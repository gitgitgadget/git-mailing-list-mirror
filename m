From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 2/5] t4041, t4205, t6006, t7102: Don't hardcode tested encoding value
Date: Mon, 19 May 2014 19:28:17 +0400
Message-ID: <b7914b89c94560d61e2cd3369d6e1402710457ee.1400513063.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:29:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPUq-0004FR-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaESP24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 11:28:56 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:42784 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbaESP2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:28:54 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so4249714lab.10
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=P7xsw4hJpkvBTVVPWwxCkupL5lQfZ6ipMfjnci3arAM=;
        b=QY5F4DNMrCJiGUP0mJ0gL0NwRyxSQk4NLd/9JzbbkWDax3cpB8+5c39rmPlN+Sva9i
         AR/n+eYjOx3J4lBsPeVj3B3BY4yMUfD3+v3a89DNipO32FEszWtusXBMZJ4hgGMo8A0r
         m0qKyCn9ntVae9TKPOjDbxfmBe7mgXv89mfoY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=P7xsw4hJpkvBTVVPWwxCkupL5lQfZ6ipMfjnci3arAM=;
        b=GkB0kTcrrlMXrsvcpfjZp2P0NgChvFQeGmheMjdqtRC5zIqzXkOc0EIPP70+Dt5v4T
         0Fn1EX9qwMvhZUFY9LbiVaNXmnt3EkUhQT1gj7NgtGRQ+PzsBjxp1q277xDP0KJeAH5k
         mFejsS3axnpFmt9nLyoFCY8Yuzt5kUzxiVaKN3qoH06vDO5nvj1psfboZtHYrxH6Ce6t
         zVrkqWBYT4YeGa2lpKCH1yuKwITBkGd3r1Mvkw9y7rCeOkXIaH9jj6uLkDa7s9DRRz+g
         zH1tBSijd9OZ2gP6gc3avS6rydP0DhixPPS1BL4tSPUuSeX+Q9xmNGYCgCyE+yfBLHUm
         OlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P7xsw4hJpkvBTVVPWwxCkupL5lQfZ6ipMfjnci3arAM=;
        b=Fg1S/n97cos8sejSyAtdxiXmk4cb3w/N4EmKCF4TCUZ0nJytj4Eciw+DNO3N+eb/sX
         KlnRJwyDmhHU0oDMjp8c+E1aelpE6GoYH4WgmcE5mrj9P04Bi/WZUOzOc4M9wl0CsEh6
         gGKRIuhgpS8YWfofAUB/BqTwdV6Yv0OiEBe7j9HW7Q1AdMW439JP8Yr43xsI82mT/+yb
         NCLWkQuZqOiZsioOUsFn+rYpC+bL6Jyy2J5grYBP9vxYFvdoQwRxnGkW1mWwJHbdU8Lt
         uaIWx1Wf/3xHMXVFcn4X8jH53q9+fjc9CvKWHINKqYQlWiKgxsb4RT5Y+QoLoLUbT/Fc
         t5Ig==
X-Gm-Message-State: ALoCoQk+7lDLhvc9bxVoGY+qC+3APnCKbI0FOJk46Z2TQF5A+YRxee4Je0z5OOvj3ge+toB095W6
X-Received: by 10.152.87.228 with SMTP id bb4mr2280105lab.74.1400513333114;
        Mon, 19 May 2014 08:28:53 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id z1sm20122915lal.6.2014.05.19.08.28.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:28:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com> <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249586>

The tested encoding is always available in a variable. Use it instead o=
f
hardcoding. Also, to be in line with other tests use ISO8859-1
(uppercase) rather then iso8895-1.

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
