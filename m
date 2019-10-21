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
	by dcvr.yhbt.net (Postfix) with ESMTP id 133541F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 12:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfJUMKo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 08:10:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46400 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfJUMKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 08:10:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id e66so12298652qkf.13
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AZg9PA4+WXYBM8hDv9ZvTkuGQ6MkNVyi1oOAwtIOnQY=;
        b=AwvDfWK/jugO72VvR3q2Cw69qvNfNSFH3EBZdVeddKiD58P+M51/B82CvTIOPCYedu
         4LhcICDoDx19ENV5Tu14mgy8AGjNhhlu8T3yqqtSxCk8TKq8zPAvVypGvPzOtxe7azds
         gtU3w8QdXPjWuGnFswKL62AWonMyImDYaDn2uKtfRvmXXPzux8ttfHfWFLGfb7DXXyyH
         R/W1SPymkfyzuidoUzdQIGw16HrppURzxZ4FSQ33LeHewewJ3BXx1RHZstSBTkCfBLG1
         nW1CE41jW25d8Ur8gVy6TmQ3tw/o7idvq2cmw74hsk9fleGZFM/Q2Yfq7snFAeq426q0
         SIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AZg9PA4+WXYBM8hDv9ZvTkuGQ6MkNVyi1oOAwtIOnQY=;
        b=XUgYtmCy4/oGjMF7j6PNmWg5I2XV2ZOj1FC9RTroA8S2WU86V0WBbmuTwkQUgyKznh
         PnNzGHsoIODyiITGYMhnB1bedVbs0Komm1obskLDfRO3R/fXQij/GxgcbzY/GMdjCRXF
         4Wl9BgnFFyBS2Mpyzn9UUUrEt0221om5Df4+DudClgDVguxPLIa77HPw6bt/DCgN4xXK
         sk6Ulwc1PXSjX6q3ZT2OX6zLYglT7TzFNRCAFFmO+ApKGlWcf2ZdvuhG54YrbgdDX+OW
         OWYl0r+2+T6k7KeUgUxBT9fKZ22fWdZmHDUQnNI5/M87gl4PDY/hSJyiSHFs8uH63b9m
         gKIg==
X-Gm-Message-State: APjAAAXVXgVFhcjVFePtzGf5ec9Ot+WV7B2wO6j2JSyb1+q/CPvPPirP
        1yL86p606+WjxG5jMq9yM9w4TBdCibs=
X-Google-Smtp-Source: APXvYqy4/6PIUpmhD9P6Jh4lTABgWzKiOxE+KkxTBPzFwg3Cv3KIF3zbOM50q3uzeSs3keIri2u9og==
X-Received: by 2002:a05:620a:1123:: with SMTP id p3mr20964479qkk.6.1571659842699;
        Mon, 21 Oct 2019 05:10:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1010:f14d:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id a9sm7983639qkb.94.2019.10.21.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:10:41 -0700 (PDT)
Subject: Re: [PATCH v4 01/17] sparse-checkout: create builtin with 'list'
 subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
 <CABPp-BEryfaeYhuUsiDTaYdRKpK6GRi7hgZ5XSTVkoHVkx2qQA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01f02ca8-00a6-6b48-1cc5-345547c2d5e4@gmail.com>
Date:   Mon, 21 Oct 2019 08:10:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEryfaeYhuUsiDTaYdRKpK6GRi7hgZ5XSTVkoHVkx2qQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2019 3:00 PM, Elijah Newren wrote:
> On Tue, Oct 15, 2019 at 6:56 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +DESCRIPTION
>> +-----------
>> +
>> +Initialize and modify the sparse-checkout configuration, which reduces
>> +the checkout to a set of directories given by a list of prefixes.
>> +
>> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> 
> I think the wording needs to be a bit more detailed; you copied the
> wording from git-switch.txt, but usage of git-switch is not expected
> to modify the behavior of other commands.  sparse-checkout, by
> contrast, is designed to affect other commands: at the very least
> checkout & switch, and likely will affect grep, diff, log, and a host
> of others.  Perhaps something like:
> 
> THIS COMMAND IS EXPERIMENTAL.  ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
> COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
> THE FUTURE.

Thanks. I was taking your comment to mean "this builtin is experimental"
but what you really mean is "the sparse-checkout feature is (still)
experimental".

-Stolee
