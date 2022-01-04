Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79948C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiADT0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiADT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:26:01 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B4DC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 11:26:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j6so29104889ila.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qwnoDVsL+4J7S34Wm4wo/EC7CLySjB/iz5TBE2ZbNMs=;
        b=ZJGhQfvNt/71n/AmAfgcXt+ZnhqiFH+Wf24DAgsD8S9mriqTM352fqkYSF0N6a888S
         ChTBN988hHiArv/JdgS+ZyaA/t+xY1Mz1rNjXsNbm3CUzpPPQ6rVpJ55fKITGg8RgdGS
         vXbAVmoa3tbP1ZzQktm++OrEiTgxU1jfeLszwrwX/Lm8Evl52MrQNnbkGqebYzNF9GsZ
         QNG1MqTfNbHnq4HVSLs34MC83tbOF39mfBjsVJjIZLbIuHERUAIgzJnr5cno2JgpM++3
         iw2VWGTGerCbzUKIqukZWNtpYf1bdh3Oytp7X3rdzZG4mdMG3LftfyE7u642ZHWBcdn5
         yyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qwnoDVsL+4J7S34Wm4wo/EC7CLySjB/iz5TBE2ZbNMs=;
        b=D0532nIfrTnNpBkrP/xFbmotnEFo5KXZl3h2yJPNSvIXMRvecH/mGtaYVgzRGkL0Jo
         PfAp11iSgpMKwDde5KEd0/KT1a4E83GuAUOCKta45MWDw/zjFCuIaPfaSqLc8RD+I2eP
         vri6273UJQ5oRcBGYXJTTMfwhsRdGf5LoCRgk2YdytaxwQR6ALvBOGzyqtyicRWQZp+x
         931uPx3dJzI6g1hpq21CLe8ssRLacxZn/F+K3PD1dpAsUvbmOgckYpImHA5pFjH20kyO
         k9hffHJfv6RigIrWYIQ9Ef5uORZGYV6ABwNUuEkSTsx/kE1fXmJCs8+57HkVo1JSBlaN
         RhDg==
X-Gm-Message-State: AOAM533IWPrZ7AFsHR5mpEJ+vMGPZmKx9yx7om1S9DrEX5lX4UMq9N8J
        P9aeYJSyQyfJrWeeXZaukAA=
X-Google-Smtp-Source: ABdhPJwR6bjCJueDD84LgliRAWKZisn5zEiB4lDpvDSne5TPemVlRA9PdGPZJK/TPwF1zPAscD4Qvg==
X-Received: by 2002:a05:6e02:605:: with SMTP id t5mr24060095ils.231.1641324360563;
        Tue, 04 Jan 2022 11:26:00 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id y15sm18900437ill.15.2022.01.04.11.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 11:25:53 -0800 (PST)
Message-ID: <d65bf6bf-8f60-31c2-7d01-e57ea6f4a5e3@gmail.com>
Date:   Tue, 4 Jan 2022 13:25:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
 <xmqqy240l8l1.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqy240l8l1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/31/21 4:20 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> Second, and this item is unrelated to your series but your comment
>> made me realize it....sparse-checkout unfortunately ignores prefix and
>> creates a bad .git/info/sparse-checkout file.  For example:
>> ...
>> I think the loss of the current working directory will be fixed by the
>> en/keep-cwd directory (currently in next and marked for merging to
>> master), but the fact that the wrong paths end up in the
>> sparse-checkout file is unfortunate.  It basically means that the
>> `set` and `add` subcommands of `sparse-checkout` can only be safely
>> run from the toplevel directory.
> 
> You made it sound as if this is a fundamental limitation, but it
> sounds more like a bug that needs to be fixed (outside the
> completion series, of course) to me.
> 
I can file a bug report if that's the correct way to proceed.
