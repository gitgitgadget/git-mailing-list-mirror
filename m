Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D291F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 17:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfJIRZ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 13:25:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50618 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfJIRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 13:25:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so3517360wmg.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o38eLV6h0jm2EOovid7LC9A6HmwZb2z5muWAlM0MrS8=;
        b=C94Oh9fjYjrU7Ih5SQv9dbIxqbRDzxZmtij7j3Qf5lxElU1guz9J6XSekwISgzEuIf
         n31py3ZW2iLM8jtrHMGJ+nE8MneOHncvvFl/IlhPrUP1X8OfmCpXysF+wPdUUBBHI/oG
         tL62NnNHgyi0ykPOqq4HL1LEX9j/7NZhxeD3ihmomQUMtyhTgO/2fyTTMBhQCuXqghlm
         I7b3d9LecWVwE2Hm36rAIxTwCocFcgPBLJ9xMD/sWQF2NIjNsptmq2+DQ2adheTW3YJD
         3ZCUGb1MZnXFm1sy5kDCogbzmqVQqhK0D/aiCG5t13KinsRX3tSnUreiMRnbMiSQ2pxY
         jGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o38eLV6h0jm2EOovid7LC9A6HmwZb2z5muWAlM0MrS8=;
        b=I1F2h/Qpzfg5KVUVzgnA6oWX/dYR6NE2OjJgkiRmN/qwLP6SBceJi28mo9LEoCi7hS
         /wR3X7D4d9jTkbTVmk+cZfPKezLD7xf6oBGHmrF1DmE8UCrQD+Vuxk2Hcb4eEJgh7R2F
         AYn7GDAeskvUHnuo/wQpvxUe4KtzWpwKBRIVPKpvQZuOXLMgdj002cDXv/6v8cRC7DQZ
         yO2j5N84/Q56F36A9Z25A6CFuK3NhGn86pSuFj+u637uI7E0o3FhowmvKNoTBFCUnxko
         JamDdAD/VZ6so87KJqZddMCNY7WA2ENltHbyhJ+0qQV3otm8Z87/AOUNHWC0Mt/Okk4g
         zK7w==
X-Gm-Message-State: APjAAAUvoWETJB3A9R/vgmWXl/g+37EXzE7nUC1cjFLJNGtL/lp0iDzy
        bacE3vOSpprKL98v79Q/CYJPmp5F
X-Google-Smtp-Source: APXvYqw2OyvNZgo/rkbkmBMEX69fQSAbylD1JDmv94SA+GiEuxL+gipXv5DmVdJcDbO5ZeT6gFjuhw==
X-Received: by 2002:a1c:8189:: with SMTP id c131mr3534518wmd.151.1570641954426;
        Wed, 09 Oct 2019 10:25:54 -0700 (PDT)
Received: from szeder.dev (x4db349a5.dyn.telefonica.de. [77.179.73.165])
        by smtp.gmail.com with ESMTPSA id x129sm5154831wmg.8.2019.10.09.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:25:53 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:25:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20191009172551.GI29845@szeder.dev>
References: <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
 <20190923165828.GA27068@szeder.dev>
 <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
 <20190926132852.GF2637@szeder.dev>
 <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
 <20190926214448.GI2637@szeder.dev>
 <20190927221857.GB31237@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927221857.GB31237@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 06:18:58PM -0400, Jeff King wrote:
> On Thu, Sep 26, 2019 at 11:44:48PM +0200, SZEDER Gábor wrote:
> 
> > All that was over a year and a half ago, and these limitations weren't
> > a maintenance burden at all so far, and nobody needed that escape
> > hatch.

> I'm actually surprised we haven't run into it more. We have some custom
> test scripts in our fork of Git at GitHub. We usually just use
> TEST_SHELL_PATH=bash, but curious, I tried running with dash and "-x",
> and three of them failed.

I try to avoid using TEST_SHELL_PATH at all costs, it is far too keen
to not do what I naively expect.

> Probably they'd be easy enough to fix (and they're out of tree anyway),
> so I'm not really arguing against the escape hatch exactly. Mostly I'm
> just surprised that if I introduced 3 cases (out of probably a dozen
> scripts), I'm surprised that more contributors aren't accidentally doing
> so upstream.

I see it a bit differently.  Over a decade we gathered about
twenty-something such tests cases: that's about two cases per year.
You added three such cases in about a year and a half: that's two
cases per year.  The numbers add up perfectly, you singlehandedly took
care of everything ;)


Anyway, I did some more digging, and, unfortunately, it turned out
that Dscho is somewhat right.  While the situation is not as bad as he
made it look like ("We need Bash!"), it's not as good as I thought it
is ("But it Just Works!!") either.

  - Some shells do include file descriptor redirections in the trace
    output, and it varies between implementations to which fd the
    trace of the redirection goes.
    
      - 'ksh/ksh93' and NetBSD's /bin/sh send the trace of
        redirections to the "wrong" fd, in the sense that e.g. the
        trace of commands invoked in 'test_must_fail' goes to the
        function's standard error, and checking its stderr with
        'test_cmp' would then fail.
 
        (But 'ksh/ksh93' doesn't really matter, because they don't
        support the 'local' keyword, so they fail a bunch of tests
        even without '-x' anyway.)

        I don't think we can do anything about these shells.

      - 'mksh/lksh' send the trace of redirections to the "right" fd,
        so they won't pollute the stderr of test helper functions.
        And indeed the test suite passes when run with 'mksh' (well,
        at least the subset of the test suite that I usually run).

  - We do call 'test_have_prereq' from within test cases as well,
    notably from the 'test_i18ngrep', 'test_i18ncmp' and
    'test_ln_s_add' helper functions.  In those cases all trace output
    from 'test_have_prereq' is included in the test case's trace
    output, which means that during the first invocation:

      - there is lots of distracting and confusing trace output, as
        the script evaluating the prereq is passed around to a bunch
        of functions.

      - after running the script evaluating the prereq 'test_eval_'
        does indeed turn off tracing, so there will be no trace from
        the remainder of that test case (except with 'mksh': while it
        does run 'set +x' in 'test_eval_', that somehow doesn't turn
        off tracing...  I have no idea whether that's a bug or a
        feature).

    As far as 'test_i18ngrep' is concerned, which accounts for the
    majority of 'test_have_prereq' invocations within test cases, I
    don't understand why it uses 'test_have_prereq' in the first place
    instead of checking the GIT_TEST_GETTEXT_POISON environment
    variable; and 6cdccfce1e (i18n: make GETTEXT_POISON a runtime
    option, 2018-11-08) doesn't give me any insight.

    I recall that some months ago we discussed the idea of how to
    disable trace output from within test helper functions; that would
    help with this 'test_have_prereq' issue as well, at least in case
    of the more "common" shells.

