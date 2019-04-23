Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1ABD1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 01:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfDWBJ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 21:09:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37754 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDWBJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 21:09:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so16493247wmf.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iK/h4g/fHppybe8Hfx5RLsrk5a3Wz+sdXVhKk5xYFOk=;
        b=eu3+WW4MsYyTRyKExkOTqeUZciGny+q486bau2t1uXXRscKLVJTdlVbjL2uBySOe/G
         6t2XdiG/b/MMITuD+fpmkNM84v9oE1jr3Cgoo4L+b9hjn+dfSUkxEhOVqpWlsHr8EdZg
         TEYRUCrjVPEdXY1HKTUGf+IMX0lTUGlnL6iQCd5izrcep6m+JUgutH1vks6V5knzPvVz
         vszPyrJl7xa0HhrYTl6QhOabOdSKhRnZiw0e0gBFSNWQhQf2s21sckaiOA6jHoYqsJKB
         upBT4onTEcqcH9i+NWUtHWwMcKzQL9CdMuyQWucJQy/P/AwoSW56f47JR3RLdrV7wEp8
         /6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iK/h4g/fHppybe8Hfx5RLsrk5a3Wz+sdXVhKk5xYFOk=;
        b=SMVzxBQil+TPZg3QGmkNMS1KKsaqhXzFNxXxjSXcM773Xs+i2veG+m+4t5xWNcL2SD
         Q/CqN8mIbjhE7V5vPSHBlfzWJV/FR8UrscISmbIUcZ866lvVNGDAn/bHETZFYS6AGRIG
         jX9Usgxnu408P79VYWWetXRgaClRdVJ94w7O4/4owr/W4f8jHyZs4Nj/1xxHxlKiUL/A
         5mBIwSz+CXd7XN1z6yNAiV8Tq7IuU9mCrwVze83gcgNxn3/nvS9BMpprMDJPbvS+2/XW
         RiLHVaSKWHrA/aIkfqvyTC57Z/viEyYlcBXCu6bG0GhMau5JecGeHojLEhQB/W+YeVZ/
         FyFA==
X-Gm-Message-State: APjAAAXBse/S9F94PHvRCOoHOWue0MZi0oP5y8dhPWvRC+CirDrlJyub
        UiTopr1rDlS+oBfa3Rwd4ahA1OQNS0Q=
X-Google-Smtp-Source: APXvYqzzglDY0WmGleaptoD14GCBmAtxBJch9Xr5wodbXUlY+L6ndqrx9FM8jBfcpbXb7IMtgk3mLw==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr160109wmg.19.1555981797194;
        Mon, 22 Apr 2019 18:09:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d18sm92607wrx.56.2019.04.22.18.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 18:09:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create the repo in each index-pack test
References: <259296914.jpyqiltySj@mfick-lnx>
        <20190420035825.GB3559@sigill.intra.peff.net>
        <16052712.dFCfNLlQnN@mfick-lnx>
        <20190422205653.GA30286@sigill.intra.peff.net>
        <20190422211952.GA4728@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 10:09:54 +0900
In-Reply-To: <20190422211952.GA4728@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 17:19:52 -0400")
Message-ID: <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] p5302: create the repo in each index-pack test
>
> The p5302 script runs "index-pack --stdin" in each timing test. It does
> two things to try to get good timings:
>
>   1. we do the repo creation in a separate (non-timed) setup test, so
>      that our timing is purely the index-pack run
>
>   2. we use a separate repo for each test; this is important because the
>      presence of existing objects in the repo influences the result
>      (because we'll end up doing collision checks against them)
>
> But this forgets one thing: we generally run each timed test multiple
> times to reduce the impact of noise. Which means that repeats of each
> test after the first will be subject to the collision slowdown from
> point 2, and we'll generally just end up taking the first time anyway.

The above is very cleanly written to convince anybody that what the
current test does contradicts with wish #2 above, and that the two
wishes #1 and #2 are probably mutually incompatible.

But isn't the collision check a part of the real-life workload that
Git users are made waiting for and care about the performance of?
Or are we purely interested in the cost of resolving delta,
computing the object name, and writing the result out to the disk in
this test and the "overall experience" benchmark is left elsewhere?

The reason why I got confused is because the test_description of the
script leaves "the actual effects we're interested in measuring"
unsaid, I think.  The log message of b8a2486f ("index-pack: support
multithreaded delta resolving", 2012-05-06) that created this test
does not help that much, either.

In any case, the above "this forgets one thing" makes it clear that
we at this point in time declare what we are interested in very
clearly, and I agree that the solution described in the paragraph
below clearly matches the goal.  Looks good.

> Instead, let's create the repo in the test (effectively undoing point
> 1). That does add a constant amount of extra work to each iteration, but
> it's quite small compared to the actual effects we're interested in
> measuring.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The very first 0-thread one will run faster because it has less to "rm
> -rf", but I think we can ignore that.

OK.

> -	GIT_DIR=t1 git index-pack --threads=1 --stdin < $PACK
> +	rm -rf repo.git &&
> +	git init --bare repo.git &&
> +	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK

This is obviously inherited from the original, but do we get scolded
by some versions of bash for this line, without quoting the source path
of the redirection, i.e.

	... --stdin <"$PACK"

