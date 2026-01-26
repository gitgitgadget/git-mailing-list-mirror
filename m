Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007D3033E5
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417612; cv=none; b=NAMkzw2eO1ZxhWoRRLMF5FhS584dXYizFCQzcdzIHT9XchtlTHHkWWZXcEM5bowoTM86m8WVTBAJ8kww75WQ43GEqxFTXkFbZ4O7SBE8sP1qzbGLEBfGsZiALP8EOW5+TQ9/ufqni803ucluG0TBe/k1bSentoB3sLKalSFeiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417612; c=relaxed/simple;
	bh=l0YYW4BU3Pc+qTQoR5faHXDYdq/GiN1CSHQEAzffRHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSq0WbnV//yt2Sm9ZOVH3yYx1uSJUzQV11K89iLCY+j3Qb9PjhquZlTp7o1iha0UqyXF8Hx4q67AppoBEEB4KpwpspMjEiMIoIn3mKF+ZH8lZNnE2qz71S45V2inZg8gcfzre7n/Vdo0F72BWdZrqnr9a49HSvm28sNPmCivk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/WtRDwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjKEAnDv; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/WtRDwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjKEAnDv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 615167A00BC;
	Mon, 26 Jan 2026 03:53:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 03:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769417609; x=1769504009; bh=0wHcMKZx28
	yO4fJgLROx+zbUnD0cDhY6d1ud0+24Fe0=; b=O/WtRDwEfkuecHStgzBLpf3W6e
	S55XmojGuTRn+dT/gQu+O9GbgOXOE80UjsC+PyJBUge03srddN4aIngYaQghPVPf
	Pr7eYDCUQk7KiHDT2SBCQcHcrJ8P0XxkiScdVIW5pEmeEx5Q9RIINSRdoyRiizM2
	b5QSgkAeSCrCj6xaEHOUkooWwCnpxJ3g9NbaZv86KMRjRM+oHz1yS1NbghQMMYVm
	emNcoFJzGPA8U5Jy9z4tHvx2xNrDYP1zK+A3EhRXrBDVwtvYAr4cuE9m1YdSIsCI
	3A6S1fb8rS3qGSV1xN6KGq0K6r+lIicBOXAgve/+QYvrAO9ZJT04BQjGRoPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769417609; x=1769504009; bh=0wHcMKZx28yO4fJgLROx+zbUnD0cDhY6d1u
	d0+24Fe0=; b=hjKEAnDvIECa0IqDxlx1w8rT7W3FpaTDNIozLN4rpS3wPG+kegK
	pduoOUpBe+UC87z4nBSjaluzzZLCccPrcIdHlyG9U+7YhK9f0Z59jrmRKC/9SgYM
	O3TtWuaIJDVsBpj/a0369mtelUfTRaf5/3+conc3WUWNO6+dPl56tatTx2g0XcMG
	Mi9YpoRoyYX11ce3+OIIN2VWLwcd4KTVbD1PRjD+acdBaknL2TLciYMiIOC7UY6s
	EVNpUxJXb0pXswUgF9U6e5Y8o8L8vGuGCYKncFZagGqgMfldKaYXBRJ4en9AsSWG
	rKBUTRBBAVl4JgahNDWOW2eNNC237/XjVRg==
X-ME-Sender: <xms:iCt3aavdHzRjFev0666YvuElyHX_n1ft37egwxNRKI1fq5cI0qPB6w>
    <xme:iCt3aWXqiZGNun2Ga3oOfSiz6kPvoA2cuYB2bUULjQBTRNpiFjfsRSnrko0LCDXq_
    YprleG33_a-8YT6U8VCFhjNJS65i84Ke71h8zlYpe9Ijpn68t9UKNM>
X-ME-Received: <xmr:iCt3aeEdfi5lzAhI3QNUAKtSyWju7Hbe1bdi0lSJvJ_ABP4iFAQwM37dyrVvAblN1SOdE_-J_fXrk9ORoowrgPrJy67ruSze-We4KGHWXGIHuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iCt3aQ0JmEn6FOvuy-pIbbgdof5cW3UegVgqDt-1uCJq6qmuJwzzkA>
    <xmx:iCt3aYNF78DTnpQwJ05aqtxPo2d7kIlwFxKVboQqpLDccKXjso5Pig>
    <xmx:iCt3aX6kFNH2wE7Uj_2Cq02HrTdKd0k9XaocH3eJuOGr5sxcZvSfAg>
    <xmx:iCt3aa2F9M9-fl8RZrSJyQBj1z9nIVlWUO8gAP1pJmWMNsdJkHfjLA>
    <xmx:iSt3aTP0uVWyONwzKBk7lDU8D3n1b2tXEfLkp77EGfQ7_crzxAIqT-q8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 03:53:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9843968 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 08:53:26 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:53:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <aXcrftLpfcG4S5AX@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
 <aXLNM+AOpdQtmisC@nand.local>
 <aXNCtCZwP57Tfu60@pks.im>
 <aXO/YLzRlDXD5IPY@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXO/YLzRlDXD5IPY@nand.local>

On Fri, Jan 23, 2026 at 01:35:12PM -0500, Taylor Blau wrote:
> On Fri, Jan 23, 2026 at 10:43:16AM +0100, Patrick Steinhardt wrote:
> > On Thu, Jan 22, 2026 at 08:21:55PM -0500, Taylor Blau wrote:
> > > On Wed, Jan 21, 2026 at 01:50:28PM +0100, Patrick Steinhardt wrote:
> > > >  static int add_object_in_unpacked_pack(const struct object_id *oid,
> > > > -				       struct packed_git *pack,
> > > > -				       uint32_t pos,
> > > > +				       struct object_info *oi,
> > > >  				       void *data UNUSED)
> > > >  {
> > > >  	if (cruft) {
> > > > -		off_t offset;
> > > > -		time_t mtime;
> > > > -
> > > > -		if (pack->is_cruft) {
> > > > -			if (load_pack_mtimes(pack) < 0)
> > > > -				die(_("could not load cruft pack .mtimes"));
> > > > -			mtime = nth_packed_mtime(pack, pos);
> > > > -		} else {
> > > > -			mtime = pack->mtime;
> > > > -		}
> > > > -		offset = nth_packed_object_offset(pack, pos);
> > > > -
> > > > -		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
> > > > -				       NULL, mtime);
> > >
> > > OK, here's where we see the existing logic for determining the mtime of
> > > an object in the GC sense. I see there's a subsequent patch that also
> > > makes use of the object_info->mtimep field, and my guess is (not having
> > > completely read that patch yet) that having the same notion of mtime
> > > between the two callsites is desirable.
> > >
> > > I still wonder whether imposing that notion of mtime at the object_info
> > > layer is the right choice. I wonder if it would make more sense to allow
> > > the caller to have a "statp" pointer filled out (or alternatively stick
> > > a "struct stat" in both the packed union type as well as the loose one,
> > > though the latter doesn't yet exist).
> >
> > The problem with filling out a `struct stat` though is that it will only
> > apply to backends that actually have a path to stat. There may be other
> > backends that don't. You could of course pretend that there was a file
> > and fill in the `st_mtime` field. But I don't really see the benefit
> > over having a standalone mtime field.
> 
> I understand what you're saying, but I don't think that this is unique
> to stat. Looking through the object_info struct, there are a handful of
> fields on the request side that are coupled to the objects themselves,
> not their representation, such as typep, sizep, and contentp.
> 
> But there are a handful of fields in the request section which are *not*
> properties of the objects themselves, but rather properties of the way
> those objects are represented as part of the backend-specific
> implementation.

Yes, the specific interpretation will change for some fields. But in
general, most of the fields still apply to all backends.

> For example, disk_sizep suggests that all objects are stored on disk and
> have a clear notion of how much space they occupy. I could imagine a
> backend implementation where perhaps the contents of objects are divvied
> up into smaller chunks and deduplicated across many objects. I don't
> think there is a clear answer to how much "disk size" an object occupies
> in that case.

This would still apply to other backends though. It's true that "disk"
size is a bit of a misnomer now, and that it should probably rather be
renamed to "storage" size. But overall, no matter the backend, you will
still eventually end up storing the object data somewhere, and that
takes up space.

> delta_base_oid is another field that I'd argue is not a property of the
> object itself, but rather its representation. Of course, objects stored
> in packfiles may or may not be stored as a delta against some other
> object, and thus being able to ask what that object is makes sense. But
> loose objects don't have the same property as a result of how they are
> stored.

Yup. This field is specific to the packed backend indeed and ideally
shouldn't be part of the `struct object_info`. In the best case it could
be lifted into `struct object_info::u`, but I'm not sure whether that's
easily possible.

> To me this seems like an example where implementation-specific details
> are already leaking through the object_info struct. So in that sense I
> don't think that adding a "struct stat" here is meaningfully changing
> anything.

The thing is that I'm trying to clean up all the different messes that
we have. So instead of adding _more_ leakiness, I'd rather prefer to
remove some of it.

> But I think the proposed mtimep field is a special case not only for the
> reasons stated above, but because an object's mtime has multiple
> interpretations already. For example, if I'm asking about an object's
> mtime, and that object happens to be stored in a cruft pack, which mtime
> am I referring to? Packed objects inherit their mtime from the mtime of
> the *.pack itself, but cruft objects have an additional interpretation
> which is read from the *.mtimes file corresponding to the cruft pack.

This is a good question indeed though.

> I don't love bolting another leaky abstraction onto the object_info
> interface, but my broader concern is that the information here is not
> just leaky but ambiguous. By adding a statp pointer, I think the
> information is less ambiguous since the GC-specific interpretation of
> mtime is done at a layer above stat(2).

Fair point. For the current backend, mtime can be ambiguous as the same
object may be stored multiple times: either as a loose object, or as
part of any of the packfiles.

In the context of `odb_for_each_object()` that info is not ambigous
though: we would yield the same object multiple times, and every time we
yield it we will may have a different mtime. And this is working as
expected for the two callsites:

  - In "reachable.c" we use the mtimep field in the context of recent
    objects. So if at least one of the objects has a new-enough mtime we
    would eventually see it.

 - In "builtin/pack-objects.c" we use basically the same logic as we
   use after my patch seires, where we use either the cruft time or the
   pack time. So things work as expected over there, too.

So I'd claim that this is working sensibly for `odb_for_each_object()`,
and there is no ambiguity involved. It's the caller that has to
disambiguite, and that's already happening.

But things are a bit different if you invoke `odb_read_object_info()`
directly, as we have no way to disambiguate there. We only want to yield
_a_ representation of an object, so the mtime will be derived from
whatever data structure the object was found in first. This could be
helped with better documentation.

> > > Then the caller could do something like:
> > >
> > > static time_t object_info_gc_mtime(const struct object_info *oi)
> > > {
> > >     if (!oi->statp)
> > >         BUG("oops!");
> > >
> > >     switch (oi->whence) {
> > >     case OI_CACHED:
> > >         return 0;
> > >     case OI_LOOSE:
> > >         return oi->statp->st_mtime;
> > >     case OI_PACKED:
> > >         struct packed_git *p = oi->u.packed.pack;
> > >         if (p->is_cruft) {
> > >             uint32_t pack_pos;
> > >
> > >             if (load_pack_mtimes(p) < 0)
> > >                 die(_("could not load cruft pack .mtimes for '%s'"),
> > >                     pack_basename(p));
> > >             if (offset_to_pack_pos(p, oi->u.packed.offset, &pack_pos) < 0)
> > >                 die(_("could not find offset for object '%s' in cruft pack '%s'"),
> > >                     oid_to_hex(&oi->oid),
> > >                     pack_basename(p));
> > >
> > >             return nth_packed_mtime(p, pack_pos_to_index(p, pack_pos));
> > >         } else {
> > >             return p->mtime; /* or oi->statp->st_mtime */
> > >         }
> > >     default:
> > >         BUG("unknown oi->whence: %d", oi->whence);
> > >     }
> > > }
> > >
> > > I like the above because it encapsulates the GC-specific interpretation
> > > of an object's mtime outside of the object_info layer, while adding
> > > information (namely statp) that is generic enough to be potentially
> > > useful to other callers who may not be interested in the GC-specific
> > > interpretation.
> >
> > This isn't achieving the goal of making the logic pluggable though, as
> > you now have backend-specific logic outside of the backends. Also, isn't
> > the end result basically the same as what I have proposed, except that
> > my version _is_ fully pluggable because the logic is entirely contained
> > in the backend?
> 
> Yes, the end result is the same, both your patch and what I wrote here
> implement the same GC-specific definition of an object's "mtime". I am
> not following the argument about pluggability, though. The concern I
> have above is that we are pushing domain-specific logic into the object
> storage backend, not the other way around.

To expand on the pluggability bit: every time you add a new backend
you'll have to extend the above logic to understand how it represents
the mtime. That by itself might be doable, but let's for example
consider a backend that is a black box to us (like a shared library that
may plug in arbitrary storage logic). In that case you would not even be
able to derive the information unless you have a generic layer that lets
you convey it to the caller.

So overall I agree with you that there are nuances here, and that the
mtimep pointer _can_ be used incorrectly. But I still think that the
concept is generic enough across backends, and the refactored logic
still works as extended. I'll try to expand the docs and commit message
a bit to cover this discussion.

Thanks!

Patrick
