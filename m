Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48E63A5
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mw5U6jni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLltyzsW"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42F122
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:45:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 22D595C034D;
	Thu, 19 Oct 2023 02:45:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Oct 2023 02:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697697938; x=1697784338; bh=JL
	58iU1ACKDYMY1bbYfGVtbRaS3wHCBQsNJ72I1jv9o=; b=Mw5U6jni+qa3xH0wmK
	Q1HbkjXkSCmSdD6sDelb9Copq398kX1j1YkPH1k2H4LYpiOFP5uwGx5fxG4//UwY
	9xbNjL093s/LOUGHyh5pXE33P69nGRZHHDOGi7svaj6qGG/iEnNd2tk8Etp1TtiV
	VzJn6pe0kZoCeKbDuucMvS2oRSbzyzSQr0jxI8sDo/y5nbfucirxlyL93y1JowTG
	J7WSTb2fQ0aAh9H1RAMrHhbIB1CQThqXoYQRNZgTdzJ2liv0NQ8Tb8IXh00p5UJD
	BcqKm7fak/zBb+TgOwQ/zsdRKtKUaXDRMpFBfdrOCVmfNekLSMsKU0VsjN9aFj7W
	Hz1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697697938; x=1697784338; bh=JL58iU1ACKDYM
	Y1bbYfGVtbRaS3wHCBQsNJ72I1jv9o=; b=lLltyzsWn4trs+yEo5TJZ/HQyVUxV
	rfTSxDMihuV6+s2rXhmw2GgTy+8rFlaG7GDnrSED+2CekcGb4KmNyfYzucdCWbyV
	4MGWaDJmbR3xeqar9vopNLlu2zCM+HLw0W0uc+NlVqBuHTkgTzT0HHMapf79DOIT
	81tdKUdo3t0cegn8VuMCGAuQ8p640S77CFwtdthLRGfPmwAmcIDfXH1QgPuk9Xhu
	Txup4nIE8x2fGj34/ykNey+xFB1XrZX66ZMshmzfN6AjwAbHBXZpSejE875FoG0B
	56m4Ztz4Kk+PGmtruG/6wXjHAAxIM4ovYYirkX1qqFqxeE1PHVjSJy/MA==
X-ME-Sender: <xms:kdAwZYzViLOGEwpEmWtZ8xgCsKdfOukJFtuwuTssUakQsyhLeB2WbQ>
    <xme:kdAwZcTQJO74znzutyNcG2n9w8o_OpQln9S94e8IMoCDjF01wgNub0ava5rDe2nfy
    fbPJ5UQFULOPZV05w>
X-ME-Received: <xmr:kdAwZaVTTd0hEIkKEQG82UruWJrJyoHjwAovnC1BggxDbT0JShX5MJnq6deZ8ZIG2zrVwIJBwkUT78A1j7gcayx1OGvjDFoLDGNb_GZA7N4xRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeehgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kdAwZWhHEir89-nars4zFRBIT-Bfr_BgVNQkajcesJ1-wnYQAwf4mQ>
    <xmx:kdAwZaCbE5Z8_ozaDIIO1B0wKtOzA8sSq6PyDNmO0NyFB1ySbxzPGg>
    <xmx:kdAwZXKfkTx4Z4fqL_AxxE1FpYDfD1LQKX-xOVsT-sbe3vzdbgzvHA>
    <xmx:ktAwZdN8GiGBD4VcgzqpcgjDWQ8aovZLLSsQIaC5aFvUIACZIi2CxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 02:45:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9eb3046 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Oct 2023 06:45:31 +0000 (UTC)
Date: Thu, 19 Oct 2023 08:45:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <ZTDQjangLsQ1cSJl@tanuki>
References: <ZSkCGS3JPEQ71dOF@tanuki>
 <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
 <xmqq1qdy1iyr.fsf@gitster.g>
 <ZS4rmtBTYnp2RMiY@tanuki>
 <xmqqjzrlhzci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSGfCm6/kUrqtWw1"
Content-Disposition: inline
In-Reply-To: <xmqqjzrlhzci.fsf@gitster.g>


--JSGfCm6/kUrqtWw1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:34:53AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Fair point indeed. The following is a worst-case scenario benchmark of
> > of the change where we do a full topological walk of all reachable
> > commits in the graph, executed in linux.git. We parse commit parents via
> > `repo_parse_commit_gently()`, so the new code path now basically has to
> > check for object existence of every reachable commit:
> > ...
> > The added check does lead to a performance regression indeed, which is
> > not all that unexpected. That being said, the commit-graph still results
> > in a significant speedup compared to the case where we don't have it.
>=20
> Yeah, I agree that both points are expected.  An extra check that is
> much cheaper than the full parsing is paying a small price to be a
> bit more careful than before.  The question is if the price is small
> enough.  I am still not sure if the extra carefulness is warranted
> for all normal cases to spend 30% extra cycles.
>=20
> Thanks.

Well, seen in contexts like the thread that spawned this discussion I
think it's preferable to take a relatively smaller price compared to
disabling the commit graph entirely in some situations. With that in
mind, personally I'd be happy with either of two outcomes here:

    - We take the patch I proposed as a hardening measure, which allows
      us to use the commit graph in basically any situation where we
      could parse objects from the ODB without any downside except for a
      performance hit.

    - We say that corrupt repositories do not need to be accounted for
      when using metadata caches like the commit-graph. That would mean
      in consequence that for the `--missing` flag we would not have to
      disable commit graphs.

The test failure that was exposed in Karthik's test only stems from the
fact that we manually corrupt the repository and is not specific to the
`--missing` flag. This is further stressed by the new test aded in my
own patch, as we can trigger a similar bug when not using `--missing`.

For end users, object pruning would happen either via git-gc(1) or via
git-maintenance(1), and both of them do know to update commit graphs
already. This should significantly decrease the chance that such stale
commit graphs would be found out there in the wild, but it's still not
impossible of course. Especially in cases where you use lower-level
commands like git-repack(1) with cruft packs or git-prune(1), which is
often the case for Git hosters, the risk is higher though.

Patrick

--JSGfCm6/kUrqtWw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUw0IcACgkQVbJhu7ck
PpTZyQ/9Fte2uQf+cmEj07z2qziSgWGLJjzoWT9TMDphmV0xyCcb2HGZWdjoU+UX
8fnNeL/ubee/4mZFLNs+Swi29d4OZkcDsvzrcVMQnhROa/XbQ2jAMrgmovajqSBB
PN5F5NtoQz084TrLd3D+6uYooE2eaI67a9abLJ7adac5iI6giiXnNC1FgZorAZN4
0oBbEpfVlXa1bo2OvB8tXw+u0zLL0vJ6SofcS3zMhbc4zpx7Y83zklGVSqJoPiJs
i0XbFZLpNk1RH2XZSt3IxMWFMbAYZkP+Nxa3BXFH7/E8YHQnU6eZd08bnI/V1+n9
js3F3IT1vKiFsld2tHi2QdbOCTbwwn18GnzuPMz7ZeBfXQec391G2lvsz3CeAVcU
e+VPms7gNf6L/odTyqrVYHRZglN9/MnNPHgqdJeWvL/XnES9XfuSeCBMHTOlvuKO
vwzR6l23p5S60wfe9DdJzGdoqhWLlw5VxNXGzgNbK3vNrGg9HGbWQf5ru1TxgCRh
vzDAx9inkD8TiwYP+Y+WnfqZFBY+7gS65HpXs3rCgidiBPFR7S8EhjmOM0w2fF/y
2iyQrYZrNYxnC11D0Npr8N4zVumwXdtpTAyHUSiNItH+1SDuY9G/BRbRgTUGgmqa
uIAZQ1zDafiIyPyQZA5P9wUErAH/Pp2Aey1Cc1pJT++CI7Up4/c=
=sVsV
-----END PGP SIGNATURE-----

--JSGfCm6/kUrqtWw1--
