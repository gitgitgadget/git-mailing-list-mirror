Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC7C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhLGWj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhLGWjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 17:39:55 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E0C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 14:36:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m6so1356561oim.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ObSd7PJQeKGitw/uZeGcvGeZWGEH2W1WW4yCCdi/PDI=;
        b=nKOxxRc/5SXfraTJCqx0B9EWiUenhgTQko9mTP89USwVwWmrtWB78ehAC6izS5MPuU
         U6DCXdohsPeG5GUO8nv4W4joVDwYNwsFKCsZFTif1i5hthTIj472DuJLw307JcDdG85A
         Z/sYKpKlQjvENq8AhHcviA8GZ3+WOX4HmCSfy1yjg1H06mmXv/kDw5RsdAEQkxgMQXkV
         AItH43ml/xmeTZU2Vsc5dontwr7OGBKjyWfxbLvaDnOYEd9YDER9mV1K9R7Yr4jp3mjT
         TIMzYilIGi+rgBAQ9jhlp9FvK6clQycT1vRAOAgcXTcVAMcUV4thtbNYdPsfT0T0Nvus
         SYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ObSd7PJQeKGitw/uZeGcvGeZWGEH2W1WW4yCCdi/PDI=;
        b=RF4K/Fpi1Hsq6KDqqI0uMloPditH2SA3DY2mdDF0aeh1TUwO22Mh+ZG30Hf8TbIdmR
         dTQTMVRvvxi6ODtpuMYUAsAJjFEFOiN2YQXC8q/0hKU6aQKcnMUifyriYxoxMYEIrDt7
         mnIcGoH76/fy5PRr1PPOLs199/ACowx/yR6meMapTUq9lbLKm5Ju5cGyMCTrRP9PhHak
         xZjv5b7vjJm1/5HGBHqBoLVQkEqC2z98B0FDV1NrKHszWMl8WYm/rEkFClrNMMbPeSCB
         l4Vq8UCPSN8v334DW27zZwO2TR7jc5ZEmDXA/C96oJQRd6FzkovB/alpDGPs1nsu9VcF
         3nOQ==
X-Gm-Message-State: AOAM532WIAdn2ihke4tzy/Bat0yjlN0oO9D614sj7ngbNP/PfjBFOiC6
        pn7ctP3WC9y06s1K/IWgz0c=
X-Google-Smtp-Source: ABdhPJx/NztU95zSRRvvDkCaJYGb6q1hQvlPXBZXo8uDrUN1yLE2/qGlSuSxr93TtFBPpRE58ojDCw==
X-Received: by 2002:aca:6541:: with SMTP id j1mr7956745oiw.4.1638916584300;
        Tue, 07 Dec 2021 14:36:24 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id g2sm192297oic.35.2021.12.07.14.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 14:36:23 -0800 (PST)
Message-ID: <6032ba91-44ac-a165-8813-3576ac9857a5@gmail.com>
Date:   Tue, 7 Dec 2021 16:36:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
 <7c2a8b0e-a387-1166-ea02-e5792537aefa@gmail.com>
 <CABPp-BH1nb0XBgNbLLrmbtoK6UfJHgeTwQvDPVn2RcaUKddNzA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BH1nb0XBgNbLLrmbtoK6UfJHgeTwQvDPVn2RcaUKddNzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/7/21 1:13 PM, Elijah Newren wrote:
> On Tue, Dec 7, 2021 at 12:42 PM Lessley Dennington
> <lessleydennington@gmail.com> wrote:
>>
>> On 12/4/21 12:00 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
> ...
>>> ++
>>> +Historically, `set` did not used to handle all the necessary config
>>> +settings, which meant that both `init` and `set` had to be called.
>>> +Invoking both meant the `init` step would first remove nearly all
>>> +tracked files (and in cone mode, ignored files too), then the `set`
>>> +step would add many of the tracked files (but not ignored files) back.
>>> +In addition to the lost files, the performance and UI of this
>>> +combination was poor.
>>> ++
>> Super nit: Perhaps update '`set` did not used to handle' to '`set` did not
>> handle'.
> 
> Yeah, that sounds better.  I'll wait a bit longer for other comments,
> then send a fix for this along with any other needed fixes (even if
> just included Acks & Reviewed-bys I get).  Thanks!
> 
Sounds good. Also apologies that I didn't add this to v2 - my Thunderbird
client hadn't loaded those messages at the time I sent my feedback.
