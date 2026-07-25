Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529372DCF74
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978521; cv=none; b=djDgUTJWaI2339Zjilo07U7Lpd0ii16gvTIFhv7986svtPzPA/O2uerPi3yAMcPCcQ6DKolwY2s9jKeEzvYBouZO5XcAovM634b1pJXRmxoCzD+flM2KaCwwPeUcNaMXvdHXhSHml+axMA+69BIifDLM+0QZMq9AvRAVLBimxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978521; c=relaxed/simple;
	bh=aPpgZuduikZThaVUutK2Zd1mAye93I/j/UGM9dNq7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXJ/VZRdkttOk5AZJP36GXAd/dSTBI7WV0uguNIt7kr/gEr3ame7nR2xItVwdwHvb24RMCwwJwc/PNvKglmF+he0L28VL4UziMnRLyrCNbW7nMtOuRoMhRg3jz4KVprYLWhzn/ttY7tPnTBOgjJSPb9l1CR635xNczXI8lvwN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThnkIKUH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThnkIKUH"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ca300db70so10990631fa.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784978517; x=1785583317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwOUCccmd4V2MOkMpY1sd0nYKYMcegnMt1OoXssb8Q0=;
        b=ThnkIKUH+1Wa8FO/YTS/GgnRo7J+Ra9dQ0wFo6UJ6226KAb1m1vktN6VMvQfnAlyNA
         FKAee9eScoUOh9wSXRKO4hRt7gNIuADZu7JBwD44jSgxcOw9oysFT6nJf8yj5Y9t+BYg
         EeBctDbThaeQMq20yL1k+qE9G+gm7b8R6I7MYuXVpfGvNSj4k8gVU2o8KMlF5//YcrEH
         GY73Lcx/T+2N8r7XIH1y48tXR2HDm1barYPs9QoOkLZb3aNpyYHJM51NFOgENNLSkO1J
         sgFIIHg6OPOxybho2JI1YnleyZTN9i/V8saNEHc1KLFLNOX4p70NXZXEOl9GdNRNKcUv
         5S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784978517; x=1785583317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwOUCccmd4V2MOkMpY1sd0nYKYMcegnMt1OoXssb8Q0=;
        b=jnYN5HnSP61rsIlwimllYorcCzhdY0g3Tzj4RlOaaX5+7xubrhSbIQHUZZ8LbehRaw
         mJM/UFXVQR+HMo48/WBhwRy2/SAuSCyoWbLzdFydOp3vu9+30WgIhdsgcsv4t5yO5wsP
         u2dg8p6/ndFnLw8PMkSTNNih/SlYzaFTqGZ00ikd1osUsC80g9IF/kEn2AYGNDEK/jOX
         35hsHImDI1wUF2eX+K5CJRkXQWpo5ylIZoIo/KX6/Vx8vxrqqxU8kDTO2jEu4LXU0iRK
         n80NVkFkgdh+ZEDL8Hb4/icHUfeRtgIGS3oj/pG1pBL1onXPf1bQDxILZ4cLhtqaLgVA
         1Gdg==
X-Forwarded-Encrypted: i=1; AHgh+RokVs+NknYjHnGTfCOKj47g9YQLIPew1jJCPAF+yxHdaaG7avgybol8IyhIZwOHt9Pp6G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjppozlL5zAslHInBfh/5C/D54QBz+rbzFjLWIXHJELHBzqrI
	ErzKi0DEc4r5uRWUqhzvuQr3NIDxawriKWFA6cUpr9HtgfID+KwRky3+
X-Gm-Gg: AR+sD11d4n5G/CL5v4JvOisw4t/e3Qyny/HGklDRtjzU3Er4IJyBLO71C/UQ0T5ogmE
	yKYmro/w9HGc0YEf3eNcp13fY0HFcTMWbuO2Rhs8KcVVwk7QDneU50o5SapRBvq71+cg1mGSh0a
	r8ko0aYTL7TXM8bOT/IUmViYq76A37VCFTm8fw6aGqF4PFqf9xfd9b3oadYeT2+R32DFg4LG+PM
	mXYgQ77/mDfZ5aXhvBG95nhlS4FWekiJZXsnGytDmVnXWunX8zkpdHFe9+Yc+LgvmP/PMdaWwsA
	WLGB6el8nDA3fy5IDCQIqzoSYpqUhQhCREUoketZ6uNFUXXS7JcsUMyzcu85LQCtzJyuLd2eV+k
	HeQLQ2HvR8vKdKLrELrZOmWnb/CZjChgFsB+u0xtZdx110bFqCUErmeQBK6zfguvMD/7+U04Mco
	G7oFJYQrhDlZ/h1jAdlHi+r3alQRZiTntWSuDxZV9xsNvXtckJ/aWiVd13x60NQAYZZfryxB3zS
	qRHGVZOuMNRDoDsakHLMMqwxawYpDqUZq0EOI72DtM+dPUfIB17Pg==
X-Received: by 2002:a05:6512:2349:b0:5ae:a9eb:c5c6 with SMTP id 2adb3069b0e04-5b2c1b746a6mr325167e87.64.1784978516759;
        Sat, 25 Jul 2026 04:21:56 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:814f:8c04:e740:83f9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be07fd0esm389211e87.19.2026.07.25.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:21:55 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Sat, 25 Jul 2026 13:21:53 +0200
From: Erik Cervin-Edin <erik@cervined.in>
To: phillip.wood@dunelm.org.uk
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
Message-ID: <amSSYagL0jTgzElD@mbp>
Mail-Followup-To: phillip.wood@dunelm.org.uk, 
	Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
 <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>

I ran into a minor regression that I tracked down to v2 of this patch
series. When I was running

    git rebase --interactive --update-refs

I got a comment in my git-rebase-todo for the branch I was rebasing,
even though it's just the current branch in the current worktree:

    # Ref refs/heads/main checked out at '/private/tmp/gittest'

where I'd expect no entry at all, since the branch is updated by the
rebase itself. After applying v3 of the series, the regression went
away. Nevertheless, I thought I ought to share what I found.

On 26/07/24 10:55AM, Phillip Wood wrote:
> > > +        if (head_ref && !strcmp(head_ref, decoration->name)) {
> > > +            free(resolved_ref);
> > >               decoration = decoration->next;
> > >               continue;
> > >           }
> > > +
> > > +        path = branch_checked_out(decoration->name);
> >
> > Then we check to see if the decoration matches HEAD which we used to do
> > above - I'm not clear why we have moved this check.

branch_checked_out() can't tell "checked out in another worktree"
apart from "checked out right here", so `path` is never NULL for the
branch actually being rebased. In v2, the check above was instead:

    if (!path && head_ref && !strcmp(head_ref, decoration->name))
        continue;

which made it a no-op for exactly that branch -- the regression I
observed. v3 drops the `!path` gate and moves `path` below it, which
is why it's fixed.

> > As topic2 is checked out in the worktree where the rebase is running
> > why did this line appear before?

This might be the same symptom from another cause: on master, head_ref
comes from refs_resolve_ref_unsafe(), and as you note its buffer is
overwritten inside branch_checked_out(). So by the time topic2 is
compared, wt-topic's lookup may already have clobbered head_ref,
letting topic2 fall through to the comment. I haven't run the test to
confirm, though.

Thanks,
Erik
