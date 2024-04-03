Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647415099C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168991; cv=none; b=JANbDdLRKBokB8n7mYLKnaZW6lD8FetEP+2LNB/AvVI25nKezRzJ9E780jJCMNwnWIOkuXl4nRj3uM9HfSlzzowbwEArSzCGADZQAk8KZTT1xikmF4vXP61Yzu5s+RuAeRZN9bdcvyqm+j4Xb7Cvs1xIUBJOByx9C6/ZUoYmBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168991; c=relaxed/simple;
	bh=Eey4PbqbSTuG+o+wnHpiIr/yyRUPw1A3zu8iDefja/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbdArSunpEgYRKVdfSxWahDviODS/Pk7+pi3xIfzTx+QbMGVwDnPrUbGGaZe/ZHhvo+dbExMbr48t/w5CBQ+W9EEUjepP8qb2dLzPVI86RxtTY1bp4YddjwpkCCDAaoPMHJxy4vVP51Ax9RlD/3suwh8xBuE9xB/XjjKKFV4GYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhhxK+V2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhhxK+V2"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221e6bf537dso101506fac.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168989; x=1712773789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kd/1OsSI+VavqqjCGuI7Z8Ql6dKjQZF682G+1bLZws0=;
        b=RhhxK+V2l9o+UOAdpMH0bRG6J8dIsAMU0mh1iD/OvHlKFZg8ad8QoPL+W7wh4OKYXm
         XyY/QARVsL3aOEnWrQdu+yE+n6rOwLqOQal80EcJJtVEMdQEbHU098TQZ+PkgfaBCua7
         FfMdKfVllupcVjANUAKMedxW2XRwPVMnFGZQaQTeZptDsahg+EI5+/9Y6yQxSjR0ZWR5
         pZJ2QmS9K/Xn3/eYRapK1FXHRMEr7+Lhc9N+IkQqvb2zCBiZ7qhuvit9oWjAyGWVf8Vt
         d98WcHqu6rkIfhCAdMdHyP0tPuWgkKQjHA3ZhP0kKIObnVScLG0WVQ6YT1CPKzAwCimv
         o2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168989; x=1712773789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kd/1OsSI+VavqqjCGuI7Z8Ql6dKjQZF682G+1bLZws0=;
        b=DoKwbe4aVG+oCYRzAxy7+bWS7HoARUNVzydOGN1833Uabj8cfHn/yOdhjA26+nF6pd
         crZHBHRkph+JRWLWVfnTAz5PgMMbNhJfBxmbnD9/UFT9Vvvbvey/n5cSUfc89383KfOk
         JxKndRNd43VGIv6DHLtHPpopT/dtkvNAjuqSB7XQ00zYkukATs1hDKa1QwZ6nXhCLskb
         BLYffQwxWp5i3wNnB3qwPTaj2wxGcY7gUwmiAtLMYwgMtqiRgSr7WoIfK1qcKWDHLQ1b
         fFgQr8LafGYe0NYAT5bVH/UUj1saCku5wegMh3+nuiafbnIuVuA47WVPoCL+zzfk4rUV
         3NTA==
X-Forwarded-Encrypted: i=1; AJvYcCWgmbhzUGXqQvQIYPv7l5w6i3YFGfUHOFGV07xkxQHHVvLoLbi/bwGNsnCNMYd520e/C4EkwA6O9bBbpXQkd9KlWIRy
X-Gm-Message-State: AOJu0Yw1g5mJY10aUEB/qUNXd8yfSRuAFiGrPsZb8OZex63OO4Qyo1Du
	xZU3c0203n471POY+JnlxXhrkWEV9gf4/xM990RwF1jZCYldrVmHq0PUZL/7UZVOPjca7W1ETD3
	Y003X6Cc/crbwdEEWDH2k+I8ShQ+Z/o5aYTP2BQ==
X-Google-Smtp-Source: AGHT+IESg+sI/6WXMzCBwoPuWwdtB//Z+BnBdmWN0T/9QaP/6HXus/dRjkyBzOtY1mgyqQ0QLZq7SNqrhhelmwUx9eI=
X-Received: by 2002:a05:6871:609:b0:22e:792e:4ac with SMTP id
 w9-20020a056871060900b0022e792e04acmr112887oan.43.1712168989141; Wed, 03 Apr
 2024 11:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+2m0i9JE92EqoZgNKTQn8FdY8cAxVLupa1fyRPNG_RN=5H1Cw@mail.gmail.com>
 <17c2d5148e3afb10.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
In-Reply-To: <17c2d5148e3afb10.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
From: Bill Wallace <wayfarer3130@gmail.com>
Date: Wed, 3 Apr 2024 14:29:38 -0400
Message-ID: <CA+2m0i_UaGsBGYt5=CDYP1q13G1m2dB47QfnQ46J7BX8yrX0-A@mail.gmail.com>
Subject: Re: Worktree shares a common remote with main checkout
To: Brian Lyles <brianmlyles@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Each branch has a parent origin/remote repository that it is directly
tracking (or not tracking), but there are other operations that
presume the name "origin" as the name - the two that I care about are:

git fetch
- this should be able to default fetch a remote associated with the worktree

git push (on a new branch)
says:
  git push --set-upstream origin testBranch

I want this to say
  git push --set-upstream project1-remote testBranch

instead.  Ideally, adding this automatically should set the upstream
remote to the specified upstream branch if that is configured (which I
never do, since I often switch the upstream).

Ideally supposing there are two branches  origin/main and
project1-remote/main, then doing:
git checkout main
in worktree project1 would checkout project1-remote/main
while doing it in the original checkout would checkout  origin/main

There is no change to the functionality of worktree branches, the only
change is the ability to store configuration values associated with a
worktree (not a branch, but the worktree itself), plus getting the
name "origin" from configuration instead of defaulting to "origin"

The setting `checkout.defaultRemote` is close - but I want that to be
something like:
worktree.<name>.remote=<value>
eg
worktree.project1.remote=project1-remote

and then:
git fetch
will fetch from project1-remote when in project1 worktree

With git push having auto setup remote, this will default to pushing a
branch testBranch to
project1-remote/testBranch
and without it being auto setup, will show the message:
"git push --set-upstream project1-remote testBranch"
as specified above.

git checkout nonLocalBranch
will first try to get nonLocalBranch from project1-remote, and only if
it is ambiguous on other systems would it complain.

Bill

On Wed, 3 Apr 2024 at 13:24, Brian Lyles <brianmlyles@gmail.com> wrote:
>
> Hi Bill,
>
> Phillip Wood wrote:
>
> > You can set a different default remote for "git pull" for each branch by
> > setting an upstream branch with "git branch --set-upstream-to" which
> > sets "branch.<name>.remote" and "branch.<name>.merge" or
> > "branch.<name>.rebase". You can also set a different remote to push to
> > by setting "branch.<name>.pushRemote" - see the "git config"
> > documentation. Would that help?
>
> Bill Wallace wrote:
>
> > It helps, and I do that, but I really want it associated with the
> > worktree so that I can work on projects for different vendors based on
> > a common open source framework.  What I'm trying to avoid is
> > accidentally committing a branch to the wrong vendor's stream or
> > mixing changes between streams.
>
> My understanding of worktrees has always been that they are simply a
> checkout of an arbitrary branch, and that branches themselves define
> their remote as Phillip noted.
>
> I'm struggling to reconcile this fact of a branch defining its remote
> with having a worktree also define the remote. How would this be
> expected to behave if you try to switch a worktree with some defined
> remote to a branch based on another remote? A warning or error?
>
> I am also wondering if an adjustment to your branch creation/management
> would solve this problem without needing such a significant change to
> the definition of a worktree.
>
> At the point of branch creation, the branch will track a specific remote
> based on the ref it's created from (assuming that ref is a remote
> tracking ref, and based on your `branch.autoSetupMerge`/whether
> `--track`/`--no-track` is used). The remote can be corrected after
> creation as Phillip noted.
>
> For example: My understanding is that if you were to set your
> `branch.autoSetupMerge` to `inherit`, then when you create a new branch
> it would inherit the remote tracking ref (and therefore the remote) from
> the branch that you create it from. This would be the case whether you
> specify a ref manually at the time of creation, or just omit it to
> create the branch from the current checked out branch. If the latter,
> then by creating new branches from within the worktree that you
> designated for a specific vendor/stream, you ensure that the new branch
> uses that same remote.
>
> Have you tried that approach? `branch.autoSetupMerge` has
> several other values to control this behavior as well though `inherit`
> seems closest to what you're looking for to me. If this is still
> insufficient, I'd be curious to hear more specifics about where it
> breaks down.
>
> --
> Thank you,
> Brian Lyles
