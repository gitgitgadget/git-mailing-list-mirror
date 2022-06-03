Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B8C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbiFCMzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCMyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 08:54:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F29536E19
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 05:54:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j8so2646620qtn.13
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MwZW3rfEgKBFRmpDsnwOMG/wdJp1gDImQE8RwYP1CiI=;
        b=ZwR3P06dMEMUJhESGbypDnpjtENyYbuvMCuG+PxwO1OB7XHDCX68gGlvogavbowREn
         PjG00ZztAjm8tj4etjT7+dc4L8peVxkgoFGRTbJUVZPq9QEv2fU0b6rJbzN/sFQysiYD
         dpb+moD1s9xpwwrQgz0jAkr9qNfe2sJ5fZm8CHiMWDmmm0aKoDddDEHi+buD5aOKTVEi
         ju4o6dBsYsd5ygmftH5t5yzv8KVBzEU6HiSyZdBAfnEyu4/yKX9LfMtlsuTrXpUkyEs6
         BxFla7vPHwtbq5NveApYwe4YZm4KF4KNvG2kdKUfZ0uavEoXEJSJ+xVsc58rZEeixTTO
         LhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MwZW3rfEgKBFRmpDsnwOMG/wdJp1gDImQE8RwYP1CiI=;
        b=WkxmmX4RK3CKNZZjt6c7+XLshDIrXwOHdKTwBgz597MXlahqKZK3RR3qKea0TcFGk4
         TVEwWmtAaEF6u/9qCj02QRCrHcUfZDts0iCqqn5Js3U2eaxZyugeTITH+3/TpOlk6tod
         077BqvKBwi/Mm7qPbSJknZphXXldWKG2+aFBg8qUZW59VcgUR4yiHXoWn/ls71/jhM+j
         /czpdqZOCtV+3K9QKpHK7VLhHdvvOFMYJ0EmFX0Rsf2nx97LRcWNlDfC9UyR+m1Qb8m3
         Xu03+98rQhxG9uBDQfpvEPG/HAL05F3pl+1tw0QPyQAdSmCWuly8WCpTxi2ffoY6t06K
         U7NA==
X-Gm-Message-State: AOAM532kxrAg/0sKwarGKG5abKGm41BCCraQMARp3V4MvYoDY9Fe9HO9
        QadCKCgXuDfFDw7bh9RVCbLf
X-Google-Smtp-Source: ABdhPJw3tpzxMrc5fs6mUMxCdLt9BIgYedRP4zE1ls76Q10Xldp+17VdhO3NnKwbvbDfifF6dhMi6Q==
X-Received: by 2002:ac8:5cd5:0:b0:302:9b2:dab0 with SMTP id s21-20020ac85cd5000000b0030209b2dab0mr7430820qta.432.1654260889710;
        Fri, 03 Jun 2022 05:54:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e12d:e22a:252a:6357? ([2600:1700:e72:80a0:e12d:e22a:252a:6357])
        by smtp.gmail.com with ESMTPSA id ey19-20020a05622a4c1300b002f39b99f69esm4608160qtb.56.2022.06.03.05.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 05:54:48 -0700 (PDT)
Message-ID: <c414de1f-b742-0880-09e6-446f1212e3bd@github.com>
Date:   Fri, 3 Jun 2022 08:54:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] remote: create fetch.credentialsInUrl config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com>
 <xmqq35gmkbic.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35gmkbic.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2022 5:20 PM, Junio C Hamano wrote:
...
> Taking all together, I'll queue the following on top as a separate
> fix-up patch, but I may well be giving (some) bad pieces of advice,
> so I will wait for others to comment.

I cut all of your commentary because it was universally good and
the fixup you provided does a great job of solving those issues.

Please give yourself co-authorship on the squashed commit.

Thanks,
-Stolee
