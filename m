From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] wt-status.c: Expand cut_line so the scissor line is 72 chars
Date: Mon,  1 Sep 2014 02:07:25 +0200
Message-ID: <1409530045-12866-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 02:17:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOFJ7-00058Y-Tm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 02:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbaIAARO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2014 20:17:14 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45259 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbaIAARN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 20:17:13 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Aug 2014 20:17:13 EDT
Received: from sunbase.org ([178.79.142.16]:57582 helo=linode.members.linode.com)
	by smtp.domeneshop.no with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <sunny@sunbase.org>)
	id 1XOF9o-0000Yk-M0; Mon, 01 Sep 2014 02:07:40 +0200
X-Mailer: git-send-email 2.1.0.29.g10a3b53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256303>

Change the size of the commit scissor line to 72 characters (the
recommended maximum line length in log messages) so it can be used as a
visual clue in editors using monospaced fonts.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 Documentation/git-commit.txt | 2 +-
 t/t7502-commit.sh            | 2 +-
 wt-status.c                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 0bbc8f5..d24573f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -189,7 +189,7 @@ verbatim::
 scissors::
 	Same as `whitespace`, except that everything from (and
 	including) the line
-	"`# ------------------------ >8 ------------------------`"
+	"`# --------------------------------- >8 ----------------------------=
-----`"
 	is truncated if the message is to be edited. "`#`" can be
 	customized with core.commentChar.
 default::
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 051489e..8b2ec6b 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -229,7 +229,7 @@ test_expect_success 'cleanup commit messages (sciss=
ors option,-F,-e)' '
 	cat >text <<EOF &&
=20
 # to be kept
-# ------------------------ >8 ------------------------
+# --------------------------------- >8 -------------------------------=
--
 to be removed
 EOF
 	echo "# to be kept" >expect &&
diff --git a/wt-status.c b/wt-status.c
index 27da529..010632c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,7 +18,7 @@
 #include "utf8.h"
=20
 static const char cut_line[] =3D
-"------------------------ >8 ------------------------\n";
+"--------------------------------- >8 --------------------------------=
-\n";
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
--=20
2.1.0.29.g10a3b53
