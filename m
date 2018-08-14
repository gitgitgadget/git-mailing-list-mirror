Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A2A1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeHOCAS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:00:18 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:38239 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOCAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:00:18 -0400
Received: by mail-pf1-f175.google.com with SMTP id x17-v6so9920733pfh.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saW4qybAbQInu/HjYLeb1R99qLQIypd4C7jogNQZNJY=;
        b=auR4v1msnB+RW5IxXpBZYDMnmQP5maow3tJ/7ecSZUx96VBYsR5X76SuZWTYsqTBF6
         YbM2mpiJMHyvVZ4R/EWPo9rB8466M+D56DMURED7Z1+Skq98G00e+xflbSrqc3c8ekz7
         8/PFG8Q+oLpKzfRhT2wd4D781OFxVuRgqcJRhurP65hh2CcBi7TMLh6oJNdi3+G48uys
         pMFWm1miskmDzFL2UHaJ05wAm2MORSzWxAFrVAw/wRAc/2oCNsvbfZ8QJuRf9eKL9IZH
         NvdkqBLsHdE6dAj/WhwUj3whZ37aoZto4bCyMZXdWxlLADY1j0WaAiS8UHr7gYJgrqmi
         F+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saW4qybAbQInu/HjYLeb1R99qLQIypd4C7jogNQZNJY=;
        b=SpLw4VXU91DAKyA9l8QGg+wLG5k1EGYe6wTYRZQW9tJayaCswqlZnLx8+HfGwUhjNk
         NAoVS+v+u2IEccwbAJt9Bgm4nQfHXxMRUz1ACZOjq/2gRtl/pdlVNnDgGtbD7BHZ6Jgc
         qQ1494+G89B/V3jZgsaiJc3YTI5/A5KapcgC4uI84GEtcmfh2hlzi5Zok+OcjyJEDhFD
         TIP8mNXi5lKMvVG306qh7Dg+SKG6/UMUaG3QWUT/k5oZ6sLnk+XjdNtfVl5TxRCarI1+
         ctr5p+2Bxot99FItY5t63iPgeDmePaecrWokmt0K4kQG2N1BtOH/sWhBooskN6KSWg92
         uKkg==
X-Gm-Message-State: AOUpUlHpm8ehYxQqRXBM0G5f0ZkqUIX7iy8j8QhRlVPnpTIFbIz3ztE2
        Ps8wsI3rO0XhmMB71WF/LjQ=
X-Google-Smtp-Source: AA+uWPxfMRNtqBI16aBPCVfF7CEB41EfOrXHPBKyZZZWsB5F5GZu8hVNcQYpq7Eljr7kaoJWMF4UTg==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr23253654pgk.32.1534288251840;
        Tue, 14 Aug 2018 16:10:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r87-v6sm42077795pfb.1.2018.08.14.16.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 16:10:51 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:10:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodule: 3 modules same git repo?
Message-ID: <20180814231049.GH142615@aiede.svl.corp.google.com>
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Joakim Tjernlund wrote:

> I am trying to create 3 submodules from the same git repo, each pointing to a different branch.
> Since the repo is somewhat large, I don't want the 3 submodules to clone the same repo 3
> times, I want one clone and then have the 3 submodules to point to different commits.
>
> Is this possible? If not, could it be added?

It's an interesting case.  You're not the only one that has wanted
something like this: for example, "repo" (a similar tool with some
differences) included the change [1] (repo: Support multiple branches
for the same project, 2014-01-30) for this kind of application.

In practice, it's a bit messy.  To allow switching to a branch where
the submodule is not present, we store the submodule .git directory
in the superproject's .git/modules/<submodule name> directory.  This is
an ordinary .git directory, with files like

	HEAD
	config
	packed-refs
	[etc]

The "git worktree" tool allows having multiple worktrees for a single
Git repository.  Each worktree has its own HEAD.  So the layout would
look something like

	.git/modules/<submodule name>/
		config
		packed-refs
		[etc]
		worktrees/
			<branch1>/
				HEAD
			<branch2>/
				HEAD

By piggy-backing on the "git worktree" feature, this should work
great, but it will take some work to teach Git to set it up.

A side note: as Stefan (cc-ed) mentioned, there is another, related
interaction between submodules and "git worktree".  Namely: I might want
to have multiple worktrees for a single superproject Git repository.
In that case, the layout might look something like

	.git/
		HEAD
		config
		packed-refs
		[etc]
		modules/
			<submodule name>/
				HEAD
				config
				packed-refs
				...
		worktrees/
			<branch1>/
				HEAD
			<branch2>/
				HEAD

The patch that Stefan sent heads in this direction, but it has a
problem: if the submodule is checked out in both worktrees, then they
cannot have the same HEAD.  So to support that goal well would also
require supporting the goal you've described as a side effect: each
submodule would need to have multiple worktrees, at least one per
worktree of the superproject.

Sorry, that got a bit contorted after a while.  If you'd be interested
in pursuing this, I'd be happy to review any thoughts you have (for
example if you write a brief design doc).

My experience from interacting with the feature [1] is that it is easy
to make mistakes when trying to support this kind of case.  (repo had
some bugs due to, for example, multiple checkouts of a repository
trying to run "git prune" at the same time.)  The "git worktree"
feature should be a good foundation to build on that avoids some of
the problems encountered there.

Thanks,
Jonathan

[1] https://gerrit-review.googlesource.com/c/git-repo/+/50715/
