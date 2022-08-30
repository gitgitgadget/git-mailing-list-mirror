Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F2ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiH3PMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH3PMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:12:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34A122BFF
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:12:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n17so14660350wrm.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=vNktmWlkkE2K7rQTftkQ9fM6T6ZytPnum4HuSqgvpO8=;
        b=nOOFv7vWe8/hsLSbJ2ndPPr+1scDgaaTboWaXmCAowxF4EX9b+JI0roMPPoHJyRukI
         iE/n1nEIcXs9EHvz36tV5ec4hTSbT+G2bbFPmI7QPAMu6uXvPRuXXQSXP8K/4QthMb+4
         K5w1I1l6HPscOtFLdgTSykrKgxI5ZVtjCaF0MpfpmPy8T9+7wTqf/VkuaPnz36UlFMyK
         fD9tAcux+JUQZJCk3A/QaduvLpPHkRw6skIIfZti7ymMeLodTjFTBlimyUnTk2ibbk69
         93/mqwE+RXOfjx0FLUn4pWxZWAMQuNMedOXTa9enWB78T8J5oQsJLV5souuKxtmwDXFI
         5zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=vNktmWlkkE2K7rQTftkQ9fM6T6ZytPnum4HuSqgvpO8=;
        b=lfAPyrfggq4OZARZKYXLpoG9Lbqs4ujphXcII5FKuRuvt8FHqYi0pGZWu+7i1E8IAw
         UE8fjS9JlpjcMU0mLocoo2PunrQDqY8dI0moX8klt6/EHoeTPLemeTftWVtfc8L2j6rK
         yV/Yyr1xV3DfSTCseEtQQ/qCPO+w4+XL0gzsmagFTkAdqWULuvuhd+xOkMymgpLGV/8O
         hWNqpTM++XWGb8V4pws98XaDJhPVoaPhU0WlkFte/Q/7Pay29SdEuM6hADjjj/fCVOv8
         eT11ifd9/6dq0mjpDYJqux4NRSxXShVKFbKcf0xXlmyJLKGL76afUk3aBkUiZJTWnFXL
         aSRg==
X-Gm-Message-State: ACgBeo0Yg2DgNbV5WZpFPau1qkL0Efq0vOSToBWPhCmcnc5QsY7kEY57
        5/JDzuLwuTyn1vET86WALbsjwPOjtaH4Mw==
X-Google-Smtp-Source: AA6agR6XlC1TSaxSj8STV8Qwy7HkQB5PcaLlAed1JcP5brRwr+4nLV84vDvm9Sdp4SLdR9FfxMPLDw==
X-Received: by 2002:a5d:5c0e:0:b0:226:e686:c30a with SMTP id cc14-20020a5d5c0e000000b00226e686c30amr1574117wrb.571.1661872337072;
        Tue, 30 Aug 2022 08:12:17 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b002252ec781f7sm9869266wrr.8.2022.08.30.08.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:12:16 -0700 (PDT)
Message-ID: <4bf29cdc-ab03-3fcd-b02d-a9840e07b4f5@gmail.com>
Date:   Tue, 30 Aug 2022 16:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] t3416: set $EDITOR in subshell
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20220824222855.1686175-1-jonathantanmy@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220824222855.1686175-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 24/08/2022 23:28, Jonathan Tan wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> Hi Junio
>>
>> On 15/08/2022 17:53, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> As $EDITOR is exported setting it in one test affects all subsequent
>>>> tests. Avoid this by always setting it in a subshell and remove a
>>>> couple of unnecessary call to set_fake_editor.
>>>
>>> Unnecessary because it reuses the one that was established in the
>>> previous test [1]?  Or unnecessary because we know "rebase -i" would
>>> fail even before it gets to the point of asking an editor to tweak
>>> the todo sequence [2]?  Or something else?
>>
>> I meant unnecessary as the editor does not change the todo list, but [2]
>> also applies.
> 
> Maybe this is moot with the other changes you're planning, but even if
> the editor doesn't change the todo list, it's still necessary, right? At
> the very least, we need to suppress the default interactive editor and
> replace it with one that just reuses the input file without any
> modification.

The default GIT_EDITOR when running the test suite is ":" and 
GIT_SEQUENCE_EDITOR and sequence.editor are unset so we don't need to 
set an editor in the tests unless we want to change the todo list.

Best Wishes

Phillip

