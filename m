Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47BC433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1D460F6D
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhJILUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhJILUD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 07:20:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56121C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 04:18:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so37754898wrc.10
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LKKpZCLoEiZK4lvT2ZG7StBmyWzs9nyaUZnBXRAHzHA=;
        b=BWb09YfXQzM4gKsiwE/SWBlSFxDypFHCeUES84ApsaZg8X7loVKM/sbnZChQDibgEw
         udwCkDtKou09isz80lHZDE50YJG2nL5K6TTCtfZNzve8tFD0fa0V80HxlI7cvtDlVXgQ
         93mgTv5S5Ev1vHkQuer2xs3bvI97ZxvQnh4TXphY9aG7bxywlOtb7S1f2qvGy0/ytJ+W
         epVcNQfSLKqmXuNoHI56wCBGkcLjYpEYZJSKoSMFYXDEfD3RBVD4/ep1ON9YOcFHIWcU
         dpBH1BtP2m7VqDYiki0C0XUT48F/yTk8Wmkb8nM1YdVuzf1t4cL/m4DavrhmKXCfqLB/
         IruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LKKpZCLoEiZK4lvT2ZG7StBmyWzs9nyaUZnBXRAHzHA=;
        b=AXL6UjXmU1oK5mbNQBYX0IOByUb4kzQN7UM9tI9/GTovvwWabf5XEBRz3caDw8mAZ9
         V41h0Gl9UY1LsQ0Vct58qg1oXQNnkH32GRmV3Ee/qCIg0CSjP1o3deT4mmCNeCs2NGtb
         4NlRJB8KQoZptyAPzTW0UsqzzWrc8aoWTVSV9UGp6I7vSej0CUSMFvf0Popl8zts9iNU
         DrvIddqEvcMt0fkBiGLcCdG8QeQkNII+iLzwtTvsUqNinRZwfYiSO1LXITZy+grkpacE
         cF/H8A+xfp98Alx2eGekodkP5h46Jo74ie6aKapmaOOnrbUhoUauUMm9ai7qaWSnza56
         V7Dw==
X-Gm-Message-State: AOAM530Ps1Nl8RHlOcRXnf+LLlNmgAz1caTAJHgoNIEE1OmhVoQaSUIa
        FyHXD1W9MQm8PFwBtGS2RIM=
X-Google-Smtp-Source: ABdhPJz3tnQjtW76nnmSksmj+giEiZt1tvnA8H0T75HysUjbmcd3V0Zl+dSVm/D/N+RehdD1/TD/Eg==
X-Received: by 2002:a05:600c:3b99:: with SMTP id n25mr9344677wms.50.1633778284890;
        Sat, 09 Oct 2021 04:18:04 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id m4sm15125934wml.28.2021.10.09.04.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 04:18:04 -0700 (PDT)
Message-ID: <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
Date:   Sat, 9 Oct 2021 12:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
 <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
 <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
 <xmqq1r4vl65w.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1r4vl65w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/2021 19:31, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> Phillip Wood wrote:
> 
>>> I was looking at the callers to prime_cache_tree() this morning
>>> and would like to suggest an alternative approach - just delete
>>> prime_cache_tree() and all of its callers!
> 
> Do you mean the calls added by new patches without understanding
> what they are doing, or all calls to it?

I mean all calls to prime_cache_tree() after having understood (or at 
least thinking that I understand) what they are doing. As I tried to 
explain in the part of my message that you have cut

(a) a successful call to unpack_trees() updates the cache tree

(b) all the existing calls to prime_cache_tree() follow a successful 
call to unpack_trees() and nothing touches in index in between the call 
to unpack_trees() and prime_cache_tree().

Maybe I've misunderstood something but that leads me believe those calls 
can be removed without degrading performance.

Best Wishes

Phillip

> Every time you update a path in the index from the working tree
> (e.g. "git add") and other sources, the directory in the cache-tree
> that includes the path is invalidated, and the surviving subtrees of
> cache-tree is used to speed up writing the index as a tree object,
> doing "diff-index --cached" (hence "git status"), etc.  So over
> time, the cache-tree "degrades" as you muck with the index entries.
> 
> When you write out the index as a tree, we by definition have to
> know the object names of all the tree objects that correspond to
> each directory in the index.  A fully valid cache-tree is saved when
> it happens, so the above process can start over.
> 
> There are cases other than "git write-tree" that we can cheaply
> learn the object names of all the tree objects that correspond to
> each directory in the index.  When we read the index from an
> existing tree object, we know which tree (and its subtrees) we
> populated the index from, so we can salvage a degraded cache-tree.
> 
> "reset --hard" and "reset --mixed" may be good opportunities, so is
> "checkout <branch>" that starts from a clean index.  And cache tree
> priming is a mechanism to take advantage of such an opportunity.
> 
> The cache-tree does not have to be primed and all you lose is
> performance, so priming can be removed mostly "without an issue", if
> you are not paying attention to cache-tree degradation.  Priming
> with incorrect data, however, would leave permanent damage by
> writing a wrong tree via "git write-tree" (hence "git commit") and
> showing a wrong diff via "git diff-index [--cached]" (hence "git
> status" and probably "git add -- <pathspec>"), so not priming is
> safer than priming incorrectly.
> 
> HTH.
> 

