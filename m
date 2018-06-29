Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E061F516
	for <e@80x24.org>; Fri, 29 Jun 2018 17:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935684AbeF2RdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 13:33:14 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33151 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934191AbeF2RdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 13:33:12 -0400
Received: by mail-qk0-f172.google.com with SMTP id c131-v6so5350912qkb.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E6S2OsBzYCFaITZPMjGFjdQ/RMm8k4sukM4+2mkwVp0=;
        b=h9T8grvWihrvA1G78tfb1La4AhKCxK0boCxmSgVqGhR0yEtap1lyQf5h4Ug2VI9DZL
         8qjdzTZASraEvVRrgQ91DWilanTHWyplnLKaZgmUVH2SS/GfSeSb2QOUZ8Wi3qUjQ2N9
         BAXQev/pU0u8j5Ym6pjOUpr9eM89RfZo4Y1fNSDPYu/Rqu3APd20tGo8wi6j27S2FzWX
         7XTJIbPT/jKrGCobThmCemlTRqECn5wg6dv3pLEwCewdFVP4MWRAcNJr9I/ax6QcToRu
         jeTtR4VFAEjsUV9o5E75Z8r5fbwxwtYY4aZvPW3CLcIShCErZ5qxWoY/vRQ4HZUfmfD3
         fIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E6S2OsBzYCFaITZPMjGFjdQ/RMm8k4sukM4+2mkwVp0=;
        b=muu0EsEnOZIUSRcfWhOxDWcyk2J0dh3UCLgdGFunY/RjYxvZij5nUg45ilkSCeqsrx
         ZkvTRohuSnue0WFJzBR10nEE8itB0kB6Zc5OpNOLnSKCbDrDaGL+c91mjj02YxwSqRaL
         nMza4pPgHXGljivM173FXHqsOrhpjgpyxAtOj5glDAzJaecWVdBn+LCOHHKqihBfO4Zq
         TZTIyJNTEdUyaqB8yCShCv7FvOoktdQP95WgQ6mdXYolIUHmFJNQaT7tLS6qcVo1gczh
         pVHoYEXlWa3tyC5a4PUHBOq4qPEjeAEB7ijAXcx2cWGzexx/BoW3kZaT5Wmq1EfQjNAq
         ++7Q==
X-Gm-Message-State: APt69E0NaNHG+MXOJ/t3oyU7iLMZ6U6q8o3XNDiCn4pSfh2xW1ov5KPl
        g5g1Atwsf/6z/xVODez5hho=
X-Google-Smtp-Source: AAOMgpdYpKvR3jTdAFF8FXYB4aAdgVVlm6ryQIvqIxezMLuWmWqAePt27FzFVoUgVajqlpkuYnyeBQ==
X-Received: by 2002:a37:8943:: with SMTP id l64-v6mr9895995qkd.134.1530293591662;
        Fri, 29 Jun 2018 10:33:11 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id a127-v6sm5669539qkd.9.2018.06.29.10.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 10:33:11 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Consolidate reachability logic
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0107a143-a90a-0b37-f5c9-2e93ff6fa593@gmail.com>
Date:   Fri, 29 Jun 2018 13:33:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC is available as a GitHub pull request [1].

Thanks,
-Stolee

[1] https://github.com/derrickstolee/git/pull/8
