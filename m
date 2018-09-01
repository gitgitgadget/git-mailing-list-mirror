Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C451F404
	for <e@80x24.org>; Sat,  1 Sep 2018 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeIATgC (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 15:36:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIATgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 15:36:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so11066527edb.10
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SElEcgDwSt90HqV0iAi/1lXFf8g1w9IaqSLGmYHcus=;
        b=NLb42uONINO6cosECUS6ToYWAyKpjv1OOA0IeI+Z+H4v5/58BVXZwXoENfZXUEMfjO
         e3RybdeezkMv4awGqdNHmnszkbcgtOVzJqNzXyKsF5w1dlRIAZyzsyW6rTjga9Uchn5B
         gk3PKJ4qZsXPzRm0ygG77Zmt0gWN4wPb4p4gpExAeRxDMtlYueScef/2S12tX94hWzrU
         6YvhKgygUck1ClBkSItzizl6Qy/UcJ5oIIb1oXfBIBnfFv+qcCsbo7sCkmfzqTnObsLQ
         yZnBeZTwoa8heNwx0i6ayVbW8HyenXNd1vyfdQWVvMlKvTdnEdtA1cIEOW2n2EMELf0M
         8YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SElEcgDwSt90HqV0iAi/1lXFf8g1w9IaqSLGmYHcus=;
        b=k2cm3LjJpFH0Vh1RSzzGfFBeaaZi1A2czERCjU/HaEljK1/oTfgU5MsKkQy7MZIz3U
         CAvaARNtqorBdZDLmLevs7rtfk8oeXZNoIOfgKx2Tt6jHtJgkvSYJXG+rfSjkY4wp/hX
         Os4b7pJCYqYs/W+4FbM2qPZkRGSJcAoqzMbvOqOVoTDu+NPoUPjlBwljvvwQQCx/TKbm
         VmN0C5/W2di1a9fxDxMQ058y5L/4qpIH1t3m725iQE7vtEzHDr0u0bafMb6F6os+8yhQ
         GmOMHbUYcvPBu1s6oS+o4W9ZEcvR/zecVZwM4fJjnH/PVHV5FJoIOlnYuZUf+tItFR2m
         67jA==
X-Gm-Message-State: APzg51AOT/DrhRALAw35rClPSxZ4ZVfs5/bTjhke7ad71zGcA6Srz6j/
        p0j7V3zEfi6GXczhvwhvDaRWep8HRCWOqxQObFlb0w==
X-Google-Smtp-Source: ANB0VdYLIfpQsXhf7WG6fV6S3MVawLdDQrXOi/1y+7VQSVO4atGAPxN38hLp0GDCCLEeBBzFu3be0RqxM6czVCpDO/I=
X-Received: by 2002:aa7:ca51:: with SMTP id j17-v6mr22539365edt.45.1535815419700;
 Sat, 01 Sep 2018 08:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
 <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
 <20180830025457.GA665@sigill.intra.peff.net> <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com>
 <20180830192019.GB19685@sigill.intra.peff.net> <CAGZ79kYVLNM4fMwXAw9FbKFNJ1tTR7e04nBqKdnYPX3wYveUfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808312336270.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808312336270.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 1 Sep 2018 08:23:26 -0700
Message-ID: <CAGZ79kbi0Y+1j836Lc-Kp6xd3ihabhODLLMj9rrZH_Mxs3PB8w@mail.gmail.com>
Subject: Re: Possible bug: identical lines added/removed in git diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, gthepiper@gmail.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 2:39 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 30 Aug 2018, Stefan Beller wrote:
>
> > On Thu, Aug 30, 2018 at 12:20 PM Jeff King <peff@peff.net> wrote:
> > >
> > > [...] Myers does not promise to find the absolute minimal diff. [...]
> >
> > The `Myers` (our default) diff algorithm is really the Myers algorithm +
> > a heuristic that cuts off the long tail when it is very costly to compute
> > the minimal diff.
>
> IIRC Myers

(the original, which we spell `minimal`)

> promises minimal diffs only for -U0. As soon as you add
> context, Myers might in fact end up with a suboptimal diff, even without
> that heuristic.

ah, the last 4 words made it clear.

I have debated the cost function for diffs some time ago and
came to the conclusion that having one line added/removed costing
a flat price of 1 in the search of the 'lowest cost diff' is pretty good
as it does an ok job in the broad world, it is not 'overfitting' assumptions
on a problem.

For example in some patches I pay more attention to the lines
removed than to the lines added, or vice versa, so assigning
different costs to added/removed lines would make sense.
(It depend on the type of patch, but that cannot be deduced
at the low level of diff machinery)

Starting a new hunk (i.e. add cost to -U<n> for n >0) could be
costly. In fact we have an after-Myers optimization in the xdiff
code that checks if hunks can be coalesced together, but
if we could have that cost at diff computation time, this might
make for better diffs already.

Another example is number of changes between
added/removed/context parts. If I have to review only
one large added part and one large removed part, it may
be more understandable than having interleaved adds/removes.
(I think --patience goes in that direction, but does optimize for
a different metric)

Stefan
