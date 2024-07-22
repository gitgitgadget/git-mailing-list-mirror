Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F11C6A8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680329; cv=none; b=jpxySfBDHKFNjKF5lghK1FRjsB5W9uGlGtFdFAcSAQAWPnsNa5+XJ/KooKTIsdXaKq7FvlhwVxQzDHTfPeb5aUvWq5Or7REOZV/xwC67PS2e40fTN/SL9LcRTd0SS9OLVbllv3d0q3rx2ukXJ0jCo0m6jTYwQ96+d8FZZyojC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680329; c=relaxed/simple;
	bh=HTCTkx4e1+huhOgGNZqbnCsObN+AjTN+nRCGkHxCSN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIJ7BOa/HmpNy4BZ3oLzqypl1HKCrXYYR1pJzIUzJqKsDn1ahUC+Te/4W1qhl+kqVZ3Ub3XDMGyw39DyukFsd19SCdVi65vlBS6+KDlunFfR4U268AZ4leH3WBA3hcujNsAl877HmeeX6lh/nxAOsTY/FDoFfVAFs6v5KjLgpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lTAgEok7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lTAgEok7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721680309; x=1722285109; i=l.s.r@web.de;
	bh=NbzmPLLBvX+ksp7Otv18Ci2vVsWdxRPRjGnunWCblEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lTAgEok76oMywHSXgRs2jXmbPrKstkk/jnE+Uw67B4h8KvUMEOttX3PNDx0AIAaO
	 FxMPrDTg/zTNiWPLCdTVe7NFuWPUXxFxzv4rhHSWkYZfLLlc+Mj9b/m1LalrS76xo
	 DCMqRXJN4K7btrBfVZgkrT6M9VZcKH/59BDqIixfTkyP1TlE/KRvrIKP6RMknnHgQ
	 pEXjiERetvYb/a7eR7DEwxkSOfyeBJ2OGmQ5ARkdeU7IoEJVaoM/bAK5eGjtzNdot
	 r04JKlrKZaAU/jWSphmcBus3yiD/TkrfCl5//BLpITrx2BFETYafS8ipZgkuiyu5w
	 7KrnPc49RlxUlw73gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1s0pra0dL1-00asbH; Mon, 22
 Jul 2024 22:31:49 +0200
Message-ID: <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
Date: Mon, 22 Jul 2024 22:31:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1q3lb4me.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JZDtuSr7X2VodTNn/5gEfAiepjKgUV+mBGWZOc69QqAvGOxuJJT
 0w9JZPF4py/3j1vbZY64XcUF7ozNnc5jKW6lGavrfGPpwVjiBfcLec7MJ+X9x38BSJihD2o
 1ENBf4D7HAN/RkeTiGdLgpTu/+Q7SmZZq6onzrI/PyOwopipFa04rp7o6OzLGVlhAgNm6Fq
 A8/UuIpc5C2XS8lfioIlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ABogRuEag7Y=;mzdv/aMW1ufkcfBGvI5HZI/VJ0/
 NUUVFxYOJqmJ+Nfojf3nbPSdJRnmBPvUrRjlS9mA4ZvpjpBQpG9aMI5N+/qhKyZ+Bfnnilaor
 RVV9oZWuEicUPJTGqMjd2fbQ/evoI9l5pv9z0PuKOU8kHK+kFHRForyPVbHJKhziblngUk/Cv
 /sZskJ/evoS4zIuc0Qm+kGaboSGVnVb9WBXIAlaYx9ysUmgcKjaZXeR7sepvUjJnSIwsTiXbk
 OpVxUZi+cvLrIe/Lvod0Ru+L9jti/XwLV0J2j3ATneQDKzMq9IJwwA/0iWFZDYwPjuye0AUX1
 IUbNGtXVSebBwfBjSxmj9cRNHbo+BuifSP/+LXJ9JB3dDiCGnYGXT5yzADUwnMMTs0iPxS1Dk
 tAw3nimC3xM+ytfOHBlf0KaWGjKn2Drb8jk1wAEVr+nYH0qN8zrk3F66WERpglMP45yQsH02z
 bXEH4W2GghCH6UJC2U7seFAymw0hw43ZI33tmAJnpad4roqnpY5gYDS9fU5N5vpyyHC9QxQ8J
 pGCRV5pg1/Up8T6YQosLeFt2sI7DsTR7Ye59wuComJU2QIv3q4yeAPRYBGfVp2syZPe36OUUg
 5yPs04sBpBHQF50C3WrkcfGzXz5KcmtBTD1/Cq2xsKWHHtp3wKWpDAb9SHURKS/vmxPiGOzd8
 lmOmbejrpeDnzyxE23o+uE8j9kiSTbz+w+H1MtaciVT5PZ4g2/tI1S3X1mi94hfVimyKA8/89
 DU7jj56vgMEeUhWNSCLkhhcHzJk2Fw7FJKnzcQQ7KmDYTBG4Ofo35Tmd+e8ltqPxt3TXlU1x+
 Fc/QgLYkyG3HvZ8STPSNAeew==

Am 22.07.24 um 21:36 schrieb Junio C Hamano:
> Kyle Lippincott <spectral@google.com> writes:
>
>>> +       for_test ("for_test passing test")
>>> +               check_int(1, =3D=3D, 1);
>>
>> I'm concerned that users will write this like:
>> +       for_test ("for_test passing test");
>> +               check_int(1, =3D=3D, 1);
>
> And that is exactly why we want the macro name to include C keyword
> for control structures.
>
>> And the issue won't be caught.
>
> You are right.  Making an empty body somehow catchable by the
> compiler would be a vast improvement.

That would be nice, but I have no idea how to do that without compiler
changes.  In the meantime the existing runtime checks will catch both
the empty test in the first line and the out-of-test check in the second
one and report them like this:

 # BUG: test has no checks at t/helper/test-example-tap.c:75
 not ok 1 - for_test passing test
 Assertion failed: (ctx.running), function test_assert, file test-lib.c, l=
ine 267.

File name and line in the second one are not as helpful as they could
be.  Here's a patch to improve that output.

=2D-- >8 ---
Subject: [PATCH] unit-tests: show location of checks outside of tests

Checks outside of tests are caught at runtime and reported like this:

 Assertion failed: (ctx.running), function test_assert, file test-lib.c, l=
ine 267.

The assert() call aborts the unit test and doesn't reveal the location
or even the type of the offending check, as test_assert() is called by
all of them.

Handle it like the opposite case, a test without any checks: Don't
abort, but report the location of the actual check, along with a message
explaining the situation.  The output for example above becomes:

 # BUG: check outside of test at t/helper/test-example-tap.c:75

... and the unit test program continues.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/test-lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 3c513ce59a..9977c81739 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -264,7 +264,11 @@ static void test_todo(void)

 int test_assert(const char *location, const char *check, int ok)
 {
-	assert(ctx.running);
+	if (!ctx.running) {
+		test_msg("BUG: check outside of test at %s",
+			 make_relative(location));
+		return 0;
+	}

 	if (ctx.result =3D=3D RESULT_SKIP) {
 		test_msg("skipping check '%s' at %s", check,
=2D-
2.45.2
