Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491613;
	b=gwJr/vsQYK9U6cceTzVcp1HcGhMh3qnYe6oFBpXrS8RcdWaMhCXyrk8hEcz/+w7XSUhp
	 3tlwdmQ6oV8Zo2Ev7DWtw0+hCPXUY0UmNemziZpsNMGb648WcaxuT8ObzwGMyUCvDmPtI
	 x/Aj0RMlwdPs+q0+pOAPhRf81MFwAkvDj09U+i3+Un19a8toy4eF4nSQCf9bU0ApI+4JV
	 NaWLEW1b0VNadSRKM4d18bvbIgif6YT3dofMHZuLeFGl6z+e4/rlTXTs7Wr+HUdqkDPwM
	 8Gw6oiAeZdwyjfbqvi4hc90WULKJdiyCvAX5hVKdrXX6th0K2i+OU+12ZiSZmgsCIXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6dzvVhBFYzcRcgHlpA4FmbbmQqgvX87Wta2I7u6AsXw=;
	b=3+qtK+BuWDERzlZsUpM30a5BRVrpwHbKwzJJJev7ltET8WViX1kMIy2f28YMW4gXAUPo
	 icgTLPmiZf4JRs4mWJJuWuE7YlgF4u+EpClGRn5wsdu9EfSgBejzMU1XcwoUGFJlbiud6
	 NItkb/TihhV4t2zT7OAwkD+TtOpaypenMv1SHWRYJb3Qjc6IggHywi0IZlOlV/RkhsrOK
	 pIMsEw6NxpmICx0X64U9GCReZmf0fa6lTF1m6YjWTR2luORBvFyON5RFhVzqRXF9L/Q1p
	 2i3rI2+TJDE9FfmY0FC8/ifU66DX696h55PGySUtCRyJjhmyFkYLx9PZyzGZ/grr6bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HIHuprB4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8E606A32E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC8E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HIHuprB4
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so3028318a12.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 03:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491611; cv=none;
        d=google.com; s=arc-20260327;
        b=lZckrggSRZyC8iPVjd0OwuIT+zZwXM0aa2kLJL42B5Eb88TZvpbDB4/wpa6c23iX7l
         o+w/VXJnn5WmAM9ToEdWIHVZcbhI2HvRMeD0tUc35t3nb/ww11/TSKA5T1EBEgbiTcGr
         LQQMmRc1Y1e7telc1SsA6ow+3X9FaKEt59f5UAJwj6l6cjFjvXRaFqQlN2/BiplGpVF6
         WcyfkfHQ8OyW6IJekugf1G1KD9N4btQhQoiAU8W5vx5niW9H7UOh1EqQoXe1aq3vEfEC
         eKDjv8pK1XIrVnNcUQqecuC+p2kZijaKdz7yYvdoJFG7k3N8sOZm8SUKwwmP1rOl470f
         X0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6dzvVhBFYzcRcgHlpA4FmbbmQqgvX87Wta2I7u6AsXw=;
        fh=GAgdSAfCsAcTR2oXXhcu/ookHUP7GS+pmdMsvSXLD5o=;
        b=FWdHWFGr1yRqRWYXv0zwcYfPN+e1LrLenEeniQNA9hwJZzo2PxKJR6X0oYz+o5QyjU
         of4Jb+v0gl8Z63G6AeJByw1qpExBH4qLtmiFXoFOOXeXa/RUX7TYP2LuCMAR2zABSjdp
         q4XVLFJUYrqPSk/pzdArfYBbT1erh0785AVoPJpRzYUoGhKIOxCJYgJkTZtkdhdZR0e5
         gwAJZigAXHVajVTQgUznAFmQPoWh+eX/Wgq7Z7Bewz8VjxkKCaiDuhYimqqNxiic3GLu
         SvTzPp6HcxCwSj48xE3IdJOH4s1qwumKXkTqciFagrsU7rFHZU1LbCkaPwj1DEOVZl2/
         xoOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491611; x=1793096411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dzvVhBFYzcRcgHlpA4FmbbmQqgvX87Wta2I7u6AsXw=;
        b=HIHuprB47wwqRs864ZLkMV7fp2ua43+b89CAY0E7kN6avVc3+b5C8xyqFpbknAm9G0
         0oNvMLrw0nfYaH1ow9Rsf6KFq2MCSzCGiDLAw7Ztn948E57Bz0A4ygKGaZxZLH+4ww+/
         4zP+FpgNcykfO+JUD94sk8KrEgYfmDauIGPC8SngV0z5FhzGkaX7A4APA42XyKp/yx5a
         BhPkkIQ5wKvfFEJA8bTCN4cprF22whay/7PSzVg2hU2qf1GbXRYk6VdwXh/b0cFoYF00
         jqFeiFSI6YcJgmqufU+qRElMXiXPuCqqvnfjEe/EmT8Bwzl2W+KgRb1XJ0Cy4tvxqJBP
         N0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491611; x=1793096411;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dzvVhBFYzcRcgHlpA4FmbbmQqgvX87Wta2I7u6AsXw=;
        b=tbmlXn7lRW0CGNLhdX7779BewEjQc6mefXOs41qECJGv27MTAO0nOCCe5Hz/cUQbQi
         8zg/th1shQTsjo/BHG06uwFGtxTWWrD79CyYqCOWvX6IpZOc30lfJbAbDS7xU+y4C7JQ
         VWcZVW+VTL8UeC4wSiJyP8j5YG4zeeGHHdIESHs+1nBVYP/vWCIZTSvWaya25V2r5Ufg
         F3dJfc27kDQUHJr2Ju7+QGiupcRLmFtbtypuqVOYhTarTEWQFywuHM8pAVaGWyUd8OtV
         abxc1tjDUxFw/zsnZyPdB99s0e2v12jpLG8kOlwDwpaGLYWsQ8g1uLyxwjrrRlFic+JN
         23kA==
X-Forwarded-Encrypted: i=1; AKwUvBzoYR+Gxl8SskXwgaG4RYhiH5OHFYXM+5wzEL4lOMW/Iht/vMJuEiAhJYdpd7NGdpCUHZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjhfqLt5BJ7maluTRUZpbGljJENCI6jOvcPhRjobjGNNfLeCY4
	10elc3aCjOe/St0hpkwly4/QisoiypcIfxcdX617FTn1+6KLMvdS18MDS/GCywWlvQhUqKYBk5q
	s+wgH1mETwLqE6gCFE7cbGNMYolETwBcdBw==
X-Gm-Gg: AYBFou3pIeaL4v7xAMpiyf9lBGerVfg9YxJck/vVEZX8eJmbk5l0cu7nVsEqod0pcO7
	fVi1MfKPJnihpODZGBHTAtpu6XkdvoOnn2j9EdYYQV+Doxg3hxmxYP9Y3x6ae19HUIKJ+qefFb7
	8ZnAUOwiFIS30/2FzoWfROnSB9W5Lp3plmOgi42SicYMSv2LSwb4wjDo8UeBKgsgRqRmrnG3y79
	6fzwQDtXZWAPSuz9FjIpM2rybuJRja1+a1W0gn94aL9DMzfLqorigTI8MvN/H47pb6x2W+dRQv0
	OwK28z1Js07jQKgXlKi4aM0gzi34Z9TMEPFtUoea9i8rzGMj1ZzRRX8g
X-Received: by 2002:a05:6402:a54c:20b0:6b1:c355:c793 with SMTP id
 4fb4d7f45d1cf-6b3a81d1075mr4627193a12.40.1792491610939; Tue, 20 Oct 2026
 03:20:10 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com> <5030377b-58c8-4193-8d72-79955082269f@gmail.com>
In-Reply-To: <5030377b-58c8-4193-8d72-79955082269f@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 20 Oct 2026 12:19:33 +0200
X-Gm-Features: AclHuK8a6tT1ur9fK1MZj0wrvudJ5vrRsDLscP3DAqOq2Lc4cB53yu6pMOSnv7o
Message-ID: <CAHwyqnU1NPp3N7Qv3ChEPCo-mL=gASeG334YFg2tczzLomsm6A@mail.gmail.com>
Subject: Re: [PATCH] status: compare against both upstream and push branch by default
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If you want to change the default value of a config variable it is
> helpful to explain why the current default was chosen as well as why you
> think the new default is better. In this case wasn't there some
> discussion about the default value when the variable was introduced?
> Providing that context would make it much easier for people to judge if
> this change is a good idea.

That's fair.

> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2458%2FHaraldNordgren%2Fstatus-compare-branches-default-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2458/HaraldNordgren/status-compare-branches-default-v1
> > Pull-Request: https://github.com/git/git/pull/2458
> >
> >   Documentation/config/status.adoc | 11 ++++++-----
> >   remote.c                         |  1 +
> >   t/t5505-remote.sh                |  1 -
> >   t/t6040-tracking-info.sh         | 30 +++++++++++++++---------------
> >   4 files changed, 22 insertions(+), 21 deletions(-)
> >
> > diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
> > index b5dd85b761..1d847d3a8a 100644
> > --- a/Documentation/config/status.adoc
> > +++ b/Documentation/config/status.adoc
> > @@ -23,8 +23,9 @@ status.compareBranches::
> >       are supported. They are interpreted as `branch@{upstream}` and
> >       `branch@{push}` for the current branch.
> >   +
> > -If not set, the default behavior is equivalent to `@{upstream}`, which
> > -compares against the configured upstream tracking branch.
> > +If not set, the default behavior is equivalent to `@{upstream} @{push}`,
> > +which compares against both the configured upstream and push tracking
> > +branches.
> >   +
> >   The entries are shown in the order they appear in the configuration.
> >   Duplicate entries that resolve to the same ref are suppressed after
> > @@ -36,11 +37,11 @@ Example:
> >   +
> >   ----
> >   [status]
> > -     compareBranches = @{upstream} @{push}
> > +     compareBranches = @{upstream}
> >   ----
> >   +
> > -This would show comparisons against both the configured upstream and push
> > -tracking branches for the current branch.
> > +This would only show the comparison against the configured upstream
> > +tracking branch for the current branch.
> >
> >   status.displayCommentPrefix::
> >       If set to true, linkgit:git-status[1] will insert a comment
> > diff --git a/remote.c b/remote.c
> > index 71170f36a9..6fdb4b84da 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2465,6 +2465,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
> >               string_list_remove_empty_items(&branches, 0);
> >       } else {
> >               string_list_append(&branches, "@{upstream}");
> > +             string_list_append(&branches, "@{push}");
> >       }
> >
> >       upstream_ref = branch_get_upstream(branch, NULL);
> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index 5fbfcb0848..f77753605f 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -34,7 +34,6 @@ setup_url_pushremote () {
> >               git checkout -b topic --track origin/main &&
> >               git commit --allow-empty -m topic-change &&
> >               git config push.default current &&
> > -             git config status.compareBranches "@{upstream} @{push}" &&
> >               git config branch.topic.pushRemote "$fork_url" &&
> >               git push
> >       )
> > diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> > index e95d420972..e10cde090d 100755
> > --- a/t/t6040-tracking-info.sh
> > +++ b/t/t6040-tracking-info.sh
> > @@ -331,19 +331,6 @@ test_expect_success 'status.compareBranches deduplicates when upstream and push
> >       test_cmp expect actual
> >   '
> >
> > -test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> > -     test_config -C test status.compareBranches "@{upstream}" &&
> > -     git -C test checkout main &&
> > -     git -C test status >actual &&
> > -     cat >expect <<-EOF &&
> > -     On branch main
> > -     Your branch is up to date with ${SQ}origin/main${SQ}.
> > -
> > -     nothing to commit, working tree clean
> > -     EOF
> > -     test_cmp expect actual
> > -'
> > -
> >   test_expect_success 'status.compareBranches with only push shows only push' '
> >       test_config -C test push.default current &&
> >       test_config -C test status.compareBranches "@{push}" &&
> > @@ -361,9 +348,8 @@ test_expect_success 'status.compareBranches with only push shows only push' '
> >       test_cmp expect actual
> >   '
> >
> > -test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
> > +test_expect_success 'status shows ahead of both upstream and push branch by default' '
> >       test_config -C test push.default current &&
> > -     test_config -C test status.compareBranches "@{upstream} @{push}" &&
> >       git -C test checkout -b feature3 origin/main &&
> >       git -C test push origin HEAD &&
> >       (cd test && advance work) &&
> > @@ -380,6 +366,20 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
> >       test_cmp expect actual
> >   '
> >
> > +test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> > +     test_config -C test push.default current &&
> > +     test_config -C test status.compareBranches "@{upstream}" &&
> > +     git -C test checkout feature3 &&
> > +     git -C test status >actual &&
> > +     cat >expect <<-EOF &&
> > +     On branch feature3
> > +     Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> > +
> > +     nothing to commit, working tree clean
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> >   test_expect_success 'checkout with status.compareBranches shows both branches' '
> >       test_config -C test push.default current &&
> >       test_config -C test status.compareBranches "@{upstream} @{push}" &&
> >
> > base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb

As a side note:

I see that you include the whole message in replies, leaving
responders to clean it, so more work for multiple people instead of
more work for a single person. Isn't the convention to only include
the parts that you are responding to?


Harald
