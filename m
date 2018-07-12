Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB281F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeGLRyH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:54:07 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46250 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeGLRyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:54:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so9331223qtn.13
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=lKV5MujpvqAiT0R7OYSni6e4oMK7hn8d8LToTt47OxU=;
        b=cN2iR52Os+oTsTqROyGTyxBExxC7ssqR7XuGUDhm0KmNtayFR4W82ufUKBdRNuKTUj
         B7S681qB+4dBTB6kOLh61OWMhTI5e7qg91ZLOLZrL8bYAlQ/flx4bNMtWdm+fgp7+iwb
         xDJCEfvIFVfdHZmRhnrKf+yrTrpWwSp1nWJXhTiu5JSzMd/3G8oXwLRqUmWPcSD0sHyB
         slJfuqFbuziZcbJN84crhPpu1GBJwuRVW1RFtnbeFDoxAJ2C4h6ir3Dm9k2nIZaMJeLi
         82BcEaDqTHZXj58E64AHQzGueEQAlmGPDUSRLcMEVG4Gw0AjAtLENQG33UDeegMlgweh
         +oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lKV5MujpvqAiT0R7OYSni6e4oMK7hn8d8LToTt47OxU=;
        b=W6gn+1oXfV+pYKTxPufiiHHfk37Tq9Il8XGrfLKlhde8uju9WbDw5cdbh5dfDxsh5L
         c6uZV3A1lam30JdZ9GgLZ2Vu/NnTJxz34tW/2hhdcA1ggv1b3xpKDyVm8roVgAoUrbCB
         1Wv5fnV4oCfr6H4TRAGMTwEWCVMud4Zhyo9E791DQbeBmU9KYn4eQWaPc3/CLZWzIu2b
         d74Vu4hSlJMCZ6eLRnEWLO5IJuYplL8HutdSrpwF9nvvAC7qnmzruJAW9PnHpY3Omj75
         wKtMxMQmyTnZvqndND7To3fZD0tFkYNzMB7NHskhEy2GaHncQpI8e955YOY2xF2NVRbZ
         /GyQ==
X-Gm-Message-State: AOUpUlEPo/hHhFrOeIiA0Ef1uaRyMpVfgbt5UmKu80ppcFu+e1boqxS3
        pK1xJpAaNjjJTiNfv1ylWECmm7fu
X-Google-Smtp-Source: AAOMgpdu8nX4xA9ZCxfpXCbT6l1BRYxSarXpsqgmKlkYIznerPhYdc4GLjGLlgSta6DIb1k07YPo8A==
X-Received: by 2002:ac8:3579:: with SMTP id z54-v6mr2670735qtb.161.1531417411952;
        Thu, 12 Jul 2018 10:43:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7999:2a5f:44db:50fd? ([2001:4898:8010:0:62cf:2a5f:44db:50fd])
        by smtp.gmail.com with ESMTPSA id g39-v6sm2552883qtb.47.2018.07.12.10.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:43:31 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Object store refactoring: commit graph
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531348540.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9d9df97-c950-fec3-83dd-aed32441dae0@gmail.com>
Date:   Thu, 12 Jul 2018 13:43:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/11/2018 6:42 PM, Jonathan Tan wrote:
> This is on _both_ ds/commit-graph-fsck and sb/object-store-lookup,
> following Stolee's suggestion.
>
> (It also seems better to build it this way to me, since both these
> branches are going into "next" according to the latest What's Cooking.)
>
> Junio wrote in [1]:
>
>> I've added SQUASH??? patch at the tip of each of the above,
>> rebuilt 'pu' with them and pushed the result out.  It seems that
>> Travis is happier with the result.
>>
>> Please do not forget to squash them in when/if rerolling.  If there
>> is no need to change anything else other than squashing them, you
>> can tell me to which commit in your series the fix needs to be
>> squashed in (that would save me time to figure it out, obviously).
> I'm rerolling because I also need to update the last patch with the new
> lookup_commit() function signature that Stefan's sb/object-store-lookup
> introduces. I have squashed the SQUASH??? patch into the corresponding
> patch in this patch set.
>
> Changes from v2:
>   - now also based on sb/object-store-lookup in addition to
>     ds/commit-graph-fsck (I rebased ds/commit-graph-fsck onto
>     sb-object-store-lookup, then rebased this patch set onto the result)
>   - patches 1-5 are unchanged
>   - patch 6:
>     - used "PRItime" instead of "ul" when printing a timestamp (the
>       SQUASH??? patch)
>     - updated invocations of lookup_commit() to take a repository object
>
> [1] https://public-inbox.org/git/xmqqpnzt1myi.fsf@gitster-ct.c.googlers.com/

I re-read the patch series and think you addressed all feedback. I have 
no more to add.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

