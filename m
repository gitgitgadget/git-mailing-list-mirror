Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA761F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeJWHKU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 03:10:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39177 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJWHKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 03:10:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so11965846wmd.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iDVNUoWbTmAW/Zxu09+7RF/bLcFx4PWGQ/jT7CXwnXY=;
        b=Elfs1c7oRBphNh9CbnZi4SmtqB3nz+9IeVl6JEv6ETF281x2KDHBtHlEeqc/nBTbz9
         M31F7D7VytCLjF9d7ROZZQ7M0V2pfChyH+xwYby98kJxDqQuHaY+MSG6FcQCuku7B3aC
         7i0QpqJu2gT81JNdmLPecb+By/+87cdOjGAaTkpgoZvvKPccPHMsPjvKLXKLLfSN8saw
         wWYH1NjGEnNYi20dKoGr7QUZhBguDWQWQxg6VzsDlQJ9Tfixa/nI3Xf4Z3Av4m3OZreQ
         2lkfc0TEhddehGQWWIU8ap0iy2ukc+pnmmcKNlT5F7VfmEHgSr8ULGI7oHQdVMr3c4Tv
         iEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iDVNUoWbTmAW/Zxu09+7RF/bLcFx4PWGQ/jT7CXwnXY=;
        b=sbiFQNn461h3G1liQTdA6lfqnP/lyRp0F6tJqQy00HrdRTR1DFmcAKNOCXWFTJ8MO2
         xWlyNrFwesMkzNis3DTt8AXnNnxLETQnY1xb4b7x7c9rvBvznINjV0iWo9ZKwHw3qtWp
         JHWciCNZRgVGrY56OizEWjUxq7lpvvPdawkbgS78ANTuW27r1pGKCj1dO5U+fP6oC0FV
         N/yBiFxfSUMYC540OaqfQ6M4Av+e1vmy3DHhS4xdDEUswt1uhsaIRVZNUqEcP88FhNOv
         wNN9iwSDq4D8VPL2QwyRIdoxMk5ol51BtfWaWTGuXBqH9VNoBP+ZDdZZD6l3n7foki7m
         DC9Q==
X-Gm-Message-State: ABuFfohNcY8eGExrRTYOQqwP4iWeD59KR/CoiHTYnjgz2dK8x1aAsobs
        ybtEJYSYnF70DJC0ZCWhZn4=
X-Google-Smtp-Source: ACcGV60kw1WOuqFUVUzoKw0qvpY5koIYMwnT35kt5jNUYBmXzh624XhJYX79XB/TJC4KB8YqD6qnrg==
X-Received: by 2002:a1c:7c16:: with SMTP id x22-v6mr17121101wmc.16.1540248587766;
        Mon, 22 Oct 2018 15:49:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j128-v6sm9354452wmb.43.2018.10.22.15.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:49:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19] Bring more repository handles into our code base]
References: <20181016233550.251311-1-sbeller@google.com>
        <20181022173935.GG30222@szeder.dev>
Date:   Tue, 23 Oct 2018 07:49:45 +0900
In-Reply-To: <20181022173935.GG30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 22 Oct 2018 19:39:35 +0200")
Message-ID: <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> I don't really like how this or the previous RFC patch series deal
> with semantic patches (or how some past patch series dealt with them,
> for that matter), for various reasons:
> ...
> How about introducing the concept of "pending" semantic patches,
> stored in 'contrib/coccinelle/<name>.pending.cocci' files, modifying
> 'make coccicheck' to skip them, and adding the new 'make
> coccicheck-pending' target to make it convenient to apply them, e.g.
> something like the simple patch at the end.
>
> So the process would go something like this:
>
>   - A new semantic patch should be added as "pending", e.g. to the
>     file 'the_repository.pending.cocci', together with the resulting
>     transformations in the same commit.
>
>     This way neither 'make coccicheck' nor the static analysis build
>     job would complain in the topic branch or in the two integration
>     branches.  And if they do complain, then we would know right away
>     that they complain because of a well-established semantic patch.
>     Yet, anyone interested could run 'make coccicheck-pending' to see
>     where are we heading.
>
>   - The author of the "pending" semanting patch should then keep an
>     eye on already cooking topics: whether any of them contain new
>     code that should be transformed, and how they progress to
>     'master', and sending followup patch(es) with the remaining
>     transformations when applicable.
>     
>     Futhermore, the author should also pay attention to any new topics
>     that branch off after the "pending" semantic patch, and whether
>     any of them introduce code to be transformed, warning their
>     authors as necessary.
>
>   - Finally, after all the dust settled, the dev should follow up with
>     a patch to:
>     
>       - promote the "penging" patch to '<name>.cocci', if its purpose
>         is to avoid undesirable code patterns in the future, or
>     
>       - remove the semantic patch, if it was used in a one-off
>         transformation.
> ...
> Thoughts?

I actually think this round does a far nicer job playing well with
other topics than any earlier series.  The pain you are observing I
think come primarily from my not making the best use of these
patches.

Steppng back a bit, I'd imagine in an ideal world where "make
coccicheck" can be done instantaneously _and_ the spatch machinery
is just as reliable as C compilers.  In such a world, I may rename
all the *.c files in my tree to *.c.in, make the very first step of
the "make all" to run coccicheck and transform *.c.in to *.c before
starting the compilation.  There is no need to have changes to
*.c.in that spatch would fix.  Such an idealized set-up has a few
nice property.

 - Mechanical conflict resolutions between topics in flight and a
   series that modifies or adds new .cocci rules would greatly be
   reduced.

 - Still, *.c files that are "compiled" from *.c.in file used by
   each build will by definition cocci-clean.

 - Bugs like the one that required 6afedba8 ("object_id.cocci: match
   only expressions of type 'struct object_id'", 2018-10-15) are
   still possible, but some of them may be caught by C compilers
   that inspect the result of spatch compilation from *.c.in to *.c

Now we do not live in that ideal world and there is no separate
"turn *.c.in into *.c" step in our build procedure.  In such a
"real" world, if we had a rule like "each individual commit must
pass 'make coccicheck' cleanly", anybody who does such a merge and
resolve huge conflics would essentially be wasting time on something
that the tool could do, and then the result of the merge would
further need to be amended for semantic conflicts (i.e. the other
branch may have introduced new instances of old pattern .cocci
patches in our branch would want to transform)).  By not insisting
on cocci-cleanness at each commit level, we can gain (or at least
sumulate gaining) some benefit that we would reap in the ideal
world, and Stefan's latest series already does so for the former.
If we insisted that these patches must be accompanied with the
result of the cocci transformations, such a series will have zero
chance of landing in 'pu', unless we freeze the world.

What I _could_ do (and what I did do only for one round of pushing
out 'pu') is to queue a coccinelle transformation at the tip of
integration branches.  If "make coccicheck" ran in subsecond, I
could even automate it in the script that is used to rebuild 'pu'
every day, so that after merging each and every topic, do the "make
coccicheck" and apply resulting .cocci.patch files and squash that
into the merge commit.

But with the current "make coccicheck" performance, that is not
realistic.

I am wondering if it is feasible to do it at the tip of 'pu' (which
is rebuilt two to three times a day), 'next' (which is updated once
or twice a week) and 'master'.

I find that your "pending" idea may be nicer, as it distributes the
load.  Whoever wants to change the world order by updating the .cocci
rules is primarily responsible for making it happen without breaking
the world during the transition.  That's more scalable.

But at some point in the ideal future, it may turn out that it is
making the process scalable by distributing a task that does not
have to be done by any human, not by the integrator or by individual
developer---but the new compilation step from *.c.in to *.c should
be able to do.  We obviously are not there yet, so...
