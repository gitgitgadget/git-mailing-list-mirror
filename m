Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B2C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeGRPjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:39:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37770 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbeGRPjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:39:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id a18-v6so4267669qtj.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=44dNTYV+0t52paGHfuDphk7R2UnmsYicfAQSMtQ6HIA=;
        b=uEMrNCKlTI8n2o0RLZTTvSzTUt0eishXVadOqHxErHmRBjmyz/Ck/1lO0vxExo8CdF
         R3FCURWAHnRgwiNYw9TO1+DY+sT1F+sY8LJUCD/qUq7Mvhdc6YoH8MppLhKeYDbAMVMb
         dGKh5XUa880BKbi4cn+UYusL4okmXcFPbkbdMvsF5V01C5qOAIl0RApSEd+Hgmvap3nx
         U43XzqSNOK5PS4vhTUK2RPrBcH84n/u+snojGcG3eNdeITN6HrYLurDaAO/tYmnHg5yD
         51KDBchKl0foARO5l1v9poUH+oJidpjEs0dQM4R+TCOqJnemkepfhtF0EOrKg6kTLtlV
         Je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=44dNTYV+0t52paGHfuDphk7R2UnmsYicfAQSMtQ6HIA=;
        b=rOP2RJ56bMxxLdInB5kpQSAciJNhdcEEPOK7gROvc12MHcWyrWcUpHPUsnzInGI3Hm
         RYvBscRkMSa5cMiIqdF+UIaf87Q3YauoHcPCNfV0o9lnF2xkdZnwdAx602mRvJchoblJ
         QX8/PU0mV7WlWyGErl3StVecbNGfUTceveMCK1YsnMWg/MuXgROd7o77NR25L7qHdS1z
         IcCq/ZhmdxVf7qssqRfEXIOcfqk7hioSCGbE+o0ya2cPh+Ngr2NZeJdnvFVnMQ+JI+GB
         dIztL7Q1li/nyNlE4gBq4p9yvTob2lQVjsluVsXtHX74TApzWCy2UwAg18wttMqA9gKA
         j/mA==
X-Gm-Message-State: AOUpUlHooiBKLdJ3WIuQasGfSJB1iHUwFzYHiQL5g0m3eAjwd1mbQrq9
        BZX+v1d6ptQaihFoGfSP4Ur9dfcF
X-Google-Smtp-Source: AAOMgpdcR/Fh5SCEyVLmVxbBuMGHfAB8vK8y2cwulXaAGlePxiwfoMpCBp9FZFTurLC0h/fCA/N/pg==
X-Received: by 2002:ac8:6055:: with SMTP id k21-v6mr6174582qtm.204.1531926057094;
        Wed, 18 Jul 2018 08:00:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id v12-v6sm2071391qtv.57.2018.07.18.08.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:00:55 -0700 (PDT)
Subject: Re: [PATCH 6/6] submodule--helper: introduce new update-module-mode
 helper
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180712194754.71979-1-sbeller@google.com>
 <20180712194754.71979-7-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e5366f75-3669-bfbb-2561-ee06751b923d@gmail.com>
Date:   Wed, 18 Jul 2018 11:00:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180712194754.71979-7-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2018 3:47 PM, Stefan Beller wrote:
> +	fprintf(stdout, submodule_strategy_to_string(&update_strategy));

This line is causing build failures on 'pu' for certain setups:

2018-07-18T14:53:03.6857987Z builtin/submodule--helper.c: In function 
‘module_update_module_mode’:
2018-07-18T14:53:03.6874886Z builtin/submodule--helper.c:1504:2: error: 
format not a string literal and no format arguments 
[-Werror=format-security]
2018-07-18T14:53:03.6890814Z   fprintf(stdout, 
submodule_strategy_to_string(&update_strategy));
2018-07-18T14:53:03.6905905Z   ^

Thanks,

-Stolee

