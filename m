Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C5F1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394909AbfBMVnc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:43:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391795AbfBMVnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:43:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so4218699wrs.8
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qBarx9mmaVL56OL1z83yyRmA8uxa/4rEGK1JN3WjAQs=;
        b=m+/w5d6kZdhbTNbJMgvQi/tLr7D+xXWyHk1QCcGR90l3xKFvLSvmDtpzd+JeS0izYp
         JQDfv6w6RoeSNDHh9dsAEIhDy/rsZujt/+mz88ICSGICezeOYzppcOMMsFfKaMg9Pxzn
         0z79anV3D8jelhcgihHVcL6Ao61tJYalroH0/GQNuDK/JzKcc1hfDnXjnA/eobGv9+6f
         VgUOtWv7e5HoQo+fQgGe3IN9nVVEu3cmRtWRPcgY1XXf8E28oVaW1nNnzzdJHYk4ApCE
         zUcBjOFuwI6DHBugl5xQlfZtMTz12S10fSFbrCL1tEBNc9X0HYVs8PWvunb4dXySjJmy
         qIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qBarx9mmaVL56OL1z83yyRmA8uxa/4rEGK1JN3WjAQs=;
        b=uEUM0sEIjk3QhGUmW4JIjDrZr0xZPa6yXEud5BLY89SyG8XdiW7mlpWBGYYhVJWPni
         Rn4fiRQ5DvdMgT9yqi2vlGuFk5OUzgHanmpCGH07TxYRe6QY9Gh/83VnjmxgcU0keOoS
         yYah0mD79w0PfOyxISE8V0RbjHNGSvC1kyaHtV5affxz1gFjlTSMUST1kL4mNr+jUHwC
         ZPqBZQlpHT0DE4qXB7Q7QKfcxGcN6K6hUGKHhb537EC7wlE13awDiP4zwDthMZyP9KJj
         w8umNygYRJIXlotC26ECSJi4A7xjF5PEGztxJ3xfYzAr1URNQlkgGvRdV6SNuLVSldTj
         y08g==
X-Gm-Message-State: AHQUAuZ7hU8M1+ZTHtPv2lqBzjXoZ9FdLX1iNi0mk27Ehd6NSAn4r/BM
        R1FMwY0qHCs4Cqwfc6JFIx4=
X-Google-Smtp-Source: AHgI3IZF5yL/e9MmKZCmm6MbLW+FQYXxdABe2fKeFy1JfmxnmbI3HI15sZZ35MnXsJ8CWF5MYR2Z1Q==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr147525wrx.303.1550094209574;
        Wed, 13 Feb 2019 13:43:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l129sm260355wml.42.2019.02.13.13.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:43:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        hsed@unimetic.com
Subject: Re: [PATCH v2] tests: avoid syntax triggering old dash bug
References: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com>
        <20190213115951.12096-1-avarab@gmail.com>
Date:   Wed, 13 Feb 2019 13:43:28 -0800
In-Reply-To: <20190213115951.12096-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Feb 2019 12:59:51 +0100")
Message-ID: <xmqqd0nvbbzz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Avoid a bug in dash that's been fixed ever since its
> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
> released with dash v0.5.7 in July 2011. This failing test was
> introduced in 5f9674243d ("config: add --expiry-date", 2017-11-18).

Thanks for not forgetting an year-old topic.  The offending commit
predates 2.16.0 that is a while ago ;-)

> This isn't a 2.21 regression, but sending it in the rc window anyway
> in case you'd like to queue an obviously working minor portability
> fix.
>
>  t/t1300-config.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 9652b241c7..428177c390 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -892,6 +892,7 @@ test_expect_success 'get --expiry-date' '
>  	1510348087
>  	0
>  	EOF
> +	: "work around heredoc parsing bug fixed in dash 0.5.7 (in ec2c84d)" &&
>  	{
>  		echo "$rel_out $(git config --expiry-date date.valid1)"
>  		git config --expiry-date date.valid2 &&
