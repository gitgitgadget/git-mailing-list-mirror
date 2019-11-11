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
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5BE1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 16:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKQNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 11:13:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53749 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKQNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 11:13:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so6314916wmc.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RmcjRkJhxC36g1i78qMeGoNs60PB+RG/j32hBRjXsa4=;
        b=t4XBveG94NyABB+GzGRmtprDbBVUeADyFNbCPeFerSm39rksHyH/vF+VJHS4YVz21o
         XPRhXhPlZYkIqQB0dWAktGSysX6snwYaJKY2xTumPN08ZLUO1rz0vi7L6i5LwG4UgPt0
         NQUtaJWzCNpqbCwi2yv3LZGW4gsj8b6Y9bfm8HnTXV7MvDeo4VRyrY75/rvoAb7m2J82
         3RQMKcbBnN/jJFGkDVEfOkzaW18h4/fEXiKGB70RCl57shOIGDS7/LsYTvzEHXZSKU3B
         +57Vgjfr1muoeFAhqkYo+hkWKO3sci/lsPG23S00Rni1eS8tuqtFFk/5oLWDfRNgUsN4
         rCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RmcjRkJhxC36g1i78qMeGoNs60PB+RG/j32hBRjXsa4=;
        b=TwG2IdUTysWrBAciPQmjZ92YkGQZfM27GA7QXAFRXpw2oH1C+Kqmb55I69NZ3A23ng
         pAq1o0bLv5SFNsx9I4uXwms+V6jqsb1kKJpIkGGL/Bt1p1b1C2z40/76sjLVEqMDFatI
         X/XouP0mPbbWHELnzU0mnXNAuwOsbpO+uNsjCaNzwezlBVPa8R9YkHIkRn5hIm7+GjNn
         ZpuThpjX1kz8psL5jDMfJSl62GYZW/PCG80UFMCm8jaMGpqevlWG0wocLpPmnzRxba0o
         7h3cRoiR5sqXvaFmBtwICq5LtmnMYYxnU4kvxansVfMf7LRVanfufS/MuMDQP93JB2Hd
         /8DA==
X-Gm-Message-State: APjAAAWLtJaJvQyTFimickAJuLGsSpHdnI9PlUbQKugoHRcq/NxOWEpz
        KjKi6lcvD5W5NHO0kvOSvgk=
X-Google-Smtp-Source: APXvYqydihxW4ZOWNMGONu5vh3eMLVPDZ8T8Tga32rLCey89b8av0U7AahCoPcoxvIn5jFF2up/k1w==
X-Received: by 2002:a05:600c:2919:: with SMTP id i25mr20875623wmd.158.1573488820548;
        Mon, 11 Nov 2019 08:13:40 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-25-36.as13285.net. [92.22.25.36])
        by smtp.gmail.com with ESMTPSA id u187sm18951446wme.15.2019.11.11.08.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:13:39 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during a
 rebase
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
 <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>
 <nycvar.QRO.7.76.6.1910251341550.46@tvgsbejvaqbjf.bet>
 <df0e77e9-b764-690e-c814-5d90fb141def@gmail.com>
 <xmqqwocblywf.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <64bd1151-d2cd-4e8c-51f6-21e779d333a3@gmail.com>
Date:   Mon, 11 Nov 2019 16:13:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho & Junio

On 08/11/2019 14:09, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Nov 2019, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>>>> I don't this patch can distinguish between an empty cherry-pick
>>>>> performed by the user while a rebase is in progress and an empty pick
>>>>> performed by rebase as both create CHERRY_PICK_HEAD while
>>>>> .git/rebase-merge exists. It seems to assume that CHERRY_PICK_HEAD was
>>>>> created by rebase and prints advise based on that which may or may not
>>>>> be the correct. I think we could distinguish the two by checking if
>>>>> CHERRY_PICK_HEAD matches .git/rebase-merge/stopped-sha or REBASE_HEAD.
>>>>
>>>> I guess we could, but then, I would rather worry about that in the next
>>>> cycle. In this cycle, I would rather fix the common case, which is that
>>>> a `git rebase -i` fails and tells me to `git cherry-pick --skip` instead
>>>> of `git rebase --skip`.
>>>>
>>>> And even if I performed a `git cherry-pick` during a `git rebase` and
>>>> the result would be an empty commit, I'd rather be told to `git rebase
>>>> --skip` to continue...

It depends if you want to continue immediately or do something else in 
which case running reset is probably better advice. I'm not sure that 
there's an easy solution for all possible scenarios though.

>>>>
>>>> But if you feel strongly that this should be fixed differently, I'll
>>>> gladly leave it to you ;-)
>>>
>>> I'm happy to wait until the next cycle once we've decided what to do
>>> about CHERRY_PICK_HEAD during rebases.
>>
>> So, is that agreed between the two?
>>
>> Should I eject js/advise-rebase-skip topic out of my tree and wait
>> for the decision wrt CHERRY_PICK_HEAD?
> 
> Phillip, if you have some time to spend on that, I'd be very grateful, I
> am a bit under the weather and in dear need for an offline weekend.

I'm happy to have a look at it but it probably wont be for a couple of 
weeks. I've been thinking about keeping CHERRY_PICK_HEAD and it's not 
totally straight forward. CHERRY_PICK_HEAD needs to be removed when 
committing fixups to keep the author data from the commit that's being 
amended (also I think `git commit --amend` errors out if 
CHERRY_PICK_HEAD is present). It's further complicated by --reset-date 
and --committer-date-is-author-date as we want commit to respect those 
when they've been passed to the rebase command.

Junio, if you drop this series for now I'll rework it with an enum as 
discussed elsewhere in this thread.

Best Wishes

Phillip

> Thanks,
> Dscho
> 
