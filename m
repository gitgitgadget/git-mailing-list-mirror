Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F102A1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 09:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbeKVTws (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 14:52:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42373 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 14:52:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so7075003edp.9
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 01:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yR/dseF0Bf8s2FTCaELM3tKowVn6Jv2ve3+yKGDl6t8=;
        b=sv0de5g2MYsuo2z9RVkkSpEDg1CgZOuZ2soNw/cutT9HboJ1k+VPxl6g5kHi8C/0sT
         CNKn1iCN8LBxB5yZ1qyftYyqEaiEZW81foAGdCvOHb72Es0ji1FZPZ5n1UCMisdmnH8D
         yZyMVX6a2ErNpgi+V62ESftzOMzreOCB3qABOySj2yjMnYD9U3nh9INUu1+VPXbUEaFF
         Hc8De7ANU4xWid6YR5l7HqO/czww5GJkPQkoM6ZPVFJm6g0WH3pTuLVEqlTlH8sszAoa
         jb4nGm3qTF1bT7Qmo10HLQKlQ3JuGn6SFk+8JsiVsaiZxklgAnq4KemtIzDoirawFn1n
         TgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yR/dseF0Bf8s2FTCaELM3tKowVn6Jv2ve3+yKGDl6t8=;
        b=cjJke0zyWDtmFfQDedsIk4coZCXLVGUKhJkDr6kfUGGj3N5KYMcHNHTt+Aqd2zNN8n
         +yvM62r7MKns1ZoeMhqJJBLh2b3MOqiTZ1XB/Pn4q3XvOZiQ6U/usa/NwHZlI1L7D5Ua
         wnx6c+8J0LiZWSFBkoudhnvXcs23vaYrdB2/CJQJxTA8gB+1p9T+dDD59570UyiYbgLC
         xFfKfC1Lz341SudqZKiURZbcv6vev/iazw25wL5Y/9YJt73GMwi26r3erXnND7dROI4T
         Bk/Ls2hHg8DuFdbsK6qM3IpnF4r4kGm1aqCnfNXVAx7FK2OLqoUlteVzJRpq6EYB+Oix
         q2hQ==
X-Gm-Message-State: AA+aEWbwHncgOUS4AMhe4nc9ilOGTHjFaG5AXiAQKXHA5MOgmPSvyVCJ
        T6y5pPwxp7UN2fB6fhxaim4mUvX2
X-Google-Smtp-Source: AFSGD/UmZ5vgqLS4Rv8nlzchtqrdM7m9B+L311MynlITDQ7otcSrBd9PxMneL9WjRx/g2dSlT8JxAQ==
X-Received: by 2002:a50:b222:: with SMTP id o31-v6mr9049286edd.11.1542878050818;
        Thu, 22 Nov 2018 01:14:10 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id c2sm13757669edv.14.2018.11.22.01.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 01:14:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v1 2/2] log -S: Add test which searches in binary files
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de> <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
Date:   Thu, 22 Nov 2018 10:14:09 +0100
Message-ID: <87lg5lzd7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 21 2018, Thomas Braun wrote:

> The -S <regex> option of log looks for differences that changes the
> number of occurrences of the specified string (i.e. addition/deletion)
> in a file.
>
> Add a test to ensure that we keep looking into binary files with -S
> as changing that would break backwards compatibility in unexpected ways.
>
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  t/t4209-log-pickaxe.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 42cc8afd8b..d430f6f2f9 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -128,4 +128,15 @@ test_expect_success 'log -G looks into binary files with textconv filter' '
>  	test_cmp actual expected
>  '
>
> +test_expect_success 'log -S looks into binary files' '
> +	rm -rf .git &&
> +	git init &&
> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -S a >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_done

This should just be part of 1/2 since the behavior is changed there &
the commit message should describe both cases.
