Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FA81F453
	for <e@80x24.org>; Tue, 16 Oct 2018 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJPXzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:55:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43418 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPXzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:55:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so21862407eds.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QIY1cBBIgsNVEo1/tiGujkghGw4aSRkRERL0O+rKN1Q=;
        b=JRknxm3Mw+OQ9CqpVSE50OecSBCyPw2PyTR0bm1bAg7CwM3XER32mxshZtAo6cb+FT
         WZqt3pwRc+oZk5WiOU0Une/dODSSu0tcFr7QjXXnbNYXF97Y/lptP6FydmiZN4GqaGqV
         +PlY6Fq6X/aYNoaiM9ZZZEIYOWvlHeHV2fped75eGAdKUztG0IMP0FIlFvIlhlDSXlNz
         kI8lvpJzI+7+IbcgVKYUE12kj2XKOJcqMcGYNcHiTd/T9bvj01T3jcVTo5qYowWlA/nA
         lElu7szLGmfjLpKB5Mqs/DOQMIWPYz8hEGLlVnEyUiAtIRd5/HMrCeiMh2HB4gkf9f/L
         Z3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QIY1cBBIgsNVEo1/tiGujkghGw4aSRkRERL0O+rKN1Q=;
        b=Ld2wzFPx86Va7by3q1X3NC/nkpUBrG7hxVc7NurTbvHwS2QP3GvYdliT4MxZDOeLmP
         kd8+y4oyEujIXwwB0RkpFhYMBOUps8Rxyw9r5quQNjOpOazJPwCBxGyhbG8RaTDWVSHQ
         nptSgxQR7qNEMu775UgFUfaSZUQEL+kff+Latf/kmz14g3J6KrUZJEMAmb/q0FOrRUqk
         UtUhtwyyGsBHnAG6rqixosNyYPCq+ciFqkw1gtw0W6c/5V8zXGMcBZcg2NsPTzVpcsKz
         rrJbqLwhsqqYaatd3xPkU1eAxpZFosc22ppdKpT5spRy724fRPiJYYCqu+C4YC0Che8P
         7ZvA==
X-Gm-Message-State: ABuFfoiocN/1gIgRMr9bFyWJVr8V0KKU5fuOMlCJBHYSsG+TxcLe3fKm
        YLqQdwyws8MGcN+PsGVL4k3/mLZ7
X-Google-Smtp-Source: ACcGV60q5AUEHTxGU8BLXMGmwFdvdUcqNloOdVFq3/w2qRjNvXPVPDtnqgtwLYQR1tlQlrmi6u+BXA==
X-Received: by 2002:a17:906:2ec8:: with SMTP id s8-v6mr23809162eji.192.1539705833025;
        Tue, 16 Oct 2018 09:03:53 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id k35-v6sm4586710edd.1.2018.10.16.09.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 09:03:51 -0700 (PDT)
Date:   Tue, 16 Oct 2018 18:03:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/13] tests: include detailed trace logs with
 --write-junit-xml upon failure
Message-ID: <20181016160348.GM19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com>
 <20181016100438.GK19800@szeder.dev>
 <nycvar.QRO.7.76.6.1810161455200.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1810161455200.4546@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 03:02:38PM +0200, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Tue, 16 Oct 2018, SZEDER Gábor wrote:
> 
> > On Mon, Oct 15, 2018 at 03:12:12AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > The JUnit XML format lends itself to be presented in a powerful UI,
> > > where you can drill down to the information you are interested in very
> > > quickly.
> > > 
> > > For test failures, this usually means that you want to see the detailed
> > > trace of the failing tests.
> > > 
> > > With Travis CI, we passed the `--verbose-log` option to get those
> > > traces. However, that seems excessive, as we do not need/use the logs in
> > 
> > As someone who has dug into a few occasional failures found by Travis
> > CI, I'd say that the output of '--verbose-log -x' is not excessive,
> > but downright essential.
> 
> I agree that the output is essential for drilling down into failures. This
> paragraph, however, talks about the general case: where there are *no*
> failures. See here:

But you don't know in advance whether there will be any failures or
not, so it only makes sense to run all tests with '--verbose-log -x'
by default, just in case a Heisenbug decides to make an appearance.

> > > almost all of those cases: only when a test fails do we have a way to
> > > include the trace.
> > > 
> > > So let's do something different when using Azure DevOps: let's run all
> > > the tests with `--quiet` first, and only if a failure is encountered,
> > > try to trace the commands as they are executed.
> > > 
> > > Of course, we cannot turn on `--verbose-log` after the fact. So let's
> > > just re-run the test with all the same options, adding `--verbose-log`.
> > > And then munging the output file into the JUnit XML on the fly.
> > > 
> > > Note: there is an off chance that re-running the test in verbose mode
> > > "fixes" the failures (and this does happen from time to time!). That is
> > > a possibility we should be able to live with.
> > 
> > Any CI system worth its salt should provide as much information about
> > any failures as possible, especially when it was lucky enough to
> > stumble upon a rare and hard to reproduce non-deterministic failure.
> 
> I would agree with you if more people started to pay attention to our CI
> failures. And if we had some sort of a development model where a CI
> failure would halt development on that particular topic until the failure
> is fixed, with the responsibility assigned to somebody to fix it.
> 
> This is not the case here, though. pu is broken for ages, at least on
> Windows, and even a *single* topic is enough to do that. And this is even
> worse with flakey tests. I cannot remember *how often* I saw CI failures
> in t5570-git-daemon.sh, for example. It is rare enough that it is obvious
> that this is a problem of the *regression test*, rather than a problem of
> the code that is to be tested.

Some occasional failures in t5570 are actually caused by issues in Git
on certain platforms:

  https://public-inbox.org/git/CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com/T/#u

> So I would suggest to go forward with my proposed strategy for the moment,
> right up until the time when we have had the resources to fix t5570, for
> starters.

I don't really understand what the occasional failures in t5570 have
to do with the amount of information a CI system should gather about
failures in general.  Or how many people pay attention to it, or what
kind of development model we have, for that matter.  The way I see it
these are unrelated issues, and a CI system should always provide as
much information about failures as possible.  If only a few people pay
attention to it, then for the sake of those few.


> > > Ideally, we would label this as "Passed upon rerun", and Azure
> > > Pipelines even know about that outcome, but it is not available when
> > > using the JUnit XML format for now:
> > > https://github.com/Microsoft/azure-pipelines-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs
> > > 
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 

