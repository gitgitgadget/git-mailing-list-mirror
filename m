Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C4C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 13:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiHPNxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHPNxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 09:53:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB746213
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 06:53:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so1516063wrv.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=HTWjy5bzu8hhI19T8p4cd9sqj1uWmUkcsE+BJpk5Lx0=;
        b=Eb7Gc12H2GbaOe4NNTlYX2gn2HjD0fXOjapIrEl/qirzAgGmrfLGYvIokB1AYJw7mn
         uA1o2Mmxfu/KxUCSUDxwcKQnZxNBa48/ofg+/v6bgnLKbLgpDkRlSezU1ZgzRxRrV38C
         1mynk0/TLEwcbJ5RUFtVqpFrmvgNsgFEu9KZ1dfc6hzaQPTDOa6PTZUipFEtw+ooQc8N
         tp/LLUO/tX/xohLgDr131qA3SAorNN9LjUtJ07opg6l+wve6/gv/ZLyKqPCxXH7xugxM
         L3QRWXYq6iWUILPyEGwY/wmYJztBNRH7bQ5J3dg3tjgJA7SFzHL0+aBXASQCfajsGX7Q
         3iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=HTWjy5bzu8hhI19T8p4cd9sqj1uWmUkcsE+BJpk5Lx0=;
        b=YeuKE5zk0Ybt4nHntNVTOa59lOA3O0e9jaBLbi+Ieq4FDrMDiHjf8sHfzYlNdCWQeM
         qeG7NJriyhwdT9B+5D99etlpsjV7N8PrdkEb6Ejr4E42kBZ23p7wsiImFMwDqKVhv0Kb
         Lc253Nx1REzftHjSy3FxwXEiuhGmTQZkGSvIs9HVOkQvSlV7hRwkWGa6mGPlfDCj2Cs9
         4Vv0JmhYInyOJa0sXAPRk9FmHbBluXZvEvcv0ZQ6LA6xVgmAAWJj4zN1Olxy7C/p1yej
         lD6ATtD0q7oqg0bhh+Q+x6KayEQMdYjpoBYjkVvNITlrMrS03Mg1KT+o9GWHaEaaT1vO
         XFdw==
X-Gm-Message-State: ACgBeo2fVMzwYRE3L4umpEALynnZJLARakyoRKAq3CeCoRFtzIAing20
        TrJ2W76OBe+Bvl6o/HIWJjg=
X-Google-Smtp-Source: AA6agR42B7npEJPzgIn8a+ySvPNfMvuje9SLKhuAZZNQCATHzC4LOuwHBC6qpzm43PvrEp899ofK3g==
X-Received: by 2002:a5d:6f18:0:b0:225:2032:fca with SMTP id ay24-20020a5d6f18000000b0022520320fcamr440801wrb.182.1660657988997;
        Tue, 16 Aug 2022 06:53:08 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003a550be861bsm13305911wmb.27.2022.08.16.06.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:53:08 -0700 (PDT)
Message-ID: <eab55cef-62bd-af2b-c295-1e76beca032f@gmail.com>
Date:   Tue, 16 Aug 2022 14:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] t3416: set $EDITOR in subshell
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <c1d91a2b190c6ea4550e33260a48a51cd0653a21.1660576283.git.gitgitgadget@gmail.com>
 <xmqqo7wl30tt.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo7wl30tt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 15/08/2022 17:53, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As $EDITOR is exported setting it in one test affects all subsequent
>> tests. Avoid this by always setting it in a subshell and remove a
>> couple of unnecessary call to set_fake_editor.
> 
> Unnecessary because it reuses the one that was established in the
> previous test [1]?  Or unnecessary because we know "rebase -i" would
> fail even before it gets to the point of asking an editor to tweak
> the todo sequence [2]?  Or something else?

I meant unnecessary as the editor does not change the todo list, but [2] 
also applies.

> If [1], it makes us wonder what happens when an earlier test gets
> skipped.  If [2], it makes us wonder what happens when "rebase -i"
> fails to fail as expected (does the test correctly diagnose it as a
> new breakage in "rebase -i"?).

I think those tests could be tightened up, I'll add a new patch that 
renames them to describe what they are testing (that we fail if there is 
more than one merge base) and greps for the expected error message.

Best Wishes

Phillip

>> @@ -102,7 +106,6 @@ test_expect_success 'rebase -i --onto main...side' '
>>   	git checkout side &&
>>   	git reset --hard K &&
>>   
>> -	set_fake_editor &&
>>   	test_must_fail git rebase -i --onto main...side J
>>   '
> 
> This is one of the "removing" instances.
> 
>> @@ -187,8 +194,12 @@ test_expect_success 'rebase -i --keep-base main from side' '
>>   	git checkout side &&
>>   	git reset --hard K &&
>>   
>> -	set_fake_editor &&
>>   	test_must_fail git rebase -i --keep-base main
>>   '
> 
> And this is the other one.
> 
> Thanks.
