Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951CC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBUUBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBUUB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:01:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621B2A15A
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:01:28 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d7so3295084pfu.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAH8F9NjMjTz5W1lt8SgiUUdUZ7moHJq7NMzrsKiUNY=;
        b=A5XYDm0iahWCC1NzdJCodowgYf/cliwTLA3C92B93kO5SLiiLLZqKtJpoLkMhUVBJo
         czprPYRupmnBIH+7Zc6zzEgZC8Tfog33TfxDvFOfdLgQ3DPNtHNuqPFS0hrvuTvBld15
         jn/LWvhy2AO9V/prs1UkwhBbP68Cdw7Exx3HJIg8xu0EwgALRIyqlmjFaOKdSV9vZlcS
         qOVsux8vipFASRS3zEYXu7ZZ92EE4cpRJnGTJa+8rEBtirOw20fCzqosurU5TKWkQSg5
         hGBRHq4y2gmerakFzXd0G7mcW3TiTYNt8QYp5/VQfZQE8Hjdrnq3XVU9RXXvsF7ZEn4K
         suJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAH8F9NjMjTz5W1lt8SgiUUdUZ7moHJq7NMzrsKiUNY=;
        b=xNeAGrbpXjP/ElZZICL7ChS0mv904jOijWXIyoCasxMzpNOmwhzLGCyNBAaxgKKMQX
         lhBpPNC80l5EzC0Pb5Jxvx3tO1fpa8nUq87ROWAKHEUMOV9uye9L54xX/FOvIprcj91I
         N8juq7rtoT2chnl0b33eyemR6ZufUwHMpJ31PcMOvsuBMUHk/HetblGAuG1aHvk/VtmK
         5UD+SQ6RPU2Io2+C77LuPgwIPkY6PCzeLOQCIsEvaoNfe7EUAT1heiIStUWbVCTcH6SV
         d6ur95qpWp3OR/N3gL1eRcFGBUWtLobtdqX/4GLCnu29PPAYRNXAJmG6x/tNGHbIXsLC
         ggGQ==
X-Gm-Message-State: AO0yUKXYsz/2UJsVyqeuOWTqC8FyTYz+BexcNGy419DaTgi6DR26gUSf
        im4R7iTcxNHXPQolf8/bY8qPAtpmRf0=
X-Google-Smtp-Source: AK7set8976WtPIS32tGDVQY3gFemtAm9fC5QtY/W5rQmet7YuhLp7kvxHaP5T36/Dz+KCUJujsyT2Q==
X-Received: by 2002:aa7:8bdc:0:b0:5a8:ae6a:cee1 with SMTP id s28-20020aa78bdc000000b005a8ae6acee1mr5612785pfd.29.1677009688078;
        Tue, 21 Feb 2023 12:01:28 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b005a852450b14sm1574988pfa.183.2023.02.21.12.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:01:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ashutosh.pandeyhlr007@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2015-checkout-unborn.sh: changes the style for cd
References: <20230218192128.7963-1-ashutosh.pandeyhlr007@gmail.com>
Date:   Tue, 21 Feb 2023 12:01:27 -0800
In-Reply-To: <20230218192128.7963-1-ashutosh.pandeyhlr007@gmail.com>
        (ashutosh's message of "Sun, 19 Feb 2023 00:51:28 +0530")
Message-ID: <xmqqpma2eqjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ashutosh.pandeyhlr007@gmail.com writes:

> From: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
>
> the `cd` followed the old style which wasn't consistent with the rest of
> the test suite, so this commit makes it consistent with the current
> style of the test suite for `cd` in  subshell.
>
> Signed-off-by: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
> ---
> this is my first time contributing to git I want to participate in 
> this year's GSoC and I'm looking for some microprojects the ones
> that are listed on the website are mostly done so if anyone can 
> suggest some beginners level microprojects that would be great.
>
>  t/t2015-checkout-unborn.sh | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
> index 9425aae639..fdc4149f15 100755
> --- a/t/t2015-checkout-unborn.sh
> +++ b/t/t2015-checkout-unborn.sh
> @@ -9,11 +9,12 @@ TEST_PASSES_SANITIZE_LEAK=true
>  
>  test_expect_success 'setup' '
>  	mkdir parent &&
> -	(cd parent &&
> -	 git init &&
> -	 echo content >file &&
> -	 git add file &&
> -	 git commit -m base
> +	(
> +		cd parent &&
> +	 	git init &&
> +	 	echo content >file &&
> +	 	git add file &&
> +	 	git commit -m base
>  	) &&
>  	git fetch parent main:origin
>  '

OK.  This makes it siimlar to the last test in the same t2015 script
that uses this "more recent" style.

Looks good.

Thanks.
