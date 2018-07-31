Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B3B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeGaTWB (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:22:01 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41221 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeGaTWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:22:01 -0400
Received: by mail-vk0-f68.google.com with SMTP id o82-v6so7930929vko.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7XW1ThGu1vjCaRu4yV4rdIRdoMBurzZS7OBBRxqsB2g=;
        b=glX9YKzmQMCVPIXgRtDulrzMq9M/tPcgLVAftwCMdfqufU4r1rP8Ofxw07RfWJW9wc
         HtLyudyBIn4txj8mgO76TfWMXkhtGm8QOAiZcBelQ/N5PIuXEJVg5wBvjV1THkMjmmqN
         qLimdsrm54iJNl/JeEop19Svtnx4b3cvLEW4ht0TPIJ44yqwlx5w0ZmYHGVSh5PoHHrH
         RCRh1BR9BymQn2T9bwxBsEXo1ZunCYM63ItMPmoinf/TR9ECkX5eM8EwXVwAGrvUhWRN
         uafEy1zXKxyy9ri2bcwKuKOfc6nfb0//h+DQco/TJHyv1f1OM8v1nwnLzKXqW2kkr+r1
         rjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7XW1ThGu1vjCaRu4yV4rdIRdoMBurzZS7OBBRxqsB2g=;
        b=r9P9CWdthW4Rn0dfAeoEw9KhuPay+8p+pqFm0quzHxnHrOXz6fDHlG6jOMD96jjCq4
         ErsMYTa0pUmMnSAEYzYGFHUtoYf4+MqEyWJo4dJT8Ca+gHOIO/+DNl18EdPtaRvcY6EX
         6B0OoGxq01gq6H5SyUdZyjto8W3bxszNDKocF56baFMkZafAVyOcYeKfqM7EsuTOj2BK
         /uZiMzSpU45oBjYzaMu3Jf+9eYiXsSKj8I6kh+bml6G7Ob/iPHEzl3Hgj/c6GFYevDdV
         bwuIeWh+V/eFzxgmdC9VM/0xk9nYkvxvk2eolVgI3+wBwWGf/2IHfoi23zyZXfclaAuw
         A8Ow==
X-Gm-Message-State: AOUpUlHrqmxC5eg79G9e5BYZ0Y6IhZWCKp5j68sqDchdHpBqkrwi5Mtt
        7rHzB7zoXiqWwM2MIzMMwZeDk8WSNLcWn86hr6ig7Q==
X-Google-Smtp-Source: AAOMgpfXb9xA9otV7w8gHjyAowFdGnmGMeOqcsEslYmWxSQkVMbXbYPtIia0WreX8Rq51i2DcxuOBnfkcojBUsN0vkc=
X-Received: by 2002:a1f:f284:: with SMTP id q126-v6mr13902864vkh.38.1533058838448;
 Tue, 31 Jul 2018 10:40:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:40:37
 -0700 (PDT)
In-Reply-To: <20180718152244.45513-1-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com> <20180718152244.45513-1-dstolee@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Jul 2018 10:40:37 -0700
Message-ID: <CABPp-BHPXG7M682haJgia2RYK5Sc3MYkcQxeBOLaRSbEXoLbUw@mail.gmail.com>
Subject: Re: [PATCH] DO-NOT-MERGE: write and read commit-graph always
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 8:22 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> The following test fails because the repo has ambiguous merge-bases, and
> the commit-graph changes the walk order so we select a different one.
> This alters the resulting merge from the expected result.
>
> t6024-recursive-merge.sh, Test 4
>
> The tests above are made to pass by deleting the commit-graph file
> before the necessary steps.

I know you meant for these to not be merged, but perhaps the test in
t6024 could be made to be less stringent about order of merge bases.
In particular, instead of expecting a certain sha1 to be at stage 2
and a different one to be at stage 3, it could just check that both
shas appear in the `git ls-files --stage` output.

> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> index 3f59e58dfb..cec10983cd 100755
> --- a/t/t6024-recursive-merge.sh
> +++ b/t/t6024-recursive-merge.sh
> @@ -61,6 +61,7 @@ GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
>  '
>
>  test_expect_success "combined merge conflicts" "
> +       rm -rf .git/objects/info/commit-graph &&
>         test_must_fail git merge -m final G
>  "
>
> --
> 2.18.0.118.gd4f65b8d14
