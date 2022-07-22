Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C0C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiGVQD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVQD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 12:03:26 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB375A14D
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 09:03:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 1so2501522ill.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fH/Jb8wqV0aHOwX1rwdjSXLlJr/LpSl2WeTSjjTPETI=;
        b=bsTynKpZU0Ekp0TIffsEV29PO7RBT8I+g/EkUsNSH2cUluDLkQmo/GqivqkcXUinfS
         opc5qM+zkzn5mrCO2wlMSsWFD4PQ9REdg++Sjp64UyXaW+zNlmMyvV3MnyaX5UBTKtsZ
         mmpA+r71nUX4b/o0KzVYQ1nh23PZbw6jjl8zAbVfUdkf9A8RK5yoKTBy6G9QgNhztQyZ
         maGOS5HvG9BrJ9YKytF1f/jlP4Hl9HCSrhLsxY/XzLCMuc1i6qQuhBIWf0Be2Fw9rMDx
         d8+Qwioe/VnBGY8w0Ad6j/W53IG78efF43iUcKau9RJGWTI5kpM5SnFiwLpnlWb0Kwqk
         /wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fH/Jb8wqV0aHOwX1rwdjSXLlJr/LpSl2WeTSjjTPETI=;
        b=JxeCs464zyrigkDD+WZlz0VwtYqU1RNRyO4R9sQliRMthP5v3YmZvC2YFTTPcYDH9P
         PwcxqcL/PcZ4CS3vDbL+kW4CoKpsLNwdOTzVMLl4pOVdq5eWIFkTQl8wAIHQqmAT1EX5
         CIu7++gpXHj2LKSC5IlyxjSLeRvoNH366oAiDAIDiYfPbLbul1pafkVePGjwHugu9qFg
         E5tvLVzvebb8HCBhKHYxYbT4nW+buvLcMXlZVts42XxO7RwqPiaklXB3vhAAHVyLSNPI
         V5chHJeL9/C9RFKs5/YI56LZ0e//H8cmzu0hTeMwHnAE9aOUaNIRKICVcU1ATqOekyRa
         Kh5Q==
X-Gm-Message-State: AJIora/VTsq4BApeYTkCgHLYUwVLcx0QOF2ySB2UxHnFKcf4xsJOrtAq
        NNlUOXkVJduz1pu6OfU3loFl
X-Google-Smtp-Source: AGRyM1s8iLFLFaJm13DfBzSTJCxktMSaFoC+skNm5aBG97Toh9sIggApedqK3LJuaESOkgdfQir7Dw==
X-Received: by 2002:a92:c562:0:b0:2dc:9ecc:9024 with SMTP id b2-20020a92c562000000b002dc9ecc9024mr260745ilj.255.1658505804818;
        Fri, 22 Jul 2022 09:03:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id m1-20020a023c01000000b00339c3906b08sm2127019jaa.177.2022.07.22.09.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:03:24 -0700 (PDT)
Message-ID: <fd278322-b8b3-d7c2-ece6-92223fd39bfd@github.com>
Date:   Fri, 22 Jul 2022 12:03:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
 <AS8PR03MB8689A38CDA60565FED96EC99C0919@AS8PR03MB8689.eurprd03.prod.outlook.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <AS8PR03MB8689A38CDA60565FED96EC99C0919@AS8PR03MB8689.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 8:09 AM, Matthew John Cheetham wrote:

>> +The remaining keys include an `<id>` segment which is a server-designated
>> +name for each available bundle.
> 
> Case-sensitive ID? A-Za-z0-9 only? "Same as Git config rules"?

I was thinking "same as Git config rules", but those rules are extremely
flexible, perhaps more than we want them to be. (For instance, the rules
allow specifying "remote.<id>.url" where <id> could be anything except
having a newline or null byte.

Perhaps we should start with "alphanumeric and `-`" like the section
name, just to be extra careful here. We can probably be fine parsing
more flexibly on the client, but better to be restrictive now and
relax later.

Thanks,
-Stolee

