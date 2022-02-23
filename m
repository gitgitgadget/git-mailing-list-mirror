Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B9C4167E
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiBWMIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiBWMIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:08:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C925B899
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:07:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so39223893wra.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Jd3N0pqaLgdNNFLVXWnp9j7uT76Dt193lP9hrDZkv8=;
        b=dIS75twhqET3Og7MATRgeMbSP9UUOsxNBsDLSReSYHLxhIO1rK4e472ALslufVIotM
         0rLuyGAekKL7izuSDwH0shWAZxgwuQFH3rPY9VJDBljjtMOgo0voPn6mLEy7s71Pa1rK
         d6lqqCjgqO1CdYGsd21x0LcbNO1Q2tyxkjLjENNYwgZH+usJ4PkA8HVNzIfo1KUnIPbE
         4lLpMStDbJ6Lrqw0X0lTK2v9y9QWCQdDJzB0mSwHtCkZbyBmuKCivjAYhX7LvlBmAluV
         orwucF3Yw4hV9o5I13ehoFQ6IMBrKrMP7BZ0w1Nh9DoqQ0SJ+q1ilyOuvb2+0vWamkQS
         nBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Jd3N0pqaLgdNNFLVXWnp9j7uT76Dt193lP9hrDZkv8=;
        b=aezt/KZh6NYz3RjqwoLOIuwhhSiBX0atquPfgLf505tG6az3hIZIQiPh2gZasDAgLj
         nHdZ82rnKEwqcYm4a/0yRG+1XFjhdUwrMGo/KNr8NA11+NemQNeLTtFGodz4sD2pZ1kw
         JIOl8nFMsbo0IjeZbrlPTrPE+6Yyr57+ps0evXm4RGMpQgEspL6VH/rT9AqZ4t2RtEBg
         sn4w4FXfNZUjTzQCBRaRqSrszEn5+JmDMVXMCBxXI/+fEusVzu0qa8gwd/SKLc5grvWn
         yTWDL6ZXOMVMHSAcBG+H3xxgMTz/JWRdO+OB/Qwpj6DefZlu42RoxWtfchKSamXk6YGQ
         oReg==
X-Gm-Message-State: AOAM532pIWLSlipfzUGc7oc4odtha5NtR+K9Nnp6EllLkPhhtLsYOfec
        ban9EWXuLlr5jyW32j7L9ak=
X-Google-Smtp-Source: ABdhPJydCiUbO9NPEPMmPzN9SkJgH4AbHd3OBGtQLHTNS0A++lZLYs5qLd13rDt25Z0YXuPkOL3Mqg==
X-Received: by 2002:a05:6000:156d:b0:1e6:db9f:a8bf with SMTP id 13-20020a056000156d00b001e6db9fa8bfmr23067609wrz.162.1645618034524;
        Wed, 23 Feb 2022 04:07:14 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f13sm1688968wrf.15.2022.02.23.04.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:07:14 -0800 (PST)
Message-ID: <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
Date:   Wed, 23 Feb 2022 12:07:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02/2022 13:31, Ævar Arnfjörð Bjarmason wrote:
> [...]
> So just to make the point about one of those mentioned in my [1] with
> some further details (I won't go into the whole thing to avoid repeating
> myself):
> 
> I opened both of:
> 
>      https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=true
>      https://github.com/dscho/git/runs/4840190622?check_suite_focus=true
> 
> Just now in Firefox 91.5.0esr-1. Both having been opened before, so
> they're in cache, and I've got a current 40MB/s real downlink speed etc.
> 
> The former fully loads in around 5100ms, with your series here that's
> just short of 18000ms.
> 
> So your CI changes are making the common case of just looking at a CI
> failure more than **3x as slow as before**.

I don't think that is the most useful comparison between the two. When I 
am investigating a test failure the time that matters to me is the time 
it takes to display the output of the failing test case. With the first 
link above the initial page load is faster but to get to the output of 
the failing test case I have click on "Run ci/print_test_failures.sh" 
then wait for that to load and then search for "not ok" to actually get 
to the information I'm after. With the second link the initial page load 
does feel slower but then I'm presented  with the test failures nicely 
highlighted in red, all I have to do is click on one and I've got the 
information I'm after. Overall that is much faster and easier to use.

Best Wishes

Phillip
