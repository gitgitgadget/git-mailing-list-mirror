Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE1C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 03:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiF1DTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 23:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiF1DTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 23:19:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A01EC68
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 20:19:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t21so10810778pfq.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=onSOL4tOc7eXZtA3LrGem3fK+pv/Ig8cwciZTVC1LV4=;
        b=gRnRKwEt2oa/NvFA9uGvoSBxKY0dPeY/KJFs5yCzI5VTusGledoeZMqlpNBxVIQ4Ch
         dJlMOsAQpJ+WkEMsdcaVaLBViGyauRoo/+T4vW85/lsRZOIHt3tGQDPCMtAFyn7tVpbh
         pli90BhzJHeuLgWq+tWAGj257nzyPXwhaDBgCSvzXyqDEexQzlAdR9NqaiKRtRUxM+VW
         sZE0tkZseTHgzsYKyJ783+cPbJ17ZDDuSslTI1sNHjmR/dFAVHuxfKNL4IQsEVfTrfBy
         ha09sypg1dRNcA4LdcDrWhiPI+A8kJ9Yuokg0mWt81FGbQmOpOFAFbjfUHNPd14tjAxp
         g+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=onSOL4tOc7eXZtA3LrGem3fK+pv/Ig8cwciZTVC1LV4=;
        b=6WkLlCEIO0mNnTsA0YHMXLn1sBU0DRFevqy6CUpWbSFKH3scFOa8t5uyO2nMTPRnSb
         nqXYSTsUYFudfx5GksMOQ+sor/vljQogwk95EzG5MxN2NzeHpZZWNdaJbpDxKKvLDzCr
         YHA5XbEWBZtS84NjwySiGeN/W2ohRTCOd8QI4tjXtUno8m6iLeUWUJo97w6zX2kX/iQ7
         cXb0j8iVIvHvz+bzL1/J8mpaObUfYL829dJLD5B11VGXWt9e9g243H35Ibdrg0aICWy4
         WaxNtgJ0dPoeFEIhDcS8nap/8zU8rHsBb/gEDiW63fBR1oxUgbzwHiEWgsbv1hXi9pDU
         12kQ==
X-Gm-Message-State: AJIora9Un4nqH+hUeh8dqjOPicnLm7LnLQwgyCpuD86pl11yscp7nc81
        jDoM3dYoOClE1Rx8o4RJvGuofTv6lrqCuA==
X-Google-Smtp-Source: AGRyM1s7SDyQOte8RjCes1vjjrfzxsZWNXTSr+xWgOdQhHDFd7IPkEd82fz66A1tgY94BmYu12mfGw==
X-Received: by 2002:aa7:9298:0:b0:525:a210:465f with SMTP id j24-20020aa79298000000b00525a210465fmr1316091pfa.77.1656386380762;
        Mon, 27 Jun 2022 20:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.26])
        by smtp.gmail.com with ESMTPSA id md17-20020a17090b23d100b001e2f383110bsm10271482pjb.11.2022.06.27.20.19.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:19:40 -0700 (PDT)
Message-ID: <c9b55a31-9e41-0a1a-dfec-f4da806f3ce2@gmail.com>
Date:   Tue, 28 Jun 2022 11:19:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [GSoC] Week 2 status update
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,
Here is Shaoxuan Yuan.
I'm writing to let you know about my previous GSoC blogs:
About GSoC 2022 [1]
GSoC Week 1 [2]
GSoC Week 2 [3]
[1] https://ffyuanda.github.io/blog/GSoC/
[2] https://ffyuanda.github.io/blog/GSoC-week-1/
[3] https://ffyuanda.github.io/blog/GSoC-week-2/
 From now on, I will reply to this thread to send weekly blog updates.
You can read them when you are free, and generously give me some
advice if possible!
Thanks & Regards,
Shaoxuan
