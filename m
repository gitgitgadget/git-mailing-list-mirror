Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67562DB785
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061270; cv=none; b=f8KIkbP7JyuIcKohkgWJPXm5RXSUJRu72g49zNvmDsbz8prYM91RT1Q1j2FpDW4XU54/rQzp0dg9nJcjn+fenoH1HZXhMBW/EdFwswavBTgI+OyqTGPoUcXOebJrT9F2IfS3WccxNMzYnDrwQ24W2Srg+F5SK1uRELuWGIsP50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061270; c=relaxed/simple;
	bh=WKFffFBhNXY3veRTLQyZHFMxWNM13dUuCWM2Ynsrp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcPtdixdXniQp4vEuNGWMrCVfF7vbnEV33lp+QVaC3P2201lPO8buz7JgoVBJTqGQmAIAi3hg/BYobBZtrkkziBpKfzZpCBWuwFKW0Nyo8zJG7vIuSxv3k4xFaI52gC7HGcl9mgB/7RvCyoHC0veLWglYkQJUZKJiZqrRjkJHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FYxa/ggN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FYxa/ggN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791061262;
	bh=WKFffFBhNXY3veRTLQyZHFMxWNM13dUuCWM2Ynsrp+A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FYxa/ggNdyXLAcyZE26mfpiD3nvbpaFEJjdDp160vsGnjGK1O4pKSbMrucUt9TsQq
	 kN9YHN804kNYFFl5x+YVuaBAx7IVAxPalS31fvr5ip4Xx1pcfP7cpkHicUOmXBxO1l
	 ApQPSB5v6iu/9501V53GvEVhEuHQZ+9KQbUkHuLANbrye7LXVZH/CWaTcAc/O9xoSx
	 lWx6P/eNvbMcmeREDZx/PW2p5WxKrePq9rsMQ8MH7jUuPdyGCVV97d3lydPkUhYsl6
	 9qQr4rnrXNcgjBgdLrdsY+ruCocECqXGSfI6V2gNWSURQGW/lVlCjgg2qiASe8owDZ
	 UaTx6o9SRoJ+n42kvNsTqH0ky8Y1U3/Atl7iFWhBhJqjwm1akldKfEB7jdLos+fWsX
	 Bb+ZyG+vK5Ku5zf1k8KYm7pelCKl52j+8myD1kLe73E0hw2aZMjEfnV52v0t4f9M+L
	 r9ZGILOzrA1OQc/4twA3qNfyHUVHnGIdVW3sJmth3c5iTj09FWU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:792b:fec:8edd:6492])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6132020075;
	Sat,  3 Oct 2026 21:01:02 +0000 (UTC)
Date: Sat, 3 Oct 2026 21:01:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] libgitcore: add `sha1dc` as an optional feature
Message-ID: <asFtDF6NBc1ofnIl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
 <b1f30a6a05673c4094d59fda80c695472850d671.1790610691.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4MQdB1J1I2FdSfyM"
Content-Disposition: inline
In-Reply-To: <b1f30a6a05673c4094d59fda80c695472850d671.1790610691.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--4MQdB1J1I2FdSfyM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-28 at 15:51:28, Johannes Schindelin via GitGitGadget wrote:
> Note that the `sha1dc` crate still requires a significantly newer Rust
> version than Git's existing Rust support requires: 1.87 instead of
> 1.63 (https://crates.io/api/v1/crates/sha1dc/0.1.3).

I think this is going to be a problem.  Yes, this is optional, but we
declare compatibility with Rust 1.49.0 in Cargo.toml and we want
everything to work there.

The goal was to have everything work with gccrs, but I think we're
nearing Git 3.0 and gccrs has not made enough progress for it to be
viable.  This is not a surprise to me, but that was our goal.

The approach I've been advocating is that we support the version in
Debian stable, plus the version in Debian oldstable for a year after the
new stable comes out.  That would get us to Rust 1.85.1, since Debian
13 (trixie) came out over a year ago, but not to Rust 1.87.

In any event, if we want to raise the version of Rust, we should
probably discuss that in a separate series that adds or updates a policy
document and bumps the version in Cargo.toml.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4MQdB1J1I2FdSfyM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrBbQwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+99jaeCCriGIm2A0iaDsio2qNrK2HoZlqKXND1nB+UV
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABrrAQCe4+5X0TnVEiO4diYTZiG62Q7l
vj0bHfgL/3jl5XHuNwD/TLen8QwITP0w9vORQNNIVECUDqBxlaCFae6/B6NJFQs=
=tm4l
-----END PGP SIGNATURE-----

--4MQdB1J1I2FdSfyM--
