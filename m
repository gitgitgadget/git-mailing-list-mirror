Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C4F20248
	for <e@80x24.org>; Wed,  3 Apr 2019 07:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDCH7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 03:59:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33185 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCH7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 03:59:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so20001562wrp.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4h0pVr5+3I9WJ7s0HukXqdFTNwezVMfXDbHevGUNhBs=;
        b=FvPR3ZAUBsi+mWAQgPzBQkLrhQDRtVS4CilUe9GY1LTp8BVB1NpXTUjZCDcvC8iLU5
         W0n6EG3DX+TWHVeepVWOhqVJDMjh4PHPcPfxBn0p5IlGF3C/iWN5vDDpcfKPicQp4L2K
         K2gE6eGaB7zo2OL18XgQOo3WbmPJrK35UujCVdxO5+YKiRejNc8qxwEyNtnwMaXkYXOm
         oxoAOP7CgMkXVFLRovqjGfUFzzmsNZI0SlF3E1rah7WdD3slcg1DvK65j1FmswQbPHtI
         U0NbkC1Vz7Tr5/9AKV+1KHZsbMKEQalwS+q5Bs7j6QkxvwVcRxMf8EAYgw9kBJvkyoUR
         EFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4h0pVr5+3I9WJ7s0HukXqdFTNwezVMfXDbHevGUNhBs=;
        b=hTt8diKiP8KJgnZp4B18RghEBuNY/HrHQfsIBgACRIKRl8IZO2rrPAoEu/icNlBVsh
         noODeoc02gHTAKX8fVebpvNmRbXmcMizpjrz6WrNfPC02BuudPtrw+hh1VI5DRw48S/1
         9pQWqEQgIjipmEhoJnkellUUxSQDpTghEuRAHo9QEyl4xBgGI29wREkH3U0ZFrMe4Ph5
         Ig8xzF9HIsNZEBfDXuboV0GBXoBL5mj1w82TFG3E0yA7MAK/rIOJEaSrL65QbhQaTC1T
         ryC77jz8hwtModilUMn0oqADkHXeYIQ2H7TImOs2vpmj5irMA6CE/dE4/FMkeMqPNOk8
         ofzQ==
X-Gm-Message-State: APjAAAW5suQ8j+g6+KsH7+wB2xGh4WZXdjFihdOKxW0sUbkXZA5oafO7
        UgXOq7KCdQismAYy2gzUWRI=
X-Google-Smtp-Source: APXvYqw32+rlpd+nMTuDAdBabiG17p3fthHT6ttEc/7UzHq6GiaHJn5kXFIMRBq1wB6AIhxOJ4wZ3g==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr5916951wru.130.1554278344123;
        Wed, 03 Apr 2019 00:59:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x18sm20825525wrw.14.2019.04.03.00.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:59:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v2 2/4] t3000: move non-submodule repo test to separate file
References: <87lg1eq146.fsf@kyleam.com>
        <20190402183505.31512-1-kyle@kyleam.com>
        <20190402183505.31512-3-kyle@kyleam.com>
Date:   Wed, 03 Apr 2019 16:59:02 +0900
In-Reply-To: <20190402183505.31512-3-kyle@kyleam.com> (Kyle Meyer's message of
        "Tue, 2 Apr 2019 14:35:03 -0400")
Message-ID: <xmqqlg0rsent.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> a2d5156c2b (resolve_gitlink_ref: ignore non-repository paths,
> 2016-01-22) added a test to t3000-ls-files-others.sh to check that
> 'ls-files -o' does not die() when given a subdirectory that looks like
> a repository but is actually a subdirectory containing a bogus .git
> file.
>
> Move this test to a separate file in preparation for testing scenarios
> with non-submodule repositories that are not bogus.

It is unclear to me why this is needed.

> +++ b/t/t3009-ls-files-others-nonsubmodule.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +test_description='test git ls-files --others with non-submodule repositories'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup: expected output' '
> +	cat >expected <<-EOF
> +	expected
> +	output
> +	EOF
> +'

I think this is overkill.  Usually we have one expectation for a
single test, so having the above inside the actual test below makes
more sense.

Or are you planning to add more tests before the test_done we see
below, all of which expect the above output?  It would make perfect
sense if it were the case, but I do not think that is what is
happenning here...

> +test_expect_success 'ls-files --others handles non-submodule .git' '
> +	mkdir not-a-submodule &&
> +	echo foo >not-a-submodule/.git &&
> +	git ls-files -o >output &&
> +	test_cmp expected output
> +'
> +
> +test_done
