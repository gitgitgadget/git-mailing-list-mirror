Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4684158DD4
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832507; cv=none; b=qX394QmKCBtdsYWvdwDDLedQVcplI7zPxH9F6q4mlk17uRTJ2rnZHxUoV4FdVpcnZoCDg0fy5GkzZFuQ84fDtoI7GytoNDuHc6uFXosSxNGVvV8dIZe9JTg+ditODqCcmS7ElSymvvkjtHWqwh+SRKdVffgoNp2U7BBZTcgUD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832507; c=relaxed/simple;
	bh=2T39HwW7jfB7FH9RsOEa+35qVN26kLZrugEeuUFgE9M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GkYlxk4ueuTRvNdhr/sv2bBBz+kKfBm8Bj0F0r1MQ/4nikfIY4X5vhy1dr2CS/CSzpKVwtIyeN5NyKUUVzVNqqts7HrZNLwD3zayaElmTyf7qcL9DEP+eSHqX7+Bt3Aj6pPUeYEfXQ8nEAT8cyp3qxSu52eLzY4tNCHN7Mkags4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BsRJwM1R; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BsRJwM1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832482; x=1722437282; i=l.s.r@web.de;
	bh=gy99trdlEczpdYT3QX9KpWaeR5GNVGtne8HIXDLrJRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BsRJwM1RTgEc0bNVJPuPUa1f1yr0ZZZwUBWwALaDY1IfT91yEKdJKqKQwl+3nwAD
	 iZciqh+88/Nf074+ad98v+tQlDezmCNtI92ORZVk6FvbRa16GZLqJxbvhIiT+tQqx
	 HM4kVWZQwEU82fgEeTNb35b7EQGgJrdzVtkOQv7olxKcDjd2j8QtDxs2wENTKzzUc
	 0tNlG7Yt1Hiqnpn1fI0B3u86festOSwL7Is5nRgcjwuo1E/TbehRiuAvvdDfuQVlz
	 +k57Xd6y4Loy4fL5srsfqy7Sr4mOfRXCIHs0TSbsTwwWE2zeal4+ugwGwZ/ukaG5U
	 Le/rrVl463AJPstS1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1rpu4M3K1k-00nzaO; Wed, 24
 Jul 2024 16:48:02 +0200
Message-ID: <33073397-cd86-49ea-a5fd-d045dc98725a@web.de>
Date: Wed, 24 Jul 2024 16:48:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/7] t0080: use here-doc test body
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0YTPFxrjaj/aKBsGERI884w2UulDlS7jhSFevG4aIitj3IyiVvV
 KmzQVSIxl9l/yEOWsSQHx3Od3iQkI3RVk+91KbPmfsGSYVbPEfUbumOXAiDL6EPdQVXOb/P
 QOdSkMks892ac7MQJOY/x5h6TQBWu+EdtNjuUopWVjQQ+nRmLCtRSz6622dddvfq1VIHPOs
 r3zwz1M9/zUetWuRc0glw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ikcasEc5nTY=;LcpBB3L7zqDb8HCm0M1pJHLXvjV
 sx62+/eccFhstNn/HqG3gQ9/4FgUiRJNsD2ypZNPcJIwatcLDjXDnFOA3JJ3hfGlzAwIBdv1Z
 bay1Z58PSl9ZBjgVuIcw5X/ziS2gUu53gG9NpWMzdBAmBFaWRO8Layfs//iM6oY7AGQ6GG+5a
 FPsnZOtNpUCDGCqerX7UgmIZ69b0FGzxBtApnOFJ7kN9Ii/kLdQrDYKZOJFkrbe2pizKPIbRE
 FiBmHWaId+GKj9ztYajBHbtSicla6NIQePMWGMPpc0hs5tpoyJ8XclED36j1z85/Nxt0Xru6r
 VzGHUjc0lRHaFXCjOEhVzLqWjUU+ZOrFn4zuau2IpnSLMAjuHiSHkEALIldrAzOBEPT0SQ6AL
 1M1hCUwgi0DQmDEd64Fjl6XPuMxLyYP5rW7q13Pk0pvXm1JL+Vie8xkzzWIb/wRu/1yds/bDp
 RQtOhUsXEF5SPHgPPL7fgwS9H2zCvxx0VjhQVKKhnuiY407mpfbVsMKxOS+n7MJQYz08dqJC/
 MYfD+1UICEhABljeT9fEh8tLvLeqFJGScVyu2fk4+o2DPKoh3uxAP7qS2Y4SQePqBw5w78VJw
 LpercAZfmXy0S9vZ2WeLzQx+uX0cnXxWf8V06ohi6Ho6PlrFPUazKvj6AV2nc9hmzyxo1oPTr
 DCwKEAvICd2PUOmz0lN9svj0JAal9wQ+mV8M5crQk1CK+rydKPUJjBmGHssc8z0Emdomark+z
 XcZZmDTG2+rBJDQBQW8SXAZh4NMbPI0jVn9CI16kt/kbw1o27wLtLISAKbTaVtRs7jyCzvJkK
 /Xmy/L/uYFSDq4x1/EhIymKQ==

Improve the readability of the expected output by using a here-doc for
the test body and replacing the unwieldy ${SQ} references with literal
single quotes.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t0080-unit-test-output.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 7bbb065d58..9ec47b7360 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -5,7 +5,7 @@ test_description=3D'Test the output of the unit test frame=
work'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

-test_expect_success 'TAP output from unit tests' '
+test_expect_success 'TAP output from unit tests' - <<\EOT
 	cat >expect <<-EOF &&
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
@@ -16,12 +16,12 @@ test_expect_success 'TAP output from unit tests' '
 	ok 4 - failing test and assertion return 0
 	not ok 5 - passing TEST_TODO() # TODO
 	ok 6 - passing TEST_TODO() returns 1
-	# todo check ${SQ}check(x)${SQ} succeeded at t/helper/test-example-tap.c=
:26
+	# todo check 'check(x)' succeeded at t/helper/test-example-tap.c:26
 	not ok 7 - failing TEST_TODO()
 	ok 8 - failing TEST_TODO() returns 0
 	# check "0" failed at t/helper/test-example-tap.c:31
 	# skipping test - missing prerequisite
-	# skipping check ${SQ}1${SQ} at t/helper/test-example-tap.c:33
+	# skipping check '1' at t/helper/test-example-tap.c:33
 	ok 9 - test_skip() # SKIP
 	ok 10 - skipped test returns 1
 	# skipping test - missing prerequisite
@@ -39,12 +39,12 @@ test_expect_success 'TAP output from unit tests' '
 	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
 	#    left: "NULL"
 	#   right: NULL
-	# check "${SQ}a${SQ} =3D=3D ${SQ}\n${SQ}" failed at t/helper/test-exampl=
e-tap.c:64
-	#    left: ${SQ}a${SQ}
-	#   right: ${SQ}\012${SQ}
-	# check "${SQ}\\\\${SQ} =3D=3D ${SQ}\\${SQ}${SQ}" failed at t/helper/tes=
t-example-tap.c:65
-	#    left: ${SQ}\\\\${SQ}
-	#   right: ${SQ}\\${SQ}${SQ}
+	# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:64
+	#    left: 'a'
+	#   right: '\012'
+	# check "'\\\\' =3D=3D '\\''" failed at t/helper/test-example-tap.c:65
+	#    left: '\\\\'
+	#   right: '\\''
 	not ok 17 - messages from failing string and char comparison
 	# BUG: test has no checks at t/helper/test-example-tap.c:92
 	not ok 18 - test with no checks
@@ -54,6 +54,6 @@ test_expect_success 'TAP output from unit tests' '

 	! test-tool example-tap >actual &&
 	test_cmp expect actual
-'
+EOT

 test_done
=2D-
2.45.2
