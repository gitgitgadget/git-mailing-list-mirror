Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642248;
	b=3jcL+YLPeO4PZnU2B5FKjzmq+rAZavtc1iAx9bp1eKVepMsbm0sKJ2kgTuee2By4zEcl
	 Eh6r6jan99kb3Bqfi5HEJtd/oq2ZDrdDc0w3xHUEaeshfAYupXPk/rf3O1CUBTKR7u/Pn
	 TA6Jua8Ssxbe7QUpkaSu1bzkujpEKTfLfDrIP6dyXgD56dELU9+AssbS2bcfu6QyyB9s2
	 FgbzJqDhKjzlRyGXnJ+UQD3G99PI78CiJEXeu20JtZSkGHi1Nz3BzBwxAI02HgOfEP2MW
	 quBmqUC9AGodigAhR/9ZM5Pii+tZe3kwxHHU/abybVW1FOee7IAsmDbw0xNvq3F6XBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ftxVTehDyiV9GfRj+1wDfPULO95KrnZHkyi9ZG9/MC4=;
	b=dkbvWq7ybsNGMUGcOvTomycwXU8no7Y5Ni++Rl5VhT+oisH6HqBrofCurjoMasPG6sHD
	 z3AALdHnm1nKZ6MJLXwKPQGkfw9IIMEAaWrgmN5EC3rXd3BsLAk1PmgQO+y3fnhrKze5k
	 IMggwRIefadF8R5mkfSVYGVWhXHZO9j6Bbd2esE5u/wZxDppspt5FHkKvINM9HjDKnRtk
	 k4akIEzJjnKoiHbKPcy7a+eRi0QYv7Nd9RdXnzJqdfs4woqUmgqar7U6KPWD5ZuYZtaDn
	 952W3FovzMKUO7UWnP+jPmWGRQanMe73Fk6AFzcN2MrDL7jtQ16GxDlJie2E0llnX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=kSbMIoV7;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA189606D825
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA189606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=kSbMIoV7
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365d725440so33737561cf.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793642247; x=1794247047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftxVTehDyiV9GfRj+1wDfPULO95KrnZHkyi9ZG9/MC4=;
        b=kSbMIoV72GuTGPjvBLzSNEwInFW1kb9zU5AXuWdAEY9odb+oabC2mDaG4fmiFk6uus
         Ytt2fB9ybfGiPpXtRd7yvJzc++/vGovTINGOoB0i8dX9z6E3qVb7xrOr8pqWfrdmbTg6
         vURc/5OscQDE0Lyks9z+B4T9/KXTxfChaPWCxcMuN6WKEhV2qaRM76prVMRJ8TJrbZqR
         C6AWpJQNaymmp6DWxDvzVBK0jSKNcDvLm0RQNC2DI0K5rvmh7EJbNkN771YS0tFz6dsa
         F92+DKu5DD4Jjh9rb19CB+y2CiKwBzA0giM1JUErbV9O6xogo8Epx0Dspknn0YYsphvy
         2kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642247; x=1794247047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftxVTehDyiV9GfRj+1wDfPULO95KrnZHkyi9ZG9/MC4=;
        b=PXhWArVsXwVpkTZZ7yfT88Vc6UONevPmcc1MdRJYkj1P/p0ojVXnrRW0QE8NVFntvE
         zz7SSiIAmWuG+xsryFl4bxk3MzGXZ5al27wC9ZKxPfEAVU+j+X12qTwxh/wL13sWtDEg
         6YL7TRTqjIsCfxGVuI8ZfCtxqqAuuIrG2I5O9G3q+k1aX0Dxkfg8m7vka2JVntUvqEzx
         ZJRhiJd2Ibarho4jeKfBriuum7skowoLa0uk8Zj6fmkHdYloU4moWECvm1BrFsje5PmK
         /5AIqOg+7/hbeLFDd8tSlkJ7zHU9hpsgiU/i6pqVWFIileAqsp7zujz1juBfpZfo37Wh
         sisg==
X-Forwarded-Encrypted: i=1; AKwUvBwy07Thsf8pR76YWx8iNIHUMKm/TXss33UhgPDS6a7Hy1teOlu1IJjmha0gjlkaHtS+QWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HGiN4R+HzZnOWvMJj5dKbyUGhtDrapFFgXWsB1XfGgDS5dQq9
	qaDfBxf+EM/bKr1wbCLm4OOSni1ZROErBPbyudczOkiFYzU9curnEOv/aDx2r5EwUKDM/uW7afO
	28XVvc00rnLiV+L30ydm59kSvtTc8UEGOtg90OjyEIhFEV/QYoDYevztaBuJM8vGaLiczkNo7Y0
	pcZP9hGNWqFfk8hs4dOELfyDX4fXq/NWLhRZUMSH4GLAR7reE=
X-Gm-Gg: AYBFou16OCG+umNCMvobLBYvvaywPZeIRpAdBTpvGXy+l5e/0plZLuVJ3JC0ajvDm1E
	dqbJTDOtHJ1h6/uPa1kOrwwxfZlq4sxvjXrNZQh4lfySrZJSGWafCD4UfN6gyHbW9iw+UXxgjLP
	XyyYrq5aFkALwkYVTL6PaXHZnaIRSzMsH5FIOQpygFgePvJisMXBk9feOmQ14ZQPRUpvZLe2KYW
	nrKw5EoT/96zlvKdZStBBhENxSLwGRYCS9fF8bBlLQwoeN3iQL22l8R/CDs9qUEuEwa5P8srXiG
	JI2wt6E0VeZV1ljULJd1n2igkeWS5mkkoFFI3X3Cr2/uYwMUm84blQZkPpEZjMcgMCLVoPq6bOc
	PSKYxSJ34j6I1XT42z+0Fpxff9nR37ECVHYP6wsFj8B7ldSmJZcpu07Ea91/xBUphgSg8VGdViA
	REVXy5tAViKZGRA2dkGNA6gRRD+7MgqymsmWdSmHuVT1a1RDohtfmghHlhjYgYyLAAgpysXz/tB
	1HPdu3zWfm8gRK0mefpmdXCDN7GlG635eELfOMdrnczV+kAbtd/U52fXmXFlL0jtd91a+A6lfKz
	XGIOdRulxtk2ruzJIgjHd8oMEVVULBvG/gu8nSb8eJPuMrRdJf7yzpCpwSWQVSkoFz3eSpU+UK1
	q6G1Ow+Au4ERnFBAzpLwG0NxlQfo1fMzI0iofOeuqFo5yQJUyEt1yR1mSjiLtD+sEdf0gZbSXp3
	4Z7DtObbUQCd9zZ7rjToR/rBo1pMMe2PbSsWHOhX800UBVDlcWTpk9fD0Bge+pJwONQKSYhZDVP
	UL4TSIDnBcmgJIPboNNzZr1XorHr938Q0dWH8oULb6uowE=
X-Received: by 2002:a05:622a:1394:b0:536:5a1a:e5c0 with SMTP id d75a77b69052e-542b7d07747mr178298771cf.53.1793642246663;
        Mon, 02 Nov 2026 09:57:26 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498c08680dsm3590791cf.16.2026.11.02.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:57:26 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: phillip.wood123@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH 2/2] ref-filter: name the worktree of a branch being rebased or bisected
Date: Mon,  2 Nov 2026 12:57:22 -0500
Message-ID: <20261102175722.76770-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <37d53d40-66b6-46bb-a38d-0d3534ca112a@gmail.com>
References: <37d53d40-66b6-46bb-a38d-0d3534ca112a@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Those commands also reject branches that are being updated by a rebase
> via "update-ref" commands. If we're interested in checkouts we don't
> want to list those, but it means that "%(worktree)" will still give
> different results.

Yes, that difference is on purpose. I will say so in the commit message
and the documentation.

> I don't really follow this logic. At the moment neither "git
> for-each-ref", nor "git worktree list" show this - there is no way for
> a script to find out which worktree is working on a given branch. We
> can choose to add it to one or both commands.

You are right, that paragraph is wrong. No command shows it today, and
this patch adds it to %(worktreepath) only. I will rewrite it.

> If we want it to behave like prepare_checked_out_branches() we should
> use that function, rather than copying some of it to a separate file.

Agreed. For v4 I have added a small function to branch.c,

    const char *branch_checked_out_worktree(const char *refname);

which reads the list that prepare_checked_out_branches() builds and
skips the BRANCH_CHECKOUT_KIND_UPDATE_REF entries. ref-filter calls it
and drops its own hashmap, so the patch now removes more code than it
adds in ref-filter.c. t6302, t3203, t3200, t2400 and t2403 pass with it.

> That sounds a bit confusing - "* (no branch, rebasing topic)" already
> tells us what we need to know, why do we need "+ topic" as well?

I agree. In v4 "git branch" will not mark the branch with "+" in the
worktree that is rebasing or bisecting it, since the "*" line already
names it. The "also in the worktree" sentence in git-branch.adoc goes
away with that.

> It is not a new problem, but I think it would be helpful to add
> something like
>
>     As the path may contain a newline, [...]
>
>     Note that if a branch checked out in more than one worktree,
>     `%(worktreepath)` will only show one of those worktrees.

Thanks, I will add that as a separate documentation patch before this
one.

>> +		if (wt->is_bare)
>> +			continue;
>
> This is a change in behavior. We currently print the git_dir of bare
> worktrees. I think you can argue that this change is a bug fix as the
> user asked for the worktree path, but it should be explained in the
> commit message.

Agreed. With a bare repository and a linked worktree, today "git
branch" in the linked worktree shows "+ main" for the bare
repository's HEAD, and %(worktreepath) gives the path of the bare
repository. main is not checked out anywhere, and "git worktree add"
already lets you check it out. I will explain that in the commit
message and add a test for it.

Thanks,
Jasper
