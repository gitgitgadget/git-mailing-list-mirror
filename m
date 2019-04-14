Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FAB20248
	for <e@80x24.org>; Sun, 14 Apr 2019 02:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfDNCgC (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 22:36:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfDNCgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 22:36:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so16970885wra.12
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U+y0qQKcryO3zkX5E7J9dwbtw1EleBN5Q9J8qxEzLGQ=;
        b=RkbdIjc6rtfZ6oPR895qxtkRDCKp8KcMXP7NO6rvzWxEl+3Qq4CmegJNoL87x2N9pr
         gLySrIcsXE1+pBXvcSYeyGO9T50ufjPcqRyjLDv3UT72O8cKhlyGuirPSSPlpZ/P5PlB
         t61ZGroT5GGwTgZ4FpJ650QiqeqW8HJSLCHR5nJZ3hknkahIlh1rICoUYZAb4AwxZCzs
         uqO3Qtc6+WDjXSW+BgbyZMKHMKc3/TxHfZC130dIkYcxH6SeD/3B5obeoq/oVs1aeaNp
         Tx2WxHIsUhTau3srYKsSKfwkQMrJXUeP7Z5ZeuN60V7kgqltUwb6a7LVn4h5lATBvtzQ
         nX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U+y0qQKcryO3zkX5E7J9dwbtw1EleBN5Q9J8qxEzLGQ=;
        b=NC3g/XAflhufDyjTFN82mZynqxXlCiIAf71kAQ5SJ3hikm0XIGqQS4TWrDouLp9MLE
         /CpCdrLHlGo4dt5cRUDHdhXXSseu8uxLBxdBZWAaMUAT1Q5MgVIOX7aN1Hdh3JtV0orL
         CVaXoEsARO2tskS5gYnj8xSVMR9sFAOrsZPyVeI2qHYXH9anHZv+7/VTlZw5dOaqAZqd
         htUwH1exREGAOyi8OAvPWBW3ykocmD9c+cocyov2FlyECP9rP3cbbpCDFMqlHISeFQN8
         6ZdghxYMA4AAMq1YuLrmhInctwPz8xIq81lblZQriKufxnPWqF+jcP/NHxw3b0h1Nart
         BVJA==
X-Gm-Message-State: APjAAAWdxkXDienCZ7G0DDfWpTrf6xUQ9+CU8Qyu3v2aHhgPtR6YLHdM
        L/0Mfg65VaZApqoydRKYMrg=
X-Google-Smtp-Source: APXvYqwJy+hngLBZIfKwGzDIVdkV1VhHaYjrwGJ9onQflJnE1D5ci9SI7PG7JZ7CPc/q0XYky1V7Xg==
X-Received: by 2002:adf:f088:: with SMTP id n8mr43238033wro.112.1555209359830;
        Sat, 13 Apr 2019 19:35:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r6sm10913100wmc.11.2019.04.13.19.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 19:35:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options (by default)
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
        <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com>
Date:   Sun, 14 Apr 2019 11:35:58 +0900
In-Reply-To: <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 12 Apr 2019
        02:37:24 -0700 (PDT)")
Message-ID: <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	disallow_abbreviated_options =
> +		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);

... which means that the value of the environment variable follows
the usual "true, yes and 1 all activate it"; very good,

> diff --git a/t/README b/t/README
> index 656288edce..9ed3051a1c 100644
> --- a/t/README
> +++ b/t/README
> @@ -399,6 +399,10 @@ GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
>  fetch-pack to not request sideband-all (even if the server advertises
>  sideband-all).
>  
> +GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
> +the default when running tests), errors out when an abbreviated option
> +is used.

OK.

> +test_expect_success 'GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS works' '
> +	env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
> +		test-tool parse-options --ye &&
> +	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
> +		test-tool parse-options --ye
> +'

The feature is activated for all tests unless otherwise noted, and
the above marked the places that need to be "otherwise noted" in a
reasonable way.  Good.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 562c57e685..f1a0fea4e1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -57,6 +57,13 @@ fi
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
>  
> +# Disallow the use of abbreviated options in the test suite by default
> +if test -n "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
> +then
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
> +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> +fi

If the original environment has it as flase, as it is set, the
substitution will yield "isset" which is not an empty string, so we
assign true.

If the original environment is not set, or set to an empty, however,
the substitution will yield an empty string, so we won't touch the
variable.

I am not sure in what situation the above behaviour becomes useful.

Do you mean more like

	if test -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
	then
		... assignment ...
	fi

IOW, we'll take an explicit GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false
as a sign that the developer for whatever readon wants the disambiguation
code in parse-options to kick in for all uses and allow a shortened option
names?

If on the other hand you are protecting our tests against those
who casually have the environment set to false, because they know
some of the scripts they use are sloppy *and* for whatever reason
they anticipate that someday we will start to disallow abbrevated
options by default?  If so, an unconditional assignment of true
would be more appropriate.

I think I can agree with either of the two positions (i.e. we let
those who explicitly want to decline do so, or we unconditionally
make sure we catch issues in our tests), and I do not think of a
third position that are different from these two and that would make
sense.  Between the two, I'd probably vote for the latter if I was
pressed, but even then that is not a very strong preference.

Thanks.  I very much like the premise of this series, and the above
hunk stood out in the range-diff in 0/8.


