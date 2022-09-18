Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A00ECAAD8
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIRUIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 16:08:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7612AF7
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 13:08:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so26132617plr.8
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XGtosHaKVztlVOiiToDDKR5Z5dfWRdoqnKBPVghtiSo=;
        b=gVzQFOFh6Z1h0vwcl6vvE/PlvUYyTJEBF/t41dHhq58NWfwGmdpNI3N1Kiuh/45dW4
         SPYadp9K/RCqezr955HPDt+lrW9efHw/3CtSZnbvcbjaXIPHHiX7lN8bPnazqbankjmo
         XExGDVQA05xui//9OTR9HfJUp/MTQoKRmQ9V4ilVzw2i+sAqDIa4xV7Ym0Rgp0e24e33
         JPdqNM9fHc6rGYzDFC6WWk76OEawXFyYPJIch49PVG64JSgHb5wYQFeb5cbQgNq2cTrJ
         b2b+r/GIcLemrvcYW+ttfcWcX1BOevb0vRcsfCc+xBsanEyOp+70vNrAq1N9Qtkgk9H+
         uXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XGtosHaKVztlVOiiToDDKR5Z5dfWRdoqnKBPVghtiSo=;
        b=pzDnjKkKzWGdnQZxdgPDFYsXP+NPEQ8mHNTD91gbYb30sqQvBCJIeRgoB4g+6Q7zqK
         txXJlmfVGFHQEfAuYgpVoEcFikbsdEIYB1/z80NjtehRq6DTS889Q4FMA0D2xUM+FoGe
         immiasXmf0sU0pxyGUj2Fjl18Q3NxYHUIaajvB682zX8Gs0iUiXTr7sZlcWaS3g3wHs1
         KDVouD1013b2uyxMo6P+5elGQ8zQkIKx7lOh8DYI7vUjLWiGdx1+BrbkMIxyms/RZK8S
         DT3Cichyk9fxgslEmCwQ9wLWgK5WHNBSDaJ0SHHRouRv6sy8G9X9VS8Fz6h43VoNovi3
         4+4A==
X-Gm-Message-State: ACrzQf1mbk1q2KOXLlz+QE9TWi2X/Zw8Q/N/NCrSD7OXoPKJUdqZSQNQ
        /odXm6n0sEhkK4XQxYDzT39q
X-Google-Smtp-Source: AMsMyM7cqSZBktr0TzJeh6EIrHYkQtQDsQT31Is5AHGcWApknVkS2Qop+nbt6i8XoURGyBdVRxrdtA==
X-Received: by 2002:a17:90a:cc04:b0:200:b869:5ba4 with SMTP id b4-20020a17090acc0400b00200b8695ba4mr27623591pju.234.1663531714924;
        Sun, 18 Sep 2022 13:08:34 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w65-20020a623044000000b0054a1534516dsm7030436pfw.97.2022.09.18.13.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 13:08:34 -0700 (PDT)
Message-ID: <433bf552-db20-9989-92c5-ee625ce9337a@github.com>
Date:   Sun, 18 Sep 2022 13:08:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] scalar: fix wrong shell hashbang
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1355.git.1663420281187.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1355.git.1663420281187.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> $SHELL_PATH_SQ haven't been set in scalar's Makefile,
> bin-wrappers/scalar will begin with wrong hashbang "#!",
> fix it by setting $SHELL_PATH and $SHELL_PATH_SQ in
> scalar's Makefile.
> 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     scalar: fix wrong shell hashbang
>     
>     The bin-wrappers/scalar seems like missing setting $SHELL_PATH_SQ which
>     lead to I can't execute bin-wrappers/scalar correctly, which output
>     error:
>     
>     zsh: exec format error: scalar
>     
>     (this bug will not turn out in bash)
>     
>     The bin-wrappers/scalar begin with wrong hashbang "#!", which cannot
>     figure out by zsh. So this patch want to fix this problem.
>     
>     v1: Setting $SHELL_PATH and $SHELL_PATH_SQ in scalar/Makefile.
> 

Thanks for finding this! However, while your patch fixes the error you've
identified (I was able to recreate both the original issue and apply your
patch to fix it), I believe it has already been fixed in 'next' by
7b5c93c6c6 (scalar: include in standard Git build & installation,
2022-09-02) (archive: [1]).

[1] https://lore.kernel.org/git/bc2092a7a7aae640b547bde8db0c0a26ce31278a.1662134210.git.gitgitgadget@gmail.com/
