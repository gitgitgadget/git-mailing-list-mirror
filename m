Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE97ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiH3Ndt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiH3Ndg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:33:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA6EA319
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:33:33 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so8059886otq.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jZOwVnCEi559sl3xNCsbOZ+Y8cGQgHnGO1IzwLwH6FM=;
        b=fHNbzLFamkscv2nb9eF4fsbzRuTkLOwqpiQn8ZB49hx2H3Ye8B9MTngMyf9Uh3g5dF
         EkHVPaXdsSy39jaciS9uk1Lh2b2uR1yJh2bRmwVm77aXt//DHlfXg6UhszmWzKFOB8pC
         ffp+mzzun1yjysAGGcVK1n8ayOm3cVk6kjJ7bRI8JMtFCpMGfGf+jdOvvGipe1qv8mYV
         RZPbD7aElRgt6wB32NYXR9tGTdZFRL+VtQKPplSHYfL6AsXPpOPgpmKVe09oUthSbzVo
         JQWN6rQEDSRaVVlqw2hrwiTrcCvifiW+TZsGKDossUGYEwOAnPjn+wyEtXz+fPpfiJf6
         9/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jZOwVnCEi559sl3xNCsbOZ+Y8cGQgHnGO1IzwLwH6FM=;
        b=Wz162SuaCyXjorNJXbzM1mMtOCAk7g21NTRVx7XeJdWMlmC7picuv7MKBoR1SW76cr
         ZNMVxBkeG+6StNNVsb86WEtLdC7aOBA1CZNuAAkEvnJvyfTePe9iYU7fuw20Inz7Hq+c
         VGTm8awaRU5z+Cp66e+1ReD95AOoaJRGqlIpClh46oQ8t4vCDeEjmkePeTVuxYfSVK/F
         Ufsh9blzFu1n/5wikpZO+k59PhuO5yFaYBQuKP+8Q0juJnQydCYXE10DH65ZTcVt12Nz
         8rMots3NKNISmCjpf6W/fhJ5PVfV4QMXrO4FHVTtwXz+nntuFk3/qee1WOfDIsSkCvJ7
         Ipyw==
X-Gm-Message-State: ACgBeo3WgNYrZFRDN4hE5WY2kszPKrUn9Jy1pc/sWSEQ88eMmjW1RMOh
        15uG4d3Yiqfe0ftv2R0AuMlr
X-Google-Smtp-Source: AA6agR68K0KYAsLpkEGmJAwkeFP8bSnnyyaFjHo02fP6JLPZCfgcLFuaH9Hn6SVo9qQtVaiDEJ+08g==
X-Received: by 2002:a05:6830:418a:b0:639:683b:82c7 with SMTP id r10-20020a056830418a00b00639683b82c7mr8460089otu.187.1661866412591;
        Tue, 30 Aug 2022 06:33:32 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e20-20020a056830201400b006394756c04fsm7242899otp.0.2022.08.30.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:33:32 -0700 (PDT)
Message-ID: <dcc46c8a-4c49-05d4-db23-0497e08f9fed@github.com>
Date:   Tue, 30 Aug 2022 09:33:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 4/5] bundle-uri: add support for http(s):// and file://
Content-Language: en-US
To:     Teng Long <dyroneteng@gmail.com>, gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, szeder.dev@gmail.com
References: <66a1ce4045192d153d5ac66cc248ac569cac8cf6.1660050704.git.gitgitgadget@gmail.com>
 <20220829045837.49659-1-tenglong.tl@alibaba-inc.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220829045837.49659-1-tenglong.tl@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2022 12:58 AM, Teng Long wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> +	while (!strbuf_getline(&line, child_out)) {
>> +		if (!line.len)
>> +			break;
>> +		if (!strcmp(line.buf, "get"))
>> +			found_get = 1;
>> +	}
> 
> Clear implementation for me to read, thanks.
> 
> I'm not sure but maybe a nit, should it be a "break;" after
> "found_get = 1;" for omitting the left uncencerned capabilities
> to quit earlier?

Teng, you are right that it does not hurt to have a 'break'
here. Since this topic has already merged, that change will
need a forward-fix that I can add to a future series.

Thanks,
-Stolee
