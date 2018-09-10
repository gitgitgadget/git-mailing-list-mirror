Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E1D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeIKAPM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:15:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35855 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeIKAPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:15:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so22688763wmj.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AjiKtuaqkOF1C+9zjcC9nQV5TYDsEHF2EL1g12XcJmg=;
        b=j+uz2AmYooLNqGWqe8MLFbB+k1AMPG2pxtkYvEfiho3u0PmKBTpFER48s0J3kf7NcF
         0YujbXViOWMplJmTPKYWOJuNyO6qwWrg4joKQ1WI9xJ6zrzyOwtEvOm3ypJe+ehqX/zM
         p5yTVUMD8LgjYdnh9h+UEnhttFzrVJ6QtHUcZHj1pCEeLUAwkBs1RNEjrjmcoNW/obay
         eWGBpACYKuSU3MuxrXR3jKiQPrGJMrw0MRE9CxmnftoFcV1FaNKWCyzq2R2BkRbEuujK
         +EfMqBLoG9VuVXiXEwwm/9P7IH5U/k1TZypyyKNq6vXb/pMt8f9gBpUzk4PiSr0nq4YE
         AFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AjiKtuaqkOF1C+9zjcC9nQV5TYDsEHF2EL1g12XcJmg=;
        b=IcFBNruumwZyCjHwPrmM9kdE4KYLwBu8/Bj88+VzxhF97Cb/VKgNPC5Oj4q5YgpG8/
         UpgnGGrTmbsQ2JNGu+O5aqXTVgx2r8A5il4NTqpqB3YM/tRuu5Ot9mAHqtfaK3kYZsZR
         7//Lq8guem0OQ5jojkzmroczR9czDfFL2xq3cKK+VagP+jY2gD6JCpwGE38baTULwLdh
         l9xK42RRvKU35Mf5ZTy2ErI66Lh72WDkF13t3nMbjpxyv9F6gvp+hpramxLNufX0N5GR
         w1PktH2tuR7UwThF2FfmU5FoK2SbST9h8P/x7Liq0SNfD1ODVWKZDnUya1igwwwP1uxZ
         aFJw==
X-Gm-Message-State: APzg51BHOhbDbhe4oDb+rdIlqKi6+O+bRAmZ31lvM9n0g+RT02SWnywZ
        ULA5irO++QcH+hVCtVI1mLU=
X-Google-Smtp-Source: ANB0VdaKjNOZ6f6O5WK7isiJmQEPfzffdyjYW36rqudyC058mF+sya9pFlm189OtaYnAkExvYBv2Sg==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr1618375wmb.29.1536607176350;
        Mon, 10 Sep 2018 12:19:36 -0700 (PDT)
Received: from localhost (x590d3ee7.dyn.telefonica.de. [89.13.62.231])
        by smtp.gmail.com with ESMTPSA id f18-v6sm17131260wrw.32.2018.09.10.12.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:19:35 -0700 (PDT)
Date:   Mon, 10 Sep 2018 21:19:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
Message-ID: <20180910191932.GB17224@localhost>
References: <20180910140714.19617-1-szeder.dev@gmail.com>
 <20180910154453.GA15270@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910154453.GA15270@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 11:44:54AM -0400, Jeff King wrote:
> On Mon, Sep 10, 2018 at 04:07:14PM +0200, SZEDER Gábor wrote:
> 
> > The test 'add -p does not expand argument lists' in
> > 't3701-add-interactive.sh', added in 7288e12cce (add--interactive: do
> > not expand pathspecs with ls-files, 2017-03-14), checks the GIT_TRACE
> > of 'git add -p' to ensure that the name of a tracked file wasn't
> > passed around as argument to any of the commands executed as a result
> > of undesired pathspec expansion.  This check is done with 'grep' using
> > the filename on its own as the pattern, which is too loose a pattern,
> > and would match any occurrences of the filename in the trace output,
> > not just those as command arguments.  E.g. if a developer were to
> > litter the index handling code with trace_printf()s printing, among
> > other things, the name of the just processed cache entry, then that
> > pattern would mistakenly match these as well, and would fail the test.
> 
> Is this a real thing we're running into?

Well, we, in general, don't, but that example mentioned in the commit
message does contain autobiographical elements :)

> I'd have thought that anybody
> adding index-specific tracing would do it as GIT_TRACE_INDEX.

Depends on the purpose, I guess.  For tracing that is aimed to become
part of in git, definitely.  However, for my own ad-hoc tracing used
to try to make sense of some split-index corner cases, trace_printf()
is perfect.

> It's
> unfortunate that "trace commands and processes" is just GIT_TRACE, and not
> GIT_TRACE_RUN or similar. But that's mostly historical. I wouldn't
> expect people to add other subsystems to it.
> 
> Not that I'm totally opposed to your patch, but it's a little sad that
> we have to match the specific text used in GIT_TRACE now (and if they
> ever changed we won't even notice, but rather the test will just become
> a silent noop).
> 
> I think it would be nice if we could move towards something like:
> 
>   - move current GIT_TRACE messages to use GIT_TRACE_COMMAND or similar
> 
>   - abolish trace_printf() without a specific subsystem key

Nah, please leave trace_printf() alone.

>   - do one of:
> 
>     - keep GIT_TRACE as a historical synonym for GIT_TRACE_COMMAND; that
>       keeps things working as they are now
> 
>     - have GIT_TRACE enable _all_ tracing; that's a change in behavior,
>       but arguably a more useful thing to have going forward (e.g., when
>       you're not sure which traces are even available)
> 
> And then a test like this would just use GIT_TRACE_COMMAND.

Except for removing keyless trace_printf(), I agree.

