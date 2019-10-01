Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249F61F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfJAS3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:29:03 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37948 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJAS3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:29:02 -0400
Received: by mail-yb1-f177.google.com with SMTP id x4so1557116ybr.5
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZyt9HvMQC+GF1oRtPQl4uDuwJqwMVjFUAkDx5BNewA=;
        b=nKtAQK6uPOZnNYLlqNT9kxHfzNeR9hUkYRTrqxYGp2egc2UmRF+F+3Xd3hS0sxSZCC
         eEmGvhOmJrWOYH7krJeSlUjkOuM72wceeqL6AuUdn7JtHAH/5Qnn4udUnM45Rb9FwX1j
         wCZAnZBeX40Vsz/YhhxKZr0WUXYbZgw+FbJwZRkXSNqhnbAxhbYSTXPlUndcjIW02wgd
         R48NkL7mXN2aHksUmJK8FUHX8gOeUhk+o0qVILnqEjPeHcaB85zpTtLTGh8W4mO8gice
         uqYNBMFTlWbPP9D+2B94jgC3RD22aY1dJtAXdiwo9MvSGRDfof9yTHX7mNwXynUYmR6D
         6gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZyt9HvMQC+GF1oRtPQl4uDuwJqwMVjFUAkDx5BNewA=;
        b=UN6LNFBDErxIwIczOaKLCFkFS1q6bqCfnk2JUTnWyEiJyWw0iHoyPZ7M2YcVxe23zX
         BLHnNj7Tj1O5rHeVw/Jvsh4Q10pojc0qiBCOc6BwXgMVkT7N3RNT02VABqIQuPo61edR
         9gy0lm4e5G6HWl4WfBw94Tx2T91df9Wn878CLWKG51uSma9OF6rJdz7uTPhb9ZMrKw0s
         VZb0CnY8+AvaybTaJVJACMgA6YBL/1O3j0R4kPB0VP67xjKiENJ5TFfuqoUzNAaqBN3X
         MnZ58V3SpTQiobs7mINsBsTUG56afyNVXhcCVU6yU44DN9qQA8QhLn/1coVMysAb+Xfq
         nJ3w==
X-Gm-Message-State: APjAAAUbZHpw/wP/v7zWfbXBew/yT20lWQNIRhHuesgk9YKzzJo6HJu7
        FS7PiBiuId1n4P7MWwUPqRjqyFW/EUA=
X-Google-Smtp-Source: APXvYqwvBFxyNt2N8Ki5Xe3sci+UoS+p48zdIPm1chEjYMOA1+/g54NbySV1qkvHawm41JHcVSfbpQ==
X-Received: by 2002:a25:db90:: with SMTP id g138mr18404014ybf.326.1569954541675;
        Tue, 01 Oct 2019 11:29:01 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 83sm3859773ywd.51.2019.10.01.11.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:29:01 -0700 (PDT)
Subject: Re: git-grep in sparse checkout
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com>
Date:   Tue, 1 Oct 2019 14:29:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/2019 9:06 AM, Matheus Tavares Bernardino wrote:
> Hi,
> 
> During Git Summit it was mentioned that git-grep searches outside
> sparsity pattern which is not aligned with user expectation. I took a
> quick look at it and it seems the reason is
> builtin/grep.c:grep_cache() (which also greps worktree) will grep the
> object store when a given index entry has the CE_SKIP_WORKTREE bit
> turned on.
> 
> From what I understand, this bit is used exactly for sparse checkouts
> (as described in Documentation/technical/index-format.txt[1]). But
> should we perhaps ignore it in git-grep to have the expected behavior?
> I'll be happy to send the patch if so, but I wanted to check with you
> first.

Is that the expected behavior? In a sparse-checkout, wouldn't you _want_
Git to report things outside the cone? You can already use external tools
to search for things in the sparse cone: they are on disk. You need "git
grep" for the objects reachable from the current tree but not already
on disk.

I respect the goal to minimize the work "git grep" is doing, especially
in a sparse-checkout + partial-clone world, where we wouldn't expect to
have the blobs locally and this search would cause many blob downloads.
I just want to truly examine if this is the right behavior.

At minimum, I would expect a new option to have "git grep" go back to
the old behavior, so users who really want a tree-wide search can have
one.

Thanks,
-Stolee
