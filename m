Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115336C0B6
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635270; cv=none; b=Oy/Ulp3XlkZ5di0muHoa90rabj1IHmNNX43nWP98QGTWnr7q4EMZShc2hFzfzQPqTaSP3CdlgEWYlhYfaIz2EmMytx8LRaba2cJ+LPZNg5V++3m4FgpJ16NqeMvAU2QwQ6DqPuHG1iHpdsXlMZ73ngYR2ZbgI1AiSK2rERaznkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635270; c=relaxed/simple;
	bh=SB6KYbTq0ecLu7B2P21RaDDp1icAVDW1A1TlDSTKO4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFv0LK+gm1Vk6t5d68T5x+rBnUMk0v7f7yErVdWHr4j/kuWB8srevkZvK2EVKE3cLBqMNEALCtoFQIkF3pA+DiplLd+sI8Nw5un92iklB7Kyj4k5YExKR6areJ8h5K1SS+nd/2iKn2grt/pHFhINOnLbMr5wRerxD7Dp8WwEiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=fail (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=XjP/DZ6F reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="XjP/DZ6F"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 8D69D180048
	for <git@vger.kernel.org>; Mon, 09 Feb 2026 12:07:42 +0100 (CET)
Received: (qmail 31601 invoked by uid 989); 9 Feb 2026 11:07:42 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by cressida.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 09 Feb 2026 12:07:42 +0100
Date: Mon, 9 Feb 2026 12:07:40 +0100
From: Matthias Beyer <mail@beyermatthias.de>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com
Subject: Re: [PATCH 0/3] commit-msg.sample: reject messages that would
 confuse "git am"
Message-ID: <gfxpnecn2cdtmeiape2d4x5aybuyyqi4c7m6te3khgct34dd44@wqusigna2nsp>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <20260209065703.GA585828@coredump.intra.peff.net>
 <f5f100de-815e-4bf3-832f-3d473413c635@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wtdru7ca74bjbqt"
Content-Disposition: inline
In-Reply-To: <f5f100de-815e-4bf3-832f-3d473413c635@gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MID_RHS_NOT_FQDN(0.5) SIGNED_PGP(-2) MIME_GOOD(-0.2) BAYES_HAM(-0.784541)
X-Rspamd-Score: -0.984541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=SB6KYbTq0ecLu7B2P21RaDDp1icAVDW1A1TlDSTKO4E=;
	b=XjP/DZ6FHo9woZrkIP5VThxSW45xtCb9kzDfA29HPx2Gnhcp9vC3XGSuf4T7xizDMTVjOY3Dfb
	qUp7m38rg1qyag8vE8UQx+ZElDTmD971t02VNEnr10j+fW4Yeqfm0N1wGccZgOst2TWMZbD7btmx
	QNcIBAGRTPbvLWs0wa3upyEg2q17S5Bz3/tV2Mazg5KEOnJo5j0o22VeIkZJghrdZATGqO7SRtG9
	mDPVfcyugQrHNZtkPexAXCPTUnQXNY6+n3m5UhJLgzdps87zWS4SiK+JklFcAKr3DOl74AIauaMP
	H4OzSF89cOHLKqt8JdyGz4Yx3hWgcQVsHcsoseveMQ5SirAOygZUx17u3NpsSJZ8l7bGqUP/LS2Z
	1Mdwj9mcn63nxcOI77QEFvKnvyopg+sD4Uq0dIZaAcdFIMJTTVXeNRll5n4C/oMTHHrLnQo/FQW3
	izBsmo9P3d5N3VXhREALb9WSGBOy0fzz8Xi5Uo7iNynL/2pQCKVeZj/Fc0wu8W685iNvf8sFc6xr
	qauV3OZuNyAG27Q2ed32UulO2lnw/BbVuMPlDp6KBx2m1pqR/2OoyCQtc/Ae3r6fSRWJXoxs0HAL
	nmkUikRSlHmRhEHZW+TOZGYii9D/zdbQKC4nLKS5QokobT35rRIlUr5f10xXkWoW1Q35jngHL3on
	4=


--7wtdru7ca74bjbqt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] commit-msg.sample: reject messages that would
 confuse "git am"
MIME-Version: 1.0

On Mon, Feb 09, 2026 at 10:43:23AM +0000, Phillip Wood wrote:
> >    2. I'd guess that these days only a small minority of people care
> >       about sending patches by email. So for most people, a warning abo=
ut
> >       their commit message containing a diff or "---" will be mostly
> >       useless, if not outright confusing.
>=20
> People do download patches from github and apply them even if they're not
> using a email based workflow. I'm not entirely clear but I think that's w=
hat
> happened in the post Matthias linked to. Though if they're using "patch"
> rather than "git am" to apply them indenting the diff wont help.

Yes, the original post was exactly that issue.

I can add that distributions also do that quite often when they apply
fixes from upstream that have not made it into a package release yet. At
least for the NixOS distribution, we do that quite a lot (a totally
unscientific grep through nixpkgs gave ~2800 instances where we fetch
patches).

Of course it is the obligation of the distribution to check the patches
that are applied to packages. But in this case they of course use
`patch` rather than `git am`. Still, that the diff from a commit message
will be applied as well is something even advanced users do not know
(I myself am using git for over 15 years, and I am comfortable with
email patch based workflows - though, I didn't know about that fact and
would have definitively fallen into that "trap").

> Kristoffer has kindly updated the documentation. I'm wary of adding a
> warning to "git commit" for the reason you gave above. We could make it
> opt-in but then hardly anyone would probably set that config option.

I agree on that part.

Matthias

--7wtdru7ca74bjbqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmmJv/wACgkQEKWX9Kit
z82vsQ//VgEMsL3gfFsW0C+WruMXZSyeCC1wsoJVry+r5W0zGuArWYO8NS8cfGNX
QNCg6PLp04vBgxMsF5u/V87pWp0GdhYiWSCRr/fFz6fuky9RoYqWWqIjZFtiQuY0
IU5Dire7NNDLTxhGEeuGYMy+8h4dUrAH+uLUlbe35PvOYTCnRDgMFI7oRR/1KwNR
h775gR1n85730qj2saFpu1+MDSm0kNke40QHpWXeBO/upQc+u0TaqbFw7plUgteQ
NBvTFBDknt6EV7CGJbQeWG7qAHp1ippV1hBZOuYEtTZxH45rNPPMJYPTJis7J7V4
TX+H5lqHi+stW5GdB9VfP2kpCPVQG5sEcrLOWSYJJKQT0ZfjXc2ZYMWwuBlI/n2f
exkwNg58pHB/yBtb1PT8C5BEt0WcF5tlN7e89kDmYYM/nuWWsJPonXIXwS9XXBoS
+tq2ckF0NwxAN8N9utVQ4jFVxBFMll2qIaGEn9CpPusQPeLy4SzXly1F/59/Ces0
/Mi+DPqwRLOscP4ruxd9ssYpG9YAGE5Ipzd6bGiWgUSEJrKTtk01fxTYw5IaZz57
pizZ6Nc8+eW1/FZ9Fbvv9yRRZcX79s00VnkCdgJBqv+6sHSyhtzLsHOZSLYkK66t
6A+4eFiEc6LSPGxG3PoHgHEZlinrn38P9Mc7bJuO2kdavPN3g98=
=kb3H
-----END PGP SIGNATURE-----

--7wtdru7ca74bjbqt--
