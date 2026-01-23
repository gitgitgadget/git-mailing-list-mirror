Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC828B3E7
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161404; cv=none; b=SnW4E7Tk6OGd5nCDFmpmwB5nj5oTe97zQ7jRa5UeAdZ6YRriB0UFcNXXdIV5CzWEBhF/ONW+aP6S/0q05rB47hC/XmA98ECKaRYfRaiZzvWg+l3mfwTB1NuLqV68xfwmzoPID6U8NXtfz2VdF6/RW10boeQqaCZ/qsjD3JJpQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161404; c=relaxed/simple;
	bh=M2rqzDkh1HQYBg2ZItbrBg+tYGL4JCVip9GyC4QH5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDgNwK1YquD1FKh/6oTLBOis56UeSRzq8wI8PNt7fA4TsIftuy+RnoPBfkIhOPMYNEXU8uCb+qa94i0AiV3ER7zJQiVBgIyhBfLwNkHD9Uq+kaW2CGeIZ2pSsU3FGjGRSJBmg+YUddnOFLoLniqk9ZSWvSj/Fbw2tQg+rmkdGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MqkKpvK9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xUJBvsAW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MqkKpvK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xUJBvsAW"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 015C37A014A;
	Fri, 23 Jan 2026 04:43:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 23 Jan 2026 04:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769161392; x=1769247792; bh=LnmFHxHzSu
	+2DE8a80PhMmaJKW9xf568um4Rk6HrvqA=; b=MqkKpvK9q2ezVQwnNaKeExkmE3
	fjXgi/Hx6hw8Jif207wt35uFiA+j1MnqqX0tfyshJ95J6fDJw3L+38IAf+z8BZND
	YTCijIC0lLM0lJOM3j3geA0rzvYoCERFQsdiEqu6+vXDAYakdCz8/AFWzhKNoQOD
	2cxXorn6IBBHjAvh561/hcnjkmSLb1ysKC8o6Y9PoV+DLJcKQMT3jSWsEPROTyrY
	7ijV3cAnEPTd0cHHqrHi18XxNzpaSVjtv/6H6UuXP5O2wln/xciOQkQKzKd7mwdx
	GjqYpL0byQhV0fKZEJvsYqplSenFVlcpiu39FYHwVSlAbhG01wPbnF9tX+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769161392; x=1769247792; bh=LnmFHxHzSu+2DE8a80PhMmaJKW9xf568um4
	Rk6HrvqA=; b=xUJBvsAWpipYq0ktG8x2Jn30hMQPt2eXeD90QVA2P8IG2hOz5SE
	RC6nK7IeLOhWZqgZddrdFkm5I0ps4Zw441Hnyt9Xr/XRfg23mFI22NtM8WFg6Mch
	po7XW5vrFi8dAGNxkUBZgXyFGOugjy03ZZlqwumUcgstqq4O52r+fqgZ6QX2FgGf
	W1GW7ag33eVTQbq6GG6OHs1E+ytwGmmE/SINoM8O6aDpx7oZqdyKVXZCrTZyMBxF
	sh/7aukNDP+KxcTXyh5VKftjn/yiPDyJWIcbTvfzmOJ2U/vrrXpOGztMFGN9pQCU
	ttvx8RtQr0Z603rxRRhmLXuepPkZrKNHM/Q==
X-ME-Sender: <xms:sEJzaeUT6gpCEqj6Jwbj0xRTydSKcVbbuXdd-cC3YIzDb2Uft4q87Q>
    <xme:sEJzaRcd0_s9H1ZO82hUako7Fo00QMIjd-MbARoXh3HKQYfI483TD_EufpZdVHpRl
    9_OWmv6bB508BTsTHopS13iEkBcgp7TG-ndTBKn_JzxIP9oI9cr>
X-ME-Received: <xmr:sEJzaaufTEtv56uSqADFY6Y02D4Bx7Y79RY7MVOL1W_RKpcEZJaXekC8UPGzaIFi4VDKd-ezk1rqpduvDhS5OxygffTAcWb5_jqSf_Hw-K_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sEJzaQ_IWOg4UZ1hgIGnyjUc5qIwoBnL20qVNEf9ClrCNiiBOtEkUQ>
    <xmx:sEJzaV1ldFY34WP63RkeZMKhmDxG4OBQla8gSaejqIlwCZEesxAhvg>
    <xmx:sEJzaVAQWX5Zvksob4_jyhzubBi_Urey0pjaVs1FChZnvGUkOddlVQ>
    <xmx:sEJzaRcajZAZn9PdOSB59FpVSuo5hKUfFtgXCCM3sheKydB9Tx6tfw>
    <xmx:sEJzafVARFeNk_b0gvSsBP9mW7kpQTLTZ1t57iNLIXBEVqzG8olFLgHf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 04:43:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36557b99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 09:43:10 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:43:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/14] odb: introduce mtime fields for object info
 requests
Message-ID: <aXNCq8h94i2Z6uSa@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>
 <aXLJoDdoEyKXKtBf@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLJoDdoEyKXKtBf@nand.local>

On Thu, Jan 22, 2026 at 08:06:40PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:27PM +0100, Patrick Steinhardt wrote:
> > There are some use cases where we need to figure out the mtime for
> > objects. Most importantly, this is the case when we want to prune
> > unreachable objects. But getting at that data requires users to manually
> > derive the info either via the loose object's mtime, the packfiles'
> > mtime or via the ".mtimes" file.
> >
> > Introduce a new `struct object_info::mtimep` pointer that allows callers
> > to request an object's mtime. This new field will be used in a
> > subsequent commit.
> 
> The goal seems reasonable to me, but I am a little unsure about whether
> or not this is the right place to expose this information. I have some
> more thoughts below...
> 
> > diff --git a/odb.c b/odb.c
> > index 65f0447aa5..67decd3908 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -702,6 +702,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
> >  				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> >  			if (oi->contentp)
> >  				*oi->contentp = xmemdupz(co->buf, co->size);
> > +			if (oi->mtimep)
> > +				*oi->mtimep = 0;
> 
> Assuming that you do not change the object_info request/response
> semantics, I wonder if it might make sense to zero out the entirety of
> the response section as a belt-and-suspenders mechanism in case future
> contributors forget to assign zero to the new fields themselves.

Splitting up the request/response structure as you proposed in a
previous patch could definitely help with this. I'd prefer to rather do
such a bigger change as a follow-up though as it would lead to a lot of
churn.

> > @@ -1619,16 +1620,34 @@ int packed_object_info(struct packed_git *p,
> >  		}
> >  	}
> >
> > -	if (oi->disk_sizep) {
> > -		uint32_t pos;
> > -		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
> > +	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
> > +		if (offset_to_pack_pos(p, obj_offset, &pack_pos) < 0) {
> >  			error("could not find object at offset %"PRIuMAX" "
> >  			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
> >  			ret = -1;
> >  			goto out;
> >  		}
> > +	}
> > +
> > +	if (oi->disk_sizep)
> > +		*oi->disk_sizep = pack_pos_to_offset(p, pack_pos + 1) - obj_offset;
> > +
> > +	if (oi->mtimep) {
> > +		if (p->is_cruft) {
> > +			uint32_t index_pos;
> > +
> > +			if (load_pack_mtimes(p) < 0)
> > +				die(_("could not load cruft pack .mtimes"));
> 
> Do you think it would be worth doing instead:
> 
>     die(_("could not load .mtimes for cruft pack '%s'"), pack_basename(p));
> 
> ? Most repositories should only ever have one cruft pack in practice
> (even so, there should still be some value in identifying it by its
> checksum in case someone is repacking underneath us). But some
> repositories will have >1 cruft pack, so knowing which one is busted may
> be useful in that case.

Yup, makes sense.

> > +
> > +			if (maybe_index_pos)
> > +				index_pos = *maybe_index_pos;
> > +			else
> > +				index_pos = pack_pos_to_index(p, pack_pos);
> >
> > -		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
> > +			*oi->mtimep = nth_packed_mtime(p, index_pos);
> > +		} else {
> > +			*oi->mtimep = p->mtime;
> > +		}
> 
> I am a little stuck here on whether or not this is the right layer to
> determine an object's mtime. On the one hand, it makes sense to me that
> callers would want to know the mtime of an object, either by the mtime
> of the loose object on disk, or the mtime of the contain pack otherwise.
> 
> But I'm not sure whether the GC-specific definition of "mtime" is what
> the caller would always want. For GC uses, yes, having mtime be aware of
> cruft packs makes total sense to me. But for non-GC uses, would there
> ever be a scenario where the caller would want to know the mtime of an
> object's containing pack, regardless of whether or not that pack is
> cruft?
> 
> I suppose they could get around that today by doing something like:
> 
>     if (oi->whence == OI_PACKED) {
>         struct packed_git *p = oi->u.packed.p;
>         if (p->is_cruft) {
>             /* reinterpret the meaning of mtime... */
>             *oi->mtimep = p->mtime;
>         }
>     }
> 
> , but that feels a little clunky. I dunno, maybe this hypothetical
> doesn't really exist and I'm overthinking this. But I have this nagging
> feeling that we are exposing this information at too low of a level as
> to make the object store aware of cruft pack/GC-specific mechanics.

I'll answer on your next mail, where you also talk about this.

Patrick
