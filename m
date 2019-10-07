Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3897D1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 21:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfJGVDL (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 17:03:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34945 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfJGVDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 17:03:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so923514wmi.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5urEUDGNJAIcbh7MTmoh0X4Ncbc5BdyGuF0hrKpgkE=;
        b=dFvTBUEBRvdzvQUKqjXxsNAMBsOL4IuSBnXSdSrK3Zd26QcMpXQF0uz0onGNvGSFyX
         LUBTYVdinmyROVrvZgeCpNyKft7VLf6ZJMIxy2sau06scQ77EbKG7T0bhskyOZ+Hjoh+
         /i8zxqmmgp1yzyOF9LUiE2GunC75SbbJCw4uNU+0LaqGGukUcZdw6mo02fBt4HdAS5Oc
         AlKFNJhSYr2pbcLie+CmRc8nGlucfXuVEbZx4hesKY6d0EtmPAdcI6Hxe6ai8k7Va+F8
         ITAxYSiRmnN6FC7RVpZ2BE9em8NZDAp+F7XDZdaF1L6H8eodtfeFillAW0ilz8XZJd1q
         tE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5urEUDGNJAIcbh7MTmoh0X4Ncbc5BdyGuF0hrKpgkE=;
        b=TNH0X3ht/iXnRQy0EpPhmFmbtCzfRTzSEwN97P9qktrRYp8uuuaz/faGClVzPCarUU
         FekSZQIb+M5rC3kO6xPPd4Lgb3HTd+I4EoRdWrCsfgmOuBKMgMQVeBCG6AWlyg4PAuGJ
         UHUypXAvX2G0CX3XMzuVGH0jX16QUCAqt9YlAqHrWinootK2gyDEOFKZfhsjNqNjtL1V
         TSSsD39Rgs6YlldXPWzvOLXA9nQbQ0Ht6ZF7hSpi/3Bsx9+Jf0iebZj1CAjP6KIHIuR6
         UGdhW6xwRPsoo/tOMJJSdEQikXOjZkCMMWHOyYB+KCwlpzJuITHWe5qaPee8c9YFM3zt
         maRg==
X-Gm-Message-State: APjAAAXQ2UvCcx86ELPZb8sbse7RCPzTJg/hjn7nFanDTrObf0RxHKJe
        DjE56yW5TroTXvLjirAEjRs=
X-Google-Smtp-Source: APXvYqx3aVKV1EtE8z1GCFmIrgt+SyNUp2UHXpgh/HKWAeAao6yxSapfuuB0BvXkNx3629TioAXI8Q==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr880493wmc.11.1570482189120;
        Mon, 07 Oct 2019 14:03:09 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id o4sm33560072wre.91.2019.10.07.14.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 14:03:08 -0700 (PDT)
Date:   Mon, 7 Oct 2019 23:03:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 1/2] format-patch: create leading components of output
 directory
Message-ID: <20191007210306.GF11529@szeder.dev>
References: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 05, 2019 at 10:43:51AM +0200, Bert Wesarg wrote:
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 83f52614d3..2f2cd6fea6 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1606,6 +1606,26 @@ test_expect_success 'From line has expected format' '
>  	test_cmp from filtered
>  '
>  
> +test_expect_success 'format-patch -o with no leading directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches master..side &&
> +	git rev-list master..side >list &&
> +	test_line_count = $(ls patches | wc -l) list

This is sort of a nit...

So, these tests check that 'git rev-list ...' lists as many commits as
the number of files created by 'git format-patch'.  While it doesn't
affect the tests' correctness, this is subtly different from checking
that 'git format-patch' created as many files as the number of commits
listed by 'git rev-list'.

Consider how the tests' output would look like on failure:
'test_line_count' shows an error message that includes the content of
the file to be checked, which in this case would consist of a bunch of
commit object ids:

  test_line_count: line count for list != 3
  f7af51d27933a90554b6e9212a7e5d4ad1c74569
  bd89fce9f5096eb5cad67c342b40818b7e3ce9e4

On one hand, these object ids won't mean much to anyone who might have
to debug such a test failure in the future, and on the other these
tests are about 'git format-patch', not about 'git rev-list'.  If the
check were written like this:

  count=$(git rev-list --count master..side) &&
  ls patches >list &&
  test_line_count = $count list

then the error message on failure would look something like this:

  test_line_count: line count for list != 3
  0001-first.patch
  0002-second.patch

which, I think, would be more useful.


> +'
> +
> +test_expect_success 'format-patch -o with leading existing directories' '
> +	git format-patch -o patches/side master..side &&
> +	git rev-list master..side >list &&
> +	test_line_count = $(ls patches/side | wc -l) list
> +'
> +
> +test_expect_success 'format-patch -o with leading non-existing directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches/side master..side &&
> +	git rev-list master..side >list &&
> +	test_line_count = $(ls patches/side | wc -l) list
> +'
> +
>  test_expect_success 'format-patch format.outputDirectory option' '
>  	test_config format.outputDirectory patches &&
>  	rm -fr patches &&
> -- 
> 2.23.0.11.g242cf7f110
> 
