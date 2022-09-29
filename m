Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E4C07E9D
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiI2JLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiI2JKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 05:10:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ACD122636
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 02:10:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x15so645828wrv.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=2jxdeclnmkHlAAk99T5Coi9gItmsjrWbs5KSyj/uJyM=;
        b=iyNCmL5abl+x23dy/kLfIc55nbLy+/wd+Gmrglrfjkpd4MvY4t3VNgFoYjOvniKY3h
         vDSj+0H0yvu5BB4j+La5hKUwwSWMqIsLHFYxSnwiBZ5q9FiDuXDHDA/dZUGWhX7ojYUe
         ZNA3O8o0FrKbpp0ICzFurJWNbJ84YGomTEQu1sIu7kTbq2iJKWhgJx/29gcuHtM2n+V7
         KI/bEoOvijb+OACixd3AtjGmo68fyYBsHwO7105yAXDh/NxqcaryxPvV+b70cpeROKie
         zB8eWwm4LNZVAabn1eqz1sDf5GDAVBN0Gt3UF8WKPEc1BDIp8fhGkl2aGTlfPY0hxGgt
         4Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2jxdeclnmkHlAAk99T5Coi9gItmsjrWbs5KSyj/uJyM=;
        b=vHNRO/JZZUC4+4tmSKvNV5vRCC4gpm+n4oAxGJCcjp5yL88ol/5cju8p7enOWILsck
         /BrNsMJhJYq2q4NXjVKe0igamuHGMZuwBuGEgzJC0Z56wjiWcJ7rjBRHQ3I7qBqSRkbr
         pqcjfrTLZAu6PkqsCMvRVlHvGkVAQ0UU9UysK+ci2Ud+jdBg4arr1N9+5ZjQZclf1qD+
         s1sSDx9uqKdRcQngVjdRHz/Q2P+6KUsTBq07q2h53Dw8aFcEsX9XZivg+cCV66efhVO4
         Lfjfv8+3IQSTFESLEVjTbz1nXhky0GzX2w2falhSTV1oVD0HqdpiJYdjJkzoc3ByqdEx
         9bBA==
X-Gm-Message-State: ACrzQf31DX0Wrc+iJL4gWlzkS4gXKsVKZ6EeuX+mPBP3yu/RPLQePclS
        XzH8mvkBrCusn8GkhLFHuMM=
X-Google-Smtp-Source: AMsMyM4DVqy77EwgbbdxHEeOhjLw0uNg0g6+mS1aSXEJ0M+XuHhLQdSboUjbqWwrSoZnv4DErhWDMw==
X-Received: by 2002:a05:6000:1291:b0:22c:c860:bf83 with SMTP id f17-20020a056000129100b0022cc860bf83mr1367007wrx.528.1664442600602;
        Thu, 29 Sep 2022 02:10:00 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a8434530bbsm3832145wme.13.2022.09.29.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:09:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a013246a-777c-acf8-d2c1-3bf9b78aa9e8@dunelm.org.uk>
Date:   Thu, 29 Sep 2022 10:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>
References: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/2022 11:01, Ævar Arnfjörð Bjarmason wrote:
> Since 131b94a10a7 (test-lib.sh: Use GLIBC_TUNABLES instead of
> MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04) compiling with
> SANITIZE=leak has missed reporting some leaks. The old MALLOC_CHECK
> method used before glibc 2.34 seems to have been (mostly?) compatible
> with it, but after 131b94a10a7 e.g. running:
> 
> 	TEST_NO_MALLOC_CHECK=1 make SANITIZE=leak test T=t6437-submodule-merge.sh
> 
> Would report a leak in builtin/commit.c, but this would not:
> 
> 	TEST_NO_MALLOC_CHECK= make SANITIZE=leak test T=t6437-submodule-merge.sh
> 
> Since the interaction is clearly breaking the SANITIZE=leak mode,
> let's mark them as explicitly incompatible.
> 
> A related regression for SANITIZE=address was fixed in
> 067109a5e7d (tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK,
> 2022-04-09).

Oh so the LD_PRELOAD breaks both sanitizers but only one of them complains

>   # Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
> -# the test with valgrind and have not compiled with SANITIZE=address.
> +# the test with valgrind and have not compiled with conflict SANITIZE
> +# options.
>   if test -n "$valgrind" ||
> +   test -n "$SANITIZE_LEAK" ||
>      test -n "$SANITIZE_ADDRESS" ||
>      test -n "$TEST_NO_MALLOC_CHECK"

The indentation is dodgy, also it would be nice to keep these in 
alphabetical order. Other than that this looks like a sensible fix.

Best Wishes

Phillip
