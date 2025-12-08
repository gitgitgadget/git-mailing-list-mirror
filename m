Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399925B311
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765234762; cv=none; b=bTUsA49VGXP3X0p9jmxfLGOx7TkMfMAjhWXVpgTzrme/DEktOSE3wnYiCxxbul52KJqdTjp2Nz9mfQ9C9YYMjAU9KZ94tbmEzbgwmakJHITiEknO4alPEwmFqw87tltoAqTYYkZghqcd6dkEWEpYoUYVQKKFeB7hdxTdiLPnWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765234762; c=relaxed/simple;
	bh=LbVBF0AsaAh7JJpQzcjk7gLI4AI/ZW9LU+3dX7ywOXE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VMuiyBZvIN6DeT1RS6bNoc389MZ5Bqc9nmgQcD6o39N9wWM56bToVHkGw9583Mi05oLRPGmAvFlhiildHmpjc5GY1ZdWgRIBqp1+VzmtdK2N7iYBIAu4u2OUafoyVE8Jjm25YMNVZRXoRrSt5bpnr0YIzY0hSrnSk6h03ypnfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JBukmGlY; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JBukmGlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765234752; x=1765839552; i=l.s.r@web.de;
	bh=59hlKF1/TJE6w7HKPxOMuQEZEeHVIuIwG3CiXnMAhyE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JBukmGlYjPWTOYQbKMZTp+IyFZvhhmbr1PQuX7toE2fbE1/7Qlc3O8QKbmt3Xm66
	 ua/So0G2fxRwTWFOOMRFsK4J+Ugyw3gImZ0bPKDvkruSnMxHbJIXcdsxq1l0qx9lr
	 pXEmEBVYWKXBC3qopXykejr+LJuYQsjcC/DKNXSXj6mOCkj2EypO+b4kBG7ukcf6j
	 0+yi9WsmnPY9uPTK/jZKrrsoOXFyltAiTXelyv2zayfHC5LxSIbKHCLqA5ggmc5Ty
	 sWfe8iW1zBkVy5LuFLx/zsWjIbmh1I9qUZ7Gzdm0CPubJ8U3t8Hb+fKqoVwW1m4vX
	 lc1Nd7fzURZjkD000A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1wFjzS0kXe-012oAV for
 <git@vger.kernel.org>; Mon, 08 Dec 2025 23:59:12 +0100
Message-ID: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Date: Mon, 8 Dec 2025 23:59:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: t3900 failure on macOS, iconv(3) broken?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRaSukoXa/BxvRWCcBXRaVCyV3wCsu36l38awGMCvNhzliJ2ils
 zgqyffuaOWtCm/3YymlmYVY6ERs20rQZ35ZT3oy83a25jZcXVvzgpjqpHHuoO45MFtR4A9U
 eBywU0nOBpRd1EoH3JPfec1/txxuF7JS7AUhYPx2m1nrj92DRDUFUrP1YMXBY/97phO+jVm
 JKg9n7TpmI7B+VoWdoGHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AJTj5rBq78g=;0GV0lCSFbacW64AgOLRWVS7sVP3
 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
 GvmMITZTfvGV4KtqM=

Hi all,

three tests of t3900 fail on macOS 26.1 for me:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

Here's the verbose output of the first one:

=2D---- snip! -----
expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
                compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.t=
xt

=2D-- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +=
0000
+++ current     2025-12-08 21:52:45.786161909 +0000
@@ -1,4 +1,4 @@
 =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5

 =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
-=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
+=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
#
#                       compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2=
-UTF-8.txt
#
1..17
=2D---- snap! -----

compare_with runs git show to display a commit message, which in this
case here was encoded using ISO-2022-JP and is supposed to be reencoded
to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
is from the original ISO-2022-JP representation.

That botched conversion is done by utf8.c::reencode_string_iconv().  It
calls iconv(3) to do the actual work, initially with an output buffer of
the same size as the input.  If the output needs more space the function
enlarges the buffer and calls iconv(3) again.

iconv(3) won't tell us how much space it needs, but it will report what
part it already managed to convert, so we can increase the buffer and
continue from there.  ISO-2022-JP has escape codes for switching between
character sets, so it's a stateful encoding.  I guess the iconv(3) on my
machine forgets the state at the end of part one and then messes up part
two.

I only noticed now because I used to compile with NO_ICONV for some
reason.

Is anyone else seeing this breakage as well?

Here's a patch that adds make variable ICONV_BREAKS.  It avoids the
breakage when enabled, by starting over again instead of continuing.

Ren=C3=A9


=2D--
 Makefile |  6 ++++++
 utf8.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 6fc322ff88..cf8a0d3ee9 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -181,6 +181,9 @@ include shared.mak
 # byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes i=
n
 # big-endian format.
 #
+# Define ICONV_BREAKS if your iconv implementation cannot reliably
+# break a string into valid substrings.
+#
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound. Define
 # ZLIB_NG if you want to use zlib-ng instead of zlib.
 #
@@ -1836,6 +1839,9 @@ endif
 ifdef ICONV_OMITS_BOM
 	BASIC_CFLAGS +=3D -DICONV_OMITS_BOM
 endif
+ifdef ICONV_BREAKS
+	BASIC_CFLAGS +=3D -DICONV_BREAKS
+endif
 ifdef NEEDS_LIBGEN
 	EXTLIBS +=3D -lgen
 endif
diff --git a/utf8.c b/utf8.c
index 35a0251939..ff0c541fbc 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			out =3D xrealloc(out, outalloc);
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
+#ifdef ICONV_BREAKS
+			/*
+			 * If iconv(3) messes up piecemeal conversions
+			 * then restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+			insz +=3D (char *)cp - in;
+			cp =3D (iconv_ibp)in;
+			outpos =3D out + bom_len;
+			outsz =3D outalloc - bom_len - 1;
+			iconv(conv, NULL, NULL, NULL, NULL);
+#endif
 		}
 		else {
 			*outpos =3D '\0';
=2D-=20
2.52.0

