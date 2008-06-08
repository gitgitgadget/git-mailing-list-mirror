From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] make_nonrelative_path: Use is_absolute_path()
Date: Sun, 8 Jun 2008 16:34:40 +0200
Message-ID: <200806081634.40882.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Lzc-0005Xz-Lf
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYFHOeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbYFHOen
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:34:43 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:60228 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYFHOen (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:34:43 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 73AC3BEE58;
	Sun,  8 Jun 2008 16:34:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2653264480;
	Sun,  8 Jun 2008 16:34:41 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84272>

This helps porting to Windows.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 path.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 7c3b89a..5da41c7 100644
--- a/path.c
+++ b/path.c
@@ -321,7 +321,7 @@ const char *make_nonrelative_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
 
-	if (path[0] == '/') {
+	if (is_absolute_path(path)) {
 		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 			die ("Too long path: %.*s", 60, path);
 	} else {
-- 
1.5.6.rc2.6.g3056b
