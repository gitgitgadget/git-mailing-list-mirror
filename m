Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lI4rPk1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U75BT4/C"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BEA10C
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:40:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4A6C73200A87;
	Thu, 14 Dec 2023 03:40:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 03:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702543250; x=1702629650; bh=cjJIyQ2mV/
	yELNktwlxyWkjKTPWIIUi7iHIrgpsYLJo=; b=lI4rPk1N3DPyx3PHhUmmE1WZxR
	IBg4uWsNs13reQKvawcanEti6W2RViQB8/QmD99MGnibaj784H/J1zTqfBAVdrHa
	7ihrPUG7ncg/mr3A9YLxq9+suC25lA9O7Zvk/nd/IeRK1XdtO3zVpZAxcesTfUPP
	4YAnFOD/oelteWAGTMtWmbaII/2fVKnbawwpnye0jhtLu9Ca7+lvJM+WBu7Zf4/0
	AFxI+Eh/gH7BvPU07AK1CnLdPJ3uwTmWIZAZP2Hym+P9wYgSjAheFRt48DffZN3c
	PN96KZlxTr2N7rEUVptJYLSDmEx3K/dhg3nQ6dIytZ1Vp/nBeps/o2XI4Iqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702543250; x=1702629650; bh=cjJIyQ2mV/yELNktwlxyWkjKTPWI
	IUi7iHIrgpsYLJo=; b=U75BT4/CJOElXGZb8wP9xSBR3ZTdZ1PZm7qaxuvcvIPn
	NFVt19bBdbVdcjqXgf9epGDfmgJU17lWNK9iam3jot1ZAm6k8ZjMEtY6m/DoH/mH
	Yni37EpaQsaHN3R0ImZzVlN6ZGXro2C1R8xfaozr1NjFkRGrBKpXQF8txLoyiFB2
	wgCln/rKBgt0h3WkvwqJisO+/+rFls69rQCdZQY3hqK1O1/1ptybwJOqCP4KQr5l
	W3LJmAT/MGxZkVibgLXAusnvHtJw9Csb88LVJS0hy/xZKJQDqeAFE9P7/cOEr717
	ofQPuMfhEnTVxGCAuTU7OBNMv96635NxmVCLUj9I1w==
X-ME-Sender: <xms:kr96ZYSR0rqbuiZAoli_oDSZfMKsoFjMtaLdG_YL3vx9Za1yBNxxPw>
    <xme:kr96ZVypCqC8av3DKRIUhqCVAIMNPgpOZDWQnQ69GMsk-d6GOxdJNkWsAnUNtW3sE
    ZodGGGovEfQyC_9sQ>
X-ME-Received: <xmr:kr96ZV0c45j9WfQ1nWuTMHxbX42TnGqxsSmkdyOztP8Jp8VkSrqN-8sca5INuSfrV5dqlmp3MDcSu72DBjotMz5AfXDtve_0yLWxIx-QgUw2yvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedtieffleelvdffgfdtjefgveevhfelteejudfhuefhieelvdelteeigfekjeeu
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kr96ZcANzjRLVmADCS95tPqzSG8giMNz-aUR0SxbcTdzgeJYkQYhjQ>
    <xmx:kr96ZRgfWgUTuBYd1zOwITgfC-XL-O8p4TVI4DfesnxfWtL1WfzwrA>
    <xmx:kr96ZYppVTpHcHUupOZSiFcic0KzAkudeI8kSaDJefKjTcb3uq8hmA>
    <xmx:kr96ZRYRMSG1hIUoUQoeKztPfuMHAbIdgAFDAABhLGsIgSYdFi4s6g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 03:40:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 131e938e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 08:39:05 +0000 (UTC)
Date: Thu, 14 Dec 2023 09:40:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
Message-ID: <ZXq_jo9QfSmjPGmK@tanuki>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g>
 <ZXlbNlG28e1sAYPU@tanuki>
 <xmqqr0jqnnmn.fsf@gitster.g>
 <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
 <ZXq5GL723v4E3_IH@tanuki>
 <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yl4KOxKKLlQq1K38"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>


--Yl4KOxKKLlQq1K38
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 03:39:17AM -0500, Eric Sunshine wrote:
> On Thu, Dec 14, 2023 at 3:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > On Wed, Dec 13, 2023 at 10:33:00PM -0500, Eric Sunshine wrote:
> > > On Wed, Dec 13, 2023 at 10:11=E2=80=AFAM Junio C Hamano <gitster@pobo=
x.com> wrote:
> > > > Mostly because your "differences in features supported by just-built
> > > > one and what happens to be on $PATH can cause problems" cuts both
> > > > ways [...]
> > >
> > > I sent an alternative solution[1] which should sidestep this objectio=
n.
> >
> > Thanks, I've replied to the thread. I think by now there are three
> > different ideas:
> >
> >   - Improve the logic to pick some kind of diff implementation, which is
> >     my patch series. It would need to be improved so that we also probe
> >     whether the respective Git executables actually understand the repo
> >     format so that we can fall back from the just-built Git to system's
> >     Git.
> >
> >   - Munge the whitespace of the expected results with some regexes.
> >     I like that idea better because we can avoid the git-diff(1)
> >     problem, but find that the result is somewhat hard to read.
> >
> >   - Fix the ".expect" files so that we can avoid all of these games.
> >
> > I actually like the last option most. I'll have a go at it and send this
> > third version out in a bit.
>=20
> I sent a reply[1] in the other thread explaining why I'm still leaning
> toward `sed` to smooth over these minor differences rather than
> churning the "expect" files, especially since the minor differences
> are not significant to what is actually being tested. That said, I
> won't stand in the way of such a patch to "fix" the "expect" files,
> but it feels unnecessary.
>=20
> [1]: https://lore.kernel.org/git/CAPig+cSkuRfkR2D3JqYcbaJqj485nfD9Nq6pM=
=3DvXWB5DJenWpA@mail.gmail.com/

Yeah, our mails indeed crossed. I personally do not mind much which of
our patches land upstream and would be happy with either.

Thanks!

Patrick

--Yl4KOxKKLlQq1K38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6v40ACgkQVbJhu7ck
PpT/CQ/9E4wkgriGYiQSves8P/E+k/yZbTySerZsgHLzQ+7QW8jpyZbpNxKNUzth
u/QnlYLO/LflRCmFm/UZ5+jShCs0V8HfvEhdTyugwNTlgdmBTdlgcIyskFNxet43
o2msD/zDiN0CGJPWL5r7yoPnYKoMUKtQFGP+SEQYhZ7POoYGW4q0trrgKVDPL3Vn
/Tz/IKPujGprbTGd0mlOWuI5qn9OtCOCmPUshp4gyLO/S6DprtEA0D8B/eqO7AYo
JeGjSo/SfaYfGobo/Awljt2kK8ov6Q63eB+3MKgAumf2HRyrDrLEIavahxsYe0VL
TMiw7jIywpde8FGO3gw0XR0E9fdxzn8VD5sf0FcHJ8CoNAiNg0rzwzRgb2TxiwyQ
9L+J8g00Mn6ueUW2SwyochH2DGDhi9MXWRVmR38jL+Nx/z6p3jxyN1bMwOdj6MjA
Nr1z42BjD4T6fYYAansCTDWyPkS4UXE96NLgYWzGmBCgLHt3lN5PtsuqSdoJ3sfI
tLtMPeU4Eu/Lig61NccWlJ4xNqG7r/MPWWGa3qbTvgi6U9MskjL0vHSTFhMZOn6Z
ebm8LHIlc08eRCR2j5YRApCh4XWIxpLrAtUqbsKV8A9TlXwg2IowDz+se2H5WgEq
/miEVItdLhcko5eL/NKkkvz+qCDpsporhNpyx3mX+3uvZ41X138=
=/48I
-----END PGP SIGNATURE-----

--Yl4KOxKKLlQq1K38--
