Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4870A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeGPTnj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:43:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45156 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:43:39 -0400
Received: by mail-yw0-f193.google.com with SMTP id 139-v6so14572094ywg.12
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8BCDicuLZq19vC83698Txf4J/v3ya5xXzUHf5ln+ho=;
        b=UpA8bnqrWGQCMmZOGwL6HP5Ic9F9Q4xQZB3ENU9AeEPDemKg3B3QyYJPljW+grsH3s
         GWjE9EhF5agtFaX+al8i6Y0O1BQjBeY39QVmAc7wxXUs3IosJqG89kStnt4g0Pri9YO7
         LAK15WY5y0NQP2aZk+7eaPgrrriz2oTXG34kpGqFvO9Snr7XW1+ij1jrjB39V4WBvVn6
         MWIC5WRkZTnAAuZur1im36924hsgTpf5wSg6gaK+5mY8huWMSgerep7iorctcXI05XLo
         hHgjzl2qR3TWV5F62vXzNRr65TlOzc8ictvQ5HhNSP23iSIiMjuduc2g4YXg2c+zctHN
         kU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8BCDicuLZq19vC83698Txf4J/v3ya5xXzUHf5ln+ho=;
        b=DdJbyZlFqTpBK3+Q18TJUjEvzB3pbCkfFVNFJflR346yZqpziNtceOo7zfCj6Uzr8Z
         p4qYjFW6+J4m0cBtNVKDR37hT0L2Bx+2yjCcnSInMSl+wpMoUUJp+L24VzYGO3BVe7QD
         UvocH/T4Mzn8GTvddW3bABp/d4b/6uJOFPLDFKDZ7wjSl3FYoHa/mUzS2NO9OH7V1M8N
         ujbwwWRF9Sqp3Me1GdEot10xI4h8uMY3x3Xmhm7ZwF9Ptp3FZe1gdCwM9fiCwJRl//JR
         lj9rY2LLrj1OabhE6cgfjMGcWKFAEFCV4z8xWQl56gdw48I7jKb9JwJHIZWy6J+S8UOz
         P1Kg==
X-Gm-Message-State: AOUpUlHrw6IKeQXXfnnjX676YegBNNRoHG2pGdQY7dOl60s8UX1VMHyJ
        TcIfE6OgFmBgREVi2oIstEx8DvBkpTd3w2n6XFmqdw==
X-Google-Smtp-Source: AAOMgpdtUk9HVuqVXaYY2YPjGq8NCO3ii7M+owHT0xuHInTTTLO3S9gLswIKqIXH+du1ExfTjciQro/5RxI3kRsO4gM=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr6787346ywh.238.1531768490814;
 Mon, 16 Jul 2018 12:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <b9687d2b21c4560178a509572770e3a058582a8b.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <b9687d2b21c4560178a509572770e3a058582a8b.1531746010.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 12:14:39 -0700
Message-ID: <CAGZ79kY76rnp8VEBjzfcZ+kB7JWh+5urASWdAGkYejwGY21QJQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] commit-reach: move commit_contains from ref-filter
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +
> +int commit_contains(struct ref_filter *filter, struct commit *commit,
> +                   struct commit_list *list, struct contains_cache *cache)

[...]

> -
> -static int commit_contains(struct ref_filter *filter, struct commit *commit,
> -                          struct commit_list *list, struct contains_cache *cache)

All moved code, but this one, which was exposed to the public.
Might be worth calling out in the commit message?
While exposing it, it is a good idea to question its name and if
it is good enough for public use (I think it is -- despite not understanding
what the function does by its arguments; so bonus points for docs!)

Thanks,
Stefan
