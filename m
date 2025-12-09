Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CD322B72
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298043; cv=none; b=kgRnGB7tDxRcoJdauMiU8sU/w+TbuE43rydZkZbITowKu4cCCXJ+JmpNu/13RpvST7ogkpXY5v8lEor+8jrw8QPG/JL3OLzMnSCNSzrk/5J2eIe9/Ly1pjgmr+rRdyBWsH2TBzY8utCiynAXieIJ3NQ9bP8n3h7x2uZJ4eN0hNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298043; c=relaxed/simple;
	bh=AYPs0jOnzWGGdTIVnoa06vLj2vKLy9pWLpfR4xgjClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2BG6Fqsr1bvA850e6tv7GYCeFjYK8pcpYu6zbbBjl6zruivjg622nbVbxOg3MAj/yDuoWyGxQYE3IidDyATuoizcjwdq4TA/SXHkPYUbzs3wGsAldKiVvevGxY4yfrcocGbJ1/OFwV8x7pZ0QGh7I1Xnc8byIcM/YbYDwQe7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=mnBnXoQn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="mnBnXoQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765298039; x=1765902839; i=tboegi@web.de;
	bh=slfwkKmhKRQs/+9eCL8kZpa+yIkA/BBA1VhTe32Mg8M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mnBnXoQnSBu/DylHxbDFzwHx/m0aY2HGUGMHW8Xsx1J29vNn7EkXQh231C1i0GU9
	 BDRmAHJpBMk45SAWN+ABDBDfhHNNRmYN2mmQEs0kiNRsuEQaLMxnmxksxZjtEBwZQ
	 hB0IlaXuvCsw4mvg144CPry0JV9HgDehCNUzoRfenETLx/DuCh7+cniDN3R+55845
	 nfJ8AGCi2g5hr/WjbYBc3NZkQTwtrHsiolrFCgsiQHuoa5hl1lqr/0iLJkj+lRHEs
	 aw6i9f9C+/iROxQmGQ80iQRqFdsRjVZf9lZ8TesnGpstI6YNPwjHLE3rrIQ/R0jCQ
	 a4Lc8UFzc8PJ2uX4gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidHP-1vzsdF3lSh-00ioZ7; Tue, 09
 Dec 2025 17:33:58 +0100
Date: Tue, 9 Dec 2025 17:33:57 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: t3900 failure on macOS, iconv(3) broken?
Message-ID: <20251209163356.GA5762@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:xgSLZ4Vx7iLXSGGh2TgqjgZ84/HtrpUyV4yXsgLMrlB7ZNCtlNH
 VRZgrTJRx8lfahAxQkEBfEf5gBeYLLSF0E8NCZd3UHxoWq7sRcb4iFmVqRjfYX075OEE0Hd
 QYlsP9BqCN/hHr8dHEVuNHD/dVBknR1jtA+SEQbrQTJEn3WpCWdN2KEs/+F9mUEyHZ8Nyi8
 R8PzaqAxWjFXf9vmYY8sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KkcIwGvluHI=;YyPOTwEUy7HExQYsAHohPQPQcTy
 +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
 AEFBV0ChXd5ZJCzu/Wi4gRkoIFyFgWpKgNEEyM

On Mon, Dec 08, 2025 at 11:59:11PM +0100, Ren=C3=A9 Scharfe wrote:
> Hi all,
>=20
> three tests of t3900 fail on macOS 26.1 for me:
>=20
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>=20
> Here's the verbose output of the first one:
>=20
> ----- snip! -----
> expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
>                 compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8=
.txt
>=20
> --- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +=
0000
> +++ current     2025-12-08 21:52:45.786161909 +0000
> @@ -1,4 +1,4 @@
>  =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5
>=20
>  =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=
=84=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
> -=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=
=8C=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
> +=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=
=8C=E3=81=BE=E3=81=B3$0$j$m$X!#
> not ok 17 - ISO-2022-JP should be shown in UTF-8 now
> #
> #                       compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900=
/2-UTF-8.txt
> #
> 1..17
> ----- snap! -----
>=20
> compare_with runs git show to display a commit message, which in this
> case here was encoded using ISO-2022-JP and is supposed to be reencoded
> to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
> is from the original ISO-2022-JP representation.
>=20
> That botched conversion is done by utf8.c::reencode_string_iconv().  It
> calls iconv(3) to do the actual work, initially with an output buffer of
> the same size as the input.  If the output needs more space the function
> enlarges the buffer and calls iconv(3) again.
>=20
> iconv(3) won't tell us how much space it needs, but it will report what
> part it already managed to convert, so we can increase the buffer and
> continue from there.  ISO-2022-JP has escape codes for switching between
> character sets, so it's a stateful encoding.  I guess the iconv(3) on my
> machine forgets the state at the end of part one and then messes up part
> two.
>=20
> I only noticed now because I used to compile with NO_ICONV for some
> reason.
>=20
> Is anyone else seeing this breakage as well?
>=20
> Here's a patch that adds make variable ICONV_BREAKS.  It avoids the
> breakage when enabled, by starting over again instead of continuing.
>=20
> Ren=C3=A9
>=20
>=20
> ---
>  Makefile |  6 ++++++
>  utf8.c   | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 6fc322ff88..cf8a0d3ee9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -181,6 +181,9 @@ include shared.mak
>  # byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes=
 in
>  # big-endian format.
>  #
> +# Define ICONV_BREAKS if your iconv implementation cannot reliably
> +# break a string into valid substrings.
> +#
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound. Defi=
ne
>  # ZLIB_NG if you want to use zlib-ng instead of zlib.
>  #
> @@ -1836,6 +1839,9 @@ endif
>  ifdef ICONV_OMITS_BOM
>  	BASIC_CFLAGS +=3D -DICONV_OMITS_BOM
>  endif
> +ifdef ICONV_BREAKS
> +	BASIC_CFLAGS +=3D -DICONV_BREAKS
> +endif
>  ifdef NEEDS_LIBGEN
>  	EXTLIBS +=3D -lgen
>  endif
> diff --git a/utf8.c b/utf8.c
> index 35a0251939..ff0c541fbc 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t =
insz, iconv_t conv,
>  			out =3D xrealloc(out, outalloc);
>  			outpos =3D out + sofar;
>  			outsz =3D outalloc - sofar - 1;
> +#ifdef ICONV_BREAKS
> +			/*
> +			 * If iconv(3) messes up piecemeal conversions
> +			 * then restore the original pointers, sizes,
> +			 * and converter state, then retry converting
> +			 * the full string using the reallocated buffer.
> +			 */
> +			insz +=3D (char *)cp - in;
> +			cp =3D (iconv_ibp)in;
> +			outpos =3D out + bom_len;
> +			outsz =3D outalloc - bom_len - 1;
> +			iconv(conv, NULL, NULL, NULL, NULL);
> +#endif
>  		}
>  		else {
>  			*outpos =3D '\0';


I am not sure, if I understand the second call to iconv(NULL....)
Here is a slightly different patch.
Comments wellcome.


diff --git a/utf8.c b/utf8.c
index 35a0251939..b3c1dd2b59 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -486,10 +486,11 @@ int utf8_fprintf(FILE *stream, const char *format, .=
..)
 char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,
 			    size_t bom_len, size_t *outsz_p)
 {
-	size_t outsz, outalloc;
+	size_t outsz, outalloc, originsz;
 	char *out, *outpos;
 	iconv_ibp cp;
=20
+	originsz =3D insz;
 	outsz =3D insz;
 	outalloc =3D st_add(outsz, 1 + bom_len); /* for terminating NUL */
 	out =3D xmalloc(outalloc);
@@ -515,6 +516,17 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			out =3D xrealloc(out, outalloc);
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
+#ifdef __APPLE__
+			/*
+			 * Several version of iconv(3) mess up piecemeal conversions.
+			 * Restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+                        insz =3D originsz;
+                        outpos =3D out + bom_len;
+                        cp =3D (iconv_ibp)in;
+#endif
 		}
 		else {
 			*outpos =3D '\0';
