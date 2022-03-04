Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8008C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbiCDSho (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCDShn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:37:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0731D63AE
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:36:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8579169pjb.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TH2Mzlst4I5DPOlZB0tBWwJ8wEWvzi559I/8Gi1CbgY=;
        b=LalyaaSieBftoK6pK06z6LAm0VWfSrsRX+Cn+eDIzhiyudsLzvG8dmX/X/FWGlmeB7
         bed7Bt/eWSNS4E64jeK3iISh8UKO5KE22+3JzJQOi6nK2OlU7AMv9wNQmDmUpRmTJuoG
         y+eJP+BjKge3J+zFk3JVopI91L06wiY6Cpei3fUOVMeqroZFRGUrND7TAZE5abYLPJG5
         Iqk04g20+bF5lOwKXMqDMNxXm+geCmk/NYKnitvd7wC4Bde+7bRbqpikizuH73ut5GhG
         4LB+b1dO+dX4Os8sa5wdyLkHFCE1exUAzLkYgHrL+pji20fPAZOHS3zQet36iGM30iNF
         9RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TH2Mzlst4I5DPOlZB0tBWwJ8wEWvzi559I/8Gi1CbgY=;
        b=UFpv8Dfy/s+Iw+w95IgL36Nxt9J+G4dZbiX8kA54eGaxca5vXWcDfkD1xl8H5ElRUG
         TL4LOO3o892hjAoOiE8TodnG1ahlxYD/ZUkbvawUJv5PaXPhjtU7SqKqWP6G/MsirvAc
         gNLXXyO/XBXDhKtNzrAHzxa47ZaH8nJErxW4Ee0LtPfE4oZcORXZBjhuTUEkgwdjuI1v
         +KxUg4DezlCpsCZf3w3YUN1p8iPY51QHTMVuGQC4JuUTIvszzNoDWvLt2qgSA82Ccsce
         OX5In3D9p31/GM6x3o4tk+hI2s0/sW5ID6p7CM30nMPO8f8g2sY6zojRJvhmMdTRaKTb
         wo7Q==
X-Gm-Message-State: AOAM533awIEO8Bfda6/iYhl45t/n/14IieHiYr5aN+N73S+sh98GYOEd
        1dYHn5HbEN7oq007RwuM7jk=
X-Google-Smtp-Source: ABdhPJzpXnQBO6CD4XgFWR89cgNgWavcSG1HCsbSX/D1BMcByhvc4ek+AfLX+L6bb9ZykfsOaG3raQ==
X-Received: by 2002:a17:90a:d145:b0:1bd:5400:cba9 with SMTP id t5-20020a17090ad14500b001bd5400cba9mr12088190pjw.232.1646419014179;
        Fri, 04 Mar 2022 10:36:54 -0800 (PST)
Received: from [192.168.1.11] ([171.78.134.145])
        by smtp.gmail.com with ESMTPSA id rm4-20020a17090b3ec400b001bf2f7e86b1sm1512643pjb.4.2022.03.04.10.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:36:53 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local>
 <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
 <CAP8UFD1bEjg20Twn0pjVqxmgCU7Nhzkg16O2t6gacSsqCYfXng@mail.gmail.com>
 <CA+ARAtrwt-Ov=b13s2g8AGuATS8fNfk_ohNQPscSjAs3n0y=0w@mail.gmail.com>
 <CAP8UFD1WMn=-6Ais10xpJR70BR28UzEtbTeGSx3uNfkNt2kJ3Q@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <3849de1a-ef47-1615-128b-b0053cb2f4bf@gmail.com>
Date:   Sat, 5 Mar 2022 00:04:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1WMn=-6Ais10xpJR70BR28UzEtbTeGSx3uNfkNt2kJ3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/22 7:21 pm, Christian Couder wrote:
> On Mon, Feb 28, 2022 at 7:02 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> 
>> On Mon, Feb 28, 2022 at 4:33 PM Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Sat, Feb 26, 2022 at 9:30 PM Kaartic Sivaraam
>>> <kaartic.sivaraam@gmail.com> wrote:
>>>
>>>> Thanks for adding the ideas to the SoC-2022-Ideas[1] list! I noticed that
>>>> you're the only one mentioned as mentor for the idea there. It's usually
>>>> good to have at least 2 mentors per project. Is anyone else interested
>>>> in co-mentoring with Taylor for the idea?
>>>
>>> If no one else wants to co-mentor with Taylor, I am happy with it.
>>
>> If it's fine, I would be willing to co-mentor with Taylor. In case
>> there are other
>> potential mentors who are willing to volunteer, do chime in :-)
> 
> Great! As I already co-mentor another project, I will let you
> co-mentor this one with Taylor.
> 

Nice. Thanks for the opportunity! I've mentioned myself as a
co-mentor for the bitmap improvements project [1].

Taylor, do let me know in case you have any concerns about this.

[1]: https://git.github.io/SoC-2022-Ideas/

-- 
Sivaraam
