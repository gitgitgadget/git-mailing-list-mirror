Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A903F39CB
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270676; cv=none; b=Vv7fgHLEPpH9fvVAOOOlHAF8bk6r4SXIseMffvrppYebstpTPzkajNj0o7GXh6638dm/AnZHQwa45Q44HsTXXhcxOCfeHN2+HPfLCCzycRmIK8HDX0BTgFFxLEb8pYn7OKfasrxAbD6Tb49G7CNm7E+wweisHoFIjk8imNFQHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270676; c=relaxed/simple;
	bh=2/l+ZM3U6sEBQiaUgXx+zqteytvZnp4X8pAKewgowb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0gHnvRFmT6eCW9MHLmLBvI4xNbHPwWCc8ziimRY7VuaPLiJHEbJXIK216W3qAUAUjajRqOROGB51Y3Vp0UWNAe+SffeJm6Sk1PjXqRLSHhgA40psfiAjRTte1w5MwEXmDsgVTKT8EyxXWU8QFBqcKm5kQtNoG3jbsUGMSydnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQjcY1gI; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQjcY1gI"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517760dc3c2so6237521cf.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270674; x=1781875474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spgboUNCf/EBPziSAHl7yJzYeBRLNqhvyASE+43+kNI=;
        b=BQjcY1gIoIGdVhWDB7YWaQQW101xl9O140YnINDM4/I8SEU9zRck6iFPRtCvwPo/vz
         dmn2DXL0zwvTbpGi7VEl7diNtO0RGXaJo1yvssmkxomhHXzYv0NOQd2mndgc07xzOk0T
         Z7J7sWb95lenjCpD4+aRsnk155G0OXBHm0+wdDQ3mJcucnar386p4AWhDV48CzPTqk+r
         hSKDE2plgUCJVPsCwjUZT8QO+tpgUsu3h4wgSMh23jwHu71zyG2druf42tFZm4sYeDBF
         RCR+YHXcgyQ5KopkvbMe2tzOqaIjfQbHfsRAzUpWbgWjC3RorErUawer9m2DQDJ6g9yz
         Gr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270674; x=1781875474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spgboUNCf/EBPziSAHl7yJzYeBRLNqhvyASE+43+kNI=;
        b=KgjNX43AoZNvYIVoFFOITI0IC58vKTwIla8QBFvd0n6OZO+L/CYOs1XhhsaMpfpeFL
         K1e0ZIY87FPqGgtzTHSq5CxcA8k9kcckWpMsWnCtWLzeUpW/ecwIDwlb4+jI5RgOE8I9
         qlfu6vdZHou1jhF+TjEFlCfREgg3mTC1IgwzTo38lLRWssYI/cEDUVwGXtLn1f2vhOrq
         DF4v+xPfl3oCEqef0uBb8TF8ll0YnYi9WhpW9wsu2aBN7zwhy3XVPK75IhHjCN5Lrv0w
         E7tascKfNbdzOd2BXZ9NNYvWxE6L2iRwoP0BrBHMZcwHFU1/WvuMS+M2T8ZxWe9wJGaP
         B8XA==
X-Forwarded-Encrypted: i=1; AFNElJ+4seRG7Lh5R4HR8fxbWQT3lvQds2CVssga20C5vPHntVcJteH4JALlkaNdxQFqkC3OgNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnQVVLCrMaEXSpC2jmMMRmjxt65zydPIf0ttPg3y/4tq4ofOO
	bBNLOfrrLUMTXfbBnx4rwyceNLMMqg0KcyfObTlG/lF2l81EDtB4gxIs
X-Gm-Gg: Acq92OHlfrD55hdX7+xjKQQ3TlnXca8KuKeph/F9oZh/HYRxDod9H0r/tSZMbA4Wcal
	ZahVX0o/MCaDOvJuSYSu4fJl79hw6vvonw5IvzB67UJeVFL+1l4QEFrakkRM2v0wGkz6kk3H3NE
	vzeaTrPzOtL3tnwjHUrLQwAFoRhZmzQ++mu62KSEJufTKOSpFwDzT+V/Gn7jpSxTd3ssbcA5mg1
	Bkh+emvBpw/I2BiXcXZcymj+E2vAIYOgQJWNWYVRS8jNzh3Is7U7mNfuxxF+jlOnzJVcsvqKlqF
	fFnbuUWHnNrbTnkt/8tcRClB8np/cPdlZPGvenQXjKA+WPbDjPW5rwBj+5MfrqAYxPB9sEk5Hyi
	J9A+sWOcPKuIUfT835FAzPvK8AbN5T9O3dkshKFDIMIeCGVD8XltdZwop8LVHhXPCoZpiwk9PdA
	2qtT0JuHiDZZw+GsGNnaxKxZL6eQYG2CM3jb/yCLwDHdIBR9cUkVP4AiaDCvgdcDABNeEP
X-Received: by 2002:ac8:5d13:0:b0:517:c6d8:780 with SMTP id d75a77b69052e-517fe6314bdmr37734611cf.56.1781270674103;
        Fri, 12 Jun 2026 06:24:34 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm20877101cf.25.2026.06.12.06.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:24:33 -0700 (PDT)
Message-ID: <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>
Date: Fri, 12 Jun 2026 09:24:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/2026 6:21 PM, Taylor Blau wrote:
> When 'pack-objects' is invoked with '--path-walk', it prevents us from
> using reachability bitmaps.

My earlier response focused on the _use_ of bitmaps when creating a
packfile, but your patch also enables _writing_ bitmaps with the
--path-walk option, which is significant and potentially more
interesting from my perspective: we have evidence that --path-walk
can produce significantly smaller packfiles than the standard
algorithm, and once those packfiles are created we can benefit from
that size in later packfile creation steps by reusing those deltas.

In this sense, I think the _writing_ is more important during a
repack scenario. The fetch/clone scenarios can benefit directly even
without integrating --path-walk with --use-bitmap-indexes.

>  * A path-walk repack that writes bitmaps does not give the bitmap
>    selector any commits, because path-walk reveals commits through
>    `add_objects_by_path()` rather than through `show_commit()`, where
>    `index_commit_for_bitmap()` is normally called.

...

>  * On the writing side: teach the path-walk object callback to call
>    `index_commit_for_bitmap()` for commits that it adds to the pack.
>    That gives the bitmap selector the commit candidates it would have
>    seen from the regular traversal.

My earlier reply to this patch was focused on the performance results
when using the "reading bitmaps" case, and I expressed suspicion about
the "exact" sizes of the packfiles.

Even more important here is that we have demonstrated examples of repos
that change their packfile size when using the --path-walk method. We
should demonstrate that the size continues to shrink with --path-walk
even when producing a matching .bitmap file with --write-bitmap-index.

The other thing that I notice here is that the bitmaps will need to
compute their reachable object set independently from the path-walk
algorithm. But I suppose that already happens separately from the
revision-walk approach that normally produces the packfile contents.

Note: A lot of my thoughts around asking for more evidence here is
that this patch seems suspiciously simple for integrating two
complicated features. The test suite (especially with
GIT_TEST_PACK_PATH_WALK=1) helps to guarantee that the result is
_correct_, but with performance features like this it's not enough to
"just" be correct. I want to see that we're having the intended
results.

From my perspective, the point of integrating these two things are:

1. Reachability bitmaps make it much faster to discover the reachable
   set and reuse bits of existing packfiles. (Your performance table
   demonstrates this is true.)

2. The --path-walk option can shrink packfile sizes by grouping
   trees and blobs by path before those paths collide in the name-hash
   sort. (I haven't seen evidence that this is happening.)

With evidence of (1) and not (2), it's not clear from the data that
these features are integrating completely. Without looking at the
code, those numbers would be the same if we had instead swapped the
preference of "the --path-walk option disables bitmaps" to "bitmaps
disable --path-walk".

Finally, I'll just note that I don't expect the _bitmaps_ to change
size dramatically. The --path-walk option does change the order of
the objects for its first pass of delta compression, but then uses
the (name-hash, size) sort to finalize the object ordering, so the
final object ordering _should_ be the same (unless I'm mistaken, in
which case the bitmaps could change size due to bitmap compression
concerns).

Thanks,
-Stolee


