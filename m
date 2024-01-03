Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC851182A3
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dfehLhDX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8x1hwmEL"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E0AE5C00CF;
	Wed,  3 Jan 2024 03:11:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 03:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704269471; x=1704355871; bh=QPwWD1dMaq
	WlZ+5PLrNL9GGagLSpdPKxoVGpODsgdxo=; b=dfehLhDXbDzq1zNCm7MxBrc7A1
	iU9j/8HRh+VAcRoIUXrrHdZlmuNtmAKvkR8q8xibbMo01RJhgLS21Kv0ntYv4ymD
	uu9ahHrgZ8pL5i4FT1nEK4Aw96qZEIXEd8IAbOu8doLpU36GtTn1CUQ0SMBjZvHS
	nvuEhfWBDSGkmB7jggbQiah3fkc5I6Qz3lczM1Lj3AyuknKGQOePTI3Nfl1pSraZ
	6ZfFdWd//Pm/MvgZkVz5yrV0/fSwUbGKuFSF6Uq+gSZipSlP527zk4emnMkXVsCe
	lpuG8hrD09Sy8+YHy6h9+ii8yJD1BPduyLTC7e6ey9lWRfVr9cMLjiDP1FRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704269471; x=1704355871; bh=QPwWD1dMaqWlZ+5PLrNL9GGagLSp
	dPKxoVGpODsgdxo=; b=8x1hwmELx36CBZuerl73wyCIq9Z6/szW5BWnf0ey86P3
	VTicOGD8GYYjObwWPbcZbS8PvdFw/+IK+0TesxHWfVp0kv0HJsZ+RnENl/mAs1aP
	ySTsbdN89A2/E968YlKGocIukuiVpf2JjuAv3VXjwXXo+0zBY4UdaWWShqJqI61g
	vy3Ot+3CyUdGh5TDTeCyNcCC+fX5ArEt+/zcP/kH5M46/etGyiDcIGDk9QxjzzeL
	KLUnbS1xHI/evJjY0ruGUurxV+EBVnV1tvprdStPELcZjDTwzBAadwGs8oyEygoX
	kSDm5Cu0cDAJ4nedt+0iDb4F/xoQ/5rEHifDyOQnvw==
X-ME-Sender: <xms:nxaVZYbHmDYVIeLdiRMfrYAInayUy7X8u_dHq-56xENETpG3rJ36AQ>
    <xme:nxaVZTZ0ze3DfTXmBsguspzGaN2VShfQWIUGCS57OkcwJqoNYOC3_qtc61iGsRvi5
    cz8NKMyenOKQbl-Kw>
X-ME-Received: <xmr:nxaVZS9XC8S9zYMfxZoD-9wP_ce_ghXnMsQ18s-NoKBQq61sWTV5jP4HFkzyvbE2_h6zGja2RlK_gDgTC0QlDVhR4ySpi_OcBkQXpJ3_E63rKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nxaVZSrFXw-Af2N4Dj5d9BeIY8TgxNy5UDWCFi9a3gNXHr2-bi7D0w>
    <xmx:nxaVZTpz5gHajidxWQX5dVzkyZuBnkiPFRfTwUc7yQ5pqnboOB0aWQ>
    <xmx:nxaVZQTIA-GXmuar9ugs_MIdUb-3Q3vJQj7rMJYCfTgWgxL38KdzCw>
    <xmx:nxaVZcCLNie4-4DGqso3YxNWfaYobKNDzePrgWwsmpr3daX4QWJPDw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 03:11:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba358bb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 08:08:43 +0000 (UTC)
Date: Wed, 3 Jan 2024 09:11:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <ZZUWmy3rTjpBsH-w@tanuki>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
 <ZZUNxNciNb_xZveY@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jzgfWFrsYVXD1+g+"
Content-Disposition: inline
In-Reply-To: <ZZUNxNciNb_xZveY@tanuki>


--jzgfWFrsYVXD1+g+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 08:33:24AM +0100, Patrick Steinhardt wrote:
> On Sun, Dec 31, 2023 at 09:27:19AM -0800, Junio C Hamano wrote:
> > Stefan Haller <lists@haller-berlin.de> writes:
> >=20
> > > I can reliably reproduce this by doing
> > >
> > >    $ git fetch&; sleep 0.1; git pull
> > >    [1] 42160
> > >    [1]  + done       git fetch
> > >    fatal: Cannot rebase onto multiple branches.
> >=20
> > I see a bug here.
> >=20
> > How this _ought_ to work is
> >=20
> >  - The first "git fetch" wants to report what it fetched by writing
> >    into the $GIT_DIR/FETCH_HEAD file ("git merge FETCH_HEAD" after
> >    the fetch finishes can consume its contents).
> >=20
> >  - The second "git pull" runs "git fetch" under the hood.  Because
> >    it also wants to write to $GIT_DIR/FETCH_HEAD, and because there
> >    is already somebody writing to the file, it should notice and
> >    barf, saying "fatal: a 'git fetch' is already working" or
> >    something.
> >=20
> > But because there is no "Do not overwrite FETCH_HEAD somebody else
> > is using" protection, "git merge" or "git rebase" that is run as the
> > second half of the "git pull" ends up working on the contents of
> > FETCH_HEAD that is undefined, and GIGO result follows.
> >=20
> > The "bug" that the second "git fetch" does not notice an already
> > running one (who is in possession of FETCH_HEAD) and refrain from
> > starting is not easy to design a fix for---we cannot just abort by
> > opening it with O_CREAT|O_EXCL because it is a normal thing for
> > $GIT_DIR/FETCH_HEAD to exist after the "last" fetch.  We truncate
> > its contents before starting to avoid getting affected by contents
> > leftover by the last fetch, but when there is a "git fetch" that is
> > actively running, and it finishes _after_ the second one starts and
> > truncates the file, the second one will end up seeing the contents
> > the first one left.  We have the "--no-write-fetch-head" option for
> > users to explicitly tell which invocation of "git fetch" should not
> > write FETCH_HEAD.
>=20
> While I agree that it's the right thing to use "--no-write-fetch-head"
> in this context, I still wonder whether we want to fix this "bug". It
> would be a rather easy change on our side to start using the lockfile
> API to write to FETCH_HEAD, which has a bunch of benefits:
>=20
>   - We would block concurrent processes of writing to FETCH_HEAD at the
>     same time (well, at least for clients aware of the new semantics).
>=20
>   - Consequentially, we do not write a corrupted FETCH_HEAD anymore when
>     multiple processes write to it at the same time.
>=20
>   - We're also more robust against corruption in the context of hard
>     crashes due to atomic rename semantics and proper flushing.
>=20
> I don't really see much of a downside except for the fact that we change
> how this special ref is being written to, so other implementations would
> need to adapt accordingly. But even if they didn't, if clients with both
> the new and old behaviour write FETCH_HEAD at the same point in time the
> result would still be a consistent FETCH_HEAD if both writes finish. We
> do have a race now which of both versions of FETCH_HEAD we see, but that
> feels better than corrupted contents to me.

Ah, one thing I didn't think of is parallel fetches. It's expected that
all of the fetches write into FETCH_HEAD at the same point in time
concurrently, so the end result is the collection of updated refs even
though the order isn't guaranteed. That makes things a bit more
complicated indeed.

Patrick

--jzgfWFrsYVXD1+g+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVFpoACgkQVbJhu7ck
PpRiiw/9FUM0Hx+Y30CO/AFvIu5Fv8HR10mKeRj0kBZ92I/at1agbNODi943Pbeh
f90RMJJfI+ewBgc1J9kE4+Th9L6RkUxll4BzSn5aovycdSeTU1oH/OWQbxXO5PQB
M5H7NPdAZMe/C8yruPz2U0VsiFIU6Kfn6gn8MXkVlPu0djB7WpNVet3K61gJWiSu
xIPVOb1YI819avZZgZ8fDxCqndj+gxf5UfcnaM1EL24EtfqT9QNGRH0GnkCjwtxQ
SpnDhRVhAwF80+xWeaXC2F3UseMf9ch4Jpt90O7FaZIBMzrGTHOM9QQ5DgRoxk2K
GtAnX39CzRUI7yKbxmB4Mfk5he+uf9QK/ySm4Fs51gAgzv193/M+mwBBTSg6A9wE
x4Lb8T/mLPj8/n7TpiZOQdsgs7UupT3mtvOIukh9CVIC5CeZsNGrIy30/xqWY5V8
ZBI5qv0xg6WHckC2on5CGyoj8ODdiBXe6uwIvdJmFavfN6OscOfx3qCZ6eXhQ6cY
KZj13iCzRnzV/PNLYbBP3nZ7O++jtYkw8QatIHKlnsI3FRzr73xJVyjmoImkZAf8
a5YHG0Eejdgcp2oiJtBcQKYdaoWe07KBMnl4ME47rt4bp92xTAGHHFm8xegeimO2
nqFO4eA8cP5qfC15kRvd36i8xMd+p+nIZ4uCAK0jEj66tuy0ZOs=
=vWjs
-----END PGP SIGNATURE-----

--jzgfWFrsYVXD1+g+--
