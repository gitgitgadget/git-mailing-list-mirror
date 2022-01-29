Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43611C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiA2Rn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiA2Rn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 12:43:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04875C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:43:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a8so9056102pfa.6
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLrxbkmAz+vgbPWYATvUabchbgOvVGNNcJAcdl0BrLQ=;
        b=NTtkQXPLug2CaYWEHxMgMng4oCZP5CBVv+ylDDbAXTElxXDc3VhNi11qKFaJaDrhQQ
         JkvwH0VzKa/XAzXZUkXDD5gdaoXoEkxdXJ8mRBvD9bBZ5xu0JgllE2ewzR0wDSIGqvGd
         SDGbbprXx0GeF7dkX3f8EOJ2+yj1MHLEDYgoCslYElot7AWF7XiUB86DQYYoKa2TqIqd
         ZQNRjjB5KBDY77AzuQ8yz9rSmzqMeKzvLF0tcg7rynBHtdXUrMUZtqY342sygOXM8IhT
         G4vy5jxGkJb4+xAOqm7fLlp5NhG2jU5KqrVmA6bXTdTNQdaoo0t2WZ2EE6bTy2xIsn0d
         8PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLrxbkmAz+vgbPWYATvUabchbgOvVGNNcJAcdl0BrLQ=;
        b=wEEtePhLW3KkFFplofG0Ptefw95ORhZOQaiRY57Ezhdw+SWCj7N7h0Hw/1Yi0cG1D3
         YqV+K78V3WwBJu+r0STIKg5FXMfAYVssnLmtZuXGTvwPpsRVZHkebg36fLcgB0WnBUU7
         juWcfuukXKjKv3+XOmTtiW4jfmUpbepQKVVWQn3cAwnxCfD1TNq5ilhCkwnR0earY5VD
         QkMg4C1JCV3sNxE/Ex9iKr2HX8jJtJemZdmhKV7hfR5wtm30D7qTVzavNy39+XwMkto0
         y3Mfctxdjttf57qeecwF+g6MIrLiyhaRp4HGDrbrX3rK9TP+Jp7uiaImy/RO/Eduu9Qb
         +bLw==
X-Gm-Message-State: AOAM530LYkT4BmBfljW//iMBAEhwlsDPoSiu5r18XdfJ4I7SaEkRDUXg
        8d3cWe/sOI6Xikmta48p48c=
X-Google-Smtp-Source: ABdhPJzUxUi0Z/2pjz2Wjq0MoMKrqRqYznLokqCHYGzEiNUyu/LNxlSQnd12uGAEXZS5NnkZxMFnog==
X-Received: by 2002:a62:e704:: with SMTP id s4mr12993002pfh.25.1643478205351;
        Sat, 29 Jan 2022 09:43:25 -0800 (PST)
Received: from [192.168.208.38] ([49.204.143.33])
        by smtp.gmail.com with ESMTPSA id qe12sm6105136pjb.14.2022.01.29.09.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 09:43:24 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <CAOLTT8QzaM70_jk4bOnBAHFaNjf6d_WSNp4h-qLWr2eJLdErBg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d7000284-0964-e929-681f-a902b2b3b917@gmail.com>
Date:   Sat, 29 Jan 2022 23:13:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8QzaM70_jk4bOnBAHFaNjf6d_WSNp4h-qLWr2eJLdErBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/01/22 8:30 pm, ZheNing Hu wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> 于2022年1月27日周四 02:29写道：
>>
>> GSoC 2022 is approaching. The timeline has been released [1].
>> Mentoring organizations should submit applications between
>> February 7 and 21 at 1800 UTC. So, I thought I'll kick off
>> the discussion about our plans for GSoC 2022.
>>
>> First, are we interested in participating in the 2022 round of
>> GSoC?
>>
>> If we are interested in participating we need:
>>
>>     - Volunteers who are wiling to act as mentors. I would be
>>       willing to be volunteer myself as a mentor for one student.
>>
>>     - Microprojects: I believe we could repurpose the Outreachy
>>       microproject ideas[2] for GSoC too. If others have suggestions
>>       for microproject ideas, please share them.
>>
>>     - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>>       but both were picked by GSoC students the previous year. So,
>>       we would need new ones this year.
>>
>>       Taylor showed interest in a bitmap-related project during
>>       the Outreachy application period [4]. Taylor, are you still
>>       interested in mentoring a bitmap-related project? Would it
>>       be possible for you to do so for the upcoming GSoC?
>>
>>
> 
> I've been busy preparing for some internships lately and may not have
> enough time as a mentor to help this year's GSOC students, but I can
> occasionally provide my review for interesting projects this year.
> 

No worries. Reviews would be great when you're able to find time for them.
Thanks! :-)

-- 
Sivaraam
