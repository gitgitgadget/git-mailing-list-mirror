Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90774C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6739C619E4
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhJVDgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJVDgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:36:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0661C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:33:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d9so2445943pfl.6
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iYIBg9zT+Q0W/UIDzZRHN++A18xh008CLBIoL53hwxI=;
        b=qLm8tWVnIHbgDCnhEIV16mFKTxUJMCdlpCf7kEBkt2h1psKAtjDdEqtX2mLmCp1Bq9
         fMnH9Gpjszk/v4phWM6Vl8ob7ekG+3eW7EhxkBsv9YffHxSGGnrz8tBFwDokXuljm3x+
         rBqkF8T1ExZ1WJidwZxfhY/31xD1cFt7qkhaOBv+F+waxagoheiyDnVDFhEGxSMPzHON
         /haGTdk6ElG/rM6W4RPkJxv/4nclIyDXQ/G9SRPeBT4Fsv1iY3VjpqOb6ozbS/rf6YgM
         CiqIDPvRYNqiwLhjOeg2eO3sUDYzSxq1YSrAwLPY1IjE4qvAY5iVQ1LYn6G2sXiWmood
         G+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iYIBg9zT+Q0W/UIDzZRHN++A18xh008CLBIoL53hwxI=;
        b=TdukIv/F/sNpLs4AZFRxgXKUEb++SWmFu4ej7Z0dOeCXXjXAuZU5YdD10cQ7XM207Z
         2MIx6Yu3xmsw0X9cisZ1wDDxMJ4SirnB+CNLqSKR0GRRU9vGtXdMYMb5VQ8/7sTE7dou
         JZJiPy8B3NwkkUKiw0HJPWu27FiOIp89nLxTqU42nrhrk9BW+pqaRSqLZhRyxIPdG0NF
         MDiglTdzVR4T8SldDPI+Hag1u/abg3EuJys93qYk39+Xpd1PILl+4QEELMt3Npdvii6/
         eUTyl9UBfSHiSQUYexkzfTlmlr6BVyKS6XWXSFo+and8zLJnT9BdfXyetdZ67PdxB8Vm
         la4Q==
X-Gm-Message-State: AOAM532tn26hSiSTGOGCCHES6nVo5mA3S2OiWBUg3YzvIJBwS47gEJLX
        D9JgXj0F1+6jUud4j4D95yw=
X-Google-Smtp-Source: ABdhPJyz/5DtNGArn9NzZ+0GtoWVz0ozkQN26xudbgxVhOtSndfB6zmZvxFAxFYasW6hp9qfyyi8Bg==
X-Received: by 2002:a63:9554:: with SMTP id t20mr7381523pgn.153.1634873626152;
        Thu, 21 Oct 2021 20:33:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id nv5sm8553042pjb.10.2021.10.21.20.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 20:33:45 -0700 (PDT)
Message-ID: <dc479498-428e-7cd4-cad5-da19875a9ad8@gmail.com>
Date:   Fri, 22 Oct 2021 10:33:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/21 23.45, Ævar Arnfjörð Bjarmason wrote:
> In summary, I think it should be changed to act like this:
>      
>      |---------------------------+------------------------+---------------------------|
>      | What                      | Now                    | New                       |
>      |---------------------------+------------------------+---------------------------|
>      | Switch                    | git switch existing    | git switch existing       |
>      | Error                     | git switch nonexisting | <no change (errors)>      |
>      | Switch with --merge       | git switch -m branch   | git switch --merge branch |
>      | Create                    | git switch -c new      | git switch -n new         |
>      | Create from existing      | N/A                    | git switch -c new [<old>] |
>      | Move & switch to existing | N/A                    | git switch -m new [<old>] |
>      |---------------------------+------------------------+---------------------------|
> 

For switch with --merge case, it seems like adding long-option variant 
of -m (--merge), right?

-- 
An old man doll... just what I always wanted! - Clara
