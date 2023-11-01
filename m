Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABF11C86
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZoL7s6+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ssf4v+c+"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47759111
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:44:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AB78A5C0505;
	Wed,  1 Nov 2023 07:44:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 07:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698839067; x=1698925467; bh=XO
	RVHFMLaM+WwFRbcf9CgSMYDid8jAYKT+VQv96KOXg=; b=ZoL7s6+yB8dowp3sKr
	MaIdbVjMwK4PYquTDue15KySLquMju5iCvGHjz3AZqUi2rF1Y3yXaDVNEZcdqzeN
	EKokwgK3zNFjr2VDsP5HLECHaHa1Un7lDCyTtgbqfrCpAqslDyvL1cCa0o11yR7Z
	x64f+O2/bMOoPP3BVLW1MU/zAH6YirydH/dJc3Gf79gh5fLEgOVwBy7gHkVrOLeg
	KR1CON8+BCQvA8t+hb80HeZ8ABNgYR1aN2ENClJ32nbxlv6w6twAN5UEv9lHWzFC
	otkqM5hufgfHrioi9Y70922L6JCeAekOGjeJ9qyDg6IEQ7Y3PY/d7SWa2FXqjd/H
	DiRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698839067; x=1698925467; bh=XORVHFMLaM+Ww
	FRbcf9CgSMYDid8jAYKT+VQv96KOXg=; b=Ssf4v+c+i/Gp6kRyS/6pzkxNX54kU
	QkqUS04MWh2muXXAnrGpIKctXO4l0UrhxtE6D4ugKdF6+IDszXsPkY4J6w4wYo/x
	7apjzrz9e3sdzqYP9FFKOc3fOiani3/dPdIqf2e6ofW9xlvkAtX9LCP2au0/6Hx2
	bOdbXWDa+hVhwF+WEYPZ6bfBrlAVOQRZsksDkKjco/znfvaQEMpYuAkdo2D7FbVF
	OSMhezfCTsuxei3uerlE4i78uylxwPTDq6nIPzy0OFURGa6J/QmZHKRh7z5EzSzJ
	eghKhs11osJCgNBzz9UCy7+SVwIG57KDgGggulZYQSX+hP+4IPrpZpMLA==
X-ME-Sender: <xms:GzpCZd8wcGQ8IQQLyp2dWMazikTNDmZRe6KUw--ox2MDOAqSA0xJLA>
    <xme:GzpCZRtFN0d0AJ1Nbf8_rFpStZBJbjnhEr81suLHZF2V5v6BJc1SJAGxVIeMkCidZ
    vno1sbdxkPAMgWh_g>
X-ME-Received: <xmr:GzpCZbAG4xAmP166yeL1zUpOdfsZiXayTihKOUoC2b2fZkrgRXFZ9EpjWYorCfhM_frR8JFj4LXJr4QGdOmjb1uaTygFweLLFd_gVYs3LdebNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GzpCZRdlzzcjStLv8TXdYyvvKHpPf9mxy09nKsMDsyME--2HvbJ3Jg>
    <xmx:GzpCZSN5mHcFstfosMv_8MbD95hty0rXUoo3s35zY05CMgxo8wYTaQ>
    <xmx:GzpCZTmi629Hi5uYxr_3qMtnd2SimYfjmkceOuqPSI1GmgShZuvI0w>
    <xmx:GzpCZfq2ZX_topacr_1Vb2rZw06XvWuLJd3L3wr8j4K6fR7KQ6WQmA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 07:44:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a7d722e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 11:44:13 +0000 (UTC)
Date: Wed, 1 Nov 2023 12:44:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye <vdye@github.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v4 0/8] ci: add GitLab CI definition
Message-ID: <ZUI6Fqj7QJQG6ox-@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
 <8e4d111f-3982-4989-90b5-08377fe9c5fd@github.com>
 <xmqqpm0uw41b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o0dh6iuDQjCaCFm/"
Content-Disposition: inline
In-Reply-To: <xmqqpm0uw41b.fsf@gitster.g>


--o0dh6iuDQjCaCFm/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 12:22:56PM +0900, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
>=20
> > As for adding the GitLab-specific stuff, I'm not opposed to having it i=
n the
> > main tree. For one, there doesn't seem to be a clean way to "move it in=
to
> > `contrib/`" - '.gitlab-ci.yml' must be at the root of the project [2], =
and
> > moving the $GITLAB_CI conditions out of the 'ci/*.sh' files into dedica=
ted
> > scripts would likely result in a lot of duplicated code (which doesn't =
solve
> > the maintenance burden issue this series intends to address).

It is possible to change the location of the `.gitlab-ci.yml` in GitLab
projects, so moving it into `contrib/` would work, too. But it does of
course require additional setup by the project admin.

> > More generally, there are lots of open source projects that include CI
> > configurations across different forges, _especially_ those that are
> > officially mirrored across a bunch of them. As long as there are
> > contributors with a vested interest in keeping the GitLab CI definition
> > stable (and your cover letter indicates that there are), and the GitLab
> > stuff doesn't negatively impact any other CI configurations, I think it
> > warrants the same treatment as e.g. GitHub CI.
>=20
> Thanks for expressing this so clearly.  I do prefer to add this as
> the first class citizen (more generally, I do not want to add new
> things to contrib/ at this point) if we are going to use it.

I certainly know that we in the Gitaly team will use this CI definition
on a daily basis, which is my main motivation to add and maintain it in
the future. I personally don't mind to add this as a first-class
citizen, because for my own workflows I'll certainly treat it as such.
And if others can benefit from it, too, then I'm even happier.

I'll keep it in the default location at `.gitlab-ci.yml` then, thanks
for your thoughts!

Patrick

--o0dh6iuDQjCaCFm/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCOhUACgkQVbJhu7ck
PpRdpw/+IVAWL2R8F++IRFWvrk6FaLFRf3NHHVln4ZygP7uupbWj1QiJeNRoLKMh
9Ej3b+rskOMZH/rWiSuksSc5a/yMIni8DH4ma+8hY0NTtIkvVDVxZmg3gXRCg7wh
oWG9XotQURr1/jGRRzZYURqeVQoS+9l5cT/rF/h8rTqe+SU2nVIvQMkUwqJa5SoL
PY8zZ1et0hpvw9wFsMrSN24qwWXdSg6UlPQyQ3rzLmrccXoRwNmpIwPdku9kaYJL
vbQypeGt8Ddax4IsYMvcv+xLqL/bGwq5EWLKr7VYisgBXSrXTPFq/Fd5DqfeQQ03
Six7XXmDW+CWZeC+YKDjacc4VoT1tLXwUla9YO9NCprRmEk8G7K/gL1coxPXQEZz
Exw1Ffh2+m+dFcSmWj8GnKyfgIIUcfC+Ri74qRu3RZFzrOpL1mKd9QIijdhRIDOQ
NtsT+wJlw3PGMWshSz25OXXGa+yHg9axsjd0nAFgAlHBArGcquJWnF6L9mZqiInB
8HXFjgIdM6ACo6tmj1tP5zAanqPLgc96+jqOAF+9GjZqcBkWXuYZh3FdoGL/hhKY
CRH1ldQCUH7uSkQcNRnb4a0Yx5Xbrs8TB+gFdGgufg6m+bEBzeO5AFJCv70VamOY
I7lT3XmPqPSasVBbonMCe9Fe38s3QpUod2yniOTs83fe25A4LCI=
=PDAY
-----END PGP SIGNATURE-----

--o0dh6iuDQjCaCFm/--
