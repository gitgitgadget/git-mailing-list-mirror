Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A4C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiHPSmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHPSmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:42:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51778048C
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:42:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so1722429plq.12
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uVHEKTVcwrR01m7ZI/0ulLJgYzmGXQrNJ0lbokUDtJw=;
        b=CPT9XY2lBwtmAZWF7PxoVrrs66fdTXj48qZ4332oVjzu0zCFfDwmt7U4DaefTnLfV1
         rzMhDLsEn0UhvYRO7WYi/C6TP8i5l08BGpx6CfTKitICaLWuU1OIEFFIaX9s+20IcRIX
         d6dzYPlcV0hI/eoVa2o5GNLshCcxM5tG9Jiwl1qpnR8G1Ezbf97IWII4M5eDKJBpZeqj
         FQGBhkD32vsfFMtu0yusoQtIrmVjbRgiEH1q3inwFYIRwir/EueO5MMsOQdcMhNaMF6o
         berjFsoOXN0hx/7vWaATfzq3WNIxiwPVw4F3Jp96mC9bhurqIKOjCPCgcHWDPlcdXIEJ
         HhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uVHEKTVcwrR01m7ZI/0ulLJgYzmGXQrNJ0lbokUDtJw=;
        b=HlfS+LNJ62Wt4M40U3+Rs6QOHzNzMBpIUWhw/ezUCMZ5u6Zdqm0e1ITa4VzJB0PoRS
         O/hc9loE+8EcVQHEzmvkCia6dVp+8uozsB/BpRuZx05tkLufHErDjOS8mfPaiTaXZTtO
         Twxjk8tVPIDheYRqUddW57XESfnLriXfe/CBItDAxsu27zkGa96mtqeAE/DzZZdmuzIA
         Lg+VHB+gcpUyb9Qqpx1N1ZnZ/v2bAbQZDVGnwlN5G+0YXk8GqNaQ38IV7Nh3c6onNLP9
         SunFnnW687gQ0fLUC059Y1/ANTvwfWydHj2BoHtaSs3CQK1PrXYPxm1F2kjYSohmIbZQ
         EmsA==
X-Gm-Message-State: ACgBeo02cKcoKztOuAd3mh06xHFJ/u7EQ28lwyyAuV14plOtMWbIAL3z
        L6T0/HL0wb2UwiZ44n3rvO+1tyLOgZ2I
X-Google-Smtp-Source: AA6agR6Du82L4Tv/vOvGn4E9dy2ZYF22cpHnS7vWLBquwOt7LNXsTEiaVj3wKoaMFqlg+g1RX3hqww==
X-Received: by 2002:a17:902:e5c4:b0:16e:d968:6352 with SMTP id u4-20020a170902e5c400b0016ed9686352mr23681246plf.69.1660675329403;
        Tue, 16 Aug 2022 11:42:09 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b0016dc1df9bf7sm9523973plg.27.2022.08.16.11.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 11:42:08 -0700 (PDT)
Message-ID: <5fb1a4b3-a4d8-25de-ac47-7e47bc604f97@github.com>
Date:   Tue, 16 Aug 2022 11:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] scalar: enable built-in FSMonitor
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <xmqqzgg4uk0q.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqzgg4uk0q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series enables the built-in FSMonitor [1] on 'scalar'-registered
>> repository enlistments. To avoid errors when unregistering an enlistment,
>> the FSMonitor daemon is explicitly stopped during 'scalar unregister'.
>>
>> Maintainer's note: this series has a minor conflict with
>> 'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
>> I can provide (in addition to [2]) that would make resolution easier.
> 
> Thanks.  What's the doneness of the other series?  It has cooked for
> quite a while and I was wondering if it is ready for 'next' already,
> by the way.
> 

I wasn't planning on making any other changes unless more comments came in;
I personally think it's ready for 'next', but I'm not sure about reviewers'
thoughts. There seemed to be some new interest in reviewing at the IRC
stand-up yesterday [1], but I haven't heard anything since then. 

On the off chance that some major blocking review to
'vd/scalar-generalize-diagnose' comes in, I didn't want to base this series
on that one. But, if it *is* merged to 'next' before this one, I'll make
sure to rebase this series on top in subsequent versions to avoid the merge
conflict. 

[1] https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-08-15#l83
