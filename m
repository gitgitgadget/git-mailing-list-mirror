Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B69C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECE061260
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhJGSBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbhJGSBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:01:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AFC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 10:59:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r18so21676249wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7TrWO1OHCOMQfzzKOeq0wP0wOu65cVwqgpvGlrCNDe8=;
        b=pCALdLbl5NeICnWwPNlU2zVJQZKOziz/+HVEggkeTJBJ3B9jxE3MNvTwCrLQn1sJ3/
         VagR/7n/k4q6nKyvsyZWPxO5foXCFkJtjCVSFuMCla+tbOJM4brLJUARg4RRAeZDcvw/
         KZLBYmrQWup05MJfs8ugzbj1xUzqh/pQm1U2f4RNWEz3fyu+wVqaDlYUU/DbyImgLJdq
         qA7c58PVUmlQN/ys+X9oSplzCTazCBhMt+U9ZM5ZWMsKlolAvHBbSMf1grdvvdv0fN+Q
         y9OlVkB95+BtuqEyZsqv+vjO0CPANmGIQLr1aTIIt8cpQMUUHH2VN41i8g7W7iAsJRyF
         CEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7TrWO1OHCOMQfzzKOeq0wP0wOu65cVwqgpvGlrCNDe8=;
        b=fggLNticFNmUh60itUp8mKHJ3ahXCfGTsCdQ2myVRCFMac4qsGKtYViQ/9XhSQHWIu
         LrhYz3wnP7MeelTPbsyj1aEIM/Iibd0hRDko59Ezr2gN+dJdcCy39z/BtsEXzXPZRC4O
         ckNcpRA+g2XDuLZEXJjbtajFXyMuqm2ScIHjUK3bPjq7n+t0arGBMOp/ghiZS++RTPe7
         xE8RpTU38ysSoVeNKEyO3IBQtv76JlvDTh/BvunTAofnyeFzFXXrCuQvDoCo7kjJk2/R
         X2C18OhfguBq3vKEA1v53DGZ5MVj4ZNa1r376tJtL9RBTaF7xLwslDBUtFQCj+fE5Xd5
         lDTg==
X-Gm-Message-State: AOAM530KIim3K2Gd6XR8FJeCZ+ehHQGW/UZoSc7y2scD387eQ5zUji7h
        Z6Yp8v49xmQ20frkvK3/2EI=
X-Google-Smtp-Source: ABdhPJy2Yf5BMpgO5KHW5LJ/seZ+HPb32l4f+q0K6PD3/HIDGyMjTRCa0MPY88Tbi3fErWGD0PQXzA==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr7440718wru.230.1633629582739;
        Thu, 07 Oct 2021 10:59:42 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id o19sm41333wrg.60.2021.10.07.10.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 10:59:42 -0700 (PDT)
Message-ID: <ebbe8616-0863-812b-e112-103680f7298b@gmail.com>
Date:   Thu, 7 Oct 2021 18:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>, phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <3bf4e767-294e-0f30-f0bc-ffa706a86835@gmail.com>
 <028aef79-d4cd-5202-f657-4b5045f85d0f@gmail.com>
 <69f83ec7-315e-0488-774c-bb8490001b13@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <69f83ec7-315e-0488-774c-bb8490001b13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/10/2021 16:44, Derrick Stolee wrote:
> On 10/7/2021 11:05 AM, Phillip Wood wrote:
>> Hi Stolee
>>
>> On 07/10/2021 14:53, Derrick Stolee wrote:
>>> On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ...
>>>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>>>> index 886e78715fe..85d5279b33c 100755
>>>> --- a/t/t1092-sparse-checkout-compatibility.sh
>>>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>>>> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>>>>    test_expect_success 'merge, cherry-pick, and rebase' '
>>>>        init_repos &&
>>>>    -    for OPERATION in "merge -m merge" cherry-pick rebase
>>>> +    for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
>>>
>>> I spoke too soon. On my machine, the 'git rebase --apply' tests fail
>>> because of some verbose output that does not match across the full
>>> and sparse cases. Using "rebase -q --apply" works for me.
>>
>> Oh, that's strange, the CI tests pass on gitgitgadget and that script passes locally for me. Do you know what the output is that does not match?
> 
> It's entirely possible that it's something in git-for-windows/git or
> microsoft/git that is causing the difference:

Yes, if I apply the hunk below from 044d9fdaeb ("sparse-checkout:
avoid writing entries with the skip-worktree bit", 2017-03-01) which
is in microsoft/vfs-2.33.0 to my fix then I see the same failure. It
looks like this change makes the apply back end fall back to a three
way merge where a simple patch application succeeded before. Adding
"-q" to the test feels like a bit of a hack but it's probably the best
we can do - at least it still catches any crashes.

Best Wishes

Phillip

diff --git a/apply.c b/apply.c
index 43a0aebf4e..4c1ca6d360 100644
--- a/apply.c
+++ b/apply.c
@@ -3346,6 +3345,24 @@ static int checkout_target(struct index_state *istate,
  {
         struct checkout costate = CHECKOUT_INIT;
  
+       /*
+        * Do not checkout the entry if the skipworktree bit is set
+        *
+        * Both callers of this method (check_preimage and load_current)
+        * check for the existance of the file before calling this
+        * method so we know that the file doesn't exist at this point
+        * and we don't need to perform that check again here.
+        * We just need to check the skip-worktree and return.
+        *
+        * This is to prevent git from creating a file in the
+        * working directory that has the skip-worktree bit on,
+        * then updating the index from the patch and not keeping
+        * the working directory version up to date with what it
+        * changed the index version to be.
+        */
+       if (ce_skip_worktree(ce))
+               return 0;
+
         costate.refresh_cache = 1;
         costate.istate = istate;
         if (checkout_entry(ce, &costate, NULL, NULL) ||


> + diff -u full-checkout-out sparse-checkout-out
> --- full-checkout-out	2021-10-07 13:37:00.475394970 +0000
> +++ sparse-checkout-out	2021-10-07 13:37:00.531396095 +0000
> @@ -1,3 +1,10 @@
>   First, rewinding head to replay your work on top of it...
>   Applying: update folder1
> +Using index info to reconstruct a base tree...
> +Falling back to patching base and 3-way merge...
> +Merging:
> +e1886b3 update folder2
> +virtual update folder1
> +found 1 common ancestor:
> +virtual b4ad7e16921c16e36f1d5d45ea4fa186efa8422a
>   Applying: update deep
> + return 1
> error: last command exited with $?=1
> 
> [1] https://github.com/microsoft/git/runs/3827705316?check_suite_focus=true#step:5:10469
> 
> Thanks,
> -Stolee
> 

