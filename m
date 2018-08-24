Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA641F404
	for <e@80x24.org>; Fri, 24 Aug 2018 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeHXWg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 18:36:56 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33776 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeHXWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 18:36:56 -0400
Received: by mail-io0-f177.google.com with SMTP id r196-v6so7972049iod.0
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rg2i+W3o8JUclnxMgPyLQ0SAUwAjLroj6rogmvixwkw=;
        b=pMn2kLPtkaW/3iH4r9Y61V+8Funzks04QYFCRCRYFGZQJabBWN5RMRHTSm2u25djs4
         R5MfOk1SiGOwn2BOpA+VTh/Ve9rzXgXd65pnOpCGYEdYuCxrBgxqWlbJPxdjNX8bHfN0
         mQsq/TzO3zEITjkXPQTX3bjoeYHmO4XMJGfM6bquMcpFMUBxcn2W0V/IvL7PtAVgtDyv
         e4LWw0TTVIiFbn/Z6ABvRyv6QpOreGmeUoORFTEOduJpaiocts7FnZt5upDYc1Ly0ruK
         YkAbetvPF1D9LHJ7lu0vQS+DVV30W3qPk8kMSqYJ5QbZxUWFwcbhEcXjOUP90ACZDWbP
         iTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rg2i+W3o8JUclnxMgPyLQ0SAUwAjLroj6rogmvixwkw=;
        b=jTObgL7unKGaRSr+F4SemJOGiVtvZ0cU7ELZeGSUchk2dG5BPXwj51xZ8Xdi/Ifjym
         CAL5OzrWhBugkoFFCo1blnQjk2R/3ZtCyhCuHTzsQ/N022OAFpZeFtnbHVKyTeft2Vnx
         G4lRFMElxi4Zw/Lq7Bf4tkUcM0BhG93utcyj1Av73eayiuB+SG5JVQ8Dkf6N7x6Z/3kt
         1tNlVAPk2OAR7Mz27KdPKllCsfPQ6MTLU0J2TxulP6WpxB1u5I6BmO2D9890lBJ5S7Bu
         65ua8MySjjUAk7/IidshVKv2918btPpSDSk/4kH/F/QHL5FCyEhKgM7b0Fq3g4Q+4Gfa
         j2Cw==
X-Gm-Message-State: APzg51BJhB9jqAExxxU/fCQYomaF+qDN38QrMoP5g4bYHhOz2rDtYO/C
        IchTyPlzvJ7QL4KWBWe4+kMYqwjYv12CSYaFjlA=
X-Google-Smtp-Source: ANB0VdYL5cE45gofFKDmHtmzWkhAt32pFjtYpBHYHsEjw1DUITwfIubO61iGb9cjLxjmTVFbgby6cu/g9+WXv49Sd+w=
X-Received: by 2002:a6b:9dc8:: with SMTP id g191-v6mr2070852ioe.282.1535137262501;
 Fri, 24 Aug 2018 12:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com> <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
 <CACsJy8BXy_7QbDtF8bY5YzwJf=JUwiODv0zKxoSXeu4rJ+xjwg@mail.gmail.com> <2ba0a9f7-8073-e606-d433-490ea605466b@gmail.com>
In-Reply-To: <2ba0a9f7-8073-e606-d433-490ea605466b@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 21:00:36 +0200
Message-ID: <CACsJy8BtSYm0+Ku_+_F3S3aH1vMv5LPb=U4XCn-P-bvn-6yhjw@mail.gmail.com>
Subject: Re: [PATCH v1] read-cache: speed up index load through parallelization
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 8:40 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 8/24/2018 2:20 PM, Duy Nguyen wrote:
> > On Fri, Aug 24, 2018 at 5:37 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >> On Thu, Aug 23, 2018 at 10:36 PM Ben Peart <peartben@gmail.com> wrote:
> >>>> Nice to see this done without a new index extension that records
> >>>> offsets, so that we can load existing index files in parallel.
> >>>>
> >>>
> >>> Yes, I prefer this simpler model as well.  I wasn't sure it would
> >>> produce a significant improvement given the primary thread still has to
> >>> run through the variable length cache entries but was pleasantly surprised.
> >>
> >> Out of curiosity, how much time saving could we gain by recording
> >> offsets as an extension (I assume we need, like 4 offsets if the
> >> system has 4 cores)? Much much more than this simpler model (which may
> >> justify the complexity) or just "meh" compared to this?
> >
> > To answer my own question, I ran a patched git to precalculate
> > individual thread parameters, removed the scheduler code and hard
> > coded these parameters (I ran just 4 threads, one per core). I got
> > 0m2.949s (webkit.git, 275k files, 100 read-cache runs). Compared to
> > 0m4.996s from Ben's patch (same test settings of course) I think it's
> > definitely worth adding some extra complexity.
> >
>
> I took a run at doing that last year [1] but that was before the
> mem_pool work that allowed us to avoid the thread contention on the heap
> so the numbers aren't an apples to apples comparison (they would be
> better today).

Ah.. sorry I was not aware. A big chunk of 2017 is blank to me when it
comes to git.

> The trade-off is the additional complexity to be able to load the index
> extension without having to parse through all the variable length cache
> entries.  My patch worked but there was feedback requested to make it
> more generic and robust that I haven't gotten around to yet.

One more comment. Instead of forcing this special index at the bottom,
add a generic one that gives positions of all extensions and put that
one at the bottom. Then you can still quickly locate your offset table
extension, and you could load UNTR and TREE extensions in parallel too
(those scale up to worktree size)

> This patch series went for simplicity over absolutely the best possible
> performance.

Well, you know my stance on this now :) Not that it really matters.

> [1]
> https://public-inbox.org/git/20171109141737.47976-1-benpeart@microsoft.com/

PS. I still think it's worth bring v4's performance back to v2. It's
low hanging fruit because I'm pretty sure Junio did not add v4 code
with cpu performance in mind. It was about file size at that time and
cpu consumption was still dwarfed by hashing.
-- 
Duy
