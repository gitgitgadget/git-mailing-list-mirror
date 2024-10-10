Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC9192D67
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580028; cv=none; b=MmhpBOHCJp5FQ6bo96YKoHqDRvH0TLWWeEScQXJaAbtlDkswTJ1vOOFKIQKKBGKKGesFMQl7rcmWr5AM3rwX4HSu3sDqsa9La0QV/DwkFX0blD/Z6UKwnYBxqW1vhpWX+uoY9LLASFwfYolxrSkE+mNIzZO+M7N5kj5aQ2ozQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580028; c=relaxed/simple;
	bh=cxUGFm7BHihdwVsp/MG0mj9HIgpw09bLx1iIgkOsEW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE26oq1UfWoTa4u3GC3M20PXh6l5pgnAs20taIEMnSoWaaxmXDWC1ZAPo9DinqszTOh4DUWOMCwYMq24EFr3iZen/6YUJT7HJDXvHD7uLgHvJzgnarbcmRvFJjzUujynxsEOJxU2HNMjDlwU5kStTCj9w/nq/YQ8AKP6YTeNXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SNHNH4/T; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SNHNH4/T"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03caab48a2so943820276.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728580025; x=1729184825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4slaRfertxRkU6ux2q9dvF4LwUWW171MmaPEboiFUY=;
        b=SNHNH4/Tf4hgooWHHT1grXWrVNsWdA6omvggpstYl1QaYy1AaooSXByPri+YiuzvcI
         UaAaZKEIbiunuS2jsMX1Ww1feXEV5nmwr8zBo/d1CUiKapQGBt2yeZhyQq+xDvJSIuxW
         AYUSc/mgSMGWiwLWaICOVuhUCsF7Lo3xN2KSwtM1ndM1kI4Rz+b69Ssp1vm8DROuvmAC
         onBNlaEc0vbBSEENTGpKdlJCGRDgvyllSiC+9N1+N7cBSynjXuXPYQLV8n26b8IbN65u
         2s7pfoG8FXQNBtm3xSYTDKMrQi56ifYpmlP2QbKK9nlr9rQ+l6z4ldaRVxfAzf02fBGu
         zhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580025; x=1729184825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4slaRfertxRkU6ux2q9dvF4LwUWW171MmaPEboiFUY=;
        b=FwbFKD9j6mOutu0U9Fu68hdLSZNARgIjh0sw/XKi9gAokx7ZgxZ5ZY5UTgsOOU3Zvb
         jGXONywtLyhQI68PIs7K2lWRLr4v0AMmQUZx1oznSTOMb9OM41qBDGl53e2paGSK5DpP
         YwJCg/v2EyxMaP4u4n2L3YkCsAz+CUji0qku3Sfb6yay+ZBWSQWyY9J8Oi4wjxThS0yy
         Eb/JgGV1Hqi54vnPv500EglRWX+y+U16hbs6roaNbm8COk3/ilWMadBLsLZmfZrkr2Kc
         fF2jh8H9xqb8eFDQv/HuPPYUXgyTRocZjl5diathfWYnF2B/APBBbvsvwz9zQvsVvQAl
         gnTQ==
X-Gm-Message-State: AOJu0YzzPcLCk9NpDTbzH31+qpUdS++UI/SQjed3RMFa5nbvDBlIXOK/
	i/3GTgeN3i9rISDD4alYT+h0CGbXjqbQafwk+q0RoLH57j3uCZgMJfUO/uOdfRqIQFU9D12JbNO
	P4To=
X-Google-Smtp-Source: AGHT+IHEV7MNVmrgBpR+9pSCYyGfRqaV4EtRdVb9CJcf0wBneYreWfWpkq6tgsRO4yvkf0E4ZqgPIg==
X-Received: by 2002:a05:6902:2d02:b0:e29:564:1f23 with SMTP id 3f1490d57ef6-e290b86afeemr3274675276.21.1728580025225;
        Thu, 10 Oct 2024 10:07:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ef5c47bsm372053276.42.2024.10.10.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:07:04 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:07:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <ZwgJt19kWVRTQhld@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <xmqqzfnblxdj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfnblxdj.fsf@gitster.g>

On Thu, Oct 10, 2024 at 09:46:00AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This patch series enables more objects to be candidates for verbatim
> > reuse when generating a pack with the aide of reachability bitmaps.
> >
> > By the end of this series, two new classes of objects are now reuse
> > candidates which were not before. They are:
> >
> >   - Cross-pack deltas. In multi-pack bitmaps, if the delta and base
> >     were selected from different packs, the delta was not reusable.
>
> Hmph.  Suppose that you need to send object X, you happen to have X
> as a ofs-delta against Y, but Y may appear in multiple packs.
>
> Even if the copy of Y you are going to send together with X is from
> the same packfile, you may not be sending all the objects between X
> and Y in the original local packfile, so you would need to recompute
> the offset to give ofs-delta X to the distance between X and Y in
> the resulting packstream, no?

That's right. When doing verbatim pack reuse, we mark reused "chunks"
(c.f. 'struct reused_chunk'), where each chunk records the offset of the
beginning of the chunk in the source pack, and the difference between
that value and the corresponding byte in the assembled pack.

So suppose like in your example we have X and Y from the same pack, and
we are sending both objects, but not necessarily every object in between
the two from the source pack. In that case, X and Y will end up in
different chunks.

When we go to actually rewrite the OFS_DELTA for X, we'll compute:

    off_t fixup = find_reused_offset(X) - find_reused_offset(Y);

(in the code, X and Y are actually the offsets for each object in the
source pack, but I'm using the object names here for clarity).

When there is a non-zero fixup value, we'll patch the OFS_DELTA to
account for the gap between it and its base object. The details of how
that is done are in builtin/pack-objects.c::write_reused_pack_one(), in
the 'if (fixup) { ... }' block.

> So when you pick the copy of Y out of another pack, what's so
> different?  After emitting Y to the resulting pack stream (and
> remembering where in the packstream you did so), when it is X's turn
> to be emitted, shouldn't you be able to compute the distance in the
> resulting packstream to represent X as an ofs-delta against Y, which
> should already be happening when you had both X and Y in the same
> original pack?

Good question. The difference is that if you're reusing X and Y from
same pack, you know that Y occurs some number of bytes *before* X in the
resulting pack.

But if Y comes from a different pack, it may get pushed further back in
the MIDX pseudo-pack order. So in that case the assembled pack may list
X before Y, in which case X cannot be an OFS_DELTA of Y, since offset
deltas require that the base object appears first.

> >   - Thin deltas. In both single- and multi-pack bitmaps, we did not
> >     consider reusing deltas whose base object appears in the 'haves'
> >     bitmap.
>
> I hope this optimization does not kick in unless the receiving end
> is prepared to do "index-pack --fix-thin".

It does. We only allow computing "thin deltas" when pack-objects was
invoked with `--thin`.

> I've never thought about this specifically, but it is interesting to
> realize that by definition "thin" deltas cannot be ofs-deltas.

Yep.

> > Of course, REF_DELTAs have a less compact representation than
> > OFS_DELTAs, so the resulting packs will trade off some CPU time for a
> > slightly larger pack.
>
> Is comparing ref- vs ofs- delta a meaningful thing to do in the
> context of this series?
>
> What does the current code without these patches do in the same
> situation?  Give up on reusing the existing delta and then?  If we
> send the base representation instead, the comparison is "we
> currently do not use delta, but with this change we can reuse delta
> (even though we do not bother recompute the offset and instead use
> ref-delta)".

The current code does not reuse deltas when we're either (a) not sending
the base, (b) we are sending the base, but it's in a different pack, or
(c) both. When any of those conditions are met, we do not reuse the
existing on-disk representation of the delta object verbatim, and
instead kick it back to the normal pack generation routine.

That might result in us finding a new base, or applying sending the
object's contents as a standalone object.

> Do we recompute the delta on the fly and show it as an ofs-delta
> with the current code?  Then the comparison would be "we spend time
> doing diff-delta once right now but instead reuse an existing one
> (even though we do not bother recompute the offset and instead use
> ref-delta)".

Fair.

Thanks,
Taylor
