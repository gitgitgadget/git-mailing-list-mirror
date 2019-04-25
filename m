Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724A61F453
	for <e@80x24.org>; Thu, 25 Apr 2019 03:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbfDYDkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 23:40:52 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36696 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbfDYDkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 23:40:51 -0400
Received: by mail-pg1-f172.google.com with SMTP id 85so10462072pgc.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lBMj0+CLJs1OScwW3B4tbQU6ekOoz/luH9c58YIqDhI=;
        b=fJ30bRkIwF9hCWRpHF8qgKZdjUONO7LrjoastZEfyaVcLzr/LqPTF1X3kCv9A0Jrvm
         UHPJ5dmsltYSw5Lk8QvN6k6GPL5sCaURFaUB5J9nTIDADeadKPvw4EUjuMZexX6zHZKb
         uhPCWlzNMuj4+zFOh7pIQDsesEbNYawdfUqIAghb4l1MZrmYYo88ekjvDOiMCTNhow3o
         YBfMM9dBTpkxFcDBySBwDEcjQtwSR4ZZSw0u/Y+68j+5DrMmNPW0al3b4RDQpuyaR+LY
         i7JQJOu2QBxhWyCeALljHI2oxol8mA2FIzqHlQ5xWrdN4Z9WE/RDfu0ov9xXoR60ag9l
         40Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lBMj0+CLJs1OScwW3B4tbQU6ekOoz/luH9c58YIqDhI=;
        b=M98//mCFNp67HWTIkHPMeG38hJ/PgNLkKqQa8NM2NgBYpV7KR0L5BcRpOEiLxCmAQU
         a4Ixp/9pG2NwG+sBcZmX76yl/yS1Y0cCNH0ytVZpkI72USZC/duiJEKMWiQIMrUXlI5y
         0n5QfqMAUIG7mb7IwNlQuxVN2aubBfgBNDT801NcEpeVqXZZ04elsXdU15ckVnPyV3+H
         W2pfupUH/ter/ufcGKoOHmYhOULFhVG6py/IwOrNJT4jZrq9T3yNwvDWRK2mPIt5OLiR
         e4FUOky0ZAFF47i5CzQJ5+TQT0+PVhXLrhFCNqe3Vsbqm9ztrRd2y6ZYL1VWXeVY0b4S
         1X2g==
X-Gm-Message-State: APjAAAVQyPirMb3oqWBdixkBki2RVW8r5xEhIWCU6a33Pw5CCkv6wMDV
        13PLuT5QmF2sROLsBoTIrwwYuoRdgbE=
X-Google-Smtp-Source: APXvYqw0WHqNFAQbVe1Q5L7LAFfxqtVX7FGLOfg9fjwTD3YJ5CHHf97X/zM2HYq45caZ/XBJkak05w==
X-Received: by 2002:a65:5289:: with SMTP id y9mr8262871pgp.52.1556163649874;
        Wed, 24 Apr 2019 20:40:49 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by smtp.gmail.com with ESMTPSA id 129sm35745325pgc.24.2019.04.24.20.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 20:40:47 -0700 (PDT)
Subject: Re: Checkout file without changing index?
To:     Junio C Hamano <gitster@pobox.com>,
        Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     git@vger.kernel.org
References: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
 <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
From:   Sitaram Chamarty <sitaramc@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sitaramc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 ZNJ7wKEHInRBmycqkB/ksby8tHy6yfE6
Message-ID: <005b0aed-2c20-0c91-e4ad-98b0ec39359d@gmail.com>
Date:   Thu, 25 Apr 2019 09:10:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2019 19.16, Junio C Hamano wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> I was familiar with "git checkout revision -- file".
>>
>> But it updates both working tree and index. I had some changes in
>> index (staged) and "git checkout HEAD -- file" silently overwritten
>> it. Well, probably my mistake, it's documented.
> 
> We'd invite you to live on the leading edge and try
> 
>     $ git restore --source=<revision> <pathspec>
> 
> which by default checks things out only to the working tree, but not
> to the index (you say --staged if you want to restore to the index,
> and you say --worktree if you want to restore to the working tree,
> or you can say both, which would be the same as "git checkout").
> 
> I think the new command is now on the 'pu' branch, but in a few
> weeks hopefully it will appear on the 'next' branch.

I'm not in a position to use either of those on at least some of my
systems, but meanwhile, I thought I'd ask this: what is the difference
between this and "git show REF:PATH > PATH", in terms of side-effects.

(I.e., any differences other than looking cleaner, not having to repeat
"PATH" etc.)

thanks
sitaram
