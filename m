Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CD1F584E
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448783; cv=none; b=M7shtoigYo1fR4ggFHJ9ydyYDkuycB1K1xy3qHUVd3vU+PPDBnW4VpmmsW8YFT9q+SpU94oetBHHlknjq7pI193cC3BwhUAEhZbfgPXAYNNnUN7O95Kt9slCBtBZRkYgkd0h37bPM/QFulgBcZXND144jOESqeQWvjnfUTHC3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448783; c=relaxed/simple;
	bh=GHTvIfODGRJbFhwN6ffISYyEHhQhALABtPQjQ8UPXY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTmDSghQqn6iO6gojGW3l0n3zBNqdwHs85l0212AAeRh+VO/P3g8F47PrSo44uoTRpebsB8E+5EtlEAARb/GxFlc5QCW+yBJI9CesXiBOV0TwChpfqSMxk3alOgPPsJUFYAKvp7qcaME00CASY/TswwKe8ZxsTFPre3YbHhxJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bQzR1dnn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bQzR1dnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745448773;
	bh=GHTvIfODGRJbFhwN6ffISYyEHhQhALABtPQjQ8UPXY4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bQzR1dnnYJbpMkweEycGjsLt58QydeViCL2dQlIj8cLlmzR63YFS5obDnC7YAEZX6
	 cTi9yBlBTUSvyD+Tql3DZ5IaM+gY3pv2yn6WwLx33O6eEVmxSRgRtS+3kzaIRifDkg
	 EnyvhR2xz63MHguOlHR5mVpBb0ixljkFQI6TxDx50IWx7q4xapMxt5gsiFhjuj9Qtz
	 oCZGDK3N2nNMggx2OSqEm/DBmsoey9ozg4uo+X8ymQWA1x3VlPa0+LKecOjbFGuoey
	 gLUtVUjqbZOnmE6rXgvDScCkcv5hINx5LcgwZE1btaSZjGtp8+ANydRrcNUfJ6D0wQ
	 GXyxNqVxGGSzUpZDruKvfHocbmnHSmmIhLiEN+FS+CBuStgAoTOvuWc9CeGzHqIbHq
	 l0QYjziS845QhcbfkHqKosgqHYj9TY/ZA358FBfE7ZzyUvz1b+U4dGpWs8NfjtaRdk
	 WifljKcw7i4Ohy0eSc/wocU3/cbgT8eEN7YVjZX8qJ0IPIh6HPq
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 43CAF20107;
	Wed, 23 Apr 2025 22:52:53 +0000 (UTC)
Date: Wed, 23 Apr 2025 22:52:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Message-ID: <aAlvRBDVygspE5_0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Shengyu Qu <wiagn233@outlook.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s86T4GMkyJfjnuGE"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--s86T4GMkyJfjnuGE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-23 at 12:19:46, Aditya Garg wrote:
> This is a problem because the Message-ID is crucial when we are sending
> multiple emails in a thread. The current implementation for threads in
> the script replies to the Message-ID it generated, but due to Outlook's
> behavior, it is not the same as the one that the recipient got, thus
> breaking threads. So a need arises to retrieve the Message-ID from the
> server response and set it in the In-Reply-To and References email
> headers instead of using the self generated one for the purpose of
> replies.

This behaviour is allowed by the standard.  It's not uncommon for
smarthosts to replace the Message-ID header because they are responsible
for making it unique.

I certainly don't love it and it has the possibility to break lots of
things, as this patch demonstrates, but it is technically allowed.

> The $smtp->message variable in this script for outlook is something like
> this:
>=20
> 2.0.0 OK <Message-ID> [Hostname=3DSome-hostname]
>=20
> The Message-ID here is the one the receipient gets, rather than the one
> the script generated.

"recipient"

> diff --git a/git-send-email.perl b/git-send-email.perl
> index a6cafda29c..a18e978e22 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1636,6 +1636,11 @@ sub gen_header {
>  	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header=
);
>  }
> =20
> +sub is_outlook {
> +	my ($host) =3D @_;
> +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.co=
m');
> +}

Are we certain that these are the only two possible values for this?  My
worry is that we'll have some other host (or the same host with some
other hostname) that does the same thing and then they'll have the same
problem.  For instance, if I set my domain `smtp-outlook.example.com` to
be a CNAME for `smtp.office365.com`, then this would fail and I'm
concerned that we'll have corporate environments with that
configuration.

What I would recommend here is that instead we set an option that
controls the message ID generation.  We might have "as-is" for the
default behaviour, "auto" to use the `is_outlook` function above to
guess, and something like "data-response" to always use the approach
you've written below.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--s86T4GMkyJfjnuGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgJb0MJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+R0F10j2L1aSGHG252jH7zjLh5ada0Soq0sSpKrOGb0
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAEoAAQCpzK2FCh3dxxWGy8pG+IOQrHCc
emaUOcKWb9LZKhNqmgEA3efXFG81rDG16fiYkjS3EgHDwQUNn3qQZQ3+emmaUAI=
=u6Jx
-----END PGP SIGNATURE-----

--s86T4GMkyJfjnuGE--
