Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2623BD17
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593993; cv=none; b=m4nNWUMdALEhy15m4SjCevCWVkpCX+2SmE2eUV2mhd+uysnQNzedwqIrK5+hYlqhMxpLceDamG72RD8vQ5ArGG4JwGKKNRX2aD8sdpFguONlSEu6/4Sf472vbh3MzmqrvCGWUPJJ+1zc9yw3aGLtQhYltR5Gp/5bj+yUuVsKNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593993; c=relaxed/simple;
	bh=iI/Pyp23Vi6sxeVufP8Hott3c61F2D/WT3M/rfAV7YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCNJnNvTT+HADGJPrNkoQHoIy7Pymxu2Tmcjpcqtuk+qLCWiZnGsi1YdQs9QouOTFYO1Y4oROz3EY6Ik212Eq9695X5K0TgBssBwdPXMw7brf3FxzaONaOY1dOUHjOoad0/2MnKfPs0S4ws4Zy/jTMB8vJfCY037SZkoc9GHX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bzDhPyB3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bzDhPyB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773593990;
	bh=iI/Pyp23Vi6sxeVufP8Hott3c61F2D/WT3M/rfAV7YY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bzDhPyB3OWa6lwedVhX7iiB3J0yKcfsBrvhy/E2G2IadtJPbyeGqiV49zmQ4j+f1j
	 /gHbgprEJQBcJ7NYAdbsrsTbhfnXqs/46JEhNCpQPwvSjYDiqs1o+0e1jrqVauO/v2
	 BtQ6Fcr2ez9M9TyaydWuw5EqLlU2qZceMfbQZ2k2XbDspa0GAJ6ygxHGFuXnq2K56j
	 RiX16psUed62LwEHKkBIM13Jz8l6uabX9XkGjtNO1chD9zLGfCatAVHLIHmza5Jdvt
	 YuBRlzs5FcDywGtlror4f5x84N75AV83XvH5DnwlyQUjVkUPXkTVcFbkEXuVw9pw5y
	 r4bGIT4SwlNsKV6Z49q27FLYKELjpC4+KjNcZnWxcMC7fy7La9DEaZcMiJUKz1q77R
	 yHbExXnsRFi0FH0sNaSWe09MaCWNIYsGayizTCPMrjH0YdluOjWYGYVB2pQLxE+N6e
	 MifZKO/L125hnofg8SixL63mJDo6gTAGAJcRqFDVX2fpqIg4vKO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c233:1397:3eba:c74d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 56EA020113;
	Sun, 15 Mar 2026 16:59:50 +0000 (UTC)
Date: Sun, 15 Mar 2026 16:59:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Unexpected exit code for --help with rev-parse --parseopt
Message-ID: <abblhCBTgamxPOhD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260315031447.GB926820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62JDF6GYzIJN/nPv"
Content-Disposition: inline
In-Reply-To: <20260315031447.GB926820@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--62JDF6GYzIJN/nPv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-15 at 03:14:47, Jeff King wrote:
> So the calling program runs that cat command. And I think what you
> really want is to tack "exit 0" onto the end of that output, which would
> tell the callers to exit. Something like this:
>=20
> diff --git a/parse-options.c b/parse-options.c
> index a676da86f5..b990f38419 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1473,8 +1473,10 @@ static enum parse_opt_result usage_with_options_in=
ternal(struct parse_opt_ctx_t
>  	}
>  	fputc('\n', outfile);
> =20
> -	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
> +	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL) {
>  		fputs("EOF\n", outfile);
> +		fputs("exit 0\n", outfile);
> +	}
> =20
>  	return PARSE_OPT_HELP;
>  }

Yeah, I did some poking around, saw the heredoc, and came to the same
conclusion that this was a viable solution.  Since we both seem to agree
that this is a good solution and it also has the advantage of being
backward compatible (in that nobody has to change their code to get the
new behaviour[0]), this seems like the best option.

> And then you don't even need to change the exit code of rev-parse itself
> (since we'd never hit the "exit $?" that the caller tacks on in case of
> failure). Though I think it might be reasonable to switch it to 0
> anyway.

I can do that as well, even though I think that is actually
substantially more complicated than the first part.  I'll write up a
bunch of new tests for these cases in addition.

Thanks for a sober second opinion.

[0] As we all know, sometimes one has to use older systems and having
scripts break on older systems needlessly is quite inconvenient.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--62JDF6GYzIJN/nPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabblhAAKCRB8DEliiIei
gXScAQClgmwIdftSohmxIX2qKgMEf6t5TWwOWJ7ba3COPuXbyQD9E+RwOQzKmWZB
O5HEOhH99CdTsvCqXc8b5TxNMGt1fQU=
=tUt7
-----END PGP SIGNATURE-----

--62JDF6GYzIJN/nPv--
