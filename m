From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Clean up documentation that references deprecated 'git peek-remote'.
Date: Mon, 17 Dec 2007 10:08:23 +0100
Message-ID: <1197882503-4296-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4By2-0005wa-VG
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760911AbXLQJIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 04:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbXLQJI3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:08:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14298 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759326AbXLQJI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 04:08:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1J4Bxp-0005Ug-3z; Mon, 17 Dec 2007 10:08:41 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 18CDE546; Mon, 17 Dec 2007 10:08:24 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id DAA09FA45; Mon, 17 Dec 2007 10:08:23 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.73.gcaffa
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68526>

Now that 'git peek-remote' is deprecated and only an alias for
'git ls-remote', it should not be referenced from other manual pages.

This also removes the description of the --exec option, which is no
longer present.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/git-daemon.txt      |    6 +++---
 Documentation/git-ls-remote.txt   |    2 +-
 Documentation/git-peek-remote.txt |    3 ---
 Documentation/git-show-ref.txt    |    2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 99e47c9..f1e48dd 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -31,8 +31,8 @@ pass some directory paths as 'git-daemon' arguments, you can further restrict
 the offers to a whitelist comprising of those.
 
 By default, only `upload-pack` service is enabled, which serves
-`git-fetch-pack` and `git-peek-remote` clients that are invoked
-from `git-fetch`, `git-ls-remote`, and `git-clone`.
+`git-fetch-pack` and `git-ls-remote` clients, which are invoked
+from `git-fetch`, `git-pull`, and `git-clone`.
 
 This is ideally suited for read-only updates, i.e., pulling from
 git repositories.
@@ -166,7 +166,7 @@ the per-repository configuration file can be used to enable or
 disable them.
 
 upload-pack::
-	This serves `git-fetch-pack` and `git-peek-remote`
+	This serves `git-fetch-pack` and `git-ls-remote`
 	clients.  It is enabled by default, but a repository can
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 93e9a60..445beda 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -30,7 +30,7 @@ OPTIONS
 	Specify the full path of gitlink:git-upload-pack[1] on the remote
 	host. This allows listing references from repositories accessed via
 	SSH and where the SSH daemon does not use the PATH configured by the
-	user. Also see the '--exec' option for gitlink:git-peek-remote[1].
+	user.
 
 <repository>::
 	Location of the repository.  The shorthand defined in
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index 38a5325..09b005b 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -28,9 +28,6 @@ OPTIONS
 	shells, but prefer having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
 
-\--exec=<git-upload-pack>::
-	Same \--upload-pack=<git-upload-pack>.
-
 <host>::
 	A remote host that houses the repository.  When this
 	part is specified, 'git-upload-pack' is invoked via
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2355aa5..7893a50 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -160,7 +160,7 @@ to get a listing of all tags together with what they dereference.
 
 SEE ALSO
 --------
-gitlink:git-ls-remote[1], gitlink:git-peek-remote[1]
+gitlink:git-ls-remote[1]
 
 AUTHORS
 -------
-- 
1.5.4.rc0.73.gcaffa
