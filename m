Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B7AC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F27E64F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 04:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhBCEr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 23:47:28 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43906 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhBCEr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 23:47:27 -0500
Received: by mail-ej1-f53.google.com with SMTP id y9so11922476ejp.10
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 20:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZQpzL4pRN2uLP/5AuKqlTK+YddwQMzG5NsftWrdov8=;
        b=OkGJeizYGQso216SLJqVenVl9gQga4Su4fMKVlhFIpdZ6j802VhaysQ7GWEiXJD8L8
         1C/SuhHy33K1KlRsEEGrKQ9ub/Mzxpju66zWcSLi0MBNtkMKuXiUKRpxLHWxwNRu5eIX
         2qJM64tkt86rS6DWRqm7PFTgCBQ0NRR/TnY6KsjN+hg1CV3BIuP393AZmxaK3Vfu+Sxx
         VAT6kRXcX0GyMRsq19a7tdtDtReNH3HFqPXtoWAw2SJB0LdqnP9I6Nti5fuTUbgQ+ggu
         oK6IdIFE8djwGOx+R+mTjvOBCt8Qx0LORNu4TrhC50Z+ckmcblOQtqMg5x2C+1vywNFH
         wCdA==
X-Gm-Message-State: AOAM530EoEVPFFx3J0rtQ/PD+j6jdo3rxLMTkfORaCRhgdMX5URqvfKi
        J7/ZoxjmI/loXRhtr4S/mBHAdDJzdmgDPp1sitk=
X-Google-Smtp-Source: ABdhPJxsZuYhJQwyTBmwBijkZGKI/C6+6hhRQVZsMb/48M+wjEcf2Lyo8Z69gSu0T1XPjzNSHpAr53zuNYCSeFpItFg=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr1350677ejm.371.1612327605492;
 Tue, 02 Feb 2021 20:46:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
 <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
 <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
 <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com> <CACPHW2VBEu=02HFhyrDes=6KceLtHzGDqBJVf2qAnD2s1f8VAg@mail.gmail.com>
In-Reply-To: <CACPHW2VBEu=02HFhyrDes=6KceLtHzGDqBJVf2qAnD2s1f8VAg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Feb 2021 23:46:34 -0500
Message-ID: <CAPig+cSSU1P68dBomjRkO4jUqUnu+0ri5-3y0-H228-qONwhyw@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Lance Ward <ljward10@gmail.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 1, 2021 at 11:09 PM Lance Ward <ljward10@gmail.com> wrote:
> On Sun, Jan 31, 2021 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I think the approach I suggested of patching those wt-status.c functions
> > to use:
> >     rev.diffopt.use_color = s->use_color;
> > would fix this inconsistency, wouldn't it?
>
> I've made the change you requested and it resolves the issue.
> It also fixed the inconsistency I mentioned.  I only needed
> to modify wt_longstatus_print_verbose to resolve the issue
> since it is the only status path that had an issue with the
> git status command.

Okay, makes sense. As long as you insert the assignment somewhere
above the special case:

    if (s->fp != stdout) {
        rev.diffopt.use_color = 0;
        wt_status_add_cut_line(s->fp);
    }

then it should work correctly, I would think. However, it might be
easier for people to grok the logic overall if you incorporate it into
that conditional, perhaps like this:

    if (s->fp != stdout) {
        rev.diffopt.use_color = 0;
        wt_status_add_cut_line(s->fp);
    } else {
        rev.diffopt.use_color = s->use_color;
    }

Or this:

    if (s->fp == stdout) {
        rev.diffopt.use_color = s->use_color;
    else {
        rev.diffopt.use_color = 0;
        wt_status_add_cut_line(s->fp);
    }

It's subjective, of course, so use your best judgment.

> > In fact, I can envision this patch being re-rolled as a two-patch
> > series which (1) patches the wt-status.c functions to do
> > `rev.diffopt.use_color = s->use_color` which should make
> > `color.status` imply `color.diff`, and (2) adds a --color option to
> > `git status` which sets `wt_status.use_color` (which would then be
> > automatically inherited by the diff machinery due to the first patch).
>
> Right now as it stands my patch resolves both of these, but
> if you'd like to make it two separate patches that would be fine.

The reason I was thinking of splitting these changes into two patches
is that they have different purposes. You'd sell the first patch as a
straight up bug fix, and it's easier to formulate a proper "sales
spiel" for that if it's not blurred with other changes. (This may be
important because it could be slightly controversial if other people
don't consider the behavior as being buggy.) The second patch would be
an easy sell as a straightforward and simple enhancement. Another
reason for splitting them into two patches is that doing so would make
it easier to revert the bug-fix patch separately if it turns out that
there are unforeseen negative side-effects.

Having said that, a well-crafted commit message may very well make it
easy to sell the change(s) as a single patch. Again, use your best
judgment.
