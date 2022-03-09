Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B96C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiCIQYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiCIQR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:17:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E957176
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:12:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i8so3821858wrr.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1TfeY60MkySFwHUcd+E4zwXaqMvAYeqqAd98bBthGY=;
        b=Z6+Ym9A7f+Uru+sw5ELMNO7IpazLTKSgkGovURb+zCW5txdJlSnPviXpg+LLREnBYV
         kgNuDLsp4alPxJYcXWhwygNdyezJHGy2/jTXejd+gudfpTAuYzgdEZCtZ9NFrZabUEHp
         FxavXQ/Ms7u0rEx/f9A8nWCQVfpPd2Lbci9C6M35eAG9y/JgugjkK1309SuRjrIh5YQd
         mOwc4Blq7Zj6CzwpubFdGTcj0HWBjPKtC9Nx8u1c+sQSzM/NIE96c/tncRHvzdHGkuJc
         W9sxNf2fCqbUR6kWoLdnvk4IgfTN/3ZdoOS0gwTHCTY4229CLMmaZvZInh/fJjTHMk98
         ERAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1TfeY60MkySFwHUcd+E4zwXaqMvAYeqqAd98bBthGY=;
        b=qJ7ZIjaRw3W1qkR4uD0f5SVn4d+U49FU1EMKG9jw7Jyy1W4xuHUW4HjndU9IweNVX5
         3Zsc4s9w853kKh5Lj8D+SBSWC1kzzM612Jo4B8OgvcD/VhIzjI0nJmh6Q27kALGC+N0y
         Hz5YdXl8Z/W+QpUWuVqzf7vJmtjkJZrV4WX9DhMf9sTvfI4tsoccbzW7q58aF6//yhVa
         l0xuAdt1xyNExZixJkwh+aVhUKmPOdtvrDNBPzaxJlw7wzAK5acpbl1SwZ1MgBE9gqH/
         6DSXtJI8sXjuqRDe7jGb93I4+NqMhYZjxRlNLLSUCbE9Jkt9W6lsPnf+unkjw9L//TPP
         vB5g==
X-Gm-Message-State: AOAM532GQLe3Q6iyEpxz5djG4A5kHHt7CfxkMUNOJcqxqcfYmiI4pXfX
        WJwgumsw5LqcocXqzVTDcqY=
X-Google-Smtp-Source: ABdhPJzaYWFLbrLCPo3FuE4EkDJHVrDJq2yA1DH14QAqp42LW9UUayNRXPtaRj0Ui7xmM/oMbsteqg==
X-Received: by 2002:a5d:64c8:0:b0:1ef:8e7b:b9 with SMTP id f8-20020a5d64c8000000b001ef8e7b00b9mr287641wri.182.1646842363209;
        Wed, 09 Mar 2022 08:12:43 -0800 (PST)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id y2-20020a056000108200b001f078fc13a7sm2106479wrw.73.2022.03.09.08.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:12:42 -0800 (PST)
Message-ID: <da1a464e-0beb-6a44-ed05-35868fd12bed@gmail.com>
Date:   Wed, 9 Mar 2022 16:12:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: jc/stash-drop (was Re: What's cooking in git.git (Mar 2022, #02; Mon,
 7))
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
References: <xmqqilspp5yg.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqilspp5yg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jc/stash-drop (2022-03-02) 3 commits
>   - stash: call reflog_delete() in reflog.c
>   - reflog: libify delete reflog function and helpers
>   - stash: add tests to ensure reflog --rewrite --updatref behavior
> 
>   "git stash drop" is reimplemented as an internal call to
>   reflog_delete() function, instead of invoking "git reflog delete"
>   via run_command() API.
> 
>   Will merge to 'next'.
>   source: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>

I think John is planning to re-roll with an improved commit message c.f. 
<A8BDCB7C-5F16-4EDE-B8B7-0B73C93B68D2@gmail.com>

Best Wishes

Phillip
