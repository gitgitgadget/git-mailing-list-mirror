From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 27/73] gettextize: git-commit formatting messages
Date: Fri, 25 Feb 2011 03:43:43 -0600
Message-ID: <20110225094342.GJ23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-28-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:43:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsuDO-0006Gm-2Q
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377Ab1BYJnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 04:43:53 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42219 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab1BYJnv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 04:43:51 -0500
Received: by vxi39 with SMTP id 39so1213262vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NV7U8QOvFKBW5rBiiO2UV9SXXx8dPPJ1thA6YJvTGvg=;
        b=ROrZic2T2rtEwaBvoM29uq2KomkIuhmD9Zl9YHauDnJz+XDu6gbo5g5wB+MyR+KfNM
         BFz0uFI/BzI3coRy1pogllOcXzzao8wmI2rgN8a2kLcA4chiUj4r03AIaC6/JuUu5ghK
         jH02caoLujuu3ZGBruXgInhxKHR4OemKXvuGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eb1PmTFfqkDvAL2JFg76D8TdfKLl71GErviQkVn4yC8Nwx/9rycaNcSYzHb+rtFZv/
         0vsSehhO1ieWQ3Oh9XvfwuJJ6V/3vxMHS0IGTkEJQqzk717bNQoTJ+3ajmFSMcNW05vn
         1Y6x4PTFp4gGJ1uclOnaim1XyJf4QFuz6Y+ms=
Received: by 10.52.94.145 with SMTP id dc17mr3584219vdb.109.1298627030343;
        Fri, 25 Feb 2011 01:43:50 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id h18sm379860vbr.4.2011.02.25.01.43.47
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 01:43:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-28-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167894>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -696,12 +696,12 @@ static int prepare_to_commit(const char *index_=
file, const char *prefix,
>  		char *ai_tmp, *ci_tmp;
>  		if (in_merge)
>  			fprintf(fp,
> -				"#\n"
> +				_("#\n"
[...]

(Everything up to and including patch 26 still looks good.)

Here's a weatherballoon patch to mark the tests affected by patch 27
as "expect failure", in case we want to go that route.  Combined with
"commit: error out for missing commit message template", it passes all
tests.

-- 8< --
Subject: i18n: update expected test results for git-commit formatting m=
essages

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/lib-commit-template.sh           |   19 ++++++++
 t/t3404-rebase-interactive.sh      |    3 +-
 t/t4013-diff-various.sh            |   82 +++++++++++++++++++++++-----=
--------
 t/t7500-commit.sh                  |   19 ++++----
 t/t7501-commit.sh                  |    9 ++--
 t/t7505-prepare-commit-msg-hook.sh |    7 ++-
 t/t7507-commit-verbose.sh          |    5 +-
 t/t7509-commit.sh                  |    3 +-
 8 files changed, 97 insertions(+), 50 deletions(-)
 create mode 100644 t/lib-commit-template.sh

diff --git a/t/lib-commit-template.sh b/t/lib-commit-template.sh
new file mode 100644
index 0000000..80ec50c
--- /dev/null
+++ b/t/lib-commit-template.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+# Messages such as
+#
+#      # It looks like you may be committing a MERGE.\n"
+#
+# are now translatable, even though the "# " part probably ought not
+# to be.  Expect some tests to fail when GETTEXT_POISON is enabled.
+
+if test_have_prereq C_LOCALE_OUTPUT
+then
+	test_log_messages_expect_success () {
+		test_expect_success "$@"
+	}
+else
+	test_log_messages_expect_success () {
+		test_expect_failure "$@"
+	}
+fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 7d8147b..84630e3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -28,6 +28,7 @@ Initial setup:
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 test_cmp_rev () {
 	git rev-parse --verify "$1" >expect.rev &&
@@ -390,7 +391,7 @@ D
 ONCE
 EOF
=20
-test_expect_success 'squash and fixup generate correct log messages' '
+test_log_messages_expect_success 'squash and fixup generate correct lo=
g messages' '
 	git checkout -b squash-fixup E &&
 	base=3D$(git rev-parse HEAD~4) &&
 	FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"1 fixup 2 squash 3 fixup 4" =
\
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index b8f81d0..872c37c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -6,6 +6,7 @@
 test_description=3D'Various diff formatting options'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 LF=3D'
 '
@@ -95,35 +96,42 @@ test_expect_success setup '
 EOF
=20
 V=3D`git version | sed -e 's/^git version //' -e 's/\./\\./g'`
-while read cmd
-do
-	case "$cmd" in
-	'' | '#'*) continue ;;
-	esac
-	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	pfx=3D`printf "%04d" $test_count`
-	expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
-	actual=3D"$pfx-diff.$test"
=20
-	test_expect_success "git $cmd" '
-		{
-			echo "\$ git $cmd"
-			git $cmd |
-			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
-			    -e "s/^\\(.*mixed; boundary=3D\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v=
-e-r-s-i-o-n\2\"/"
-			echo "\$"
-		} >"$actual" &&
-		if test -f "$expect"
-		then
-			test_cmp "$expect" "$actual" &&
-			rm -f "$actual"
-		else
-			# this is to help developing new tests.
-			cp "$actual" "$expect"
-			false
-		fi
-	'
-done <<\EOF
+try_cmds () {
+	test_expect_expectation=3D${1:-test_expect_success}
+
+	while read cmd
+	do
+		case "$cmd" in
+		'' | '#'*) continue ;;
+		esac
+		test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
+		pfx=3D`printf "%04d" $test_count`
+		expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
+		actual=3D"$pfx-diff.$test"
+
+		$test_expect_expectation "git $cmd" '
+			{
+				echo "\$ git $cmd"
+				git $cmd |
+				sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
+				    -e "s/^\\(.*mixed; boundary=3D\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--=
v-e-r-s-i-o-n\2\"/"
+				echo "\$"
+			} >"$actual" &&
+			if test -f "$expect"
+			then
+				test_cmp "$expect" "$actual" &&
+				rm -f "$actual"
+			else
+				# this is to help developing new tests.
+				cp "$actual" "$expect"
+				false
+			fi
+		'
+	done
+}
+
+try_cmds <<\EOF
 diff-tree initial
 diff-tree -r initial
 diff-tree -r --abbrev initial
@@ -174,25 +182,33 @@ diff-tree --pretty --patch-with-stat side
=20
 diff-tree master
 diff-tree -p master
+EOF
+try_cmds test_log_messages_expect_success <<\EOF
 diff-tree -p -m master
 diff-tree -c master
 diff-tree -c --abbrev master
-diff-tree --cc master
 # stat only should show the diffstat with the first parent
 diff-tree -c --stat master
 diff-tree --cc --stat master
 diff-tree -c --stat --summary master
 diff-tree --cc --stat --summary master
+EOF
+try_cmds <<\EOF
 # stat summary should show the diffstat and summary with the first par=
ent
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
+EOF
+try_cmds test_log_messages_expect_success <<\EOF
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat master
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat --summary master
+EOF
+try_cmds <<\EOF
 # this is correct
 diff-tree --cc --patch-with-stat --summary side
-
+EOF
+try_cmds test_log_messages_expect_success <<\EOF
 log master
 log -p master
 log --root master
@@ -237,14 +253,20 @@ log --patch-with-stat master -- dir/
 whatchanged --patch-with-stat master -- dir/
 log --patch-with-stat --summary master -- dir/
 whatchanged --patch-with-stat --summary master -- dir/
+EOF
+try_cmds <<\EOF
=20
 show initial
 show --root initial
 show side
+EOF
+try_cmds test_log_messages_expect_success <<\EOF
 show master
 show -c master
 show -m master
 show --first-parent master
+EOF
+try_cmds <<\EOF
 show --stat side
 show --stat --summary side
 show --patch-with-stat side
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 5976f59..614d31b 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -8,6 +8,7 @@ test_description=3D'git commit
 Tests for selected commit options.'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-commit-template.sh"
=20
 commit_msg_is () {
 	expect=3Dcommit_msg_is.expect
@@ -48,7 +49,7 @@ test_expect_success 'nonexistent template file in con=
fig should return error' '
 # From now on we'll use a template file that exists.
 TEMPLATE=3D"$PWD"/template
=20
-test_expect_success 'unedited template should not commit' '
+test_log_messages_expect_success 'unedited template should not commit'=
 '
 	echo "template line" > "$TEMPLATE" &&
 	test_must_fail git commit --template "$TEMPLATE"
 '
@@ -72,7 +73,7 @@ test_expect_success 'adding comments to a template sh=
ould not commit' '
 	)
 '
=20
-test_expect_success 'adding real content to a template should commit' =
'
+test_log_messages_expect_success 'adding real content to a template sh=
ould commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE"
@@ -80,7 +81,7 @@ test_expect_success 'adding real content to a templat=
e should commit' '
 	commit_msg_is "template linecommit message"
 '
=20
-test_expect_success '-t option should be short for --template' '
+test_log_messages_expect_success '-t option should be short for --temp=
late' '
 	echo "short template" > "$TEMPLATE" &&
 	echo "new content" >> foo &&
 	git add foo &&
@@ -91,7 +92,7 @@ test_expect_success '-t option should be short for --=
template' '
 	commit_msg_is "short templatecommit message"
 '
=20
-test_expect_success 'config-specified template should commit' '
+test_log_messages_expect_success 'config-specified template should com=
mit' '
 	echo "new template" > "$TEMPLATE" &&
 	git config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
@@ -206,7 +207,7 @@ test_expect_success 'commit -F overrides -t' '
 	commit_msg_is "-F log"
 '
=20
-test_expect_success 'Commit without message is allowed with --allow-em=
pty-message' '
+test_log_messages_expect_success 'Commit without message is allowed wi=
th --allow-empty-message' '
 	echo "more content" >>foo &&
 	git add foo &&
 	>empty &&
@@ -214,7 +215,7 @@ test_expect_success 'Commit without message is allo=
wed with --allow-empty-messag
 	commit_msg_is ""
 '
=20
-test_expect_success 'Commit without message is no-no without --allow-e=
mpty-message' '
+test_log_messages_expect_success 'Commit without message is no-no with=
out --allow-empty-message' '
 	echo "more content" >>foo &&
 	git add foo &&
 	>empty &&
@@ -270,7 +271,7 @@ test_expect_success 'commit --squash works with -C'=
 '
 	commit_msg_is "squash! target message subject lineintermediate commit=
"
 '
=20
-test_expect_success 'commit --squash works with -c' '
+test_log_messages_expect_success 'commit --squash works with -c' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
 	git commit --squash HEAD~1 -c HEAD &&
@@ -283,14 +284,14 @@ test_expect_success 'commit --squash works with -=
C for same commit' '
 	commit_msg_is "squash! intermediate commit"
 '
=20
-test_expect_success 'commit --squash works with -c for same commit' '
+test_log_messages_expect_success 'commit --squash works with -c for sa=
me commit' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
 	git commit --squash HEAD -c HEAD &&
 	commit_msg_is "squash! edited commit"
 '
=20
-test_expect_success 'commit --squash works with editor' '
+test_log_messages_expect_success 'commit --squash works with editor' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 	git commit --squash HEAD~1 &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8980738..af6a829 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -8,6 +8,7 @@
=20
 test_description=3D'git commit'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 test_tick
=20
@@ -163,7 +164,7 @@ d381ac431806e53f3dd7ac2f1ae0534f36d738b9
 402702b49136e7587daa9280e91e4bb7cb2179f7
 EOF
=20
-test_expect_success \
+test_log_messages_expect_success \
     'validate git rev-list output.' \
     'test_cmp expected current'
=20
@@ -200,7 +201,7 @@ test_expect_success 'partial commit that involves r=
emoval (3)' '
 '
=20
 author=3D"The Real Author <someguy@his.email.org>"
-test_expect_success 'amend commit to fix author' '
+test_log_messages_expect_success 'amend commit to fix author' '
=20
 	oldtick=3D$GIT_AUTHOR_DATE &&
 	test_tick &&
@@ -215,7 +216,7 @@ test_expect_success 'amend commit to fix author' '
=20
 '
=20
-test_expect_success 'amend commit to fix date' '
+test_log_messages_expect_success 'amend commit to fix date' '
=20
 	test_tick &&
 	newtick=3D$GIT_AUTHOR_DATE &&
@@ -329,7 +330,7 @@ test_expect_success 'multiple -m' '
 '
=20
 author=3D"The Real Author <someguy@his.email.org>"
-test_expect_success 'amend commit to fix author' '
+test_log_messages_expect_success 'amend commit to fix author' '
=20
 	oldtick=3D$GIT_AUTHOR_DATE &&
 	test_tick &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commi=
t-msg-hook.sh
index ff18962..2d7ec32 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -3,6 +3,7 @@
 test_description=3D'prepare-commit-msg hook'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 test_expect_success 'with no hook' '
=20
@@ -103,7 +104,7 @@ test_expect_success 'with hook (-C)' '
=20
 '
=20
-test_expect_success 'with hook (editor)' '
+test_log_messages_expect_success 'with hook (editor)' '
=20
 	echo "more more" >> file &&
 	git add file &&
@@ -112,7 +113,7 @@ test_expect_success 'with hook (editor)' '
=20
 '
=20
-test_expect_success 'with hook (--amend)' '
+test_log_messages_expect_success 'with hook (--amend)' '
=20
 	head=3D`git rev-parse HEAD` &&
 	echo "more" >> file &&
@@ -122,7 +123,7 @@ test_expect_success 'with hook (--amend)' '
=20
 '
=20
-test_expect_success 'with hook (-c)' '
+test_log_messages_expect_success 'with hook (-c)' '
=20
 	head=3D`git rev-parse HEAD` &&
 	echo "more" >> file &&
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index da5bd3b..62c42b3 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'verbose commit template'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 cat >check-for-diff <<EOF
 #!$SHELL_PATH
@@ -37,12 +38,12 @@ check_message() {
 	test_cmp "$1" actual
 }
=20
-test_expect_success 'verbose diff is stripped out' '
+test_log_messages_expect_success 'verbose diff is stripped out' '
 	git commit --amend -v &&
 	check_message message
 '
=20
-test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
+test_log_messages_expect_success 'verbose diff is stripped out (mnemon=
icprefix)' '
 	git config diff.mnemonicprefix true &&
 	git commit --amend -v &&
 	check_message message
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 77b6920..2820b89 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -6,6 +6,7 @@
 test_description=3D'git commit --reset-author'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-commit-template.sh
=20
 author_header () {
 	git cat-file commit "$1" |
@@ -57,7 +58,7 @@ test_expect_success '-c option copies authorship and =
message' '
 	test_cmp expect actual
 '
=20
-test_expect_success '-c option copies only the message with --reset-au=
thor' '
+test_log_messages_expect_success '-c option copies only the message wi=
th --reset-author' '
 	echo "Test 4" >>foo &&
 	test_tick &&
 	EDITOR=3D: VISUAL=3D: git commit -a -c Initial --reset-author &&
--=20
1.7.4.1
