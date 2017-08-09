Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D771F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbdHISUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:20:16 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36235 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdHISUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:20:14 -0400
Received: by mail-lf0-f50.google.com with SMTP id o85so31515972lff.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ddqfWZmJm2V2VNtTj4ITLX6xY9By8AbhVrd2ftHLKA0=;
        b=lbnUzmKG6KjCiNAuW9PaTb/dwFgoGsmaLRqV5IYxFgRxV/0IS3a2fftCnvP3cohp4x
         7h8Ywcs1Qra+AokjSLMkY7e//TrW4yD6z4aU3qaFjDKEhAuezrvg5sygftdCxVTI+jtd
         AXl9fQIojs+6jo5rcJ4aVIg/PENsOqYQKgZeaUiQqEis3JBWYLyjDxT+V2wdNaLSJekR
         4KkMjGdlinEgeO1VfF3HAmsr+4wpCtcVnfLXQeHwTaUVd/a6wSet5G+sHnGeQCDhG5v0
         bwEf62KIAVUTmtGTf9F0Qa9HrALHjQgg0s6tjNhvW3PB5LCezxO9cyORZlg1+u9kVxhw
         eQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ddqfWZmJm2V2VNtTj4ITLX6xY9By8AbhVrd2ftHLKA0=;
        b=milSjGSJFSE0DgIsGvEyb8FLpNwe+/BXlOyAdyxgSeahzt+ZzdaVmTWkcrnuSyUPv3
         RFw/I3VRTJBOeP0km4y8bj+N8hb1+9kE1SpzjFlvFmze7h3Q21Ick5VnLdEQFRFWzCU5
         ENSz1aaZD/r+5yIlxNDaWmr4kpGMNNZOtMSXfN5pW5V/ZvGWIqvlp8yp05mpWGd4n0kR
         AQ0/c4HyF0FNd44LNfq5pFS4Xm1n+MjrSa419hD0Ha+WSHL8YVpjatYmXXgkhrOK2U9V
         hMZw/Bsd01SQ+ZTpbIq80ozS3rHEAxMhj48fiOoyUYrNMNAaN2EOBa75l5UylDevdL1l
         7xCw==
X-Gm-Message-State: AHYfb5iwU8frLG0V+5DAMkdj1WDJxXf1DpmCXpXnpTJW/DiFyj5VsIJR
        xCSQVVxQ4RbeszuzCNABzZ5MMoRXAI3q
X-Received: by 10.46.69.193 with SMTP id s184mr3089830lja.116.1502302813032;
 Wed, 09 Aug 2017 11:20:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 11:20:12 -0700 (PDT)
In-Reply-To: <20170809122642.uwhv2epmgmr7wrk5@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net> <20170809122642.uwhv2epmgmr7wrk5@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 11:20:12 -0700
Message-ID: <CAGZ79kZ8_bx3M6vac9MDLJjZCS5vqosPhO51dmGjC=3Fiz3O6Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] interpret-trailers: add --parse convenience option
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:26 AM, Jeff King <peff@peff.net> wrote:
> The last few commits have added command line options that
> can turn interpret-trailers into a parsing tool. Since
> they'd most often be used together, let's provide a
> convenient single option for callers to invoke this mode.
>
> This is implemented as a callback rather than a boolean so
> that its effect is applied immediately, as if those options
> had been specified. Later options can then override them.
> E.g.:
>
>   git interpret-trailers --parse --no-normalize
>
> would work.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-interpret-trailers.txt |  4 ++++
>  builtin/interpret-trailers.c             | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 6d867e8ab3..ab2d5c7696 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -93,6 +93,10 @@ OPTIONS
>         line, with any existing whitespace continuation folded into a
>         single line.
>
> +--parse::
> +       A convenience alias for `--only-trailers --only-existing
> +       --normalize`.

Somewhere in this series, we'd want to not just describe each
of the new knobs, but reword the initial description, too?

    git-interpret-trailers - help add structured information
        into commit messages

Maybe a s/add/handle/ s/into// is enough?
