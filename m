Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED8F1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 04:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750790AbeFAEGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 00:06:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40512 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFAEGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 00:06:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so285960wmh.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=biPq/NNZvlM5bIYkhsk91OuRbmcYH5Q7Bwbo5vPJEbg=;
        b=IlLD5bXfIsbOBB9fOexR4BaOeMsEJQHoXW33xwFMarxLFSIFfDenk7gGFju0fkG/Xx
         pAJSctCCpL4LhGDXQ5XrKBg3IEDPJF94giZEPTbOkPY9QpZlUMoOHbGLFNc74CiJt7PX
         aQh8UH7/bahr/IfVr0wcG8qKDbGSawYhpJKddOu2H3WuhKzhHVejwmZRwoz2pRNQJdxb
         bXwx8q/8xd9kIW/DStWezToSnqM7qLMGHW0nI4H+gFuiguCtNoJiRN30vEeVqADB9rfL
         TzeabK+C0xFXDWw11C0kYuEXeUJoUtZjmn7sdjqmYnu4vr0xSbDf+TQQ8G47bFdVLfOt
         GY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=biPq/NNZvlM5bIYkhsk91OuRbmcYH5Q7Bwbo5vPJEbg=;
        b=K8YvOdrFUxBDkErXucEwnDljwcLCcQ30wOn7gB1+oooBCnxorAG6hurXaofDBchwYv
         uWeLxR9biB5oU0rOp6G62oiF1NJ1BZwcDCA1fLI+eAggyf74dVGnLhiPeKRrkfga7WmW
         yrjcKqMx5bm657jPKklUvper1o5nHVBDcl6HoEj9lcKtTTJxrUCDoB0qGShBruFVL31i
         r4SyfdT3eC2/8D165MtUgnEk6NCE5h13X1VJuu2RTuIVEU4A2mYyTqoJBMq/hlSdhlby
         tYbIRX93Az0E2qcPAkfhC6HX2OcCFeP6LwcJfe/Sog5JqzWy+KGGCI7oIIr6nhQfXe6L
         pMWw==
X-Gm-Message-State: ALKqPweFWeA6dCtMcBqdicyQTDVdtaS5iHS47sBeWe8saQaQn+aBV9ci
        QQLcuo92UddrcGFNK3VhGCs=
X-Google-Smtp-Source: ADUXVKKpSdRZDlb/8xiuAFJiFEBeJQiiDzQXCcA8WF7blNLNuUNZERFKG7j+hqOFzDYF0w3aZC3//w==
X-Received: by 2002:a1c:a750:: with SMTP id q77-v6mr1389887wme.111.1527825961759;
        Thu, 31 May 2018 21:06:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h65-v6sm999143wmf.7.2018.05.31.21.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 21:06:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/9] checkout tests: index should be clean after dwim checkout
References: <20180531195252.29173-1-avarab@gmail.com>
        <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-2-avarab@gmail.com>
Date:   Fri, 01 Jun 2018 13:06:00 +0900
In-Reply-To: <20180531195252.29173-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 31 May 2018 19:52:44 +0000")
Message-ID: <xmqqwovj882f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Assert that whenever there's a DWIM checkout that the index should be
> clean afterwards, in addition to the correct branch being checked-out.
> ...
> So let's amend the tests (mostly added in) 399e4a1c56 ("t2024: Add
> tests verifying current DWIM behavior of 'git checkout <branch>'",
> 2013-04-21) to always assert that "status" is clean after we run
> "checkout", that's being done with "-uno" because there's going to be
> some untracked files related to the test itself which we don't care
> about.

It might not be absolutely necessary to state, but it would be
helpful to say that you are assuming to start a checkout (DWIM or
otherwise) from a clean state; without the assumption, the readers
need to think for a few breaths why "the index should be clean" is
true.

The intention and the implementation of the change both mostly look
good to me from a quick read.

>  test_expect_success 'setup' '
>  	test_commit my_master &&
>  	git init repo_a &&
> @@ -55,6 +61,7 @@ test_expect_success 'checkout of non-existing branch fails' '
>  	test_might_fail git branch -D xyzzy &&
>  
>  	test_must_fail git checkout xyzzy &&
> +	status_uno_is_clean &&
>  	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
>  	test_branch master
>  '
> @@ -64,8 +71,10 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
>  	test_might_fail git branch -D foo &&
>  
>  	test_must_fail git checkout foo &&
> +	status_uno_is_clean &&
>  	test_must_fail git rev-parse --verify refs/heads/foo &&
> -	test_branch master
> +	test_branch master &&
> +	status_uno_is_clean

Hmm, what's the point of this second one?

>  '
