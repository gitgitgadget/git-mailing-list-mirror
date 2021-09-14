Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F27AC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B0560F44
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbhINDrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:47:35 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:38850 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhINDre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:47:34 -0400
Received: by mail-ej1-f52.google.com with SMTP id n27so25673925eja.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WahJmvRAGYSNMxN57Nbi9cAr2gRm8C873YbwAWT4b7E=;
        b=6INmUrDq3PGErzUyoPeg2qtl83grCoKQWoPeDUs6UpR5jU+jNTOqX1qII4h70VgE5w
         2yjRzqQ7MzH+UyXpMmPd702sHTowQK24QYkNADu2zfgb5g5hgl4IJmcBohz4CluUeVW9
         4h7EZBT01Qq25Kvy2dUu+aszPw5VNtSfiRHqLOc+c2AuvJr0s+SoHB3FkR82rYaCVy7I
         JzKEmRTzTdGomlLW2vYrT25UhmkyCA1jkQlnDjHyR+DGPlKMchuL7OKMO1S9kErf3/Es
         MWLdOfvXJwxuzKzhWWp9UM8L+7+zserHFgTiqaudb26oUugU4BSsojoGV9oJZFqQ4zP9
         H/4g==
X-Gm-Message-State: AOAM530VDSzuD3B3E+g2tdkYl9zwxuag73RNBRxz82M5Om4PFO/r5Apy
        5Aq/GKDKbObvY0QxXrM4uFJ5wh/5Z1A4CWDH+fFvMt7m
X-Google-Smtp-Source: ABdhPJwy2f3qqoeaeGMbNG3u4KU26qRCXZawalQkAdk/KCebH7vv6uQhu1lA5twQoykgRU2wYMNmUycJCVu8abW2gfw=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr16101302ejr.36.1631591175683;
 Mon, 13 Sep 2021 20:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <02e15e8d-6923-9f21-8eeb-592eb0c9588b@gmail.com>
In-Reply-To: <02e15e8d-6923-9f21-8eeb-592eb0c9588b@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 23:46:04 -0400
Message-ID: <CAPig+cSHSSuE6ovPN+XVRDhNU8WD+XzuH0gLzupNZiN1QLGz9A@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 10:43 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 14/09/21 02.48, Glen Choo wrote:
> > In the "Sending V2" section, readers are directed to create v2 patches
> > without using --range-diff. However, it is custom to include a range
> > diff against the v1 patches as a reviewer aid.
> >
> > Update the "Sending V2" section to include the --range-diff option. Also
> > include some explanation for -v2 and --range-diff to help the reader
> > understand the importance.
>
> I think plain "Changes since v1 [link]" is sufficient if you can
> describe such changes well without resorting to range-diff.

Not so. Anyone who does any serious amount of review on this project
finds it tremendously helpful to have both a prose description of the
changes ("Changes since v1..." plus a link to the previous submission)
and a mechanical range-diff or interdiff. A range-diff (or interdiff)
is especially important to provide reviewers with context which they
might have forgotten since the previous version of a patch series was
posted, which can matter since it's so easy to forget specifics even
about one's own review if enough time has passed or if reviewing a
large number of unrelated submissions. A range-diff or interdiff also
helps a reviewer determine at-a-glance whether or not earlier review
comments have been addressed without having to laboriously re-read
each and every patch.
