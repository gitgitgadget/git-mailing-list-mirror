Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92951F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfA2ReO (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:34:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36591 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfA2ReO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:34:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so18687718wmc.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=80YVyAPs4v7DgysnixptzWHLxhV1qEvNtXZ3gqzD0LM=;
        b=Nf+jPT7xpTRNPaNvZI4nGS6VaMCQF60nNhPwuBNYL8h7OvjDnBceZamwA2h2NvgYqf
         KqixRANKmsSeaCi0GZ/Q1/4wjFX2TKEWXs/lyBdYrCxhpOYnGm1/AVofyVCC8PmRpkEo
         VyV/N7UIjla+UOKX3refFPxCCBXPWQ7dM9kMYCpppA5LFavAq3+IJsaSDhGZ4IZjfVec
         hy4cYyuZkt4LtwxkL4v/7PfyRKPfufIVEsvC9O5IxqVBajPYOcLV2K7369/HfoqalHmr
         9Ki6AQzfIoo1UuYQOBLnZiLkxUJ5dWo7KhdhD99QZL0qGliN/zhCcJSBQS8bpynb66AU
         5H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=80YVyAPs4v7DgysnixptzWHLxhV1qEvNtXZ3gqzD0LM=;
        b=jdF1cthY5NNW4NJXC0PlSC8md1n1+4rDhuB+jpuI6dMqjoVdyzuTtw4AT4c8cyP7ri
         B68g9Inwy9IdaODdvK2JZf1mU7jyK3aN13Xs3TqSqPVvjDrMp53B98jTICzDdgumK4aO
         wExUjU07coU571VEweOohuQPu3mH1V3pOM/rIH5eGPqqDE5zjylkBmrsg1vXWJm/SdRs
         IMGsEO1z188v/k7kOh4rAJbQJ4wagHpO/Y4AUOat3lOj+2Dc1EsdzR7Ja6yQPkHtVp5C
         VYOg0hTo//tTUEPA6p0CYHe1eB2uba3X+DZD+oWGfBp9TSxPJ7y8YR0pmDBEY7JU8uSj
         3lfQ==
X-Gm-Message-State: AJcUukfSnAL/iFo8fkEpkyqX2I3xhYt9EJk+sCko6ZOzMfDg8rUwqUP1
        19EApUzMyUFc5KCpDADNHOY=
X-Google-Smtp-Source: ALg8bN41polHf/aPHr8HY8eYMlMmzaexFF+vCtaTttc/fyiq2UIpkH093AxV/O+TCWIhybdJ2a+rIQ==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr22608976wmc.113.1548783252599;
        Tue, 29 Jan 2019 09:34:12 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id c1sm5489922wmb.14.2019.01.29.09.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:34:11 -0800 (PST)
Date:   Tue, 29 Jan 2019 18:34:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129173409.GD13764@szeder.dev>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129155827.GC13764@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 04:58:27PM +0100, SZEDER Gábor wrote:
> On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:
> > @@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
> >  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> >  		DEFAULT_TEST_TARGET=test -j1 test
> >  
> > +coverage-prove: coverage-clean-results coverage-compile
> > +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> > +		DEFAULT_TEST_TARGET=prove -j1 prove
> 
> First I was wondering why do you need a dedicated 'coverage-prove'
> target, instead of letting DEFAULT_TEST_TARGET from the environment or
> from 'config.mak' do its thing.  But then I noticed in the hunk
> context, that, for some reason, the 'coverage-test' target hardcoded
> 'DEFAULT_TEST_TARGET=test -j1'.  Then I was wondering why would it
> want to do that, and stumbled upon commit c14cc77c11:
> 
>     coverage: set DEFAULT_TEST_TARGET to avoid using prove
>     
>     If the user sets DEFAULT_TEST_TARGET=prove in his config.mak, that
>     carries over into the coverage tests.  Which is really bad if he also
>     sets GIT_PROVE_OPTS=-j<..> as that completely breaks the coverage
>     runs.

So this text is really dramatic and implies (to me, at least), that
parallelized coverage builds just don't work.  I've just run a
coverage build with this patch and my usual GIT_PROVE_OPTS containing
'-j4', and the tests went well and the generated report looks good,
too (I don't know how it's supposed to look, but at least I didn't
notice anything obviously wrong with it).  However, this might mean
nothing, because further digging turned up the follow paragraph in
901c369af5 (Support coverage testing with GCC/gcov, 2009-02-19):

    The tests are run serially (with -j1).  The coverage code should
    theoretically allow concurrent access to its data files, but the
    author saw random test failures.  Obviously this could be
    improved.

And in the related email discussion [1]:

  But even though the docs claim it [-j<N>] should be possible,
  I've been getting "random" test failures when compiled with coverage
  support, that went away with -j1.  So the tests still run with -j1, as
  with the first version of the series.

So it doesn't seem to be that bad after all, because it's not
"completely breaks" but "random test failures".  Still far from ideal,
but the original coverage patch is just about 3 weeks short of a
decade old, so maybe things have improved since then, and it'd be
worth a try to leave GIT_PROVE_OPTS as is and see what happens.


[1] https://public-inbox.org/git/200902191512.16755.trast@student.ethz.ch/


