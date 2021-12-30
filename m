Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E776C433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 17:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhL3Rny (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbhL3Rnx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 12:43:53 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD046C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:43:53 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so33098625otl.8
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ArVetg/4IoLmUXH32wflNQAp2k3UglNWBrmxKJm2ShU=;
        b=hZUJBgKr3Utv102K920nthp5gS3+K0dkZa/kEaQkzGL+aAYCSVicrquQhw/Mnj/FQI
         K4XKm08ad5UA6Ft0Q9Kk3ccXApdQ4D0/l6uy5ueyxO2CwP26rXq5Y+g+zALs2Q520kQR
         6SesDuwhbNUCMw7nsaMvqV1ESAPC0o5YeKnoXbmXqfB9ZSTchYaBUIYfI+e6AUVXasGl
         VZlLdG0d0yYc+OjIabq0N5My0/S8dTizg3hHKUTIkTsmkItYMpxvu8KAakn5yQE9BsA0
         TgKobgqy3lfwx1CLoaUp8SA6AcVj6+hwCR+R7PcUyrI0IA1PWw0WE06zFJ4jQhxRSXhj
         GK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ArVetg/4IoLmUXH32wflNQAp2k3UglNWBrmxKJm2ShU=;
        b=ofiaU0qlbAnr/nctP3y+3CL40bhZQ+WIFtBp9TIQxGezi0foMaODFls6JjaU4PbLIK
         Zwg8CqfamoboiCxgJpkAD+ACgmNj2bjjTw7SiijD/AXK9uvLIw6/BziZSh05+whmmnqb
         CdVNcPiPBji26XSeZofhG2AmyklnXdhXx/1PbSTbqavjHvZdTcznahC5JiwCq3o8Sqlo
         ccHlgARSz0Q5Qg7mFhv5WJrH1jmalt+/gjEkKRkkuNrWpGGaeDtPS1srAkymS3aoj/Bq
         hOx94+ZdCJMw6MbsCfFt9snWJIkVLCcJqdyMkGy8pdXR3MT89YQmHsuotE1pGTG2GMaf
         /ouA==
X-Gm-Message-State: AOAM531CCOw30zLQOFt0YlzPFW8EINs7Qlak1wg54js+cPMVSsqeppEr
        Vey6p4YpSdc0FAEQlJ6GiTiPcxzFRIQ=
X-Google-Smtp-Source: ABdhPJy9ynhk3UqhCFESIiGgg8tPkzBE4gsZXKxs7Xn/fQsnsgakGC/y09nJOBY4BL1eyzNI6xtV3Q==
X-Received: by 2002:a9d:6acb:: with SMTP id m11mr19557856otq.375.1640886233058;
        Thu, 30 Dec 2021 09:43:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd5c:4260:de91:c496? ([2600:1700:e72:80a0:cd5c:4260:de91:c496])
        by smtp.gmail.com with ESMTPSA id q2sm3986063otm.74.2021.12.30.09.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 09:43:52 -0800 (PST)
Message-ID: <63bb7366-71f6-d4c3-529f-c52d3610c1cd@gmail.com>
Date:   Thu, 30 Dec 2021 12:43:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
 <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com>
 <e6728ed1-52c6-05eb-e816-a9d919d3e9d1@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e6728ed1-52c6-05eb-e816-a9d919d3e9d1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2021 11:19 AM, Lessley Dennington wrote:
> On 12/30/21 7:43 AM, Derrick Stolee wrote:

>>> +    (
>>> +        cd sparse-checkout &&
>>> +        test_completion "git sparse-checkout set f" <<-\EOF
>>> +        folder1 Z
>>> +        folder1/0 Z
>>> +        folder1/0/1 Z
>>> +        folder2 Z
>>> +        folder2/0 Z
>>> +        folder3 Z
>>
>> This tab-completion doing a full directory walk seems like it could
>> be expensive for a large repository, but I suppose it is the only way
>> to allow the following sequence:
>>
>>     fol<tab> -> folder
>>     folder1/<tab> -> folder1/0
>>     folder1/0/<tab> -> folder1/0/1
>>
>> (Hopefully that makes sense.)
>>
> Yes, it does.
>> It would be more efficient to only go one level deep at a time, but
>> that might not be possible with the tab completion mechanisms.
>>
> When you say one level deep, do you mean that from the sparse-checkout
> directory, tab completion would only show the following?
>     
>     folder1
>     folder2
>     folder3

That's what I mean by one level deep at a time, but I also am not
sure that that is the correct functionality. I would leave the full
expansion as you have now as the design.

Thanks,
-Stolee
