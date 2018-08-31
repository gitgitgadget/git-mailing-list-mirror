Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE0E1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 07:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeHaLX3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 07:23:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33074 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 07:23:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so261381edv.0
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0uG+Mzl4YJ6GfB1TLyMpTS4CsFkBTmJi2OUv3wRKDAU=;
        b=PIoDmP2KugA4IeVWX2Oe/uMIyvIAaO3zXFSTB8dpsxo9+HyHNpTFJdugaULMm+yV6C
         tObug/BsTNpmmKDOtfckJp0xR23AVZ3o1XlMUsJzEjVQej85axe86DZgtORCWKtTMkAd
         Nyj/ipAmNlX73+R6Lw0CqsV9B8g+lNJJCzxRO5E+3iPbgJJU8Shqc3o8bPPeB8a5Fq4q
         aKnFfeT8b9izTuwr4tVfLzZNCcnxbyhu6hHWLEJwWBoniCs5WNW+KZtQm+0W9iON0/ln
         hLfvg3N6OFOuwGMlYYsaxCOum00MVgwoFiPone3mzuAAsneWvuhMQinyDxJ6KBvT3OMy
         F4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0uG+Mzl4YJ6GfB1TLyMpTS4CsFkBTmJi2OUv3wRKDAU=;
        b=rHJTj/vf/7jj1Ejk4MGaZy3AETbK02VmYltiuZstZjIuZinYrQgsKMrIYYH7S/NZrC
         FrmRw7UPRKumM9fOxehAGNfglHwRoRkay8BiZhj5GgyS0qOh8YUWUpIqb+IRdpK/Wud5
         IC1X0R4QZKiMwDMQKPqvsvXZMQWN5TZIBjw482vXdIe26QycanRFHHSxhKkb9E3IVRh+
         hhaGcXGHu7DXEi4wupanwIh1usn+jHTgGVqq/ZTiXCLdHner+C/rLj/M63YbsFlYEgcm
         p2cRPCfsaDouSjfZcBucbq3l7rZBgZfZ0QPApe6JcJRdTmWY+QWa87yxP+II6T2hpt5e
         I9cQ==
X-Gm-Message-State: APzg51BhF+AOKq+X3d6uFguiW2vDv1t36jhXHQHIeb2frfkDG7g5lX5D
        +58AHgcDK39d6TKRQTEv+FU=
X-Google-Smtp-Source: ANB0VdbO/iORmUE9xxmFL8KviU821iBnffxcz5lTI1czwB0W8lyui2vZciaJUx9sLVRV9qRF3FIJng==
X-Received: by 2002:a50:e68c:: with SMTP id z12-v6mr16759045edm.275.1535699844583;
        Fri, 31 Aug 2018 00:17:24 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id i15-v6sm4537251ede.66.2018.08.31.00.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 00:17:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Change tests from expecting to fail to expecting success.
References: <20180831053921.8083-1-ischis2@cox.net> <20180831053921.8083-2-ischis2@cox.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180831053921.8083-2-ischis2@cox.net>
Date:   Fri, 31 Aug 2018 09:17:23 +0200
Message-ID: <87d0tzc8e4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 31 2018, Stephen P. Smith wrote:

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 4cae92804..810d4cea7 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -99,12 +99,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
>  	git commit -m next -a --dry-run
>  '
>
> -test_expect_failure '--short with stuff to commit returns ok' '
> +test_expect_success '--short with stuff to commit returns ok' '
>  	echo bongo bongo bongo >>file &&
>  	git commit -m next -a --short
>  '
>
> -test_expect_failure '--porcelain with stuff to commit returns ok' '
> +test_expect_success '--porcelain with stuff to commit returns ok' '
>  	echo bongo bongo bongo >>file &&
>  	git commit -m next -a --porcelain

This commit is not OK and needs to be folded into later commits. It
makes the test suite fail until (presumably, haven't reviewed the rest)
a later commit. The tests must always pass, otherwise someone bisecting
will trip up over this commit.
