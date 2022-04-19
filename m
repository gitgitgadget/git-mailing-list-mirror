Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F0C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 05:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiDSF24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 01:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDSF2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 01:28:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B6027CC8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 22:26:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so22912809pga.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Qj1+TAt+ez/WaEG4B0e6YPEQyqV1pON3g7j0Cv4x04=;
        b=bdexb+KU+HK0ZgzLGEgyKKMpQiyFlykEuQ+txm8Spxy+K1n1ANcWng1AAueuhXCGJb
         N5voY5gtyRI8qsdjscxgsVgVew0hYwVMxGLnRy+g5lLQ3ROGdDtm3wIT7J5qL3QzFm/j
         cSxLG/GDcrrSMRabEnZrpdtqaLrb6Uvd+PP/k4ek4T0DW5lO2RYyWANBx0X0REP0UQm4
         YZk3MwLNVgpesVXq2bAuHyRDuIn9xTHSB6vzgdCBaxb2I3AVTiiPD5wY4OyrJB0scuC5
         lN63eGxxElSh+7Fz4WLsdtgsdG4tBgV8JnIDya8qCrb1R58QA+xpnyC5tlJxQB9JV0pO
         uG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Qj1+TAt+ez/WaEG4B0e6YPEQyqV1pON3g7j0Cv4x04=;
        b=CdbA6dlixHwAs0ciq4uaqh9ymDWBGJsknsRxlUFsCxqRVo+gNKW6vI4VoMwKbsc8Lp
         qtNH/otGNxUfDbQfDaJOUK2OLVyqgDit29Xd+VXV5IrgmHVWxZqnMTd4BdTGsTjFPd9g
         ADSv6HKi3uzFFeRIcL2rZ25QFpZITn0ibw/a+1OxSqSBfuKIVF+f/6F4m4XH+bxv1Wui
         kpG43ulzWOCe+eoYUsVd2NY7Us2VqsbKcJo7fUvwhJVStqE19dAFW82iveXh+o8ct5dE
         n6LV6iJkVlhjulEOIdZy2AiNXsNXIQqsC1QXgiJUyVw2NhsgZYNyGuMeUIpFm8KNlF/4
         EraQ==
X-Gm-Message-State: AOAM531hFBETwfOBWgBHSlKg1McRiWdbMh+MFDIu3BgFmo08VjXEFCVn
        MZn+6zBegadIJvyrARMpTEo=
X-Google-Smtp-Source: ABdhPJxoiUXox0mwUVRP6/5n0o3oV6f9/w9ygOz6aljDGgRkn9Q9jewYCBMM5sip4cnygyCXlGZnIg==
X-Received: by 2002:a05:6a00:2883:b0:509:322f:685f with SMTP id ch3-20020a056a00288300b00509322f685fmr15899681pfb.60.1650345972842;
        Mon, 18 Apr 2022 22:26:12 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090a2fcf00b001d090271f23sm11923895pjm.54.2022.04.18.22.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 22:26:12 -0700 (PDT)
Message-ID: <5b90dfbf-b299-1388-f9b6-c610ce12bab7@gmail.com>
Date:   Tue, 19 Apr 2022 12:26:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test
 script
Content-Language: en-US
To:     Jack McGuinness via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/19/22 08:31, Jack McGuinness via GitGitGadget wrote:
> Jack McGuinness (3):
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script p2
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script p3
> 
>  t/t4202-log.sh | 156 +++++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 76 deletions(-)
> 

I think the subject prefix of this patch series can be just
[GSOC] [PATCH] instead.

-- 
An old man doll... just what I always wanted! - Clara
