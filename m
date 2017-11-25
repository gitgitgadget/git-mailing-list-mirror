Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E943220954
	for <e@80x24.org>; Sat, 25 Nov 2017 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdKYQ5L (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 11:57:11 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40958 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdKYQ5K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 11:57:10 -0500
Received: by mail-wr0-f193.google.com with SMTP id s41so17301002wrc.7
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lPYzeRMf5CS6qkjbCln3jzeinkD7T47YEbI+/wcMfIA=;
        b=c+C5SbSwoBotA5gPsxg8HyR7CpZAfT/vDTeKu593YeVqVenx3MYAu67Rl2curo44s6
         iKrO4Z8lfZWe5TmGRJEtGt6E7IBcJDr73tf0BVZLKsQjx++iSM2n9BjH6NTFxj5Hv8Kv
         wAEyvrDrMcrZ9ueRkKZ3VaOIQkV0Y/gk9BYn4/vjep8CD9i/Vhm1tbSWnqQa+qzc5iHw
         KJ38Ghwx0oPmPurjZ24W5xKDG0uOlD+6YFSEPNdVEzE78GnTLqz6M22GEfHvnaEqvkk6
         3FgwZVn20LU8T7slgOMmzdaU8IZcThNmWJEwVaRWiJANvurVOCH06jH+gdhyStI9BYRY
         V8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPYzeRMf5CS6qkjbCln3jzeinkD7T47YEbI+/wcMfIA=;
        b=AQDAiFRqNVhQpYYPsBNS1n7byuKPLGJge/5CvdFjfnMbPpNL8gsblDtvUPi866VI8+
         7wCVEQIaC45eeOAHeZq1lcHMCJGbzobsnFCoA7z3TYXuG0d4CHj47moJLHwmh5H3p+1/
         NOK8p9P9OrrKfr7ZqG3CNN4NXkzDMxWaHn2gUpwgXGhKs0E8m4btwUatji4lddeCPvtu
         sg0VZ21i3dVff/xny/Iy5hC7+pp1rH0KJvRGn6nellx7L0+qll5xv1p+VkzYwnOly1HT
         wgKR+gjFBxDaEQF7x1uMb+1OHb08yr7bROw6ieN0vDGy9AoudDjCMFAqzHLyUI4ANk1Y
         rl0w==
X-Gm-Message-State: AJaThX6hLDq3FWiF5VGL9Sy+RYg0IVPkwf33IApmPhwn4fWY9zLu4iDi
        5ZShqKDoZjod5gSbTdhtzj0=
X-Google-Smtp-Source: AGs4zMZvLA8SWQ9gsGS9MFCgr8DKCwxtWys6n1JgEmclnPyLL64CkgWRodGxFpQU7YA297f8Ib4wew==
X-Received: by 10.223.173.129 with SMTP id w1mr28422117wrc.19.1511629029214;
        Sat, 25 Nov 2017 08:57:09 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d23sm1706184wmh.18.2017.11.25.08.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Nov 2017 08:57:07 -0800 (PST)
Date:   Sat, 25 Nov 2017 16:58:40 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/4] worktree: add --[no-]track option to the add
 subcommand
Message-ID: <20171125165833.GA14993@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171122223020.2780-3-t.gummerer@gmail.com>
 <xmqqa7zcnozj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7zcnozj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > index b5c47ac602..53042ce565 100755
> > --- a/t/t2025-worktree-add.sh
> > +++ b/t/t2025-worktree-add.sh
> > @@ -313,5 +313,60 @@ test_expect_success 'checkout a branch under bisect' '
> >  test_expect_success 'rename a branch under bisect not allowed' '
> >  	test_must_fail git branch -M under-bisect bisect-with-new-name
> >  '
> > +# Is branch "refs/heads/$1" set to pull from "$2/$3"?
> > +test_branch_upstream () {
> > +	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
> > +	{
> > +		git config "branch.$1.remote" &&
> > +		git config "branch.$1.merge"
> > +	} >actual.upstream &&
> > +	test_cmp expect.upstream actual.upstream
> > +}
> 
> OK.
> 
> > +test_expect_success '--track sets up tracking' '
> > +	test_when_finished rm -rf track &&
> > +	git worktree add --track -b track track master &&
> > +	git config "branch.track.merge" &&
> > +	(
> > +		test_branch_upstream track . master
> > +	)
> > +'
> 
> Is this "git config" necessary, or is it a remnant of a debugging
> session?  It is tested in the helper that branch.track.merge is set
> to something, and otherwise the helper would fail the same way as
> this standalnoe "git config" would, no?

It's a remnant of a debugging session, sorry.  It would indeed fail in
the same way, so just leaving the 'test_branch_upstream' is enough.
Also looking at that, there's no need for it to be in a subshell, will
fix that as well.


> > +# setup remote repository $1 and repository $2 with $1 set up as
> > +# remote.  The remote has two branches, master and foo.
> > +setup_remote_repo () {
> > +	git init $1 &&
> > +	(
> > +		cd $1 &&
> > +		test_commit $1_master &&
> > +		git checkout -b foo &&
> > +		test_commit upstream_foo
> > +	) &&
> > +	git init $2 &&
> > +	(
> > +		cd $2 &&
> > +		test_commit $2_master &&
> > +		git remote add $1 ../$1 &&
> > +		git config remote.$1.fetch \
> > +			"refs/heads/*:refs/remotes/$1/*" &&
> > +		git fetch --all
> > +	)
> > +}
> > +
> > +test_expect_success '--no-track avoids setting up tracking' '
> > +	test_when_finished rm -rf repo_upstream repo_local foo &&
> > +	setup_remote_repo repo_upstream repo_local &&
> > +	(
> > +		cd repo_local &&
> > +		git worktree add --no-track -b foo ../foo repo_upstream/foo
> > +	) &&
> > +	(
> > +		cd foo &&
> > +		! test_branch_upstream foo repo_upstream foo &&
> 
> It is true that this test helper must yield failure.  But what you
> expect probably is more than that, no?  For example, the test helper
> would fail even if branch.foo.remote is set to the upstream as long
> as branch.foo.merge is not set to point at their foo, but what you
> really want to make sure is that neither configuration variable is
> set.

Yeah you're right, this test is a bit too loose.  Will fix that in the
re-roll.  Thanks!

> > +		git rev-parse repo_upstream/foo >expect &&
> > +		git rev-parse foo >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
> >  
> >  test_done
