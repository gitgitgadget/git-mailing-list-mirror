Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE75375F7C
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909888; cv=none; b=VZmlSqwYiDRp7xFLQZ2PWJJyZUf9H7D5p2CBpFiQGDFhFiqW0A8ruF7W0QfF1ixkybKY0YedQQatUTy5szgAtwR1eaBABCdzQ1+NaRPiuGSO5uvEmREjjt6Pqhakrg9hyKEM8xPC3GMwlaMNmZB50DJ3MgoWVLE3E24PjOYi0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909888; c=relaxed/simple;
	bh=sToKitTEpDdn0j303vGg5Q73CMwMJAENe4AZ7UvpfOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svp3ppciCoCp8wF5XYx0ksVHe1BGwpNQQHikzK2nY3CJzPPXr0j3EI3MnR4B+4H+8BMqh1jcHT+PaHTSxNaE2AKzVX0XlRrSypkmg3dJIMWqOx83NbRQ/vyGPsYMHChtTe0AZZyN82zdgrdSSAHID9K1MAXBIEr0bl4SHDOG2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FNgdd4fE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FNgdd4fE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c58e6eb2c8so121132757b3.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779909886; x=1780514686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cs/5jQyPHHlFhSNLlt3ieRw1q4qTrzG7vDLwa5WbS0=;
        b=FNgdd4fEAfgQjZOzVEcI4lZ+DJtna74oyE7ndvcqoMtnuXUJkgobTENHbLZ+n65tls
         i5Ib8hkkuKxx15HupO6PCw0yCgZMkr0LuDWc8U9P9vSGifHsykuyaJ4xtG8KiAyKtmzn
         CgQ56BX90joc2QpzDRwYXp+WIKaPyOUm0yA00t15jdz+GccOi6iV9mdZM5H2A4jyCeiP
         cXvQU1AQxtM/ar1oNKDrVrlRyZUJBT9pYx2Jox5w3BlSsxDVr71XwJZVm7Zwk1TgnLzG
         GBacx+cRfCHPI4tr0P7H4MNzG3hfouJGcNEX4HD746wvD5v/JvC+sHmtj4fp6SoL+XdZ
         014A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909886; x=1780514686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cs/5jQyPHHlFhSNLlt3ieRw1q4qTrzG7vDLwa5WbS0=;
        b=PLCnPCmTlSSx2Z96ojkqgHxUvDSsviUUrIhyYdL30GlGZAr0FBd4vv+pMILTUGU+59
         hZuMxdLNBWed39R0N7BY3qijqgalnY/QLAY32MTGuRAXNiS7rmjwx3WbWD2lWqrhaaq7
         tuIyJtU/q/gs9YQLWr01GABfzMRVKOUgfrrXm9DAeza3Hj7wNEaOp+UNANQ/diQL9L+J
         F9qW4AYk3AbqeIPzJpCnd5rx7X6tX2Hxl5eT+8B6NBjPJV0sBlKZcyicnfUtg3MGDBFV
         8f2FgBRdu0A7Dj88tn/H6Ie5NiFredBdAKqMijV1ZNVGJOpMCAtmqZtRUOeerAtm/Bsc
         ZZZg==
X-Gm-Message-State: AOJu0YxFSRoSi5YNoBavRaHNZtG7sFppI9SJ+JNda6t8wzvkcqAqLSEr
	zSiivlS1FTLzbzNl49OjZoDCwtQI0SgR/3kLgOWUQz3Tye10IMcW18Dh8jz5Gx+YUQg=
X-Gm-Gg: Acq92OFBe1P1sya6hXl9/DJnlRGcIn2YlIdkt1/yYlSCKk+qsGTtMiuA93WI1MLtm3N
	Q10i25H3HHfbn+CTPHmSTjqe7RaxtBtcRPQJQfef2gN+mt/2xFaFet4O7PRVSxkN9pWxrgon4SO
	5bLH4CLyjQgBLVpuW1oov2GKtwgF0udesMJj5VjuARBKMwp27S2UWsRMjeyiA6huH/D7JQ94ec6
	f/J08CzgPkITOJtxBe359SgZmPboJJtVNaV5+KrTrMO4xOo5fP0kTv78z9H49fim1crFF2s5bUt
	F//dd0O7JZtt+tlIno8QVzC2iR+RUrVaCvzXYXHCslXcExbzV8QnRW33AEOBT/IJ8FbGJiQ/Qyb
	w4/XgH1mjTwJbcibJwxOcFDJYERAwjoIPHOymh+8T4olmvfrZygwQLMge5OF7QNS+WF7beB/RbG
	aT382Nv1Og4Q+iuZ48uhsl8aeL7Yie8G9gRqBStk+YRQUXPcuSDgtJUbsoDcI1+fYWfr/lHi7B3
	H02g0HmpJOw860eC0rj1RtXa+LPDki7AeFZop/WY2MeZ7IJkLCcbzZX1xuIyPIoFQZfh/SjIivP
	7Wio62Ehw+g91zae5eVobbdnCyw=
X-Received: by 2002:a05:690c:7a1:b0:7bd:7c16:1720 with SMTP id 00721157ae682-7d331bf6b25mr273372507b3.0.1779909885607;
        Wed, 27 May 2026 12:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d176a9sm79804557b3.16.2026.05.27.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:24:45 -0700 (PDT)
Date: Wed, 27 May 2026 15:24:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 8/8] pack-bitmap: build pseudo-merge bitmaps after
 regular bitmaps
Message-ID: <ahdE+Je5YK9JoE7B@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <30ce254312cfee2a2a82f08246c3a2546ae32578.1779207127.git.me@ttaylorr.com>
 <20260527102534.GH981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527102534.GH981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 06:25:34AM -0400, Jeff King wrote:
> > It struggles, however, to efficiently generate pseudo-merge bitmaps.
> > Unlike ordinary commits for which the above algorithm is designed,
> > pseudo-merges don't represent any "real" commit in history, just a
> > grouping of non-bitmapped reference tips. In that sense, their first
> > parent is just a part of a larger set, and treating them like ordinary
> > selected commits imposes a significant slow-down when generating bitmaps
> > with pseudo-merges enabled.
>
> This is a great explanation of the problem, and especially this:
>
> > In other words, we pay a nearly ~5 minute penalty to generate
> > pseudo-merge bitmaps, but only save ~50 seconds during traversal.
>
> makes it clear that we're doing something sub-optimal. And it points us
> in the right direction, since that traversal should be able to generate
> the pseudo-merge bitmap we need in the first place! So that should be
> our goal to work towards.
>
> > Instead, build the regular selected commit bitmaps first, considering
> > only non-pseudo-merge commits in `bitmap_builder_init()`. Once those
> > bitmaps have been stored, build each pseudo-merge bitmap separately and
> > attach its parent and object bitmaps to the corresponding pseudo-merge
> > entry before writing the extension.
>
> And then this solution follows naturally from the earlier explanations.
> Good.

Thanks. For as clear as this sounds now, finding this approach took me
longer than I'd like to admit. I'm satisfied, however, with the result.

> In some ways this goes back to the pre-v2.31 way of generating bitmaps,
> which is to just traverse for each bitmap independently. But as you
> note, the whole idea of pseudo-merge bitmaps is that they aren't
> overlapping in any meaningful way. So doing one fill-in traversal per
> pseudo-merge makes sense, and hopefully we hit enough real bitmaps that
> it's not too costly.

Exactly!

> > As a result, the overhead cost for generating pseudo-merges in the above
> > configuration is much smaller:
> >
> >     +------------------+-----------------+---------------+-------------------+
> >     |                  | no pseudo-merge | pseudo-merges | Delta             |
> >     |                  |                 | (HEAD)        |                   |
> >     +------------------+-----------------+---------------+-------------------+
> >     | elapsed          |   294.1 s       |   328.4 s     |  +34.3 s (+11.7%) |
> >     | cycles           | 1,365.5 B       | 1,529.3 B     | +163.7 B (+12.0%) |
> >     | instructions     | 1,389.8 B       | 1,552.8 B     | +163.0 B (+11.7%) |
> >     | CPI              |     0.983       |     0.985     |  +0.002   (+0.2%) |
> >     +------------------+-----------------+---------------+-------------------+
>
> Nice. The time savings are going to depend on how many pseudo-merges we
> generate, I think. And I'd guess that the numbers above come from making
> one big pseudo-merge bitmap, per the config you showed earlier. But you
> probably only want a handful of them in any repo, so hopefully it
> doesn't scale _too_ badly.

That's right, though see below for more thoughts on scaling...

> > Recall that at the start of this series, generating reachability bitmaps
> > took 612.5 seconds *without* pseudo-merges. With this commit, it is
> > still ~46.38% *faster* to generate reachability bitmaps *with*
> > pseudo-merges than it was to generate bitmaps wihtout them at the
> > beginning of this series.
>
> Sure, though 612.5 seconds is all in the distant past. We only care
> about 294.1 seconds now. ;)

Heh ;-). Naturally, I agree here, but wanted to include it for context.
I wanted to point out that the accumulated changes in this series make
it cheaper to generate bitmaps with pseudo-merges now than it was to
generate bitmaps without them before.

> More seriously, I do think the interesting question here is how the time
> scales for various pseudo-merge configurations. I don't know if we have
> any real operational experience with them yet. The original idea is that
> you might slice up the ref space into a few chunks. I'd guess that the
> old code performed badly-ish overall, but the time did not grow all that
> much as you increased the number of chunks. But with the new code, I
> suspect that the cost grows more linearly with number of chunks. That's
> just a guess, though.

I'm not aware of any large-scale deployments of pseudo-merge bitmaps.
This series is written (in part) of the hopes of making one ;-). I think
your intuition on the old code matches my own.

Below are some numbers that give you a sense of how the runtime scales
with the number of pseudo-merges. I'm relying exclusively on "stable"
pseudo-merges here since they have more predictable bucketing behavior,
though note that there isn't an exact way to dial in the number of these
so-called "stable" pseudo-merge groups. We can only control their *size*
(in terms of number of parents), so I ran the harness which produced the
above code with powers of 10 between [10^3, 10^6].

Results are as follows:

    +------------+-------+----------+
    | stableSize | count | time (s) |
    +------------+-------+----------+
    |    1000000 |     1 |   34.963 |
    |     100000 |     3 |   36.954 |
    |      10000 |    26 |  221.963 |
    |       1000 |   252 | 2779.373 |
    +------------+-------+----------+

Which scales roughly like O(x^1.165) (the best fit function I could find
was t(n) = 25.18 + 4.386 * n^1.165, where 'n' is the number of
pseudo-merges, and t(n) is the time it took to generate them).

So it does grow faster than linearly, but it's not too bad. The jump
from 26 to 252 pseudo-merges is pretty significant, though, but having
that many pseudo-merges is probably not something that we would want to
do in practice.

> The other thing we hope for with pseudo-merges is that the chunks are
> selected such that most of the chunks don't change (because they are
> composed of old, stable refs). So in subsequent bitmap generations, we
> can either reuse them either verbatim or as a starting point (if there
> were only additions). But all of that is going to be heuristic and
> depend on your config, the changes the repo sees over time, and so on.
>
> So I don't know if we'd really have good numbers on that.

We don't, and it is somewhat of a pain to simulate. I think the proof
will be in the pudding, so to speak.

> > Now that we have decoupled how we generate pseudo-merges from their
> > representation, the following commits will improve the API around
> > specifying pseudo-merge groupings during bitmap generation.
>
> I think we're at patch 8/8 here. I guess you have more to come
> eventually, but for now this part is just misleading. ;)

Yeah, I cleaved this off of a larger series to make the pseudo-merge API
a little easier to reason about and less clunky to use. But I ended up
hoarding some of those patches, and apparently forgot to adjust the
message here. Thanks for spotting.

Thanks,
Taylor
