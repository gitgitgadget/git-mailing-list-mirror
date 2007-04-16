From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-applymbox documentation
Date: Mon, 16 Apr 2007 01:40:06 -0500
Message-ID: <20070416064006.GA20240@localdomain>
References: <20070416062024.GB19759@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKsz-0006V4-2R
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbXDPGkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXDPGkV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:40:21 -0400
Received: from www.aeruder.net ([65.254.53.245]:4208 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318AbXDPGkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:40:20 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 6C42A4026E;
	Mon, 16 Apr 2007 01:40:07 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416062024.GB19759@localdomain>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44595>

Documentation/git-applymbox.txt: updating -u documentation to include
fact that it encodes to the i18n.commitencoding setting, not just utf-8.
Added documentation of -n option to pass -n to git-mailinfo.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Resending due to my bad .git/config interacting with mutt to
 wipe out first line of commit message

 Documentation/git-applymbox.txt |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
index 95dc65a..3bc92d8 100644
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -42,14 +42,20 @@ OPTIONS
 	and the current tree.
 
 -u::
-	The commit log message, author name and author email are
-	taken from the e-mail, and after minimally decoding MIME
-	transfer encoding, re-coded in UTF-8 by transliterating
-	them.  This used to be optional but now it is the default.
+	Pass `-u` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
+	The proposed commit log message taken from the e-mail
+	are re-coded into UTF-8 encoding (configuration variable
+	`i18n.commitencoding` can be used to specify project's
+	preferred encoding if it is not UTF-8).  This used to be
+	optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
 conversion, even with this flag.
 
+-n::
+	Pass `-n` flag to `git-mailinfo` (see
+	gitlink:git-mailinfo[1]).
+
 -c .dotest/<num>::
 	When the patch contained in an e-mail does not cleanly
 	apply, the command exits with an error message. The
-- 
1.5.1.1.98.gedb4f-dirty
