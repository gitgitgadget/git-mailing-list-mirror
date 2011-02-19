From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 53/72] gettextize: git-status basic messages
Date: Sat, 19 Feb 2011 19:24:36 +0000
Message-ID: <1298143495-3681-54-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUb-0003dU-Qj
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349Ab1BST3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46654 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BST2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:15 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347171eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=RVUJNhrbsfk6h7AOwMS7sTAgRLO/yvl6lY1agtXFKOk=;
        b=PmiveZu05tWoO3yH4K9QD5Xu8PSdLfx0G/uEWfmIi+xR1as1+cnbQLQb2Va0XO5g76
         JiE88dMhYcXghfuDf1QzNuCicmzztXrYIpx/dUEmsEpVypeW4V7QHsqIBCbwR0DPS+zU
         /UvSfbRJb947NXYL1ldGC2HNFUkpPulDikg38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=spnems47jaVViIsbx/CDMOEOxqe/1diI+zjZFhJIZWrfgyyagBoIuuRxVmSr0NhIIr
         6E6MfOVvA2bpL4D1Jn7urGAkf1uZ6ZKUBsJbTExGo2fzS+3+SFdYDgtlQrode/icXo9N
         ESEPr9013UDBWMyB8c88icIYdzz9shvnPNSnY=
Received: by 10.213.26.79 with SMTP id d15mr1005924ebc.0.1298143691477;
        Sat, 19 Feb 2011 11:28:11 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.10
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:11 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167359>

Gettextize the most common git-status messages. Many tests checked for
these explicitly. Change them to skip under GETTEXT_POISON=3DYesPlease.

Some of the tests in t7508-status.sh needed to be split up when I
added NO_GETTEXT_POISON to them, since parts of them affected later
tests (some of which aren't being skipped) indirectly.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7060-wtstatus.sh         |    2 +-
 t/t7506-status-submodule.sh |   20 ++++----
 t/t7508-status.sh           |  115 ++++++++++++++++++++++++-----------=
--------
 wt-status.c                 |   86 ++++++++++++++++----------------
 4 files changed, 119 insertions(+), 104 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index fcac472..7205154 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -38,7 +38,7 @@ cat >expect <<EOF
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
=20
-test_expect_success 'M/D conflict does not segfault' '
+test_expect_success NO_GETTEXT_POISON 'M/D conflict does not segfault'=
 '
 	mkdir mdconflict &&
 	(
 		cd mdconflict &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3d4f85d..74e0f6f 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -30,7 +30,7 @@ test_expect_success 'commit --dry-run -a clean' '
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'status with modified file in submodule' '
+test_expect_success NO_GETTEXT_POISON 'status with modified file in su=
bmodule' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
@@ -46,7 +46,7 @@ test_expect_success 'status with modified file in sub=
module (porcelain)' '
 	EOF
 '
=20
-test_expect_success 'status with added file in submodule' '
+test_expect_success NO_GETTEXT_POISON 'status with added file in submo=
dule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
 	grep "modified:   sub (modified content)" output
@@ -60,14 +60,14 @@ test_expect_success 'status with added file in subm=
odule (porcelain)' '
 	EOF
 '
=20
-test_expect_success 'status with untracked file in submodule' '
+test_expect_success NO_GETTEXT_POISON 'status with untracked file in s=
ubmodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
 	grep "modified:   sub (untracked content)" output
 '
=20
-test_expect_success 'status -uno with untracked file in submodule' '
+test_expect_success NO_GETTEXT_POISON 'status -uno with untracked file=
 in submodule' '
 	git status -uno >output &&
 	grep "^nothing to commit" output
 '
@@ -79,7 +79,7 @@ test_expect_success 'status with untracked file in su=
bmodule (porcelain)' '
 	EOF
 '
=20
-test_expect_success 'status with added and untracked file in submodule=
' '
+test_expect_success NO_GETTEXT_POISON 'status with added and untracked=
 file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
@@ -95,7 +95,7 @@ test_expect_success 'status with added and untracked =
file in submodule (porcelai
 	EOF
 '
=20
-test_expect_success 'status with modified file in modified submodule' =
'
+test_expect_success NO_GETTEXT_POISON 'status with modified file in mo=
dified submodule' '
 	(cd sub && git reset --hard) &&
 	rm sub/new-file &&
 	(cd sub && echo "next change" >foo && git commit -m "next change" foo=
) &&
@@ -113,7 +113,7 @@ test_expect_success 'status with modified file in m=
odified submodule (porcelain)
 	EOF
 '
=20
-test_expect_success 'status with added file in modified submodule' '
+test_expect_success NO_GETTEXT_POISON 'status with added file in modif=
ied submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
 	grep "modified:   sub (new commits, modified content)" output
@@ -127,7 +127,7 @@ test_expect_success 'status with added file in modi=
fied submodule (porcelain)' '
 	EOF
 '
=20
-test_expect_success 'status with untracked file in modified submodule'=
 '
+test_expect_success NO_GETTEXT_POISON 'status with untracked file in m=
odified submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
@@ -141,7 +141,7 @@ test_expect_success 'status with untracked file in =
modified submodule (porcelain
 	EOF
 '
=20
-test_expect_success 'status with added and untracked file in modified =
submodule' '
+test_expect_success NO_GETTEXT_POISON 'status with added and untracked=
 file in modified submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
@@ -167,7 +167,7 @@ test_expect_success 'setup .git file for sub' '
 	 git commit -m "added .real to .gitignore" .gitignore
 '
=20
-test_expect_success 'status with added file in modified submodule with=
 .git file' '
+test_expect_success NO_GETTEXT_POISON 'status with added file in modif=
ied submodule with .git file' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
 	grep "modified:   sub (new commits, modified content)" output
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index f1dc5c3..d79737f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -55,7 +55,7 @@ test_expect_success 'setup' '
 	git add dir2/added
 '
=20
-test_expect_success 'status (1)' '
+test_expect_success NO_GETTEXT_POISON 'status (1)' '
=20
 	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
=20
@@ -85,7 +85,7 @@ cat >expect <<\EOF
 #	untracked
 EOF
=20
-test_expect_success 'status (2)' '
+test_expect_success NO_GETTEXT_POISON 'status (2)' '
=20
 	git status >output &&
 	test_cmp expect output
@@ -111,7 +111,7 @@ EOF
=20
 git config advice.statusHints false
=20
-test_expect_success 'status (advice.statusHints false)' '
+test_expect_success NO_GETTEXT_POISON 'status (advice.statusHints fals=
e)' '
=20
 	git status >output &&
 	test_cmp expect output
@@ -157,6 +157,12 @@ test_expect_success 'status -s -b' '
=20
 '
=20
+test_expect_success 'setup dir3' '
+	mkdir dir3 &&
+	: >dir3/untracked1 &&
+	: >dir3/untracked2
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -172,16 +178,14 @@ cat >expect <<EOF
 #
 # Untracked files not listed (use -u option to show untracked files)
 EOF
-test_expect_success 'status -uno' '
-	mkdir dir3 &&
-	: >dir3/untracked1 &&
-	: >dir3/untracked2 &&
+test_expect_success NO_GETTEXT_POISON 'status -uno' '
 	git status -uno >output &&
 	test_cmp expect output
 '
=20
-test_expect_success 'status (status.showUntrackedFiles no)' '
+test_expect_success NO_GETTEXT_POISON 'status (status.showUntrackedFil=
es no)' '
 	git config status.showuntrackedfiles no
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
 	test_cmp expect output
 '
@@ -197,7 +201,7 @@ cat >expect <<EOF
 # Untracked files not listed
 EOF
 git config advice.statusHints false
-test_expect_success 'status -uno (advice.statusHints false)' '
+test_expect_success NO_GETTEXT_POISON 'status -uno (advice.statusHints=
 false)' '
 	git status -uno >output &&
 	test_cmp expect output
 '
@@ -208,7 +212,6 @@ cat >expect << EOF
 A  dir2/added
 EOF
 test_expect_success 'status -s -uno' '
-	git config --unset status.showuntrackedfiles
 	git status -s -uno >output &&
 	test_cmp expect output
 '
@@ -243,13 +246,14 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status -unormal' '
+test_expect_success NO_GETTEXT_POISON 'status -unormal' '
 	git status -unormal >output &&
 	test_cmp expect output
 '
=20
-test_expect_success 'status (status.showUntrackedFiles normal)' '
+test_expect_success NO_GETTEXT_POISON 'status (status.showUntrackedFil=
es normal)' '
 	git config status.showuntrackedfiles normal
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
 	test_cmp expect output
 '
@@ -266,7 +270,6 @@ A  dir2/added
 ?? untracked
 EOF
 test_expect_success 'status -s -unormal' '
-	git config --unset status.showuntrackedfiles
 	git status -s -unormal >output &&
 	test_cmp expect output
 '
@@ -302,18 +305,21 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status -uall' '
+test_expect_success NO_GETTEXT_POISON 'status -uall' '
 	git status -uall >output &&
 	test_cmp expect output
 '
-test_expect_success 'status (status.showUntrackedFiles all)' '
+test_expect_success NO_GETTEXT_POISON 'status (status.showUntrackedFil=
es all)' '
 	git config status.showuntrackedfiles all
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
-	rm -rf dir3 &&
-	git config --unset status.showuntrackedfiles &&
 	test_cmp expect output
 '
=20
+test_expect_success 'teardown dir3' '
+	rm -rf dir3
+'
+
 cat >expect <<EOF
  M dir1/modified
 A  dir2/added
@@ -361,7 +367,7 @@ cat >expect <<\EOF
 #	../untracked
 EOF
=20
-test_expect_success 'status with relative paths' '
+test_expect_success NO_GETTEXT_POISON 'status with relative paths' '
=20
 	(cd dir1 && git status) >output &&
 	test_cmp expect output
@@ -434,18 +440,19 @@ cat >expect <<\EOF
 #	<BLUE>untracked<RESET>
 EOF
=20
-test_expect_success 'status with color.ui' '
+test_expect_success NO_GETTEXT_POISON 'status with color.ui' '
=20
 	git config color.ui always &&
+	test_when_finished "git config --unset color.ui" &&
 	git status | test_decode_color >output &&
 	test_cmp expect output
=20
 '
=20
-test_expect_success 'status with color.status' '
+test_expect_success NO_GETTEXT_POISON 'status with color.status' '
=20
-	git config --unset color.ui &&
 	git config color.status always &&
+	test_when_finished "git config --unset color.status" &&
 	git status | test_decode_color >output &&
 	test_cmp expect output
=20
@@ -464,7 +471,6 @@ EOF
=20
 test_expect_success 'status -s with color.ui' '
=20
-	git config --unset color.status &&
 	git config color.ui always &&
 	git status -s | test_decode_color >output &&
 	test_cmp expect output
@@ -564,9 +570,10 @@ cat >expect <<\EOF
 EOF
=20
=20
-test_expect_success 'status without relative paths' '
+test_expect_success NO_GETTEXT_POISON 'status without relative paths' =
'
=20
-	git config status.relativePaths false
+	git config status.relativePaths false &&
+	test_when_finished "git config --unset status.relativePaths" &&
 	(cd dir1 && git status) >output &&
 	test_cmp expect output
=20
@@ -585,6 +592,8 @@ EOF
=20
 test_expect_success 'status -s without relative paths' '
=20
+	git config status.relativePaths false &&
+	test_when_finished "git config --unset status.relativePaths" &&
 	(cd dir1 && git status -s) >output &&
 	test_cmp expect output
=20
@@ -607,7 +616,10 @@ cat <<EOF >expect
 #	untracked
 EOF
 test_expect_success 'dry-run of partial commit excluding new file in i=
ndex' '
-	git commit --dry-run dir1/modified >output &&
+	git commit --dry-run dir1/modified >output
+'
+
+test_expect_success NO_GETTEXT_POISON 'dry-run of partial commit exclu=
ding new file in index: output' '
 	test_cmp expect output
 '
=20
@@ -655,13 +667,13 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status submodule summary is disabled by default' =
'
+test_expect_success NO_GETTEXT_POISON 'status submodule summary is dis=
abled by default' '
 	git status >output &&
 	test_cmp expect output
 '
=20
 # we expect the same as the previous test
-test_expect_success 'status --untracked-files=3Dall does not show subm=
odule' '
+test_expect_success NO_GETTEXT_POISON 'status --untracked-files=3Dall =
does not show submodule' '
 	git status --untracked-files=3Dall >output &&
 	test_cmp expect output
 '
@@ -719,7 +731,7 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status submodule summary' '
+test_expect_success NO_GETTEXT_POISON 'status submodule summary' '
 	git config status.submodulesummary 10 &&
 	git status >output &&
 	test_cmp expect output
@@ -760,8 +772,11 @@ cat >expect <<EOF
 #	untracked
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-test_expect_success 'status submodule summary (clean submodule)' '
-	git commit -m "commit submodule" &&
+test_expect_success 'status submodule summary (clean submodule): commi=
t' '
+	git commit -m "commit submodule"
+'
+
+test_expect_success NO_GETTEXT_POISON 'status submodule summary (clean=
 submodule): output' '
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
 	test_cmp expect output &&
@@ -812,7 +827,7 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'commit --dry-run submodule summary (--amend)' '
+test_expect_success NO_GETTEXT_POISON 'commit --dry-run submodule summ=
ary (--amend)' '
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
 	test_cmp expect output
@@ -867,13 +882,13 @@ cat > expect << EOF
 #	untracked
 EOF
=20
-test_expect_success '--ignore-submodules=3Duntracked suppresses submod=
ules with untracked content' '
+test_expect_success NO_GETTEXT_POISON '--ignore-submodules=3Duntracked=
 suppresses submodules with untracked content' '
 	echo modified > sm/untracked &&
 	git status --ignore-submodules=3Duntracked > output &&
 	test_cmp expect output
 '
=20
-test_expect_success '.gitmodules ignore=3Duntracked suppresses submodu=
les with untracked content' '
+test_expect_success NO_GETTEXT_POISON '.gitmodules ignore=3Duntracked =
suppresses submodules with untracked content' '
 	git config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	test_cmp expect output &&
@@ -885,7 +900,7 @@ test_expect_success '.gitmodules ignore=3Duntracked=
 suppresses submodules with unt
 	git config --unset diff.ignoreSubmodules
 '
=20
-test_expect_success '.git/config ignore=3Duntracked suppresses submodu=
les with untracked content' '
+test_expect_success NO_GETTEXT_POISON '.git/config ignore=3Duntracked =
suppresses submodules with untracked content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
@@ -896,12 +911,12 @@ test_expect_success '.git/config ignore=3Duntrack=
ed suppresses submodules with unt
 	git config --remove-section -f .gitmodules submodule.subname
 '
=20
-test_expect_success '--ignore-submodules=3Ddirty suppresses submodules=
 with untracked content' '
+test_expect_success NO_GETTEXT_POISON '--ignore-submodules=3Ddirty sup=
presses submodules with untracked content' '
 	git status --ignore-submodules=3Ddirty > output &&
 	test_cmp expect output
 '
=20
-test_expect_success '.gitmodules ignore=3Ddirty suppresses submodules =
with untracked content' '
+test_expect_success NO_GETTEXT_POISON '.gitmodules ignore=3Ddirty supp=
resses submodules with untracked content' '
 	git config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	! test -s actual &&
@@ -913,7 +928,7 @@ test_expect_success '.gitmodules ignore=3Ddirty sup=
presses submodules with untrack
 	git config --unset diff.ignoreSubmodules
 '
=20
-test_expect_success '.git/config ignore=3Ddirty suppresses submodules =
with untracked content' '
+test_expect_success NO_GETTEXT_POISON '.git/config ignore=3Ddirty supp=
resses submodules with untracked content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
@@ -924,13 +939,13 @@ test_expect_success '.git/config ignore=3Ddirty s=
uppresses submodules with untrack
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success '--ignore-submodules=3Ddirty suppresses submodules=
 with modified content' '
+test_expect_success NO_GETTEXT_POISON '--ignore-submodules=3Ddirty sup=
presses submodules with modified content' '
 	echo modified > sm/foo &&
 	git status --ignore-submodules=3Ddirty > output &&
 	test_cmp expect output
 '
=20
-test_expect_success '.gitmodules ignore=3Ddirty suppresses submodules =
with modified content' '
+test_expect_success NO_GETTEXT_POISON '.gitmodules ignore=3Ddirty supp=
resses submodules with modified content' '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -938,7 +953,7 @@ test_expect_success '.gitmodules ignore=3Ddirty sup=
presses submodules with modifie
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success '.git/config ignore=3Ddirty suppresses submodules =
with modified content' '
+test_expect_success NO_GETTEXT_POISON '.git/config ignore=3Ddirty supp=
resses submodules with modified content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
@@ -981,12 +996,12 @@ cat > expect << EOF
 #	untracked
 EOF
=20
-test_expect_success "--ignore-submodules=3Duntracked doesn't suppress =
submodules with modified content" '
+test_expect_success NO_GETTEXT_POISON "--ignore-submodules=3Duntracked=
 doesn't suppress submodules with modified content" '
 	git status --ignore-submodules=3Duntracked > output &&
 	test_cmp expect output
 '
=20
-test_expect_success ".gitmodules ignore=3Duntracked doesn't suppress s=
ubmodules with modified content" '
+test_expect_success NO_GETTEXT_POISON ".gitmodules ignore=3Duntracked =
doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -994,7 +1009,7 @@ test_expect_success ".gitmodules ignore=3Duntracke=
d doesn't suppress submodules wi
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success ".git/config ignore=3Duntracked doesn't suppress s=
ubmodules with modified content" '
+test_expect_success NO_GETTEXT_POISON ".git/config ignore=3Duntracked =
doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
@@ -1043,12 +1058,12 @@ cat > expect << EOF
 #	untracked
 EOF
=20
-test_expect_success "--ignore-submodules=3Duntracked doesn't suppress =
submodule summary" '
+test_expect_success NO_GETTEXT_POISON "--ignore-submodules=3Duntracked=
 doesn't suppress submodule summary" '
 	git status --ignore-submodules=3Duntracked > output &&
 	test_cmp expect output
 '
=20
-test_expect_success ".gitmodules ignore=3Duntracked doesn't suppress s=
ubmodule summary" '
+test_expect_success NO_GETTEXT_POISON ".gitmodules ignore=3Duntracked =
doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -1056,7 +1071,7 @@ test_expect_success ".gitmodules ignore=3Duntrack=
ed doesn't suppress submodule sum
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success ".git/config ignore=3Duntracked doesn't suppress s=
ubmodule summary" '
+test_expect_success NO_GETTEXT_POISON ".git/config ignore=3Duntracked =
doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
@@ -1067,11 +1082,11 @@ test_expect_success ".git/config ignore=3Duntra=
cked doesn't suppress submodule sum
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success "--ignore-submodules=3Ddirty doesn't suppress subm=
odule summary" '
+test_expect_success NO_GETTEXT_POISON "--ignore-submodules=3Ddirty doe=
sn't suppress submodule summary" '
 	git status --ignore-submodules=3Ddirty > output &&
 	test_cmp expect output
 '
-test_expect_success ".gitmodules ignore=3Ddirty doesn't suppress submo=
dule summary" '
+test_expect_success NO_GETTEXT_POISON ".gitmodules ignore=3Ddirty does=
n't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -1079,7 +1094,7 @@ test_expect_success ".gitmodules ignore=3Ddirty d=
oesn't suppress submodule summary
 	git config -f .gitmodules  --remove-section submodule.subname
 '
=20
-test_expect_success ".git/config ignore=3Ddirty doesn't suppress submo=
dule summary" '
+test_expect_success NO_GETTEXT_POISON ".git/config ignore=3Ddirty does=
n't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
@@ -1111,7 +1126,7 @@ cat > expect << EOF
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
=20
-test_expect_success "--ignore-submodules=3Dall suppresses submodule su=
mmary" '
+test_expect_success NO_GETTEXT_POISON "--ignore-submodules=3Dall suppr=
esses submodule summary" '
 	git status --ignore-submodules=3Dall > output &&
 	test_cmp expect output
 '
diff --git a/wt-status.c b/wt-status.c
index 123582b..f369eba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -57,16 +57,16 @@ static void wt_status_print_unmerged_header(struct =
wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	color_fprintf_ln(s->fp, c, _("# Unmerged paths:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		;
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appr=
opriate to mark resolution)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" as ap=
propriate to mark resolution)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -80,9 +80,9 @@ static void wt_status_print_cached_header(struct wt_s=
tatus *s)
 	if (s->in_merge)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -92,16 +92,16 @@ static void wt_status_print_dirty_header(struct wt_=
status *s,
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changes not staged for commit:");
+	color_fprintf_ln(s->fp, c, _("# Changes not staged for commit:"));
 	if (!advice_status_hints)
 		return;
 	if (!has_deleted)
-		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update=
 what will be committed)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add <file>...\" to upda=
te what will be committed)"));
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to upd=
ate what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to=
 discard changes in working directory)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" to u=
pdate what will be committed)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git checkout -- <file>...\" =
to discard changes in working directory)"));
 	if (has_dirty_submodules)
-		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or =
modified content in submodules)");
+		color_fprintf_ln(s->fp, c, _("#   (commit or discard the untracked o=
r modified content in submodules)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -110,10 +110,10 @@ static void wt_status_print_other_header(struct w=
t_status *s,
 					 const char *how)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
-	color_fprintf_ln(s->fp, c, "# %s files:", what);
+	color_fprintf_ln(s->fp, c, _("# %s files:"), what);
 	if (!advice_status_hints)
 		return;
-	color_fprintf_ln(s->fp, c, "#   (use \"git %s <file>...\" to include =
in what will be committed)", how);
+	color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to includ=
e in what will be committed)"), how);
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -130,18 +130,18 @@ static void wt_status_print_unmerged_data(struct =
wt_status *s,
 	const char *c =3D color(WT_STATUS_UNMERGED, s);
 	struct wt_status_change_data *d =3D it->util;
 	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one, *how =3D "bug";
+	const char *one, *how =3D _("bug");
=20
 	one =3D quote_path(it->string, -1, &onebuf, s->prefix);
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (d->stagemask) {
-	case 1: how =3D "both deleted:"; break;
-	case 2: how =3D "added by us:"; break;
-	case 3: how =3D "deleted by them:"; break;
-	case 4: how =3D "added by them:"; break;
-	case 5: how =3D "deleted by us:"; break;
-	case 6: how =3D "both added:"; break;
-	case 7: how =3D "both modified:"; break;
+	case 1: how =3D _("both deleted:"); break;
+	case 2: how =3D _("added by us:"); break;
+	case 3: how =3D _("deleted by them:"); break;
+	case 4: how =3D _("added by them:"); break;
+	case 5: how =3D _("deleted by us:"); break;
+	case 6: how =3D _("both added:"); break;
+	case 7: how =3D _("both modified:"); break;
 	}
 	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
 	strbuf_release(&onebuf);
@@ -171,11 +171,11 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 		if (d->new_submodule_commits || d->dirty_submodule) {
 			strbuf_addstr(&extra, " (");
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, "new commits, ");
+				strbuf_addf(&extra, _("new commits, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, "modified content, ");
+				strbuf_addf(&extra, _("modified content, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, "untracked content, ");
+				strbuf_addf(&extra, _("untracked content, "));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
@@ -189,31 +189,31 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		color_fprintf(s->fp, c, "new file:   %s", one);
+		color_fprintf(s->fp, c, _("new file:   %s"), one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("copied:     %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_fprintf(s->fp, c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, _("deleted:    %s"), one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_fprintf(s->fp, c, "modified:   %s", one);
+		color_fprintf(s->fp, c, _("modified:   %s"), one);
 		break;
 	case DIFF_STATUS_RENAMED:
 		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_fprintf(s->fp, c, "typechange: %s", one);
+		color_fprintf(s->fp, c, _("typechange: %s"), one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_fprintf(s->fp, c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, _("unknown:    %s"), one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_fprintf(s->fp, c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, _("unmerged:   %s"), one);
 		break;
 	default:
-		die("bug: unhandled diff status %c", status);
+		die(_("bug: unhandled diff status %c"), status);
 	}
 	if (extra.len) {
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
@@ -633,14 +633,14 @@ void wt_status_print(struct wt_status *s)
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
=20
 	if (s->branch) {
-		const char *on_what =3D "On branch ";
+		const char *on_what =3D _("On branch ");
 		const char *branch_name =3D s->branch;
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name =3D "";
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D "Not currently on any branch.";
+			on_what =3D _("Not currently on any branch.");
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
 		color_fprintf(s->fp, branch_status_color, "%s", on_what);
@@ -665,29 +665,29 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, "Untracked", "add");
+		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, "Ignored", "add -f");
+			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
 	} else if (s->commitable)
-		fprintf(s->fp, "# Untracked files not listed%s\n",
+		fprintf(s->fp, _("# Untracked files not listed%s\n"),
 			advice_status_hints
-			? " (use -u option to show untracked files)" : "");
+			? _(" (use -u option to show untracked files)") : "");
=20
 	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
+			fprintf(s->fp, _("# No changes\n"));
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-			printf("no changes added to commit%s\n",
+			printf(_("no changes added to commit%s\n"),
 				advice_status_hints
-				? " (use \"git add\" and/or \"git commit -a\")" : "");
+				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
 		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present%s\n",
+			printf(_("nothing added to commit but untracked files present%s\n")=
,
 				advice_status_hints
-				? " (use \"git add\" to track)" : "");
+				? _(" (use \"git add\" to track)") : "");
 		else if (s->is_initial)
 			printf("nothing to commit%s\n", advice_status_hints
 				? " (create/copy files and use \"git add\" to track)" : "");
--=20
1.7.2.3
