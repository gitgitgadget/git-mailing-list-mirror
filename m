Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7173B20A41
	for <e@80x24.org>; Sat, 25 Nov 2017 22:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdKYWfx (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 17:35:53 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:45434 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdKYWfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 17:35:48 -0500
Received: by mail-vk0-f45.google.com with SMTP id s141so9571386vkb.12
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Hd6dehQyySTPtjp0ekY7eCKNM+SLA0YPHDp52YDC4c=;
        b=W/IvhD0i1tY4mZpMgDfvaUlCLBAyitPNje2yriIPQBW9Kv9ve53Vhl8g6WR1AckFJw
         8CkCqfw9bC0DzvE9052UHtogKzCbt4fgjPOp1AVy+n0SDIKOTO7GSDFisVv0Fo8wMaqh
         Mecy/hGN0GMvTF86XUpC/lEhomTbo2QYOcChe3swFDXLNNgVhWg1/eEkj2c3StzFJwQq
         hjaA1V+z4cqBo2Bkzh3AUs1R0hLMJ88F0Klk2pRK6oVd8SKHcV/cPS0uO8W8ygZ9NsnA
         WMKUSXbTNf2zOMGFpinyWeeX6j0gLxlMhgJGYIYbJSt3WAA1oEVxeTPBSUfU06e/pPJ8
         zkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Hd6dehQyySTPtjp0ekY7eCKNM+SLA0YPHDp52YDC4c=;
        b=PbMvJQk5Krm8VNEA+LH7DB+cTubGiry8eQxmL5mwneY2gZmcKmotRJUSokO10Vh78a
         TlesXNSJkHvpQAjK5TQJWOCmEuKmCHSKC0lFR5N+B/N9nMVXBligJnsFNwOvuA2GQDSv
         rEIbU6MraEoyksVt0F2pvuuwlcwxBBnNKBbUI09j0AV22EiqUM+EnRoyODN4nWmox0mT
         Ze9OCt8ZcQ3VOwTue30yS5ozC9hYXziMeV9RV7Ke7jiwUhC7rZKdO2G/YdYGQHNh3VHG
         wUPystdAnP8m1Um4OCxg7XP/m/n96FDjRG9Bn/shlDOZM1Xnkc6bgHu4U5bHiH6Uf+l6
         959g==
X-Gm-Message-State: AJaThX6khXxv2e14D9Z6TYcGOM0Za5ytkMIti9yyYctrpRUYOWD0VjFj
        MWbz6rc7ZogWOElIC5UCTUQ9W9gN8ZGN8xFluZM=
X-Google-Smtp-Source: AGs4zMaoke0ya0bmDEHZoNLYCefchsjL9AA7l/3fCzbZ5GArwzq7ygQc2SaOxBDZ/C9h7Lsg6vHVYuhL6kOLDOuTr2o=
X-Received: by 10.31.125.75 with SMTP id y72mr23717479vkc.79.1511649347396;
 Sat, 25 Nov 2017 14:35:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Sat, 25 Nov 2017 14:35:46 -0800 (PST)
In-Reply-To: <xmqqd147kpdm.fsf@gitster.mtv.corp.google.com>
References: <20171124195901.2581-1-newren@gmail.com> <xmqqd147kpdm.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Nov 2017 14:35:46 -0800
Message-ID: <CABPp-BGcfFOvv+-uW2_EaftLiU-xs_D4g8hsYOZqjk1XwK_8Fw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>     But what it really is forced to do is more of a 4-way merge; a good
>>     chunk of its annoying complexity is based around this (undocumented
>>     and unfortunate) reality.  It derives from what I consider a simple
>>     design flaw.
>
> Yes, and it does not help that it wants to write into the filesystem
> while it performs the outermost merges.
>
> In the ideal world, we should
>
>  - ask unpack_trees() to do "read-tree -m" without "-u";
>
>  - do all the merge-recursive computations in-core and prepare the
>    resulting index, while keeping the current index intact;
>
>  - compare the current in-core index and the resulting in-core
>    index, and notice the paths that need to be added, updated or
>    removed in the working tree, and ensure that there is no loss of
>    information when the change is reflected to the working tree,
>    e.g. the result wants to create a file where the working tree
>    currently has a directory with non-expendable contents in it, the
>    result wants to remove a file where the working tree file has
>    local modification, etc.; and then finally
>
>  - carry out the working tree update to make it match what the
>    resulting in-core index says it should look like.

I had another email I had been composing to try to argue for changing
merge-recursive.c's design to the above, assuming I could get the time
to work on it.  Nice to see that I'm not crazy, and that I apparently
don't need to do much convincing.  :-)
