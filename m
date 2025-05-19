Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60C21A94F
	for <git@vger.kernel.org>; Mon, 19 May 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690524; cv=none; b=S9ZwTA6K1466tQd8TUCq6BG5ecy4kenVI26DDxhv948L/trmdN7W20HwW5BISctBj+0wVNdi67Ekww9E+XC9H7coU2YscEY08qLBCc9GP6+DejVIU270tjnFTj6KkUeJZaEsGU1o8uCEacHFjLyvmnFGq5ZqjmC/6TM1+1Up3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690524; c=relaxed/simple;
	bh=OOFaazAIiSqDSCWqzepkLQWl+p/+vxRHyhDY59Nc+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEXEQrrQ1r6nvh4HkihQ1iH/x6IExYWTgVLzY1Qp83B3pC1w3/7OXWNgMqv0GN9/LC7jyixDhFLp9OpsQOKSiwuF3d3gxKhVej87WDARKh2fL06Shg4MxGsCFPfbgD2aL2wCW4yTm+S75czVMCrwc9Kqc6/KApfe/z6pY1D/EOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YAEMmyM5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YAEMmyM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747690520;
	bh=OOFaazAIiSqDSCWqzepkLQWl+p/+vxRHyhDY59Nc+5E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YAEMmyM5M8TK1FBIDWI0E3EbJHIbleQJPDbY7zeV+Gd5kGa9WnEvRxv7H4FobGgI/
	 PLCfUOOE7Y40t72ojcISUCu+cqOGOXV0i5ep3ZIgt/RUD7PtOepW9J7t+BF9pm/wLb
	 DdU2ZcuTE9eDi/iaMuDvr6hRv+vOJIAqvWzNCPwuNwKyPR001qaXRU/UkCJX01KrGg
	 STpPGiTUGXbBoQSRxrm2/lQ1eg5q7YY7aEoUw7WCLOlPTmtXtyLZKmgi6mfEZ6N4lH
	 lWQ6fEjMHPyXZRbTJEniB9n09Pgh9PHUtxnC4y0PHYlgdW5UTNmyd1TOIpCqIOGlg3
	 2UzZrYEIiBnFPHf0FVd2t2UHRNAUuHA2ndhflFdqxTU+W9ruyWCZE5NAXXR+GrFhrN
	 zKMI2JP5S+j2LC8c3Xermi8CNlD5P45S477wxvZaRdKE+DVp2GLFQyQIgmR67P9CBJ
	 WgVOmukEdrs1gpxxaif65TNfIKF1axDYRgkYeftk8vNYDq0XVto
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 624282010F;
	Mon, 19 May 2025 21:35:20 +0000 (UTC)
Date: Mon, 19 May 2025 21:35:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Bleecher Snyder <josharian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: make reset --hard add something to the reflog
Message-ID: <aCukFlfmQcxRSqGz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Bleecher Snyder <josharian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAFAcib_PV4EB-i4PUmTxCx_6LX=8aWDNT_ZPrN0-EDsRwRfi4g@mail.gmail.com>
 <aCuMshOaqcuwMCpG@tapette.crustytoothpaste.net>
 <xmqqjz6cmgt4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a0YvQaVScJKTqwHa"
Content-Disposition: inline
In-Reply-To: <xmqqjz6cmgt4.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--a0YvQaVScJKTqwHa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-19 at 21:28:07, Junio C Hamano wrote:
> I do not offhand have a strong objection for the _feature_, but if
> the implementation uses the default "stash", that is a bit
> worrysome, as anybody, even a script, using "reset --hard" would add
> a new stash entry, shifting the end-user's expectation of what the
> Nth stash entry records behind user's back.

Yes, this would need to live under a different ref.  We could use the
same stash machinery, though, with a small refactor.

> Doesn't "reset --hard" add record to the reflog already, by the way?
> I agree that a way to recover the local modifications that "reset
> --hard" is designed to get rid of is a good addition.  I just do not
> know what the best vehicle to store the local modifications is.

It does, at least when it changes HEAD.  But it doesn't preserve the
local modifications anywhere, which is really the request that's being
made.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--a0YvQaVScJKTqwHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgrpBYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyj8JDSSZs0A9M9v8SMTCTYU217R7FBVTiIyd8Y9vyFi
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADVMAQDeT+v5B4ZVyTITaJGJf36mHY0w
LL1maaolZvvkHgzLpgD9GND9XGcx3KEMnreG+1YiSvLAb9wv/OxNjp4bRvH+Hwk=
=CXjq
-----END PGP SIGNATURE-----

--a0YvQaVScJKTqwHa--
