Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE2221545
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860988; cv=none; b=FYqgkT1w5I0nvV8GdS4WHNmLDDAEzIlED/KGmbStUvFhiE8wGOlvBgS076GwIOcoTXcspnpBoqVdufReNe28JDoUUulqGGI6ZNK2JYvsAKakdmL0r3cpCBqLRFcMya7IqMTwFJG5lwis2Qvg07IPEQly9yg8ivPWAF2W3lnD1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860988; c=relaxed/simple;
	bh=cFpsrxy6tefnydtCk7lshYAVC9QspVQDRsWN7hJlJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig4IPQzdOp/o08ZgbU0/67/SUHsM1ygnCQUQTw3b9kCBIWFr0wca2qEPkRd9xh5w3NcI5AQ7BbtLLojXPB/Rf63a9sVxtEIenY2sKq8ZQwQwd109fmM265N0r+58VYCxfUVXxsRIx6gmlxs/HwXVvqgxEvZFBteEruNzRHfMD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BA1q9fqE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BA1q9fqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768860979;
	bh=cFpsrxy6tefnydtCk7lshYAVC9QspVQDRsWN7hJlJHo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BA1q9fqEd3u0nJmYZsyVmubccoBiobgyFBikWDQ3MYpyx1FgR/5Q0i7QBlRsO61xV
	 ihn1tsFdKtD3dmWacxgefuj8yYQoQeHQ5G2+Dj77d84W++5TBH1lSC4FO6H5kOuwTm
	 EHc+N0xPyAgXZvBAGtVhPGAKOSZTcL+OFi/CKRyJOPlSLB6F75iq48SuzYSp8NPgKe
	 71uzDcKIeVDiv0UN/poawACmHI/3JUpL2nVXsq0LcEnalHX/Un8CH2/v1PwGID6oNt
	 DVtZW/N1yR1m9NPNyUWQbIRZV0gCLI6z92pHzrv/or2991msyyqY17QJg/sngoXGvS
	 6N39UZvyGW5TcRiiagsC28ShxQPQVFBW/C35k6LpUGoWnI0cXM09Mxxbdle3Uygd4B
	 apwroGMrwXkMtJJRP5nTpsYNjhhcWDwOAyBU2TAmPIVtE5H+pM48CVRXM3XE30MsPU
	 jl//zeEALA7cu/NUWkwaFiOVbvRNnfMGiFcfBGcZjtnH/L4o3iF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:11b3:8fe0:a8a4:798f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8806320081;
	Mon, 19 Jan 2026 22:16:19 +0000 (UTC)
Date: Mon, 19 Jan 2026 22:16:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
References: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
 <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
 <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
 <aWnekt4ESo0bKpOT@pks.im>
 <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
 <xmqq3445bn33.fsf@gitster.g>
 <aW3bSYCIPMhJT1mf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tX/VKoODrKkeWkno"
Content-Disposition: inline
In-Reply-To: <aW3bSYCIPMhJT1mf@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--tX/VKoODrKkeWkno
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-19 at 07:20:41, Patrick Steinhardt wrote:
> I think what I strongly disagree with is that this is considered to be a
> feature. I myself don't consider this to be a feature though, but rather
> a security fix for a bug that can lead to arbitrary code execution on
> the client-side, for example via title bar injection.

I don't agree with that.  Nobody still enables the functionality in a
terminal that allows title bar injection.  And, as I've pointed out,
even connecting to an SSH remote allows exactly the same behaviour as
this patch seems to try to fix, so there is no actual security benefit
to enabling these patches there.  Defaulting this series to on is like
closing the barn door to prevent the horse from getting out when there's
a giant hole in the barn wall.

It should be pointed out that, in general, simply using SSH to connect
to an untrusted remote system or using `cat` on an untrusted file can do
exactly the same thing as this series tries to prevent by sending
arbitrary terminal codes to the terminal.  Nobody has sent patches for
SSH to make it filter out terminal sequences.

I have also found pre-receive hooks on GitHub that will be broken by
these changes.  Just because Dscho has not seen them doesn't mean that
they don't exist and many users who are not on Windows do not run the
latest Git (they run what's provided by their distro or vendor), so they
won't notice that things are broken until we've shipped the feature
being on by default.

I'm not opposed to adding support for this as an opt-in feature for
those people that want it, though, and I think that's the right path for
including it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--tX/VKoODrKkeWkno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaW6tMQAKCRB8DEliiIei
gUdGAQDmygWkBDJRbf9zIrt1ZacyFfIPLVLACSWgBDK1U+NsIwEAuM7eh0Xczf5j
UGclIn7d4cjiKxyYdm/hz1q+82YpCAo=
=LGnL
-----END PGP SIGNATURE-----

--tX/VKoODrKkeWkno--
