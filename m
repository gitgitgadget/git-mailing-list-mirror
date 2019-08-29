Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5861F1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfH2UHm (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 16:07:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36045 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfH2UHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 16:07:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so5171047qtc.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MpjfWwJFlBDZhly0DxzEZE0j7mnmjq67WEcOcrwDrJ0=;
        b=G28WhsT/Y2FDbEXJTQVkW9vb5rrKRK/iQ8Cg2mtACcmM4HUmgBbS3QpdCOLKMw2j0H
         K6ppmvo2EVWe71p9nWrLCGyC4Q1/S3cFHSVMiNEb+hHtqgK970ikLnu3NgX2yEHRyXNO
         abBZIthu4tUGZ6JpKHRFoa4RFY5yov0N+3Capsm0Ax7/Zno80sngRL6/cohceD5vRqpC
         brzZ40bGEpHcxYmkjSsEl8/3kH+5en1lIBZ3S6nEW3Lnb4rGF3QKiAAD9Aq7N9pj6REK
         Tnq+TctDNRF4CjaHxYLZ8s+b4len+vmpOPmt4HLG7OA/i0JOcs6+kD8ykFd3SoJ5zeMc
         otmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MpjfWwJFlBDZhly0DxzEZE0j7mnmjq67WEcOcrwDrJ0=;
        b=Tq+GtXH0iqPXE91vNJvNzDirsrn7c16zYtEyZrG/vYKfaXjcZ54BGvR/5Mf4UIP+ws
         1ggxEr851ZQoMRKsTvRmQQCVDNB/Qi+JG0/ZCwOXTzYn/IianXHOmEP4kEwGl05gGvNn
         EnBChg6OInrqiPsPtSN2P0wbMkhzPns54BXUCjfytUVSm1YkmGSuHBwbuC6Clqz06CaV
         lR9tlQlwTxMtyl7Gpk4Bn2AUtRHsflTf9x7D+VaEAGvrGw8WeWRyY50APk+pwzI7Q5mR
         lQorYknom96bWHVJKZFPKMFKCeI/+xiqB7Rv0u0T2mA8O7MPC2MGx6LecsGvar//W2N7
         U2IA==
X-Gm-Message-State: APjAAAXnIk9vIBLkOw2+LnjtFHBBCuZbEy+IbyG1NsEes/z/KLHKT8l+
        ugAHX4fCWShYP3844JAfq+k=
X-Google-Smtp-Source: APXvYqyhZVKq4b7J3JzSe1p2OdDBWmCgbUv66ba7+3vTI+MI+76Pfgc3vxyQR7w6LFlyjzSZza92SA==
X-Received: by 2002:ac8:124c:: with SMTP id g12mr11610528qtj.42.1567109260622;
        Thu, 29 Aug 2019 13:07:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c1be:7752:fdc7:f5c9? ([2001:4898:a800:1012:72f2:7752:fdc7:f5c9])
        by smtp.gmail.com with ESMTPSA id h137sm1236310qke.51.2019.08.29.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 13:07:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
Date:   Thu, 29 Aug 2019 16:07:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2019 2:54 PM, Phillip Wood wrote:
> Hi Stolee
> 
> On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
>> +   
>> +    if (argc == 3 && !strcmp(argv[1], "-b")) {
>> +        /*
>> +         * User ran 'git checkout -b <branch>' and expects
> 
> What if the user ran 'git checkout -b<branch>'? Then argc == 2.

Good catch. I'm tempted to say "don't do that" to keep this
simple. They won't have incorrect results, just slower than
the "with space" option.

However, if there is enough interest in correcting the "-b<branch>"
case, then I can make another attempt at this.

-Stolee
