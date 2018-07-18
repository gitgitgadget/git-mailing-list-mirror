Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0461F597
	for <e@80x24.org>; Wed, 18 Jul 2018 23:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeGRXwJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:52:09 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37063 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeGRXwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:52:09 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so2538122ybo.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xyv1lgrIkKAMtFylnQ29rXebWVtUCe5uAvzRsusXYuw=;
        b=FSD0BemffELf5hlsKq+Nc7mhhQmEY8wOX7PLuYfICcEOGV1KtOj7hgSl2zk23tmDZ/
         dQNZWrFzgc6z5jP21m0Qf8d0bAqYI2xsQWcj3eoSJF2tm3t3ng7+OCsn7tPZaG2flbT8
         gO7hFCCYYhxmCiqCj6EIKOuiQlyrtPP/R1YlPNy6yhITkwihytdVpB0jczkAG37gCfFF
         8ZPYlcdRtP5McinvIu62bCCOiY65Ta76YmHS/gutS+qJpBCD3tUCYpdHAW2oaXhD87s3
         QWz6eiJKLgnPo3DM3w1GpFS16d78f2Ooe+wvzfe3ryym9HMOvWvmPpaCxwhTf2jTx1jg
         XVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xyv1lgrIkKAMtFylnQ29rXebWVtUCe5uAvzRsusXYuw=;
        b=Pf0WNWj0IDeUTDhDfJYLEbUaLmxqcFae02bZfUg1/4z4ujFY2PFYE4VY0rhlzkJBOv
         McYyE0zGfXFsy8YxdVgJpPtGxswIGf0HDBnj03I/UkJBbu4SQe96bWFFhs6UWjwMPGFb
         jgwFZG5oxua/TTRv6vGAgOtw53jKS13NZW1zWl6LYr/HyG8My5RDtK499MCksvL+s7op
         qSs97a2fahSA4ihXKuVsmty0KcxF8QA98iJShBNoiyUQj8CGBz3GioeZYam5URrdnoAa
         1aLbpIWQfPaR+d4CVGoyVcmcfwAZ2WeHj5fEVSuhY0eo4SBdRcX5kvJp7ThkXXXF/gLk
         w2PA==
X-Gm-Message-State: AOUpUlFtTPzWfv5Sa897nwCMHjDKJy2IH66YkyzceatKlxvwSK4IQFFf
        kauRYAnvoSFFYLe7k8m2XEc2gFwLTs2ttLiRJ+T2ZQ==
X-Google-Smtp-Source: AAOMgpdLcCxs8HNG67s579F4ypdxIlTvTzy7YPSXdPIREMCpiKMB50BZVtZm/4Tz0SXl2jKb+63HnF5lDK4llPLpJuw=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr4445505ybm.307.1531955518747;
 Wed, 18 Jul 2018 16:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180718194853.57994-1-sbeller@google.com> <xmqqpnzki3mp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnzki3mp.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 16:11:48 -0700
Message-ID: <CAGZ79kbYybZ8KbaECy2oqrTH9dUKVgTfrrxbOYWxhF14_d210A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Resend of origin/sb/submodule-update-in-c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 3:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This fixes the compilation issue raised by SZEDER and Stolee,
> >
> >
> > 6:  3c156c79ae7 ! 6:  f82f24e73b6 submodule--helper: introduce new update-module-mode helper
> >     @@ -10,7 +10,6 @@
> >          for arbitrary repositories.
> >
> >          Signed-off-by: Stefan Beller <sbeller@google.com>
> >     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> >      diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> >      --- a/builtin/submodule--helper.c
> >     @@ -74,7 +73,7 @@
> >      +        determine_submodule_update_strategy(the_repository,
> >      +                                            just_cloned, path, update,
> >      +                                            &update_strategy);
> >     -+        fprintf(stdout, submodule_strategy_to_string(&update_strategy));
> >     ++        fputs(submodule_strategy_to_string(&update_strategy), stdout);
> >      +
> >      +        return 0;
> >      +}
> >
> > Thanks,
> > Stefan
>
> Thanks.
>
> This time not from GGG?

GGG = GitGitGadget?
I have yet to try out that tool, I am still stuck on git-send-email.
(old habits die hard)

It is even based off your branch (with all your sign offs).

I just cut down aggressively on the range diff (and short stat),
as I want to highlight the important part.

>  I don't particularly care which direction
> patches come from, though ;-)

Cool.

Thanks,
Stefan
