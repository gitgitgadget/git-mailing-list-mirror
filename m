Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF3320D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdFAXkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:40:39 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34882 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAXki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:40:38 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so40281394pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8Y1tS9OJQ9RDW660mLf/nHBvBXi28SQ6xSoVUOUE6FE=;
        b=HI/3uFScsCj1OkF1kNzAl+wwJ5ab1pysyH/8X1JJ3d/9tFK/OP26GAlU1RxTwjNRCp
         xrXWLCiObAOz/SZUwfZhl0eKt43Zh301lQxLlaullnz7HHuVD6T9wiX1Il6/YvH2Mby0
         HjOlVwcMDe3hBT2Kl8fkIqnmtBHwpy+rNBxSef4JVy6yfgJJd5LX/VCkIsBY1laUm0pr
         i4FYudoYGSqc31qX54Of3zwGId+5/1pFzQ+mkY7am8+hB/ZfKgc+JGnxNBr+mVLS6wyC
         5odRz0pKkpVaXn/JYiRf1VBDBKxl9oRrstY/b6Cb95kZBFQiiDRkgublm/pp4UVpJg3L
         yxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8Y1tS9OJQ9RDW660mLf/nHBvBXi28SQ6xSoVUOUE6FE=;
        b=mWUW7hC1xUJ8YBxL5Nwf0+OFMIP7iM0Gqz7sfQ6XbKlSf+I27s8W5V6N0MMmItwRhh
         Ni3tXlZlGUzj6t1fh2wwEgH3KX+iDr3gGcQWM0WnePfac1B335UbByI3v99EJT1S2tiL
         SJaJfIN95vxSzBjpOGE39ONt3HQwkTCyg2fvSN741fUfcfXtqkr3zRBFMgG1UagkAlSv
         XiqVhQjqjqvg7iYVBgTW28hDTd7x4cLe5GlfbrGYicw3dMjirlG32A5EFfh20s2W2UU4
         ODygQBH2WbZhzL46PoqcWMr8FLLcVcWNdw0KlZ1XfO9VzaG8Zx2YbS8yIANoAHcQV1n8
         W8Nw==
X-Gm-Message-State: AODbwcBKyy3sXamk4gG2iqV/5oiecn/GYAgE9OdF95xJfUQ4ESmZp1BM
        NjV02Z8g4ln0RA==
X-Received: by 10.98.217.7 with SMTP id s7mr3583308pfg.39.1496360437971;
        Thu, 01 Jun 2017 16:40:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id h15sm37500106pfk.120.2017.06.01.16.40.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:40:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-3-phillip.wood@talktalk.net>
        <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
Date:   Fri, 02 Jun 2017 08:40:36 +0900
In-Reply-To: <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> (Johannes
        Schindelin's message of "Thu, 1 Jun 2017 14:56:13 +0200 (CEST)")
Message-ID: <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, about the commit IDs. As long as the tests are consistent (i.e. they
> use test_commit rather than plain `git commit`, or at least call
> `test_tick` beforehand), the commit IDs should actually be identical
> between runs and not depend on the time of day or the date.
>
> The only exception to that rule is when some previous test cases call
> `test_commit` but are guarded behind some prereq and may not be executed
> at all. In that case, the precise commit IDs depend on the particular set
> of active prereqs.

Good observation.  The tests written such a way may make later
introduction of new hash function troublesome, though (we already
have tons of them, and it is already a hassle just imagining that we
will have to migrate them X-<).  

And what you gave below is an excellent suggestion to even solve
that future headaches.

> But as far as I can tell, t3420 does not have any test cases guarded by
> prereqs.
>
> Taking an additional step back, I wonder whether we have to hard-code the
> commit IDs (or XXX) to begin with. Why not generate the `expect` files
> with the information at hand? We can simply ask `git rev-parse --short`.
>
> For the stash's commit ID, there is no record in the ref space, of course
> (because it was created with `git stash create`). But I think in this
> case, it is legitimate to simply grep the output.
>
> That way, the test would be precise and resilient.
>
> So for example instead of adding the t/t3420/expected-success-am verbatim,
> you could generate the output via
>
> 	cat >expect <<-EOF
> 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\\$" output)
> 	HEAD is now at $(git rev-parse --short HEAD~2) third commit
> 	First, rewinding head to replay your work on top of it...
> 	Applying: second commit
> 	Applying: third commit
> 	Applied autostash.
> 	EOF
>
> Ciao,
> Johannes
