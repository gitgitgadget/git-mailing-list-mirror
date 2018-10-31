Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9594C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 11:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeJaUw1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 16:52:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42903 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeJaUw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 16:52:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id z20-v6so17244681qti.9
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A0FPyVZuygc0nS3GV6mJ1Uhin9PRYN4ExaaVkMocOCM=;
        b=LbQ2cQq93qdQj49HqjtqBnANfDMiAgK5mc66aIq0JZAthMITUA4yh/88NSHjHMQKLS
         Z6SAvgN+ZJs0cndHHljrC8iQ1YMMSiyeNffImsxEOAnnb5Dkw1rAR7QvVN6hyRbo3I8j
         HE+ruMHiFYw0FoqMh1QyBeDOJf+44r4vBOJMYAWUagABYbTmQWaqJpyzRiUeYGE2Pnze
         B9h1bmY0HI7WLnZthSdaPoLHsjSFtczNqYmZVrdasT9lFMf4280/UUiQRm1fliANxvtJ
         slaZ7uV0HHKArjKNX5kRSE6rp52L0rehZLHzbTwZzUWeoosBNjCkkQLwuD/M2gui9ttN
         JLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A0FPyVZuygc0nS3GV6mJ1Uhin9PRYN4ExaaVkMocOCM=;
        b=YB9y1+5vxw7L43Q+8738pl5ewvj9KoShqn6VQBnmUdPr9J3YoQ9sayU4Gp+kqL1bFG
         bx+Rlwe3BcL4nRRjsRGIDciEzTijosrso4+LoQbNDKltF/NnOO+iOqvLmssqFoRHPMSt
         7F70ICoG8SrG6DiqyE+Kbw2m+qboifqOmVI0XdCVd5EwSOhSS/ycxyyI+L0lZ323viS4
         XwSbCcMFHHEWqdAAqbNRaXWqwyq9WVixYE/krc+2MQuQEJJe4b/BJhHoaMxbbsp5VyKz
         9Hm8OzkYwUNvFKcOTdvZ18uLumws5+P8PV+Meb5PWTh/4p7Cy+xYO6WqdyHHBcr+6BwN
         VJ6w==
X-Gm-Message-State: AGRZ1gLLx4Y6v7eK0ZjXBdGem/7HCR460q1BQU8Eyddr3V2KgqD2KSH8
        9yWSvGEZelLrvnC1RAx+rCY=
X-Google-Smtp-Source: AJdET5dRyAAeEoZveS0ehwfKouR7MUAXqK88rtceEJzhRf4v08O8WbFrDPU/aGDGUllkMpxDeVSkHA==
X-Received: by 2002:a0c:ef03:: with SMTP id t3mr2247418qvr.148.1540986882823;
        Wed, 31 Oct 2018 04:54:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51aa:e8f0:335f:de7c? ([2001:4898:8010:0:3ae0:e8f0:335f:de7c])
        by smtp.gmail.com with ESMTPSA id d20-v6sm3014217qtm.49.2018.10.31.04.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 04:54:42 -0700 (PDT)
Subject: Re: [PATCH 1/3] commit-reach: implement get_reachable_subset
To:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.60.git.gitgitgadget@gmail.com>
 <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
 <CABPp-BHbOWXsnUSdcptyQ_Cn_PnqH4On+Q3zWNZQV4QHgYhqpg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d42eceda-0178-ce48-1ccd-7a1842e897ed@gmail.com>
Date:   Wed, 31 Oct 2018 07:54:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHbOWXsnUSdcptyQ_Cn_PnqH4On+Q3zWNZQV4QHgYhqpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2018 2:07 AM, Elijah Newren wrote:
> On Tue, Oct 30, 2018 at 7:16 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -688,3 +688,73 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>>          object_array_clear(&from_objs);
>>          return result;
>>   }
>> +
>> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>> +                                        struct commit **to, int nr_to,
>> +                                        int reachable_flag)
>> +{
>> +       struct commit **item;
>> +       struct commit *current;
>> +       struct commit_list *found_commits = NULL;
>> +       struct commit **to_last = to + nr_to;
>> +       struct commit **from_last = from + nr_from;
>> +       uint32_t min_generation = GENERATION_NUMBER_INFINITY;
>> +       int num_to_find = 0;
>> +
>> +       struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>> +
>> +       for (item = to; item < to_last; item++) {
>> +               struct commit *c = *item;
>> +
>> +               parse_commit(c);
>> +               if (c->generation < min_generation)
>> +                       min_generation = c->generation;
> So, when we don't have a commit-graph, is c->generation just going to
> be 0, making min_generation also be 0? (meaning we get no possible
> speed benefit from the commit-graph, since we just don't have that
> information available)?

If we don't have a commit-graph, then we can only terminate the loop early
if we discover all of the commits (num_to_find == 0).Otherwise, we need to
walk the entire graph in order to determine non-reachability. This relates
to Junio's point about in_merge_bases_many(), which I'll respond to his
message in more detail about that.

Thanks,
-Stolee
