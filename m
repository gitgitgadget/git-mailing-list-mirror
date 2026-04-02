Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE937C108
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170292; cv=none; b=Bep8+xOds+qffjj7YrBxg04BzaY0uxXThWeU5fXU8xixlX8uDjLrU3auwt+vrMXO2qgXZK+EPT0dUU2QB18k79l2/SU6u8gXG3sVwSFld5FqQnrCSaNXenjejL//ht6psZ/kmGoaR1dCl1DOiDirKxX0uyCwHLxq+FNEanjSdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170292; c=relaxed/simple;
	bh=dKLeagNUXBbJ3u12PrZHvnRxGy8Ejws1fo9IwCF3Kns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX5DSVEkZWSWzAbTVJ6/zTVyJdQ84Kp7LPAvj5FZYBvlHzspX9PUk+I7BQ/Dn7UQDJtgILN4RZqYZIBhgq/0BQ+l8J3899zh+Z37IFIxkg4YEtrFmcv2stG0eNzxIxvH5iYgBMHhr4cQkT0AzjnbmdXwOmPohwYHoPEQFJpb/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FcBLeZ+R; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FcBLeZ+R"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-466f00535cfso890325b6e.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1775170289; x=1775775089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNWLMoafKuTRpQQVKTiUg1rFoEwqgSNsNQeApYfIv0o=;
        b=FcBLeZ+RiwHkETk+ebvyjzz6irtpCTSsgqIlLncIf1KDUyus0kJZ0gXA2juLnEoWdL
         YYsKFlBlj4uQZpMLCyM2RjnYVAhNnR5xy+oZy6XgO08HwI6aDoTeY9heEXuqwep1XL5w
         BTP2MXV90I0Zkf9Es6ZeKx8FwTPxlKsIWU35aI+lOF6um+BeKcEP6G8+LmeMbP+0dfgV
         gT9ol99VityXnEEFlbGIJ7ITMedS9dgXjoiUMhbc1i3nqoWTZuFQViE0mHbk82oqcAQt
         BpxfVORP9uf0ogtornpmdfAYVnKeYFrqrgrc0Pwr0mtKd12R6k2S8i6k3KSiu5ak4jCx
         NGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170289; x=1775775089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNWLMoafKuTRpQQVKTiUg1rFoEwqgSNsNQeApYfIv0o=;
        b=YFrmU0nX72R5ZBVi0JRoJVHe8YLZxDfr6tcsoRw7KTIwi+y0FaIl20YCLuETe8ul+b
         8iZjCtPT3ygxDDYIs4NRZe9TQCX0WW+M3yiCmYiu9Qyf80mqlr2iPiaRR/hvfIBDitAp
         zYRHmmVY1Kj1vhZttPl8cuz9ZOWB6+z6am57W2dZKlV+nkUVKSAKx3F9vmjAniwCqOiE
         MjS6nP5W8cKD+aEthQJIkrQLQoVYNN06Dz59GXFzkQvxLUKiv96kxJF06drm+fe+1V7G
         6GAiuA/uL88OGM4vJe+C2IZVWZCXFy7zlGILbbCLF3hc4Qed9fWwIEeSFqgZQg7hX39f
         S90A==
X-Gm-Message-State: AOJu0Ywu+/ocxFshzGrZq7pteJ5sI4tQFb/RIc8iYEDE8hlVfhISarw3
	z9n66AZzTW1NbL9irw4eghgVUdPZ4LsSisD3iU5KvKZO4HAuSbN5Xu1bm95+71aNVxICStuYYdv
	mfrvBaQw=
X-Gm-Gg: ATEYQzwkRZvPL222OszyzRWoc6qBhHW1At20Vt0nlQfHdlhBj0ZAlpvAqBfp06vo6W8
	c6xe+rAdUI/Grn9Ov+Zdc2pHLjuXReBV034dltmjIfQHDC9rXNZ7fNvBALDHrmoEwmwRdmgusoS
	nmKqot0lxdSAdRFcEOq32LCCGLvrNJjXVM205VaFwRX3iTayvDPcb0OfgLI9sichyIT71dvBPtD
	Dzs656TZ2JiC7CJ8n+bx5RPfcn3fJg/EkiYeclkdA6BCpVoGwbUqlHm/ZzUwMHNG1/i4Bm3HyKI
	P2o0pGpl5RYxs5K4CCVoWf57lYOOpb8KdgsNDSpu7PNbQAf2zB+IIMuCJ3np5O6VB+WkCJ8e4OP
	a4U1XzdjmQHowRkFpcfD4i9fN0b5EQ17FQqV+ArKyVyqAVJidhz/MZ1NHynPxhG9uOr0iybesBD
	uFnSWOiq9Mj3Tjy7BhGqGqSPHCYoEanUsjOG8zDkC2eRKqDVW7aSVE2k8pTFq1FyIXsjdbMXSH2
	B1EUexBwjgAqji8zJGnTDZ00RPEdQ==
X-Received: by 2002:a05:6808:4f29:b0:467:fab6:c7ed with SMTP id 5614622812f47-46ef8d5c008mr636626b6e.50.1775170289580;
        Thu, 02 Apr 2026 15:51:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4230fb42ec7sm522310fac.0.2026.04.02.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:51:29 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:51:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/16] midx: introduce `--checksum-only` for incremental
 MIDX writes
Message-ID: <ac7y7t+Qgm0htU3c@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <41cb5471bb96d38a1b9ae75d022e2c5356318939.1774820449.git.me@ttaylorr.com>
 <20260330231547.GE41843@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330231547.GE41843@coredump.intra.peff.net>

On Mon, Mar 30, 2026 at 07:15:47PM -0400, Jeff King wrote:
> Your goal makes sense, but that is not at all what I would have expected
> a "--checksum-only" option to do. From the name I expected it to just
> compute or verify checksums and not write anything to disk. I dunno.
> Maybe it should be "--no-write-chain-file" or something?
>
> This is perhaps on the border of bike-shedding, and maybe the fact that
> it is an option of "multi-pack-index write" would be enough to clarify.

Heh :-).

I think that it definitely qualifies as bike-shedding, but I'm glad you
brought it up. I hadn't considered the name being potentially confusing,
but now that you mention it I can't un-see it.

Calling this something like '--no-write-chain-file' feels like a good
choice to me, and doesn't paint us into a corner if we want to later add
an option that does something like you describe above.

(As an aside, we already have 'git multi-pack-index verify', which is
probably the closest thing to what you're describing, so perhaps the
concern is lessened by that fact. But even if we already have that
functionality laying around, I think that "--no-write-chain-file" is a
more descriptive name for the command-line flag than "--checksum-only".)

> > @@ -239,6 +254,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
> >  	if (argc != 2)
> >  		usage_with_options(builtin_multi_pack_index_compact_usage,
> >  				   options);
> > +
> > +	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
> > +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
> > +		error(_("cannot use %s without %s"),
> > +		      "--checksum-only", "--incremental");
> > +		usage_with_options(builtin_multi_pack_index_compact_usage,
> > +				   options);
> > +	}
> > +
>
> OK. It's sad that we have to duplicate these bits between the write and
> compact operations, but I'm not sure how much sense it would make to
> factor out common options (both how much work it is, and how much
> duplication we could actually drop in practice).

I agree. I looked at unifying these a little further, but decided
against it as it ended up making things more complex than it was worth
IMHO.

> >  	if (ctx.incremental) {
> > -		FILE *chainf = fdopen_lock_file(&lk, "w");
> >  		struct strbuf final_midx_name = STRBUF_INIT;
> >  		struct multi_pack_index *m = ctx.base_midx;
> >
> > -		if (!chainf) {
> > -			error_errno(_("unable to open multi-pack-index chain file"));
> > -			goto cleanup;
> > +		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
> > +			FILE *chainf = fdopen_lock_file(&lk, "w");
> > +			if (!chainf) {
> > +				error_errno(_("unable to open multi-pack-index chain file"));
> > +				goto cleanup;
> > +			}
> >  		}
>
> OK, and this is the actual write which is skipped. I guess this could
> also be conditional on is_lock_file_locked(&lk), assuming we initialize
> it with LOCK_INIT. In some ways that seems easier to analyze to me,
> since you don't have to realize that "lk" is only active when
> CHECKSUM_ONLY is not set. But I don't think there's another reason we'd
> choose not to take a lock file, so I think it may be six of one and half
> a dozen of the other.

Yeah, I think this is more or less equivalent. In some ways I like the
explicitness of the conditional as it is currently written, but I think
your suggestion reads clearer.

It ends up producing nice code like:

    if (is_lock_file_locked(&lk)) {
        FILE *chainf = fdopen_lock_file(&lk, "w");
        /* ... */
    }

which is pleasing to me in the sense that it reads like "if the lockfile
is held, then do something with it".

I think there is a small risk of coupling the state of the lockfile with
the MIDX_NO_WRITE_CHAIN bit in the flags, but it's easily mitigated by
an ASSERT(opts->flags & MIDX_NO_WRITE_CHAIN) in the else branch of the
conditional above.

There are a few such conditionals, and repeatedly checking that the flag
bits are set is wasteful, so I check it only once in the big "if
(ctx->incremental)" block, and then once again in the top-level
write_midx_internal() function before we do the final commit and
cleanup.

Thanks,
Taylor
