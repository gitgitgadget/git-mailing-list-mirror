Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54281F406
	for <e@80x24.org>; Sat,  6 Jan 2018 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeAFR31 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 12:29:27 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:41845 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeAFR3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 12:29:25 -0500
Received: by mail-io0-f182.google.com with SMTP id f6so8903999ioh.8
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=clnmjmpwjtZc6Vh+W/LEAACkd71hZkzvrHBkqFpkDjI=;
        b=h4O7aBSoPyN9MKEA0Q2nTgXsuPC3vlR86Z0B0rcCTqtKIWXl2jlQYNHXRfg1Qg9Eg9
         iY/lNTPp8AlWTvuGYQxcPMKE1/Oj0kTjWJU5aMw+7rDvr21AMw3O00blSn2YsLL2h3F1
         jbZAfih8sA+OozCLWkqF/6vGtwq59GzLnLdvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=clnmjmpwjtZc6Vh+W/LEAACkd71hZkzvrHBkqFpkDjI=;
        b=qQuKdLtRAfr+Ehsm+ZuznDj05AWJXgJVALcY3zl39eWwkR0qBIeK5Y4zzvY3BD1jUh
         82ZuVj7oyKi2UP0TTgsTyJK/cvh5h3/T4xJstzf+GO/p7IOKd2UPEI0joRdqXDnj7xhz
         W3QQhGSD70K8ZAXOKINdtArDuXLgR4VYOMdLmXnL7JldH7ca0hYu30qD0ZwtTAkb3+sh
         8H0e2PSmnZZGwYQTD8rtXcjpulS7uwdxCsHZAQbPGeNkgupJ0e6LE0VdXFadDruVxdbK
         8HIcu7lOZMzoTmU+8qMzHg0HW2MWvRLPT6wlCOsknaSp31y4CNBJXfLokqzZl+4eXQ3W
         kEpA==
X-Gm-Message-State: AKGB3mI6X/stakuS9t+rYeP8vPGNhBF96cCrw0p1Xg+UtJq9OhzBIK3W
        ZITuRumKKrUMpt/FiJrUz6gLWQ==
X-Google-Smtp-Source: ACJfBosl4T3RtsHzYwdoS3SjP8YUm6QV6WkWrT5mODANgDhzJZA+nXVwfIpZzKwildcYRm2sZKFuHg==
X-Received: by 10.107.69.20 with SMTP id s20mr6389043ioa.35.1515259764037;
        Sat, 06 Jan 2018 09:29:24 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:ecbd:512d:cd90:54dd])
        by smtp.gmail.com with ESMTPSA id e20sm4867725ioe.13.2018.01.06.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 09:29:23 -0800 (PST)
Date:   Sat, 6 Jan 2018 10:29:21 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Fick <mfick@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180106172919.GA17272@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <3447055.jsE6nH3DQt@mfick-lnx>
 <xmqq4lo0cbbv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lo0cbbv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 12:14:28PM -0800, Junio C Hamano wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> 
> > These scenarios seem to come up most for me at Gerrit hack-
> > a-thons where we collaborate a lot in short time spans on 
> > changes.  We (the Gerrit maintainers) too have wanted and 
> > sometimes discussed ways to track the relation of "amended" 
> > commits (which is generally what Gerrit patchsets are).  We 
> > also concluded that some sort of parent commit pointer was 
> > needed, although parent is somewhat the wrong term since 
> > that already means something in git.  Rather, maybe some 
> > "predecessor" type of term would be better, maybe 
> > "antecedent", but "amended-commit" pointer might be best?
> 
> In general, I agree that you would want richer set of "relationship"
> than mere "predecessor" or "related", but I do not think "amended"
> is sufficient.  I certainly do not think a "pointer" embedded in a
> commit object is a good idea, either (a new commit object header is

To me, this is roughly equivalent to saying that parent pointers
embedded in a commit object is a good idea because we want a richer
relationship than mere "parent". Look how much we've done with this
simple relationship. Similarly, the new relationship that I'm proposing
handles much more than the simple m==n==1 case. Read below for more
detail.

> out of question, but I doubt it is a good idea to make a pointer
> back to an existing commit as a part of the log message).
> 
> You may used to have a set of n-patches A1, A2, ..., An, that turned
> into m-patches X1, X2, ..., Xm, after refactoring.  During the work,
> it may turned out that some things the original tried to do are not
> sensible and dropped, while some other things are added in the final.
> series.  
> 
> When n==m==1, "amended" pointer from X1 to A1 may allow you to
> answer "Is this the first attempt?  If this is refined, what did the
> earlier one look like?" when given X1, but you would also want to
> answer a related question "This was a good start, but did the effort
> result in a refined patch, and if so what is it?" when given A1, and
> "amended" pointer won't help at all.  Needless to say, the "pointer"
> approach breaks down when !(n==m==1).

It doesn't break down. It merely presents more sophisticated situations
that may be more work for the tool to help out with. This is where I
think a prototype will help see these situations and develop the tool to
manage them.

When each of n commits is amended or rebased trivially into m==n new
commits then each change is represented by a distinct graph of
predecessors that can be followed independently of others. With rebase,
this is accomplished by using only "pick" in interactive mode or not
using interactive mode at all (and no autosquash).

The more sophisticated cases can be broken down into two operations that
change the number of resulting commits.

  1. Squashing two commits together ("fixup", "squash"). In this case,
     the resulting commit will have two or more pointers. This clearly
     shows that multiple changes converged into one at this point.

  2. Splitting a single commit into multiple new commits ("edit"). In
     this case, the graph shows multiple new commits pointing to the
     same predecessor. In my experience, this is less common. It also is
     a little more challenging to think about the tool managing
     divergent work but I think it is possible.

The end result is m commits where m can be any positive number (even,
coincidentally, n). However, the graph of amended commits still tells
the story quite well. Even if commits are reordered, the graphs can
still be useful. The predecessor graph is independent of the parent
graph which makes up normal git commit history so it isn't inherently
bad that the order of commits was changed.

We can dream up some very interesting graphs. Sure, as we do
increasingly more complicated history rewriting, it is going to be
increasingly more difficult for the tool to help out. I'm not really
deterred by this at this point. I want to experiment and work it out
with a prototype.

My primary objective personally is to detect where work on a single
change has diverged by working on it from more than one workspace
whether its multiple people chipping in or just me. Merely having the
ability to reject an update that clobbers divergent work is a big win.
No more silent corruption of work.

My secondary objective is to develop a tool to help get the divergent
work back on track. I believe that in the majority of common cases, this
tool can be successful in either finding an automatic way to bring the
divergent work back into a new revision of the change or present the
user with conflicts to resolve that end up being much easier than what
I've had to do in past experience with rebase workflows.

Carl
