Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666BC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhKVVxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhKVVxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:53:42 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93419C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:50:35 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 14so25191882ioe.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bHzXVORaI0MdEeLQd8Y5ARG8IBoPeticYf/b92NHslg=;
        b=mMgf2CjQmRHEomxkM0Lv7MCkMreRBtO9Vt75yqdwWxHCVJN8rCu45YBEXNbp9NXiAK
         CvoB8m/ZBg0A/QRGh3poHNIVIkBBymJN6DPq7wT8kmrJqbesHKQVzEBvuVeOY8orm/FJ
         7Szzy0Wyd4ecQeivYTj957OAuKBVnoRdc4D4ysNQ5gw+iFQ8dgBzxfbhYAJrPq7NE4sp
         2SO3MdOIV7Q+fgTRPmLGDxGqT80brNuFlf2OCLzF/EQeMg159YUeW4vKdvwNzOxpXyDs
         CmMSzeBwtircfMn2ltPav5A7+6fE6ubMjuLgMTaJkEINobcOa3la9nfH3Ir73z/XjzZE
         CaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHzXVORaI0MdEeLQd8Y5ARG8IBoPeticYf/b92NHslg=;
        b=386+lu1X6TKm+1uMAORC04re1f8h1dWkkqL66NdJN47795g6yb/vyN0FL00T5joqR0
         vOJFPMH827kk4zHxEW8RUPtlkRm/uvgFXStsTQ9riVGT9cjNElLQMe1dRWcnChxD+RlO
         3nXu4zZ3I3R2Q9+8kqnKIaczLQrtAx0yW5Jue9leoC7xS+g9PTz1rYVuALUe+DB5JmUH
         txhMtu2srQbxhsZhZok0MriR3dWkQsrPkmS2VBCfrAYlFXTYcniyQPyBmJdJZeMmOFCg
         Y4pBKwkvg8NAnuHC5sNLbMtjUihS4YgzbFcVT+bejDXvLoUW/oFYCWcMYisZ1rYJWsgO
         bZAQ==
X-Gm-Message-State: AOAM531DD/RP2sTsXQ2WEl1SNpjpgCysII5ptHZVtCgc+nC3k6aOJg+S
        frIchTWk59vhseH8hiYrAJHFXHFC/wA=
X-Google-Smtp-Source: ABdhPJxyTnLRPKnL7vMtDsE6ERX8GAyGkBq7+oFltdOp1q3mRPXUmBNFUTDgElclOsrZ9BARirEUeg==
X-Received: by 2002:a05:6638:349e:: with SMTP id t30mr221339jal.49.1637617834518;
        Mon, 22 Nov 2021 13:50:34 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:e1db:bcd3:11fe:659a])
        by smtp.gmail.com with ESMTPSA id o7sm4552589ilo.15.2021.11.22.13.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 13:50:33 -0800 (PST)
Subject: Re: preparing for 2.34.1
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr1b8gkhg.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6cc0bc51-cc28-989c-d666-75b707f2c080@gmail.com>
Date:   Mon, 22 Nov 2021 16:50:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1b8gkhg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/21 12:37 PM, Junio C Hamano wrote:
> There are a few topics [*] to fix regressions introduced in the
> previous cycle, which should be in 2.34.1 and I've merged them to
> 'master'. I hope we can merge them to 'maint' (which now point at
> 2.34) and tag 2.34.1 in a few days.
> 
> After that, in yet another few days, we will see most of the stalled
> topics ejected from the tree, the tip of 'next' rewound, and we will
> start the cycle toward 2.35 by starting to take new topics, by the
> beginning of the next week at the latest.

There is a patch deep in a thread [1] that is a regression
in 2.34.0 that would be good to include in this release. It
fixes a sparse-checkout bug via a simple revert (plus a new
test).

Sorry that the patch was buried deep and was easy to miss.

[1] https://lore.kernel.org/git/72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com/

Thanks,
-Stolee
