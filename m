Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDEC433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbiARQRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbiARQRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:17:03 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE7C061746
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:17:03 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w188so29127559oiw.13
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aBxjw8hIHtUB+6XLdV79Jeta1WTP32TgEDrWtDaV7Ws=;
        b=LS/lv5vFsg29KWTr3Ml8xfGe9EoYDHMmdtHqK3LRTKq2KRGUfbVPWnrWAFx+A+UnbI
         iR9X9GH9WhPWzlyACyrNTK4711Dw0WmNp7xmMZfWB3YGpLFluNvZw1NcAzPH7ZDlnydl
         JKkKi9LWzi0zQu32ELx/mSp55y8sduji9qGcTPv/LomcD3u62BfRAas3zvBt0xqV9tAW
         wL2IrTshWIeIfF23e58yXFo38Ys2o0QWbBsaDMzw7twoj1JTtb74LC/xxMf1/Vr4h5wV
         ulPstTGftjN33Bqco1nn7qoLBHYcXm2gdkDg7wzxzzM465mBK8UtWUCfpVwLdoP2strn
         pAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aBxjw8hIHtUB+6XLdV79Jeta1WTP32TgEDrWtDaV7Ws=;
        b=0i5o+GKXN4ZpAjsba8bZmKXUafyg8zD1QUJzBfapcNhJF8tnuh6EbdtqQWFiIMGQOt
         iFR3bo1MFo2SJmHD2YYpCvUs1DDuvPv6l3wK5k+L4kxImwNRAGQN5twmAOp+BdWzw3eG
         hPZEHjIwSjMKZib6WDcyxeQNtZlIiVqotTns6+iuGoOxwOpiYlCvDbTBKVA0BJwc1PC/
         2Jcb3nNnFLnlUah34r1Pc7Aj4kY1pGRKZ9Bg3MvtFlmqbi2QalcQ9apyFdxxHcQoCo/7
         pWX3fVFsjiRTcWr1ZxPsCwHllKthDCzAbdESKDxbj0JEiKVRIxDhGqho0Ib4Q8mCBhcF
         8N0Q==
X-Gm-Message-State: AOAM533pGW3ogXfnqXdfsMOd9k1kN1dFN4vC9R9nj602kKKSGBKjPCB7
        zUtKED7mCtLZl38VKt3FKBo=
X-Google-Smtp-Source: ABdhPJwjCN5uTAANRbTqcblJpeeWk0eDNEHVZ6wceV5aaKB0MdrMZSxOIy4v9VxUmeWF0wpTMINPUQ==
X-Received: by 2002:aca:230d:: with SMTP id e13mr591929oie.106.1642522622426;
        Tue, 18 Jan 2022 08:17:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:113f:db67:413a:89ca? ([2600:1700:e72:80a0:113f:db67:413a:89ca])
        by smtp.gmail.com with ESMTPSA id bp13sm4124535oib.40.2022.01.18.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:17:01 -0800 (PST)
Message-ID: <ea4cc086-744b-6fe5-08be-7a9c684da1a3@gmail.com>
Date:   Tue, 18 Jan 2022 11:17:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] t3705-add-sparse-checkout: ignore a LF->CRLF warning on
 Windows
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <7ed402e0-63cd-2875-b3ac-71c967ccf80a@kdbg.org>
 <df42170b-8659-d496-3454-a4a3ac2827eb@kdbg.org>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <df42170b-8659-d496-3454-a4a3ac2827eb@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2022 9:58 AM, Johannes Sixt wrote:
> There are checks that certain `git add` invocations do not produce
> output on stderr. One of them, the original one, uses
> "-c core.autocrlf=input" to ensure that `git add` does not write a
> hint about LF to CRLF conversion to stderr on Windows. A second
> `git add` was added in later patch, but it was forgotten to add
> the same protection. Add it now to let the test pass on Windows.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 13.01.22 um 22:12 schrieb Johannes Sixt:
>> is there a reason we don't do this in the test case that you added in
>> 63b60b3add75 ("add: update --chmod to skip sparse paths", 2021-09-24).
>> Notice that the similar git add earlier also sets core.autocrlf.
> 
> Here's a proper patch.

Thanks for this fix. I'm not sure why this fails on your Windows
machine but passes the Windows CI builds. Glad to have the fix
either way.
> -	git add --sparse --chmod=+x sparse_entry 2>stderr &&
> +	git -c core.autocrlf=input add --sparse --chmod=+x sparse_entry 2>stderr &&

Thanks,
-Stolee
