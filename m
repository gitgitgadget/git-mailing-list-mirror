Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323421F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeCUSW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:22:29 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33659 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeCUSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 14:22:28 -0400
Received: by mail-wm0-f44.google.com with SMTP id i189so7571114wmf.0
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AQsdk6ZxB3FbAfxdVzyjbZpD2Xq2jwZ/G4G1+IUCOvA=;
        b=iQRri0mYWZgBteAtjt7KvMFS33rv6DenG5Cq9qhBEkD2GtZSKhHpDw2jYc5VF4xkj6
         pR1J9OIvUSC75pdMk4I6iVm9lDz78UXJpJ5cFe8Vpv7617a78Inw8FAHZqOtLLO23cid
         u60kuctYBw6M45D3BAucFiXQphYqn5UQQunbNH4gN0qJr7clGEgUua/kTK5lAvqFBEAA
         DxYsNGs66szrxpj3Cj5N5kwU3Y6UZse8l1gIVCCfpVx1vkAz2bADEQzsbtHndM1xPM8f
         f/bSeKHMkTsgJuAU2Ez/2zCjn8+XST2SZ2kxzCwmJHOMU4H+wwq97Q3nVwXIAvw9Ic0a
         5ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AQsdk6ZxB3FbAfxdVzyjbZpD2Xq2jwZ/G4G1+IUCOvA=;
        b=Kjn5qVfJxdCXWsC6RtZd3YztT5rEite9F/gEQgdjpZZuZUVyo3KD4SHDE1SVC+U13t
         W8YBK/uuHs6xOsuHLlTXe1xPihGbVWKdSGA4tVYvHUqN3xeDmK1DTZf8FYtt6RKbe536
         twQxzQlwy9f/Oh4eK0BMyPLXZDl3PATa+feitbByM7T9ZAOyabSjAZjXHq7Prm+0iwnc
         hN6LUtgGIlp4h4skzwnTUZFJTtJrOItcMKLEkfnHhAZOGiWdLlKucSZ8JxFHbEE53JPL
         NUjKoroG1wEjTnnHazuUNYMMaYgNFY5r9eLu9mRT09Z1YMZHg7dz0g5bMgoTy5Sl7pCn
         EaGw==
X-Gm-Message-State: AElRT7FNf2yfb0lra75fa2DJAtAJd1DpMTh4TBDGCf2ZpJAQqLpyrrUT
        JZWzDijja72TkqI1WAS6OKM=
X-Google-Smtp-Source: AG47ELvvTaij/kZrDAn69QZoCbAvMXQQyTUpqXY6JFm0I31xNbcfz6FNGbWHcNKzpGT0/qJo+Wz6Ew==
X-Received: by 10.28.158.197 with SMTP id h188mr3601460wme.72.1521656547367;
        Wed, 21 Mar 2018 11:22:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x18sm4478201wmc.2.2018.03.21.11.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 11:22:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v6] parse-options: do not show usage upon invalid option value
References: <20180320175005.18759-1-ungureanupaulsebastian@gmail.com>
Date:   Wed, 21 Mar 2018 11:22:25 -0700
In-Reply-To: <20180320175005.18759-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Tue, 20 Mar 2018 19:50:05
        +0200")
Message-ID: <xmqqk1u5p9um.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
> new file mode 100755
> index 000000000..ac96bc3b9
> --- /dev/null
> +++ b/t/t0041-usage.sh
> @@ -0,0 +1,107 @@
> +#!/bin/sh
> +
> +test_description='Test commands behavior when given invalid argument value'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	test_commit "v1.0"
> +'
> +
> +test_expect_success 'tag --contains <existent_tag>' '
> +	git tag --contains "v1.0" 1>actual 2>actual.err &&

It is not wrong per-se, but >redirection without a number redirects
fd#1, so "1>actual" is an unusual way to spell ">actual".

> +	grep "v1.0" actual &&
> +	test_line_count = 0 actual.err
> +'
> +
> +test_expect_success 'tag --contains <inexistent_tag>' '
> +	test_must_fail git tag --contains "notag" 1>actual 2>actual.err &&
> +	test_line_count = 0 actual &&
> +	test_i18ngrep "error" actual.err &&
> +	test_must_fail test_i18ngrep "usage" actual.err

test_must_fail mustn't be used like that for two reasons

 - It is to be used for "git" stuff, because it knows failing with
   segfault and other failure modes are _wrong_ and should not be
   happy even if the command "fail"ed.  We however do not expect
   commands that are not git (e.g. test_i18ngrep) to require special
   casing of the failure modes.

 - test_i18ngrep pretends to always "have found match" when running
   under GETTEXT_POISON build, so it will pretend that usage exists
   in actual.error.  test_must_fail will then say "oops, the string
   'usage' shouldn't appear in the output but it did", which is not
   what you want.

Perhaps

	test_i18ngrep ! "usage" actual.err

is what you want to say here instead.

In any case, the tests got a lot cleaner compared to the previous
round, and I feel that this patch is "getting there" ;-)

Thanks for working on it.
