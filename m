Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65A3A169E
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405908; cv=pass; b=ISLwFgceW03YpIF91oxXVEwCPyKkecwlSW3UUDnZMiwFG0GWo5Sq/DzfeDduEtAh6uN94zCQIFgTD0GWJ/HAYpKiE67o5sNTNGYX5J/7UXs0m+S2z//+ZX4XXYs64L9HKPmAnUhkb79WdMd0T9Zikis2kmnVWJmTX0u8GmlgAUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405908; c=relaxed/simple;
	bh=U9DYjw2J8stYvJSv1WpEU9zaufiTsrSLYbgdBF3AnPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEpwykOoA3oN92j0TOEANmABPul+jw29OPKLslRPZd/MRdsW5v1pggqRu7ZlTJZjRMT44PuQCtxhr2QpSXFr140sTJN51iSY/zKWGPPjCMJrzF6VIULGWzPRJPW0IVqOeLqHWtRDS/R13Yc1oPyl6yEJZ8Fwcyb80Cq9sdIEdys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfHEae/l; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfHEae/l"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80e4455b9a3so56157617b3.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 23:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783405906; cv=none;
        d=google.com; s=arc-20260327;
        b=ePfNSIrWBfhcnDq2BaxWkTXl7JOYokWixAdwKjNAonLgz7ukq3oP2y18yhoHaYbzVK
         VjXH8pXnP6kjIHNAmimKBpZOY0AE++rfk9Uml/PM4Sysc/Ip1iUiXDDBhHUUKWSe3xHr
         0RluyuGHPatYfb/lQ1Xuu5+2H4ws34DGE2STua5lzisW6ZmKdcBPxPKSGu6QIsGYI8TX
         JwP6KcZSEI7qIihUSgd4Xa7WmRxri3jqMbjm4R2Gg87xIRJtIvP68AxyUtbE18aXeyWw
         /OG9d87imWQrP3pQq61hGbW8FDfAUZzxdH0Wq7m0DoozwgtZviHVpHtNZkB2zVbGQkO5
         wPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U9DYjw2J8stYvJSv1WpEU9zaufiTsrSLYbgdBF3AnPs=;
        fh=pwfwrN+286pKmP5Ry5+F7A1/0yoMMMPlN6UtDbnPK2k=;
        b=OfJUaIzY/TOCYHCqlIQuVlrqubBLs3or2qH31MtZN7gNrxGsl1ILnKtliJH1xwak7I
         Y9MhqzwKOBlVK1b158+IPqYfIV9ujKbi94F+rS+Weg/OKbHVbQO8zTNrBmwxaMfSFDhh
         5+V1cVc+uAQbrMCc3DoGLPqxC7f+ZHPtFhbuX1x4AvU2OcvPrTVijzzHe8WPlkG2g1Nc
         dQVIoUnf1IkjSgF4V4eacMv/4Hm795FeXZQlPhjF8dCD05MIbkd8Dbqwap8qpJ3nssEJ
         qyMpVqag2Ouq52HCYz3X2gHNaVrSegc9gxXo+iB9yRn+lqcTYhHhUZFUYdYdqCoGgVBi
         eM/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783405906; x=1784010706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U9DYjw2J8stYvJSv1WpEU9zaufiTsrSLYbgdBF3AnPs=;
        b=YfHEae/lyCOZlpZsStD2+IcHVZYWs+750+rEjPtbvueO1cGVMmEfPPSBTw1lqOEHSR
         352dECYew7QgdyXrSCORcmIK4Cr3BMzXsQZngl2wbNEGYtAUdCmXmkQr92xC6ksKM6Yk
         SGQFOhBlCsio+aVc67CjMcRPLY6nvuzuDXMmi19s6y6mT73hIGgGf5IvoXQSQjKh+Lhp
         0Bzjlp1eCpN0cYw4ccrf+omW+MGSlJv65PcM6mJT0rfptk05dksVULrJs3rB4HMxziVo
         MjX9svGTjWVpLWc/1b8YjCyzgmTAApfsKbpM6tRASZM0SnquLGkGUMrJk9xviZ/oxFZQ
         035w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783405906; x=1784010706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9DYjw2J8stYvJSv1WpEU9zaufiTsrSLYbgdBF3AnPs=;
        b=ZvOuq4tHNVRXrFXgrZovfuAB9ljzexKs10JtRqUqCQYRUFS70i4uvAJJE9+st8Ircb
         5SltW/prGgjauAef/cVEFmPakewVZ7ntjwoevQjQfraPj2OCRxqf9KWPgpfNxE9YoGhh
         qZrGFmiUMaPjA5Xmbyn8KtGD95HjofrDqtaKfS1yUFHAkGm4bIjdANTyZfbAZ0PRO2kh
         VZGrPVz0mMv5dIlhVcfoAoEiMo0mtv9Wm46dcjfLsMm009plCkPnqBpOAUKJvtpjm4Ix
         p6z7PQh9j8f2sre+y2EqWXkflfbsPKaIWEfe0SRyGHeQZa0uX8dJ5Jam+sTue3EBMdEs
         SoyA==
X-Forwarded-Encrypted: i=1; AHgh+RrPv92cwGwteZBn2ShBcHreEjyPZaio/s6RyGXZK3Euo8gPxoqsCNTMfkq8BCoQkKuvFIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVgvAx0SKfH7QwPnhz3okHfR1sdD1xwBWQNDMeHE2xWemwqJw
	cbUWBoUQ0geNDweJJHB86JnnNxG0EfbqlfbCUVQp9V4gtsAKDLbGs8oeBUg68QZ4DGQAvyuzyqH
	YKpsh0ByKD5/RD/mFWDq3NF9B8FXNdt0=
X-Gm-Gg: AfdE7cmaEGDbZxU5hmBnpDojfmtr3U43Yhmk5eo9jsCo9/yBlcn5DrGb5eilQUphx/j
	3OilT1T9OKZIk3GUr/WxNN4gzlrnzB0Re+WHW9NTa/kDi54Gauu8Z9XEDwCCEve96MJef6YvqhQ
	wdbr8KkxBscBur0eO2SkQIcyUbuLqlQLBbWf+lo0SpPlofAjfA1nA8gvJ1AEL5deOsswIaXbty0
	H3tqxjoDMazosza/9wN9ANx6gY1Tq/zQuMp6vuL52iZw9pGOY7X18f9AGmyPw91L0zriFRAthTG
	uygPvMyDpX4HfOyPpjtfniKHGiR2t7HSyEWqHvuyVWQQZPnLR9jM+Dl1x8IWhmv/rTSy36oPcS3
	f2Cqvgo7/Eog00SzgIoM1mMEBCAYkpC1dLUs2BiDBpLV5TmSGIVWLw2OY1iJ0Xe7da7hjLqs=
X-Received: by 2002:a05:690c:670c:b0:80f:8faa:b8e0 with SMTP id
 00721157ae682-81be0f35b4cmr30522067b3.8.1783405906074; Mon, 06 Jul 2026
 23:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
 <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com>
 <CAL71e4O1tLE_VSDeeZQ_p=8kAXvk9JQ9EqdPaYMZnNs+Xj+RYA@mail.gmail.com> <CA+J6zkSrcJVcKmm0duTQwWcLxrsZ6eZkVgL=hQUQHegKGsWsxg@mail.gmail.com>
In-Reply-To: <CA+J6zkSrcJVcKmm0duTQwWcLxrsZ6eZkVgL=hQUQHegKGsWsxg@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 7 Jul 2026 08:31:35 +0200
X-Gm-Features: AVVi8CcuVpbzBAtOJHXmVGHtNYb3_aZiuGjq9raDfb9yC5wH8v-_S5XG2_ObiSk
Message-ID: <CAN5EUNQoLtJ9cGwe8RNJTTdngM=qoak2=5F+yc7TH94TmQn7uw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 6 jul 2026 a las 17:33, Chandra Pratap
(<chandrapratap3519@gmail.com>) escribi=C3=B3:
>
> On Mon, 6 Jul 2026 at 19:15, Kristofer Karlsson <krka@spotify.com> wrote:
> >
> > The hardcoded size-2 lookahead buffer was my suggestion,
> > so I am responding inline with my thoughts although Pablo is
> > the right person for making further changes (if any).
> >
> > On Mon, 6 Jul 2026, Chandra Pratap <chandrapratap3519@gmail.com> wrote:
> > > Do we need to NULL out the retrieved buffer entries? If so, it is
> > > worthwhile asserting that the entire buffer is NULLed out in the
> > > !graph->lookahead_nr check above.
> >
> > You're right, it's not technically needed, and there are many places
> > in the repo where stale data remains in buffers, and it would be possib=
le
> > to do that here too. I don't think it matters much in practice though,
> > and NULLing them out would perhaps prevent some accidental reuse on bug=
s
> > (NULL would crash instead).

It is not really needed to NULL because every time we access it (pop
or the graph_is_interesting()) we are limited by graph->lookahead_nr,
however I thought that it is better to have it NULL.

Imagine that somehow the lookahead_nr is 1 when it should be 0, having
NULL would segfault or if it doesn't at least we are sure that
graph_is_interesting() won't re-process as interesting a commit left
as stale on the buffer. Anyway, this is just speculation. I think it's
better to leave it like this.

> >
> > As for asserting: rather than checking that empty slots are NULL
> > (which just verifies our own cleanup), it might be more useful to
> > assert that a slot is non-NULL when lookahead_nr says it should be
> > populated, i.e. assert on read rather than on empty. But even that
> > may be overkill for a 2-element internal buffer.
>
> True. But since we're already going through the pains of initializing the
> buffer and NULLing it upon a pop, I'd much rather go the extra length
> and verify what we're trying to do, shouldn't be that complicated anyway.
>
> Whether that means checking for NULL here, on a push, or on a read
> is something I don't feel strongly about, either is fine with me.

About asserting, I think that the best is, because we are popping, to
check the first element only just in case we are in the imaginary
scenario that lookahead_nr is lying, but because we pop, we don't
really care about what's on the second entry.

>
> > > Not the best engineering practice, but I guess it is fine to constrai=
n
> > > the logic to _only_ a 2-entry buffer since that's what we'll always
> > > deal with anyway.
> >
> > I did consider making it a proper ring buffer, but it felt like
> > overkill (and I could not find any other existing ring buffer to
> > piggy-back on in the repo), and the lookahead depth is
> > structurally tied to the algorithm - we only ever need two more
> > elements.
> >
> > It also helps that this is entirely internal to graph.c. If the
> > buffer were part of a broader API, a less hardcoded approach
> > would be more appropriate indeed.
>
> Agreed.
>
> > > We should use ARRAY_SIZE(graph->lookahead) instead of hardcoding
> > > the value 2.
> >
> > Agreed, that is a nice improvement. What do you think Pablo?

Yes, I'll do that on reroll.

> >
> > Thanks,
> > Kristofer

Not related with this feedback but worth saying:

re-reading what's done on revision.c there is this if line:
> if (!revs->max_count_stage && !revs->reverse_output_stage)

Graph is not compatible with --reverse, so the right-side will always be tr=
ue.
About --max-count, I made a few tests and the lookahead behaves the
same regardless of the number of commits to be shown (even if capped).

So this whole if block can be dropped and we can try to populate the
lookahead buffer always.

Thanks both for the feedback and review,
Pablo.
