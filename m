From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-am: Do not exit silently if committer is unset
Date: Sat, 12 Jul 2008 17:46:59 +0200
Message-ID: <1215877619-16915-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhKP-00063I-Du
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbYGLPrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbYGLPrF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:47:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:57332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753522AbYGLPrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:47:04 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:47:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp022) with SMTP; 12 Jul 2008 17:47:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19BB4s+GIZBo6jKcj4d3ZMJ9puykgzgUWJY9rdJKx
	Sxd+cId2B+UmfR
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhJL-0004Pb-Dw; Sat, 12 Jul 2008 17:46:59 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88246>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2c517ed..83b277a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -30,7 +30,8 @@ set_reflog_action am
 require_work_tree
 cd_to_toplevel
 
-git var GIT_COMMITTER_IDENT >/dev/null || exit
+git var GIT_COMMITTER_IDENT >/dev/null ||
+	die "You need to set your committer info first"
 
 stop_here () {
     echo "$1" >"$dotest/next"
-- 
1.5.6.2.303.g79662
