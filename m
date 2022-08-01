Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C62C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 13:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiHANmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHANmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 09:42:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A295BB
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 06:42:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y9so7991171qtv.5
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+6BX3Jtz2clQadTJbCnc0tr0kJ9jXLqHu05tJZ+3nGI=;
        b=PnmTFVzNQxQEAP3m6/wxU68Mv3CloODM1keEa63n/9MNAUiKE58QhA6HM2O3LLgZtp
         PhD1D4/jCh759guNuhRczc6VfLkYnewaopBONfAVO+E8Nl/V9T4a5MRLVUcmo6A/NyJS
         Mj6QjYlWRuiT/9OozhI5u9QISv3qiUgvfs7JKfv/KV+upwpMSD3bLfat7Mt5C7MJBD6U
         GJ8po0V1t40DPVYtwzPoSaWKUbsE7LiXRxya7vaEghuG9BMSeesN78nLCmBEOBxp3qfk
         wgnLmaKYwzOQDiUAb4vl+kINM420hC6vUMUkzsd8ELVQL0w9EKeY5QfoQ4Vg0hGqOxA2
         zp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+6BX3Jtz2clQadTJbCnc0tr0kJ9jXLqHu05tJZ+3nGI=;
        b=PTSbn7xXg/0SOs88zpMXmKocHjW+ZfassfXoEfrA6JoFAj7mhVdEP56OqWY9dDzebW
         2IkltpK7FsLqmmUOO+9h3WG2PnUjAEyUIo9fyU0Dig30N7bAHhEnPXZOi/eXkXx2dAV7
         7yA0RzHlo3gs2BCSiBzLpUxexkNxey7GvpUX2Ba2LvqhLiTJ8yr8ReiGmBCGbSreixz+
         p9sU5KuEZqCQlZtU/n40A+07UH/C99lK530OF/xzSfX3qCwdoNc25ZUT82XaFSv7kinf
         h5phjMdp8yZHWwjjZgp80+XgJekhujGILTyGl35O9+GSN/6nfWPRrJOuNZS7cFI5fRHX
         1Ygw==
X-Gm-Message-State: AJIora9U1jddvrsLUCR7g0tBf7qlaQUgGRy++s5RNG1B8IrKE6fsq+/f
        Kx0Y+45FhJZoOsaY9cmcpuEW
X-Google-Smtp-Source: AGRyM1saSYmdnvlIdSC+HSVpfIH1xVolJSu48MtD8FUnOQvf4cRLMXCMlUlc8ci/C3GeW1n0xjNdNA==
X-Received: by 2002:a05:622a:110d:b0:31f:1c18:eb1a with SMTP id e13-20020a05622a110d00b0031f1c18eb1amr14040312qty.292.1659361339330;
        Mon, 01 Aug 2022 06:42:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8ca1:1a2:b034:1f7e? ([2600:1700:e72:80a0:8ca1:1a2:b034:1f7e])
        by smtp.gmail.com with ESMTPSA id g9-20020ac81249000000b0031ea95094dcsm7114300qtj.72.2022.08.01.06.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:42:18 -0700 (PDT)
Message-ID: <e2c64924-d1d3-f3cd-8c89-d9d36a30d528@github.com>
Date:   Mon, 1 Aug 2022 09:42:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] docs: document bundle URI standard
Content-Language: en-US
To:     "tenglong.tl" <dyroneteng@gmail.com>, gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, szeder.dev@gmail.com
References: <e0f003e1b5fae07e98e89875c047c795396ea494.1658757188.git.gitgitgadget@gmail.com>
 <20220728012358.29627-1-tenglong.tl@alibaba-inc.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220728012358.29627-1-tenglong.tl@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 9:23 PM, tenglong.tl wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> +bundle.heuristic::
>> +	If this string-valued key exists, then the bundle list is designed to
>> +	work well with incremental `git fetch` commands. The heuristic signals
>> +	that there are additional keys available for each bundle that help
>> +	determine which subset of bundles the client should download. The only
>> +  heuristic currently planned is `creationToken`.
> 
> Seem like there is a small indent nit at the last line?

Thanks for noticing. I had a setting malfunction and it is fixed now.

Thanks,
-Stolee

