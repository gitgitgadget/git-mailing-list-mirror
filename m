Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31731FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 12:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdBEMNW (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 07:13:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34649 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdBEMNV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 07:13:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so15533640wmi.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 04:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HC4bvGPIPSwZznrj4BGd97akos3oTh9zm+Nnxi8/xwg=;
        b=hVqvlvimg3awFyX8ruo1iS7apWQkB/5f5ltaM1kQodaaKMz9X40Lf8vNAU/7CJMz09
         5APfPcnCwMfQJIVYapvW9FpQ3B/4EViDJnz1mwWofKfzLOSdxX47mUftw0lxiEzkDgOT
         1jA2stX6CpReu/E8XcEJU2RKiLVqaGjirXc+o5otaKrRKipRJwLxOdMb6V7XH6KJ7QEL
         5VUr9UbTsynfLJXpGHAs5g4O3Mee8KsMQ+BaBE295wDcyrAzFPnIABzeHjIXoy6if1xL
         eoK798X5Uw1upV5XXEXGw6ho4yKOKEUH2Eg1aGOzQTJfi8AVdWW7qmGVyg4WUgDpWzFU
         ecrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HC4bvGPIPSwZznrj4BGd97akos3oTh9zm+Nnxi8/xwg=;
        b=GK0EH2o38ULyAuKkZxoHuMr+mSRHntxhBuweuvcvvQfD9r6jg8f5vu5hqtV4TYSsu4
         haqGDuKi9FSPDEYRi+PZEo6YuQc5ATS7Ya8wodvKDFcPcodb9utkFRFob0zQHP5VTiRq
         ueAk9yK+g2QddlaNpNiy6PzKWoeNMGBJwV4/Fp0NBaUTCxWEpGSGbTTPnJ8MZOdHz+Ll
         keIPaXOXBFiIQHiWvvAu+GDpi4mYxUQiPW7NzP/IVbdylit+UT4OSTNJoTxHr7ngqduf
         X9jOQGGou6bC8bub7hAmUsqZfhPrSYR903BiS/ihMYvmaHe6mbLKPw8HzY9IB585v1oK
         eGxw==
X-Gm-Message-State: AMke39kyiXShQto54u+uhSRmZ5qkhgN1RQ7N+swtXHvOsV3v2NRXJV1XHqcTWzMFipn2sA==
X-Received: by 10.28.149.199 with SMTP id x190mr4603058wmd.91.1486296799887;
        Sun, 05 Feb 2017 04:13:19 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e14sm7225550wmd.14.2017.02.05.04.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 04:13:18 -0800 (PST)
Date:   Sun, 5 Feb 2017 12:13:47 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/4] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170205121346.GH31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170129201604.30445-2-t.gummerer@gmail.com>
 <xmqq7f5cuu8l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7f5cuu8l.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Don't mention git reset --hard in the documentation for git stash save.
> > It's an implementation detail that doesn't matter to the end user and
> > thus shouldn't be exposed to them.
> 
> Everybody understands what "reset --hard" does; it can be an
> easier-to-read "short-hand" description to say "reset --hard"
> instead of giving a lengthy description of what happens.

While this is definitely true for experienced git users, it might not
be for some people relatively new to git, which are probably the ones
that need the description most.

> Because of that, I do not necessarily agree with the above
> justification.  I'll read the remainder of the series before
> commenting further on the above.
> 
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 2e9cef06e6..0fc23c25ee 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -47,8 +47,9 @@ OPTIONS
> >  
> >  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> >  
> > -	Save your local modifications to a new 'stash', and run `git reset
> > -	--hard` to revert them.  The <message> part is optional and gives
> > +	Save your local modifications to a new 'stash' and roll them
> > +	back both in the working tree and in the index.
> 
> "... roll them back both ..." is unclear where they are rolled back
> to.  
> 
> Perhaps "roll them back ... to HEAD" or something?

Yeah that makes sense, thanks.

-- 
Thomas
