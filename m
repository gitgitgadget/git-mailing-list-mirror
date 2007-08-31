From: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Test for windows format absolute paths on cygwin too
Date: Fri, 31 Aug 2007 09:07:20 +0000
Message-ID: <xMhwifY1.1188551240.4001640.roro@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 11:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2bK-0006mG-Uu
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758586AbXHaJPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757929AbXHaJPS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:15:18 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20195 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbXHaJPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 05:15:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C6D4880288D
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 11:07:23 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03477-01 for <git@vger.kernel.org>; Fri, 31 Aug 2007 11:07:21 +0200 (CEST)
Received: from dewire.com (torino.dewire.com [10.1.2.98])
	by dewire.com (Postfix) with SMTP id 841F7802866
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 11:07:20 +0200 (CEST)
Received: from 194.68.126.35 (auth. user roro@localhost)
          by dewire.com with HTTP; Fri, 31 Aug 2007 09:07:20 +0000
X-Mailer: IlohaMail/0.8.14 (On: dewire.com)
Bounce-To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57140>

---

Requires cherry-picking 6397c3119ecaa258b5185315c64062bec29bcd86

 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 97ea448..fa867b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -84,7 +84,7 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 /* returns the number of chars to skip to first component */
 static inline int is_path_absolute(const char *path)
 {
-#ifdef __MINGW32__
+#if defined(__MINGW32__) || defined(__CYGWIN__)
 	if (isalpha(path[0]) && path[1] == ':')
 		return 2 + (path[2] == '/');
 	/* TODO: C:dir/file 'relative' paths are not catered for */
--
1.5.3.rc7.25.g5389f-dirty
