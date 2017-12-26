Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0C31F404
	for <e@80x24.org>; Tue, 26 Dec 2017 20:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbdLZUb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 15:31:59 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:39715 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZUb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 15:31:58 -0500
Received: by mail-io0-f169.google.com with SMTP id g70so20923116ioj.6
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 12:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SxIwNL7ReuPutsAUqlozoFiyeB5osy6h9mJhJUOaIWM=;
        b=M4+jeRYKczYO3Ok03CqxCAwUce6WpXEY7TDmBeOMGcIjmMFzlYzvdX7xSLEscz33/h
         LnVNnk/qD34411xuddrQ0VKLQfhXVv4JfKunYoCAIt87XGFF/LU0nNbseBssgTF8UWCy
         YSq5taaklEt4TKrPWKW71Bu01+igyPCV7MVtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxIwNL7ReuPutsAUqlozoFiyeB5osy6h9mJhJUOaIWM=;
        b=KIJSJjOLuJg5IY90JdtL4YhcLpI0AHGtk5cZtTzhDrI8y1PWXl+8wNTj+fmjRWr2nt
         wjUpdeKXA32T5SU1Ny60yjSyg0vAPfm0fM1tzwrH3B9/QqByH0JbmIW/8tDpAbfaoI6T
         S2TuZnXwx4pJ5WAk4jRMpv44q6n+YWNwM5DOAzQm09ZK0sjYWIO2UoICMmz3nsEwwHkm
         Q3xtwNPXnZwXerlQEA0yJT31cYFJ7UZwiZZyM5JXOZMO11MDj2CsjYZB3CikO6RVO1On
         wvF8Gk1n602dbdUS+Bq78ijbkyhS4z59QS1yPdOehLjtZ60e7WjXhOuPH3UnpjxlI2lY
         KFFg==
X-Gm-Message-State: AKGB3mK05TA7Zkyr56OQ+/nZrABtaKAZpcD0qKYjvU+hYUhhCRZ6hWVA
        /nBmjG+D58trIL7rQs3O1u4chQ==
X-Google-Smtp-Source: ACJfBovp+kvj36HyKLoG8q6OkOQtLl9afdNhPpW+qBYrM16mnmgXI/7tfopRqzAI2XuvxXk8pwA1WQ==
X-Received: by 10.107.222.21 with SMTP id v21mr16786352iog.24.1514320317743;
        Tue, 26 Dec 2017 12:31:57 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:59aa:140c:4d30:a473])
        by smtp.gmail.com with ESMTPSA id 124sm9815648itw.30.2017.12.26.12.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 12:31:56 -0800 (PST)
Date:   Tue, 26 Dec 2017 13:31:55 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226203153.GA21429@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <20171226180436.GA28565@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171226180436.GA28565@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 01:04:36PM -0500, Theodore Ts'o wrote:
> On Mon, Dec 25, 2017 at 06:16:40PM -0700, Carl Baldwin wrote:
> > At this point, you might wonder why I'm not proposing to simply add a
> > "change-id" to the commit object. The short answer is that the
> > "change-id" Gerrit uses in the commit messages cannot stand on its own.
> > It depends on data stored on the server which maintains a relationship
> > of commits to a review number and a linear ordering of commits within
> > the review (hopefully I'm not over simplifying this). The "replaces"
> > reference is an attempt to make something which can stand on its own. I
> > don't think we need to solve the problem of where to keep comments at
> > this point.
> 
> I strongly disagree, and one way to see that is by doing a real-life
> experiment.  If you take a look at a gerrit change that, which in my
> experience can have up to ten or twelve revisions, and strip out the
> comments, so all you get to look at it is half-dozen or more
> revisions.  How useful is it *really*?  How does it get used in
> practice?  What development problem does it help to solve?

I didn't mean to imply that we need to get along without the comments. I
was only pointing out that gerrit, github, other code review UIs have
already figured out how to store comments archored to specific revisions
of files in the repository. I'm suggesting that we let them continue to
do that part while we take the first step of specifying how the
intermediate revisions are kept.

If the various code review servers adopted this then we'd have a client
side which could push up revisions for review to any of them. In
addition, they'd all get the collaborative functionality that I
described in my reply to your previous message.

What we get with this proposal is if I push up a review and that review
is changed by someone (maybe even me) outside of my original workspace,
my client gives me the tools to detect it and merge with it. If I try to
push over (clobber) that work then I get an error that the remote cannot
be fast-forwarded and I'm forced to fetch it and merge it.

I get this while using the rebase methodology I've grown to enjoy having
since using gerrit and I end up with a mainline history that looks
exactly the way I want it to.

> And when you say that it is a bug that the Gerrit Change-Id does not
> stand alone, consider that it can also be a *feature*.  If you keep
> all of this in the main repo, the number of commits can easily grow by
> an order of magnitude.  And these are commits that you have to keep
> forever, which means it slows down every subsequent git clone, git gc
> operation, git tag --contains search, etc.

I didn't say it was a bug; just that it is at odds with what I'm hoping
to do.

I agree that the number of commits in the repository will go up.
However, I think there will be ways to mitigate the costs.

The commits are not in the mainline history. So, I wouldn't expect a git
tag --contains or most other commands that traverse history to consider
them at all.

It could be possible to make the default git clone skip them all and
only fetch them on demand for specific changes.

> So what are the benefits, and what are the costs?  If the benefits
> were huge, then perhaps it would be worthwhile.  But if you lose a
> huge amount of the value because you are missing the *why* between the
> half-dozen to dozen past revisions of the commit, then is it really
> worth it to adopt that particular workflow?
> 
> It seems to me your argument is contrasting a "replaces" pointer
> versus the github PR.  But compared to the Gerrit solution, I don't
> think the "replaces" pointer proposal is as robust or as featureful.
> Also, please keep in mind that just because it's in core git doesn't
> guarantee that Github will support it.  As far as I know github has
> zero support notes, for example.

What I propose is that gerrit and github could end up more robust,
featureful, and interoperable if they had this feature to build from.

With gerrit specifically, adopting this feature would make the "change"
concept richer than it is now because it could supersede the change-id
in the commit message and allow a change to evolve in a distributed
non-linear way with protection against clobbering work.

I have no intention to disparage either tool. I love them both. They've
both made my career better in different ways. I know there is no
guarantee that github, gerrit, or any other tool will do anything to
adopt this. But, I'm hoping they are reading this thread and that they
recognize how this feature can make them a little bit better and jump in
and help. I know it is a lot to hope for but I think it could be great
if it happened.

Carl
