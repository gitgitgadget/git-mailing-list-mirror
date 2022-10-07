Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42CC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 01:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJGBoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJGBoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 21:44:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FACFE748
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 18:44:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq16so3210706pjb.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdBlQh0kbGV3tMjGkenkIuv3qtKbp58bvGYF9PyGpwg=;
        b=SAeYWvkBYpjR1dfKKu5+9AgqlRsZSlnztD88oOoMUNj62k5fiIlJ7eFvR4mxGAJy0v
         TWoyNa4Mp7AowmKxQkwGalOJYbMCAHbksTvG5YTH4glatVoDbQEloz+AjBf/THmNhmoP
         e8jZKLbcvgFH8JUhSC8jxcfRI2A9bt6js4cUhaoUFnE4cEFWg4XgQJyExzNL8466/Rkh
         wqWATCTbv4ZX6Ht5cSMXOHMozttFsVhYsMhk9dk64Z5eySk3TbE/QYRMdANJQdaHbkVu
         R2wSZ3Znib3bAPRl4KIFEqmeyPC2rSgh+7sw2jENsRW9otpovQG15f35uDWlSko0OY13
         W0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdBlQh0kbGV3tMjGkenkIuv3qtKbp58bvGYF9PyGpwg=;
        b=wycUBMOZ6IOPTHvcTvPNYnUL/F2q3nEOHy18v2XSIbDOmal0yYDYxmfR9H8NyssP4g
         /543E6hptnj51Wqrq4mC0QJpWqs2DPth0eFgoBYzBmPH5TUEtLUrlFfwBVhJzXvOktpg
         VtL4UDdxY2kPhMEYsXFxfan6MeQOcY0aodO7ExaxpCAn4sdwQE6JQMOtvlaPH+Z18Wwe
         ZJIbmMOV8XNL+hhMLvmGk33YASM2FLpRoWKqpOgxC+bzl3CNycN1cAN9Bur/OvAZZmc3
         qjzUwvzOd2CPsddHWfWj7bzClqeq57Qp/DUkiAv+CnUSJhaaO/xEsEJ07m6147xEvoFV
         KArA==
X-Gm-Message-State: ACrzQf3cSMfbmPhbJAMofravAt1Al48gJJuYMGNXj4GPXU9Fs1ICDwBw
        NDX3TOt7n0AD4S0l3bv6zbURvoTtyto=
X-Google-Smtp-Source: AMsMyM4qE6ptGlX6UPRmkyxpNQ1dW5VBXK3VBSpumkVTDfrGvfhjioo2xPg2bilszhnjyG9TSgmguQ==
X-Received: by 2002:a17:90b:38ca:b0:202:fb75:7dc3 with SMTP id nn10-20020a17090b38ca00b00202fb757dc3mr13621019pjb.192.1665107053334;
        Thu, 06 Oct 2022 18:44:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id ix14-20020a170902f80e00b001780a528540sm287142plb.93.2022.10.06.18.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 18:44:12 -0700 (PDT)
Message-ID: <83814bcb-1d72-07bf-32d1-d05db6cc6481@gmail.com>
Date:   Fri, 7 Oct 2022 08:44:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [feature request] resume capability for users in enemies of
 Internet countries
Content-Language: en-US
To:     m <mahg361@gmail.com>, git@vger.kernel.org
References: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/22 01:01, m wrote:
> In my country government make connections unstable on purpose. Please add resume capability for commands like git clone
> 

Bandwidth issue?

-- 
An old man doll... just what I always wanted! - Clara
