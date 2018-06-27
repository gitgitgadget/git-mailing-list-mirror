Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659F71F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965823AbeF0Si2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:38:28 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41980 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933925AbeF0Si1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:38:27 -0400
Received: by mail-yb0-f196.google.com with SMTP id y187-v6so1136321yby.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fK8XJIjFeRBewn7ZNNis3L97ZYqO/uavCU+rAk0B7Gs=;
        b=gx2p1FMhnAr4oADggleeas5zNJZQRvZUyfi4cWvYX6VC0qhPrCjjs1zUnYt64gTjEy
         N901PPAFFbd7HOoC8C++ABv4lRvNNFmFLu6mjcRi+tXmm1NEkHGCYrfEFm+sVZEtj+tW
         1GpIVRDfaghmJtVjbkfxgJOT89ri/rcbnCgshECGTQlixNdmK4wAAZTBNCnTR5EHbeZl
         tm++/oyOjzUUvUCCpxMn5TpMxqpa9rLRV4SEwHgNdIqzsCxDl2ChUZ+V3rHL8P1Q0RXs
         Xg8JnzmZKqllsWdZp6d3ZN3mWyTsu7iSphmO6bWYLjAkDegyTk7wxsTuNF1Q8Py1iM1M
         keUA==
X-Gm-Message-State: APt69E39sZQGbYHDCPX4zI76ELG8P63pSFC+G7pOvVj4inmKymv/grb4
        GY9RJHEjdng7DMXMHxnBbB6fxwSsgZiff3+amKk=
X-Google-Smtp-Source: ADUXVKIJBOcP0OwvPsgcW4qPdTJcexa7yPJ9Gf0mn+RonoVB0/cxpnE3ah3s6hF7BSDLS/wepV7Yh9y1b9AEr34VWts=
X-Received: by 2002:a25:ac5b:: with SMTP id r27-v6mr3607846ybd.497.1530124707106;
 Wed, 27 Jun 2018 11:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-14-sunshine@sunshineco.com> <20180627183057.254467-1-sbeller@google.com>
In-Reply-To: <20180627183057.254467-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Jun 2018 14:38:16 -0400
Message-ID: <CAPig+cSr0owziyxDXexAFgZSurM-Vd+p6sJ5L3zSE_GAwcSO1A@mail.gmail.com>
Subject: Re: [PATCH] t/lib-submodule-update: fix absorbing test
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 2:31 PM Stefan Beller <sbeller@google.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> This test has been dysfunctional since it was added by 259f3ee296
> (lib-submodule-update.sh: define tests for recursing into submodules,
> 2017-03-14), however, problems went unnoticed due to a broken &&-chain
> toward the end of the test.
> [...]
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> In an ideal world the commands would not fail, but absorb the git directory
> of the submodule. I manually tested that it is absorbed and not data from
> a git directory is lost.
>
> I would propose to replace that patch with the patch below; I hope
> the wording did not add more confusion than there is already.

Thanks for diagnosing the problem, Stefan. I'm not a submodule user
and was not at all confident that I had interpreted the test breakage
correctly or that my fix was appropriate, so I'm happy to have a
diagnosis and fix from the person who actually wrote the test.

I'll also add a Helped-by: when re-posting.
