Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4597C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 19:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354008AbiFUTeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353555AbiFUTeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 15:34:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D821265
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 12:34:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l24so2799112ion.13
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=tKXkzh5PbNFgeAy7KOjkhBUqi0uLgrABpfSypdkBBKI=;
        b=JjkXis6lq2YoIGR6pEYcWBjIboT82cP9RT29vulAG8kb71S7QQIcPnXtQFStufK0Er
         FSjn7tEhhNg7uRRVweu8DUD/9pevOAYJ0rK3s8Jhmos4vhU/SofLTtAxT/Uus6jpPgLw
         7yoL/XnPrEhnH1okKxmTcx7hpuUuwOuxPtK3S06K4ULvyR7FvffZgQ6axxCMOFRxeb/T
         ROYZ0UTi9txWkfuJUH99OqZl6ASm33qXOBAQiHnOvWSsPjhpZZoeVDamVtetnMYpPHJJ
         XBQ9fTi75F5+wrfgIu+e4qw+r4SiI20ExDrCf6cX2t7Y1sxVnX/OWVclwXxoQdm7g4qp
         qTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tKXkzh5PbNFgeAy7KOjkhBUqi0uLgrABpfSypdkBBKI=;
        b=BJt5dFt3Jx9U0sYAaaZxqpWBrlbPiPJ+Y7HUskrfXEi+NLg1OSGpnQuiROJMYqnie/
         vXQFk/1mDHyiWBL85mQJynf6c4tocDrGqH0a7Ke32hVXq3VaOWerhkodUhXLKuwzIRh2
         hQeD263WsmCQoOTu+Rb0NwbT5Slc5h2rjqPB/SHkyzBmJq40OJGWzmGRxq0GiG2gGMmO
         AKlpB2bQ/57Zi55ZF8+HGRrOKmxG/NMbCMeZWoU8RAc+UwPAjmtsFSVWR3EJekm2AUfm
         LoqTHUncJr/jQIm/XI1itDOaSMqwnxTdodCYvEniVf59gXrNQF56GS1EvhpYkcEgeOKW
         YlLw==
X-Gm-Message-State: AJIora/skS3JbHuqmcbRopvW30Pqta0YF/4S0xyC8Ij1Pbfx0QTX4ad1
        jfUSrgwxBwD2LV+RL0kp0M6Y
X-Google-Smtp-Source: AGRyM1tdX1nfFm2tvgQ/kBLqxSui7AZxF1GXU204UUWafIyKHYlJytdL4MPv43UucNd6te6ERKPuFg==
X-Received: by 2002:a05:6638:14cd:b0:332:56c:3524 with SMTP id l13-20020a05663814cd00b00332056c3524mr17628458jak.159.1655840056816;
        Tue, 21 Jun 2022 12:34:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:44d7:1b01:4339:1df9? ([2600:1700:e72:80a0:44d7:1b01:4339:1df9])
        by smtp.gmail.com with ESMTPSA id u10-20020a92600a000000b002d54d827007sm7806602ilb.17.2022.06.21.12.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 12:34:16 -0700 (PDT)
Message-ID: <d4427adf-e3ef-a5cd-3016-687004dc5ae3@github.com>
Date:   Tue, 21 Jun 2022 15:34:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
 <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
In-Reply-To: <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 3:46 PM, Derrick Stolee wrote:
> On 6/6/2022 8:33 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

I'm finally getting around to applying the recommended changes
locally, when I noticed...

>>> +   present in the client repository. If some are missing, then the client
>>> +   delays unbundling until other bundles have been unbundled, making those
>>> +   OIDs present. When all required OIDs are present, the client unbundles
>>> +   that data using a refspec. The default refspec is
>>> +   `+refs/heads/*:refs/bundles/*`, but this can be configured.
>>
>> The refs/bundles/ appear in the document only here, and it is
>> unclear why we even want it (I am assuming this is against gc while
>> "git clone" is still running) or how we are going to retire it, if
>> ever.  If there are multiple bundle files involved in this "git clone",
>> to anchor objects that are necessary against "gc", don't we need to use
>> refs/bundles/<i>/* or something like that, where <i> is uniquely assigned
>> number locally?
> 
> The real reason to keep them in refs/bundles/ is because then those
> refs can be used in the incremental 'git fetch' after downloading the
> bundles (in perpetuity) while not stomping refs/heads or refs/remotes/

...I completely ignored your "refs/bundles/<i>/*" suggestion, which is
an interesting way to allow dropping refs from this space, allowing GC
to clear up space over time.

I'm making note of this and will include it as a potential way forward
(while I also think about what the implementation would look like).

Thanks,
-Stolee
