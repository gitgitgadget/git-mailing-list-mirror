Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C42C1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeGPUo0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:44:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPUoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:44:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so23926123wrt.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0ZytC5FLDgn1wIVh8pxELcnfnwUUVyScF66T/Vnl2W8=;
        b=EH7v1NBABw0rFEhMY1oLsYRfCCBoCSGNagtDPFZ5qGDwPk/6x6OVyOQbHef9C1Fm9b
         zbv4flgWuZg7ax0eefgmn+8YZXmLYZfTP4sm3vXpgPNFcKVo/XSs70KrJ0YpAanu4uDm
         HKrOlcqAzEEyVEOWTUdYFPEqlnjzVD/JW2cUXpMUmMpiu1sKR9c9dbMDJONZP6jQkgnw
         EJV0zLFnIaLNgx3b173OCyWntnOlpsCXrs74ergTpRc/DblQ7R+jOkERa4tPsKLH4Oau
         pWIud2B6A/fvkcUsaftqlVOwZv1qOrDn5WhPURX20uCZmRTvP9jhN/XryyzZqvgmsnXy
         8FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0ZytC5FLDgn1wIVh8pxELcnfnwUUVyScF66T/Vnl2W8=;
        b=eFEqEEW+fpC8GLJ+UI4YWZIKdBJyF8Q9loe7+Fn+5NfxmTgenZWlWSk0QtrvgJtJXy
         +UMaB5cVwavpOVQVa/TFDcuftjaQSZM+5Tb+Tjyzac6eId/rOMAHge0yghlHFgIkBUhQ
         V1+SvzvZwdw7/vuTpgYlj1h0xqKpG+o+UND3QhQq3uz7UK6dF10C/QIlIWQZL31tPlPM
         uS8nwVjf5tP5kh9UGC/d3TS6NfNkW/yi+bX2mMHY5SpEpjekBYrq4XsXXoFQQtwLZcsh
         ErOLMUkO/7sZSK9fHXRXo1hf4fDPy6C89O1XIBhLcwgyNDpn35AuzE+j5RVWEAml219z
         pUKg==
X-Gm-Message-State: AOUpUlFNzYLENzGWvx30a0OLlhk6LxCTaoTWKzjq9xp5lrCvo669GtY2
        1OFQW1PKoLNTYI2mnI0UVFg=
X-Google-Smtp-Source: AAOMgpcUmiw51jGjp3stm7YfBsl9dn/HW/TV84mEOLK+6kNWhKxwFfs50S6ZwPWRg3+hhaR5I8WSWw==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr12407758wri.42.1531772124850;
        Mon, 16 Jul 2018 13:15:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m144-v6sm17668206wma.36.2018.07.16.13.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:15:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/7] t/t7510: check the validation of the new config gpg.format
References: <cover.1531470729.git.henning.schild@siemens.com>
        <cover.1531470729.git.henning.schild@siemens.com>
        <e3fc5449ef1fe1d107e11c77f2e66d8d47a451db.1531470729.git.henning.schild@siemens.com>
Date:   Mon, 16 Jul 2018 13:15:23 -0700
In-Reply-To: <e3fc5449ef1fe1d107e11c77f2e66d8d47a451db.1531470729.git.henning.schild@siemens.com>
        (Henning Schild's message of "Fri, 13 Jul 2018 10:41:24 +0200")
Message-ID: <xmqqd0vnszs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Test setting gpg.format to both invalid and valid values.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/t7510-signed-commit.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e2015ed9..1b6a1dd90 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -227,4 +227,13 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
>  	grep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG 'check config gpg.format values' '
> +	test_config gpg.format openpgp &&
> +	git commit -S --amend -m "success" &&
> +	test_config gpg.format OpEnPgP &&
> +	git commit -S --amend -m "success" &&
> +	test_config gpg.format malformed &&
> +	test_must_fail git commit -S --amend -m "fail"
> +'
> +
>  test_done

Since we'd be doing case-sensitive value for gpg.format, this would
have to change in a later iteration, I guess.
