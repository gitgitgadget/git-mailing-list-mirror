Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B954262
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430444; cv=none; b=Cop514T1ATZr4WeZtt4T5xKvOIJU3TtUr8Exeq309KbKKOrbnuQs10R4PmAlwyBDZL5O1bZunTpHQcQOqxjFOf2Rn5m93F6hhhGn1s7anZU8sXm31CP8UhK1fOCZPoFNH/jBfxfOVaTXCQwIpDooisj+yJwOHek8Kzt0fSZviCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430444; c=relaxed/simple;
	bh=zQy48j2pLWqUGs8/rLEqXnV3UUJu+hfb/RS8uLKBQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXv94d6BrJd49dfkzr/YmExHUAxY76ks3X5rtnwp8IS8FEmXhysubtAyeYxvGYFJSGE5DrzMGZ6+/t/r8ZNImWjtijURS9Zz3ELWpTg8SANz5SRbOR+kH7y0bMAVaEntaHECQF12Z4r9QO5B8whMIqhomUzHgSkpEvLjnvBPOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=E0/yoUeF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="E0/yoUeF"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f23f3fc686so4909835ab.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756430441; x=1757035241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOMyE2TKQhgS0VGfVFh+m39aOpayjaYSSD1p+ejzem4=;
        b=E0/yoUeFQzTeyKKfhLIdRZG4+YDnS6UlbNLmnIsiRgn2GAfxiK/LmPeeQNEb2QoZIt
         aotcXKw1c4We+YPkKursu1U8ZaFBimMDygULNRadNQ2t0lbL9o9TMpO4dRrxPBEpkkSr
         MNmsf3Pv7A9AYVC+Jh4qN2CW83CD6UY3RBkCNd4fUX2U8EiqVs63bl7kF92cmdcJBXxx
         tIxRV4YSsQD6txXtV1CilQAp7L74dBvJpjpp4fcRJ1V0IUuub5dfprqxrezdcCprlDBp
         JCIOgGQ6MSRLfBxjpFUV32+mUuLDhIQGOQMXdUrq8YdBmFDu+goo6LcRizxqLRejdzp7
         Cirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430441; x=1757035241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOMyE2TKQhgS0VGfVFh+m39aOpayjaYSSD1p+ejzem4=;
        b=QT7OCqT3v5v+b1P8ALxnEnuoePHWkuy7UdphnDDg/tkHGKxQcwcG8kyAiXk8l23KK7
         g3CDIR41AfiQp/Ou57U25U9IGYjSRDsgFGgA3rIWTuTBHcWsCJbaWakvOaRnQaAasMA/
         s9U3S9pVEmpag6GNXKoiraSiLdqF1lHVF1x6xBQUa3ZhvC/bHhWfp2ayJkEFdWlynAJl
         hrGMdRQq5QcPRS5EK+kvkeW4y29pTp7LL9XvwNpbzANhXzLt/brCFxiEbQzpcRe/vkn4
         Vd/igpqdRndOe0Fje+IWzMB9FtMWxMskbQnc6d8K37MmV4uAOLwQCeQg/ZJsmKFBQu2c
         RTng==
X-Gm-Message-State: AOJu0Ywcf31N607uKR9gtooqjqKNBA7ZJ4xamXIso8/ME4zcRYEJJocL
	QtKMhB7+PoX7DYQGMexL1HgqYY3OF9lsYfGctNfc8ziRMec1FG6aMz9eQoQbIw/Sxck=
X-Gm-Gg: ASbGnctpX6JYkaLkrTqOJWPwQXmatMhU8LFTDmnFNqROuGQmeWO9qXLQFWzMjb3jDYO
	WfZBL/9dHJ2sAdP2bdy35zDRrv2zVY3Zww3C6AwrJBuuEc7E6Fz+ZJyaOxGwzKB/dwirAf6w6yS
	EYcLh7csgDNBsOpeN6EXr6KU7LY6uy/iX50lsH0eQxiMw/vyvJwdyXOXNr8KS/8xHp5jDuqcgaM
	orBa+xH3IapcZKjXXCGyvNljZ7sHis/M18dmPfm+rrREi7yR23jf+5fuIAdft6EHO8SNnwBkRJe
	RJHvGj53AR8G5flRkP75KhmixR4MxSvIuVDezdmr/hgGT2QEuSooSeAeVYPE3IRUQDfKbnbI3ns
	Cy4SjlLWaKbT1VQDGRhW1Axqp5YjxMn3tYfV2Vv5RukHlbJPLwP2gQDtW18seb6Uw2iLP4s8chi
	p9Dh17z+Cnj/v5Y32lnp/DSpU8Xy4ToZmBodLl
X-Google-Smtp-Source: AGHT+IG+WIQDtrnsNhPBhUZhJBtgCv8qhfK9HOxpFDax4ZSq52zLqUSKiKvt8nEKgEhcsTjAC6W6pA==
X-Received: by 2002:a05:6e02:1a6d:b0:3f2:63ad:d222 with SMTP id e9e14a558f8ab-3f263add2fbmr30649985ab.15.1756430441530;
        Thu, 28 Aug 2025 18:20:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3f2a1c71a34sm2267625ab.45.2025.08.28.18.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:20:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:20:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] midx-write: only load initialized packs
Message-ID: <aLEAaNsm8LE2M3TE@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>

On Thu, Aug 28, 2025 at 05:39:51PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
> implement support for writing incremental MIDX chains, 2024-08-06) to
> allow for preferred packfiles and incremental multi-pack-indexes.
> However, this led to some conditions that can cause improperly
> initialized memory in the context's list of packfiles.
>
> The conditions caring about the preferred pack name or the incremental
> flag are currently necessary to load a packfile. But the context is
> still being populated with pack_info structs based on the packfile array
> for the existing multi-pack-index even if prepare_midx_pack() isn't
> called.

Thanks for looking at this one. On the surface this looks not great, but
I am having a hard time coming up with a smaller test case that
exercises this behavior.

I can get what you wrote below to fail on my machine pretty reliable
when building with SANITIZE=address (even without --stress). All of the
spots that read from the pack_info array and access the actual
packed_git structs are guarded by either writing a MIDX bitmap or having
a non-empty preferred pack.

So I can see that we're definitely trying to close_pack() on a NULL
pointer, but I can't find a way to trigger that more directly.

(I think the fact that we don't appear to be accessing the packed_git
struct because the spots that want to are guarded by the same conditions
that cause us to call prepare_midx_pack() in the first place is pure
luck and not something that I am comfortable with us relying on. So we
should fix this up for sure, but I wish I understood the existing bug a
little more clearly first.)

> Add a new test that breaks under --stress when compiled with
> SANITIZE=address. The chosen number of 100 packfiles was selected to get
> the --stress output to fail about 50% of the time, while 50 packfiles
> could not get a failure in most --stress runs. This test has a very
> minor check at the end confirming only one packfile remaining. The
> failing nature of this test actually relies on auto-GC cleaning up some
> packfiles during the creation of the commits, as tests setting gc.auto
> to zero make the packfile count match the number of added commits but
> also avoids hitting the memory issue.

Hmm. Is this portion of the commit message out-of-date? I can't see the
check you're referring to that ensures there is only one pack remaining,
nor can I see the spot where we disable gc.auto.

> The test case is marked as EXPENSIVE not only because of the number of
> packfiles it creates, but because some CI environments were reporting
> errors during the test that I could not reproduce, specifically around
> being unable to open the packfiles or their pack-indexes.
>
> When it fails under SANITIZE=address, it provides the following error:
>
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
> ==3263517==The signal is caused by a READ memory access.
> ==3263517==Hint: address points to the zero page.
>     #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
>     #1 0x562d5d82d3ab in close_pack packfile.c:354
>     #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
>     #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
>     #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
>     ...
>
> This failure stack trace is disconnected from the real fix because it

s/it// ?

> the bad pointers are accessed later when closing the packfiles from the
> context.
>
> There are a few different aspects to this fix that are worth noting:
>
>  1. We return to the previous behavior of fill_packs_from_midx to not
>     rely on the incremental flag or existence of a preferred pack.
>
>  2. The behavior to scan all layers of an incremental midx is kept, so
>     this is not a full revert of the change.
>
>  3. We skip allocating more room in the pack_info array if the pack
>     fails prepare_midx_pack().
>
>  4. The method has always returned 0 for success and 1 for failure, but
>     the condition checking for error added a check for a negative result
>     for failure, so that is now updated.

Oops ;-).

>  5. The call to open_pack_index() is removed, but this is needed later
>     in the case of a preferred pack. That call is moved to immediately
>     before its result is needed (checking for the object count).

I think we need to do this in at least one other spot, but see below.

> +			if (prepare_midx_pack(ctx->repo, m,
> +					      m->num_packs_in_base + i)) {
> +				error(_("could not load pack"));
> +				return 1;

Looks good, though I agree with Junio's comment in his separate reply
that we could probably just turn this into "return error(...)" while
we're at it.

> @@ -1223,6 +1204,11 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>
>  	if (ctx.preferred_pack_idx > -1) {
>  		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
> +
> +		if (open_pack_index(preferred))
> +			die(_("failed to open preferred pack %s"),
> +			    ctx.info[ctx.preferred_pack_idx].pack_name);

This makes sense, but I think we need to apply similar treatment in the
"else if" arm of the if-statement immediately above this one too. That
portion of the code handles the case where we're writing a MIDX bitmap
but didn't provide a preferred pack.

When that's the case, we loop through to try and find the oldest pack
that contains at least one object. If we don't call open_pack_index()
all of those ->num_objects fields will still be zero'd, so we'll only
find the oldest pack.

That may actually produce wrong behavior if we have duplicate objects
that aren't uniformly resolved in favor of the earliest pack in lex
order. I'd have to think about it a little more to be sure, though.

Thanks,
Taylor
