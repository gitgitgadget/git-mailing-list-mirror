Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41461C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhLHTKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhLHTKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:10:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B66C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:06:34 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso3697035otj.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KmN/6yVIGs3yh7ULIhE75pw/Bx7h3MZyIfR/BI5R9MM=;
        b=Mf6B/3QfVLG/+whgfa3Zlbee9+9R/AOSTICW4jb4ybAXoEwKNO1s/4umE+yVwWB+64
         TGIFgPwn8qIGiCFggUiGXGFATdJJGS+GmIxCpVJG1sXktJb3iEzhjH9CosAXdH/uFsVM
         PoBgTGDgQulaIewf1oTllar3dQaLVPqNqSGZEQAarDkFTMBpCni/StgN3XXpp5oafZ9W
         m2IwyOvWRrBW7mk9e+HXjp97i1dpyLK5vd/7brkYTtiH2j4PnITCLAhqf1PT8V6DdG5X
         vhZ18kAKoHsAsBm8e+59VOWYiYVMhBhbtg5ogpFkMH5amR450/cu6I3O+pOZFPE058Ay
         el4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KmN/6yVIGs3yh7ULIhE75pw/Bx7h3MZyIfR/BI5R9MM=;
        b=iYyebJBHtwn+k/jRn5+fqq8BWeRr+6rsHZ1JwNF/bvRM+aBjCK6T1LUDXxAY+oSojT
         3HIdGpZNDc5kjID/i5NAlmfUO6750vrWS9a5bchbSvoxmSes60gDyyQooEMxKFRn0E1O
         JWOWyWIptiiWj16Nl+HkD9yPxnqA0KbongDKSrYt/cyOtSJ1XKlraUutNY2/vha3sgGP
         uEIlvVZihz+i9MuPRiZABpvYOl/PQ4U/0NCsM3LFigbHwi9fBzQqCxO5RuRA1ggIIBGM
         l6GF6wUXlV2m9+bXPbPoCl1Qk5opCuKv8lYulDXA90RbDdGp54PfwrhHBrd1fMnkx8Ax
         1iaQ==
X-Gm-Message-State: AOAM530d+ChKzM3X9aDFnlEDMYlv0zzwk3ABihCHVQOIBkbW0JLlHtaK
        7Vhxl81aFbp7hlaTcO9v5S4=
X-Google-Smtp-Source: ABdhPJwv18qcxnRw07bzkAwDIGdQcyEMCa43Jr+Aztg9QIZWkn50/e7kGYhhcGXT+Z71ceAJgjyMBg==
X-Received: by 2002:a05:6830:4b3:: with SMTP id l19mr1254725otd.284.1638990393800;
        Wed, 08 Dec 2021 11:06:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id j187sm748764oih.5.2021.12.08.11.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:06:33 -0800 (PST)
Message-ID: <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
Date:   Wed, 8 Dec 2021 14:06:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
 <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
 <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 1:36 PM, Elijah Newren wrote:
> On Wed, Dec 8, 2021 at 10:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/8/2021 12:04 PM, Elijah Newren wrote:
>>>
>>> This actually looks quite nice, though the magic '16' is kind of
>>> annoying.  Could we get rid of that -- perhaps using something to rip
>>> out the diff header, or using comm instead?
>>
>> What I really want is "remove the first two lines of this file"
> 
> Is `tail -n +3` portable?  Looks like we have five uses of tail -n +N
> in the testsuite, so it should be okay to use.

Ah, that's the magic incantation. Sounds good.

>> but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
>> magic number?
> 
> That works too.

If the "-n +X" syntax works, then I'll opt for that.

Thanks!
