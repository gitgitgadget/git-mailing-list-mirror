Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CAAD2C
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460836; cv=none; b=ltsWQ4qVlN9KO6cilUublonMYFEaAxKLkHeTG8HmuxnXkgMWCLV1yGJt6LWyEdySSB8mZ5B2wAg3pkE/E5/JPB1+orKYt6648v2M5LUKkgMWRGv0wE7Tbf2BWG0LL3N/D9XcAew+A90R6DzThEJCLPfxEyQ1QT3mlytJWnwXNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460836; c=relaxed/simple;
	bh=J61+Zy6gVBjQi61CBhMyibG93fsTlznvmkd12KRexyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUqxJ3ToSYZ/w+yoLrwFSLp3tCvFUW1juDaFngMBDfhyd0C0xA7XcUzUikD+eslfmSvujgCluFsaQ8oGNlCyFEL9NB9edjoq5QNQp3NVj5bzZ3fbfPW0vUItb20H+18GpwvA/bYBk4fWZDnzymk30mSqNfl+87IT8HS+L0ixwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jRZEp+Bx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jRZEp+Bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709460830; x=1710065630; i=l.s.r@web.de;
	bh=J61+Zy6gVBjQi61CBhMyibG93fsTlznvmkd12KRexyI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=jRZEp+Bxle7h8ZXFDSylcWQa70S5jsXN7EpTsrR+naNeNRR+th6SFS4vmCAscnf+
	 OiagpG67ZbKWnTMtvuTEnrXAmJdoBcGjM4a9RslQl6B9+zFn/8+xeVJnK9i5an4pP
	 hbl6v+HyKw1aRHBPGb0ZiJO3NWwrQNo7Ahph9Syw73qmDvizUefafJghjs7NMSEkj
	 0I2VzbNEQ++nyhk11hL40UO6sc5UlrdmjQi+Kqbn5E2lSV5gVlluEQJHMEwnSFuP4
	 FZWu451196LhPfrc6o6uYWJLnA5n/QmpeO9YXSwPWbi6CeSe+vU/9feM8go5XIHxn
	 csF1NkbpwJ8JiyNmDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MGQC9-1rdje70opR-00GqBL; Sun, 03 Mar 2024 11:13:50 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/4] t-ctype: align output of i
Date: Sun,  3 Mar 2024 11:13:27 +0100
Message-ID: <20240303101330.20187-4-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101330.20187-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BAj8Rinc1pnGywWckW4fSq2wzWEePniF7swZeHHA9u1HCW/hIEB
 nxqkDxJOZgpeYIBuFuVkvkuNjdPz3MZzhAhE5Un/gn8l6QTsLxLL9/d8Z0AMox0XYy9zmhy
 jDU6b/PdCWLrRXqBR96x8/PuxOju7YjeSjTNl8HQiWk8QEgtwmzLxcTC16841LImF9oBb8F
 UDqyv7w/YcKZrXlSaJuNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u9egaJiJS2w=;MvKmTPvKmm8aSuo/wY5bH4BXnIe
 KLNnwtxViDooeols/p4iGFwDCx4x8+vrf11MQU/KgWWJYNUfxrfK4mv9Ynyk87r4YW1PSDbTM
 1eG7L9vg1nOwPCSu7nuPnE/jM+naKxdur/7udsEf+/7oA7G7pTX2eJztGPbxipHUAZuAtM8U/
 I0Qok3bg1bEHvBEaeqSSewxY2ndYhlCnoHVyRTMxiD1jGul8syrP3CAkndeZJNwswYRQOsCah
 ll308BXu576A78m4KA6/r6aI3XBlpBFMWbr3r+/7s+88dywgRJu7TNa4Ze+OAPcyC3nWvQe76
 xEWjZ5qQpVI37YHohB2uY4W+dqep9IFV1cJfDfPwWESoKVI/ZYNlTeuwdHCmcRHo1g0d5Fjvw
 jG+9NLSundmhwOxDQMuEb7jafwuyaS0xDKKSak/LDq2yQIbcgVFp4oJcatFndfrpl7U7oj6ay
 rNHld3DzJ5/IwaGTAMmCLVdApD/GG3SB84lxI71nnbg1wWTE2OqO7snDO+ETYW3lI+2of/7WA
 A8V1kQvXRhI+i9llp09ctgB/IkLagHCCH9j/YbRmrkB16qdEeA72IvgZE0hMAkN44750jpXCi
 BZK/MVQIYUyD32dpr3lGo/7qpGM0yar+9vspC4UHDgmYBvuYtH2k0MOXfiPf6llhgskfOBmQH
 aDius5RlSgbNoj4muecieUW/5Vyj+UcgXex6Vgq2OIkEfKcXnL2kZSgOS0nZiNbArd8arE9iC
 gjRNszM62GVB5ujJ/s2ES6DWOB47OmQKVRv8pWqFNmwG0R/WW+eR0pLyx10uejlQpGmvYYuy4
 1JA4uUWQBvV4ILQCHZBBvQ1b1vkz1e8I7HPAwkd2juV+Q=

The unit test reports misclassified characters like this:

   # check "isdigit(i) =3D=3D !!memchr("123456789", i, len)" failed at t/u=
nit-tests/t-ctype.c:36
   #    left: 1
   #   right: 0
   #        i: 0x30

Reduce the indent of i to put its colon directly below the ones in the
preceding lines for consistency.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index f0d61d6eb2..02d8569aa3 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -8,7 +8,7 @@ static void test_ctype_##func(void) { \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
 	for (int i =3D 0; i < 256; i++) { \
 		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
-			test_msg("       i: 0x%02x", i); \
+			test_msg("      i: 0x%02x", i); \
 	} \
 	check(!func(EOF)); \
 }
=2D-
2.44.0

