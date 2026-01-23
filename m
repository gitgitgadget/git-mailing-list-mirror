Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BB2309B9
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193316; cv=none; b=hukrCahR+kanFlhPwHujRtYb4Hzg126+eA0+M/ZsETpHazsTMUpV37g7g4w0iXOLcWzDJItvIycaaElc0TwCPOWD2LLolAyyQDTDFaZV9dvJnN4hGFXdasruBl7RUy/qDE307vyeU6XmZuxapOKdtbmLkEcQkhxIpFhhq9CwHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193316; c=relaxed/simple;
	bh=cWIuTEu8FiJ8JbhqNx+LwFwKBc2g67lm2Cuq24MEgCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD5GkVdZTj4K5EHBhxrdTfNZYOxOLfQWvRG51zE78g3fJWaG+8MM1BG7vHnr4UOT6HrBe0xOiRiNB8gv6Mf3EK2YnRjaMZw64XZ/XokLZ2m4V5oburJKpLn3DS0LimrEBLFJ6/ndRG2U/nxs0q7xPSGLwBirlqsaLKNSMKUwNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nMGargZQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nMGargZQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794279c3b00so25294867b3.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769193313; x=1769798113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8nS4/nMHTZdzj/F5MFnVadu7dTFVmECPjNJYDGG/7M=;
        b=nMGargZQeb396mP28tHx7UuoiiywyMMwQMqBHzYPwsDmUHo8InYgv+ttzwQGz3ypVV
         HDt09b624nkq9ipxhV9e/ykvfAxVTQoPwy1hcDlk/8DbamXFJRubuNdsoRe/GrvqT9cU
         ONFDta9FMdF4KtGV3omFKBFTCz5dT30r5V/Op61EQGQO7PaKgOLBBOe3vYeYm0q/5hKF
         1KcUAOno+gZTU6vLpAdLfzuL9+uQk95QmSyYNlWkWilMAGdfz1LnSVFboL0sPzfOBZaj
         nWfg5eg47HorjQfEy9BlDAiYMYojQPJIKjgL/IEgo/h93hkorrNFoz7CEcuFc/urpe0/
         BLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769193313; x=1769798113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8nS4/nMHTZdzj/F5MFnVadu7dTFVmECPjNJYDGG/7M=;
        b=Uin9HnT7pjLV9gHFIkCWHBTeVf7RoESYIXDgU1wEX67vGztfEWBsNEgvT6nmExu3lk
         4I1dlW2HO8xeX12aLFFrkGnete0Z6UQlfb81ttQ2JmVGi0Rs+5MExOWKfEJPPJyUiyVW
         NAph5z/3fFAdSlvMbWAoQZgrjcN90NWNmq69UDq2CTvKVGZnEDyN/v7uCEq/CdMpifgR
         IKufDZa1qbzKVmHa44dlt6jbcj+6ocvz3uZc9tVG6DWvqEKMMFcglD30uenfLrLkVoC5
         Y11EpjJYeNm8iUeS8XHk/6vGtmg7Pnl+68sGpDq9ySr2FhwUgLGZjgzAYFf5kcGhEPr2
         ZLug==
X-Gm-Message-State: AOJu0YxdEKkXdTBFV8uDGRNxhF1heC304PHLi3Rh2vt1xBk612rVI8b5
	0dVwo/1hp16l+ClHQhI6TueT3h4mIQlZgM9j8OpAQe6NhocSAr+8Lvgzw+pkI8UxTH8=
X-Gm-Gg: AZuq6aLzua973dUBTvgM1K0WP+4njQ+mjzl5WKxwFazVp/WWC1MkHAx47n4FTzi9ye0
	xCF2HURfczADW7zyiGFBWC3mXMTBppYr1uIdW6xzETovMPiRS5/r1aQz/6mlQHZNIKeDWrjTNKx
	3H2sHMCZPstV4gK/XPpa6PoQZyffbxiNHZlzGOkwTZuzuohx9FMFEVHOcX0eMSN6s/sg1vmDHiZ
	P/EhtIXsdFYMPZoU6ZOKxAcipgB0dHNgDK1erS1L+O9/ycYYxgogfzpDgjBo4CZ9iIp6Do3qfi0
	7Ith6d7pZq6zQgWPceVNJmkzkADC6a0CpabraAFPVaXW/n1xLTun7HGmF8A1dGMTVk0rRaSruUg
	3lLrrBEmyv78jd9gDkLxH/B++6H8hhtaAk75thlagVHstMXPE/HlpGPyKFegZ6xBl9lVrkKry0/
	ygNR8yGjsjP+fX5M5gScdL7Ia/x75a4/WmmP+ACn8WfZsU/R1d+RXZ/+pGeGSJPLruuIlBFoIti
	gUAOnFzkXzTYR5HtiWXiF1JLZS4
X-Received: by 2002:a05:690c:e3cd:b0:794:37f9:829d with SMTP id 00721157ae682-794397e8163mr35404247b3.0.1769193313564;
        Fri, 23 Jan 2026 10:35:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b01b366sm14101857b3.16.2026.01.23.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:35:13 -0800 (PST)
Date: Fri, 23 Jan 2026 13:35:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <aXO/YLzRlDXD5IPY@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
 <aXLNM+AOpdQtmisC@nand.local>
 <aXNCtCZwP57Tfu60@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXNCtCZwP57Tfu60@pks.im>

On Fri, Jan 23, 2026 at 10:43:16AM +0100, Patrick Steinhardt wrote:
> On Thu, Jan 22, 2026 at 08:21:55PM -0500, Taylor Blau wrote:
> > On Wed, Jan 21, 2026 at 01:50:28PM +0100, Patrick Steinhardt wrote:
> > >  static int add_object_in_unpacked_pack(const struct object_id *oid,
> > > -				       struct packed_git *pack,
> > > -				       uint32_t pos,
> > > +				       struct object_info *oi,
> > >  				       void *data UNUSED)
> > >  {
> > >  	if (cruft) {
> > > -		off_t offset;
> > > -		time_t mtime;
> > > -
> > > -		if (pack->is_cruft) {
> > > -			if (load_pack_mtimes(pack) < 0)
> > > -				die(_("could not load cruft pack .mtimes"));
> > > -			mtime = nth_packed_mtime(pack, pos);
> > > -		} else {
> > > -			mtime = pack->mtime;
> > > -		}
> > > -		offset = nth_packed_object_offset(pack, pos);
> > > -
> > > -		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
> > > -				       NULL, mtime);
> >
> > OK, here's where we see the existing logic for determining the mtime of
> > an object in the GC sense. I see there's a subsequent patch that also
> > makes use of the object_info->mtimep field, and my guess is (not having
> > completely read that patch yet) that having the same notion of mtime
> > between the two callsites is desirable.
> >
> > I still wonder whether imposing that notion of mtime at the object_info
> > layer is the right choice. I wonder if it would make more sense to allow
> > the caller to have a "statp" pointer filled out (or alternatively stick
> > a "struct stat" in both the packed union type as well as the loose one,
> > though the latter doesn't yet exist).
>
> The problem with filling out a `struct stat` though is that it will only
> apply to backends that actually have a path to stat. There may be other
> backends that don't. You could of course pretend that there was a file
> and fill in the `st_mtime` field. But I don't really see the benefit
> over having a standalone mtime field.

I understand what you're saying, but I don't think that this is unique
to stat. Looking through the object_info struct, there are a handful of
fields on the request side that are coupled to the objects themselves,
not their representation, such as typep, sizep, and contentp.

But there are a handful of fields in the request section which are *not*
properties of the objects themselves, but rather properties of the way
those objects are represented as part of the backend-specific
implementation.

For example, disk_sizep suggests that all objects are stored on disk and
have a clear notion of how much space they occupy. I could imagine a
backend implementation where perhaps the contents of objects are divvied
up into smaller chunks and deduplicated across many objects. I don't
think there is a clear answer to how much "disk size" an object occupies
in that case.

delta_base_oid is another field that I'd argue is not a property of the
object itself, but rather its representation. Of course, objects stored
in packfiles may or may not be stored as a delta against some other
object, and thus being able to ask what that object is makes sense. But
loose objects don't have the same property as a result of how they are
stored.

To me this seems like an example where implementation-specific details
are already leaking through the object_info struct. So in that sense I
don't think that adding a "struct stat" here is meaningfully changing
anything.

But I think the proposed mtimep field is a special case not only for the
reasons stated above, but because an object's mtime has multiple
interpretations already. For example, if I'm asking about an object's
mtime, and that object happens to be stored in a cruft pack, which mtime
am I referring to? Packed objects inherit their mtime from the mtime of
the *.pack itself, but cruft objects have an additional interpretation
which is read from the *.mtimes file corresponding to the cruft pack.

I don't love bolting another leaky abstraction onto the object_info
interface, but my broader concern is that the information here is not
just leaky but ambiguous. By adding a statp pointer, I think the
information is less ambiguous since the GC-specific interpretation of
mtime is done at a layer above stat(2).

> > Then the caller could do something like:
> >
> > static time_t object_info_gc_mtime(const struct object_info *oi)
> > {
> >     if (!oi->statp)
> >         BUG("oops!");
> >
> >     switch (oi->whence) {
> >     case OI_CACHED:
> >         return 0;
> >     case OI_LOOSE:
> >         return oi->statp->st_mtime;
> >     case OI_PACKED:
> >         struct packed_git *p = oi->u.packed.pack;
> >         if (p->is_cruft) {
> >             uint32_t pack_pos;
> >
> >             if (load_pack_mtimes(p) < 0)
> >                 die(_("could not load cruft pack .mtimes for '%s'"),
> >                     pack_basename(p));
> >             if (offset_to_pack_pos(p, oi->u.packed.offset, &pack_pos) < 0)
> >                 die(_("could not find offset for object '%s' in cruft pack '%s'"),
> >                     oid_to_hex(&oi->oid),
> >                     pack_basename(p));
> >
> >             return nth_packed_mtime(p, pack_pos_to_index(p, pack_pos));
> >         } else {
> >             return p->mtime; /* or oi->statp->st_mtime */
> >         }
> >     default:
> >         BUG("unknown oi->whence: %d", oi->whence);
> >     }
> > }
> >
> > I like the above because it encapsulates the GC-specific interpretation
> > of an object's mtime outside of the object_info layer, while adding
> > information (namely statp) that is generic enough to be potentially
> > useful to other callers who may not be interested in the GC-specific
> > interpretation.
>
> This isn't achieving the goal of making the logic pluggable though, as
> you now have backend-specific logic outside of the backends. Also, isn't
> the end result basically the same as what I have proposed, except that
> my version _is_ fully pluggable because the logic is entirely contained
> in the backend?

Yes, the end result is the same, both your patch and what I wrote here
implement the same GC-specific definition of an object's "mtime". I am
not following the argument about pluggability, though. The concern I
have above is that we are pushing domain-specific logic into the object
storage backend, not the other way around.

Thanks,
Taylor
