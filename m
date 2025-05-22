Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2614C5AF
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943175; cv=none; b=sE3OpfpimSROqgfDUh3PFoD8xqXM4Ra7ra/f9UDC1bq6+5vrbBMJzk+NzeT5qD8Ns+z9pabInA/9JEGXytyAgUiDm85s41vnbrpFzdmEzgPx7eUm2sZFHYnTzQ8t3B0gerIQCIFZcqvz47OaZGC60JTqSk7DGnaDxJa53AS54Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943175; c=relaxed/simple;
	bh=kZcrtlqvEPp4enjq+QTO9QQntvMoXAr96XdxpGEodtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZD4SmsG1Cuc6uz3FULdKydVIpHHknjSfVgWqjs7tQozZlmwkwl9Taham+nE1Et5/4BR8e4YPdptjeeCfMFiGutPvsaXjrKdrJkzWzhSJl7BYLaXiqY//rBvsV229+iS3rcbWEEQibuyFN58/xMrYQDgilbt4xGUi/Jobmo2xAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=p8CdsjRX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="p8CdsjRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747943172;
	bh=kZcrtlqvEPp4enjq+QTO9QQntvMoXAr96XdxpGEodtg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=p8CdsjRXZGSgSgcZlMjlbbXqqwHwYU9rDQKfLM5T7q6zSaA+li6MaVCMRlVRAY8Jm
	 aOp2Aa1d57yqpKl3yN+BC48NS8Q9Cr+cFOqRBGocBNobaXz9YuDR+qwzqM0opAmLlh
	 BgYgi4ApywMUz5V0gcjN7j0sNQpeNc/D7wZ4I75hPiE6MEEz71HqeXFR113cVTj05b
	 aOQZdjCn3RwZp34DAGCdD2re+grxTUDvuNYmxjVHgUGhO9m2QgSXTNToZKnewP/D8E
	 l2MHTXi4JXUaDAK0qH9CXigp9/Y8A0/9dqu4UqHd+siCelWGveQCv7aoeEBIO3O4MZ
	 0zwtbqOmOPAeTzZOIZro0d9QtfFI11Z9XcmOYvUzkNbkdP9yNqPK03nLGiPlubpOyN
	 U1uV5lbPazdelHVbhBPzztO6AZ2QoiHvz43zSwXiqgIZ/K4A3msHqFIOzGfuYrdwnR
	 4S4yTi87PuFolQVy/7rODj4F3giex9fTLVb+cJinkROaoR4Zs8+
Received: from tapette.crustytoothpaste.net (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A16CB2010F;
	Thu, 22 May 2025 19:46:07 +0000 (UTC)
Date: Thu, 22 May 2025 19:45:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Subject: Re: [PATCH 2/2] imap-send: add support for OAuth2.0 authentication
Message-ID: <aC9-7Z4VW7gXw_l8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB959744EC6D19FEB8D197C434B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ih3Jx53GmBunxi8f"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB959744EC6D19FEB8D197C434B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ih3Jx53GmBunxi8f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 17:27:16, Aditya Garg wrote:
> +static char *xoauth2_base64(const char *user, const char *access_token)
> +{
> +	int raw_len, b64_len;
> +	char *raw, *b64;
> +
> +	/* Compose the XOAUTH2 string
> +	 * "user=3D" {User} "^Aauth=3DBearer " {Access Token} "^A^A"
> +	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#=
initial_client_response
> +	 */
> +	raw_len =3D strlen(user) + strlen(access_token) + 20;
> +	raw =3D xmallocz(raw_len + 1);
> +	snprintf(raw, raw_len + 1, "user=3D%s\001auth=3DBearer %s\001\001", use=
r, access_token);
> +
> +	/* Base64 encode */
> +	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
> +	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw,=
 strlen(raw));
> +	free(raw);
> +
> +	if (b64_len < 0) {
> +		free(b64);
> +		return NULL;
> +	}
> +	return b64;
> +}
> +
>  #else
> =20
>  static char *cram(const char *challenge_64 UNUSED,
> @@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
>  	    "you have to build git-imap-send with OpenSSL library.");
>  }
> =20
> +static char *oauthbearer_base64(const char *user UNUSED,
> +		  const char *access_token UNUSED)
> +{
> +	die("If you want to use OAUTHBEARER authenticate method, "
> +	    "you have to build git-imap-send with OpenSSL library.");
> +}

I don't think this is a good idea.  Linux distros and other parties who
distribute OpenSSL cannot legally distribute Git linked against it and
we should not require people to use OpenSSL for this.  It looks like all
you need here is a base64 encoder and it should be pretty easy to write
such an encoder.  There's a minimal decoder as part of decode_b_segent
in mailinfo.c and I'm pretty sure we could just add a suitable encoder
that writes to a strbuf like we have for percent-encoding.

Alternatively, you could just push this into the credential helper with
the new credential helper extensions by adding support for that to git
imap-send and let the helper implement the base64 encoding.  That's kind
of the reason I implemented it in the first place.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Ih3Jx53GmBunxi8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmgvfu0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3lCWLoTGQeXoRk2QiWm63KwMgwM5xzuhkQ847p+QIMy
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFOdAQDzkwRwMfT5pwtW7E1YTCcpy8ew
85Hm8R6pO0fUMItGBAD9FwZq8MZ2Kqn9MGrOnnqneW1ENXLANxkqM/3fwG8siQM=
=J+b8
-----END PGP SIGNATURE-----

--Ih3Jx53GmBunxi8f--
