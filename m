Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71767256D
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744850394; cv=none; b=Mpb0eBacruYzlwY3AvnO1i/i4m9ui/fyKb5HVISfnWK4guTgIZlk4xgNMJxmEMVn97Ut+NfLQ1fdDtvKHjc1vq9JV8Wkv9QQX+KXcv6yeywiePKtbI91AXObAAzdO4qCyotctAza7/VRBAxvqvX9vYYnnjvcz8xUShJ7Eu2hDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744850394; c=relaxed/simple;
	bh=54XZw+OpeDsOSv+hdYxVvnq6Lh1cWhcv6duDf9etq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEMA6SwfsIeTtDqsce29sW/HO7velLpLKz6s6vlmFnOZS+KZxpd13f8juKt2X6PPWTuBY2sWYEmBth8hbk8EZGZLK5+vuacCP3mgBq7vIAYbeDwpDdBo1BZV3Zlxpvv+PramCmRh1sSMUKPqN6KWUegnKX7PHndH093477ac3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=F8NabQY+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="F8NabQY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744850384;
	bh=54XZw+OpeDsOSv+hdYxVvnq6Lh1cWhcv6duDf9etq8Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=F8NabQY+wRp6LH38rjc3ir1fghsmKfBjE9pE4yLy15aQxw6FZm0d9vVFGTTJs+BwC
	 Dnp+SSgP/7yTWmOlezNURwtV0RMUZber/FMeNJchr/10jR5ePIkGNzyDjESqLu5EAS
	 tINPbjD4NDu29xAjxFU+HD3Sgc//h+zJ/UDlh+BcwHwy/dSith4VVdh8NEOTPe3lTq
	 WB3FAvvYH5ZsgCSPAhxhQ+ez6SQT2+bfbsVIvbKKCDl/tjLzw25HukNxL5O5OFcYfT
	 8l41+gVlnMz1bPOxdH8QFcoGOicga+SuoShdZW0x76QXRwiRKzJ9xTpeZAXXzHNh44
	 wi00beKt9YCkNE7zWyXf6aKyNFbHQGhr7lnVw76BvEpGOWE/Y+VTx+rkLyclfve0jX
	 iJhAiZOpetfCqVy7Ryht8sNeeYLirXJlfFlgiCoHSp9jHZttKJEMmsb9gKkrA1cHD8
	 dmv+dm5VxVt/jVFUNMOrUers4z6w6F8dHETHNOn5GccXuoXEOoI
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 28C3C2010E;
	Thu, 17 Apr 2025 00:39:44 +0000 (UTC)
Date: Thu, 17 Apr 2025 00:39:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] docs: document core.hooksPath=/dev/null
Message-ID: <aABNzj66xq5HA6gA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Derrick Stolee <stolee@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
 <BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
 <9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HLwXhpH9KSsD8rPq"
Content-Disposition: inline
In-Reply-To: <9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--HLwXhpH9KSsD8rPq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-17 at 00:25:28, Derrick Stolee wrote:
> On 4/16/2025 12:53 PM, Lucas Seiki Oshiro wrote:
> > Hi!
> >=20
> >> +You can also disable all hooks entirely by setting `core.hooksPath`
> >> +to `/dev/null`.
> >=20
> > Personally I think it would be better to focus on the non-expert user,
>=20
> I absolutely want this to be targeted for expert users, so users self-
> select themselves into the risk of what happens when disabling hooks.
> This is a "there be dragons here" kind of warning, implying that you
> better know what you're doing if you are messing with hook paths.

Yes, I think that's the right choice.  As we've established elsewhere,
it's easy to break things or cause data loss (e.g., by not pushing Git
LFS objects) by disabling hooks and the user should be confident of what
they're doing before doing so.

That being said, I agree that in the general case we should make our
documentation accessible to non-expert users because nobody is born
knowing how to use Git and that will benefit the most people.  This just
happens to be an exception.

I thought the text in the patch looked good to me.  I appreciate you
graciously pivoting approaches and documenting this, both for the
benefit of users and as an approach to help make sure we don't break
this functionality.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--HLwXhpH9KSsD8rPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgATc4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+1ej2aQQkkjNz9ZhDzH79KFJE0n6+oTq4iKcFKBz9RZ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALW5AP9JAFbWKqfGvlsnfwEA/ee2277S
dNIV28PfrOHzFjqRRgEA2IJWlJXLe7k5KKS14pg+H0PII/R7dxaKwWvHvvJj6As=
=C6kc
-----END PGP SIGNATURE-----

--HLwXhpH9KSsD8rPq--
