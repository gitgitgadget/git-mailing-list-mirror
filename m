From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v5] diff --stat: tests for long filenames and big
 change counts
Date: Wed, 15 Feb 2012 09:33:46 -0800
Message-ID: <7vobt00znp.fsf@alter.siamese.dyndns.org>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
 <7vvcn810ml.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 18:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxijq-0002cT-VT
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 18:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab2BORdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 12:33:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab2BORdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 12:33:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DACB75A1;
	Wed, 15 Feb 2012 12:33:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uLAeR3U19aVM
	2J8Fw1xPvslBR0Q=; b=LlshzzuoPXvOMUitMHmY4AohlkdlKk7OSyz6z/d5GZK7
	qUiN6wr2GZMSfSgWTzgSpzyPOtA5X/kLxqLxgH4xQnGb48Vu3smLVywmbuhl2BuD
	6FFdFcc4aTueuxa5OiIrjs/7+xn/H3oJoqUs/GoXH1904n9l9HfM6Sgi31qmxH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mV9nn1
	W0tx094URl2oKCpt+WNChazSIK9bq2b8az9eVpWIQYAq4bSI7wA9h9j8aciXon+g
	rltiqbT2te9ykRFgr/h53nY8cJqXgU6dwrdrebbdSlTtALxb/oJ+tWnF01RSqGis
	UkWtLG/XRxvxGrUsI2k3SGX7ezieyhuknLEro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15A9175A0;
	Wed, 15 Feb 2012 12:33:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68645759E; Wed, 15 Feb 2012
 12:33:48 -0500 (EST)
In-Reply-To: <7vvcn810ml.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Feb 2012 09:12:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37EB2BEE-57FB-11E1-BF80-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190840>

Junio C Hamano <gitster@pobox.com> writes:

> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>
>> Eleven tests for various combinations of a long filename and/or big
>> change count and ways to specify widths for diff --stat.
>> ---
>
> Sign-off?=20
> ...
> The same comment as the previous one.  Because you change the allocat=
ion
> to the graph part in your patch to diff.c, which hasn't happened in [=
1/3]
> yet, this should expect the existing behaviour (narrower graph) in th=
is
> step, and then be updated to expect the output shown above in the [2/=
3]
> patch that changes the implementation in diff.c.

The previous review message in a patch form that can be squashed on top=
 of
this patch.

-- >8 --
Subject: [PATCH] (squash to the previous -- replace the log message wit=
h this)

diff --stat: tests for long filenames and big change counts

In preparation for updates to the "diff --stat" that updates the logic
to split the allotted columns into the name part and the graph part to
make the output more readable, add a handful of tests to document the
corner case behaviour in which long filenames and big changes are shown=
=2E

When a pathname is so long that it cannot fit on the column, the curren=
t
code truncates it to make sure that the graph part has enough room to s=
how
a meaningful graph.  If the actual change is small (e.g. only one line
changed), this results in the final output that is shorter than the wid=
th
we aim for.  A couple of new tests marked with test_expect_failure
demonstrate this bug.

---
 t/t4014-format-patch.sh |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f6ebb51..0376186 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -897,18 +897,18 @@ test_expect_success 'format patch ignores color.u=
i' '
 # 120 character name
 name=3Daaaaaaaaaa
 name=3D$name$name$name$name$name$name$name$name$name$name$name$name
-test_expect_success 'preparation' "
-	>\"$name\" &&
-	git add \"$name\" &&
+test_expect_success 'preparation' '
+	>"$name" &&
+	git add "$name" &&
 	git commit -m message &&
-	echo a >\"$name\" &&
-	git commit -m message \"$name\"
-"
+	echo a >"$name" &&
+	git commit -m message "$name"
+'
=20
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
 |    1 +
 EOF
-test_expect_success 'format patch graph width defaults to 80 columns' =
'
+test_expect_failure 'format patch graph width defaults to 80 columns' =
'
 	git format-patch --stat --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
@@ -917,13 +917,13 @@ test_expect_success 'format patch graph width def=
aults to 80 columns' '
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
 EOF
-test_expect_success 'format patch --stat=3Dwidth with long name' '
+test_expect_failure 'format patch --stat=3Dwidth with long name' '
 	git format-patch --stat=3D40 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_success 'format patch --stat-width=3Dwidth works with long=
 name' '
+test_expect_failure 'format patch --stat-width=3Dwidth works with long=
 name' '
 	git format-patch --stat-width=3D40 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
@@ -941,26 +941,21 @@ test_expect_success 'format patch --stat-name-wid=
th with long name' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'preparation' '
+test_expect_success 'preparation for big change tests' '
 	>abcd &&
 	git add abcd &&
 	git commit -m message &&
 	i=3D0 &&
-	while test $i -lt 1000; do
-		echo $i &&
-		i=3D$(($i + 1))
+	while test $i -lt 1000
+	do
+		echo $i && i=3D$(($i + 1))
 	done >abcd &&
 	git commit -m message abcd
 '
=20
 cat >expect <<'EOF'
- abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 EOF
-test_expect_success 'format patch graph part width is 40 columns' '
-	git format-patch --stat --stdout -1 >output &&
-	grep " | " output >actual &&
-	test_cmp expect actual
-'
=20
 test_expect_success 'format patch ignores COLUMNS' '
 	COLUMNS=3D200 git format-patch --stat --stdout -1 >output
@@ -984,7 +979,7 @@ test_expect_success 'format patch --stat-width=3Dwi=
dth with big change' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++
 EOF
 test_expect_success 'format patch --stat=3Dwidth with big change and l=
ong name' '
 	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
--=20
1.7.9.1.237.g00b59
