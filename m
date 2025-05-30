Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2081D47B4
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612217; cv=none; b=tgjPq0w17wH8ChJNe7YV3WTGMul1zkFailyfBmz6hrQj8GMA2pBKiJBoKZUHQckPoLbALNnnNy1NMFTJvHb2eMOrdQkPQa37KL44cb3IOqV7Rm60Q/m5mF74ha0NzR+ZkRlWMzJ8PxoniN/VH+h4n5QGOJB7vH+uMu9EeInnN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612217; c=relaxed/simple;
	bh=ICwrzSN4vYBFba20qS8oAPglbfx2HzOJyQJveKtLWRA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To:Cc; b=eQBcCOnRyM24u8uRCQDQlio7UXZmL8gr2g0zKMovygF4/lpAhIRWYjPe66zCaYeJfpQ5eH/FoLApPTsNIMVK9NfP3bBXpqIhKYVPHEAzq7qM5FFFKE5pxlg5RLL4tfcpXyKn8o3rqjl8xQgRNFHtU1YWITSh0szNPR7W0vFMTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfmviNRm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfmviNRm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d0976776dcso191871785a.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748612213; x=1749217013; darn=vger.kernel.org;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4mYwEifhEiswfU5TcQl0f2sn5pNDKtHEhKZs77TU3Y=;
        b=HfmviNRmYvtWWRdLHnLGUrKNc0vEqIOCB9uiLRK+V0K+E/ykaRvOxezjIrf52XMEai
         TTE/b/W8MS7zroGEoIsaQqXwG0gj9aw6SaEtr/KJfLRmHbmxF+jIqjQSMnQiJO18NRXv
         YYFcJq6VaKyzQS7lXaMfZQhgnCGZn1nIsmrSmy5WQI0iBsFGWo3375ARBq+BPwFS9wUc
         1V8A3f5cu0yDAd6rnfUBzEuTFrD8ha1yy34JMGg8Dn3gyFo3GmZoAufLDcHdoiCRcd09
         6ztgBBp3AHr4c8DyAWvLsWN9u5gC8xG/4nIDdE0Fvf9DnLdjRcCPzKP3/821DBOSZClv
         2l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612213; x=1749217013;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m4mYwEifhEiswfU5TcQl0f2sn5pNDKtHEhKZs77TU3Y=;
        b=L9HtAuLCn4cSX5/P2Q2rIUNlmy+xYBv2uGRzQ2sonKhKdJ9OVvtMGA4GV/mEg5DMgA
         g0MI/ShzDnQOI8f5VjNEuI/HFO+gnRE3EsKleZ1Ox2lykpNmLP4LNM6yyyoEkaA0vrNb
         DQDc2RDpb3njzXLWIufShalhgH5FAQc2wOQSWhqe4IyxjoY+UuP9NbxdZSkYFigD6rvB
         PfZrGY7Irpg1yGA6Co7rwV5PDP7bODK6gR6AvuSKiZ1K7/ow50osBS1vjxLHWjQ9GPuY
         1ysBaqEJIrqRBpr3cnC2SA58e0ZQToW6LW30Umlw5J9bx4nyd1eY8tqHKhAZy0cLSKth
         5vbg==
X-Gm-Message-State: AOJu0YxalJXZ8sqtdEGjqBmYUgGx7bd3yTEHjqs9+426Fsh01BtDFSCP
	d11zeqo0uUFg+OaZEiB7BwNvlvmA+detmv1XpmatiAKcgU7hB/0fIzsI
X-Gm-Gg: ASbGnctNkihDPRPon8ubnefhmqAnoVTIX/fEduAEnvUW6c9LFaCbX+PPCG2Dh2ogcvk
	lbgYNUZutSLHpRN4pRYbmCr6Ky1S4m17zEU/CiifS7gklzz+IXApZ/F/Ylt+dvntmZJK3RIfiAV
	HcacXCoAGAV3cClzQhX/RCVI3EQlO7jkzFJxuavWdca272RTLvFhtDYE4cKye4YPnTtPKPpTsJa
	bX7IMWZozMwbMxMqxIFzXesY6v45hoAD3ybAFGo410SnDV1vTbM1H+L8k3KdAI9hhT5D5KuCvDx
	qI8BxGfOv6WCgddNb9NqiQYNIUf2+ANTRYKbyiV6POAbmxqaMCRrVCPFvsgbyvvcO4Yaccti/7H
	Ihm/D
X-Google-Smtp-Source: AGHT+IEl3zEkvq8M+8HjSL7kCe9ZkYazIUUTTwooE0IQVsOzbrW3X4JYJMlR2SSQ1MD9rkOUJUgaPQ==
X-Received: by 2002:a05:620a:2791:b0:7d0:97d6:e94b with SMTP id af79cd13be357-7d0a1fb07a2mr521666685a.31.1748612213055;
        Fri, 30 May 2025 06:36:53 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b104:32c0:b484:4436:c503:cced])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1a70fasm228839685a.95.2025.05.30.06.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 06:36:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 08/11] builtin/maintenance: let tasks do maintenance before and after detach
Message-Id: <6E33013D-8336-4BE1-9DBB-CAFF835A49C3@gmail.com>
Date: Fri, 30 May 2025 08:56:38 -0400
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>
X-Mailer: iPhone Mail (21F90)

=EF=BB=BF
> Le 27 mai 2025 =C3=A0 10:05, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFBoth git-gc(1) and git-maintenance(1) have logic to daemonize so t=
hat
> the maintenance tasks are performed in the background. git-gc(1) has
> some special logic though to not perform _all_ housekeeping tasks in the
> background: both references and reflogs are still handled synchronously
> ni the foreground.
>=20
> This split exists because otherwise it may easily happen that git-gc(1)
> keeps for the "packed-refs" file locked for an extended amount of time,
> where the next Git command that wants to modify any reference could now
> fail. This was especially important in the past, where git-gc(1) was
> still executed directly as part of our automatic maintenance: git-gc(1)
> was invoked via `git gc --auto --detach`, so we knew to handle most of
> the maintenance tasks in the background while doing those parts that may
> cause locking issues in the foreground.
>=20
> We have since moved to git-maintenance(1), which is a more flexible
> replacement for git-gc(1). By default this command runs git-gc(1), only,
> but it can be configured to run different tasks, as well. This command
> does not know about the split between maintenance tasks that should run
> before and after detach though, and this has led to several bug reports
> about spurious locking errors for the "packed-refs" file.
>=20
> Prepare for a fix by introducing this split for maintenance tasks. Note
> that this commit does not yet change any of the tasks, so there should
> not (yet) be a change in behaviour.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> builtin/gc.c | 40 +++++++++++++++++++++++++---------------
> 1 file changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 447e5800846..57f3bbf5344 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1545,53 +1545,54 @@ typedef int (*maintenance_auto_fn)(struct gc_confi=
g *cfg);
>=20
> struct maintenance_task {
>   const char *name;
> -    maintenance_task_fn fn;
> +    maintenance_task_fn before_detach;
> +    maintenance_task_fn after_detach;
>   maintenance_auto_fn auto_condition;
> };
>=20
> static const struct maintenance_task tasks[] =3D {
>   [TASK_PREFETCH] =3D {
>       .name =3D "prefetch",
> -        .fn =3D maintenance_task_prefetch,
> +        .after_detach =3D maintenance_task_prefetch,
>   },
>   [TASK_LOOSE_OBJECTS] =3D {
>       .name =3D "loose-objects",
> -        .fn =3D maintenance_task_loose_objects,
> +        .after_detach =3D maintenance_task_loose_objects,
>       .auto_condition =3D loose_object_auto_condition,
>   },
>   [TASK_INCREMENTAL_REPACK] =3D {
>       .name =3D "incremental-repack",
> -        .fn =3D maintenance_task_incremental_repack,
> +        .after_detach =3D maintenance_task_incremental_repack,
>       .auto_condition =3D incremental_repack_auto_condition,
>   },
>   [TASK_GC] =3D {
>       .name =3D "gc",
> -        .fn =3D maintenance_task_gc,
> +        .after_detach =3D maintenance_task_gc,
>       .auto_condition =3D need_to_gc,
>   },
>   [TASK_COMMIT_GRAPH] =3D {
>       .name =3D "commit-graph",
> -        .fn =3D maintenance_task_commit_graph,
> +        .after_detach =3D maintenance_task_commit_graph,
>       .auto_condition =3D should_write_commit_graph,
>   },
>   [TASK_PACK_REFS] =3D {
>       .name =3D "pack-refs",
> -        .fn =3D maintenance_task_pack_refs,
> +        .after_detach =3D maintenance_task_pack_refs,
>       .auto_condition =3D pack_refs_condition,
>   },
>   [TASK_REFLOG_EXPIRE] =3D {
>       .name =3D "reflog-expire",
> -        .fn =3D maintenance_task_reflog_expire,
> +        .after_detach =3D maintenance_task_reflog_expire,
>       .auto_condition =3D reflog_expire_condition,
>   },
>   [TASK_WORKTREE_PRUNE] =3D {
>       .name =3D "worktree-prune",
> -        .fn =3D maintenance_task_worktree_prune,
> +        .after_detach =3D maintenance_task_worktree_prune,
>       .auto_condition =3D worktree_prune_condition,
>   },
>   [TASK_RERERE_GC] =3D {
>       .name =3D "rerere-gc",
> -        .fn =3D maintenance_task_rerere_gc,
> +        .after_detach =3D maintenance_task_rerere_gc,
>       .auto_condition =3D rerere_gc_condition,
>   },
> };
> @@ -1599,20 +1600,25 @@ static const struct maintenance_task tasks[] =3D {=

> static int maybe_run_task(const struct maintenance_task *task,
>             struct repository *repo,
>             struct maintenance_run_opts *opts,
> -              struct gc_config *cfg)
> +              struct gc_config *cfg,
> +              int before)

Perhaps we can use a small enum=E2=80=A6

> {
> +    maintenance_task_fn fn =3D before ? task->before_detach : task->after=
_detach;
> +    const char *region =3D before ? "maintenance before" : "maintenance";=

>   int ret =3D 0;
>=20
> +    if (!fn)
> +        return 0;
>   if (opts->auto_flag &&
>       (!task->auto_condition || !task->auto_condition(cfg)))
>       return 0;
>=20
> -    trace2_region_enter("maintenance", task->name, repo);
> -    if (task->fn(opts, cfg)) {
> +    trace2_region_enter(region, task->name, repo);
> +    if (fn(opts, cfg)) {
>       error(_("task '%s' failed"), task->name);
>       ret =3D 1;
>   }
> -    trace2_region_leave("maintenance", task->name, repo);
> +    trace2_region_leave(region, task->name, repo);
>=20
>   return ret;
> }
> @@ -1641,6 +1647,10 @@ static int maintenance_run_tasks(struct maintenance=
_run_opts *opts,
>   }
>   free(lock_path);
>=20
> +    for (size_t i =3D 0; i < opts->tasks_nr; i++)
> +        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 1))

So that is clear what =C2=AB 1 =C2=BB (=C2=AB BEFORE =C2=BB) does here=E2=80=
=A6

> +            result =3D 1;
> +
>   /* Failure to daemonize is ok, we'll continue in foreground. */
>   if (opts->detach > 0) {
>       trace2_region_enter("maintenance", "detach", the_repository);
> @@ -1649,7 +1659,7 @@ static int maintenance_run_tasks(struct maintenance_=
run_opts *opts,
>   }
>=20
>   for (size_t i =3D 0; i < opts->tasks_nr; i++)
> -        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
> +        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 0))

And =C2=AB 0 =C2=BB (=C2=AB AFTER =C2=BB) does here?

>           result =3D 1;
>=20
>   rollback_lock_file(&lk);
>=20
> --
> 2.49.0.1266.g31b7d2e469.dirty
