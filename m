Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41701B278
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rix6xQ3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCPaiInV"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9269E3200A28;
	Wed,  3 Jan 2024 10:50:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Jan 2024 10:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704297058; x=1704383458; bh=1nwCezLpCc
	S5Wx9LpWXqBAJdzCzIcHBUcgFrravM/j8=; b=Rix6xQ3G9WXs0eTtceNz01S4pd
	ryQeuV7k/3xeExQncawl9ZsI4PpZ4aGpa3JDtGwb88kpY7/nZcpx0FOo7nVcF4WE
	QdLCWApnIuUvpPjOTUvT7+NmI8fLfWKtczfhKyC1q0p/LYIPPzksCcemOzDEFbgO
	XuO+fpjr6rPmBssTq3dZhiYkfE0Mxw80N2kiKJlxFgS+/yV0CDf5P1mOHtadQNFj
	l1175rZSuxnacbWfYICTqIiTByBGDQI0N2oDvIay81n0rt/AYFmi9yDZlzBzVeid
	6LKeA7azAaVEca/Mr8d2qorvgfQfbO01XygHbqIHS1khf2nnBstIvhFrpYHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704297058; x=1704383458; bh=1nwCezLpCcS5Wx9LpWXqBAJdzCzI
	cHBUcgFrravM/j8=; b=sCPaiInVZwp6NJ6zTcX8iVX6Q2BzoX8jOsciQ7Rvmcz2
	ZAXpu8/exhn24jdc+6eNm2NUfC2JAz4hMn7fwHahF6qczzzcJDv8LgTUFq3PN29L
	kXh7g1OxvHvsNcGDFEWzJ6SnJGM/ISTzatzCnNVyIutbzdtsWVlKjozQYTLld4la
	fafyTg6R3TbJ7XqhV9sLKGBmXm5vftFQ/SRxldI40QPv1SPLVTc9QqBIeD5DyW4a
	/pn2cHJTn5zOO1SY0IKClFsLx0JcleFAsxamTHwjWxvjqpW16miaDzK7jXB/zFUo
	y1P6yHYsWXDv75o4J2mjnnujga5Gk+zd173CEuR5Mg==
X-ME-Sender: <xms:YYKVZaWwhEaWcSZkY4Sj2GMTTM0N6QYAu0ESb8Ef3zNe_fjxyCpsKA>
    <xme:YYKVZWmQRXNPmKGhaE2k5f2mVrKbKafx4dHig9N8KItINim0FHiNylolN8SET1Q1p
    SjlU84RqzrQ8yzw_Q>
X-ME-Received: <xmr:YYKVZeYqibqBMGpPuo7Af45al6SRMe18sIaIkWUa3dFhnIP5rXEZsbFXgnMLHUfr_mpPZAwwLTjUMLXe65G5eAr4728CCJafeW8qANQ77z-S4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YYKVZRVU3e1lhRlMBwd-F73kLLkq8IhnxO4-Fr3AYwLAGU_BajrC3Q>
    <xmx:YYKVZUlvZxb7OeLJWP_-CG-QEsDDUiFcjLpwAocd_7aR6PioPncnjg>
    <xmx:YYKVZWeUON6RRkOG3Q_feqMHPGQZR-9KFvLySm1W4PN8CGFuCCKlqQ>
    <xmx:YoKVZeh_AhtS6QfwURcrN0MWUm-kQUEDBhrZIn7pGhhL75Tdm1PviQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 10:50:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a015c8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 15:48:27 +0000 (UTC)
Date: Wed, 3 Jan 2024 16:50:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWCXFghtql4i4YE@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
 <xmqqwmsqbhyt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iRF5t0DKfZMfBTEa"
Content-Disposition: inline
In-Reply-To: <xmqqwmsqbhyt.fsf@gitster.g>


--iRF5t0DKfZMfBTEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 06:38:02AM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> > The confusion was that I thought Junio was referring to using
> >
> >     $ git for-each-ref ""
> >
> > to print all refs under $GIT_DIR, while he was actually talking about
> > "$GIT_DIR/refs/" directory.
>=20
> I do not think you misunderstood me here, though. =20
>=20
> When you have your master branch (refs/heads/master), your v1.0 tag
> (refs/tags/v1.0), and the usual pseudorefs, giving "refs" to "git
> for-each-ref" would yield refs/heads/master and refs/tags/v1.0 but
> not HEAD and others, simply because the pattern "refs" in
>=20
>     $ git for-each-ref "refs"
>=20
> works as a hierarchy prefix match.  You give "refs/heads" and you
> get only your master branch but not tags or HEAD in such a
> repository.  As a natural extension to that behaviour, an empty
> string as a hierarchy prefix that matches everything would work
> well: you'd get HEAD, refs/heads/master, and refs/tags/v1.0 as an
> empty prefix would cover all of the hiearchies these three refs (and
> pseudorefs if you had ORIG_HEAD and MERGE_HEAD there) live in.
>=20
> In any case, it is not a very much interesting to define the syntax
> to tell for-each-ref not to limit itself under "refs/".  My point
> was that you do not need a special option for that, as shown above.

I think you're just stating that "it's possible, but not necessarily a
good idea" (let me know if I'm misinterpreting, I'm not quite sure
whether I read this correctly). Anyway, let me add my 2c here, even
though it may ultimately be completely moot.

The downside of an empty prefix is that you wouldn't be able to filter
refs outside of the "refs/" hierarchy in case we'd use the empty prefix.
A better alternative would be to use "/" as an indicator that you want
to list refs outside of "refs/". That'd allow for more flexible queries:

  - "/" prints all refs and pseudo refs, even those outside of the
    "refs/" hierarchy.

  - "/refs" prints your normal refs.

  - "/something/else" prints refs in "$GIT_DIR/something/else".

I'm not sure whether it's a better idea than using a flag and I'd assume
that the implementation would be more complex in that case because the
respective backends would need to special-case leading slashes.

So in the end I'm still in the camp that a flag is likely a better idea.

> What is more interesting is what to do with refs that are specific
> to other worktrees, e.g.
>=20
>     $ git rev-parse "worktrees/$name/refs/bisect/bad"
>=20
> would currently let you peek into (and worse yet, muck with, if you
> really wanted to, with something like "git update-ref") refs that
> should be only visible in another worktree.  Should for-each-ref and
> friends learn a way to iterate over them?  I have no answer to that
> question.

That's a good question indeed. I could certainly see an argument that
there should be the possibility to list them to get an allcompassing
view of the repository's refs. It's sure going to get more complex like
that though (which is not a good argument not to do this).

Currently, per-worktree refs are implemented as quasi-separate ref
stores (see `get_worktree_ref_store()`), and the reffiles backend will
indeed use completely separate stacks for each worktree. So ultimately
it makes me think that this is higher-level logic that the ref store
backend wouldn't need to be aware of, but that git-for-each-ref(1) or
related commands would need to handle.

So I'm not quite sure whether we should solve all these related problems
at once. If we were to implement these features via a flag then I could
see us using a value-flag with which you can control what exactly should
be included in the listing. So something like:

  - `--with-refs=3Drepository` includes all refs of the current
    repository.

  - `--with-refs=3Dworktrees` includes refs of all worktrees.

I dunno. I feel like I start to overthink this.

Patrick

--iRF5t0DKfZMfBTEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVglcACgkQVbJhu7ck
PpSugQ//Waludh99kO6qp3Bzz+x8n8/fTvUABffDiNw2cao9pY3YvgukYz/qHfrX
L7qRgcWezG6ouLP6OqjhIA+cdd7v5m0rCVqpJNuZWyGoJafk4tBu0lXE8Q5UsXuP
dFyV/e6OIYyBpMq/StU9hm+5QMKiknPT1QGQxK8cs4sFfSAaeaQDi4Yh1kfWKj29
norwCxJy6dK61nhcoVwEJjDBLiB3v/KFSwBnD6hIM8bLe8JYjUWzyUENt3G/SPIN
oyc6c83gIKBXInn/MHxx4f/5Djse890A1KmM4Z1ZP3iFnhITiB7ny5Lx69BeMdWJ
f0t37lFtwNt+4rYL+fHGVr3p93uctpE4O54Dijmm1PdU4hjofbG9uqjC7dPeEuKz
HawSCtr7WRRrP8E9rqRQ5rmZfmP49m+ClZYrefXoMB26LVSKxUKzGv3mJwLmzPnx
vEjsjErC392lX8r/iBYwHomeMLHccWOfALXDz/oQ00f7QYINKoBrhIXg9WJ0al6P
C9RawjWmGufDqr0S0/hdl4g5Dke5IfVA+beQBZJGXl308yk6Q10GakSlaEG5r6jp
jFwZBXkG1p2wNhSet1bPcIKgBqNyXOS0ht8CYnJ7JA60cZ0xo5SqOeJtU9PxLYO6
MecmZkmlrDAeA+HxrSlIGrdV0sbHoLtaK9si6Ki3o17CZByQ0VA=
=W3Jg
-----END PGP SIGNATURE-----

--iRF5t0DKfZMfBTEa--
