Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77426980F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765308938; cv=none; b=al/iE0sO1muH8qbNIZtKlvp2EDDAeSDqwjy1kbx/DLyHyvnRhk3LfCzHFLd/nAr4+hWzdbNEsmQK/EiwA/DSqxEyBe4UcVRmkhGF9PoIYg1umJmZYWNQM/qDijI+82qIgx6KoNoN6hq871u13QpK7TBHYXlBZYnjlHvfYOwsgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765308938; c=relaxed/simple;
	bh=JTd1JPA387QfoEAGorR+ywgeFfiD37Bd5ayJsobyI78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvtdZ+YaIzl9mCJKO8ZIk2Lw+gki0n6IWhfJF4+ww4MvPW7BiBEg0nyaXrkB5YjHMhsSDB1nUnAngBp/hqI5ARHjrcy7ebwgbJ0CTM4SpgT4YPQvmbLLH0ZqdcF8CeMw7+kEl8Ea8UtV/o94agwoyUGTJxwsB6JEL/M1T/qzk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WP6ai/54; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WP6ai/54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765308924; x=1765913724; i=l.s.r@web.de;
	bh=jsdLA3oMNWGDorxdX6ly/pRmgeFBp1KOPB/tWsfsMAI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WP6ai/54++bVvyiuo+y0RjaFa2N4n5FyAn1hmlUY9qcDANIZ5UsdlXN2H/ipy69t
	 vTCAFgw28cnD63/tHrKqfL50hYNKOT8/aqzaGRsnySGGVPxP7gdcG0XJh2y6iWaFm
	 tOXxrkNzWvTxr59ddh0Nxb7sfnx0/5CqKz5/W3mRHl1odzSKezlYnSYMva/ShXVAZ
	 8CpCDE8VTtMtW0Zn4h1ZQD0h0DK897//qwG4K+k4YZ8Sn6Rc4Ty0e1OoSefrEx9g6
	 rOaSJu970amrt1kyJ2ih6bGcMrPKlgjmzbXhmJd+C9aEuJDp7SXc35G/S2SG+iX5U
	 e3Lg5X3DsVeivJq9fQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc3T-1vHBNZ0yU1-00CecS; Tue, 09
 Dec 2025 20:35:24 +0100
Message-ID: <51dc4ca7-61fd-42f7-8e72-a516a870e011@web.de>
Date: Tue, 9 Dec 2025 20:35:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: t3900 failure on macOS, iconv(3) broken?
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <20251209163356.GA5762@tb-raspi4>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251209163356.GA5762@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j48flvb7YqlAytVvQ3CAsw4EjCv2ZqDspNExlbqWb17B3vwv4Nk
 ucjvqxTLwo7x9AokecIF3aE/W4AFtobzA/jScf19PZ0auyJYoZnsjVaEYGR8bzelNfVJNEQ
 gJ6kbs9+ACpRBuLXxOVILrX5DYZGthlp/q9JYifoNcDwW87eRX1/A0DQrM9X4VpDXfNiMJu
 8ByAPneqgMA5FF7Yhey6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8NFS0D4VMww=;EQrY+LOODoeXDn5TEsW6C3szYkE
 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
 VDsDFecTpqJGySGc5qQV9hgHFl+CEUJQyiE4Lc

On 12/9/25 5:33 PM, Torsten B=C3=B6gershausen wrote:
> On Mon, Dec 08, 2025 at 11:59:11PM +0100, Ren=C3=A9 Scharfe wrote:
>>
>> diff --git a/utf8.c b/utf8.c
>> index 35a0251939..ff0c541fbc 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t=
 insz, iconv_t conv,
>>  			out =3D xrealloc(out, outalloc);
>>  			outpos =3D out + sofar;
>>  			outsz =3D outalloc - sofar - 1;
>> +#ifdef ICONV_BREAKS
>> +			/*
>> +			 * If iconv(3) messes up piecemeal conversions
>> +			 * then restore the original pointers, sizes,
>> +			 * and converter state, then retry converting
>> +			 * the full string using the reallocated buffer.
>> +			 */
>> +			insz +=3D (char *)cp - in;
>> +			cp =3D (iconv_ibp)in;
>> +			outpos =3D out + bom_len;
>> +			outsz =3D outalloc - bom_len - 1;
>> +			iconv(conv, NULL, NULL, NULL, NULL);
>> +#endif
>>  		}
>>  		else {
>>  			*outpos =3D '\0';
>=20
>=20
> I am not sure, if I understand the second call to iconv(NULL....)

It resets the state of the converter, e.g. the current code page of
encodings that have multiple ones.

> Here is a slightly different patch.
> Comments wellcome.
>=20
>=20
> diff --git a/utf8.c b/utf8.c
> index 35a0251939..b3c1dd2b59 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -486,10 +486,11 @@ int utf8_fprintf(FILE *stream, const char *format,=
 ...)
>  char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,
>  			    size_t bom_len, size_t *outsz_p)
>  {
> -	size_t outsz, outalloc;
> +	size_t outsz, outalloc, originsz;
>  	char *out, *outpos;
>  	iconv_ibp cp;
> =20
> +	originsz =3D insz;
>  	outsz =3D insz;
>  	outalloc =3D st_add(outsz, 1 + bom_len); /* for terminating NUL */
>  	out =3D xmalloc(outalloc);
> @@ -515,6 +516,17 @@ char *reencode_string_iconv(const char *in, size_t =
insz, iconv_t conv,
>  			out =3D xrealloc(out, outalloc);
>  			outpos =3D out + sofar;
>  			outsz =3D outalloc - sofar - 1;
> +#ifdef __APPLE__
> +			/*
> +			 * Several version of iconv(3) mess up piecemeal conversions.
> +			 * Restore the original pointers, sizes,
> +			 * and converter state, then retry converting
> +			 * the full string using the reallocated buffer.
> +			 */
> +                        insz =3D originsz;
> +                        outpos =3D out + bom_len;
> +                        cp =3D (iconv_ibp)in;

This forgets to reset outsz and the converter state.  With this patch
t0028-working-tree-encoding.sh seems to get stuck in an endless loop.

> +#endif
>  		}
>  		else {
>  			*outpos =3D '\0';

