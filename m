Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60587C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiBXP54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBXP53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:29 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E24A3ED
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:56:48 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h13so4246272qvk.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1xVC7yH2vJRkXzvmaPLg8dNPe2hFp5lrzOCJJz/xvGc=;
        b=a8Mats+PrVjOfh/sBkwBo2u14Hc6a2oR47gtYSM8ubcyz5ZUQP1N1rDZeIkgf9nHSO
         3AnVlrH/IJCnPyMKtEuEXw8IgxLWloSkPKHdHwvQdaJlGdrXOCUAPDDFlJgtE9vmy4rE
         nwiMP00SqjHAhaXW8SmEdXR3nungd54D5GrNwUNvN4p3NJZx1/nr9oTX5BVkWCDmWrwZ
         CDjXgjBV3VVfgPVAcAyzO5I0MNXM+Vqe7mmt9b5jhw2BNlFR5tjFEHun5nUOMsxGFQ4m
         ve0Lris6KYaTuIjIUm5qkyMU4Do9Xx8up1Ger+zfp7aXLG18KtwKz9O3kRApIKMnBCx8
         RQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1xVC7yH2vJRkXzvmaPLg8dNPe2hFp5lrzOCJJz/xvGc=;
        b=TXeVWJUqS6pKYhmzBYaEdH2xxZLRELVECAC0fgaO+RE+mKyHQ60vEeyaQtz0YO2zkB
         RxAD2aFWr7+FpKbo/4OpZPgzRr6Tjajpsf3SXm1w+Hql+88LViL5zgrJpqlNKUvdtLFa
         8rLcrQ4nU1olGw2Z5hJuf56QwpKVl+N9/filh3e+l+tnGA2CmoCVOCplSLCRkhDi+/uN
         lE2c9h3gM7Lc6wJKnRU2JYwAklVHTeoMIDIIg6LYfrVv1Cr7iuH2qb09MIIiOUrBuaZn
         2oa5Pqkh2ywbluG3SOEcEVp0HlZ9U6t3UHpPYGbLojPeb0YQL6I96y59hxrsmnIzRr0r
         MCJw==
X-Gm-Message-State: AOAM53022hGoopWYKmoYGBV32djVtILsboJA5BM4lFbbVwmfW35c/3WU
        gdl63pZlgALdiYA5t6cYJKOIaMvlZNb4
X-Google-Smtp-Source: ABdhPJxQuGBt9LAcysprLyAv34BAtnkUIWMrO+BP6zX+vIfP3u/NtjP5q8fkp/TTrn00Rw7pHeUbzg==
X-Received: by 2002:a05:622a:1d3:b0:2de:4e2f:82a0 with SMTP id t19-20020a05622a01d300b002de4e2f82a0mr2942583qtw.293.1645718207209;
        Thu, 24 Feb 2022 07:56:47 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o10sm1783494qtk.84.2022.02.24.07.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:56:46 -0800 (PST)
Message-ID: <ac59cfaa-1323-df83-de03-f7886699bc24@github.com>
Date:   Thu, 24 Feb 2022 10:56:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 10/23] fsmonitor-settings: remote repos on Windows are
 incompatible with FSMonitor
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ae09fb10c3ad5ea129c88addd07ebe674a22793d.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ae09fb10c3ad5ea129c88addd07ebe674a22793d.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
...
> @@ -31,5 +129,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
>  	if (reason)
>  		return reason;
>  
> +	reason = is_remote(r);
> +	if (reason)
> +		return reason;
> +
>  	return FSMONITOR_REASON_ZERO;

Just popping in to say that

	return is_virtual(r) ||
	       is_remote(r);

would work here, but we might remove is_virtual().

Thanks,
-Stolee
