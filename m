Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053A11F461
	for <e@80x24.org>; Fri, 19 Jul 2019 01:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGSBbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 21:31:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39375 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSBbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 21:31:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so13687223pgi.6
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5iY0SpbJ2kHqejdEOZ82mZjaUQecBV+S1+so4XP29LA=;
        b=hEKP6PsldyxmfJIbasfC2jFMYHYq/J3RjzlbdPv3Ad1GqdSkJYYrkRYgp3wcfnOZVh
         EuBWXZlZ/M1TZSbXuSZHuVJB2jK8CaKTvWdH4yphofkBt079Ms8DgZ01r8v5Bl6Pqsmw
         cHh/y9P/KWN0WUVKBJfiiCJfB6SCeYU777ZM7L1O0I55Ejab7n1wbvijquNWpB2iPfoH
         X93IznzNvbzfRPi7YmShidekfZEbfoqquZHDeXQH4b2dP1uG0mbe6oLay6Q4zWEneRxG
         bFTQOK+CNov3x0OIyUmMbJV8yG1cfpxv54v2ql75mRLXLP4nxZzQB3esu28o1u64e0HZ
         t1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5iY0SpbJ2kHqejdEOZ82mZjaUQecBV+S1+so4XP29LA=;
        b=l1Q14CCdLa3YQLvtNblbhoKX/B+aDJs1yq7bGtcGSfHJdHECciubhpExtDYBR715/X
         Bilk6z/0GMtUQNq6v3IVJrJoP0fY8kULq1MDbWwMNkz/YqiitsTHEY64g0yF6qak1xGq
         zAdOB35zl45oPjP014u33IwFzKxYEL2FW7kCNClFeTXBs9r9glwuRFy68q6U1bMew/0g
         xx74FaCnkA+3aNwa5AtruAMaUlqbJQ7EpWtdGJgRfHhe/YWDsx7Cm7x0Yecyq3EWB3iP
         ESrnipXI8cukzBwc9aw9xloVe2GeY45OtuiQQFLqkQCo3MgwzQwHejEpkwXN3eAsoN0/
         KbmQ==
X-Gm-Message-State: APjAAAUJC1byjkV6M1kp71WTR9A8xQcFiQMU1jiG9q1jGUhzdEujkGC9
        jaWv9r1gvPfRPidOtAIm3wg=
X-Google-Smtp-Source: APXvYqxj7qdy15Y5c1/GIzoLIZE3zYF1Zhb5XC8u51UeopubjSjM2pr2mfybi0QmMU0bmTFgOYWdSw==
X-Received: by 2002:a17:90a:9f08:: with SMTP id n8mr54878624pjp.102.1563499891747;
        Thu, 18 Jul 2019 18:31:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p187sm42954872pfg.89.2019.07.18.18.31.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:31:30 -0700 (PDT)
Date:   Thu, 18 Jul 2019 18:31:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190719013128.GB251102@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <20190718152234.GI20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718152234.GI20404@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:

> I expected that this will eventually happen after Travis CI's default
> Linux image recently changed from Ubuntu 14.04 to 16.04; explanation
> in the commit message below.
>
> With that patch issues like this could be caught earlier, while they
> are only in 'pu' but not yet in 'next'.  But do we really want to do
> that, is that the right tradeoff?  Dunno...  Adding a dedicated CI job
> just to check that there are no 'for' loop initial declarations seems
> kind of excessive, even if it only builds but doesn't run the test
> suite.  And I don't know whether there are any other undesired ("too
> new") constructs that GCC 4.8 would catch but later compilers quietly
> accept.

This makes sense to me.  Not really for the 'for' loop declaration
aspect: for that, I'd want some more specialized tool that allows
turning on such a check specifically.  But more because Ubuntu trusty
is still a platform that some people use (though hopefully not for
long), so it's helpful as a representative old platform to see if we
break the build on it.

[...]
> [2] On Travis CI 'make test' alone would take about 9 minutes in this
>     new job (without running httpd, Subversion, and P4 tests).  For
>     comparison, starting the job and building Git with GCC 4.8 takes
>     only about 2 minutes.

Nice.  In an ideal world there would be some kind of "make fasttest"
that runs some fast subset of tests.  But this seems pretty safe.

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  .travis.yml               |  4 ++++
>  ci/run-build-and-tests.sh | 17 +++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)

Thanks.

[...]
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -11,9 +11,9 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  esac
>  
>  make
> -make test
> -if test "$jobname" = "linux-gcc"
> -then
> +case "$jobname" in
> +linux-gcc)
> +	make test
>  	export GIT_TEST_SPLIT_INDEX=yes
>  	export GIT_TEST_FULL_IN_PACK_ARRAY=true
>  	export GIT_TEST_OE_SIZE=10
> @@ -21,7 +21,16 @@ then
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
>  	make test
> -fi
> +	;;
> +linux-gcc-4.8)
> +	# Don't run the tests; we only care about whether Git can be
> +	# built with GCC 4.8, as it errors out on some undesired (C99)
> +	# constructs that newer compilers seem to quietly accept.
> +	;;
> +*)
> +	make test
> +	;;
> +esac

Does what it says on the tin.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
