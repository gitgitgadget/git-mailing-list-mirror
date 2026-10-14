Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFA5304C7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992608; cv=none; b=Eqn5iSTYZRrfIIyXfIJE89IgI884uT36sWgRnsW3CSYYd5QFeArVlFbJEvBEho5yxEdu4DZccM2kC5A+ppv6syeWYaxEhspSAI8sERKhef/Vr1xafcGax5f6CHDZjHIl1J4QuAYz7PP7anuWMvhtH34OcJPaZWqOq4fcePho4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992608; c=relaxed/simple;
	bh=rg8dAQIvRL5VL1nsuXXN4SYoiSFM8xMUW3Fd4h5YwX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmrNjJsIpMmWRGWwcME/EMR8Tn3KFZ8g0exEs+l2Cir1dKQ1NTH5rk+P9IAD7Lk/OJ8HmbnKKwNff5oR6Hrar1dBr8qHkHo/LBBMyLNs4Qt+Rwtg64TovTTkSdPVeXZWI2l7rlUZBuucRJsXstI/kuFPfrG8ShsgxcpOUKk84wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk10O86v; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk10O86v"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-483a66818edso290676fac.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992605; x=1792597405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nTORC4KfdxNQDTiVFfv549e9PPdzOlbLQA9EFBbQvvc=;
        b=hk10O86vQ2kMD4Sm7/l6sfGC0Ev2Lt5nAp1hqIobpNndfkt/geZS+6U+7JlZbkfvwd
         Oh5ui4LibcLDmWDlRBon3YKI1LaEJ5fCkrx37/Z2g9s8yBGt0eNy6fckN432YJS0Ajqd
         UgWDRdRp85vkjmpKwBEoWVTZ+iuT2yrHPbxIoI4Ero9iypWXKQk4iBYHZb0A+8seUClv
         j2Z+te4saF8d2XLHv6UpCCbpywh1T/vKPTjB3kP1/4pF0GRmKJrW6H3hxtZUvo0/W3vE
         RsacbuEnCivKMWw8vcM9baaeiz3bIIlGREhT93/PcSnxx2VpYtSGhl0es6PdXlhpAA+I
         wbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992605; x=1792597405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTORC4KfdxNQDTiVFfv549e9PPdzOlbLQA9EFBbQvvc=;
        b=rOyHHn+4HtD6QIc+XV0R6fYSa5OIK498f6ZqVF8QxmB6U0ORKOHR+iSsMx39R8qcIa
         Qp+/FkemkG5edOkE52bqezl5iRYv38HE3es/jnMCP5HWuMSqRwmcLok5l3VHpEgURlwc
         OaaEaG/hvq9dkffahvKr3qifqLvXEJRi7CEVlJ86R7bAZ/96ueOUQgwz4zB2Qef80OJY
         A/XRJ4Z74i+SVssvy5L+4oEqJ2r1mRaxur47gSf96/8zHQTwaCQ1L4Tdb5kXv4WILunZ
         /wSjX2w10BNhvW/gZhkJZ4P9QqxCfV57JVd+23jjeanWOyKsnE0jB7kBfFiMAINsIYS3
         MhzQ==
X-Gm-Message-State: AFq9FYJ/CWUhkCJE2QfhQokY5rtkfVB6e6/037J64oxx1ecG7FTC94rR
	ESZYzNaNalpOWmZLzbHIUYWoS6OwpwFIvVjq7lVBIAHpqC2EeYmkmblu6tqLIw==
X-Gm-Gg: AYBFou38uTBLU0FvA7PleiWJTaHPSe371/8ukHWmcneSSabjyk5rWF5F+Uze0t9gnVT
	uCTjUcpU1VBmfagxl9lRt9Mb83lioZDECG7gO0STwKRHuTuKmwp3U/bZEVbZBg1AYEUao4bp9S5
	fLNTzoHoYXzs4smNZro0ZcwzP4dvTebhQCZx0o/OIHK5FzY6WASLZsWHAaI3Tj2vejYmHwTm/xA
	IWnOcgN21RNFYlYhDl8yB0WeIRUY2Cz2jor1+HybJD6Dh2XiYHnjlx7xERRMN/URu588hP5U1v6
	BUeZX2cyPOkdmV7bGE+AhO1lLEUgvMUltKRSKVVfBMCn/uQhgVhmH8VgkQ2zvhl2QT6LMVnVEQH
	IQVSv4gU3YGwGHLrqD+cB6mv5HkvG20KFbK93edudvJI9EuY5Naj54y8Up0spf50bsddUgkmzML
	O4rQn7Qk0AWcy3yIywMqk6RmmyAySkWSTNjFn7Ra6KQeSiG5Ljp3NsA8gKv+GDdfbnEVkzVBQx9
	NEeTHHsCGcMARrr6ekaZbk=
X-Received: by 2002:a05:6870:b50d:b0:494:7af4:9556 with SMTP id 586e51a60fabf-4a2a86aca68mr13439931fac.6.1791992604626;
        Wed, 14 Oct 2026 08:43:24 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb4e92asm2359998fac.6.2026.10.14.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:43:24 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:43:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 5/5] odb/source: drop `local` flag
Message-ID: <as-iH9JtWaKacK4T@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>
 <as6palGWxRlky0bS@denethor>
 <as8njPHSZVabmb4Q@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as8njPHSZVabmb4Q@pks.im>

On 26/10/14 08:56AM, Patrick Steinhardt wrote:
> On Tue, Oct 13, 2026 at 05:44:11PM -0500, Justin Tobler wrote:
> > On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > > The `local` flag indicates whether a given `struct odb_source` is a
> > > local source or not, where "local" is defined as being the object
> > > directory that is directly attached to the current repository. But now
> > > that alternates are handled in the "files" backend, this property is not
> > > something that even makes sense anymore to have on the generic source.
> > > 
> > > In fact, we already have a partial replacement for this field in `struct
> > > odb_files_dir`. The only other site that requires it is the packed
> > > object database source, because it propagates the bit into the packfiles
> > > it is opening.
> > > 
> > > Drop the flag from `struct odb_source` and instead move it into the
> > > packed source.
> > > 
> > > Note that we stop considering the `local` bit when iterating through all
> > > loose objects with the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag. This is
> > > fine though, as we already handle the flag in the "files" backend
> > > itself, where we skip over any object directory that is not marked as
> > > local.
> > 
> > I do wish we could also drop ODB_FOR_EACH_OBJECT_LOCAL_ONLY. This flag
> > also feels rather leaky to me. I guess though we still need a way to
> > ignore objects from certain sources when iterating over all sources such
> > as the inmemory source.
> > 
> > Overall, I happy to see the `local` field dropped from the generic ODB
> > source structure, but IMO is does make each `for_each_object` callback
> > handling of the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag a bit ambiguous and
> > awkward.
> > 
> > Naive question: Do all odb_for_each_object() call sites that use the
> > ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag have "files" backend specific
> > reasons to do so?
> 
> It does make it awkward, I agree. There's only two callers that use the
> flag right now:
> 
>   - git-pack-objects(1) with its "--local" flag. I consider this command
>     to be too specific to the "files" backend anyway though, so arguably
>     we could just let it handle this directly.
> 
>   - "reachable.c" via `add_unseen_recent_objects_to_traversal()`. This
>     is invoke by git-prune(1) to mark reachable objects that are recent,
>     and it's dubious that we only enumerate local objects here.
> 
> So we might be able to get rid of that flag altogether. But I'm inclined
> to go one step at a time and leave this for a future patch series.

That's fair. I don't think we need to get rid of this flag as part of
this series, but it seem like it would be something nice to eventually
remove.

Do we want to leave a TODO comment to mention this?

> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > [snip]
> > > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > > index 868e723c81..75cf29fa9d 100644
> > > --- a/odb/source-inmemory.c
> > > +++ b/odb/source-inmemory.c
> > > @@ -161,8 +161,12 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
> > >  	};
> > >  	struct object_id null_oid = { 0 };
> > >  
> > > -	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
> > > -	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
> > > +	/*
> > > +	 * In-memory objects are neither promisor objects nor do they live in
> > > +	 * the local object directory, so there is nothing to iterate over.
> > > +	 */
> > > +	if (opts->flags & (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
> > > +			   ODB_FOR_EACH_OBJECT_LOCAL_ONLY))
> > 
> > So for the inmemory source, we don't want to iterate over the objects at
> > all if we are only interested in "local" objects.
> > 
> > Naive question: Are there any scenarios where we even would iterate over
> > an inmemory source and only be interested in "local" objects?
> 
> Not that I'd know of.

That's what I figured. To me, this is just another reason to remove the
flag. :)

-Justin
