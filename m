From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v8 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
Date: Tue,  2 Jul 2013 03:19:03 +0400
Message-ID: <f0307d1e6d5bebb0a90ff1c0ffe70f8ef32f78df.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 01:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtnNn-0007Lt-KI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 01:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab3GAXTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jul 2013 19:19:31 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:44296 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab3GAXTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 19:19:24 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so5037185lab.15
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bzEhuhq0n+b4/qZu5bsDfL+xego9ysoc4DoCrJK/TY0=;
        b=Zks2CW/FLb5/nHra+f/S13J2Cph+ZpGeTkM88Ko1Sasak5RLCQlrBHV8BFYhKaEKJR
         GQ+V4E+Rd3xzno8gnZdtyfcwRusTrZCnTx9BrmaYgZesTcNn19CsD50GuIHtuoVQC9no
         PM8mO6/RVDtV+rl73sWi+xEaXiB6aPELoTqjE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bzEhuhq0n+b4/qZu5bsDfL+xego9ysoc4DoCrJK/TY0=;
        b=bVaqGtL22M7JJ3+82fJf7bHDPj+7XENdTAaEEaQtaW5aa0zJRBuLe5qg2562vQNxCI
         tv8KcsXWEJjTIts+6A8jCNniXLKUIyS7+FveVMvBMpsOmr4u7MMU8y6p80y2IDMCEuJ2
         wC+JKCInpmTWT/5YOKdKiEsq6matbTZwH4bjG+AdEfNgZ6WdqMEYxQ5nILoEiu8NjpXH
         3C8tBVMn1TRK5rW0wMzKKMIF26hv/UHfxSW6yaySVUbWUMVKXhjG47MP6y6RbiQI1sR2
         MfUa9kgdc7oWT3Lgw2em8IeyPdDPIvEuyL1Piv0VZdfdI7jkeWGyNk/xGK+rysgk4E2i
         PVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=bzEhuhq0n+b4/qZu5bsDfL+xego9ysoc4DoCrJK/TY0=;
        b=h3KE7obuadzF4SjIFcYSPZiWUxn3OJ0FwOjYiDH3t5mfbPhqgW7j1hjnYMj5gnbotB
         1vHrUuZDaI3PxV7XRBLd9cAUwhYKrRhU+zZ2g2BJ2ORt1Iu2BtgefBYW5QzeDHe/mUEA
         cHfhpz+5n8vWKY+D4dydCldrxIL5l0DSMB4JEoePVd7Fc+AV2gIi+3Ji4OYnLiVBkvgv
         wv55rRDYXoH/W2R9taALjIH2C2uCFXdmsTKW2RL5Pe1JVlJz+K10go15s2kYlOlxhKHe
         G2fn0FQUTwEaHezajFUh+/wtEqF25Juyi4gbAr+Vcib6xPVcLGLXQTcnSuKORHpm5i5C
         va0A==
X-Received: by 10.152.120.228 with SMTP id lf4mr13195251lab.65.1372720762727;
        Mon, 01 Jul 2013 16:19:22 -0700 (PDT)
Received: from localhost (ppp91-77-20-158.pppoe.mtu-net.ru. [91.77.20.158])
        by mx.google.com with ESMTPSA id v18sm7883858lbd.5.2013.07.01.16.19.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 16:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.16.gce2c52e
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com> <cover.1372719264.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQk7zUT7urRMdqJhJLjQyjRrN+kR7i96hsK5XDUFvl7oHiXng1AbYPGiIfJfrAfkVgfvKQGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229351>

One can set an alias
	$ git config alias.lg "log --graph --pretty=3Dformat:'%Cred%h%Creset
	-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset'
	--abbrev-commit --date=3Dlocal"

to see the log as a pretty tree (like *gitk* but in a terminal).

However, log messages written in an encoding i18n.commitEncoding which =
differs
from terminal encoding are shown corrupted even when i18n.logOutputEnco=
ding
and terminal encoding are the same (e.g. log messages committed on a Cy=
gwin box
with Windows-1251 encoding seen on a Linux box with a UTF-8 encoding an=
d vice versa).

To simplify an example we can say the following two commands are expect=
ed
to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=3Dformat:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it formats "%s".

The same corruption is true for
	$ git diff --submodule=3Dlog
and
	$ git rev-list --pretty=3Dformat:%s HEAD
and
	$ git reset --hard

This patch adds failing tests for the next patch that fixes them.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4041-diff-submodule-option.sh |  35 ++++++----
 t/t4205-log-pretty-formats.sh    | 146 ++++++++++++++++++++++++-------=
--------
 t/t6006-rev-list-format.sh       |  74 +++++++++++++++-----
 t/t7102-reset.sh                 |  31 ++++++++-
 4 files changed, 198 insertions(+), 88 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 32d4a60..d300d0c 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
+# Copyright (c) 2013 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
 #
=20
 test_description=3D'Support for verbose submodule differences in git d=
iff
@@ -10,6 +11,9 @@ This test tries to verify the sanity of the --submodu=
le option of git diff.
=20
 . ./test-lib.sh
=20
+# String "added" in German (translated with Google Translate), encoded=
 in UTF-8,
+# used in sample commit log messages in add_file() function below.
+added=3D$(printf "hinzugef\303\274gt")
 add_file () {
 	(
 		cd "$1" &&
@@ -19,7 +23,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			git commit -m "Add $name" || exit
+			msg_added_iso88591=3D$(echo "Add $name ($added $name)" | iconv -f u=
tf-8 -t iso8859-1) &&
+			git -c 'i18n.commitEncoding=3Diso8859-1' commit -m "$msg_added_iso8=
8591"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
@@ -89,29 +94,29 @@ test_expect_success 'diff.submodule does not affect=
 plumbing' '
 commit_file sm1 &&
 head2=3D$(add_file sm1 foo3)
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff --submodule=3Dlog >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward) --submodule' '
+test_expect_failure 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
@@ -138,25 +143,25 @@ head3=3D$(
 	git rev-parse --short --verify HEAD
 )
=20
-test_expect_success 'modified submodule(backward)' '
+test_expect_failure 'modified submodule(backward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
-	  < Add foo3
-	  < Add foo2
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
=20
 head4=3D$(add_file sm1 foo4 foo5)
-test_expect_success 'modified submodule(backward and forward)' '
+test_expect_failure 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
-	  > Add foo5
-	  > Add foo4
-	  < Add foo3
-	  < Add foo2
+	  > Add foo5 ($added foo5)
+	  > Add foo4 ($added foo4)
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 73ba5e8..a23da67 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1,20 +1,44 @@
 #!/bin/sh
 #
 # Copyright (c) 2010, Will Palmer
+# Copyright (c) 2013, Alexey Shumkin (+ non-UTF-8 commit encoding test=
s)
 #
=20
 test_description=3D'Test pretty formats'
 . ./test-lib.sh
=20
+commit_msg() {
+	# String "initial. initial" partly in German
+   # (translated with Google Translate),
+	# encoded in UTF-8, used as a commit log message below.
+	msg=3D$(printf "initial. anf\303\244nglich")
+	if test -n "$1"
+	then
+		msg=3D$(echo $msg | iconv -f utf-8 -t $1)
+	fi
+	if test -n "$2" -a -n "$3"
+	then
+		# cut string, replace cut part with two dots
+		# $2 - chars count from the beginning of the string
+		# $3 - "trailing" chars
+		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a by=
te
+		# as it does with C locale
+		msg=3D$(echo $msg | LC_ALL=3Den_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1=
=2E./")
+	fi
+	echo $msg
+}
+
 test_expect_success 'set up basic repos' '
 	>foo &&
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git commit -m initial &&
+	git config i18n.commitEncoding iso8859-1 &&
+	git commit -m "$(commit_msg iso8859-1)" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"
+	git commit -m "add bar" &&
+	git config --unset i18n.commitEncoding
 '
=20
 test_expect_success 'alias builtin format' '
@@ -38,6 +62,20 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'alias user-defined tformat with %s (iso8859-1 enc=
oding)' '
+	git config i18n.logOutputEncoding iso8859-1 &&
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	git config --unset i18n.logOutputEncoding &&
+	test_cmp expected-s actual-s
+'
+
+test_expect_failure 'alias user-defined tformat with %s (utf-8 encodin=
g)' '
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	test_cmp expected-s actual-s
+'
+
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
@@ -71,22 +109,22 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=3Dtest-foo
 '
=20
-test_expect_success 'NUL separation' '
-	printf "add bar\0initial" >expected &&
+test_expect_failure 'NUL separation' '
+	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty=3D"format:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL termination' '
-	printf "add bar\0initial\0" >expected &&
+test_expect_failure 'NUL termination' '
+	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty=3D"tformat:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL separation with --stat' '
+test_expect_failure 'NUL separation with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expect=
ed &&
 	git log -z --stat --pretty=3D"format:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -94,7 +132,7 @@ test_expect_success 'NUL separation with --stat' '
 test_expect_failure 'NUL termination with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &=
&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expec=
ted &&
 	git log -z --stat --pretty=3D"tformat:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -108,172 +146,172 @@ test_expect_success 'setup more commits' '
 	head4=3D$(git rev-parse --verify --short HEAD~3)
 '
=20
-test_expect_success 'left alignment formatting' '
+test_expect_failure 'left alignment formatting' '
 	git log --pretty=3D"format:%<(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 message two                            Z
 message one                            Z
 add bar                                Z
-initial                                Z
+$(commit_msg)                    Z
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'left alignment formatting at the nth column' "
-	git log --pretty=3D'format:%h %<|(40)%s' >actual &&
+test_expect_failure 'left alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %<|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1 message two                    Z
 $head2 message one                    Z
 $head3 add bar                        Z
-$head4 initial                        Z
+$head4 $(commit_msg)            Z
 EOF
 	test_cmp expected actual
-"
+'
=20
-test_expect_success 'left alignment formatting with no padding' '
+test_expect_failure 'left alignment formatting with no padding' '
 	git log --pretty=3D"format:%<(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'left alignment formatting with trunc' '
+test_expect_failure 'left alignment formatting with trunc' '
 	git log --pretty=3D"format:%<(10,trunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 message ..
 message ..
 add bar  Z
-initial  Z
+$(commit_msg "" "8" ".\+$")
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'left alignment formatting with ltrunc' '
+test_expect_failure 'left alignment formatting with ltrunc' '
 	git log --pretty=3D"format:%<(10,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 ..sage two
 ..sage one
 add bar  Z
-initial  Z
+$(commit_msg "" "0" ".\{11\}")
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'left alignment formatting with mtrunc' '
+test_expect_failure 'left alignment formatting with mtrunc' '
 	git log --pretty=3D"format:%<(10,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 mess.. two
 mess.. one
 add bar  Z
-initial  Z
+$(commit_msg "" "4" ".\{11\}")
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'right alignment formatting' '
+test_expect_failure 'right alignment formatting' '
 	git log --pretty=3D"format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 Z                            message two
 Z                            message one
 Z                                add bar
-Z                                initial
+Z                    $(commit_msg)
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'right alignment formatting at the nth column' "
-	git log --pretty=3D'format:%h %>|(40)%s' >actual &&
+test_expect_failure 'right alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %>|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1                      message two
 $head2                      message one
 $head3                          add bar
-$head4                          initial
+$head4              $(commit_msg)
 EOF
 	test_cmp expected actual
-"
+'
=20
-test_expect_success 'right alignment formatting with no padding' '
+test_expect_failure 'right alignment formatting with no padding' '
 	git log --pretty=3D"format:%>(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'center alignment formatting' '
+test_expect_failure 'center alignment formatting' '
 	git log --pretty=3D"format:%><(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 Z             message two              Z
 Z             message one              Z
 Z               add bar                Z
-Z               initial                Z
+Z         $(commit_msg)          Z
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'center alignment formatting at the nth column' "
-	git log --pretty=3D'format:%h %><|(40)%s' >actual &&
+test_expect_failure 'center alignment formatting at the nth column' '
+	git log --pretty=3D"format:%h %><|(40)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	qz_to_tab_space <<\EOF >expected &&
+	qz_to_tab_space <<EOF >expected &&
 $head1           message two          Z
 $head2           message one          Z
 $head3             add bar            Z
-$head4             initial            Z
+$head4       $(commit_msg)      Z
 EOF
 	test_cmp expected actual
-"
+'
=20
-test_expect_success 'center alignment formatting with no padding' '
+test_expect_failure 'center alignment formatting with no padding' '
 	git log --pretty=3D"format:%><(1)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'left/right alignment formatting with stealing' '
+test_expect_failure 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &=
&
 	git log --pretty=3D"format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual =
&&
 	# complete the incomplete line at the end
 	echo >>actual &&
-	cat <<\EOF >expected &&
+	cat <<EOF >expected &&
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
-initial      A U Thor
+$(commit_msg "" "8" ".\+$")   A U Thor
 EOF
 	test_cmp expected actual
 '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index cc1008d..e4b50ed 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -1,31 +1,44 @@
 #!/bin/sh
=20
+# Copyright (c) 2009 Jens Lehmann
+# Copyright (c) 2013 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
+
 test_description=3D'git rev-list --pretty=3Dformat test'
=20
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
 test_tick
+# String "added" in German (translated with Google Translate), encoded=
 in UTF-8,
+# used as a commit log message below.
+added=3D$(printf "added (hinzugef\303\274gt) foo")
+added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t iso8859-1)
+# same but "changed"
+changed=3D$(printf "changed (ge\303\244ndert) foo")
+changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t iso8859-1)
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git commit -m "added foo" &&
+	git config i18n.commitEncoding iso8859-1 &&
+	git commit -m "$added_iso88591" &&
 	head1=3D$(git rev-parse --verify HEAD) &&
 	head1_short=3D$(git rev-parse --verify --short $head1) &&
 	tree1=3D$(git rev-parse --verify HEAD:) &&
 	tree1_short=3D$(git rev-parse --verify --short $tree1) &&
-	echo changed >foo &&
-	git commit -a -m "changed foo" &&
+	echo "$changed" > foo &&
+	git commit -a -m "$changed_iso88591" &&
 	head2=3D$(git rev-parse --verify HEAD) &&
 	head2_short=3D$(git rev-parse --verify --short $head2) &&
 	tree2=3D$(git rev-parse --verify HEAD:) &&
 	tree2_short=3D$(git rev-parse --verify --short $tree2)
+	git config --unset i18n.commitEncoding
 '
=20
-# usage: test_format name format_string <expected_output
+# usage: test_format name format_string [failure] <expected_output
 test_format () {
 	cat >expect.$1
-	test_expect_success "format $1" "
+	test_expect_${3:-success} "format $1" "
 		git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
 		test_cmp expect.$1 output.$1
 	"
@@ -110,14 +123,16 @@ EOF
=20
 test_format encoding %e <<EOF
 commit $head2
+iso8859-1
 commit $head1
+iso8859-1
 EOF
=20
-test_format subject %s <<EOF
+test_format subject %s failure <<EOF
 commit $head2
-changed foo
+$changed
 commit $head1
-added foo
+$added
 EOF
=20
 test_format body %b <<EOF
@@ -125,12 +140,12 @@ commit $head2
 commit $head1
 EOF
=20
-test_format raw-body %B <<EOF
+test_format raw-body %B failure <<EOF
 commit $head2
-changed foo
+$changed
=20
 commit $head1
-added foo
+$added
=20
 EOF
=20
@@ -190,12 +205,12 @@ test_expect_success '%C(auto) respects --color=3D=
auto (stdout not tty)' '
 	)
 '
=20
-cat >commit-msg <<'EOF'
+iconv -f utf-8 -t iso8859-1 > commit-msg <<EOF
 Test printing of complex bodies
=20
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =A1bueno!
+include an iso8859 character: =C2=A1bueno!
 EOF
=20
 test_expect_success 'setup complex body' '
@@ -209,16 +224,18 @@ test_format complex-encoding %e <<EOF
 commit $head3
 iso8859-1
 commit $head2
+iso8859-1
 commit $head1
+iso8859-1
 EOF
=20
 test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
-changed foo
+$changed_iso88591
 commit $head1
-added foo
+$added_iso88591
 EOF
=20
 test_format complex-body %b <<EOF
@@ -231,6 +248,29 @@ commit $head2
 commit $head1
 EOF
=20
+# Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
+# so unset i18n.commitEncoding to test encoding conversion
+git config --unset i18n.commitEncoding
+
+test_format complex-subject-commitencoding-unset %s failure <<EOF
+commit $head3
+Test printing of complex bodies
+commit $head2
+$changed
+commit $head1
+$added
+EOF
+
+test_format complex-body-commitencoding-unset %b failure <<EOF
+commit $head3
+This commit message is much longer than the others,
+and it will be encoded in iso8859-1. We should therefore
+include an iso8859 character: =C2=A1bueno!
+
+commit $head2
+commit $head1
+EOF
+
 test_expect_success '%x00 shows NUL' '
 	echo  >expect commit $head3 &&
 	echo >>expect fooQbar &&
@@ -279,12 +319,12 @@ test_expect_success 'add LF before non-empty (2)'=
 '
=20
 test_expect_success 'add SP before non-empty (1)' '
 	git show -s --pretty=3Dformat:"%s% bThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 2
+	test $(wc -w <actual) =3D 3
 '
=20
 test_expect_success 'add SP before non-empty (2)' '
 	git show -s --pretty=3Dformat:"%s% sThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 4
+	test $(wc -w <actual) =3D 6
 '
=20
 test_expect_success '--abbrev' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 05dfb27..6a92703 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -9,6 +9,19 @@ Documented tests for git reset'
=20
 . ./test-lib.sh
=20
+commit_msg() {
+	# String "modify 2nd file (changed)" partly in German
+	# (translated with Google Translate),
+	# encoded in UTF-8, used as a commit log message below.
+	printf "modify 2nd file (ge\303\244ndert)" |
+	if test -n "$1"
+	then
+		iconv -f utf-8 -t $1
+	else
+		cat
+	fi
+}
+
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
 	echo "1st file" >first &&
@@ -28,7 +41,7 @@ test_expect_success 'creating initial files and commi=
ts' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Diso8859-1" commit -a -m "$(commit_msg i=
so8859-1)" &&
 	head5=3D$(git rev-parse --verify HEAD)
 '
 # git log --pretty=3Doneline # to see those SHA1 involved
@@ -44,6 +57,20 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
=20
+test_expect_failure 'reset --hard message' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	test_cmp .expected .actual
+'
+
+test_expect_success 'reset --hard message (iso8859-1 logoutputencoding=
)' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git -c "i18n.logOutputEncoding=3Diso8859-1" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg iso8859-1) > .expected &&
+	test_cmp .expected .actual
+'
+
 >.diff_expect
 >.cached_expect
 cat >.cat_expect <<EOF
@@ -304,7 +331,7 @@ test_expect_success 'redoing the last two commits s=
hould succeed' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Diso8859-1" commit -a -m "$(commit_msg i=
so8859-1)" &&
 	check_changes $head5
 '
=20
--=20
1.8.3.1.16.gce2c52e
