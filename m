Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0F248891
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347152; cv=none; b=Ntb8bas3ttn8xnnPKLM8GoEXkdi6uCB5t6NU0fvdPFshFeIn8yuuOOeplskYjwQT3IxKnVdQH60ftD6xJwd6s9g8m2vFKIksvsRLvdC75h1Y0kiXP3ud18oM0i1GSZZVZAq+2fakJNLFxd2+UAan2gO2bGOG9F/jnDhFbqoRBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347152; c=relaxed/simple;
	bh=NF7nv29bX8fNSo/4yjw//e+b5gyny4F6fSSoV2l18xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl1VJL90e5CtHOZTMLwYFT5rRd05jsfKGputERFzGI8UWfzCbA81zRjKPZku62boO3ORaUXO73zUDtontHKj/+K3ZYtrCJjOpQgoaMvM31PnMTRS78zGHa/MXzD2QnZMSK9yas0Hnc5Ar4FdA88ypV80UUBExr492CM6mtlZe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FSQ99mR3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FSQ99mR3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-792815157f3so29954697b3.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768347149; x=1768951949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHS+B55R/wdjzXIr67euBs7M5IDX03kjSEEnHpBHoSM=;
        b=FSQ99mR3RA9N7cJIxFj4wEKnEDl9N2SfbgFMFNX+5zV68ni8Gvrs+KgCXHMxCwTJuC
         JsFtrWzXxCC34J4cnefYo8F98DAZ6mXX6PGy6Qql6YzZFYas3I9XX2fgI8E7Cx4oMubt
         mOAXNr+LxQiY5AGIT+bkP311l/l3aZtJWHwweuYna/WY7+xir4ASphqdgJQfr/6F3mvM
         +paTGRxg1LAoRUSLIA99i+hLd8zso+rsJUN/FMZ/cFykUoEmcfm69p2lTBucQQZYKxNT
         D8ZmHpDuyQAk1Acyadr+mOWvk4l5VYQHOl06HKbOg7J01AnOadAy6asZULa8iKYGBAM/
         tdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347149; x=1768951949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHS+B55R/wdjzXIr67euBs7M5IDX03kjSEEnHpBHoSM=;
        b=NxIyoffmFVq8LBt1f0IGRQ46JY2arQw+NRJ+Eur1cZoHNM6mCzuQzHugEutuibJW2n
         JGAzw4XxuA7RiBMLfmAWM2v2ub6AicbJYB0KJMmq5QEvJRStLLmj686DiACkXh+u1pKa
         TvCxY0be+Ch8hK89E5NqsS0xMA+/2GRBAAkZjrDufiGkIJVVPone7JYXGVsr/mBaUwp4
         KNV3TTz6kLC/penLgVlykoC1Y7SOv72j/6/Tj7mW+RMzuq/RXAe2PKZeMnmrCB5j2nap
         kFK98g7qRn/IAxPpOo+k2vwGdLh0Qjfdnf0nuA7fGHQux9gschhbzhth0d7A669nuaoM
         cgnw==
X-Gm-Message-State: AOJu0YwqDfJzoF1kKRG4oGI0DrZZmRRvXt3uHtFTtPl+ByarhiRs0mhw
	8v4qFXNPuP8DxeLUYOmuD8kqP3NJnXKHDtb7NHBcdJ1iGXfIowvDwo7I6pZHKyA9G38=
X-Gm-Gg: AY/fxX4g3FJQCPcZ3Z5RIX5C5W+gp6kvmdFYlsnvPZl2YHCiHieKKE0XKUR1pFFfCqn
	cH4moquh9yuZNRUliMB6td6be8E3SzBj9TbyJ9LT3Lgzyg0ygymm15lSaovhxCmjQ3JRG0f5Whz
	3ekiqZSG9buS2Tk6X4Z3N1HcL0zR7RbmY2941f1dHBV84JmPeLEF/jOgK1+fqzyR07yglaJ6DwB
	Xnf2rCaBcmkunCxB6ymlR4fxteo/uLZ8pGDmeGqTvcqUnzCUWz7jU6AYVXKukaWxC8uiyPGy+AY
	hGZQhT6urDXFZwpegJu2GNJzNZGCYUisA24/SvNk/KAuSIdyJz+pP7tCFMpUkhYwsv9GgMqMw0C
	FkrE7qnCkguxvcA1uGUw0PFGdNCrL3w+kIBEDQGLlYAKSDE4hF/L56gwpQpmw6qIUTAICjAqMtP
	hWThQgIdzXEwMe1OXggTR95hL6yWi5iFm0gK6UafqZ+uJVMU/SrHNc7QSQC/C3bEncwmpAQmTA/
	zY7rrFuzVJRiFQ0Jw==
X-Received: by 2002:a05:690c:e3cd:b0:786:449a:176b with SMTP id 00721157ae682-793a19c5ae5mr5591497b3.21.1768347149418;
        Tue, 13 Jan 2026 15:32:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a3969sm84930787b3.43.2026.01.13.15.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:32:28 -0800 (PST)
Date: Tue, 13 Jan 2026 18:32:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/17] midx: implement MIDX compaction
Message-ID: <aWbWC4nTnP52lxSg@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <c136b2e179d02321de7e7b3f1b6c748cb434d68d.1765053054.git.me@ttaylorr.com>
 <aTfN_PycU9ag8c0u@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTfN_PycU9ag8c0u@pks.im>

On Tue, Dec 09, 2025 at 08:21:32AM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:47PM -0500, Taylor Blau wrote:
> > diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
> > index 164cf1f2291..a9664e77411 100644
> > --- a/Documentation/git-multi-pack-index.adoc
> > +++ b/Documentation/git-multi-pack-index.adoc
> > @@ -12,6 +12,8 @@ SYNOPSIS
> >  'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
> >  		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
> >  		         [--refs-snapshot=<path>]
> > +'git multi-pack-index' [<options>] compact [--[no-]incremental]
> > +		         <from> <to>
> >  'git multi-pack-index' [<options>] verify
> >  'git multi-pack-index' [<options>] expire
> >  'git multi-pack-index' [<options>] repack [--batch-size=<size>]
> > @@ -83,6 +85,17 @@ marker).
> >  		necessary.
> >  --
> >
> > +compact::
> > +	Write a new MIDX layer containing only objects and packs present
> > +	in the range `<from>` to `<to>`, where both arguments are
> > +	checksums of existing layers in the MIDX chain.
> > ++
> > +--
> > +	--incremental::
> > +		Write the result to a MIDX chain instead of writing a
> > +		stand-alone MIDX. Incompatible with `--bitmap`.
>
> Interesting. What would happen if you compact a subrange of the MIDX
> chain without incremental? Would the MIDX be completely replaced with a
> MIDX that only covers these packs?

That's right.

> Also, the "--bitmap" flag does not exist yet, so the second sentence
> probably needs to be introduced in the next commit.

Ah, great catch -- I removed that line here. I don't think it needs to
be readded in the following commit, though, since that patch introduces
"--bitmap" and makes it compatible with MIDX compaction.

> > +	if (!from_midx)
> > +		die(_("could not find MIDX 'from': %s"), argv[0]);
> > +	if (!to_midx)
> > +		die(_("could not find MIDX 'to': %s"), argv[1]);
> > +
> > +	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
> > +
> > +	return ret;
> > +}
>
> Is it valid if `from_midx == to_midx`?

Yes, that would result in a noop write.

> > +	while (m != ctx->compact_from->base_midx) {
> > +		uint32_t pack_int_id, preferred_pack_id;
> > +		uint32_t i;
> > +
> > +		if (bitmap_order) {
> > +			if (midx_preferred_pack(m, &preferred_pack_id) < 0)
> > +				die(_("could not determine preferred pack"));
>
> `midx_preferred_pack()` only returns a valid pack ID in case we've got a
> reverse index, and as far as I understand we seem to only generate those
> when computing bitmaps. I assume that this means that we can only
> compact MIDX layers in bitmap order if they already were in bitmap order
> before?
>
> That would at least also make sense. We of course cannot randomly change
> the order in the middle of our layers, as that would break later layers
> that build on top.

Indeed, we only generate a reverse index for a MIDX if we are writing it
with bitmaps, since there is no other purpose for having a revindex
outside of reachability bitmaps.

So if we have a bitmap and are compacting, then we need to retain the
order of the packs as they appear in the pre-compaction pseudo-pack
order to avoid permuting the bits corresponding to those objects. In
other words, you're correct in saying that we cannot start writing
bitmaps during compaction if we did not have bitmaps to begin with
pre-compaction.

> > +		for (i = m->num_packs_in_base;
> > +		     i < m->num_packs_in_base + m->num_packs; i++) {
> > +			if (preferred_pack_id == i)
> > +				continue;
> > +
> > +			if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
> > +						i) < 0)
> > +				return -1;
> > +		}
> > +
>
> So the condition that should hold after this loop is `pack_int_id ==
> m->num_packs`. Which is somewhat obvious: we skip one pack, but that
> pack is the preferred pack that we have populated first.

Exactly!

> > @@ -1101,11 +1216,18 @@ static int write_midx_internal(struct write_midx_opts *opts)
> >  			 */
> >  			if (ctx.incremental)
> >  				ctx.base_midx = m;
> > -			else if (!opts->packs_to_include)
> > +			if (!opts->packs_to_include)
> >  				ctx.m = m;
>
> I'm a bit surprised by this change here. I would've expected that we
> never pass `packs_to_include` when compacting, so why is this change
> necessary?

Right, we do not pass packs_to_include here during compaction. But if we
are doing an incremental compaction, then we do want to assign ctx.m in
addition to ctx.base_midx.

> > diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
> > new file mode 100755
> > index 00000000000..f889af7fb1d
> > --- /dev/null
> > +++ b/t/t5335-compact-multi-pack-index.sh
> > @@ -0,0 +1,102 @@
> > +#!/bin/sh
> > +
> > +test_description='multi-pack-index compaction'
> > +
> > +. ./test-lib.sh
> > +
> > +GIT_TEST_MULTI_PACK_INDEX=0
> > +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> > +GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
> > +
> > +objdir=.git/objects
> > +packdir=$objdir/pack
> > +midxdir=$packdir/multi-pack-index.d
> > +midx_chain=$midxdir/multi-pack-index-chain
> > +
> > +nth_line() {
> > +	local n="$1"
> > +	shift
> > +	awk "NR==$n" "$@"
> > +}
> > +
> > +write_packs () {
> > +	for c in "$@"
> > +	do
> > +		test_commit "$c" &&
>
> Nit: it might be sensible to disable housekeeping here. You strongly
> depend on the on-disk shape of the objects, so if you by chance wrote
> two objects starting with "17" we'd end up repacking and racing.
>
> I've also got an upcoming patch series in mindthat I've got cooking to
> make geometric compaction the default for auto-maintenance. We've got
> many test suites that implicitly rely on the current algorithm used by
> git-gc(1), so I'd love to avoid adding more.

I'm not sure I follow what you mean by "housekeeping" here. Are you
referring to maintenance.auto? If so, we shouldn't be writing so many
packs as to trigger that during these tests, but I can disable it as a
sanity check just in case.

> [snip]
> > +test_expect_success 'MIDX compaction with lex-ordered pack names' '
> > +	git init midx-compact-lex-order &&
> > +	(
> > +		cd midx-compact-lex-order &&
> > +
> > +		write_packs A B C D E &&
> > +		test_line_count = 5 $midx_chain &&
> > +
> > +		git multi-pack-index compact --incremental \
> > +			"$(nth_line 2 "$midx_chain")" \
> > +			"$(nth_line 4 "$midx_chain")" &&
> > +		test_line_count = 3 $midx_chain &&
> > +
> > +		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" A &&
> > +		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" B C D &&
> > +		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
> > +
> > +		test_midx_layer_object_uniqueness
> > +	)
> > +'
>
> It would be nice to also test for requests that don't make sense: "from"
> larger than "to", "from == to", missing "from" or "foo" and so on.

All good suggestions, thanks!

Thanks,
Taylor
