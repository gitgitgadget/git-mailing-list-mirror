Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C6A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeHWSaF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:30:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45239 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732062AbeHWSaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:30:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so3792705eda.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=c7rmnJRXs034b9ZY/f5SNx4hQllGhHl3bCsSLPneNUU=;
        b=XZAnpFgc5XoJ4WRRfdlLi/GwSwghstQnU7ErKkXUQujFugSE1n7F4RtF4C5r2NO54g
         UWC/MDM5mHbsR+NvOnKA1064bYC2wWsf7h25AdvT1qrIGrygHOgmugkVgyDc34B+QMwu
         JKzS5ZaeO0OZ8QwhjCNqlLxlsgadPQxl0owOAa/ETOZBNoKm+nNbw6Z4bKF29+8NAYLO
         f6xj7oZGL7v9Mrci7kX1xk2Y8X+TwCplkIwKCBe9+hIhF+MJwg+3YWBYwAwVeZimKkPS
         VeT0xi8T+JSSwOX66mig7bpM8NwxKAy2VmARglSjMZd/yeUlEi9vJy/2+5fR/uf3jpF1
         US4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=c7rmnJRXs034b9ZY/f5SNx4hQllGhHl3bCsSLPneNUU=;
        b=YZWm4hWLTWlJ4blvgP/jomF4k5i07KJD8tUyqahNwXrALOeFmz3Vhv9ZLVXy7UjqwI
         vKomLgT+Su/mCa9035+jxGOqeqFecxC8gzLAcia79qkvUzitiW6MfFeiZJvMDayZMp3k
         t4QKdMSFCq9jGJFnBLVe3Qr0Q0HAv5hSaPNOcA0oE1RIeBb1/xMFO24f5HExzeO++liC
         Xam/QDKMySxS1URBYoDybhz5uLFRtmUnUatpTc70qp6pGh7HByOaJWi5vcGrGgntmKem
         M2bhknwngYiwnHU+3uF9a9Rs05Wv+aRpUIa/5UgiLtbpq5F+6Y9OPM3fDXGpIK2H1y41
         3vwg==
X-Gm-Message-State: APzg51AELCB+jVPFaIwclIBEfHBvZMLclYlqdv4Z+CxEqX0Cc/zVefJQ
        0Fyp6bjaihxC4nm9fJqC9ipPN6XAXJU=
X-Google-Smtp-Source: ANB0VdYO+vHr5sIs2AXEkPwi5+/3aND85dh45sNKOBGn16zu1KgnZxOK4V4KfnT7Et3iiF5MgFrGgg==
X-Received: by 2002:a50:d9c6:: with SMTP id x6-v6mr2561441edj.63.1535036401636;
        Thu, 23 Aug 2018 08:00:01 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id e25-v6sm2268984edd.35.2018.08.23.08.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:00:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] t2024: mark a `checkout -p` test as requiring Perl
References: <pull.20.git.gitgitgadget@gmail.com> <pull.20.v2.git.gitgitgadget@gmail.com> <8d46b31f5ad9925c8d1867c8db4fcbf86480d431.1535035282.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <8d46b31f5ad9925c8d1867c8db4fcbf86480d431.1535035282.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Aug 2018 17:00:00 +0200
Message-ID: <877ekhf7rj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 23 2018, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> A recently-added test case tries to verify that the output of `checkout
> -p` contains a certain piece of advice.
>
> But if Git was built without Perl and therefore lacks support for `git
> add -i`, the error output contains the hint that `-p` is not even
> available instead.
>
> Let's just skip that test case altogether if Git was built with NO_PERL.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t2024-checkout-dwim.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index 26dc3f1fc0..29e1e25300 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -76,7 +76,8 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
>  	test_branch master
>  '
>
> -test_expect_success 'checkout of branch from multiple remotes fails with advice' '
> +test_expect_success NO_PERL \
> +	'checkout of branch from multiple remotes fails with advice' '
>  	git checkout -B master &&
>  	test_might_fail git branch -D foo &&
>  	test_must_fail git checkout foo 2>stderr &&

This issue is already fixed in master as 3338e9950e ("t2024: mark test
using "checkout -p" with PERL prerequisite", 2018-08-18).
