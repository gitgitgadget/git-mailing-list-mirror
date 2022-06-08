Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F522C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 14:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiFHOcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbiFHOcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 10:32:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32722939B
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 07:32:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso11182412wmn.4
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PtZp7NTKLh/MEdUyjo8d5+jlL7K1cjMwwlm1SRU23Vs=;
        b=FVOlivnhzp/QbfPaKRTOFQ2vJtfLwfGgrm1FTKZ/FciR4J+ENlFoP9ycekr5Etv8c1
         T4sRix0bUpy0UUZxtMn2THGNWfqGh29e4EvSWKYlHLzogiBlVEalim1/r0ZyVynElyL8
         Dlg2NxbM/mbzaO0DbNlvZn+MCSUF0Sc9hpXLhryFdUR+6II/Z5q0BzjUsEgdfn31fqqc
         E9swS/snxS5kNDRI98etV1yWW7r6AO8CYJgRH6fXkdoL8iG/KmmVy8N2iFm4Bz64oqJD
         hIw/D0+irgiWSuZZP6cqb3xF1ApJG8kbHK9Pw81X5zJkOcLGAbB27S13XsO5XzBneHDW
         hqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PtZp7NTKLh/MEdUyjo8d5+jlL7K1cjMwwlm1SRU23Vs=;
        b=S/gSb3dZvllHvXWTldA7Tsimd9M3xAaFyW7flOTcaG9MUl3SlYSa5LNY9T3mRyeZce
         A7fhm+tb66YNb8Hwy3blP+k2AM5W7HahJ8B3iHFe1RrGZRD6pc1frFipztTmMQZ1pbVZ
         I/8wHK05gQqxo8UtgNtP8X40GRu+mfvoioBFW5DQJxF8bb2FVCP7EP2BxA8ipgHaxZN7
         MJFGhQsq7YSrXLdUXDuJVE8uvRaskK2pJcvnnFSl0Ky+Xugd5WvjamREfU94+/34fs0L
         1DB5OnEoH3pAvhRR7L8FW8yDLwsVxnaciiYnqDZN18eKB8TFdyzjg5F/wy0bTZl4eSYB
         28Dg==
X-Gm-Message-State: AOAM530FxVTiSBrgYlTmdIvfZuWES2TharkxE6ZxxHcE/RTz5HmWNKVR
        0OpJil97NpGejLVjBr2ub14=
X-Google-Smtp-Source: ABdhPJyHNmJRNLQfLFvW711LNjUm8CZcikMDBgtt+yKeRFpU0vVC66Zpf3W+CRFlU33CJCRkR9L5TQ==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr615081wmj.113.1654698768589;
        Wed, 08 Jun 2022 07:32:48 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b0020c5253d8c2sm21105259wrn.14.2022.06.08.07.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 07:32:48 -0700 (PDT)
Message-ID: <ac135ece-a901-5868-f28c-2161d7a62e97@gmail.com>
Date:   Wed, 8 Jun 2022 15:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/7] rebase: update branches in multi-part topic
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/06/2022 21:42, Derrick Stolee via GitGitGadget wrote:
> [...]
> As an example, here is my in-progress bundle URI RFC split into subtopics as
> they appear during the TODO list of a git rebase -i --update-refs:
> 
> pick 2d966282ff3 docs: document bundle URI standard
> pick 31396e9171a remote-curl: add 'get' capability
> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
> pick 6adaf842684 fetch: add --bundle-uri option
> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
> label for-update-refs/refs/heads/bundle-redo/fetch
> [...] 
> update-refs
> [...]
> Based on some of the discussion, it seemed like one way to do this would be
> to have an 'update-ref ' command that would take the place of these 'label'
> commands. However, this would require two things that make it a bit awkward:
> 
>   1. We would need to replicate the storage of those positions during the
>      rebase. 'label' already does this pretty well. I've added the
>      "for-update-refs/" label to help here.

I'm afraid I don't think that using a label with a name constructed from 
a magic prefix and the full refname is a good user interface.

(i) Having labels behave differently based on their name is confusing.

(ii) The length of the label string is cumbersome for users. Rebase 
already has a reputation for being unfriendly and hard to use, this will 
not improve that. "update-ref bundle-redo/fetch" is much simpler.

(iii) It means that we no longer store the oid of each branch when 
creating the todo list and so cannot check if it is safe to update it at 
the end of the rebase (just using the current value of the branch ref at 
the end of a long running operation like rebase is not sufficient to be 
safe).

>   2. If we want to close out all of the refs as the rebase is finishing, then
>      that "step" becomes invisible to the user (and a bit more complicated to
>      insert). Thus, the 'update-refs' step performs this action. If the user
>      wants to do things after that step, then they can do so by editing the
>      TODO list.

I'm not sure what the use case is for making the update-refs step 
visible to the user - it seems to be added complexity for them to deal 
with. We don't do that for the branch that is being rebased so why do we 
need to do it for the other branches? As for the implementation we could 
just update the branches at the end of the loop in pick_commits() where 
we update the branch and run the post-rewrite hook etc. there is no need 
for an entry in the todo list.

Best Wishes

Phillip
