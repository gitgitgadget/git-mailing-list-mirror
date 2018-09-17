Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229401F404
	for <e@80x24.org>; Mon, 17 Sep 2018 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeIQSYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 14:24:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35118 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQSYT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 14:24:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so11139760otl.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYz4wJx53NjtRmJXWAP7ZNyXzTk+n41rYUuDeDipEQM=;
        b=ndqdPppqELqHdaJFFZEB8+DC9MbA76709kGRWuAeOih/pdmzSdflN+kgSBsM9Bfb1k
         qcCrs6pK/99WsqCFFagGm3pQu89R1ROc7AQa2GrL/PxiNAt9/KElHSB/wyL7orTmICFE
         ReIo92Y/Mxg+Trgv87AcA3IHQL44REqIxdSZr6OgIsXPiMSqcasEW5aEv8bFUeCUr9rP
         E9HKBDPt1g/d4h00M+fjaZJVfFZt6F4lRizjiCoB+AdkeHNabaaV3vh6aUZrlViMoH8o
         qyLwMqcvgWVzx2w7CSkIpAYCZ7iont00T3HO/T6pzD02v112kAEsbpoZOH33XDYVW3po
         Z9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYz4wJx53NjtRmJXWAP7ZNyXzTk+n41rYUuDeDipEQM=;
        b=IhU0kZbgyED+sxon7eoAp81+ajskTxkCSrCSk6cwF32k8rnHe42w1oELqBWA0GFLcW
         qLJkCUTdjyhG7Z7vrYdfv4DjeJea8pIUjnqvPC0YXiAIKk68j43VaxZhWaVZX/PEYj25
         f7fMhetZJ8HIAaNchDwZHCqKKGvWlLsJyIdTInUkmNArcx7pdsReizVGbgyJucVhpDTL
         fmjlVJknmJTSR/R+I101d6NapS98K6Uv7tfwRRQFLCl/dXm+TTh4fRt5sP4j8xUdZAsF
         wuU4TbbiJ7u/kSciSwmT1e6uT01W1OWcNkeOAZvn89z0Hv/aJ6dochyz6q+j6KtCN3RJ
         QsNA==
X-Gm-Message-State: APzg51DSP4io4CGzlRkFdtJpUQ7NDbEYeBz8iVp0Kq9UXwIL0+h/tUdk
        wr3WXoCs5+eWsTeuyLh9CZmJUKyQdjKgVremkky8lN7zrubr
X-Google-Smtp-Source: ANB0VdYPvgKLvI01vhMATU32hwn/2YkNd99QsZ+xmv1zH5Nb2g90XN0ec/EEW5+FAZypfLAy6FmQriwCb8M9m5fQw4k=
X-Received: by 2002:a9d:7185:: with SMTP id o5-v6mr9601560otj.60.1537189024836;
 Mon, 17 Sep 2018 05:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <7bc3b618ea90f3a2b7dcdbd269c23c049f4ded0e.1536969438.git.matvore@google.com>
In-Reply-To: <7bc3b618ea90f3a2b7dcdbd269c23c049f4ded0e.1536969438.git.matvore@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 17 Sep 2018 05:56:44 -0700
Message-ID: <CAMfpvhKEdtNUMnTa+Su55FLj30hmnr+KrxBtYAVjSuY1pX-Bpw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] t/*: fix ordering of expected/observed arguments
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 5:03 PM Matthew DeVore <matvore@google.com> wrote:
>
> This fixes various places where the ordering was obviously wrong and it
> was either related to other patches in this patchset or was easy
> find with grep.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
The clause about "related to other patches in this patchset is wrong,
so I've reworded the commit message body:

    Fix various places where the ordering was obviously wrong, meaning it
    was easy to find with grep.

> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1620,7 +1620,7 @@ test_expect_success 'show stash info with "--show-stash"' '
>
>  test_expect_success 'no stash info with "--show-stash --no-show-stash"' '
>         git status --show-stash --no-show-stash >expected_without_stash &&
> -       test_cmp expected_default expected_without_stash
> +       test_cmp expected_without_stash expected_default
>  '
This line should not have been changed, so I've reverted it.
