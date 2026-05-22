Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31869372073
	for <git@vger.kernel.org>; Fri, 22 May 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483350; cv=none; b=oGUeEpHcFNBJWkcWGC4q0eqTADuCP0ze/Rd/SGTsI4Q1smvwmSKwNW9G3oWsQi6hbIrFxtbrePu01qy1Iu8uRO1pMxD1M9MNmpRGbq5Hs9fQH4LPeyydARKtT3FV7jSjkxV9KA6ba1KCB4U2HwPMvk3ipXp1UoiM7ECToyhj/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483350; c=relaxed/simple;
	bh=LoVd3dNJiqPWO+LtLVdTtbvoRnaRq4Q9MnFUuzGo7rY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JP9FkEZw9xtOM8lhcIW/f0EZhqqEnrJg+Ykrn8UmGQUdH3okiowU8xAUg6I3JQXcR43O6Lxg6IqcxDIjj6QkFMITZgZ6J8N9ZTZgn10RrEaBNmj8Db2Y5iD7AnHMERJyE5Qly66ei2AW0eKOg2Ei+eNfYyBOmmkZnQlkfJTGFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu; spf=pass smtp.mailfrom=adamj.eu; dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b=dbc5jd9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGIUBd7N; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamj.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b="dbc5jd9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGIUBd7N"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 734AC140016C;
	Fri, 22 May 2026 16:55:48 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 16:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamj.eu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779483348;
	 x=1779569748; bh=6WP35cg5w5kYBjixskQnwe16l5SKpp8hBkvtaoUmjYk=; b=
	dbc5jd9wniYiIrfOLvzpm+dTPyMhgiXv/LFg5a1ZH02V0KwX3qvxWD8hh4Vw2j0c
	gksUovtbt09UeJvL/8+M7V13m4XJDJSWBK/EaRyl29MuIId9hUO0IUYJyUfPIqev
	SMVeug+Hb4mAUgK3Nfna78DKyUnzDcCjKwppT98vQd1G5Fh/l77aqFfUEVXuMEnb
	TYNaicGOJrJHREBVqbohthLkFbiLKn439PNU6ChDgbwKvI2F18GiRPTbh+9SL1I+
	+AVX/w8Y1yGi3wvnKBXyeQEfrGmgjfAMWlbhz+FWDkNvCskv6JeVR7XZL3gs8ct2
	3NHfP/ohm+jdAMJsZE/nHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779483348; x=
	1779569748; bh=6WP35cg5w5kYBjixskQnwe16l5SKpp8hBkvtaoUmjYk=; b=n
	GIUBd7NiBE0YMqriyXIrujVHIJ2lBmVFaRpOrRe1/Lt2ARq08wEVkPndvqTNdhLm
	mdIlluQiwNtfX4fHJS1ybTQ808l07ON+xvSx914/H8Pdpi36Nw7D2az7DV+D+2LC
	FGEWEAkt8koYn16bPrNmGUyw//gPD6UetPsxab3oaFp/88qAkNwdOz3L+zE0vOvN
	5ZQhYTnM1U8ZjjtIvNKLbLC1xtYvG2dKoFbrw9WQx14KSNVS7DWEKE9IhhCHGcy5
	QeeoUbuI7C79uZXmLbtST2ixt6lTpM3dPcrVeWc6hERBZLZIbFZfU1tAO1ETwm8H
	3fzecghtWFNtr5mZtrtzA==
X-ME-Sender: <xms:1MIQampTbjMFx5GIgI9SXtZeSWl_4TTknK2iy9qEdVbfUwPfYVpVlA>
    <xme:1MIQaveTMbL5EZt4vGTTunxee6w6No0kFHqa6bnNoDa7ioPW-IpeO0RQVzQNkJhSH
    pVH1kxh8Bk6QW1QYLLgu0tTpRwQkXUctWvhwb_dcC8jg6uNfrsaWug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftegurghm
    ucflohhhnhhsohhnfdcuoehmvgesrggurghmjhdrvghuqeenucggtffrrghtthgvrhhnpe
    elieetvdduvdeihfefteeuteevjeefleefhfetlefgvdekhfehgfetgfegkeetheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesrggurg
    hmjhdrvghupdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthdrghhumhhmvghrvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1MIQakQB_0_9mbRigrRnsG53WMCRGZzuIk8CQV1bUighSBh65k8LzA>
    <xmx:1MIQar0BtJ9DDdxOPtW7RpwM_D5VoL0qcsgQWTbo9cdwsk_Q1ocFRw>
    <xmx:1MIQahvnSq1zMiYaW30RFl2i6w_oyHW2b7JtDK9AE2kD-Q3i4q0RLQ>
    <xmx:1MIQapij0xlvT-MY-RDPPUvG9H9o9KrL9kICsp9malbEyC48Y1zXsw>
    <xmx:1MIQap9laZCuTtHSjsFxOijCJ02ym3LnXCipSzyTVelMD3jLbyiry-Y7>
Feedback-ID: i8b3949f9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36820216008A; Fri, 22 May 2026 16:55:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoJsM15w4is3
Date: Fri, 22 May 2026 21:55:27 +0100
From: "Adam Johnson" <me@adamj.eu>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Adam Johnson" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Thomas Gummerer" <t.gummerer@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Victoria Dye" <vdye@github.com>
Message-Id: <e6e3ba3a-a08d-426b-b0ae-1f57554b2b1d@app.fastmail.com>
In-Reply-To: <xmqqldde6cl5.fsf@gitster.g>
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
 <xmqqldde6cl5.fsf@gitster.g>
Subject: Re: [PATCH] stash: reuse cached index entries in --patch temporary index
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Is this "non-zero return from refresh_index() leads to a failure"
> intended?

Good catch, it=E2=80=99s not needed. Removing, we can make the call
unconditional.

On Wed, 20 May 2026, at 03:26, Junio C Hamano wrote:
> "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> >  2 files changed, 83 insertions(+), 6 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 32dbc97b47..48189cb9f7 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -372,6 +372,57 @@ static int reset_tree(struct object_id *i_tree,=
 int update, int reset)
> >  return 0;
> >  }
> > =20
> > +static int create_index_from_tree(const struct object_id *tree_id,
> > +   const char *index_path)
> > +{
> > + int nr_trees =3D 1;
> > + int ret =3D 0;
> > + struct unpack_trees_options opts;
> > + struct tree_desc t[MAX_UNPACK_TREES];
> > + struct tree *tree;
> > + struct index_state dst_istate =3D INDEX_STATE_INIT(the_repository);
> > + struct lock_file lock_file =3D LOCK_INIT;
> > +
> > + repo_read_index_preload(the_repository, NULL, 0);
> > + if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL=
, NULL))
> > + return -1;
>=20
> Is this "non-zero return from refresh_index() leads to a failure"
> intended?  The old "git read-tree HEAD" wouldn't have cared if the
> original index were unmerged, for example, but with this update, we
> will see an immediate failure.  There are other conditions that
> refresh_index() flips its local variable has_errors on, which leads
> to its non-zero return.
>=20
> Since "git stash -p" is almost always invoked when the user has
> unstaged modifications, I am not sure allowing refresh_index() to
> notice and barf is what we want here.
>=20
