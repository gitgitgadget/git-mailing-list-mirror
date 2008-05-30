From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 1/3] Clearify the documentation for core.ignoreStat
Date: Fri, 30 May 2008 13:14:24 +0200
Message-ID: <043361f81946d5657217e6be0f22f4df350fd13f.1212152269.git.marius@trolltech.com>
References: <483C6D60.7090705@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 15:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24M7-0007rZ-Q1
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYE3NIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYE3NIX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:08:23 -0400
Received: from hoat.troll.no ([62.70.27.150]:46268 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYE3NIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 09:08:22 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1B42120BEA;
	Fri, 30 May 2008 15:08:17 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 100C620BEF;
	Fri, 30 May 2008 15:08:17 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83294>

The previous documentation didn't make it clear that the
"assume unchanged" was on per file basis, and not a global
flag.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c298dc2..5331b45 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -205,10 +205,13 @@ Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
 handling).
 
 core.ignoreStat::
-	The working copy files are assumed to stay unchanged until you
-	mark them otherwise manually - Git will not detect the file changes
-	by lstat() calls. This is useful on systems where those are very
-	slow, such as Microsoft Windows.  See linkgit:git-update-index[1].
+	If true, commands which modify both the working tree and the index
+	will mark the updated paths with the "assume unchanged" bit in the
+	index. These marked files are then assumed to stay unchanged in the
+	working copy, until you	mark them otherwise manually - Git will not
+	detect the file changes	by lstat() calls. This is useful on systems
+	where those are very slow, such as Microsoft Windows.
+	See linkgit:git-update-index[1].
 	False by default.
 
 core.preferSymlinkRefs::
-- 
1.5.5.GIT
