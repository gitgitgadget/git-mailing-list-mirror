Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF05330D24
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698868; cv=none; b=GEqycmEUxAG40nOChwQvsX41jFgL2Mog8Jnci4KJ2DhV/8XxNH1a2wF72OvW7CNQC575YR/CvIbF8ojGVMm0IYCoR9yuidEuv5Ih5Nl5N2m6Auyu5yc6WG+Wn3VCaGub7CifNBu/la+uNvL6uLMpuSCC2Zei2inZM9KL6MfORdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698868; c=relaxed/simple;
	bh=ktzU2nQ9wjsby0Oyimg2K1muu/wCsfzU6AxIHvk1Y+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLCUdqiQ5RLYyNx3a9LlqEsYAXCf2dQrBSV8z/xuyK4iLC9De5T0i5MH7+QtPFmceqwJ6QsFlcbwDwOlXl0MkJgTrNyPoyhVKjYvbWDpnmHY+cQoTVO3Haz8n1R0uWdwcCuYORCxIMqXjST8RCftdoPq0SnUYRwTVvuosWfaOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=He/r9i2J; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="He/r9i2J"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c9f6b78ca4so647891585a.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773698866; x=1774303666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9o2SUwvNFY/+s6bOX+uLRqhp8nbm4c3A307w/r1BnI=;
        b=He/r9i2JLbeeYsNpumfpZ/kjRI1MPOhDKmGQOHn5GJlYv1GVq45RIN/fk+F2+SFTPp
         hf2GSQRiXMQZ8EiiP/OwQcNhiIj0RyEk6qiXUEe9efD9MjN19wh2yNVaXxslfY+iLPkk
         eDEBZcK1kBflDxIXrWGCgMBeUrepxfoAOQdUmRislwP1ZMbJJVra9L2sNKTXRfYRaQ0T
         avf08eUysn80NL7mvJKsU62bhxjSFV4G9vBr64//JmWcjfEi/iwXQdboKeFsFiXGB+tC
         gs8dBAJ31EF00M1Pj1iPFHprd3Bvm/iCWVIyByqx3V0iaQMQQu6hndBg0Eu3UXbWFw9w
         /NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698866; x=1774303666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9o2SUwvNFY/+s6bOX+uLRqhp8nbm4c3A307w/r1BnI=;
        b=G1LOoAqoNxYRxSJ1NmIDCla0wkw6QsRxZzQy1jRyq0JwF6JkjpeNBI97nGfIXNX9AZ
         RQenMeV9yKeR6KUW6vT0M5kACYFCDLb0/5/xU7zXHV7koxVxE0VOwrBc4NeP7LQgfSUz
         c4mIef0O7hVeSOn8FEIPEs+KNeInFzwirKdpJi7ZT86xh80MjwvXd+lQS9v3OPcZ/Fi5
         AN4HUxsqevYUXbVWZ3f3OWAnEiZeRdaedtH1VBLF+xP96cWsXOgdgob/Iai7LY6HSvV2
         fm3Ab1VP15L55DTSTV1OxWj4GT19VEHvraWZ1vWnwL+pyu36IbO7zmNTlZtn5yzrpcZ/
         HJ4w==
X-Gm-Message-State: AOJu0YwiZelTcwewR7FdR98dB1WaZaxthwoUArB5zuG+RBtwSP/kOFdZ
	t4+Sx5qsWkZNRIFupan0mZWrH7KlbA8sGqpchMPCAORpIRiJ2R0Gf9HpPjhCgCWGSDM=
X-Gm-Gg: ATEYQzyHgX7r+qyYgRjJ0ZByqKtduB72OU//Ig755gt3q6NVTS039MPxUbw7Q0gfegK
	UsjimOz128/M2H4HkvFY0Dfqi8leP88JlD7dB/kgQ1KJkK3nuKO17kI74Cjmh/FvXkT4BVPYZfq
	Kyjc9d7QvAj9bu33n3H3x+skAD6LE+VRzKTC2yQ5YSQn0G+z7890/qiFQzY26lcVyNp/wGOh3u/
	WHjEi8H3kIkd9qbzxeyFbIzLHGD3VEAaOTd6WMwuhxq7rXVic/WY+Wxh5qO3UTBMRRhOQSRymMs
	qwqD09TCzAZks5fGVuV8i/qLJvCKrxf8yknGIsJSFwEsTWaIgC7llzi8dZO/i0w77+edTxCwcZ5
	hAXumJZCigBcydkJKLVmAkeVibs/Y7Oodz+wpnfsRB9oNh7hAOawUbAiWDbe/mA2ew/rwCXPv3x
	xXtbk6fh2ysCChjaLlAcjLEd05nLo0HBUOhheSj1nDULSlC21pppeUyBlLQYKcpZvWXegTUQ44Y
	ElRNnoHUygmPPSTFp2pILY6/Pp8IqW4pKBU3J9r
X-Received: by 2002:a05:620a:170f:b0:8c6:bbfa:36af with SMTP id af79cd13be357-8cdb5b59a8fmr1938231285a.40.1773698866121;
        Mon, 16 Mar 2026 15:07:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm1303010685a.12.2026.03.16.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:07:45 -0700 (PDT)
Date: Mon, 16 Mar 2026 18:07:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
Message-ID: <abh/LUGAWUDx/E2t@nand.local>
References: <xmqqh5qka8so.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5qka8so.fsf@gitster.g>

On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:
> * tb/incremental-midx-part-3.2 (2026-02-24) 17 commits
>  - midx: enable reachability bitmaps during MIDX compaction
>  - midx: implement MIDX compaction
>  - t/helper/test-read-midx.c: plug memory leak when selecting layer
>  - midx-write.c: factor fanout layering from `compute_sorted_entries()`
>  - midx-write.c: enumerate `pack_int_id` values directly
>  - midx-write.c: extract `fill_pack_from_midx()`
>  - midx-write.c: introduce `midx_pack_perm()` helper
>  - midx: do not require packs to be sorted in lexicographic order
>  - midx-write.c: introduce `struct write_midx_opts`
>  - midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
>  - t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
>  - git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
>  - git-multi-pack-index(1): remove non-existent incompatibility
>  - builtin/multi-pack-index.c: make '--progress' a common option
>  - midx: introduce `midx_get_checksum_hex()`
>  - midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
>  - midx: mark `get_midx_checksum()` arguments as const
>
>  Further work on incremental repacking using MIDX/bitmap
>
>  Will merge to 'next'?
>  source: <cover.1771959555.git.me@ttaylorr.com>

I think that this one is ready to go. There was a relatively small
range-diff between v2 and v3 based on Peff's review of the earlier
round.

That review[1] said that:

    There were a couple minor issues brought up in review, like
    out-dated comments and the u32_add interface. So I think we might
    need a v3 with a few touch-ups, but that's it.

, so I think with the latest round we should be OK to start merging this
one down.


Thanks,
Taylor

[1]: https://lore.kernel.org/git/20260223140847.GB271392@coredump.intra.peff.net/
