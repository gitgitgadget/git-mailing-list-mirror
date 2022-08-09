Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D0C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHINUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:20:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C6C25
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:20:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d187so2763876iof.4
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=56iHPScA7d4QFUiF/1ug+Fb86mh++At8fs6u83HNICA=;
        b=XLJy4XFD/Nz8lWUsiUEI3Gtr0+RCTHd8CrQEsCVxPIf4+czXFpWfY21NPnrB5n0fz/
         r8bNt5GoYxBqQNnkaEcPrZmSe+FRTztnzmjEXTo3EmHKMhV1E5FpAFqitssDo4gflOIF
         Q2nMLKwm9aLeehZeRObr8BJA1ItkmMaigDocNfP7FVuuJgmOGhvob9FVRIL28C5/JBaq
         5aQQ2emDbfWDHevd8j29pinEOclU1hvU0kZwjL80kZXb7+vRvN/M6S9nC2R+4gMn9WIZ
         gw21CVIrLUFHei0KeVDHo/7uhJXswy/W8ef509WBYuanU2Wx9C8mBlh0bZI6eVLznyP3
         IbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=56iHPScA7d4QFUiF/1ug+Fb86mh++At8fs6u83HNICA=;
        b=NJY0SmAhnolWQmLiWRf95HBO+YLPIYS4ij3I/GU98GmXLennfItd5Z3xMkpSm4ytv+
         QQPBvqpmK1k35GqIUk3XzX06vt+RxZdVLIhe48ANz8H5bS2/RMiKGD/ecYVWvj83mxxC
         0505T0nJFz0M5lOIpZtXh5VvUhMFmNSai2pDOJFLJvZ4l6JWn0NdfJx/OEeA5pfTt09r
         5JuxhE8aEui/z/PHcWvZ/eYyGIBuWWoF4439GhqeBzk41FiR8H3qiWSMM+0Xqrbxg+Nv
         zZPG1UBh8lKS0HUOvtzmX6sjAkhErXUY+YOGKiD2+gb+CNTqywsxmCcSm7VAgJZB4YwM
         tKGQ==
X-Gm-Message-State: ACgBeo1B/CEuZxVhLrIJR/A7mujBGUcHeCj3vtWuSbaHJ3ETUaWfyLjl
        9SVSdvb9U58JcIZix8WHsEGmYPslUMWo
X-Google-Smtp-Source: AA6agR4MQ8yZnFS7Xznq9VxCEbL1PEF7/AuLdPguC2nTS7Hk5QFBXvwWJPrujXbf8sGIhjECxWpmLQ==
X-Received: by 2002:a05:6602:1587:b0:67c:b28:6e90 with SMTP id e7-20020a056602158700b0067c0b286e90mr9453844iow.16.1660051221834;
        Tue, 09 Aug 2022 06:20:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e1:3e6e:802:8594? ([2600:1700:e72:80a0:14e1:3e6e:802:8594])
        by smtp.gmail.com with ESMTPSA id w19-20020a02b0d3000000b0033c98e45659sm6309876jah.119.2022.08.09.06.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 06:20:21 -0700 (PDT)
Message-ID: <ca575fc0-f9ee-9b32-f12b-75c83dd3b031@github.com>
Date:   Tue, 9 Aug 2022 09:20:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/4] reset/checkout: fix miscellaneous sparse index
 bugs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, shaoxuan.yuan02@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
 <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
 <xmqq1qtqsadz.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qtqsadz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2022 5:17 PM, Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Changes since V2
>> ================
>>
>>  * Adjusted 'reset hard with removed sparse dir' test in
>>    't1092-sparse-checkout-compatibility.sh' to avoid 'git rm' log message
>>    conflicts with [1]
> 
> The topic looks quite ready for 'next'.

I agree. Thank you!

-Stolee
