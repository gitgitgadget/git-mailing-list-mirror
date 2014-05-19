From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 4/5] t4205, t6006: Add failing tests for the case when i18n.logOutputEncoding is set
Date: Mon, 19 May 2014 19:28:19 +0400
Message-ID: <1ab6aabaf34ecbb0fa6ded22d48e9f939a9d2176.1400513063.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPV1-0004b3-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbaESP3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 11:29:05 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47022 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaESP3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:29:03 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so4122295lbi.23
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IBGIh4q/sFU2x+ZXv5lO8Rzy8vUkEwEHRt+rZ7G/F9c=;
        b=S8DgwOEvsVCwUOv3nTRmK4xppisAM90jcKSipxLdxyrCY98bD8NMzo2fKohV0s8CaH
         wfYWq+bRZ3AxN5HEfXahh5gsXe2B8f/NZKZszprIvO8YORiASaEXZm2V0y+cIN4FZvyw
         Du6SGDUZA9EwBzca9vFjeRwCYTXF7PchHK3eI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IBGIh4q/sFU2x+ZXv5lO8Rzy8vUkEwEHRt+rZ7G/F9c=;
        b=a9tfEA+11Y2UMnFMHKxpJxLROH2hJbLkWFex1IXRzFgZ4339KbAQjs/kPxEn6ewy1I
         w16UgP7GCSurqibkUv450egvnCUOF59qTUJvITR31dkT8qJuXPkF0uC57Cyf4ShYvHLi
         uj7Qk0SauHCStz4YIbtR976j9uQ46kaLZSGN4QlZ4OBE6rMBVbhAbG152ITcPm66d2L6
         qz46CwQSRIpg48/QAzNcgNl2V6aqpH5xb25Zhw4z+lJo2/IGcDx7fKyefHy0l0UOFAHZ
         XbkOK0FJlv8sXKKvohUV9QJJpO3sA1j2MgHuiF6/6LTqWn2GB9ba4yq4GQ5hSnlO5wWp
         7BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IBGIh4q/sFU2x+ZXv5lO8Rzy8vUkEwEHRt+rZ7G/F9c=;
        b=auQc1NE6o/bqpiKO+IzMT4qosFDXggq/Vteahf6jBUsd2Wg0KqgEat+CZ1ay/D33tg
         WYEZI6UMiTLF97dKD6RlRVuetPBZrhhUrRQpbB5hsHlLtUr19eptTzUaoRvBYCTxvsJE
         r40LK4501B/+VxtuwipLQFM2v3nPErvgkbqR3/3rbWX7/MBGsWiMlqsKYFpq2Gwddbo3
         I88TTa2imVIfGzjnfAhNInMKCDrhz0DYstEFnUp6NgsBBUxP3T4WHOOegGYO4ezvIoJK
         5FnKThWAA3MtHsyjyvnBrUQIL1NrvwS+vuOl46Xpv69Pt5cCApX98m6xxVu73wD9lpUN
         8jnw==
X-Gm-Message-State: ALoCoQlEJTT8VsS262z1KWQhgpT0sYzbJgOXFltpUQg6R1gOIScQ9JuHQQqS5g+Q2YDy72ZprHAy
X-Received: by 10.152.29.133 with SMTP id k5mr17262677lah.44.1400513340896;
        Mon, 19 May 2014 08:29:00 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id bg4sm18035133lbb.6.2014.05.19.08.28.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:29:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com> <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249589>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

There were no breakages as far as were no tests for the case
when both a commit message and logOutputEncoding are not UTF-8.

Add failing tests for that which will be fixed in the next patch.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
 t/t4205-log-pretty-formats.sh | 140 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t6006-rev-list-format.sh    |  75 +++++++++++++++++++++-
 2 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index c03a65e..74babce 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -154,6 +154,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting. i18n.logOutputEncoding=
' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two                            Z
+message one                            Z
+add bar                                Z
+$(commit_msg)                    Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -165,6 +176,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting at the nth column. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %<|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 $(commit_msg)            Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%<(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -176,6 +198,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting with no padding. i18n.l=
ogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty=3D"tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -187,6 +220,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message ..
+message ..
+add bar  Z
+initial...
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty=3D"tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -198,6 +242,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,ltrunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+..sage two
+..sage one
+add bar  Z
+..${sample_utf8_part}lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty=3D"tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -209,6 +264,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,mtrunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+mess.. two
+mess.. one
+add bar  Z
+init..lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty=3D"tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -220,6 +286,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting. i18n.logOutputEncodin=
g' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%>(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+Z                            message two
+Z                            message one
+Z                                add bar
+Z                    $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -231,6 +308,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting at the nth column. i18=
n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %>|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4              $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -242,6 +330,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting with no padding. i18n.=
logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%>(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting' '
 	git log --pretty=3D"tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -253,6 +352,16 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting. i18n.logOutputEncodi=
ng' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%><(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+Z             message two              Z
+Z             message one              Z
+Z               add bar                Z
+Z         $(commit_msg)          Z
+EOF
+	test_cmp expected actual
+'
 test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -264,6 +373,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting at the nth column. i1=
8n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %><|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4       $(commit_msg)      Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%><(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -278,6 +398,16 @@ EOF
 # save HEAD's SHA-1 digest (with no abbreviations) to use it below
 # as far as the next test amends HEAD
 old_head1=3D$(git rev-parse --verify HEAD~0)
+test_expect_success 'center alignment formatting with no padding. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%><(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
=20
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &=
&
@@ -290,6 +420,16 @@ initial...   A U Thor
 EOF
 	test_cmp expected actual
 '
+test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+short long  long long
+message ..   A U Thor
+add bar      A U Thor
+initial...   A U Thor
+EOF
+	test_cmp expected actual
+'
=20
 # get new digests (with no abbreviations)
 head1=3D$(git rev-parse --verify HEAD~0) &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9e4ba62..a932f34 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -15,12 +15,22 @@ test_encoding=3D"ISO8859-1"
 # String "added" in German
 # (translated with Google Translate),
 # encoded in UTF-8, used as a commit log message below.
-added=3D$(printf "added (hinzugef\303\274gt) foo")
+added_utf8_part=3D$(printf "\303\274")
+added_utf8_part_iso88591=3D$(echo "$added_utf8_part" | iconv -f utf-8 =
-t $test_encoding)
+added=3D$(printf "added (hinzugef${added_utf8_part}gt) foo")
 added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t $test_encoding)
 # same but "changed"
-changed=3D$(printf "changed (ge\303\244ndert) foo")
+changed_utf8_part=3D$(printf "\303\244")
+changed_utf8_part_iso88591=3D$(echo "$changed_utf8_part" | iconv -f ut=
f-8 -t $test_encoding)
+changed=3D$(printf "changed (ge${changed_utf8_part}ndert) foo")
 changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t $test_encodin=
g)
=20
+# Count of char to truncate
+# Number is chosen so, that non-ACSII characters
+# (see $added_utf8_part and $changed_utf8_part)
+# fall into truncated parts of appropriate words both from left and ri=
ght
+truncate_count=3D20
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
@@ -139,6 +149,13 @@ commit $head1
 $added
 EOF
=20
+test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
 test_format body %b <<EOF
 commit $head2
 commit $head1
@@ -242,6 +259,33 @@ commit $head1
 $added_iso88591
 EOF
=20
+test_format complex-subject-trunc %<($truncate_count,trunc)%s failure =
<<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part_iso88591}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part_iso88591}gt..
+EOF
+
+test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s failur=
e <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part_iso88591}gt) foo
+EOF
+
+test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s failur=
e <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part_iso88591}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part_iso88591}gt) foo
+EOF
+
 test_expect_success 'prepare expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
@@ -270,6 +314,33 @@ commit $head1
 $added
 EOF
=20
+test_format complex-subject-commitencoding-unset-trunc %<($truncate_co=
unt,trunc)%s <<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
+test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_c=
ount,mtrunc)%s <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part}gt) foo
+EOF
+
+test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_c=
ount,ltrunc)%s <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part}gt) foo
+EOF
+
 test_format complex-body-commitencoding-unset %b <expected.utf-8
=20
 test_expect_success '%x00 shows NUL' '
--=20
1.9.2-15
