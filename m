Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RVkAUxPy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qc6cW4fY"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4203710E
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:21:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 485705C013C;
	Thu, 14 Dec 2023 08:21:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 08:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702560101; x=1702646501; bh=9lf7j8egRH
	QtdOW+CmsvGS048h+rFZb60A4LYNolxLU=; b=RVkAUxPyN42NLnNl//qF2RqnR2
	s97uMkdAjg46ZZ1URz2uKV33KYJ6LRTi4wMMiz9YoXVhfKVvGD/vr4Qx/IxX/zqC
	HBNqE17/huAAMrctveHfw+87djvtkVzCL+OCxbAMxgjkkE2iI6cvwYI/ehb7QxBc
	Aw7Km42USCpfEPm1zkNnonDUAEPTmjG8Mjor080+rFFvBfJgIr23YvL8ys0q9Mwt
	9KuEtp8qHZI0ApoBAugIENMtPiOHGndB63ojjV1QJj06Twli9/MqD08DtMdqBtov
	siOWWk6aCp8m6ixMEIA3xIDdKihaPFyqHCXjlf+fDBE3GVkA76NOqxs3dUfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702560101; x=1702646501; bh=9lf7j8egRHQtdOW+CmsvGS048h+r
	FZb60A4LYNolxLU=; b=qc6cW4fY2Ncn1hI29+Wk3vu503SIQNu6MGhVspStlZyG
	SFAQhcCpMUVh5reE0uaXgLRUWyoADuZFnxKSt7+SRILdoTCu3tHHMtzhzZabd4gs
	HXfdoUhj77rTTDCcSh5lKRuYZQK4acnt/W9ZSgonq4kQ3238H3BFlsyh8J1FOt/b
	+9Hgl/HBoPIESs2AE4gE+rRldPQm4fUKZC4I7iWxY5Jb5mo9XxsBLej96aa+v/Nf
	SlQBg1kjZI24sR32oRvaLgZNgYHI10iizNqC5C6G1wlHTwMtRLz1Avaqd71SbqH0
	o1bpHM3NZUne0aUm7LKXm5QQBlO38WVQBy5PER3A+w==
X-ME-Sender: <xms:ZQF7ZUi55WxuuwBh110NpDLoCfksP3qeY9o6QsVMr5nF0SCBIgNWGA>
    <xme:ZQF7ZdCvnEg9-rr8-ocKAGTWFHKX7Dkw6uSJo7sni7FazctdStzVvAGiyFfOrjxzs
    MavQgcrhpyieMrGww>
X-ME-Received: <xmr:ZQF7ZcETzBtRLU951tHZ3f2AyeHOLHoR9NX-_hIKT-iJ1swgE2SZWqA-Ic0sjh5LIZgKvcB-mvvRyObFhfZPCaYR2f4wj2-txCKrGhEgobBcrEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ZQF7ZVQ7cwil-xACK8hut1-QbWu3T2_VUa-EnSw-gxMqqDjdBt8PXA>
    <xmx:ZQF7ZRx_EebEzDdkoHNkvcJVmRmfaRBE2SD1M-BZ29xuREmbg-YGdg>
    <xmx:ZQF7ZT7jXKSUXqqSukqsUK83OksSns-tBR-y5ALlEPKRYucQezbBVw>
    <xmx:ZQF7Zc_TCgaF_fk6F_Z9qcEh3EEjEtdaKJ0GQRlPwoRcbKOnePAd6Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:21:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 510e0976 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:19:54 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:21:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZXsBX-PW5J_5nTPT@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
 <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
 <xmqqle9zqidj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F+LNKMcd/ncP8pA+"
Content-Disposition: inline
In-Reply-To: <xmqqle9zqidj.fsf@gitster.g>


--F+LNKMcd/ncP8pA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:24:24PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
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
> > =20
> >  	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
> >  	    !s->branch || strcmp(s->branch, "HEAD"))
> >  		return 0;
> > =20
> > -	head =3D read_line_from_git_path("HEAD");
> > -	orig_head =3D read_line_from_git_path("ORIG_HEAD");
> > +	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
> > +	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid=
, NULL))
> > +		return 0;
> > +
>=20
> This made me wonder if we have changed behaviour when on an unborn
> branch.  In such a case, the original most likely would have read
> "ref: blah" in "head" and compared it with "rebase_amend", which
> would be a good way to ensure they would not match.  I would not
> know offhand what the updated code would do, but head_oid would be
> uninitialized in such a case, so ...?

The code flow goes as following:

  1. We call `read_ref_full()`, which itself calls
     `refs_resolve_ref_unsafe()`.

  2. It calls `refs_read_raw_ref()`, which succeeds and finds the
     symref.

  3. We notice that this is a symref and that `RESOLVE_REF_NO_RECURSE`
     is set. We thus clear the object ID and return the name of the
     symref target.

  4. Back in `read_ref_full()` we see that `refs_resolve_ref_unsafe()`
     returns the symref target, which we interpret as successful lookup.
     We thus return `0`.

  5. Now we look up "rebase-merge/{amend,orig-head}" and end up
     comparing whatever they contain with the cleared OID resolved from
     HEAD/ORIG_HEAD.

So the OID would not be uninitialized but the zero OID. Now:

  - "rebase-merge/amend" always contains the result of `repo_get_oid()`
    and never contains the zero OID.

  - "rebase-merge/orig-head" may contain the zero OID when there was no
    ORIG_HEAD at the time of starting a rebase or in case it did not
    resolve

So... if ORIG_HEAD was rewritten to be a symref pointing into nirvana
between starting the rebase and calling into "wt-status.c", and when
ORIG_HEAD didn't exist at the time of starting the rebase, then we might
now wrongly report that splitting was in progress.

In other cases the old code was actually doing the wrong thing. Suppose
that ORIG_HEAD was a dangling symref, then we'd have written the zero
OID into "rebase-merge/orig-head". But when calling into "wt-status.c"
now we read the still-dangling symref value and notice that the zero OID
is different than "ref: refs/heads/dangling".

I dunno. It feels like this is one of many cases where as you start to
think deeply about how things behave you realize that it's been broken
all along. On the other hand, I doubt there was even a single user who
ever experienced this issue. It often just needs to be correct enough.

I think the best way to go about this is to check for `REF_ISSSYMREF`
and exit early in that case. We only want to compare direct refs, so
this is closer to the old behaviour and should even fix edge cases like
the above.

Will update.

Patrick

--F+LNKMcd/ncP8pA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7AV8ACgkQVbJhu7ck
PpRY5BAAjAGp+h/qhb5GsTg60VZItvtfnXVC7aj9JyL9fplXeShvGy1uIPg5R9e7
hpO6+jjmpZy6hCMKsrktiYq0o4CG8MPvfETfWKOl3K9rLv+ujFvQbuAtGlQxsPUY
b/oy9NvxrPSOoZwt5NceMU1K3RqfV3LYeQ4gJc9vfecj95Bk1w799OQCjsHVHiNs
ohZjCyNAr5OkLpfMhZIbMOXuf+oXvJ+f8wKDCdlJZXjOfw4ZNECZA1caZC9HCwxf
7DP2OuvnXc0/8ZqbtjAFlVWQl87Nf1O8gFbomP1X+45PQ9qat9wnu/i9y1BPDNKh
Pz27AHThU61h5PRKXHmsLsB0IgN8Zr7HuWi1+oDDNiXyUbv15NJyinsDfH+tUSmX
qDwriKUMTM5bKxSZxUfKdOjK+MG/Qqldxk9GcH5FNqfSu0qAbz/AAlQ9l6L5HvW0
7jEIrMHVq66/NhcYJcVoLUO4OeOJOCyL2l9bF8q53XG0kVgu3sARa8wWOrUiSMWk
WbLpguoWhWM2GEJeq/fZyPSxDE6DdCNiMb5AjJ2V9hjcX1o6ybCW/c7q+vVVQTOs
Myc4g5+gYKLzjuGCJmEMda3qErGuApj8yCaPyUPU+yqCx/ZF3ZwUJOKyD66dwo0v
9iLLac9079OmqwUXZF3ymKNwQ0DJX1MpdYYoO5+gm5WBwxA/rK8=
=EIE4
-----END PGP SIGNATURE-----

--F+LNKMcd/ncP8pA+--
