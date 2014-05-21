From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 2/5] t4041, t4205, t6006, t7102: Don't hardcode tested encoding value
Date: Wed, 21 May 2014 17:20:04 +0400
Message-ID: <54dcfd93d1f81f106bc106bf0ae60ab5b5a6bab4.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400678003.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6Rm-00023H-Hw
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbaEUNUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2014 09:20:38 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43604 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaEUNUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:37 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so1520917lbd.22
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=XaK3QPqfeQ4O+1vW/FhQtOLrNT5b0STSxii4tgiTguM=;
        b=YyKc3R/WyxKLPzHumd8MUFyvsOSXc6F+f/mUz4no2HRhtGihvNNqgAe4gKM3BM3G6+
         G/xIPdQVEH6NpjghZGNYmZJGA5FrJFoQEvxOMfek754SYhcAbEanHI4AVbczRq0056GC
         4veBi28Dwk6dbVD7Cr2mOPOK7hBNdoVq0gVlOPWp2aQ23eBCtSmtxc7UUgCfDyXXMmRh
         lJWDBQ+jTIc8EAehvzn7xQx7UCAWRoTeLYj5UholfnF1q+cqJeLoYErbyvy/J9QqmYte
         wa9eI5SLhhLfbO/b9hWuxE73ZcH1Otlm6JjdaePG6onKx8pWIFqHx+ZNMaju7032iehb
         42Xw==
X-Received: by 10.112.55.5 with SMTP id n5mr1699068lbp.71.1400678435322;
        Wed, 21 May 2014 06:20:35 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id k9sm25545605lam.11.2014.05.21.06.20.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:34 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249796>

The tested encoding is always available in a variable. Use it instead o=
f
hardcoding. Also, to be in line with other tests use ISO8859-1
(uppercase) rather then iso8859-1.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4041-diff-submodule-option.sh |  7 +++++--
 t/t4205-log-pretty-formats.sh    | 11 +++++++----
 t/t6006-rev-list-format.sh       | 35 +++++++++++++++++++-------------=
---
 t/t7102-reset.sh                 | 13 ++++++++-----
 4 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 1751c83..463d63b 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -11,6 +11,9 @@ This test tries to verify the sanity of the --submodu=
le option of git diff.
=20
 . ./test-lib.sh
=20
+# Tested non-UTF-8 encoding
+test_encoding=3D"ISO8859-1"
+
 # String "added" in German (translated with Google Translate), encoded=
 in UTF-8,
 # used in sample commit log messages in add_file() function below.
 added=3D$(printf "hinzugef\303\274gt")
@@ -23,8 +26,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			msg_added_iso88591=3D$(echo "Add $name ($added $name)" | iconv -f u=
tf-8 -t iso8859-1) &&
-			git -c 'i18n.commitEncoding=3Diso8859-1' commit -m "$msg_added_iso8=
8591"
+			msg_added_iso88591=3D$(echo "Add $name ($added $name)" | iconv -f u=
tf-8 -t $test_encoding) &&
+			git -c "i18n.commitEncoding=3D$test_encoding" commit -m "$msg_added=
_iso88591"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index f9f33ae..f5ea3f8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -7,6 +7,9 @@
 test_description=3D'Test pretty formats'
 . ./test-lib.sh
=20
+# Tested non-UTF-8 encoding
+test_encoding=3D"ISO8859-1"
+
 sample_utf8_part=3D$(printf "f\303\244ng")
=20
 commit_msg () {
@@ -27,8 +30,8 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding iso8859-1 &&
-	git commit -m "$(commit_msg iso8859-1)" &&
+	git config i18n.commitEncoding $test_encoding &&
+	git commit -m "$(commit_msg $test_encoding)" &&
 	git add bar &&
 	test_tick &&
 	git commit -m "add bar" &&
@@ -56,8 +59,8 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'alias user-defined tformat with %s (iso8859-1 enc=
oding)' '
-	git config i18n.logOutputEncoding iso8859-1 &&
+test_expect_success 'alias user-defined tformat with %s (ISO8859-1 enc=
oding)' '
+	git config i18n.logOutputEncoding $test_encoding &&
 	git log --oneline >expected-s &&
 	git log --pretty=3D"tformat:%h %s" >actual-s &&
 	git config --unset i18n.logOutputEncoding &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9874403..9e4ba62 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -9,19 +9,22 @@ test_description=3D'git rev-list --pretty=3Dformat te=
st'
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
 test_tick
+# Tested non-UTF-8 encoding
+test_encoding=3D"ISO8859-1"
+
 # String "added" in German
 # (translated with Google Translate),
 # encoded in UTF-8, used as a commit log message below.
 added=3D$(printf "added (hinzugef\303\274gt) foo")
-added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t iso8859-1)
+added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t $test_encoding)
 # same but "changed"
 changed=3D$(printf "changed (ge\303\244ndert) foo")
-changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t iso8859-1)
+changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t $test_encodin=
g)
=20
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git config i18n.commitEncoding iso8859-1 &&
+	git config i18n.commitEncoding $test_encoding &&
 	git commit -m "$added_iso88591" &&
 	head1=3D$(git rev-parse --verify HEAD) &&
 	head1_short=3D$(git rev-parse --verify --short $head1) &&
@@ -124,9 +127,9 @@ EOF
=20
 test_format encoding %e <<EOF
 commit $head2
-iso8859-1
+$test_encoding
 commit $head1
-iso8859-1
+$test_encoding
 EOF
=20
 test_format subject %s <<EOF
@@ -206,16 +209,16 @@ test_expect_success '%C(auto) respects --color=3D=
auto (stdout not tty)' '
 	)
 '
=20
-iconv -f utf-8 -t iso8859-1 > commit-msg <<EOF
+iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
 Test printing of complex bodies
=20
 This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+and it will be encoded in $test_encoding. We should therefore
+include an ISO8859 character: =C2=A1bueno!
 EOF
=20
 test_expect_success 'setup complex body' '
-	git config i18n.commitencoding iso8859-1 &&
+	git config i18n.commitencoding $test_encoding &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=3D$(git rev-parse --verify HEAD) &&
 	head3_short=3D$(git rev-parse --short $head3)
@@ -223,11 +226,11 @@ test_expect_success 'setup complex body' '
=20
 test_format complex-encoding %e <<EOF
 commit $head3
-iso8859-1
+$test_encoding
 commit $head2
-iso8859-1
+$test_encoding
 commit $head1
-iso8859-1
+$test_encoding
 EOF
=20
 test_format complex-subject %s <<EOF
@@ -243,16 +246,16 @@ test_expect_success 'prepare expected messages (f=
or test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
-	and it will be encoded in iso8859-1. We should therefore
-	include an iso8859 character: =C2=A1bueno!
+	and it will be encoded in $test_encoding. We should therefore
+	include an ISO8859 character: =C2=A1bueno!
=20
 	commit $head2
 	commit $head1
 	EOF
-	iconv -f utf-8 -t iso8859-1 expected.utf-8 >expected.iso8859-1
+	iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
 '
=20
-test_format complex-body %b <expected.iso8859-1
+test_format complex-body %b <expected.ISO8859-1
=20
 # Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
 # so unset i18n.commitEncoding to test encoding conversion
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index ee117e2..8a56756 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -22,6 +22,9 @@ commit_msg () {
 	fi
 }
=20
+# Tested non-UTF-8 encoding
+test_encoding=3D"ISO8859-1"
+
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
 	echo "1st file" >first &&
@@ -41,7 +44,7 @@ test_expect_success 'creating initial files and commi=
ts' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=3Diso8859-1" commit -a -m "$(commit_msg i=
so8859-1)" &&
+	git -c "i18n.commitEncoding=3D$test_encoding" commit -a -m "$(commit_=
msg $test_encoding)" &&
 	head5=3D$(git rev-parse --verify HEAD)
 '
 # git log --pretty=3Doneline # to see those SHA1 involved
@@ -64,10 +67,10 @@ test_expect_success 'reset --hard message' '
 	test_cmp .expected .actual
 '
=20
-test_expect_success 'reset --hard message (iso8859-1 logoutputencoding=
)' '
+test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding=
)' '
 	hex=3D$(git log -1 --format=3D"%h") &&
-	git -c "i18n.logOutputEncoding=3Diso8859-1" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg iso8859-1) > .expected &&
+	git -c "i18n.logOutputEncoding=3D$test_encoding" reset --hard > .actu=
al &&
+	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &&
 	test_cmp .expected .actual
 '
=20
@@ -331,7 +334,7 @@ test_expect_success 'redoing the last two commits s=
hould succeed' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=3Diso8859-1" commit -a -m "$(commit_msg i=
so8859-1)" &&
+	git -c "i18n.commitEncoding=3D$test_encoding" commit -a -m "$(commit_=
msg $test_encoding)" &&
 	check_changes $head5
 '
=20
--=20
1.9.2-15
