Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B5101C1
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yYmgbkrs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kECJekz4"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023D2118
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 22:30:08 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E42E55C0303;
	Thu,  9 Nov 2023 01:30:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 01:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699511405; x=1699597805; bh=NF
	HAwbRrQkYWkDAYLUtdcx6ma08xg+p3WsBrBdfWueA=; b=yYmgbkrsu/EexEmW/M
	aiAxFT+8iKQOivmE/6weWGH50/Ej9izIc0TfTjNOtG8UgVNvwIN8TFylbVmveR6Q
	WXsT3Y1o12Ivq5KXjHg3MY5uFAi3Mnc2D56dPH723ASkeb9SPtbow+KqOZWW34mo
	yk8egGpzMcOBLaOSKSoeybHISBxLDV8zLMwa+m/S4SibwG8gaIHE4uwVgdNE4y4Z
	z8DaJ3b1GRldsOsSFI7KBLklLYyLS0dFVUVpVb099WKtm3mYiO/iXOt1LPQy8LS6
	5SSLk9g9XTdFzhPMg/uKps3f8q61el0AH5S9H7sMufUIxjXcPqGcMR0UhvVIeypL
	alQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699511405; x=1699597805; bh=NFHAwbRrQkYWk
	DAYLUtdcx6ma08xg+p3WsBrBdfWueA=; b=kECJekz413REQ/Hy9hyHX7c3KxT/l
	VLcFQYzi3M26AzimYA0RtGReEyHdpn+xDUA+Q+pzMoi33olInhtadAnx32+6K+a0
	qjKTWostPT7itWpf/tWqwo5E3a9l1IM58ZHcJSTU9ZnP8i+BSA67NoGpEugKxGPz
	WJVEBnShTkdlL+2piXZj4zy89M4kNF8kmiFMmaTYdfgofqmwldoYy5e72usE1ofi
	x1PY8uYtfFVl+XccwY3pTpkDyADY04CScyKWXcVxT+rxWiUuHj4ipxEylD6/9EkX
	stsrjzOzXf7Mx8425vQ4GEPdaYaakuTKQ7CFjffuO6LLToTy7ONx2TKEw==
X-ME-Sender: <xms:bXxMZdV2LNbdL9T49XGwk4q7OLuhJBALW3ssn6rI3XRXKL9uFLhWCQ>
    <xme:bXxMZdkSBK7Yrns7x6huQf038ASccn8JZbPojpPNphoPhVwxszT9k_WezfbS-2Evm
    jPLX-heuNJmJtxRog>
X-ME-Received: <xmr:bXxMZZZUF0bDmumVrvQc5p6VLDPZJef5ddF2bvY1PhXqB24W6V4yTMU1fbX50ZkPqaOcgRY_wpqJsej_b2zDIMWi5TAekf-RNiDKATbKj_KdTyxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeigfekvdetteefhedtveelgeejfeejfe
    ekgfeigeegieehgeefhffggeehveekkeenucffohhmrghinheprhgvugdqsggvrghnrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimh
X-ME-Proxy: <xmx:bXxMZQU0GSHLz6pld49l9forblDF2IcVYP_LycUjxf5jV0wzsWR5RA>
    <xmx:bXxMZXloV0MIb3M5gytGRxcrL0Ov8wI0fbTVBWrARy3gPy8uASK4PA>
    <xmx:bXxMZdfNhvJDpVFovH_sNZuNj2KStPbqg5TPw8vFCr0ATRJ7wnSmoA>
    <xmx:bXxMZfvanqY4KbfQ9ItEjvADGTLXu1krzKph9BQHMrrrSfJ0UKyETQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 01:30:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25ec17dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 06:29:36 +0000 (UTC)
Date: Thu, 9 Nov 2023 07:30:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t9164: fix inability to find basename(1) in hooks
Message-ID: <ZUx8adNt3Ky-U09W@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>
 <20231108172125.GD1028115@coredump.intra.peff.net>
 <xmqqwmus3zvd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWjD3fuGzNYLTeJV"
Content-Disposition: inline
In-Reply-To: <xmqqwmus3zvd.fsf@gitster.g>


--cWjD3fuGzNYLTeJV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 02:43:02AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > ... But the more robust way to do it is:
> >
> >   # export ORIG_PATH, which presumably is not cleared the same way PATH
> >   # is, so that the hook can access it
> >   ORIG_PATH=3D$PATH &&
> >   export ORIG_PATH &&
> >
> >   cat >"$hook" <<EOF
> >   # pull the original path from the caller
> >   PATH=3D$ORIG_PATH
> >   export PATH
> >
> >   ...do other stuff...
> >   EOF
> >
> > That's assuming that environment variables make it intact to the hook at
> > all (it is not clear to me why the original $PATH doesn't).
>=20
> Yeah, the parenthetical comment points at the crux of the issue.  I
> can tell from the patch what issue the platform throws at us we are
> trying to work around, but it is frustrating not to know why the
> platform does such unpleasant things in the first place.
>=20
> Thanks.

Indeed, I should've described this better in the commit message. Quoting
[1]:

> By default, Subversion executes hook scripts with an empty
> environment=E2=80=94that is, no environment variables are set at all, not=
 even
> $PATH (or %PATH%, under Windows). Because of this, many administrators
> are baffled when their hook program runs fine by hand, but doesn't
> work when invoked by Subversion. Administrators have historically
> worked around this problem by manually setting all the environment
> variables their hook scripts need in the scripts themselves.

So it's not an issue of the environment, but rather an implementation
detail of how Subversion hooks work. It's surprising that this does not
fail on other platforms -- maybe the shell has a default PATH there that
allow us to locate basename(1)? I dunno.

Will add to the commit message.

Patrick

[1]: https://svnbook.red-bean.com/en/1.8/svn.reposadmin.create.html#svn.rep=
osadmin.create.hooks

--cWjD3fuGzNYLTeJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMfGQACgkQVbJhu7ck
PpS3IA//WIozh7d+5vQ6wzUeE3HOeNvUe8zKFWAJiFv2uZacrNcR9vQYtoa6C7Ch
ucmRvFKddo6kAghUuim2TWgsXC4mZ3nE9uhY8K4nof7vEJ8Gwf47QH04tR4zbVZt
CfG9f64kBMC9mlLXE6CmbdjDrFixEs33pAsOTkSgZiBxUjX8l7+uLHndZNwFWU2X
4/rODRYCFI6rN7Mw4MaZ7dy2X/dXb55KrifV5nzK13B57FHQDGkiqKQEOV7FshsU
XYS6QY6opl3sm68tbTGH+4OigmaK4+XKaQjqMZ+1M8YdB2YcNXyGBMzUapQgYdyo
UN5MgzEojfPfW8eHzW6sRfmw6jDkvdt6NcD49tjgORzUeYnZvpi5ZlXwGNxvzeOW
nHKF2LLGXIDCcpkwsLDJYiEQnvfrFofLOGZNZZHAOQDzIKtabHvBGdMqAQirKCcz
5vQWd/2jUyt7pXczKl0l3MLwuOsWNrlrb24jglKQOZHc4RpvZ2nBpn/13Bccjcen
Plwnr8HNzzlq+D/e3ZFIJZ2i3C+UKBHhAbfzKU71m+A+j9/hMm+gbbUGcE4Wy0uT
rJ93JGMn2MLQtpdSK7L2T5agdaiOBp+u4o/VPws8mg0Ch0FPhvmQBbxEz/LlDxxV
5rGIV2HMlZJXfcpXwdMTzTdXmkkOaBDLCu8EvNqkaUhiXMQF26o=
=A8DC
-----END PGP SIGNATURE-----

--cWjD3fuGzNYLTeJV--
