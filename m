Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8AEBE5D
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460840; cv=none; b=K6KB/7gz7ihdEfx6jwp/3PuFtFSkoR2QRhLppJn1qXC98jIGXNF6xFYvZ1MPP2MYahgof5VP1/kg4oSZ2OKAva9AU0LzvXa0O0bFdCSUZYeJ+CyEz62j1xAk63/iSb0L5pIYTsmck8t13mnA53ZHIwsJqzmN23sna1yVWyy7Mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460840; c=relaxed/simple;
	bh=mxx2sKX5RuUJG7aT9mXPofT7um1SRgWmcUa5kyis5RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy1m3vWXYrq5vu5WMH4EOFs/r/tr3PoCEnsVZYM2nhhC7mJU6we/LtaLYtiiUi9I8+f4twjPci6/b9ymSHAqbXh334LMr/s4Xa+hakUVIwlkA7KvzxHHpWSC3dfhZv9x1/qO/04ieUkEK+gLVQH4LyUKr/mgtONsqrdyc24PFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=k0YfchHU; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="k0YfchHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709460829; x=1710065629; i=l.s.r@web.de;
	bh=mxx2sKX5RuUJG7aT9mXPofT7um1SRgWmcUa5kyis5RE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=k0YfchHU3njFGaPHpUpMAo7iOsc7IBq8B2Nxdu71MrDnSQPGTbrEdM8P7B6KrsdK
	 UCdbteJqas+4Xy7xKsKHRdDOQt9TlzM0zPHe75rmevyjUKrBPGL5yyzvbgVsAICvV
	 JzV6VrT+LgMXCYXf7MrtqGwpVoLpGhdv+kbkMpt0QWiDqYZWP4oBn8NcChnaN4I2h
	 MJJ2A42+b90Y++A4TIbHNYMZQ5QvTG5FPHjOtd3IbU/LFQjzPy9+yiRbM2w20Rbm4
	 I98pJzCPyPzSMZMsNMgCma8T+hFBJ+EHUtos4yVlzIYCJwIcvdY5VRKOZsBNMPEzM
	 MsBNJCV0/y1sa1I1dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mpl0r-1r4fwW2TDp-00qB03; Sun, 03 Mar 2024 11:13:49 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/4] t-ctype: simplify unit test definitions
Date: Sun,  3 Mar 2024 11:13:24 +0100
Message-ID: <20240303101330.20187-1-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225112722.89221-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qNtq2KOxB6luFOaFeJhhTApqvE2BmJVKPdXvrB7bW81V/8fHGGo
 fv+XhetRmegVQn4CNd2Q8y8Cmy12Ut6uajMNzfhGfzDdPD7YU1fEZiLwoB8/n6b2xZuaZOm
 5T990uCd2h78vcnsZTRDziB/zSNq3p+FL5vN6gRfZS9F0VW4tghkXOZkdnnkK6P6mnUWqb8
 dndmYYYvONgPu84+UyOeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:me6yxUD8XUg=;XsDEFSIjFjNtXn02Q5otPC9jIYJ
 AHBFaGxTIAJgPn3oPSjWbAW0FMVG9AuT+icy2WWvBWkjBKbO16+XWP+86uKSOVnz7Ig5c1FXl
 W+Ygq5aNEP+5IZdiiG4KO9lCDGAIoNlz5XkwZhZIUd/c+0Drt9B3wdnaWtvAGKlgopLH+uzoT
 jHNhXspz+p4xnZcM9zhaVn+S/qcxNG2divnlxrZNKARaGWvcisKVM0Zf9f5edzR33zwBDAx2G
 CFyRMrv//dZsiGMmbmaioNSyXI44NMk8TyOH3qB5iHFBbjVN9EIr5QUjQ//M48rQ1tFam8Kt3
 ixDbjk4V48CYQnDIkeXskSLiuOXh51l06bvh5c0d/nk0vjL9T4CtndYSngnHuTeOqvFf0Kx0+
 MIRK8y0AmkkPrIbJwCc4zkcuaxnOFVX++WcWRbyFsKOQRjqbkzX3lYx82Ozml47ysAf1PSH0d
 QtOZ4AfCh8VDtSF4YFjzfm93Powul1NIb18MT5H7Zxb73X/Un4Nho23m/gQFmekpVfAcKtBIw
 9WbmPcaWckUuPgM69tCszFxIYiFLBggcREIDVde+JJZt04aIr5j0oSE5/zX0q2O0gCe8wHNDz
 r/3xNWYmcOBALnB3gnL3DvgfWU1hM2rG1iuq5f2/RWRCM/Pxvf8+OCyVqms0J7pT0u8yDXJzK
 4Ke7ckggFoBJVN1XLH1VuM7hYhvr/YPTF8hV9ymPC32TdF46QVj9u7UxJVRRt9RJP1gXCofeP
 c+AkfED0S9mERmlVwwbDqR5Yj8LrBSKzTTd1NMtlLNwbIA3Gmd1DWySs5DPwcpidSLlHLkctt
 MVVf4mTPOEGXBCp++J1bgGw1Cx1dwE2WSbMbzrkpF9ONg=

Simplify the ctype unit tests to allow combining specification strings
in any order and no longer require repeating class names.

Changes since v1:
* Added checks to guard string length calculation using sizeof.
* Kept the definition string in the error output.
* Added patches 2 and 3 with further cosmetic changes.
* Dropped the last patch with the huge output for now, as it needs
  further thought.

  t-ctype: allow NUL anywhere in the specification string
  t-ctype: simplify EOF check
  t-ctype: align output of i
  t-ctype: avoid duplicating class names

 t/unit-tests/t-ctype.c | 81 ++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

Range-Diff gegen v1:
1:  ae9b5468db ! 1:  28fba8bda9 t-ctype: allow NUL anywhere in the specifi=
cation string
    @@ Commit message
         if we ever want to support more character classes that contain it=
.

         Getting the string size using sizeof only works in a macro and wi=
th a
    -    string constant, but that's exactly what we have and I don't see =
it
    -    changing anytime soon.
    +    string constant.  Use ARRAY_SIZE and compile-time checks to make =
sure we
    +    are not passed a string pointer.

      ## t/unit-tests/t-ctype.c ##
     @@
    @@ t/unit-tests/t-ctype.c
      /* Macro to test a character type */
      #define TEST_CTYPE_FUNC(func, string) \
      static void test_ctype_##func(void) { \
    ++	size_t len =3D ARRAY_SIZE(string) - 1 + \
    ++		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
    ++		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
      	for (int i =3D 0; i < 256; i++) { \
     -		if (!check_int(func(i), =3D=3D, is_in(string, i))) \
    -+		int expect =3D !!memchr(string, i, sizeof(string) - 1); \
    -+		if (!check_int(func(i), =3D=3D, expect)) \
    ++		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
      			test_msg("       i: 0x%02x", i); \
      	} \
      	if (!check(!func(EOF))) \
-:  ---------- > 2:  1eab0d289c t-ctype: simplify EOF check
-:  ---------- > 3:  901312e980 t-ctype: align output of i
2:  688e6b6cb5 ! 4:  5dac51cfeb t-ctype: avoid duplicating class names
    @@ t/unit-tests/t-ctype.c
     -/* Macro to test a character type */
     -#define TEST_CTYPE_FUNC(func, string) \
     -static void test_ctype_##func(void) { \
    --	for (int i =3D 0; i < 256; i++) { \
    --		int expect =3D !!memchr(string, i, sizeof(string) - 1); \
    --		if (!check_int(func(i), =3D=3D, expect)) \
    --			test_msg("       i: 0x%02x", i); \
    --	} \
    --	if (!check(!func(EOF))) \
     +#define TEST_CHAR_CLASS(class, string) do { \
    + 	size_t len =3D ARRAY_SIZE(string) - 1 + \
    + 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
    + 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
    +-	for (int i =3D 0; i < 256; i++) { \
    +-		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
    +-			test_msg("      i: 0x%02x", i); \
     +	int skip =3D test__run_begin(); \
     +	if (!skip) { \
     +		for (int i =3D 0; i < 256; i++) { \
    -+			int expect =3D !!memchr(string, i, sizeof(string) - 1); \
    -+			if (!check_int(class(i), =3D=3D, expect)) \
    -+				test_msg("       i: 0x%02x", i); \
    ++			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
    ++				test_msg("      i: 0x%02x", i); \
     +		} \
    -+		if (!check(!class(EOF))) \
    - 			test_msg("      i: 0x%02x (EOF)", EOF); \
    ++		check(!class(EOF)); \
    + 	} \
    +-	check(!func(EOF)); \
     -}
     -
     -#define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " w=
orks")
    -+	} \
     +	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
     +} while (0)

3:  caf2acbd09 < -:  ---------- t-ctype: do one test per class and char
=2D-
2.44.0

