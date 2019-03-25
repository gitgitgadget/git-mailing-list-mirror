Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EFB20248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYU0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:26:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44708 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYU0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:26:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so7641810wrn.11
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qp0ZCRoJCPCLkgvMPhKJUyJbNEI6tOmOvxb6wvm/tWA=;
        b=LW0ghiWQKbsUIQG1xdBA9HVErckXkrimn+QQI7uvZOSPWVVarnn0FWyKwQ0a+V6BSj
         99UiIHRD3ww9WZ8/2igYeODLdPFamKsm8uCE1EeUGrhZWAdNFgOfO3vHv0aEZSX4FByj
         I/9KUFYRBv3N+RmGteCu0AFu7qdaMODexPxhrc4XWK8tJ/VA+reC5PHGygFcTJ6fcSaK
         oWRj5ZPftU2+cHIutknCpZyERgPZOA3m0YyUVM2gMNdSo1UCB8o0tTrzidNDFMmKzYLC
         FTFN2hA+m+eDMgPOwW0hpuknezZo0o/2kBbAa9y4Hr4hwLZIJRg66rO+uGWWmw7LBwui
         FqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qp0ZCRoJCPCLkgvMPhKJUyJbNEI6tOmOvxb6wvm/tWA=;
        b=jft/f7BISFbAMYeYNbD/eWeiWaP/VibgKRn8PTGgPqcSZkGkZ+JwpUp/B/ndMzfqv1
         dM6Bwtsypy/F1wc/JQStB1UlKBW6D4P8lVJHdnlSgjygQ4BCV6+Y4peo82VUQ3XvXrpp
         gc8xDjmxOiiE4sX0wEnZSV87bpbTugSbKtFSIkGml3O/Ufco0pmbLqeg5OviuR64UY0D
         x/qCndB7Nv++tLE5hoV64fCNce5RkrAGIm1XaelqBhtDHc4e9Yw6fL39UnglToaBNcEL
         bKuutqrHn7NasMm5oRv9E8t30QNLqWhI+zNwEm73FSszurT75G+cT+Bq0opo2JvfBX76
         patQ==
X-Gm-Message-State: APjAAAVWaM5HYKO1/t+kiePH52EvmzqVMLmTwGWGhpjWtf0hrMh/QfqA
        Z750T7bmMZipKBM/BMJWz3w=
X-Google-Smtp-Source: APXvYqwnflxVZ+4T6AzPCLxxoEFn9frb9Eer8IjZBQzi0aRThmUnvIOH4Z17FUC0b8zMALYuokeTYQ==
X-Received: by 2002:adf:f286:: with SMTP id k6mr8444041wro.137.1553545611582;
        Mon, 25 Mar 2019 13:26:51 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 3sm22588986wrk.68.2019.03.25.13.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 13:26:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by default)
References: <pull.167.git.gitgitgadget@gmail.com> <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com> <20190325183505.GA28920@dev-l>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190325183505.GA28920@dev-l>
Date:   Mon, 25 Mar 2019 21:26:49 +0100
Message-ID: <87r2aubsza.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Denton Liu wrote:

> Hi Johannes,
>
> Thanks for catching this. Perhaps I should've been more diligent and ran
> the entire test suite before submitting but I was running low on
> batteries only ran the rebase-related tests.
>
> On Mon, Mar 25, 2019 at 11:14:23AM -0700, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> @@ -325,6 +329,7 @@ file: (not set)
>>  EOF
>>
>>  test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
>> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
>>  	test-tool parse-options --no-ambig >output 2>output.err &&
>>  	test_must_be_empty output.err &&
>>  	test_cmp expect output
>
> Would it make sense to include a test case to ensure that
> GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is working properly?

To elaborate on this since one might wonder "but aren't these those
tests?". I think you mean if we shouldn't have a "test_must_fail" test
there that asserts that parsing the options will die with the default of
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true. Yeah, that makes sense, it's
currently a blind spot that we just assume will keep working.
