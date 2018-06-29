Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C811F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936093AbeF2Vy7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:54:59 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:39292 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeF2Vy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:54:58 -0400
Received: by mail-yw0-f182.google.com with SMTP id 81-v6so4222202ywb.6
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHbxTP40qszBx3wAhJkyDOUpW1HDAc71cv+Kri1rDys=;
        b=SkajTjyKxyTVx4i7r/Zb4CjMBInZoZJGZLUAcx3MJWFHsyfnUsreKAZlZWt1pIpiAt
         GujjoSrjbdATQptzTLlvTCGhvs8DMVinaMPiTrpk5S9iknLil3sFG5OG+KgrlytUcmYx
         tkvHjHQQ1grQ1gMcHZmPASYcQdD6FlCRiD9TdcTJUg6myWN6ifcPaRrNHPwX66LsykXU
         dzFhc0UygNoTBvrWlh7usVmSEzJXOZtmbWiuLBxgpEYPRSA4Kay0Qdp96R48JOkLB4df
         0GZjiCvkNtPjIchOdO5d05Ke4li4LNPblj3FhyzuR1DBa2OlErrQ8rM9jG8AQAwcFgjx
         uetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHbxTP40qszBx3wAhJkyDOUpW1HDAc71cv+Kri1rDys=;
        b=Ir7910hYHRmjPvJbF1sLAi3cuVwnC21uYNmiFqO5ADbFWO1JM+9JfnYPAHvaMWOKQU
         4H3ExK4s6ZoKiprvB76D+HrQ71mZeWVxRQMjIP2h/+UBzKm/eyQDb0QfEuYcISMEAGKr
         dnFsBM27Ap8sskmds4EIA7AKzhBZAgU2vqXPyxRnIwxViCIzwmU9wIlgThCwhhiHv7WH
         uLTbD/pmFDC5SKQiYHVZiWU+T07wgJAnnh5BSMfAksI00Km38amSpTZRjypSXZ33fE2j
         9idQMV7gcc9j2DIsPYJBcPN8R1dbw6BPRnAdjxuDCwZI9hbl3ZgY/h5BRUNsuwi8cRii
         YRgA==
X-Gm-Message-State: APt69E3VuT49Qcmy0hnC2xzXxpnJ2r1DFOAWRR0j5RDY0uF02Lkdxvff
        7GjQNm9yeoxBKt5vz+IR81wJ3dBKjzBpaVSUBF/85bOp
X-Google-Smtp-Source: ADUXVKLLyuOJoGpiZiANnqAi4nVYscqwEZzfL85TwIlZ3Ej+C8mJSaYHuoNljrQ5+kOzBnSESi6tCLrlh2a/z4Y5K1M=
X-Received: by 2002:a25:c04:: with SMTP id 4-v6mr8822372ybm.247.1530309297722;
 Fri, 29 Jun 2018 14:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-8-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-8-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:54:46 -0700
Message-ID: <CAGZ79kZpZvaX7Jh7hXPWV+KPffx4m+5W-3Baqd6ggoNnq2Y9hw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] test-reach
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 9:13 AM Derrick Stolee <dstolee@microsoft.com> wrote:

> +# Construct a grid-like commit graph with points (x,y)
> +# with 1 <= x <= 10, 1 <= y <= 10, where (x,y) has
> +# parents (x-1, y) and (x, y-1), keeping in mind that
> +# we drop a parent if a coordinate is nonpositive.
> +#
> +#             (10,10)
> +#            /       \
> +#         (10,9)    (9,10)
> +#        /     \   /      \
> +#    (10,8)    (9,9)      (8,10)
> +#   /     \    /   \      /    \
> +#         ( continued...)
> +#   \     /    \   /      \    /
> +#    (3,1)     (2,2)      (1,3)
> +#        \     /    \     /
> +#         (2,1)      (2,1)
> +#              \    /
> +#              (1,1)
> +#
> +# We use branch 'comit-x-y' to refer to (x,y).
> +# This grid allows interesting reachability and
> +# non-reachability queries: (x,y) can reach (x',y')
> +# if and only if x' <= x and y' <= y.

This is an interesting DAG, though not very common
in reality (81 merges, 18 single parent commits,
one root with a depth of at most 10).

It reminds me of FELINE as that also has 2 independent numbers :)

I guess it is easy to make up artificial test cases for that,
but I wonder if we want more variety for a generic reachability
test tool (e.g. long chains of parallel histories, octopus,
disconnected parts of the graph)

> +test_expect_success 'setup' '
[...]
> +       git commit-graph write --reachable

Is this only to test the full commit-graph?, maybe we'd
want to write out the commit graph at (5,10) or so, such
that half the walking is tested without graph.
What about author/commit dates?
