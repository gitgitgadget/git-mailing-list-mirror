Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76801F462
	for <e@80x24.org>; Tue, 11 Jun 2019 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405274AbfFKKMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 06:12:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfFKKMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 06:12:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so12321303wrq.11
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+kQbOJwD+xdG6lJdYvz12rdw+pD8DJJhtdm4g/8OxOQ=;
        b=Sx0mp8lcco7zpW6JukjcCBYUMqbG+/eoUnAl8cl37Cx8voYOeXgP2PxF1ztw3zNfsx
         KyeEqE1R5GppxWs0LY1p3+8h5yI2oqvvx+O2zfDL3sPEH69XKfubeEjJ7JWAtuvhNvfe
         e7soNVA9a7kxzO7dTcAGPyoNihzvplV1LEyxSnwfawLtBPSH9Z6f2mbG3BrL+8+LoMf4
         eBvc6v92OVceQnVOYUrH2FBLkUDFNxQPfBn+j/DhCiu69Aop6WaAmO/Swn/365/SoYvP
         oiKRRJfpTBYOzeQbNeVFD95lX2zAAgVui7dbibjlPzwsyb5cGPy2dEfykVZhrb05gQAx
         PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+kQbOJwD+xdG6lJdYvz12rdw+pD8DJJhtdm4g/8OxOQ=;
        b=BPIIeEGYNpXr0+f+LuUg950ygKsvZaxmwgwMCzYP8VL+lSMhs4btkzbZp0RuOtlQeU
         ky8nvwXx+reiBt+UYblJs5sjQJKcG/e09MMgBNnwzHCpVaBomwTyhekFxIBk4xA/8UL7
         1ICdhe18I6gG/1F1erd67blxLA8qzqJbNrfV0DeBzWa/bF++RYa6+cv8pxEEIaouRzqo
         CmWLmKKsIoBU4QDaERw0yq8ZWRs9J4c4HeyYLimnv5lbksp7/SwD31LLthjeI6ZeqKPb
         0XNiSTIiKpPk7UiyMtQVveZhbj0rc4Vg9MIH8VFya8AKvAhRqUgDnhmcTZlpwcHyUoAf
         W01w==
X-Gm-Message-State: APjAAAWHGGHQbRm/HPncfRhubnWXGLowD9vlG7V4R4egy2O7056gc7SU
        /MsRo2O3foczQFUPlviGxHg=
X-Google-Smtp-Source: APXvYqxeic1BAFv7VQI9+Yy49MrJ4xXQWtLIp809t/0nWG31qcecnIRGc4PPkg1AAMOg30UPME2viw==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr21655106wro.300.1560247973212;
        Tue, 11 Jun 2019 03:12:53 -0700 (PDT)
Received: from szeder.dev (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id j16sm30281307wre.94.2019.06.11.03.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:12:52 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:12:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] t: add t0016-oidmap.sh
Message-ID: <20190611101250.GE4012@szeder.dev>
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
 <20190611082325.28878-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611082325.28878-3-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 10:23:24AM +0200, Christian Couder wrote:
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> new file mode 100755
> index 0000000000..cbd2cb71d6
> --- /dev/null
> +++ b/t/t0016-oidmap.sh
> @@ -0,0 +1,100 @@
> +#!/bin/sh
> +
> +test_description='test oidmap'
> +. ./test-lib.sh
> +
> +# This purposefully is very similar to t0011-hashmap.sh
> +
> +test_oidmap() {
> +	echo "$1" | test-tool oidmap $3 > actual &&

Style nit: space between redirection op and filename ;)

