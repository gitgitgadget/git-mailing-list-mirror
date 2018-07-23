Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28B31F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbeGWTYg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:24:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43792 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWTYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:24:36 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so1586269qtp.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/TjuROWhAQVgLktLA+T4BOezgAEAYx6A7fZQem5LwGk=;
        b=ibxeDs3YtemSTe+0KEpSWt/enPnjtjDQ1wS/28faW7pK26S+BnGAwMaWfgqptcetfO
         E0dmOMe7aGdA2m9oxARImWgIH6fTuraAkGGSSQ7Upmqm2ZlZaor5A5go1VVTUjScQMdn
         dzMQvKxh/ZeCsJ8wZaAhEQnWtJtdaUM7w8izqJbDD2pnqcCIqliKnuJE3jv+g8AjfkId
         kpleAbFKpaSIA1ndmYKPsfp/0IZyFBoLbvlT44gx9U/ZdSRNWCBOT9cZlBd2ILqJKYOl
         dp5TzgDszVRcXhs3HXUXnT7N36b4fikUMTLO0hDzcxfyFJN7Z01vryJV5hXevroOcD+a
         wf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/TjuROWhAQVgLktLA+T4BOezgAEAYx6A7fZQem5LwGk=;
        b=YS//iSQyUuscF9DvtHWPeQiFHIJ8ZSZLGxQOT+negJn5pAt3uxqshct0OgI/9WJPc5
         lQ1gyoZq3STExoDuCP7qi7pnBeInp1uI82uGeoFaZF/a26CW0aGfJZaf2CegllZd8xMd
         AopSkDT2ztdj5RyyOPYmmuQS3zou4TV2NO/MqK/dCzVu2ncdydpUZ/Ae8TBeA3EyKNwS
         Peizzs81SPfUBhZuRVCgSFSMduqBWlxvdC8c5i1DiTlPK/onj37ZYoC7yvRcrwNg+ImG
         Q1ED0RXki3hDjFvYL03b6L4c/1eYwk/nNIQ+G5Gs5lsRMDa3V+re+1PNTQv0LAav4S3C
         IQsw==
X-Gm-Message-State: AOUpUlGmtwNmscy4SErmdGvUkYCshpJnEtTvRT/qWdHrshuRiAS3e2pA
        wKboGWRMyRVC1KKug7tIkzI=
X-Google-Smtp-Source: AAOMgpfX9bCO+s2aTT/18v8mv2BQ648HIUmnLujr7nGqxyqNyIO+0+zDBnXleZ3+8SfKRN9ShMBCBg==
X-Received: by 2002:ac8:2798:: with SMTP id w24-v6mr13262172qtw.51.1532370128383;
        Mon, 23 Jul 2018 11:22:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id v71-v6sm7394924qkl.42.2018.07.23.11.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:22:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse
 checkout
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, kewillf@microsoft.com
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
 <20180721063428.20518-2-newren@gmail.com>
 <CAPig+cTjQ74gOt8gJbYUBaTRsHBvqtcmucoVdiudFt2TrhCn+g@mail.gmail.com>
 <b56598a1-e543-500a-a39b-cee07fe1e533@gmail.com>
 <CAPig+cR3ic5OAAhNNaSu3YXMnpm=zw6XjspYSU4jouH6po05gg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <795b0bbc-c9d3-f627-4798-80d0e25bfade@gmail.com>
Date:   Mon, 23 Jul 2018 14:22:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cR3ic5OAAhNNaSu3YXMnpm=zw6XjspYSU4jouH6po05gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/23/2018 2:09 PM, Eric Sunshine wrote:
> On Mon, Jul 23, 2018 at 9:12 AM Ben Peart <peartben@gmail.com> wrote:
>> On 7/21/2018 3:21 AM, Eric Sunshine wrote:
>>> On Sat, Jul 21, 2018 at 2:34 AM Elijah Newren <newren@gmail.com> wrote:
>>>> +       rm .git/info/sparse-checkout
>>>
>>> Should this cleanup be done by test_when_finished()?
>>
>> I think trying to use test_when_finished() for this really degrades the
>> readability of the test.  See below:
>>
>> test_expect_success 'failed cherry-pick with sparse-checkout' '
>>          pristine_detach initial &&
>>          test_config core.sparsecheckout true &&
>>          echo /unrelated >.git/info/sparse-checkout &&
>>          git read-tree --reset -u HEAD &&
>>          test_when_finished "echo \"/*\" >.git/info/sparse-checkout && git
>> read-tree --reset -u HEAD && rm .git/info/sparse-checkout" &&
>>          test_must_fail git cherry-pick -Xours picked>actual &&
>>          test_i18ngrep ! "Changes not staged for commit:" actual
>> '
>>
>> Given it takes multiple commands, I'd prefer to keep the setup and
>> cleanup of the sparse checkout settings symmetrical.
> 
> Some observations:
> 
> The test_when_finished() ought to be called before the initial
> git-read-tree, otherwise you risk leaving a .git/info/sparse-checkout
> sitting around if git-read-tree fails.
> 
> The tear-down code could be moved to a function, in which case,
> test_when_finished() would simply call that function.
> 
> Multi-line quoted strings are valid, so you don't need to string out
> all the tear-down steps on a single line like that, and instead spread
> them across multiple lines to improve readability.
> 
> test_when_finished() doesn't expect just a single quoted string as
> argument. In fact, it can take many (unquoted) arguments, which also
> allows you to spread the tear-down steps over multiple lines to
> improve readability.
> 
> Multiple test_when_finished() invocations are allowed, so you could
> spread out the tear-down commands that way (though they'd have to be
> in reverse order, which would be bad for readability in this case,
> thus not recommended).
> 
> Correctness ought to trump readability, not the other way around.
> 
> So, one possibility, which seems pretty readable to me:
> 
>      test_expect_failure 'failed cherry-pick with sparse-checkout' '
>         pristine_detach initial &&
>         test_config core.sparseCheckout true &&
>         test_when_finished "
>             echo \"/*\" >.git/info/sparse-checkout
>             git read-tree --reset -u HEAD
>             rm .git/info/sparse-checkout" &&
>         echo /unrelated >.git/info/sparse-checkout &&
>         git read-tree --reset -u HEAD &&
>         test_must_fail git cherry-pick -Xours picked>actual &&
>         test_i18ngrep ! "Changes not staged for commit:" actual &&
>      '
> 

Minus the trailing && on the last line, that works for me.  Thank you - 
readability and correctness.

> Notice that I dropped the internal &&-chain in test_when_finish() to
> ensure that the final 'rm' is invoked even if the cleanup
> git-read-tree fails (though all bets are probably off, anyhow, if it
> does fail).
> 
