Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7B2566F7
	for <git@vger.kernel.org>; Sun, 17 May 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031580; cv=pass; b=i4nEOD4arPEGr1413iSQV+H8Q5NmbsNTpkAL8TuQIeBsjmxlwKrBkiGvIvCmfxWydBzNO69VlpUdb5WT+EFHR2WW027gscFF3QMV0PLNNJDiS+/HqAP8iS3FX7Izx/Uv6DGO/Rs4mYb+QCJkIkgEqYjD3XvtGU3ZqGkWXB/9ceo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031580; c=relaxed/simple;
	bh=sL11IJdxfoQDjHeMFxcC7leBjfYmBu7FLq1ve9JY0YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYao/4wdyLX90aK9WsaRN/CthaJX+4SnHmE6CgEa7ey/7I2YkdCpzdw+Wz5z1y20wqWYITCZPpwlARmDzJ5/JYGUSMG/j5gqP2vSXy/WavUYIkVd/XmDIAuWWevzFdlD46vaC3sz6k7hm7uJVQOhsfq9RXDvBtIpvjo1eTXxslY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Nde0PUrg; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Nde0PUrg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7ca947f9b00so7778867b3.0
        for <git@vger.kernel.org>; Sun, 17 May 2026 08:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779031578; cv=none;
        d=google.com; s=arc-20240605;
        b=RXhYpb4gdTjUIasuvIsqCF6ru7EQ/RiC7NeMHJn6Yjx07Be45sqD3LiE/8TZKF9QMq
         YOw2iUsEaQI+YY8H61ETldY+nGa3tFSEIxBDH45wuDhn5zC/vf/+lm2wl0SPFmpcmyKa
         K//EmXBtLdKJof6Ohi6fXudKNeR/uXN4CLlDsBWYBXwC6Vf2WsiFSpdepb4PbL6AxYJV
         JM6jfU25AxPhPyqOCHFeBBbdUPtVq54O+3RO/5I8LiqzLMvzfxuJybk3UFGaIJgGN4UY
         6UlSp89egWXHcDxvvK6ca2HDwpptdRT9TDlajNMV3UvP7SH/t5TMQJG5DuANjtCZncCU
         Uk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wrifQKl3jXoE8ce8/+zRQEFQ5RmpgU4I8TP82/QIEus=;
        fh=NpssAJle9+Di8b5ur+a/A9M1IwdNj+OtSW6+r5XuIB4=;
        b=FX0Aievjqnus7ezy5xQrBT0r5NxR8T5blIy6hhRbNZD8WkVsdPulLHrSBgrFJPWCj/
         gvZarCv6uUIntBX3sH82hkoyErnWeIZUBtSZqGyK9zG9xTm9lrrpyUxq3OtovKwyFhGz
         trapx2SN9q0QaMLiTo3LvI5n93NYpefVoohkNkk/sYfu5SFbH4XlE+nu07G2LzKb6R5/
         AAw7jz3db1YxjxRNoVT+hEvb2vACllcDeVZIDO09tzPOFHz7vmWJhRdgBWad4UGDTgd2
         q/jHXbOBNVk1F4c64lvwCmMJSJpch7YKVm7L8P0riCTYTDuS8mYqNVvnWv24GffjEFo3
         gT6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779031578; x=1779636378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrifQKl3jXoE8ce8/+zRQEFQ5RmpgU4I8TP82/QIEus=;
        b=Nde0PUrgt5RddaK9j9RFN7j84WV/ipAOYiZm/R/xGk8d0Boa6ku2zTiI5fRZpJiTEO
         We4ivvHvxIJQEZHM5iYyDdjGKCcDz3+7i/kzXxj7vnSZ5hVTXbMHQynU73kuhDHi2i3g
         HU+c/F4TneuiKz2AAzc4FngK5dUtTizP/6240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779031578; x=1779636378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrifQKl3jXoE8ce8/+zRQEFQ5RmpgU4I8TP82/QIEus=;
        b=Cl0lmzjVA2t23dmRuuXtJ+ihWVRicDD5juGG3giEd3GD6dIplwXdwhDBEQbXvSgtZM
         KlvWfeQ55IAJKATWMWAN8a79c5wtrdRi6FrkPIu0r5QltZPX+quBSmxn9CFwdi7h+LjR
         MIAIldXI+PkbUtxvsU3fv1Qc9+zDk8yLlb9VH6rxpQVXFY+d1ljygw8ANz6ZforrhcI2
         q9cgWf6w98J89dQgicWe+HHy9qUI7OCBFVYdchkKdwPJQtCcQAT54SAFYXi+lVOcAMNO
         AOqJymHiy5syw4WGTjyvT50HyVx3YzfHJBntfQPaVNR0hoVmjXU48biE3fV3usoitna6
         +fAA==
X-Forwarded-Encrypted: i=1; AFNElJ/1IeygJii1J1pf6AlTsO+Xl0UqvgkhwyRwhFR7k0Rg46v8fj2TnECfoBhzOvcN5U2TIKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LQsxR92+16AngKt8aQCgxenr7YnIPCcqunm7MygzqSBfLAfj
	vKus+B76mcIRStrTh2L49TQPvWhj6mQSKAm3G7p943bcjhxp5V7lXhREMpH02tAjWxDIqMl4CMs
	8etZF9JDQqdxYidA7Phjq5vgVyDvEX1L6fQxlK9ZfiQ==
X-Gm-Gg: Acq92OFY/FN/FNzQGQd0YQOojeeA2u6uOklmMQwTUkBPxgQqzr8CHw4sgP9U5FqVhY9
	8Io6r28DzPHViDJ0nUPEOeJ+kRYJWFwzLNnttyGDpZdWmKd5FOZOPjYr2ZAVkg4NAqthy2X1IxL
	soC3ZlhVDDAcZvCdG/IrXDilgBwzi6DTuTSMR6nYh1h9CK7lGOh5U0KhbqyPZD+qwISeACDgJN/
	Kdy/3sooXsL1twmiXVyBxiMHtCeJ480lSynAmLXpXeGtUFhWRAE2zUVr7djRCOzpMp7B7g2ZsNi
	S1gB1vy5MyWfAr1YRmk=
X-Received: by 2002:a05:690c:102:b0:7bd:8d1e:39fb with SMTP id
 00721157ae682-7c9594b4f2dmr122307637b3.7.1779031577636; Sun, 17 May 2026
 08:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <20260515041641.GA81292@coredump.intra.peff.net> <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
 <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
In-Reply-To: <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 17 May 2026 17:26:06 +0200
X-Gm-Features: AVHnY4LUlL7j0JIwfNP8GsO9DPLiEDLnXeOZpslw2iED62K6BXmPQ0EvfIyhDww
Message-ID: <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Another note - I think I managed to apply the same change to
get_revision_1 too - speeding up a monorepo "git rev-list HEAD" by
3.3x so it seems like a reasonable thing to do.
This simplifies process_parents and also makes
commit_list_insert_by_date dead code.

The only caveat is that get_revision_1 starts to get messier and the
rev_info struct needs both a prio_queue and a linked list of commits -
and then flushing everything
from the list into the prio_queue when executing get_revision_1.

I don't want to pollute this patch with that change - should I start a
separate thread for it or just revisit this later?
(Perhaps I have too many optimization patches in flux already)

- Kristofer

On Fri, 15 May 2026 at 15:10, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/15/2026 3:47 AM, Kristofer Karlsson wrote:
>
> > Unfortunately git.git's mostly-linear history doesn't
> > trigger the quadratic behavior (the queue stays narrow). Even with
> > 5,584 commits in the symmetric diff, `--left-right --count` finishes
> > in ~0.4s on git.git for both baseline and patched. A 50-pair
> > interleaved run shows no statistically significant difference:
> >
> >     git rev-list --left-right --count v2.47.1...v2.54.0 (git.git, 5,584 commits)
> >     50 interleaved paired runs:
> >
> >     baseline: mean 393ms, stdev 13ms, median 392ms
> >     patched:  mean 396ms, stdev 14ms, median 393ms
> >     paired t-test: +2.9ms, t=1.16, p>0.05 (not significant)
>
> Thanks for sharing these details! Consider my curiosity sated.
> > The existing t/perf tests don't cover this path. p0001 doesn't
> > use --left-right and p6010 is merge-base specific. I could add a
> > perf test, though it would need a merge-heavy test repo to show the
> > difference. Would a synthetic one (like p6010 does) be useful?
>
> I'm usually interested in encoding ways to repeatedly exercise
> these performance gains and preventing regression in the future.
> However, you've demonstrated that not all repositories have a
> data shape that reveals the performance problem.
>
> If you happen to find a publicly-available repository that shows
> this improvement, then documenting the performance benefits for
> that repo would be sufficient. I'm familiar with performance
> work that doesn't reveal its most important gains until working
> with private repositories at the proper scale, so don't sweat
> not having a public example.
>
> I don't think it's worth constructing a synthetic repo to
> demonstrate this issue. I was hoping that it would be low-
> hanging fruit to cover this in the perf test suite, but that
> does not seem to be the case.
>
> Thanks,
> -Stolee
>
>
