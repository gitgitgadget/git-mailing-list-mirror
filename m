From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] git-archive --format=zip: use default version ID
Date: Sat, 07 Oct 2006 01:47:24 +0200
Message-ID: <4526EB0C.6000802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 07 01:47:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVzPT-00010F-3v
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 01:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWJFXrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 19:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJFXrP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 19:47:15 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:32952
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750705AbWJFXrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 19:47:14 -0400
Received: from [10.0.1.3] (p508E6834.dip.t-dialin.net [80.142.104.52])
	by neapel230.server4you.de (Postfix) with ESMTP id 9513D1002B;
	Sat,  7 Oct 2006 01:47:13 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28450>

Use 10 for the "version needed to extract" field.  This is the
default value, and we want to use it because we don't do anything
special.  Info-ZIP's zip uses it, too.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 3ffdad6..ae74623 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -214,7 +214,7 @@ static int write_zip_entry(const unsigne
 
 	copy_le32(dirent.magic, 0x02014b50);
 	copy_le16(dirent.creator_version, 0);
-	copy_le16(dirent.version, 20);
+	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, 0);
 	copy_le16(dirent.compression_method, method);
 	copy_le16(dirent.mtime, zip_time);
@@ -236,7 +236,7 @@ static int write_zip_entry(const unsigne
 	zip_dir_entries++;
 
 	copy_le32(header.magic, 0x04034b50);
-	copy_le16(header.version, 20);
+	copy_le16(header.version, 10);
 	copy_le16(header.flags, 0);
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
-- 
1.4.2.3.gf59615
