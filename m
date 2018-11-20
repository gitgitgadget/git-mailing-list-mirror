Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57711F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 12:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeKTWiv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 17:38:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50804 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeKTWiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:38:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id 125so1909332wmh.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 04:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nbsEq7NqkRI/P7BcJcQ+/llLA9HN+D/PPUpdwtVY6rc=;
        b=hHYNEhe4bzy+CSfvnu9GDXpENSxwTL4ezIdPjkqXv2mvnfFz6WVQscVXaZIa5nLt82
         bP/I5U4QcBuTdabedRaQWt1JG8ZHbSBq8zI29ZICgtoXbiMhNdYIZeok9bgrXWTJVHL9
         geTEIQBFC2aFUnz+GY7HS9kKyf+JcpbRY8jf0DvQk4RguXxne8hHBbpLinOseRpQUnq1
         mpZRO8Htefm5fWxdI0fleGKFuYHX9JvhaOUbWs8p/CP+feOE6thzGMdiBjspvZGLxzXo
         8qNFhJz2h9SPLZxPPJq009DOfqu91Bsu39yrpWBuPHrxxpdUUzZ+w4TXViMtj5h+qbDC
         kiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nbsEq7NqkRI/P7BcJcQ+/llLA9HN+D/PPUpdwtVY6rc=;
        b=D+08bmpqJ7QVbXJUCgPL5HKNlg3vlz+dUDIzdBwDY0R+mria16PAOsvHuGKgfsHRLV
         nE6zXMzkHhL8t1hzHXUP8DJFSBsPAZuD08b2uqAz2Y8FJcSTl396yZL9wELGvajqc+C+
         RqkCgdUHcOJP4msyagen+QoxjVw1M83mciNjAOEwCZdNh9sUIE5rUvMbdMFE7+JIiTmM
         Hg+xO0o/5cUKOPtTnDpNBq+PdjXnCZaI10IIaYBynTnrUekUwDVvCeNqaSWQ436XX0Lu
         q1KEyNUZMV/WxaQCgn7uA/SeqHeAR2VeT8OLVjR8uhuJxy5pfOaqSDGyhvnVFmf2lO77
         +v1A==
X-Gm-Message-State: AGRZ1gLusdt1ZYNRb6oYr4iHZri/NhIoGvozpPBBT6/u1sIFXPD9xOWK
        iyV9A34yo6H4c8j5LJGvUyATcu6D
X-Google-Smtp-Source: AJdET5dKZbMEl8YutG1rajpr8j7LoCJVd2OVYaNmS7WqmU6PT7vww722O6CY0Hf/GdiChl1iah1v8w==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr1965598wmd.141.1542715799941;
        Tue, 20 Nov 2018 04:09:59 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id x194-v6sm97288896wmd.41.2018.11.20.04.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:09:59 -0800 (PST)
Date:   Tue, 20 Nov 2018 13:09:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: send "bug in the test script" errors to the
 script's stderr
Message-ID: <20181120120957.GY30222@szeder.dev>
References: <20181119131326.2435-1-szeder.dev@gmail.com>
 <20181119194432.GA7330@sigill.intra.peff.net>
 <20181119233404.GW30222@szeder.dev>
 <20181120104528.GA26263@sigill.intra.peff.net>
 <20181120105825.GB26263@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120105825.GB26263@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 05:58:25AM -0500, Jeff King wrote:
> On Tue, Nov 20, 2018 at 05:45:28AM -0500, Jeff King wrote:
> 
> > On Tue, Nov 20, 2018 at 12:34:04AM +0100, SZEDER Gábor wrote:
> > 
> > > > I do notice that many of the existing "FATAL:" errors use descriptor 5,
> > > > which goes to stdout. I'm not sure if those should actually be going to
> > > > stderr (or if there's some TAP significance to those lines).
> > > 
> > > I chose to send these messages to standard error, because they are,
> > > well, errors.  TAP only cares about stdout, but by aborting the test
> > > script in BUG(), error() or die() we are already violating TAP anyway,
> > > so I don't think it matters whether we send "bug in test script" or
> > > "FATAL" errors to stdout or stderr.
> > 
> > Yeah, I agree it probably doesn't matter. I was mostly suggesting to
> > make the existing ">&5" into ">&7" for consistency. But I don't think
> > that needs to block your patch.
> 
> By the way, I did check to see whether this might help the situation
> where running under "prove" we see only "Dubious..." and not the actual
> error() message produced by the test script. But no, it eats both stdout
> and stderr. You can sneak a line through by prepending it with "#", but
> only if "prove -o" is used (and even then, it's hard to associate it
> with a particular test when you're running many in parallel).

Just to be clear: I don't mind if in some combination of test
harnesses and test options a "bug in the test script" message doesn't
reach the terminal as long as I get a clearly visible error from
somewhere.

> So I guess the status quo is not too bad: prove says "dubious", and then
> you re-run the test with "./t1234-foo.sh -v -i" and you get to see the
> error.

And with '--verbose-log' the "bug in the test script" message goes to
the test's log as well, even when it has to go through fd 7 first, so
if you use 'prove' and your GIT_TEST_OPTS includes '--verbose-log'
then you can just look at the log, there's no need to re-run the test.

