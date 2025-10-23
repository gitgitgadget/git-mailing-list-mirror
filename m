Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437831991D2
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256180; cv=none; b=NL/jifI7hoYHVFqGAVTfirfGP/qcSixqqwQKq+LVQ+jGFFLkr+RzqbsOk9VJMgRNgxro01UUcXcMv0dCuua7BfATCI9F6JSZ8F+AekEZDxh20/vMS1WvZsskjtMiqjwrTcBIjeWq5Fgupmd9h89FQfV07cXu9Ccyd0xvwQPF6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256180; c=relaxed/simple;
	bh=4te6uehYnIyBoJbWYPJ0XvTARZOGUGnvWbzgZ57OFRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Bx7VfR6uFaEBFAo0Jf3eqtGG8VXTpEw32q4voCnh2sPBcM6pgT5PI/7bWseXl0spJ9bZd11N9SzGiB613qZRJlmiRH3WC3yofxsajExFHPKyA+7Iet/Q5441jzN9gG5/Pm27AcdQnqKfJ4AA7XeAvDzhDJPbc3baa0ddiDqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IFfGj1CP; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IFfGj1CP"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430aeaffeaeso6169525ab.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761256177; x=1761860977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9TC3MUzy81fa0gXxq1nyQFzaMzBIUihpwkG5vbJ1Kg=;
        b=IFfGj1CPwbekpdXf+/PLACLiVnzuhQpoZSgc8xTMlVVq+lu3WFOhIHuWi/0LwLCvXU
         QXjo4Wn/jbrZYCkxqnjXYueQSFs+kYhSu9blOY1gGnTb/NxTCo0tHyS3Bl4Fv5PiokCj
         K7n4ND9R9fLgCxQWyGwi9W7RhSkIAYwcy+eOw5r6p7TMDlI39ZiVpklNoTxB0jF5PFa8
         NcSPetyGRsr20z64MA4PIn69KUQ5ZK5qb7kfSlc2UoDgVnisPmqjCjPqJaBsc+GDOZJl
         O4HZhdYccOexrEMZMg9Bs2HPb8dnSpe7+y5Nvis2ZQWL54QSFFyaK6MChNqVC3DnWe+a
         SMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761256177; x=1761860977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9TC3MUzy81fa0gXxq1nyQFzaMzBIUihpwkG5vbJ1Kg=;
        b=ZP+WnzkUdSCWOsgJE3DzLWn2Rbt3a4COnnOCcHyvUSxaMO1wBuhN0XpHA/mLjw3yD3
         YfdhuiSynlX+wOwWl3njbJ8BKdqNmei66Ul/Pc6dRojGc39il/VEtGOgEoUELXoCNEFl
         pdunpEgaJFcrOXTUG+EdUWE0yEnjfFdWDNvpdIIIR9JapBC/gxaxxC//U39NogsciJdN
         rfV8JJFL+bFndM9TGY+y2LchGG+PBfLIR5pueEKYyRWFGAilNvW1RX/nOCFSvTBftOEz
         7XD11GC6KP2kF7h6HB/CYUhz/iXRSLxBX2Lqann9xsXAUnXvwPPHD8ovZDASVoZEnavM
         Sfcw==
X-Gm-Message-State: AOJu0YwyEHqpKe9GX5C981qBDw9wEULfWsipky+T8E+c1Q5ut6nINhPz
	zqwMHNkW7HphfqH+oMDMDEEeHlIHruECQZnTmVl766Dq8+MRx1tRlCrzcGMd4HJPdsFElXxZolU
	c2jcbFfSDgw==
X-Gm-Gg: ASbGnctgKFFzGz0OTI3nRDl3xr98aZzxCDORj7NVkeK1kZ/iCUBb0bsLqAVRGPxnjap
	sdbUteH/H/Fx13Mz5bGy7QorTvRwv33V0Y4nluWgoHuyt5Z6eWo0SKAY/C35eY76kUdM2cvduML
	mjeqIDNz1pGOmgjWtk+a1Yzm+srfhHt/MjT5+y7Umw2E7SZyTdkttuGrQEd8aWedCSDa+/mzs87
	awGda61WQ2oQrwes0Y6X1t81P340X/QadrbW+hlc5ACIJRmUyaTTQo9pfyrkDiiUhGRKQDVIZl8
	kguJBl7jWMw2IHfc42tTq6xVBmztEpxyVBPunyA0YcqDTeS8Q9Oc7VfcnC0NDyeqv/nsqaS0LlU
	5l0LRLaS2po9KHdrU8sb1WJox+bGku+1ghtmEifPxDSd+g58B/EuUN27s4CQjVOb5x/v0bt/2IC
	yMNd/JBsr9wK/26QYKf5e/LzHlUmFdsHRVXi1nlXjBa6yNYThX9XKSpqI4lwEn0zvyIbUCeZyz8
	o2bS4o=
X-Google-Smtp-Source: AGHT+IFdRZDYrE7b/YS236zztYCTaZiz+0QdWG4cBmc7trW8IX1NQeTWYKco//qb4dKe5KmbVBErUA==
X-Received: by 2002:a92:c26c:0:b0:431:d864:3658 with SMTP id e9e14a558f8ab-431d864382dmr69909095ab.20.1761256177094;
        Thu, 23 Oct 2025 14:49:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5abb8fb2a59sm1360264173.64.2025.10.23.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:49:36 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:49:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 9/9] builtin/maintenance: introduce "geometric"
 strategy
Message-ID: <aPqi71+zRE2KsnCk@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-9-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-9-f0d727832b80@pks.im>

On Tue, Oct 21, 2025 at 04:13:31PM +0200, Patrick Steinhardt wrote:
> We have two different repacking strategies in Git:
>
>   - The "gc" strategy uses git-gc(1).
>
>   - The "incremental" strategy uses multi-pack indices and `git
>     multi-pack-index repack` to merge together smaller packfiles as
>     determined by a specific batch size.
>
> The former strategy is our old and trusted default, whereas the latter
> has historically been used for our scheduled maintenance. But both
> strategies have their shortcomings:
>
>   - The "gc" strategy performs regular all-into-one repacks. Furthermore
>     it is rather inflexible, as it is not easily possible for a user to
>     enable or disable specific subtasks.
>
>   - The "incremental" strategy is not a full replacement for the "gc"
>     strategy as it doesn't know to prune stale data.
>
> So today, we don't have a strategy that is well-suited for large repos
> while being a full replacement for the "gc" strategy.

Well put.

> Introduce a new "geometric" strategy that aims to fill this gap. This
> strategy invokes all the usual cleanup tasks that git-gc(1) does like
> pruning reflogs and rerere caches as well as stale worktrees. But where
> it differs from both the "gc" and "incremental" strategy is that it uses
> our geometric repacking infrastructure exposed by git-repack(1) to
> repack packfiles. The advantage of geometric repacking is that we only
> need to perform an all-into-one repack when the object count in a repo
> has grown significantly.
>
> One downside of this strategy is that pruning of unreferenced objects is
> not going to happen regularly anymore. Every geometric repack knows to
> soak up all loose objects regardless of their reachability, and merging
> two or more packs doesn't consider reachability, either. Consequently,
> the number of unreachable objects will grow over time.
>
> This is remedied by doing an all-into-one repack instead of a geometric
> repack whenever we determine that the geometric repack would end up
> merging all packfiles anyway. This all-into-one repack then performs our
> usual reachability checks and writes unreachable objects into a cruft
> pack. As cruft packs won't ever be merged during geometric repacks we
> can thus phase out these objects over time.
>
> Of course, this still means that we retain unreachable objects for far
> longer than with the "gc" strategy. But the maintenance strategy is
> intended especially for large repositories, where the basic assumption
> is that the set of unreachable objects will be significantly dwarfed by
> the number of reachable objects.
>
> If this assumption is ever proven to be too disadvantageous we could for
> example introduce a time-based strategy: if the largest packfile has not
> been touched for longer than $T, we perform an all-into-one repack. But
> for now, such a mechanism is deferred into the future as it is not clear
> yet whether it is needed in the first place.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/maintenance.adoc |  9 +++++++++
>  builtin/gc.c                          | 19 +++++++++++++++++++
>  t/t7900-maintenance.sh                | 20 +++++++++++++++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> index b2bacdc822..d0c38f03fa 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -32,6 +32,15 @@ The possible strategies are:
>    strategy for scheduled maintenance.
>  * `gc`: This strategy runs the `gc` task. This is the default strategy for
>    manual maintenance.
> +* `geometric`: This strategy performs geometric repacking of packfiles and
> +  keeps auxiliary data structures up-to-date. The strategy expires data in the
> +  reflog and removes worktrees that cannot be located anymore. When the
> +  geometric repacking strategy would decide to do an all-into-one repack, then
> +  the strategy generates a cruft pack for all unreachable objects. Objects that
> +  are already part of a cruft pack will be expired.
> ++
> +This repacking strategy is a full replacement for the `gc` strategy and is
> +recommended for large repositories.

Nice. I always feel like it's tricky for changes like these to know
where the right place is to draw the line between "this belongs in the
commit message, because it will be useful to reviewers in understanding
how I came to this patch" versus "this belongs in the documentation for
my new feature, because it will be useful to users trying to figure out
what option to use".

I like the spot where you drew that line here and I think that the
patch message has details that are useful to reviewers (like the
historical differences between all-into-one strategies and geometric
repacking), but that the documentation has the right user-facing details
and explanations.


> diff --git a/builtin/gc.c b/builtin/gc.c
> index aaff0bae15..9739bb0ea2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1878,12 +1878,31 @@ static const struct maintenance_strategy incremental_strategy = {
>  	},
>  };
>
> +static const struct maintenance_strategy geometric_strategy = {
> +	.tasks = {
> +		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
> +		[TASK_GEOMETRIC_REPACK].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_GEOMETRIC_REPACK].schedule = SCHEDULE_DAILY,
> +		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_PACK_REFS].schedule = SCHEDULE_DAILY,
> +		[TASK_RERERE_GC].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_RERERE_GC].schedule = SCHEDULE_WEEKLY,
> +		[TASK_REFLOG_EXPIRE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_REFLOG_EXPIRE].schedule = SCHEDULE_WEEKLY,
> +		[TASK_WORKTREE_PRUNE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
> +		[TASK_WORKTREE_PRUNE].schedule = SCHEDULE_WEEKLY,
> +	},
> +};
> +

What you wrote here all makes sense to me, so I don't have any comments
on the technical content of 'geometric_strategy'.

As an aside, I wonder if we should use a nested designated initializer
here? It seems a little cleaner to me than doing:

    .tasks = {
        [TASK_FOO].type = ...,
        [TASK_FOO].schedule = ...,
    }

It's inconsistent with the style of the rest of this file, so if you did
make this change I'd suggest adding a prerequisite change that modifies
existing strategies to match the new style. But you could imagine
something like the following on top:

--- 8< ---
diff --git a/builtin/gc.c b/builtin/gc.c
index 9739bb0ea2..881ef6ad88 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1880,18 +1880,30 @@ static const struct maintenance_strategy incremental_strategy = {

 static const struct maintenance_strategy geometric_strategy = {
 	.tasks = {
-		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
-		[TASK_GEOMETRIC_REPACK].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_GEOMETRIC_REPACK].schedule = SCHEDULE_DAILY,
-		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_PACK_REFS].schedule = SCHEDULE_DAILY,
-		[TASK_RERERE_GC].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_RERERE_GC].schedule = SCHEDULE_WEEKLY,
-		[TASK_REFLOG_EXPIRE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_REFLOG_EXPIRE].schedule = SCHEDULE_WEEKLY,
-		[TASK_WORKTREE_PRUNE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
-		[TASK_WORKTREE_PRUNE].schedule = SCHEDULE_WEEKLY,
+		[TASK_COMMIT_GRAPH] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_GEOMETRIC_REPACK] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_PACK_REFS] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_RERERE_GC] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
+		[TASK_REFLOG_EXPIRE] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
+		[TASK_WORKTREE_PRUNE] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
 	},
 };

--- >8 ---

The rest all looks good to me.

Thanks,
Taylor
