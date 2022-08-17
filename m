Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82486C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiHQOvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiHQOvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:51:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C53576478
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:51:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p184so7406021iod.6
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Uxd2vrhezLWE3jHoFmjeZAK5PCZp2st3/lcyscLI+o0=;
        b=ET8zNWMXvUCFhe78mcxlor4RMuNRam+KdvIyHj0KvOFLvyesu+SyTaI8ruscbSJlKm
         KccNTqcfNb3MlOvoGdQcyHKIagRNy0lExYOr8U/Kp3ZDTzfqexybGhqZBCLsMLaWO1Si
         hiCJ7AxbRSooocln/jvzOKni92OKfOvjg5iPjfAe9tETKThewQ9mwCwrHP6fpMJblG+W
         PbiWWh52C7vie9tHwmZCwzENupsgeslElAtrIkFJkXbnkgvCPrRAsl4HLI3U6cgLFZxk
         YryCK5C2dT6plxQsZUS6k2JVgbsQbnubVfMXOCBGw+SmMj67xzttaGxqniLdB4IVUrJp
         As0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Uxd2vrhezLWE3jHoFmjeZAK5PCZp2st3/lcyscLI+o0=;
        b=bew2reYoYJTAstp03mHyV1pUL0oV2hu4Y6dfuEhgRw9o30wOyDMOcbPkXfR3UItGzv
         v6b6KlbvzojEMJVJXwGP2oWH0SFvh6WTcRwtfBDgzO9ywGwn0S8gTIx2NtkFWA/P7m+r
         9zdqf91q3HkEh83jULPXLhShMMdY562CaBBRIDptgc8XV+RNk8vbWyGIadtU1pgSi6xa
         WgWTlUS7CcCkL1tkBjI5VBZlF8oPt7pJojYwqxKTaxcth2GIQApMS0eROqNiMXVCa01P
         kyAIVUIgTL0tWg/08cNepcV+RBeZqlWnEX1+fd+7f004dqzG9yIQMdyk5q52tX+V1Td2
         ti8g==
X-Gm-Message-State: ACgBeo32icZQqxAkGInAWlmM7lM59Oewg3pIMBULie2K/25Jul2BkPgR
        vvsh5+0HlYRk7KTtppOnoYSV
X-Google-Smtp-Source: AA6agR5FUcTEpSa7Cz97TgmPJHB06uTE81Nboqa4fIOP9aZ+oNPGv4QZlP+gYaB1/Iuzz5JiJ3QKIw==
X-Received: by 2002:a5e:a815:0:b0:688:f11a:6e11 with SMTP id c21-20020a5ea815000000b00688f11a6e11mr1249027ioa.10.1660747871725;
        Wed, 17 Aug 2022 07:51:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id y92-20020a029565000000b003433f35eb40sm5523716jah.80.2022.08.17.07.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:51:11 -0700 (PDT)
Message-ID: <69be513b-b6c3-3a92-6152-fddc835a6723@github.com>
Date:   Wed, 17 Aug 2022 10:51:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/5] scalar: enable built-in FSMonitor
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2022 7:58 PM, Victoria Dye via GitGitGadget wrote:
> This series enables the built-in FSMonitor [1] on 'scalar'-registered
> repository enlistments. To avoid errors when unregistering an enlistment,
> the FSMonitor daemon is explicitly stopped during 'scalar unregister'.

I hadn't looked at this code in a while, so I poked around and
asked some questions that might not even need answering.

Outside of a nit involving a test prereq, this version looks
fine to me.

Thanks,
-Stolee
