From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 28/63] gettext tests: skip breaking tests under GETTEXT_POISON
Date: Sat,  4 Sep 2010 22:10:27 +0000
Message-ID: <1283638229-14199-8-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0x5-0003Lx-EL
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab0IDWLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:11:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37424 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0IDWLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:11:04 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so4554637wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JKYCMObahHHddKBcHDMIpxmsue84mYP1skyzm0eDG4o=;
        b=th40OE9d2H5hOAM0wh+63MQ1ZmmH8qmimO5G5YoL50ePMzCMMqKBwJwgAluJjDY0+H
         Sl2oZzeV3uKDGpCpBESoVdin9XSDbXxhqH2SVKFmtlGqg9dunodKsURKUnxaTeY05CSi
         big57PsWh3xOXhOd85xwxE3cGlHTocNM9y5+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HUF87Tafnszf9vDxrf4hcHFX7F2Pj+74VwrgetEisQYRXBiwq5RHjLMgL2u7e0AWFI
         rZxZGO5EYg1j+f6fxKqnNkjcmJlEnPT8kaOvUBEEMVp0wgg6V//oDoCtbP3EZM7NufMz
         YKKdWSe2rVSFYCxaUl594XoOGf/UOxJNHU/y4=
Received: by 10.216.52.135 with SMTP id e7mr2143722wec.98.1283638263441;
        Sat, 04 Sep 2010 15:11:03 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.11.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:11:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155371>

Change the tests that depend on the output of the porcelain to only
run if the NO_GETTEXT_POISON prerequisite is set. These will always
fail under GETTEXT_POISON=3DYesPlease.

I've manually inspected these and determined to the best of my ability
that they aren't plumbing output.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

(repeated)

    This is still the part of this series that needs the most
    review. I *think* I got this right, but more eyes are needed on
    it.

 t/lib-httpd.sh              |    2 +-
 t/t0001-init.sh             |    2 +-
 t/t1200-tutorial.sh         |    4 +-
 t/t2200-add-update.sh       |    2 +-
 t/t2204-add-ignored.sh      |    8 ++--
 t/t3030-merge-recursive.sh  |    2 +-
 t/t3200-branch.sh           |    2 +-
 t/t3203-branch-output.sh    |    2 +-
 t/t3700-add.sh              |    4 +-
 t/t4001-diff-rename.sh      |    4 +-
 t/t4014-format-patch.sh     |    2 +-
 t/t5541-http-push.sh        |    2 +-
 t/t5601-clone.sh            |    2 +-
 t/t6040-tracking-info.sh    |    2 +-
 t/t7004-tag.sh              |    6 ++-
 t/t7060-wtstatus.sh         |    2 +-
 t/t7102-reset.sh            |    2 +-
 t/t7110-reset-merge.sh      |    6 +-
 t/t7201-co.sh               |   10 ++--
 t/t7500-commit.sh           |    9 +++-
 t/t7501-commit.sh           |   14 ++++--
 t/t7502-commit.sh           |   46 ++++++++++----------
 t/t7506-status-submodule.sh |   28 ++++++------
 t/t7508-status.sh           |   98 +++++++++++++++++++++--------------=
-------
 t/t7600-merge.sh            |    2 +-
 t/t7811-grep-open.sh        |    2 +-
 26 files changed, 139 insertions(+), 126 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index e733f65..817b865 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -154,7 +154,7 @@ test_http_push_nonff() {
 		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" ou=
tput
 	'
=20
-	test_expect_success 'non-fast-forward push shows help message' '
+	test_expect_success NO_GETTEXT_POISON 'non-fast-forward push shows he=
lp message' '
 		grep "To prevent you from losing history, non-fast-forward updates w=
ere rejected" \
 			output
 	'
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7fe8883..b45df24 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -124,7 +124,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
=20
-test_expect_success 'reinit' '
+test_expect_success NO_GETTEXT_POISON 'reinit' '
=20
 	(
 		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index ab55eda..c568e0e 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -163,7 +163,9 @@ test_expect_success 'git resolve' '
 	git checkout mybranch &&
 	git merge -m "Merge upstream changes." master |
 		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" \
-		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output &&
+		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output'
+
+test_expect_success NO_GETTEXT_POISON 'git resolve output' '
 	test_cmp resolve.expect resolve.output
 '
=20
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 2ad2819..b3b90ca 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -111,7 +111,7 @@ test_expect_success 'touch and then add explicitly'=
 '
=20
 '
=20
-test_expect_success 'add -n -u should not add but just report' '
+test_expect_success NO_GETTEXT_POISON 'add -n -u should not add but ju=
st report' '
=20
 	(
 		echo "add '\''check'\''" &&
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 24afdab..b7a0d71 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -27,7 +27,7 @@ done
=20
 for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
 do
-	test_expect_success "complaints for ignored $i" '
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i" '
 		rm -f .git/index &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
@@ -36,7 +36,7 @@ do
 		cat err
 	'
=20
-	test_expect_success "complaints for ignored $i with unignored file" '
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i with=
 unignored file" '
 		rm -f .git/index &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
@@ -48,7 +48,7 @@ done
=20
 for i in sub sub/*
 do
-	test_expect_success "complaints for ignored $i in dir" '
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i in d=
ir" '
 		rm -f .git/index &&
 		(
 			cd dir &&
@@ -63,7 +63,7 @@ done
=20
 for i in ign file
 do
-	test_expect_success "complaints for ignored $i in sub" '
+	test_expect_success NO_GETTEXT_POISON "complaints for ignored $i in s=
ub" '
 		rm -f .git/index &&
 		(
 			cd sub &&
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index efe2900..b8ddb94 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -281,7 +281,7 @@ test_expect_success 'merge-recursive result' '
=20
 '
=20
-test_expect_success 'fail if the index has unresolved entries' '
+test_expect_success NO_GETTEXT_POISON 'fail if the index has unresolve=
d entries' '
=20
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f54a533..d90d9fd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -192,7 +192,7 @@ test_expect_success 'test deleting branch deletes b=
ranch config' \
      test -z "$(git config branch.my7.remote)" &&
      test -z "$(git config branch.my7.merge)"'
=20
-test_expect_success 'test deleting branch without config' \
+test_expect_success NO_GETTEXT_POISON 'test deleting branch without co=
nfig' \
     'git branch my7 s &&
      sha1=3D$(git rev-parse my7 | cut -c 1-7) &&
      test "$(git branch -d my7 2>&1)" =3D "Deleted branch my7 (was $sh=
a1)."'
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 809d1c4..dfdf5a7 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -72,7 +72,7 @@ cat >expect <<'EOF'
   branch-two
   master
 EOF
-test_expect_success 'git branch shows detached HEAD properly' '
+test_expect_success NO_GETTEXT_POISON 'git branch shows detached HEAD =
properly' '
 	git checkout HEAD^0 &&
 	git branch >actual &&
 	test_cmp expect actual
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ec71083..fea0c17 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -266,7 +266,7 @@ test_expect_success 'git add --dry-run of existing =
changed file' "
 	echo \"add 'track-this'\" | test_cmp - actual
 "
=20
-test_expect_success 'git add --dry-run of non-existing file' "
+test_expect_success NO_GETTEXT_POISON 'git add --dry-run of non-existi=
ng file' "
 	echo ignored-file >>.gitignore &&
 	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1=
 &&
 	echo \"fatal: pathspec 'ignored-file' did not match any files\" | tes=
t_cmp - actual
@@ -282,7 +282,7 @@ cat >expect.out <<\EOF
 add 'track-this'
 EOF
=20
-test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
+test_expect_success NO_GETTEXT_POISON 'git add --dry-run --ignore-miss=
ing of non-existing file' '
 	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err &&
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 71bac83..d42c077 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -64,7 +64,7 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
=20
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success NO_GETTEXT_POISON 'favour same basenames over diff=
erent ones' '
 	cp path1 another-path &&
 	git add another-path &&
 	git commit -m 1 &&
@@ -73,7 +73,7 @@ test_expect_success 'favour same basenames over diffe=
rent ones' '
 	git mv another-path subdir/path1 &&
 	git status | grep "renamed: .*path1 -> subdir/path1"'
=20
-test_expect_success  'favour same basenames even with minor difference=
s' '
+test_expect_success NO_GETTEXT_POISON  'favour same basenames even wit=
h minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status | grep "renamed: .*path1 -> subdir/path1"'
=20
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f87434b..ae3659e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -592,7 +592,7 @@ echo "fatal: --name-only does not make sense" > exp=
ect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
=20
-test_expect_success 'options no longer allowed for format-patch' '
+test_expect_success NO_GETTEXT_POISON 'options no longer allowed for f=
ormat-patch' '
 	test_must_fail git format-patch --name-only 2> output &&
 	test_cmp expect.name-only output &&
 	test_must_fail git format-patch --name-status 2> output &&
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index b0c2a2c..670d3de 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -118,7 +118,7 @@ test_expect_success 'used receive-pack service' '
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone master
=20
-test_expect_success 'push fails for non-fast-forward refs unmatched by=
 remote helper' '
+test_expect_success NO_GETTEXT_POISON 'push fails for non-fast-forward=
 refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to mat=
ch the
 	# two refs (viz. local, remote) unless an explicit refspec is provide=
d.
 	git push origin master:retsam
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..ecb499d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -31,7 +31,7 @@ test_expect_success 'clone with excess parameters (2)=
' '
=20
 '
=20
-test_expect_success 'output from clone' '
+test_expect_success NO_GETTEXT_POISON 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
 	test $(grep Clon output | wc -l) =3D 1
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..c9a86f6 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -42,7 +42,7 @@ b3 behind 1
 b4 ahead 2
 EOF
=20
-test_expect_success 'branch -v' '
+test_expect_success NO_GETTEXT_POISON 'branch -v' '
 	(
 		cd test &&
 		git branch -v
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..cf40992 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1044,12 +1044,14 @@ test_expect_success GPG \
 	'verify signed tag fails when public key is not present' \
 	'test_must_fail git tag -v signed-tag'
=20
-test_expect_success \
+# "POISON" isn't a comment, so skip under GETTEXT_POISON
+test_expect_success NO_GETTEXT_POISON \
 	'git tag -a fails if tag annotation is empty' '
 	! (GIT_EDITOR=3Dcat git tag -a initial-comment)
 '
=20
-test_expect_success \
+# Likewise GETTEXT_POISON doesn't emit something that looks like a com=
ment
+test_expect_success NO_GETTEXT_POISON \
 	'message in editor has initial comment' '
 	GIT_EDITOR=3Dcat git tag -a initial-comment > actual
 	# check the first line --- should be empty
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
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b8cf260..1370949 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -423,7 +423,7 @@ Unstaged changes after reset:
 M	file2
 EOF
=20
-test_expect_success '--mixed refreshes the index' '
+test_expect_success NO_GETTEXT_POISON '--mixed refreshes the index' '
 	echo 123 >> file2 &&
 	git reset --mixed HEAD > output &&
 	test_cmp expect output
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 70cdd8e..8e54f0c 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -233,7 +233,7 @@ test_expect_success '"reset --merge HEAD^" is ok wi=
th pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    C     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD^" fails with pending merge' '
+test_expect_success NO_GETTEXT_POISON '"reset --keep HEAD^" fails with=
 pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
@@ -259,7 +259,7 @@ test_expect_success '"reset --merge HEAD" is ok wit=
h pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    B     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD" fails with pending merge' '
+test_expect_success NO_GETTEXT_POISON '"reset --keep HEAD" fails with =
pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD 2>err.log &&
@@ -280,7 +280,7 @@ test_expect_success '--merge is ok with added/delet=
ed merge' '
     git diff --exit-code --cached
 '
=20
-test_expect_success '--keep fails with added/deleted merge' '
+test_expect_success NO_GETTEXT_POISON '--keep fails with added/deleted=
 merge' '
     git reset --hard third &&
     rm -f file2 &&
     test_must_fail git merge branch3 &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1337fa5..fe7536b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -223,7 +223,7 @@ test_expect_success 'checkout --merge --conflict=3D=
diff3 <branch>' '
 	test_cmp two expect
 '
=20
-test_expect_success 'checkout to detach HEAD (with advice declined)' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD (with a=
dvice declined)' '
=20
 	git config advice.detachedHead false &&
 	git checkout -f renamer && git clean -f &&
@@ -242,7 +242,7 @@ test_expect_success 'checkout to detach HEAD (with =
advice declined)' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
@@ -260,7 +260,7 @@ test_expect_success 'checkout to detach HEAD' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with branchname^' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with br=
anchname^' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout renamer^ &&
@@ -276,7 +276,7 @@ test_expect_success 'checkout to detach HEAD with b=
ranchname^' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with :/message' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with :/=
message' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout ":/Initial" &&
@@ -292,7 +292,7 @@ test_expect_success 'checkout to detach HEAD with :=
/message' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with HEAD^0' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with HE=
AD^0' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout HEAD^0 &&
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index aa9c577..6b983b8 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -59,7 +59,10 @@ test_expect_success 'adding comments to a template s=
hould not commit' '
 	)
 '
=20
-test_expect_success 'adding real content to a template should commit' =
'
+# These fail under GETTEXT_POISON because the poison editor message
+# doesn't do the right thing with comments and line breaks, this
+# message will be incorrectly broken up across lines.
+test_expect_success NO_GETTEXT_POISON 'adding real content to a templa=
te should commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE"
@@ -67,7 +70,7 @@ test_expect_success 'adding real content to a templat=
e should commit' '
 	commit_msg_is "template linecommit message"
 '
=20
-test_expect_success '-t option should be short for --template' '
+test_expect_success NO_GETTEXT_POISON '-t option should be short for -=
-template' '
 	echo "short template" > "$TEMPLATE" &&
 	echo "new content" >> foo &&
 	git add foo &&
@@ -78,7 +81,7 @@ test_expect_success '-t option should be short for --=
template' '
 	commit_msg_is "short templatecommit message"
 '
=20
-test_expect_success 'config-specified template should commit' '
+test_expect_success NO_GETTEXT_POISON 'config-specified template shoul=
d commit' '
 	echo "new template" > "$TEMPLATE" &&
 	git config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8297cb4..96601db 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -14,8 +14,11 @@ test_tick
 test_expect_success \
 	"initial status" \
 	"echo 'bongo bongo' >file &&
-	 git add file && \
-	 git status | grep 'Initial commit'"
+	 git add file"
+
+test_expect_success NO_GETTEXT_POISON \
+	"Constructing initial commit" \
+	"git status | grep 'Initial commit'"
=20
 test_expect_success \
 	"fail initial amend" \
@@ -142,7 +145,8 @@ cat >msg <<EOF
 A good commit message.
 EOF
=20
-test_expect_success \
+# Can't rely on editor with POISON
+test_expect_success NO_GETTEXT_POISON \
 	'editor not invoked if -F is given' '
 	 echo "moo" >file &&
 	 EDITOR=3D./editor git commit -a -F msg &&
@@ -163,7 +167,9 @@ d381ac431806e53f3dd7ac2f1ae0534f36d738b9
 402702b49136e7587daa9280e91e4bb7cb2179f7
 EOF
=20
-test_expect_success \
+# rev-list won't be OK under GETTEXT_POISON since the above test won't
+# run.
+test_expect_success NO_GETTEXT_POISON \
     'validate git rev-list output.' \
     'test_cmp expected current'
=20
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ac2e187..9e293f3 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -25,7 +25,7 @@ check_summary_oneline() {
 	test_cmp exp act
 }
=20
-test_expect_success 'output summary format' '
+test_expect_success NO_GETTEXT_POISON 'output summary format' '
=20
 	echo new >file1 &&
 	git add file1 &&
@@ -36,12 +36,12 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "" "a change"
 '
=20
-test_expect_success 'output summary format for commit with an empty di=
ff' '
+test_expect_success NO_GETTEXT_POISON 'output summary format for commi=
t with an empty diff' '
=20
 	check_summary_oneline "" "empty" "--allow-empty"
 '
=20
-test_expect_success 'output summary format for merges' '
+test_expect_success NO_GETTEXT_POISON 'output summary format for merge=
s' '
=20
 	git checkout -b recursive-base &&
 	test_commit base file1 &&
@@ -70,7 +70,7 @@ output_tests_cleanup() {
 	git commit -m "cleanup"
 }
=20
-test_expect_success 'the basics' '
+test_expect_success NO_GETTEXT_POISON 'the basics' '
=20
 	output_tests_cleanup &&
=20
@@ -91,7 +91,7 @@ test_expect_success 'the basics' '
=20
 '
=20
-test_expect_success 'partial' '
+test_expect_success NO_GETTEXT_POISON 'partial' '
=20
 	echo another >"commit is" &&
 	echo another >not/forbid &&
@@ -103,7 +103,7 @@ test_expect_success 'partial' '
=20
 '
=20
-test_expect_success 'partial modification in a subdirectory' '
+test_expect_success NO_GETTEXT_POISON 'partial modification in a subdi=
rectory' '
=20
 	test_tick &&
 	git commit -m "partial commit to subdirectory" not &&
@@ -113,7 +113,7 @@ test_expect_success 'partial modification in a subd=
irectory' '
=20
 '
=20
-test_expect_success 'partial removal' '
+test_expect_success NO_GETTEXT_POISON 'partial removal' '
=20
 	git rm not/forbid &&
 	git commit -m "partial commit to remove not/forbid" not &&
@@ -165,7 +165,7 @@ test_expect_success 'verbose respects diff config' =
'
 	git config --unset color.diff
 '
=20
-test_expect_success 'cleanup commit messages (verbatim,-t)' '
+test_expect_success NO_GETTEXT_POISON 'cleanup commit messages (verbat=
im,-t)' '
=20
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >expect &&
@@ -175,7 +175,7 @@ test_expect_success 'cleanup commit messages (verba=
tim,-t)' '
=20
 '
=20
-test_expect_success 'cleanup commit messages (verbatim,-F)' '
+test_expect_success NO_GETTEXT_POISON 'cleanup commit messages (verbat=
im,-F)' '
=20
 	echo >>negative &&
 	git commit --cleanup=3Dverbatim -F expect -a &&
@@ -184,7 +184,7 @@ test_expect_success 'cleanup commit messages (verba=
tim,-F)' '
=20
 '
=20
-test_expect_success 'cleanup commit messages (verbatim,-m)' '
+test_expect_success NO_GETTEXT_POISON 'cleanup commit messages (verbat=
im,-m)' '
=20
 	echo >>negative &&
 	git commit --cleanup=3Dverbatim -m "$(cat expect)" -a &&
@@ -220,7 +220,7 @@ echo "sample
 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit." >=
expect
=20
-test_expect_success 'cleanup commit messages (strip,-F,-e)' '
+test_expect_success NO_GETTEXT_POISON 'cleanup commit messages (strip,=
-F,-e)' '
=20
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
@@ -234,7 +234,7 @@ echo "#
 # Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 #" >> expect
=20
-test_expect_success 'author different from committer' '
+test_expect_success NO_GETTEXT_POISON 'author different from committer=
' '
=20
 	echo >>negative &&
 	git commit -e -m "sample"
@@ -248,7 +248,7 @@ rm -f expect.tmp
 echo "# Committer:
 #" >> expect
=20
-test_expect_success 'committer is automatic' '
+test_expect_success NO_GETTEXT_POISON 'committer is automatic' '
=20
 	echo >>negative &&
 	(
@@ -370,66 +370,66 @@ try_commit () {
=20
 try_commit_status_combo () {
=20
-	test_expect_success 'commit' '
+	test_expect_success NO_GETTEXT_POISON 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit' '
+	test_expect_success NO_GETTEXT_POISON 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status' '
 		clear_config commit.status &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status' '
 		clear_config commit.status &&
 		try_commit --no-status
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit with commit.status =3D =
yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit with commit.status =3D =
no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit "" &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status with commit.st=
atus =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status with commit=
=2Estatus =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status with commit.st=
atus =3D no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status with commit=
=2Estatus =3D no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit --no-status &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3d4f85d..2347451 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -20,17 +20,17 @@ test_expect_success 'setup' '
 	git commit -m "Add submodule sub"
 '
=20
-test_expect_success 'status clean' '
+test_expect_success NO_GETTEXT_POISON 'status clean' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'commit --dry-run -a clean' '
+test_expect_success NO_GETTEXT_POISON 'commit --dry-run -a clean' '
 	test_must_fail git commit --dry-run -a >output &&
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
@@ -177,12 +177,12 @@ test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
=20
-test_expect_success 'status clean (empty submodule dir)' '
+test_expect_success NO_GETTEXT_POISON 'status clean (empty submodule d=
ir)' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'status -a clean (empty submodule dir)' '
+test_expect_success NO_GETTEXT_POISON 'status -a clean (empty submodul=
e dir)' '
 	test_must_fail git commit --dry-run -a >output &&
 	grep "nothing to commit" output
 '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 18b07d9..97e0d7a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup' '
 	git add dir2/added
 '
=20
-test_expect_success 'status (1)' '
+test_expect_success NO_GETTEXT_POISON 'status (1)' '
=20
 	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
=20
@@ -61,7 +61,7 @@ cat >expect <<\EOF
 #	untracked
 EOF
=20
-test_expect_success 'status (2)' '
+test_expect_success NO_GETTEXT_POISON 'status (2)' '
=20
 	git status >output &&
 	test_cmp expect output
@@ -87,7 +87,7 @@ EOF
=20
 git config advice.statusHints false
=20
-test_expect_success 'status (advice.statusHints false)' '
+test_expect_success NO_GETTEXT_POISON 'status (advice.statusHints fals=
e)' '
=20
 	git status >output &&
 	test_cmp expect output
@@ -148,7 +148,7 @@ cat >expect <<EOF
 #
 # Untracked files not listed (use -u option to show untracked files)
 EOF
-test_expect_success 'status -uno' '
+test_expect_success NO_GETTEXT_POISON 'status -uno' '
 	mkdir dir3 &&
 	: >dir3/untracked1 &&
 	: >dir3/untracked2 &&
@@ -156,7 +156,7 @@ test_expect_success 'status -uno' '
 	test_cmp expect output
 '
=20
-test_expect_success 'status (status.showUntrackedFiles no)' '
+test_expect_success NO_GETTEXT_POISON 'status (status.showUntrackedFil=
es no)' '
 	git config status.showuntrackedfiles no
 	git status >output &&
 	test_cmp expect output
@@ -173,7 +173,7 @@ cat >expect <<EOF
 # Untracked files not listed
 EOF
 git config advice.statusHints false
-test_expect_success 'status -uno (advice.statusHints false)' '
+test_expect_success NO_GETTEXT_POISON 'status -uno (advice.statusHints=
 false)' '
 	git status -uno >output &&
 	test_cmp expect output
 '
@@ -219,12 +219,12 @@ cat >expect <<EOF
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
 	git status >output &&
 	test_cmp expect output
@@ -241,13 +241,13 @@ A  dir2/added
 ?? output
 ?? untracked
 EOF
-test_expect_success 'status -s -unormal' '
+test_expect_success NO_GETTEXT_POISON 'status -s -unormal' '
 	git config --unset status.showuntrackedfiles
 	git status -s -unormal >output &&
 	test_cmp expect output
 '
=20
-test_expect_success 'status -s (status.showUntrackedFiles normal)' '
+test_expect_success NO_GETTEXT_POISON 'status -s (status.showUntracked=
=46iles normal)' '
 	git config status.showuntrackedfiles normal
 	git status -s >output &&
 	test_cmp expect output
@@ -278,11 +278,11 @@ cat >expect <<EOF
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
 	git status >output &&
 	rm -rf dir3 &&
@@ -337,7 +337,7 @@ cat >expect <<\EOF
 #	../untracked
 EOF
=20
-test_expect_success 'status with relative paths' '
+test_expect_success NO_GETTEXT_POISON 'status with relative paths' '
=20
 	(cd dir1 && git status) >output &&
 	test_cmp expect output
@@ -409,7 +409,7 @@ cat >expect <<\EOF
 #	<BLUE>untracked<RESET>
 EOF
=20
-test_expect_success 'status with color.ui' '
+test_expect_success NO_GETTEXT_POISON 'status with color.ui' '
=20
 	git config color.ui always &&
 	git status | test_decode_color >output &&
@@ -417,7 +417,7 @@ test_expect_success 'status with color.ui' '
=20
 '
=20
-test_expect_success 'status with color.status' '
+test_expect_success NO_GETTEXT_POISON 'status with color.status' '
=20
 	git config --unset color.ui &&
 	git config color.status always &&
@@ -437,7 +437,7 @@ cat >expect <<\EOF
 <BLUE>??<RESET> untracked
 EOF
=20
-test_expect_success 'status -s with color.ui' '
+test_expect_success NO_GETTEXT_POISON 'status -s with color.ui' '
=20
 	git config --unset color.status &&
 	git config color.ui always &&
@@ -446,7 +446,7 @@ test_expect_success 'status -s with color.ui' '
=20
 '
=20
-test_expect_success 'status -s with color.status' '
+test_expect_success NO_GETTEXT_POISON 'status -s with color.status' '
=20
 	git config --unset color.ui &&
 	git config color.status always &&
@@ -467,7 +467,7 @@ cat >expect <<\EOF
 <BLUE>??<RESET> untracked
 EOF
=20
-test_expect_success 'status -s -b with color.status' '
+test_expect_success NO_GETTEXT_POISON 'status -s -b with color.status'=
 '
=20
 	git status -s -b | test_decode_color >output &&
 	test_cmp expect output
@@ -485,7 +485,7 @@ A  dir2/added
 ?? untracked
 EOF
=20
-test_expect_success 'status --porcelain ignores color.ui' '
+test_expect_success NO_GETTEXT_POISON 'status --porcelain ignores colo=
r.ui' '
=20
 	git config --unset color.status &&
 	git config color.ui always &&
@@ -494,7 +494,7 @@ test_expect_success 'status --porcelain ignores col=
or.ui' '
=20
 '
=20
-test_expect_success 'status --porcelain ignores color.status' '
+test_expect_success NO_GETTEXT_POISON 'status --porcelain ignores colo=
r.status' '
=20
 	git config --unset color.ui &&
 	git config color.status always &&
@@ -539,7 +539,7 @@ cat >expect <<\EOF
 EOF
=20
=20
-test_expect_success 'status without relative paths' '
+test_expect_success NO_GETTEXT_POISON 'status without relative paths' =
'
=20
 	git config status.relativePaths false
 	(cd dir1 && git status) >output &&
@@ -558,7 +558,7 @@ A  dir2/added
 ?? untracked
 EOF
=20
-test_expect_success 'status -s without relative paths' '
+test_expect_success NO_GETTEXT_POISON 'status -s without relative path=
s' '
=20
 	(cd dir1 && git status -s) >output &&
 	test_cmp expect output
@@ -581,7 +581,7 @@ cat <<EOF >expect
 #	output
 #	untracked
 EOF
-test_expect_success 'dry-run of partial commit excluding new file in i=
ndex' '
+test_expect_success NO_GETTEXT_POISON 'dry-run of partial commit exclu=
ding new file in index' '
 	git commit --dry-run dir1/modified >output &&
 	test_cmp expect output
 '
@@ -630,13 +630,13 @@ cat >expect <<EOF
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
@@ -694,7 +694,7 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'status submodule summary' '
+test_expect_success NO_GETTEXT_POISON 'status submodule summary' '
 	git config status.submodulesummary 10 &&
 	git status >output &&
 	test_cmp expect output
@@ -711,7 +711,7 @@ A  sm
 ?? output
 ?? untracked
 EOF
-test_expect_success 'status -s submodule summary' '
+test_expect_success NO_GETTEXT_POISON 'status -s submodule summary' '
 	git status -s >output &&
 	test_cmp expect output
 '
@@ -735,7 +735,7 @@ cat >expect <<EOF
 #	untracked
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-test_expect_success 'status submodule summary (clean submodule)' '
+test_expect_success NO_GETTEXT_POISON 'status submodule summary (clean=
 submodule)' '
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
@@ -753,7 +753,7 @@ cat >expect <<EOF
 ?? output
 ?? untracked
 EOF
-test_expect_success 'status -s submodule summary (clean submodule)' '
+test_expect_success NO_GETTEXT_POISON 'status -s submodule summary (cl=
ean submodule)' '
 	git status -s >output &&
 	test_cmp expect output
 '
@@ -787,7 +787,7 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success 'commit --dry-run submodule summary (--amend)' '
+test_expect_success NO_GETTEXT_POISON 'commit --dry-run submodule summ=
ary (--amend)' '
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
 	test_cmp expect output
@@ -842,13 +842,13 @@ cat > expect << EOF
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
@@ -860,7 +860,7 @@ test_expect_success '.gitmodules ignore=3Duntracked=
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
@@ -871,12 +871,12 @@ test_expect_success '.git/config ignore=3Duntrack=
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
@@ -888,7 +888,7 @@ test_expect_success '.gitmodules ignore=3Ddirty sup=
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
@@ -899,13 +899,13 @@ test_expect_success '.git/config ignore=3Ddirty s=
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
@@ -913,7 +913,7 @@ test_expect_success '.gitmodules ignore=3Ddirty sup=
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
@@ -956,12 +956,12 @@ cat > expect << EOF
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
@@ -969,7 +969,7 @@ test_expect_success ".gitmodules ignore=3Duntracked=
 doesn't suppress submodules wi
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
@@ -1018,12 +1018,12 @@ cat > expect << EOF
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
@@ -1031,7 +1031,7 @@ test_expect_success ".gitmodules ignore=3Duntrack=
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
@@ -1042,11 +1042,11 @@ test_expect_success ".git/config ignore=3Duntra=
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
@@ -1054,7 +1054,7 @@ test_expect_success ".gitmodules ignore=3Ddirty d=
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
@@ -1086,7 +1086,7 @@ cat > expect << EOF
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
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b4f40e4..cc6c4e9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -484,7 +484,7 @@ test_expect_success 'merge fast-forward in a dirty =
tree' '
=20
 test_debug 'git log --graph --decorate --oneline --all'
=20
-test_expect_success 'in-index merge' '
+test_expect_success NO_GETTEXT_POISON 'in-index merge' '
 	git reset --hard c0 &&
 	git merge --no-ff -s resolve c1 >out &&
 	grep "Wonderful." out &&
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 568a6f2..3aa544c 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -61,7 +61,7 @@ test_expect_success SIMPLEPAGER 'git grep -O' '
 	test_cmp empty out
 '
=20
-test_expect_success 'git grep -O --cached' '
+test_expect_success NO_GETTEXT_POISON 'git grep -O --cached' '
 	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
 	grep open-files-in-pager msg
 '
--=20
1.7.2.3.313.gcd15
