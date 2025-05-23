Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082C2DCBED
	for <git@vger.kernel.org>; Fri, 23 May 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963348; cv=none; b=WwOWRgRXwwuqo4ZXo+X83qejaPrZeTw7ZG5/OWpMnl+r1OWls7lveS89PF5mSrkrAonMF1w/0h+nmOrFeFiKYAcd+L7fsfbyMn402duGzMAZRznahnviW8HlJ5aFY6Hmm8RGsBqB8YQh7M0T5xmVlelEiPudw0IEZBzkQribi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963348; c=relaxed/simple;
	bh=/9uGIy0KCdfB9YoQOxzgaOs9M+cwWEDfKPLe0b7kIRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSuAAdacMXF1hMeXKt9VHwryIXET6MbUERDj0/KMOYaPIn+Glpr7zQ7WNSDIFso/+26iH2pN2TbQV2goj1Sdr1k16sqJCx86L5jvBH5AFm3ILddH+uR7/Wed1e9chYw3iJIMPspTvPn6gR4xFa/ykKq0ljLubsWM7D9ayIkMMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w8tbVIjf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w8tbVIjf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5e2fe5f17so887208385a.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 18:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747963345; x=1748568145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g38XEV1lan0nOnaDE0VKeh0YUgh6MY0JepsOUGN5+2o=;
        b=w8tbVIjfTv5Q+BVxZMRsWjchLPbchic5XRFg32Xo0ax6RCD1GGT78S1RufFzM2glhd
         jR//+lr0mbbMbhqGvYmtZpG3D4TWzselcDMU9CGAoJOhDyJbdQUmPuOz1WL0IHLYc35E
         FxgUEK2fdF9PEoosOqy3FGRxUi2ve4yZcQUI9qKinzK44EKLY+vPTZ5kw+HAgrmhXowi
         reS7Vhro81srFHp0+TrleqW7yjFmN75HcVCxMi1wiDLRrvvqyM5qMvPGWgWdGz8ABdlG
         D0nqa79qgUnrY0FTTKOH9m3WILbrFbPCKVBxvU0n5LHZBzGt/5vPSzXrdiRSZ5Leib43
         vibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747963345; x=1748568145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g38XEV1lan0nOnaDE0VKeh0YUgh6MY0JepsOUGN5+2o=;
        b=vhLEbQpAeFgxLlVKa2WXh0ZJ/beNtXLBABKCh58itT10Yu9GXMJVISkEFdhRtVlRPF
         wHcpKR6bojJXTxxvdpbcIFCXYBACSgnPsDt/6UDqqn+PbebutMbpdlr6TIyycD6K1Q+n
         kaLyaIiB+3Gh7tXz8+uGJXBqUGEQWHQRiSIzzvwEkDOPfUaG6O/4jWYKossZ+0BEc3dJ
         FDCD4FTY0cBxrf7FE0Dv0h42n6+9h/rOiJRM7WN81nR0nvgaW76Zu7EP+TybWU2szliW
         kH0/nQoyk6ceNPOMOqGWjDIoyvUVdDgskDghYgS3sCW+UJGLgQRPiKmlt9B7QIJn8wBp
         LeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW0ASpU/qBzHv21SDxKMrgZEaGUbZHXRrF/wrwKYJjUImO2We5Rp8AuYrOQBbiFszOxb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwSfVy3QlqtetybMk1YOcLAwCsYisH5a3uxLvnmvXjVQUWBFq
	emTywMxgb1o9yaDAYNGGw9Lus9jGT367ri1KYhMjZ9J2XDP//QiC/xC6HNC7+5GkiPc=
X-Gm-Gg: ASbGnctqAFU/O4LR+nGSI7f2PWUODx9LvKIIctjBNNltVsIDE48Utw+1rIajMnYR9qP
	ABtaUZgvzBupM2xIwVv/qnwuAK4BwdwkmzektkwSXFM2pJ7bw5hcYRoj3JVDzYBPrLaC234gZ+8
	BbOkahCwFxGJ4/53h4t0ugmVRiC1Sw9LDv+q6yp/oyVu5K6LFoqxzrYco+Sk2ck4ykqPUj76+6c
	FO4S7PWwIltKxyQxRZ8nPxIE4cISCi+MRRuMI8shRPIWSN7xcjOqMjBGo6Ra2KmmYzR0TnON49B
	0o9a78HH4eRLpjWhMZ+uctpcfa4/JEClKb7dViDaFKQJftg2wNPrdsLZppAiIQTIsf0DUbtNHWF
	sk6/pk1JQ53w3y9T2wNEZRlw=
X-Google-Smtp-Source: AGHT+IHbUEJKhJKGVCWCXOoc9lQIyrtLwDOPJsfyO20/hIAwoAkD9xO9XWCeHwe0iJkbxj8wiNQ7Fw==
X-Received: by 2002:a05:620a:d95:b0:7cd:348:1e11 with SMTP id af79cd13be357-7cd467af0c1mr4256909985a.47.1747963344758;
        Thu, 22 May 2025 18:22:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467c08e1sm1105102785a.17.2025.05.22.18.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:22:24 -0700 (PDT)
Date: Thu, 22 May 2025 21:22:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <aC/Nz2wQgncXzFvs@nand.local>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
 <xmqqbjrk7ikx.fsf@gitster.g>
 <20250522165924.GA1613@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522165924.GA1613@coredump.intra.peff.net>

On Thu, May 22, 2025 at 12:59:24PM -0400, Jeff King wrote:
> > By the way, I suspect I am not reading the code correctly, but I am
> > not sure what fill_midx_entry() does with a failed case.
> >
> > 	midx_for_object(&m, pos);
> > 	pack_int_id = nth_midxed_pack_int_id(m, pos);
> >
> > 	if (prepare_midx_pack(r, m, pack_int_id))
> > 		return 0;
> >
> > With or without cached failure, this should return 0 when and only
> > when m->packs[pack_int_id] is a usable pack.  But what about the
> > access on the next line?
>
> I think there's a subtlety here with incremental midx's, in that a pack
> id can be "global" within the whole midx chain, or a local index into a
> specific chain element's list of packs.

If you'll indulge me in a bit of pedantry for a moment, I would add that
the pack_int_id is *always* global within the whole MIDX chain. It only
happens to additionally be the correct local index when
m->num_packs_in_base is zero.

The thing here:

    m->packs[pack_int_id - m->num_packs_in_base];
             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

is indexing into the current layer's pack array, which only contains the
packs at that layer, so the index there is no longer really a
pack_int_id at all.

But...

> In fill_midx_entry(), I think we get such a global id back from
> nth_midxed_pack_int_id(). And then when we hand that to
> prepare_midx_pack(), it is converted into a local midx/id pair with:
>
>   pack_int_id = midx_for_pack(&m, pack_int_id);

...this confusion is really my fault, since the thing midx_for_pack() is
returning isn't really a pack_int_id in the classic sense at all. I
think I chose this name to avoid making the patch noisy, and to avoid
the possibility of accidentally using the global identifier when you
meant to use the local index.

(As an aside, I think I recall you suggesting a while ago that it might
be interesting to define "global" things with a different type than
"local" ones to prevent this sort of confusion. That would allow us to
keep both "pack_int_id" and the return value of "midx_for_pack()" in
scope at the same time, without the possibility of using one when you
meant to use the other.)

> where the end of that function is the same:
>
>   return pack_int_id - m->num_packs_in_base;
>
> you saw elsewhere. So at that point we have a local midx and index,
> which is what prepare_midx_pack() fills via the m->packs[pack_int_id]
> field.
>
> So when you say "only when m->packs[pack_int_id] is a usable pack", you
> are talking about the local m/pack_int_id within that function.
>
> But back in the caller...
>
> > 	p = m->packs[pack_int_id - m->num_packs_in_base];
> >
> > Do we have any guarantee that we called prepare_midx_pack() for
> > the pack at (pack_int_id - m->num_packs_in_base)th slot?  Can p
> > be NULL here?  And with the magic "we know this fails" value, can p
> > be that magic value?
>
> Our pack_int_id is the global one, so it needs to be adjusted. But this
> pack pointer we access is the same one that was filled (or not) by
> prepare_midx_pack(). So it cannot be NULL or the magic "fails" value,
> because prepare_midx_pack() returned 0.
>
> So I think this code is fine.

Thanks for the analysis.

> One thing that did puzzle me: in prepare_midx_pack() we not only adjust
> the pack_int_id, but we may walk back through the midx chain to find the
> correct multi_pack_index struct. Wouldn't the caller need to do the
> same?
>
> The answer is that it does. The midx_for_object() call in
> fill_midx_entry() does that same walk, storing the result in its local
> "m" variable. So the walk backwards in prepare_midx_pack() is
> superfluous for this particular caller, who we know is already handing
> us the desired multi_pack_index struct, and it could just do:
>
>   pack_int_id -= m->num_packs_in_base;

Right. You could imagine that after getting the pack_int_id back from
nth_midxed_pack_int_id(), we could do:

    midx_for_pack(&m, pack_int_id);

, which would be a noop because of the chain invariant that we never
duplicate objects or packs anywhere in the chain. (IOW, if you know
object X is in pack Y, and you move your MIDX pointer to the layer
containing X, you are guaranteed to be able to find Y in that layer's
array of packs.)

> rather than calling midx_for_pack(). But the same is not necessarily
> true for other callers, so we should continue calling that function.

...exactly ;-).

> I suspect this would all be a bit more obvious if prepare_midx_pack()
> simply returned the pack pointer, avoiding the need for callers to look
> at m->packs at all (and making it a true cache, internally only to
> prepare_midx_pack()).
>
> Looking at other callers of prepare_midx_pack():
>
>   - in fill_packs_from_midx(), we do not adjust our "m" to match the
>     index. But that is OK, because we adjust our local index (which we
>     get by iterating from 0 to m->num_packs) to a global index when
>     calling the function:
>
>       if (prepare_midx_pack(ctx->repo, m, m->num_packs_in_base + i))
> 	...
>       open_pack_index(m->packs[i]);
>
>     which is fine.
>
>   - I'm less sure of the call in expire_midx_packs(). It iterates over
>     num_packs in the same way, but does:
>
>       if (prepare_midx_pack(r, m, i))
>               continue;
>
>     and then looks at m->packs[i]. That would be wrong if "m" is not the
>     first item in the chain. Ah, I see. Earlier we do:
>
>       if (m->base_midx)
>               die(_("cannot expire packs from an incremental multi-pack-index"));
>
>     so we know that the global and local ids are equivalent in this
>     instance (since the "base" midx . Still seems a bit fragile.

Yeah, I think you can only meaningfully expire packs from the most
recent layer, which is why I added that guard. I agree it is still
fragile, though.

>   - There's a similar case in midx-write.c:want_included_pack(). That
>     one seems to have the same local/global confusion, but I do not
>     obviously see anything preventing it from being fed a non-base midx.
>     So it might possibly be buggy?

Yeah, this spot is definitely broken. At minimum it would need something
like:

--- 8< ---
diff --git a/midx-write.c b/midx-write.c
index 0897cbd829..54a04f7b75 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1634,9 +1634,10 @@ static int want_included_pack(struct repository *r,
 			      uint32_t pack_int_id)
 {
 	struct packed_git *p;
+	midx_for_pack(&m, pack_int_id);
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return 0;
-	p = m->packs[pack_int_id];
+	p = m->packs[pack_int_id - m->num_packs_in_base];
 	if (!pack_kept_objects && p->pack_keep)
 		return 0;
 	if (p->is_cruft)
--- >8 ---

>     Likewise fill_included_packs_batch() in the same file.

I think this one is actually OK for the same reason as the
expire_midx_packs() case. Its sole caller in midx_repack() has:

    if (m->base_midx)
        die(_("cannot repack an incremental multi-pack-index"));

, so we are OK there. We might want to add an ASSERT() in
fill_included_packs_batch() to make it clearer, though.

>     In both cases I think if prepare_midx_pack() returned a pointer, we
>     could just use it directly.

Agreed.

Thanks,
Taylor
