Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T6r9ZDbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/EVu/4K"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4AD66
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 23:46:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E1D9D5C0296;
	Thu, 30 Nov 2023 02:46:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Nov 2023 02:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701330417; x=1701416817; bh=LJ
	CXICXwdZrLmYouzAMEDNs+2PvH9jsBkk6WA4hQXsM=; b=T6r9ZDbYgjhrfZEa5l
	irWNtJ+fHZzr7b95Xw0a+Zl74mkV6cGHPh8j8d/FelQTI6DOVbQS4gDbUa3wHzyD
	VaJK4n63G3+nM4XctR0WGovrvnGoTrYJOx9FHy1V9gOaWFdmSRQYuCAToZnotoZe
	PKVPPThjt/vZ9N8KQLF5VUd2dKnFig/9v0VA3uN+WYp0xwbpOx80WrVib4fkoC6f
	6L4O/lJqpnNH/W6hO3uqMZosBdkshJ2MjWyBRGpBvp0hh454aMM2DvyuW0R9+uV3
	4MDt79CO8YGLb2UQUIbV+pQSQKs8vy0iSh7VEk83TZN/A992dXdJcgP1pGmpiIH7
	12sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701330417; x=1701416817; bh=LJCXICXwdZrLm
	YouzAMEDNs+2PvH9jsBkk6WA4hQXsM=; b=E/EVu/4KnlrChYQCo22g1VAP01xLO
	8pFl9VYIBI64hKO80rhWbHJXkuGBLag27/LgKl8nWu1WDhGbVdmJFUqg2dQBWOwj
	vGoU6COsVTvMyLHfaLwrAlRU1LOjRZYPP/DaXWKWUfW+5JO/29i5Fz02j0FPg7KA
	gEPJUKYaOqnzX9oSak6hJc1P8pVJ5zXjiLG39t0bIRU9y0c2oV66EfqCNqQVn/c8
	eDuYlBe/qaxwLGcHtib4tMOaSc0kEDyQyrIk/Zx3B4Gfz3eRcEfMRsaVPuyyqPqI
	smQlAaotClWWu6zG0jnoYeRcWSL3zQRBXAaUMEsBqZdm0ulBRN6K/l8yQ==
X-ME-Sender: <xms:8T1oZfjlapUQy8pSjMIHG8isO-S3h3AYqR_YGzdogeZV4kJqDABawA>
    <xme:8T1oZcDWtgH1PSctNrfauRqkq2ZUJnEQDq2cNDMh1Kvv5F4pOteg9IaKF2T78pAjg
    5ncNGlpoQ9gHyt_4A>
X-ME-Received: <xmr:8T1oZfFHKnC3_-8Dq7ysOuc9unTHF27TLXOAQpdmGXFEL9mA-BBhwYCl8cAzDKMvm9Oups_Rrka2O0LfthyuleFa6PJhrnCzK9UgLwOFBUaY_JrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8T1oZcSTslPcJhpwKlErhN1KCJrBnhkoKosZPndATm9SeRYLaRMYRw>
    <xmx:8T1oZczGvoBmXXsErOdMREoIM8yEsW2QZLoz7Ia-50zh7BpBsj5jIA>
    <xmx:8T1oZS6JzOT7BnMjAFmzJP3v_vM79WY8cJbHhIr3V-LsSgrUgmnbkg>
    <xmx:8T1oZZrTduaEYVyDC32YRf0-XJUtjVIYxboPmNRV_pc1mvMMi4N18w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 02:46:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0aeff01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 07:45:43 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:46:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 0/4] refs: improve handling of special refs
Message-ID: <ZWg97gfn80jeB3-_@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <ZWe3z59WGE0+8gXN@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nb+ket7qVDlX2Mhf"
Content-Disposition: inline
In-Reply-To: <ZWe3z59WGE0+8gXN@nand.local>


--nb+ket7qVDlX2Mhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 05:14:39PM -0500, Taylor Blau wrote:
> On Wed, Nov 29, 2023 at 09:14:07AM +0100, Patrick Steinhardt wrote:
> > Patrick Steinhardt (4):
> >   wt-status: read HEAD and ORIG_HEAD via the refdb
> >   refs: propagate errno when reading special refs fails
> >   refs: complete list of special refs
> >   bisect: consistently write BISECT_EXPECTED_REV via the refdb
> >
> >  bisect.c                    | 25 +++------------
> >  builtin/bisect.c            |  8 ++---
> >  refs.c                      | 64 +++++++++++++++++++++++++++++++++++--
> >  t/t1403-show-ref.sh         |  9 ++++++
> >  t/t6030-bisect-porcelain.sh |  2 +-
> >  wt-status.c                 | 17 +++++-----
> >  6 files changed, 86 insertions(+), 39 deletions(-)
>=20
> These all look pretty good to me. I had a few minor questions on the
> first three patches, but I don't think they necessarily require a
> reroll.

I agree that none of the comments really require a reroll, but I'll
address them if there will be another iteration of this patch series.

Thanks for your review!=20

Patrick

--nb+ket7qVDlX2Mhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoPe0ACgkQVbJhu7ck
PpQQzA/+InZV7kRORhNGUvkM74QbTqsERwDpDPmkkiYCJBp0V+PzkBQpmcafsvZm
Bbq7Xzi+goLfn0KYUBCVnACpAOH8RVRam3pFeKVMLCzDrHU6q5M/hN+9ox+5nCxt
8iKLiY/iJmwpAqAb2nYV/b9bCIegPPYCdyoEN3ziPr9yAsSMe14fjL9Ovi4U+KbZ
M7Qg1SujQMZNuKHHZcCmmsa1tBPgyGCPYcxZpll3Zv6alvp03LlnN8GrKkRClGqe
iL88tJ9KauTFAu/QhQS0LzHYRS6WdOpPoAIOflMM64LkcgS7X+eFOvPFFETq2rXK
fFVhNWBMfwW8u5qsJpMLFowOHPQeGTpH/uukSbqMKqqU0BSaR9bb9A/1SaoQDpx7
8McITRB1ldnQOdsiwHA70pOwiR1woKUHOVOq4SrjM4ZvWRdVUb5OoG7WZWKATGrf
9zeNaogbc4kAMxIsU2IZTyEIONYsr5eLuL+n4osje2EKTJUPycEnxHL7SIxCGNfk
1RBzOKTDxNtlKW14FapEKW2HLMa15KbGhNLsV4LwDrSVp3HzO9skvK4O1JF2z/TP
HDZZMFn+2H3EFJZkQndcYL3wQnBPs7ojvuty42m3nJeCeQJW4E7h8rq45GI45hxq
uuXwIN20a4M1A9hBBlV1wUSRcywPRwTVxLXDVngvpM9Fxyi5ldU=
=deEJ
-----END PGP SIGNATURE-----

--nb+ket7qVDlX2Mhf--
