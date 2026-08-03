Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D40313547
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723241; cv=none; b=T6RqwQGlzNtP3INo+LeOqA1Eox59QrdCEfyfjylUIpfY9eIu9t6bwEvYda53719DM1zfEKtrqYJJg4LP57fdmEO8DVNjhZ4J4/AXW+Wf4vKkCxrwbClXMGSCVB9YSQmdo2O4U0OsKh9chlCPsE6RSvhjvawLnEBPLKwDUKfSZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723241; c=relaxed/simple;
	bh=/k12Dl3CoUbxEThZzxb2H6A+2pe1HdVv0Xr4JTLRPWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIQ10X4Fu/HtO/1ZQ5B+0LwF04dHI/7niegWtlT8RhRBfPgk3k6JDPi97xPgQZ+FPACqBV1EEjnp8EzzYTzs7LKNrgZWub9m5kejhUMzCa6T7fFSPa1pJzmZPGUgYEmPUkMXTp86ArNkjz0wyfN3u0RPPBW8zalLmkBG9jB98mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DtnaZ80x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DtnaZ80x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785723237;
	bh=/k12Dl3CoUbxEThZzxb2H6A+2pe1HdVv0Xr4JTLRPWs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DtnaZ80xt+pO3HMg9aRnuYTvvBFwctu+JYUHCQ7aVfDvKzlIBKQit7WDn4Wsw65W4
	 39vaa5ggXRSla89Fb6fNu67ulmLtnA4Mpuol9J6Dv1yTbEXINY9r0DJx2RYnhXsS8w
	 p/LtVZdrb8VNC7/gkjLyxnJMjDj7ivEzFqO4zUKf94Dov6TXw6r57jXLzqVyRsmRJg
	 lNx/t2EP1fi2/ZRI4jCGZFQRdJdv4ptysRY8JaWd3IEG3lspVCmPUNm4bJOAy7Qr0s
	 Z0vrqJoofe8GHOrb/8z9dPl4YoiCS9GyK52JiU+QFFnmPpUuiNAGqpUunzJg5dfrlL
	 AA6WVzwZVGtLO2TdLnkpIS/f0XggCsIlKc/KCA9h1gbrmOGfIs88fikozG6w9fq3T/
	 QPbuBU9hH6GR8Eey1C9cc+dAy08rUxCcL3zyY5towzttZ20egJ2zcNJIutar/QUfSf
	 EebALXgx7tIe7seoERC+VBK+2fszwgeJ4E5CETdJtVac5vA1R8N
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8B4F1200C4;
	Mon,  3 Aug 2026 02:13:57 +0000 (UTC)
Date: Mon, 3 Aug 2026 02:13:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kenneth Lorber <keni@his.com>
Cc: git@vger.kernel.org, redoste <redoste@redoste.xyz>,
	Fabian Stelzer <fs@gigacodes.de>, Xi Ruoyao <xry111@xry111.site>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t7528: fix failure under csh
Message-ID: <am_5YymI-UnCT_s1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kenneth Lorber <keni@his.com>, git@vger.kernel.org,
	redoste <redoste@redoste.xyz>, Fabian Stelzer <fs@gigacodes.de>,
	Xi Ruoyao <xry111@xry111.site>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
References: <20260803004105.36913-1-keni@his.com>
 <20260803004105.36913-2-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ozne4nWJMCq+E81"
Content-Disposition: inline
In-Reply-To: <20260803004105.36913-2-keni@his.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--3ozne4nWJMCq+E81
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-03 at 00:41:03, Kenneth Lorber wrote:
> Explicitly set sh mode for ssh-agent (ssh-agent -s) to prevent
> failure when user's login shell is csh-like.  The failure is
> caused by propagation of the $SHELL value from the user's original
> shell despite the test and test harness explictly using sh, which
> makes ssh-agent emit initialization code for the wrong shell:
>=20
> > cd t
> > echo $SHELL
> /bin/tcsh
> > ./t7528-signed-commit-ssh.sh --verbose --debug
> [...]
> expecting success of 7528.2 'sign commits using literal public keys with =
ssh-agent':
> [...]
> ./t7528-signed-commit-ssh.sh: 1: eval: setenv: not found
> ./t7528-signed-commit-ssh.sh: 1: eval: setenv: not found
> [...]
>=20
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---
>  t/t7528-signed-commit-ssh.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
> index b50306b9b3..7bf4a40de2 100755
> --- a/t/t7528-signed-commit-ssh.sh
> +++ b/t/t7528-signed-commit-ssh.sh
> @@ -82,7 +82,7 @@ test_expect_success GPGSSH 'create signed commits' '
>  test_expect_success GPGSSH 'sign commits using literal public keys with =
ssh-agent' '
>  	test_when_finished "test_unconfig commit.gpgsign" &&
>  	test_config gpg.format ssh &&
> -	eval $(ssh-agent -T || ssh-agent) &&
> +	eval $(ssh-agent -T -s || ssh-agent -s) &&
>  	test_when_finished "kill ${SSH_AGENT_PID}" &&
>  	test_when_finished "test_unconfig user.signingkey" &&
>  	mkdir tmpdir &&

This seems reasonable.  SHELL is defined by POSIX as "a pathname of the
user's preferred command language interpreter."  When we're running the
testsuite, we don't care what that is and always want a POSIX
sh-compatible output, so using `-s` is the right thing.

I also don't see any other instances of `ssh-agent` in the codebase, so
this looks like the only place we need to fix.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3ozne4nWJMCq+E81
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmpv+WMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5L1P3IX9PrmAMv70kaZfd5UKE1iVnbJfVsGBygNKpID
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACDlAQCdJV1nXwwb2TOhTblz85MvFRLo
NqkKTkR4BKeK/VMLvQD/VRy6xl8AMWC9Ir6Xg/or/2Skt/CAo2fcleKH9tXqiQ8=
=oAPc
-----END PGP SIGNATURE-----

--3ozne4nWJMCq+E81--
