Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B03F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdGMTpY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:45:24 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33964 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdGMTpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:45:23 -0400
Received: by mail-qk0-f179.google.com with SMTP id d78so59470453qkb.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aztXITNSANOXTSk8uQwm80mzKaERyl2ILWxrExsCAjY=;
        b=UFs74badXM6fyhtc/U8kdWACdfPsfidjYrm1u80+5gX+qSR5tbHddXIPWX7Utopmsr
         GiZ4H1Zm6Nh4pLC9r1mopIbXZe4FeNAB1e+DggBoAw8CLlTtJMNVEKWCt8pqPPlrA7T7
         YLnhitqQDI05UcXli4qdw5r4ueLu0Fcnaq0PYO6jKM8lvkqiDlcYoNlhOvWLGuSFDrbb
         urePK1Gu169WOtSalD5eBW4ZX1GiGniSld/j+JI1uw6m1PLeV8nkjkT+GlPCsyFaqlsy
         f7hxSEgrSIpSmcPciVp6rRqeUNvZlVGsmgo52yGRBz/k17AMyZ26ZiIQIDIh0OW7D89O
         7GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aztXITNSANOXTSk8uQwm80mzKaERyl2ILWxrExsCAjY=;
        b=uHoI8Icr4CXi4dGjIkFC0yA2aFNqnUYFAxKugKvypsjC/GbwBKM0vJzI3DU68uUinC
         LLZUJuIoqBGFZ0cdsohz+y7SRPCW5gHeYz1EMAn+2dWRRHbvwi3At3be9gwliUafQUUg
         egm12gCZoSHcFOexX27Z4Vv6UkwF/yz4dRMSuNiswJzKX+S4mpPjZBeZe+PhfL2sFGsj
         EL42tMnk42eKeOlFDR03PKk+/BsQvmwHVG7C4bamOa5BDO5etnpOX+J0iwwyLty8Cz6N
         RWCS03LNu+NxjYjeTKse6641E3GCCb7nzRtWMUsiUa6l6jDoWvSOL/jZBTD9cBj7J332
         ZmHg==
X-Gm-Message-State: AIVw111LVFDsWoR73f3RkZEPUkB8ify2D3R5gWLSdQyXdZ3qJQI4vmvJ
        t4rwQMIifJGP9yK7LX1gsiS3XUOmVA==
X-Received: by 10.55.152.71 with SMTP id a68mr6521359qke.210.1499975122690;
 Thu, 13 Jul 2017 12:45:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 13 Jul 2017 12:45:22 -0700 (PDT)
In-Reply-To: <20170713184051.fcwg76o6ovnsjjbm@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net> <xmqqeftkxkax.fsf@gitster.mtv.corp.google.com>
 <20170713184051.fcwg76o6ovnsjjbm@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Jul 2017 21:45:22 +0200
Message-ID: <CAP8UFD1ZfdV2+9Z6pjUvtxWitxdwquPjycWr+H-XR3Uw9pruBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 8:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 13, 2017 at 11:29:10AM -0700, Junio C Hamano wrote:
>
>> > So then I think your config file primarily becomes about defining the
>> > properties of each run. I'm not sure if it would look like what you're
>> > starting on here or not.
>>
>> Yeah, I suspect that the final shape that defines the matrix might
>> have to become quite a bit different.
>
> I think it would help if the perf code was split better into three
> distinct bits:
>
>   1. A data-store capable of storing the run tuples along with their
>      outcomes for each test.
>
>   2. A "run" front-end that runs various profiles (based on config,
>      command-line options, etc) and writes the results to the data
>      store.
>
>   3. A flexible viewer which can slice and dice the contents of the data
>      store according to different parameters.
>
> We're almost there now. The "run" script actually does store results,
> and you can view them via "aggregate.pl" without actually re-running the
> tests. But the data store only indexes on one property: the tree that
> was tested (and all of the other properties are ignored totally; you can
> get some quite confusing results if you do a "./run" using say git.git
> as your test repo, and then a followup with "linux.git").

Yeah I agree, but if possible I'd like to avoid working on the three
different parts at the same time.

I haven't thought much about how to improve the data store yet.
I may have to look at that soon though.

> I have to imagine that somebody else has written such a system already
> that we could reuse.  I don't know of one off-hand, but this is also not
> an area where I've spent a lot of time.

Actually about the viewer AEvar suggested having something like
speed.python.org and speed.pypy.org which seem to be made using
https://github.com/tobami/codespeed

So unless something else is suggested, I plan to make it possible to
import the results of the perf tests into codespeed, but I haven't
looked at that much yet.

> We're sort of drifting off topic from Christian's patches here. But if
> we did have a third-party system, I suspect the interesting work would
> be setting up profiles for the "run" tool to kick off. And we might be
> stuck in such a case using whatever format the tool prefers. So having a
> sense of what the final solution looks like might help us know whether
> it makes sense to introduce a custom config format here.

I don't think we should completely switch to a third-party system for
everything.
Though it would simplify my work if we decide to do that.

I think people might want different viewers, so we should just make
sure that we can easily massage the results from the run script, so
that it will be easy to provide them as input to many different
viewers.

So we are pretty free to decide how we specify which tests should be
performed on which revision, and I think a config file is the best
way.
