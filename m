Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928E3C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B7422C7B
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbhAXF2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 00:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAXF2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 00:28:42 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2DC061573
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 21:28:02 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v1so9489708ott.10
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 21:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97zPYRpWLZYzjzN8jV/AI1Yko0txwZYLPHhJ0UIniUM=;
        b=Apct7Bm1C4PHkuNWfrzH2+hkTJ+6C3MQoDUJV7X3+/pqxSzyTy7jACXN9dbiJNeyeS
         FKZkEbu8lhyhxarbBCZ0i7GxFLnRz/AlmSoAIpw8UaycUfGiDU7s0434c3ismk1YH7qe
         PwdF1w5OjFSdN8l6A/nV+/6kYooU9brrMWOlGKnoNsoqhsi4MSf+vN5JnVfwPm5Ddea2
         4NkRR2Y7ni3gbddYJBeHVm9XUANOMWkHU1OyW8SLy3MawKT02vMNznFrZiqp89hgC4+t
         BxE6j530+qL9l90yiqymxjz4+2PsT5TNP9EkhO/8w6F2NmHPaqZXRjmpqgL/dc+bKC7N
         kwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97zPYRpWLZYzjzN8jV/AI1Yko0txwZYLPHhJ0UIniUM=;
        b=tEFxZFcqH4A4X6xSO4kJlANCQdTeGBndbTMhV1gr5eMQU/v1AR+CvAzUbcbrPL9ODH
         Wke+RYXjdsvOW77daP2x+0qOUr7+kExjS7iB1qWvzxhEpXA7PMu545j8mI9sQrorh8k/
         RBjKu2pJWf81uInystFackBlbeJlC9LSNLhA8Pu6uZNCN3BUTyKpzZLDiIYaEATwdTOi
         hEfChz0ZuY2keHiyM5eTIwq/5qt11HOIQVnBZioX6WEpjkTtJWcWhFSFEhCz0mM8pxbI
         VF5pi+8flUKKVK2fFb2UzDNfO7uWYRDRlaUULgLfMe4Me9N2Hoeh1rP1sBoWs2Yx7kxJ
         ixlA==
X-Gm-Message-State: AOAM530X6jVsjMsV3i7wfoSX9rmZKdhEAx4wpN45V+papXoUhNz7HjP+
        5IYDayRoev2AKeEBZ4wwagR3MbhwX2rw/ZcB/Mo=
X-Google-Smtp-Source: ABdhPJx40Z+2AOZhWM0pNhIEqcfzEq2vDU5I9airgIGKkY6U4yuQOpEFvGq7VDvGHsGdcmZ6iXMMCtq0EB8fry+X298=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr8378226ots.345.1611466081108;
 Sat, 23 Jan 2021 21:28:01 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com> <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
 <xmqqft2ucf4p.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft2ucf4p.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jan 2021 21:27:50 -0800
Message-ID: <CABPp-BHMmi1A2fzkVsgEUeeMQywtU6YaCU93nq1K7301YhtpjQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 21, 2021 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Hi Junio,
> >
> > On Sat, Jan 16, 2021 at 2:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> * en/merge-ort-perf (2021-01-15) 4 commits
> >>  - merge-ort: begin performance work; instrument with trace2_region_* calls
> >>  - Merge branch 'en/ort-directory-rename' into en/merge-ort-perf
> >>  - Merge branch 'en/ort-conflict-handling' into en/merge-ort-perf
> >>  - Merge branch 'en/diffcore-rename' into en/merge-ort-perf
> >>  (this branch uses en/diffcore-rename, en/merge-ort-3, en/ort-conflict-handling and en/ort-directory-rename.)
> >
> > Any chance we could merge this down to next now?  In terms of pre-requisites:
> >   * you merged en/diffcore-rename and en/merge-ort-3 to next already
> > (and marked both as "Will merge to master")
> >   * you previously labelled en/ort-conflict-handling as "Will merge to
> > next" (and it was reviewed by Stolee[1])
> >   * en/ort-directory-rename has now been reviewed by Taylor[2]
> > Also, en/merge-ort-perf itself has also been reviewed by Taylor[3].
>
> This one is a bit unfortunate in that it is so small a change by
> itself, but sits on top of en/ort-directory-rename.
>
> Even though I wanted to merge the en/ort-directory-rename down to
> 'next' yesterday, it has just got updated and I had to rebase the
> ort-perf branch using the material from the old thread, so neither
> is in 'next' as of now.  That's the cost of building on top of too
> many things that are in flex X-<.  I'll see if I can find time today
> to give it the last read-over before mergint the ort-d-r in 'next'
> but I am not very optimistic right now.
>
> > But I'd like a stable commit identifier to place in the '??????????'
>
> Well, we'd all like a stable commit contents in the first place ;-)

Yeah, so...I'm about to make it even worse.  I'm feeling really
embarrassed, but I discovered a huge memory leak due to a section of
code that I for some reason thought was associated with later changes
and had been planning to submit later, but I discovered it should have
been submitted already (along with other series that have already
merged to master).  The memory leak makes a small but measurable
difference on the performance numbers, and since my subsequent series
repeatedly refer to that commit message and the performance numbers it
reports, it's kinda important to get it right.  So...

* I'm not touching en/ort-directory-rename; I still think it is ready
for merging to next.
* I'm about to resubmit en/merge-ort-perf, turning it into a three patch series.

Sorry for the headaches.
