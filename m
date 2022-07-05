Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54374C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiGENHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGENGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 09:06:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48A2E6AA
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 05:33:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a15so11354011pfv.13
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQEpL9Rbnh+E+xbQl5cj48Rvo3qI+VMYl3zi6tG8HOc=;
        b=mi/wBYk09BeZw3+729USe12T9PDkA06Y2NBe/uHSklGtZS+I4VGRRWnJ6g0OiTOb+2
         tasEQS8DJ9RRaCS9rXetHLR1tn7j7KGbxDocoHYHUNOD2jgMzNVifwN5EYmu5t2NwHMq
         qhfid+xc1woAm2Yl0qcutS7N9V1agst0xD86a6Rj4N/qljYrfGL0kbT7c9DHBYVudloy
         UiK9aq6Xgum2nNOvBY2IuOXyAvFS4yf0SBkrQvrQL7re8t3A1KcJfuGbv5lINgafPkOf
         wGZ5FdtJCqJfxRKdR9VnKk3vteHF7TVdCNTfxPDI2/2G5RKL2USA8K8eVal1RvlR/UKL
         ZaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQEpL9Rbnh+E+xbQl5cj48Rvo3qI+VMYl3zi6tG8HOc=;
        b=kKCSWSMQrOUDBEypb9lwnEzcaJ7lDmc+s4SmKWUWexYD9F7y7GQCydAJ3llOHBLOHW
         MJ+6ITFBGeQKe8P8jLkARo4EU27yKc65DWPSYPq7boBS2Jtz4XtHyVPAt41brzIa+Kr6
         cXQHWEehDv8oKMt+zUs37y4PpmEMYkXKMx9ck7cxXJ/8zJ3UW49/99+P4H9lBFszKP9y
         8jesQ22XTBLSthy3G2DR70zAPlzlIDftmc5G5+k/cPqeZPaOD+CZoCnYiRDIb9vgKW5q
         rQ4dxL2ICg8Jzk85+wtcrYY78z5HYg2bZ+XrvcGBH2i/0HfhVQ/JsrSVF6tEDdqgiYiv
         NqFQ==
X-Gm-Message-State: AJIora8O8ywyLR6nTQOFOPayTXtbR1IqPRhXD1IIFd7T6mq9r77PWsh+
        ZsDwnzcPz2OcKyb8BWrALYx2hG5Rwco=
X-Google-Smtp-Source: AGRyM1ubN21e8Idk61tuAVOgsEGBScpGKLs7eP8a0X/Hc+thne27viiYv4FhXJ6z4ZJhc2qnLWl/SA==
X-Received: by 2002:a65:6944:0:b0:408:aa65:9464 with SMTP id w4-20020a656944000000b00408aa659464mr29075400pgq.160.1657024393875;
        Tue, 05 Jul 2022 05:33:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b00163fa4b7c12sm7895739pla.34.2022.07.05.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:33:13 -0700 (PDT)
Message-ID: <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
Date:   Tue, 5 Jul 2022 19:32:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Git fork process infinitely and never stop
Content-Language: en-US
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/4/22 16:44, 程洋 wrote:
> Git Version: 2.36.1
> 
> In some circumstance, Git will fork child process forever until my PC crash.
> I don’t understand why and I don’t know what log or information I should provide
> Details are showed in this Youtube video. Please feel free to ask if I can provide anything.
> 

Hi and welcome to Git mailing list!

For this bug report to be useful, please include following information,
inline in your email:
- git version
- steps to reproduce the bug
- what you expect and actual behavior, as well as the differences
- system info
- miscellaneous

And don't forget to send as plaintext email.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
