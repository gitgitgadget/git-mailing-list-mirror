Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EGWXbpAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnX8gZIj"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B04196
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 23:42:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 943AD5C00A9;
	Thu, 30 Nov 2023 02:42:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Nov 2023 02:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701330172; x=1701416572; bh=IG
	ZJhcxoAyBpLsJ/5oyLQmW6hnr1IX5FR9udAKUcPtw=; b=EGWXbpAk07+eo1XizU
	gwnAarjKwqC8QpUSxNBK+lAC5YhodrbtGM/3oQQh5ghnhWSU++M3GKHC3DNBkkP9
	UUMwYGIgnulrm6IpXbJszqx1EIYE/Wg6WFM+izq8IuOenS2hakjSDqjyzWXffXAo
	AF363LHSplLNkvMnUIj2I9NmpJcyHnmHS7WEl3Wz8aLvJCduywQGd5N/oNLQABfA
	44ansaa/i/SKHN11gZtnxmQabGNf6sW2M1Wrh99LxG/cPOlPgy9A5AYnK7+fc4aD
	nWiW1JKt2p5RYJ5CNpJjh+tk7qlZe3myeQDYI9JQJkX583Ca4dsGsDlsQTLI8vv7
	+RfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701330172; x=1701416572; bh=IGZJhcxoAyBpL
	sJ/5oyLQmW6hnr1IX5FR9udAKUcPtw=; b=BnX8gZIjf8DAU69XucXQ566Exs3B7
	4rh+KsiFBxbHwTfUsqVCtszB0N/7WnlOZmECTy9bzwGEQJnA/Mp7Pe4SGafRovRF
	0kZBxH5lDPbNXIzgMye2nL0xWI6GxN92nTUd1YHzGYSbULw8PGiaIkuBvrr+qsPY
	EDFMTaJ3e+8rQ+HlPhGnvuxu7W4IgwDhaCRHkal/fj+uCC1euXBNC7IiGxIGIpUv
	t2TtQdj6v0thvUpzKS2/GwM7ZtMRkPUNnk2oh+t/9SOZJaRtC3udb37/sseDuhjD
	5AF1LK+nv9SEbzytKvHMsbGLidNgMItN/bxd3TZiaW7FKbjvExHn6D+fw==
X-ME-Sender: <xms:_DxoZeSqdL4J0HnBW1s-UeINj3USmgFoE7mlD5ouk7JeiMmKf5Q26w>
    <xme:_DxoZTy3W3M_MSzRwZrqhnHw86tzc_WldV0JS31iWkGyLTocBTXTK8IglDnVA1KqJ
    JTnzpVRM9GadlJUDA>
X-ME-Received: <xmr:_DxoZb1EXW9ziwS_MM35sK3Ptpiyevb_rTPCCOHrIJkuxejpMvC05E0KcbTxcCYEIil12pSTG4uKdHnqrZ_stPevs39IbYgeQCibg5EULbBQIRCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_DxoZaB-l7_uowJGwMZF37MMAZDqr1pqLKR40yItTB80qbeqk4Cu4w>
    <xmx:_DxoZXhuCGeZ3sQDSACHC5mLJeU_owL9VKjAmLKL02Sbgsg4aN2Jnw>
    <xmx:_DxoZWp1Xdlk_VhyEsdx3gaaWNIzgNPAfcjrYVHYi_A6pbCSB3Va9g>
    <xmx:_DxoZfa9o5JKnwxroM1R96pbsv95WtF-mXYDmzTJekdvOHeo2_MU2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 02:42:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e1cd750 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 07:41:37 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:42:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZWg8-HW6yCa6-tnS@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <35b74eb972eed7e08190e826fabcf6b7a241f285.1701243201.git.ps@pks.im>
 <ZWew3CP4QJ4XDnHj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxUSDxdxlG0EKEGM"
Content-Disposition: inline
In-Reply-To: <ZWew3CP4QJ4XDnHj@nand.local>


--nxUSDxdxlG0EKEGM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:45:00PM -0500, Taylor Blau wrote:
> On Wed, Nov 29, 2023 at 09:14:12AM +0100, Patrick Steinhardt wrote:
> > We read both the HEAD and ORIG_HEAD references directly from the
> > filesystem in order to figure out whether we're currently splitting a
> > commit. If both of the following are true:
> >
> >   - HEAD points to the same object as "rebase-merge/amend".
> >
> >   - ORIG_HEAD points to the same object as "rebase-merge/orig-head".
> >
> > Then we are currently splitting commits.
> >
> > The current code only works by chance because we only have a single
> > reference backend implementation. Refactor it to instead read both refs
> > via the refdb layer so that we'll also be compatible with alternate
> > reference backends.
> >
> > Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. This is
> > because we didn't resolve symrefs before either, and in practice none of
> > the refs in "rebase-merge/" would be symbolic. We thus don't want to
> > resolve symrefs with the new code either to retain the old behaviour.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  wt-status.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/wt-status.c b/wt-status.c
> > index 9f45bf6949..fe9e590b80 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1295,26 +1295,27 @@ static char *read_line_from_git_path(const char=
 *filename)
> >  static int split_commit_in_progress(struct wt_status *s)
> >  {
> >  	int split_in_progress =3D 0;
> > -	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
> > +	struct object_id head_oid, orig_head_oid;
> > +	char *rebase_amend, *rebase_orig_head;
> >
> >  	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
> >  	    !s->branch || strcmp(s->branch, "HEAD"))
> >  		return 0;
> >
> > -	head =3D read_line_from_git_path("HEAD");
> > -	orig_head =3D read_line_from_git_path("ORIG_HEAD");
> > +	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
> > +	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid=
, NULL))
>=20
> Switching to read_ref_full() here is going to have some slightly
> different behavior than just reading out the contents of
> "$GIT_DIR/HEAD", but I think that it should be OK.
>=20
> Before we would not have complained, if, for example, the contents of
> "$GIT_DIR/HEAD" were malformed, but now we will. I think that's OK,
> especially given that if that file is bogus, we'll have other problems
> before we get here ;-).
>=20
> Are there any other gotchas that we should be thinking about?

Not that I can think of. As you say, a repository with malformed HEAD
will run into other problems anyway. And `read_ref_full()` would return
errors if these refs were malformed, which would cause us to exit early
=66rom anyway. So unless "rebase-merge/amend" and "rebase-merge/orig-head"
contained the same kind of garbage we'd retain the same behaviour as
before, and that shouldn't really be happening.

One interesting bit is that we don't set `RESOLVE_REF_READING`, so
`read_ref_full()` may return successfully even if the ref doesn't exist.
But in practice this is fine given that the resulting oid would be
cleared in that case.

Patrick

> > +		return 0;
> > +
> >  	rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
> >  	rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-head"=
);
> >
> > -	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
> > +	if (!rebase_amend || !rebase_orig_head)
> >  		; /* fall through, no split in progress */
> >  	else if (!strcmp(rebase_amend, rebase_orig_head))
> > -		split_in_progress =3D !!strcmp(head, rebase_amend);
> > -	else if (strcmp(orig_head, rebase_orig_head))
> > +		split_in_progress =3D !!strcmp(oid_to_hex(&head_oid), rebase_amend);
> > +	else if (strcmp(oid_to_hex(&orig_head_oid), rebase_orig_head))
>=20
> I did a double take at these strcmp(oid_to_hex(...)) calls, but I think
> that they are the best that we can do given that we're still reading the
> contents of "rebase-merge/amend" and "rebase-merge/orig-head" directly.
>=20
> I suppose we could go the other way and turn their contents into
> object_ids and then use oidcmp(), but it doesn't seem worth it IMHO.
>=20
> Thanks,
> Taylor

--nxUSDxdxlG0EKEGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoPPcACgkQVbJhu7ck
PpS9CQ//VrXuPqnEqMKSnXkgKs2Bt+zlxPy/PYvvg7iuSoSYe43Ms5X2EXPMXczL
e90nQpzyscPO92ZPZe/VdNpyN52cSIPACQi1lFZq96HoWnuZSGqw7CGteGM9Ktlt
Fw/7G+t7xgCbE5lgsuzwqM/Z65MRZiwFjxvvJpisrLys92tU80A7kEQq+DCVz3QB
ZM5IVpXTATIPLwPCeOPqUOTyqpyURpg0U18mymOCRYCNJfYTmqY7FV+kCFNNcnsu
CkKOJJ3vZWP8q/n+k0570k0VA+z0dqK0PJbkwrRkORnV8HPp2+74v72gdExWiDna
dQ4p9WbP9LPmS/7xmI/RliVcp7tF8HavXGTWIEnW+new+RMreGoNVTxSaBbr1WqH
81Bq6wtc+d1wPRw+oeqhxoG9gW7cTB2HzOnrNPGUgEsiYjf9gaCDbnWOxaWUjDaq
7J61Dq6rOknP5+a3AHEIv9fLnYM66Taje0lJxLR+SLWFcUMELmAxDQ166BcSlB3C
yH0Ja0X9pNQvpvqTp+F0RrwXnQRTwJ5lqg6gBB8bRHd/iJX1nO5YcZc3AqMADgzx
g3iMELwd98Iv52c/gzulsBuFEqn1o1ilKgPirY+Tz9yvO8fNw6xyxG/Pz1BK3vsF
IZwG717mhLziR+5v+AanJZgxf/7zjzunCn1mJnrTjw4RraHhWYM=
=vBrF
-----END PGP SIGNATURE-----

--nxUSDxdxlG0EKEGM--
