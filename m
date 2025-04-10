Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116520C48A
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323217; cv=none; b=dopeMExifpJRLMPD11ZbWMeQ6lDd+9rHdGbd+G3FY+VPJp3C1yYFmmNGuRWbRpJIggFFVX6vkUuU6ut/mkfNM8Flv7J5sBOiZ6Mmf9hoF3Kqx25FehflcKY/evEbAIgkvRAlcusYSxVutZ2reO8E2hsstf+1wzdJdikjRfCumBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323217; c=relaxed/simple;
	bh=0fo0aJn6zw9qD+roIWXpDjyHbfsmfEgkOuAOS7S1UmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTBdXlKecY3Xh6g40O8JoFxgGKFBAvZpY3WIeE5RwCQ4S2oMbcnMFKg+PGv7QFtXKaTev3ZfUic64lXoKfJdc0syIBzvYHLE16DEptu01uSZcqCpqC0NiFFxTxFjiZEvtVX06M5HBq7+0gBM36ypp+NMKRJo0MX8hv95gGj85kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FwsrwETO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FwsrwETO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744323214;
	bh=0fo0aJn6zw9qD+roIWXpDjyHbfsmfEgkOuAOS7S1UmQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FwsrwETOYO5IX7upk+hyHKtzup1ZsxudCvlU2u3RVqjU0QZRNXnSdv/3yj5+o3CzJ
	 MXX6k26kaPL+8PtLngWIUiGfLO/hsbAKy6ucxlZ8Mrg+xSrrIr2l7PFSnaUPBhB6hP
	 4Ly6quDPL6i0q+YEh89d3xFO9aW3Hmq3AA1X6WTtX13LAKI5iTiS1lsZ8NxGBMgaau
	 LKcerg8iWcVX3Rmoijv8Wt06pavsUOOzz+UnrAzVvuEhDMSKAAJ+q8DZOLaT1/qDq4
	 DQpJFvmxNHr7nQfdJPsWPksceI3YNI8/ZWVk8AxN++Ocf364YPxAjrNR3/gdPPNONq
	 MF8ubG2IeuGiD/CEb4GwiOaLjLKxnb/hXHGub+Ax44nm6zkbzV7CuUOLBcwfzYFW5u
	 KJG9RAd/93I8QCvKc4MdBc4l5NigmIBKL4F+YHavXUk/grldk+FDNwBpTJ2qBlhvlk
	 1bdVW2FyIrKmt6nDctpRH9BHCe0TIim9abwQHlah81jko2B8nST
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ED4A720104;
	Thu, 10 Apr 2025 22:13:34 +0000 (UTC)
Date: Thu, 10 Apr 2025 22:13:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Nikolaus Rath <nikolaus@quadrature.ai>, git@vger.kernel.org
Subject: Re: 'safe.directory' setting ignored for some operations?
Message-ID: <Z_hCjfoRUIDZoBfP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Nikolaus Rath <nikolaus@quadrature.ai>,
	git@vger.kernel.org
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
 <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>
 <20250410213542.GA3168175@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B3TPNxcg5lxLbPqT"
Content-Disposition: inline
In-Reply-To: <20250410213542.GA3168175@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--B3TPNxcg5lxLbPqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-10 at 21:35:42, Jeff King wrote:
> So I think things are working as intended. You can get around it with
> either of these:
>=20
>   - set the config in your user ~/.gitconfig, which will be read by the
>     child upload-pack command
>=20
>   - tell clone to pass the config to upload-pack, like:
>=20
>      git clone -u 'git -c safe.directory=3D"*" upload-pack' ...

I think you can also use `git clone --no-local` in a more recent version
and the normal clone-from-untrusted-repository semantics will kick in
and things will work.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--B3TPNxcg5lxLbPqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/hCjQAKCRB8DEliiIei
gXLMAQD8YKRPHbM1CqAofnyVqz/OfiF/E+IqR0muUDOwB0T2ewEAs5Ial904kiV3
Kf/0DB4MsOSQuf5/NIjDByOA1ACljgQ=
=egtk
-----END PGP SIGNATURE-----

--B3TPNxcg5lxLbPqT--
