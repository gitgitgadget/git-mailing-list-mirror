Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5D60890
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854351; cv=none; b=GffwSWQFI1ayHbAFWoweMwdO786rvH9Fq0V1/f1CeLL4P+X4xXr4v1DadvmDj/MVU6bee+HtTHWXHdQ+GtXENpkeEECof42ElBdSlOHnqzNuBW34CdTFxIwBAWkWmbLSVm+kY9E9vjBKsiP6eswd1Nn5bbqq6d5opbYCpoUdz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854351; c=relaxed/simple;
	bh=toh9iz4sjM6jFxWZjITGpPHmkRy01IIV7M8ctkHZE5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hFOa6M1qGHeR2iBTqd4QwNjuzbqJHdyES3MUHazXHFriFF6TOUv+mJLXmNhqPirOJhwvdT0Z3Zrt+JWO8WgvdKymlZeklu+4+I3/uit3T/dJSEXDtb6+cU72GXgQBvcG3By+Zod8THxebmgyFoAFy9qn1/TOS/pIdP0oL66R8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qJXLE/jZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qJXLE/jZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707854334; x=1708459134; i=johannes.schindelin@gmx.de;
	bh=toh9iz4sjM6jFxWZjITGpPHmkRy01IIV7M8ctkHZE5Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=qJXLE/jZa8VU1zGnAyr1iYwMPL5opGtawFGqSv7/QMcwwZv1eppNcC4pjQU4o2bX
	 Du9lek7/Ch+l8WHsESdJJ7JIAKl/GLyk/7qw5dgOoObTfuhtElGiAgwJgpr3BsP0Z
	 DLhBR0LMbeATDuQPbTLT0EIl7K0ylQrz2QuQw36H7wUjAqNfewKtAAbstUUyJ6bbj
	 5BtHj0VZ4J6TuaRPUvZwUWuSorEbF7ZvYoHG3JnYMlThMjD8Yb3mCTO4UJQFvLS0s
	 HiOq82s+Z1U58LUc9q04iAVgyUcdSwlfqwE9MeB/hCDblD0Uw+2Wyb4Rgt+0/Enhr
	 JMNaBbAUcKsag3mJuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1r8eib3LUZ-00iyLx; Tue, 13
 Feb 2024 20:58:54 +0100
Date: Tue, 13 Feb 2024 20:58:53 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
    "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2] unit-tests: do show relative file paths on non-Windows,
 too
In-Reply-To: <xmqqle7r9enn.fsf_-_@gitster.g>
Message-ID: <0fb4e912-b25e-0240-c49f-aac5cbc3ef9e@gmx.de>
References: <xmqqttmf9y46.fsf@gitster.g> <6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com> <xmqqle7r9enn.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q6goMojNXqybxsFEw/DbNWcs2XOTkkKJyxdr+jltG3K+s0UdRvl
 hAQbNyDU9/XCN29VVJf0EXf6k/73eEtzqpxi9VtSgWY2hEszRayR7nFiU0oi98NJNR9E2lw
 M8gSXMg7Nzvfb4Ra1uApv8WvDL4NTsypF1dPBHYhpCUI1k5kfFqE+tmi+lUKSHQ1E+RvUr/
 bobNMmGUaDNf70Ygfd1wA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+vRTDwHYkf0=;tXI2Kn0OcZ7kFfps+1Ib/TmrGjV
 g1ZpNXX+7Q8Nax7OQR+SuTmV1awJv/vL0L6Noh7mhSIYdVQYGbYMuXDIqX0zNX5qfsTf4e4hO
 m3tdVPxcB8eueYXqPovf+W9Tzg66QuHs8ZUbTXRShTEQAP+pVEzChX0OEJIrLt/kIktU8Pm8F
 /JKmjxzz9s+4PA3ZFyogKHlmth9QVyHP15dsFhgvKWjG7N1+otDcFYs/opQbu2xj7f4Buae4S
 ZOsbVxpYmJjyiUP6msJB+AJ27NpqjhpGJJV5HX5ks8793AwWbXe7TMjwcM/8ntKjmeCN++A5A
 7dsRt4CTzF0ve1J/OI+mzXkh4ZoWVCre+6SHoiy94wfWoKEDYuxwEF7bXTV0U1PPMk5aZToHA
 xea2i0xuCXhER3mAXfs0V/PnOVD3B5fiTLLo1nl6bI1rxkVqTwSrPpRRkRHaHknQEyhM5r5Tc
 cseIzZMaHioGwjKq6k3QBGniO2GM3xqjjTmDHEips4PzoKCRUkWe/OTjZslEhfkFrxRbehxmq
 UVVah5wr6Lw4JRSaLDmGgHeZyufuABFyo0ETfTDPsa8xJj9rniiM0/bcjIlzDKwW1RVSkwM3q
 u1gdhx5fESHeiOk5H1C5ShNHK6YJbtjmqrQnFeE+1xEZvs+L5m467cInTkbfcskZfO+gBumAC
 v0h/Ro1BJdKrd1MT53faXN8EDa1dHFijdA659ir5XYmaLCW4ucbS5/+L15erptq3qpaOLMCE1
 ODZBirKDiZ0bTQQ72GckEYSO8ELm4iCiQ/kqiiuKvNLV720TkPi7PamvbbJGCrxE7kjri/YAB
 va2V/tnWWunrO4YdgNoYkvy50Uc33OgWi6/UdDLaAtDDs=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 11 Feb 2024, Junio C Hamano wrote:

> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 7bf9dfdb95..66d6980ffb 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -21,12 +21,11 @@ static struct {
>  	.result =3D RESULT_NONE,
>  };
>
> -#ifndef _MSC_VER
> -#define make_relative(location) location
> -#else
>  /*
>   * Visual C interpolates the absolute Windows path for `__FILE__`,
>   * but we want to see relative paths, as verified by t0080.
> + * There are other compilers that do the same, and are not for
> + * Windows.
>   */
>  #include "dir.h"
>
> @@ -34,32 +33,66 @@ static const char *make_relative(const char *locatio=
n)
>  {
>  	static char prefix[] =3D __FILE__, buf[PATH_MAX], *p;
>  	static size_t prefix_len;
> +	static int need_bs_to_fs =3D -1;
>
> -	if (!prefix_len) {
> +	/* one-time preparation */
> +	if (need_bs_to_fs < 0) {
>  		size_t len =3D strlen(prefix);
> -		const char *needle =3D "\\t\\unit-tests\\test-lib.c";
> +		char needle[] =3D "t\\unit-tests\\test-lib.c";
>  		size_t needle_len =3D strlen(needle);
>
> -		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
> -			die("unexpected suffix of '%s'", prefix);
> +		if (len < needle_len)
> +			die("unexpected prefix '%s'", prefix);
> +
> +		/*
> +		 * The path could be relative (t/unit-tests/test-lib.c)
> +		 * or full (/home/user/git/t/unit-tests/test-lib.c).
> +		 * Check the slash between "t" and "unit-tests".
> +		 */
> +		prefix_len =3D len - needle_len;
> +		if (prefix[prefix_len + 1] =3D=3D '/') {
> +			/* Oh, we're not Windows */
> +			for (size_t i =3D 0; i < needle_len; i++)
> +				if (needle[i] =3D=3D '\\')
> +					needle[i] =3D '/';

This looks very similar to the `convert_slashes()` function that is
defined in `compat/mingw.h`. It might be a good opportunity to rename that
function and move it to `git-compat-util.h`, then use it here and once
more below at the end of `make_relative()`.

That's just a nit, though. The patch looks good to me.

Thanks,
Johannes

> +			need_bs_to_fs =3D 0;
> +		} else {
> +			need_bs_to_fs =3D 1;
> +		}
>
> -		/* let it end in a directory separator */
> -		prefix_len =3D len - needle_len + 1;
> +		/*
> +		 * prefix_len =3D=3D 0 if the compiler gives paths relative
> +		 * to the root of the working tree.  Otherwise, we want
> +		 * to see that we did find the needle[] at a directory
> +		 * boundary.  Again we rely on that needle[] begins with
> +		 * "t" followed by the directory separator.
> +		 */
> +		if (fspathcmp(needle, prefix + prefix_len) ||
> +		    (prefix_len && prefix[prefix_len - 1] !=3D needle[1]))
> +			die("unexpected suffix of '%s'", prefix);
>  	}
>
> -	/* Does it not start with the expected prefix? */
> -	if (fspathncmp(location, prefix, prefix_len))
> +	/*
> +	 * Does it not start with the expected prefix?
> +	 * Return it as-is without making it worse.
> +	 */
> +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
>  		return location;
>
> -	strlcpy(buf, location + prefix_len, sizeof(buf));
> +	/*
> +	 * If we do not need to munge directory separator, we can return
> +	 * the substring at the tail of the location.
> +	 */
> +	if (!need_bs_to_fs)
> +		return location + prefix_len;
> +
>  	/* convert backslashes to forward slashes */
> +	strlcpy(buf, location + prefix_len, sizeof(buf));
>  	for (p =3D buf; *p; p++)
>  		if (*p =3D=3D '\\')
>  			*p =3D '/';
> -
>  	return buf;
>  }
> -#endif
>
>  static void msg_with_prefix(const char *prefix, const char *format, va_=
list ap)
>  {
> --
> 2.44.0-rc0
>
>
>
