From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 10/12] merge,
	pull: remove deprecated '--(no-)summary' options
Date: Wed, 16 Apr 2008 02:39:09 +0200
Message-ID: <1208306351-20922-11-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-8-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-9-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-10-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:27:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhu-0007aE-V5
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbYDPAjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756812AbYDPAjq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56328 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbYDPAjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:45 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JlvgH0DFl-0002vf; Wed, 16 Apr 2008 02:39:21 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-10-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/bKzC0CHpnSX9m5urtXFSYvFv50vzSua0lsUW
 QWKX9WH+OErWGpwULWvMItrOPfD3eKrDHm12vyy+axWtslOfX0
 SWRzRt8/BGM66czhHZPKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79640>

Also remove related test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-options.txt |    6 ------
 git-merge.sh                    |    6 ++----
 git-pull.sh                     |    4 ++--
 t/t7600-merge.sh                |   15 ---------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index f282556..f22fc6e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -6,12 +6,6 @@
 -n, \--no-stat::
 	Do not show diffstat at the end of the merge.
=20
---summary::
-	Deprecated equivalent of --stat.
-
---no-summary::
-	Deprecated equivalent of --no-stat.
-
 --log::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
diff --git a/git-merge.sh b/git-merge.sh
index f0b764f..263b337 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -10,8 +10,6 @@ git-merge [options] <msg> HEAD <remote>
 --
 stat                 show a diffstat at the end of the merge
 n,no-stat            don't show a diffstat at the end of the merge
-summary              deprecated equivalent of --stat
-no-summary           deprecated equivalent of --no-stat
 log                  add list of one-line log to merge commit message
 no-log               don't add list of one-line log to merge commit me=
ssage
 squash               create a single commit instead of doing a merge
@@ -152,9 +150,9 @@ merge_name () {
 parse_config () {
 	while test $# !=3D 0; do
 		case "$1" in
-		-n|--no-stat|--no-summary)
+		-n|--no-stat)
 			show_diffstat=3Dfalse ;;
-		--stat|--summary)
+		--stat)
 			show_diffstat=3Dt ;;
 		--log|--no-log)
 			log_arg=3D$1 ;;
diff --git a/git-pull.sh b/git-pull.sh
index e344afb..d1edb9c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -23,9 +23,9 @@ rebase=3D$(git config --bool branch.$curr_branch_shor=
t.rebase)
 while :
 do
 	case "$1" in
-	-n|--no-stat|--no-summary)
+	-n|--no-stat)
 		no_stat=3D-n ;;
-	--stat|--summary)
+	--stat)
 		no_stat=3D$1 ;;
 	--log|--no-log)
 		log_arg=3D$1 ;;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6680321..6fc626e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -383,21 +383,6 @@ test_expect_success 'override config option -n wit=
h --stat' '
=20
 test_debug 'gitk --all'
=20
-test_expect_success 'override config option -n with --summary' '
-	git reset --hard c1 &&
-	git config branch.master.mergeoptions "-n" &&
-	test_tick &&
-	git merge --summary c2 >diffstat.txt &&
-	verify_merge file result.1-5 msg.1-5 &&
-	verify_parents $c1 $c2 &&
-	if ! grep "^ file |  *2 +-$" diffstat.txt
-	then
-		echo "[OOPS] diffstat was not generated"
-	fi
-'
-
-test_debug 'gitk --all'
-
 test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
 	git config branch.master.mergeoptions "--stat" &&
--=20
1.5.5.76.g546c
