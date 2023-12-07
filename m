Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xba7AAy2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hj9kYvjY"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B322128
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 05:13:16 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F80F5C0172;
	Thu,  7 Dec 2023 08:13:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 07 Dec 2023 08:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701954793; x=1702041193; bh=uP
	u5wN5/Oeb/lOvzI3M8KQ1vMRYBqO2gy1tNgqP4T4s=; b=Xba7AAy2R6F/bBA13m
	oTNKwVsJaTMhU5DSNEgxhoJah7yWk/bZaaVrseN0mijmy2Jlw7e6K6MPuYbwW7xz
	FIPQIkK1eUoFm5cd4POGj+33FG+clDqOodw5h8wepWZxIwKhn+WzYLZLokUd5Jxc
	Sa4Mu4xAcFMhop2d45EqVAUX6TdMv+UhRXiCYoTw0eEcaPBoOg++SaRgm4xipxF/
	PLhYV7XVsF5/YKdMFLCH1eXKmEYY27eWdVbTmRmDfsqOVnYFgkKtJhxiop33jn5R
	uhYAg8NT8PIKNsEBCUjLh/XnB4gwahsd4jBsN5hqbGSG2xCS/QLIwSoc/AVvQnE4
	yrNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701954793; x=1702041193; bh=uPu5wN5/Oeb/l
	OvzI3M8KQ1vMRYBqO2gy1tNgqP4T4s=; b=Hj9kYvjYxtVn4rXDmDPQBCvsu9ATr
	Ug2TX6DxrRlsOcUyjOGSf0DoVb40WWXaJMafUcW1aBhgLejDsgPTyigPs24xxP8B
	rQBCwCD+m+1n8RWpZo/R+sjmUb7asy3wMqxUlalz8SLGilNS86FYP0iR5Hxf0LwS
	PF1fsFO3k1Cf24KeDHvVuQNkqcbKwQuJJfyXoRzYsdxkcoJXFdKNvxnIqiUpyTX6
	aHiwNMv4IwAh+QoTL/tPnUY6+cHr0ZFwCUUt1INo6lfOOrKU77fWJS3wsfJiVEMy
	EaLXA5L7+tYHfFyyeSSgNaFAzPMtxrME3x6mWWg65eBPOg72XY3nqzjvA==
X-ME-Sender: <xms:6cRxZUfcrOWUhKDPUdQKP5oGjmvGNszXOG3FIU8WxAEtGW9briIkYQ>
    <xme:6cRxZWOw6wPqDZXhvuLnjxc3-PBA4x1pSZFv0GGBNI0SO89b_Bnb2z_d_rk1dXGD7
    DbpBFx4hdzIM0twxA>
X-ME-Received: <xmr:6cRxZVhkd9grFoulk8-i9884g44sk1ICkNCtMisT3CXRkZt1uzUQKgBOoUSt29d1c6KvmQN6aOEOIoclqLf4p1sfVeatAwGHD2X8haVDvGGbZlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:6cRxZZ81AIU0_a-26_8O3XS1ih_7NJJ0R2N_pFn4-FesHPmAibOmvg>
    <xmx:6cRxZQtzG16Es6XBjC8w0N2HuKpXFEFaMFUldUwWpuMig2ZBP75s2w>
    <xmx:6cRxZQF6FtRCoSI6_fa1wwhWUXNPF-iU7K6Zsma7sRWWEG4jXlLPLQ>
    <xmx:6cRxZZ62X2CIgeYWYeYxG5nYbBOgMPNzLYvOHsAvcLwSMLCfPD2XYw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 08:13:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5828691f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 13:11:42 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:13:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXHE5Lce_6CAWKFT@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XLc+KCMRBudSpgFU"
Content-Disposition: inline
In-Reply-To: <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>


--XLc+KCMRBudSpgFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:18PM -0500, Taylor Blau wrote:
> Now that we can generate packs which are disjoint with respect to the
> set of currently-disjoint packs, implement a mode of `git repack` which
> extends the set of disjoint packs with any new (non-cruft) pack(s)
> generated during the repack.
>=20
> The idea is mostly straightforward, with a couple of gotcha's. The
> straightforward part is to make sure that any new packs are disjoint
> with respect to the set of currently disjoint packs which are _not_
> being removed from the repository as a result of the repack.
>=20
> If a pack which is currently marked as disjoint is, on the other hand,
> about to be removed from the repository, it is OK (and expected) that
> new pack(s) will contain some or all of its objects. Since the pack
> originally marked as disjoint will be removed, it will necessarily leave
> the disjoint set, making room for new packs with its same objects to
> take its place. In other words, the resulting set of disjoint packs will
> be disjoint with respect to one another.
>=20
> The gotchas mostly have to do with making sure that we do not generate a
> disjoint pack in the following scenarios:

Okay, let me verify whether I understand the reasons:

>   - promisor packs

Which is because promisor packs actually don't contain any objects?

>   - cruft packs (which may necessarily need to include an object from a
>     disjoint pack in order to freshen it in certain circumstances)

This one took me a while to figure out. If we'd mark crufts as disjoint,
then it would mean that new packfiles cannot be marked as disjoint if
objects which were previously unreachable do become reachable again.
So we'd be pessimizing packfiles for live objects in favor of others
which aren't.

>   - all-into-one repacks without '-d'

Because here the old packfiles that this would make redundant aren't
deleted and thus the objects are duplicate now.

>   - `--filter-to`, which conceptually could work with the new
>     `--extend-disjoint` option, but only in limited circumstances

We're probably also not properly set up to handle the new alternate
object directory and exclude objects that are part of a potentially
disjoint packfile that exists already. Also, the current MIDX may not
even cover the alternate.

> Otherwise, we mark which packs were created as disjoint by using a new
> bit in the `generated_pack_data` struct, and then marking those pack(s)
> as disjoint accordingly when generating the MIDX. Non-deleted packs
> which are marked as disjoint are retained as such by passing the
> equivalent of `--retain-disjoint` when calling the MIDX API to update
> the MIDX.

Okay. I had a bit of trouble to sift through the various different
flags like "--retain-disjoint", "--extend-disjoint", "--ignore-disjoint"
and so on. But well, they do different things and it's been a few days
since I've reviewed the preceding patches, so this is probably fine.

One thing I wondered: do we need to consider the `-l` flag? When using
an alternate object directory it is totally feasible that the alternate
may be creating new disjoint packages without us knowing, and thus we
may not be able to guarantee the disjoint property anymore.

Patrick

--XLc+KCMRBudSpgFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxxOMACgkQVbJhu7ck
PpR9xw//dbbgRo54pyNKzrrSbe+/LzMav2mfXSlIwcDdtrU+mruuiFgv5NKUhQQG
PZR64wfhig2nxCSd5ZXtcNRPwK4ndWjdXG0xiLBEqXWGC6tsYMnXX7StiEbilCeO
Y8UejcHUGyZOdhwTk3lNKl+SEruv+NFr0wsPeoACxFs4/A+AUaImL4XWBWF7i43H
wdQG575ZQnDLgVYh34nnZTHQLgU2eto9i+ideoIpITlvXE5UTMMoCSIEL8SRkH/n
WlyQw5TXIva92iouilBeIgV/LcOlOxFS/6tUlGbvbGwmAYh5AVKUxYfWCMs2zlQj
Stf+It/tHaUs9xIsy+EvpEF7Ml/W8vK9f3AxxB+CaqtS4RlLiAxbjr23mlfoMy9S
k14qcZ1IdXBGOHqG8UBIRWMLjdGigmrVynWmavVWJs+u4iCEa/yJzDqHW21e/r7u
WpqyQhmQaD09qYPcfUfENZAw8xsR9JafxEVywYeW5xqinlzKSIUdYfBLNt9bqK1k
Tm9wjOwXsB7MbhYXn2PxCS8t2GgT8gl5XCBFQUATAO4CP/5RaEjCfaNj/d5k1ojI
nDfhUpaHv4lnIGlSrzy7wBv/EPAcXSdrI43BjAOXSr8osko4nNp0c2ThGHUdaiti
wv9ShKOh4DWpdhpy9YTGgfDU9YehYyNJu391waVyFQU50tm/njk=
=iqrE
-----END PGP SIGNATURE-----

--XLc+KCMRBudSpgFU--
