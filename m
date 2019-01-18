Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2BC1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 19:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfARTYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 14:24:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfARTYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 14:24:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so16415408wrt.7
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GNeThrazpUQtSgwtaii/QaZThXsTzNbEOayiMGhRf6o=;
        b=ae13jdKa3FO09JvIzA4fzbSqJftwvFGzp6AAxTJRU13FHnPQwk2IqJqG/V9P7xyQSj
         uDf7Nf62iCMptpdXCxXnVp/ZMBNnEaO6x9+uHVkV0NOWNnxq40tOGPevtNZALiaWVOZu
         V4uQM6nxDMXwet/NCgBEK/PPySjBKtELw+J3LInvARpX5/TGe9TgpPS50xpDf/AF8vBi
         ENwPSeUo60SxwACOsTgi+faWD2bbVHonmzK56VDzcmefnKtjyVZktzs2lGpQJDee3oXr
         3c7ab5ZfyY2J6SwSG0WwyBoGLkywLiyVPuWMR+E1gMOtF8pOvoUedIS/nUfK9QzsEcU6
         fLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GNeThrazpUQtSgwtaii/QaZThXsTzNbEOayiMGhRf6o=;
        b=icGKPP448ssWJz+4VnjqBoHkctvX6DpbVOvi7inIWPf8u4z8IdPXWL3t8xcjeF8YqY
         ntOj3kMx2YzVInZZjq0e/0Rfq6qEnh0TSpCCwmSc6V1FsW8C5pcymOoW1HxBHKm645WA
         ARNJWS1fUKxxyiacEzpAFKAxZlqADZHqYodlyxsK4vKqKxQPrmFUKVORIW8leKV+Fdhd
         Oqb/EzCCBFTzx4raq8KSTzj8dNM/8pakIIQoXNEO+8KsFyfeUnXO0e3y9WuzkWMKq7V1
         NmGkSZomy4osajDfSb7gm0jAs91yB5MshQotmA84ZjEg3mM4mUyaKxNbwd/AOoPrKrOJ
         /yGw==
X-Gm-Message-State: AJcUukebf3GYd/+R1FmiLW/QrxM8W+vjvZD4YS2wQKlK5x+YK8mRI/gz
        RmfD4e1DABIZhv/qUn88fPk=
X-Google-Smtp-Source: ALg8bN4qP/a/n38eosUuxZ0MsoNmQrLiGDkdWE1rwKYH9HS5ekfhOEArd0Z0+oEj32zwARIVo2f8mA==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr17574361wrq.38.1547839442460;
        Fri, 18 Jan 2019 11:24:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w80sm58678635wme.38.2019.01.18.11.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:24:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 5/5] Add `human` date format tests.
References: <20181231003150.8031-1-ischis2@cox.net>
        <20190118061805.19086-1-ischis2@cox.net>
        <20190118061805.19086-6-ischis2@cox.net>
Date:   Fri, 18 Jan 2019 11:24:01 -0800
In-Reply-To: <20190118061805.19086-6-ischis2@cox.net> (Stephen P. Smith's
        message of "Thu, 17 Jan 2019 23:18:05 -0700")
Message-ID: <xmqqpnstkbvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> +check_date_format() {
> +	format=$1
> +	t=$(($TEST_DATE_NOW - $2))
> +	expect=$3

Notice that neither $format nor $1 is used in this test, which means
that "check_date_format" is not a generic "I can take a format
parameter to check the specified one".  So perhaps

	check_date_format_human () {

and then lose the first parameter?

> +	test_expect_success "human date $t" "
> +	echo $TEST_DATE_NOW >now &&
> +	test-tool date human $t >actual &&
> +	grep '$expect' actual
> +"

Hopefully $3 does not have a single quote in it ;-)  

But the test block can see the shell variables just fine, so writing
it like the following is more in line with how the test framework is
designed to be used.

	test_expect_success "human date $t" '
		echo "$TEST_DATE_NOW" >now &&
		test-tool date human "$t" >actual &&
		grep "$expect" actual
	'

How is the file 'now' get used?  Nobody seems to read it around here.
Is the last one supposed to be "grep"?  Or should we do

	echo "$expect" >expect &&
	test_cmp expect actual

instead?

> +}
> +
> +check_date_format human 18000 "5 hours ago" # 5 hours ago
> +check_date_format human 432000 "Tue Aug 25 19:20" # 5 days ago
> +check_date_format human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
> +check_date_format human 13000000 "Thu Apr 2 08:13" # 5 months ago
> +check_date_format human 31449600 "Aug 31 2008" # 12 months ago
> +check_date_format human 37500000 "Jun 22 2008" # 1 year, 2 months ago
> +check_date_format human 55188000 "Dec 1 2007" # 1 year, 9 months ago
> +check_date_format human 630000000 "Sep 13 1989" # 20 years ago
> +
>  test_done
