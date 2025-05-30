Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B02C18A
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612229; cv=none; b=IbQrapiSJVkBkCLfnNCTh3MrvGUlhTgruDC79L5i4q9Xx/4TrgBWhhYrvhznrJ/pg0gfK2GMCiK6h5L77DweEP/EnsC6q54fBDll0MeCN5xzx8vCm8gm6Sku572QkgHQtxVonINrNyZbEu1oqBcjoOAjENNWXvMhJ6uNQxvQK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612229; c=relaxed/simple;
	bh=8CoZCS9Z3nR9fnMHmuzP4APUoq5pNNqkFdkCB9sPRHM=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To:Cc; b=uwPXlR39xjz9uL3vXDo0joL+tk7Cij2IrzhOUqFPvTK4D7MSBM6+CGzEw8IBXKHNfqM9cG+BzOB6qS1lVWBxmrKdBsUthORi1t2xeWjlctoBFtUG+7Ddffe0EJrRG/KKzWqTY49Job1xN9aqHZU3aa14sf/L11Br88YCeTzooSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9pzvYgW; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9pzvYgW"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fa6c54cdb2so1524769b6e.3
        for <git@vger.kernel.org>; Fri, 30 May 2025 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748612227; x=1749217027; darn=vger.kernel.org;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Q753k2YmC3LD2gGE4rq3sBOaLRFryUXAxpQF5KNRuY=;
        b=M9pzvYgWbPEMhEpCQSIR1HYgbDHkWR4Uf/tFIX+BuABGgBTeqT9mpsYT1pIsg6X0AB
         kuHSe31yL6FWF/N8gBmGciLRc9zNL/KcySpEfffYTBQ8V6tPX0Ku0NvA8uz4ifpKdrSq
         A768G8s6UABNLr6itSl/kTh/tOieP0jtWGW8bP+9ZJtYgLzzpbU+CPaa24ooV+ViP0qD
         dLF+m/337G4tT7udyYlbuewnQOc5O5QQhsSLH0BeHz9k0RQIhei5Rl5FRjbdfIw8iCyA
         5g6XZ/O6Kg8Cj1dN8MqX77ate0sGuPepKkbAnBseZyiQI7/b/DcCg4WdbquZRg+pUknu
         PaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612227; x=1749217027;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Q753k2YmC3LD2gGE4rq3sBOaLRFryUXAxpQF5KNRuY=;
        b=VlnVv8A8wIibXJlpaTLI3X9BBYwRMag/6Yf2CTE/RZp5IVXxhqMzbvBHiRjwpiefMB
         z52bGhOA3x7BWIgwlfwJbHqmy0BSTc5Fx2ACiiHjSdJtlLR8qpZkXeTYLYFHENZAJFSa
         RbuAIfOymnMLwXC0Tibmr3KAClCsPjTLJSH02toc4jbrazrjX0NEhJe/8S0s0xJnVjXI
         pY/jiR2yGOWL+zSoXOfiqwsMBEZy/xuMWaBH5uMtLFgFHdvubNIya6PyJ5QisZMutfhd
         jtSCL909zYW0zqdE3ZqwYmASpba+D31QfHMNURfD+0YpQtqO5hiTcDjcT2Epa1EI0DcR
         cKiA==
X-Gm-Message-State: AOJu0YyqhwpALxNWDW0qOUixIsGl0+VqrF69edMSBhnwiUU4BthYEoQp
	HBe92nExhaSjv/dORb8u14HtJAwnjBUeK68EzM9NxnIlfVDOMSBeM4SpsG4/uQ==
X-Gm-Gg: ASbGncueqAdJNr294na6de3G84gyP4w/GjjfIJT1N2Lthvp0tynoBx8RUMl29o1nfg2
	WhAHxlbFVjgxmSyEB/zjEZjcH9DXZZW45FCa6qRwgi8FUArC4eT1uac1jdig7rrHSCDYU71qoEs
	gRvQ/4Ek8hhpZurXYS6m3siQ+YMWuHyCy4gVu6Dbu9bW4jg+730P2HnaHis0jrCzKPl/OeRNEt7
	BIZbq4vchiRY8NUnOsWbTeWvFkaJRAjsi980KM/0dGSDo0LSTmaPaWPpMUdfGvkRsyMIqv2SnF2
	EMBeD4mjYITdQzG5dMRXH71LweHyjJAQtl8eyFstNDi0MtGNtShUKeP6ijExf610K8Ivpm28OJl
	F/hmaEocWbgLhG40=
X-Google-Smtp-Source: AGHT+IG9o603P4MtsyMc6VhNeCfoGk3egmCOAVD4p9GsZvJuiXtl67oWa+1jJ1sGSLRiiQVRDvM5Qw==
X-Received: by 2002:a05:620a:2682:b0:7d0:9a88:6e82 with SMTP id af79cd13be357-7d0a1fb04bcmr519818985a.10.1748612215498;
        Fri, 30 May 2025 06:36:55 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b104:32c0:b484:4436:c503:cced])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e35e4sm231384985a.15.2025.05.30.06.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 06:36:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 11/11] builtin/maintenance: fix locking race when handling "gc" task
Message-Id: <819EFBF4-C435-4213-91C7-BF15B49B1B09@gmail.com>
Date: Fri, 30 May 2025 08:55:49 -0400
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>
X-Mailer: iPhone Mail (21F90)

=EF=BB=BF

> Le 27 mai 2025 =C3=A0 11:29, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFThe "gc" task has a similar locking race as the one that we have f=
ixed
> for the "pack-refs" and "reflog-expire" tasks in preceding commits. Fix
> this by splitting up the logic of the "gc" task:
>=20
> - Before detaching we execute `gc_before_repack()`, which contains the
>   logic that git-gc(1) itself would execute before detaching.
>=20
> - After detaching we spawn git-gc(1), but with a new hidden flag that
>   suppresses calling `gc_before_repack()`.
>=20
> Like this we have roughly the same logic as git-gc(1) itself and know to
> repack refs and reflogs before detaching, thus fixing the race.
>=20
> Note that `gc_before_repack()` is renamed to `gc_before_detach()` to
> better reflect what this function does.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> builtin/gc.c           | 39 ++++++++++++++++++++++++++-------------
> t/t7900-maintenance.sh | 12 ++++++------
> 2 files changed, 32 insertions(+), 19 deletions(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 174357b9c25..2cf61efcee9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -816,7 +816,7 @@ static int report_last_gc_error(void)
>   return ret;
> }
>=20
> -static int gc_before_repack(struct maintenance_run_opts *opts,
> +static int gc_before_detach(struct maintenance_run_opts *opts,
>               struct gc_config *cfg)
> {
>   if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
> @@ -837,6 +837,7 @@ int cmd_gc(int argc,
>   pid_t pid;
>   int daemonized =3D 0;
>   int keep_largest_pack =3D -1;
> +    int skip_maintenance_before_detach =3D 0;
>   timestamp_t dummy;
>   struct maintenance_run_opts opts =3D MAINTENANCE_RUN_OPTS_INIT;
>   struct gc_config cfg =3D GC_CONFIG_INIT;
> @@ -869,6 +870,8 @@ int cmd_gc(int argc,
>            N_("repack all other packs except the largest pack")),
>       OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
>              N_("pack prefix to store a pack containing pruned objects")),=

> +        OPT_HIDDEN_BOOL(0, "skip-maintenance-before-detach", &skip_mainte=
nance_before_detach,
> +               N_("skip maintenance steps typically done before detaching=
")),
>       OPT_END()
>   };
>=20
> @@ -952,14 +955,16 @@ int cmd_gc(int argc,
>           goto out;
>       }
>=20
> -        if (lock_repo_for_gc(force, &pid)) {
> -            ret =3D 0;
> -            goto out;
> -        }
> +        if (!skip_maintenance_before_detach) {
> +            if (lock_repo_for_gc(force, &pid)) {
> +                ret =3D 0;
> +                goto out;
> +            }
>=20
> -        if (gc_before_repack(&opts, &cfg) < 0)
> -            exit(127);
> -        delete_tempfile(&pidfile);
> +            if (gc_before_detach(&opts, &cfg) < 0)
> +                exit(127);
> +            delete_tempfile(&pidfile);
> +        }
>=20
>       /*
>        * failure to daemonize is ok, we'll continue
> @@ -988,8 +993,8 @@ int cmd_gc(int argc,
>       free(path);
>   }
>=20
> -    if (opts.detach <=3D 0)
> -        gc_before_repack(&opts, &cfg);
> +    if (opts.detach <=3D 0 && !skip_maintenance_before_detach)
> +        gc_before_detach(&opts, &cfg);
>=20
>   if (!repository_format_precious_objects) {
>       struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
> @@ -1225,8 +1230,14 @@ static int maintenance_task_prefetch(struct mainten=
ance_run_opts *opts,
>   return 0;
> }
>=20
> -static int maintenance_task_gc(struct maintenance_run_opts *opts,
> -                   struct gc_config *cfg UNUSED)
> +static int maintenance_task_gc_before_detach(struct maintenance_run_opts *=
opts,
> +                         struct gc_config *cfg)
> +{
> +    return gc_before_detach(opts, cfg);
> +}
> +
> +static int maintenance_task_gc_after_detach(struct maintenance_run_opts *=
opts,
> +                        struct gc_config *cfg UNUSED)
> {
>   struct child_process child =3D CHILD_PROCESS_INIT;
>=20
> @@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_ru=
n_opts *opts,
>   else
>       strvec_push(&child.args, "--no-quiet");
>   strvec_push(&child.args, "--no-detach");
> +    strvec_push(&child.args, "--skip-maintenance-before-detach");

I suspect this would be more obvious to me if I had the manual available rig=
ht now, but if we are not detaching (=C2=AB --no-detach =C2=BB) why do we ne=
ed to skip something before detaching (that presumably won=E2=80=99t happen)=
?

>=20
>   return run_command(&child);
> }
> @@ -1561,7 +1573,8 @@ static const struct maintenance_task tasks[] =3D {
>   },
>   [TASK_GC] =3D {
>       .name =3D "gc",
> -        .after_detach =3D maintenance_task_gc,
> +        .before_detach =3D maintenance_task_gc_before_detach,
> +        .after_detach =3D maintenance_task_gc_after_detach,
>       .auto_condition =3D need_to_gc,
>   },
>   [TASK_COMMIT_GRAPH] =3D {
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 1ada5246606..e09a36ab021 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -49,9 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
>       git maintenance run --auto 2>/dev/null &&
>   GIT_TRACE2_EVENT=3D"$(pwd)/run-no-quiet.txt" \
>       git maintenance run --no-quiet 2>/dev/null &&
> -    test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
> -    test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
> -    test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
> +    test_subcommand git gc --quiet --no-detach --skip-maintenance-before-=
detach <run-no-auto.txt &&
> +    test_subcommand ! git gc --auto --quiet --no-detach --skip-maintenanc=
e-before-detach <run-auto.txt &&
> +    test_subcommand git gc --no-quiet --no-detach --skip-maintenance-befo=
re-detach <run-no-quiet.txt
> '
>=20
> test_expect_success 'maintenance.auto config option' '
> @@ -154,9 +154,9 @@ test_expect_success 'run --task=3D<task>' '
>       git maintenance run --task=3Dcommit-graph 2>/dev/null &&
>   GIT_TRACE2_EVENT=3D"$(pwd)/run-both.txt" \
>       git maintenance run --task=3Dcommit-graph --task=3Dgc 2>/dev/null &&=

> -    test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&=

> -    test_subcommand git gc --quiet --no-detach <run-gc.txt &&
> -    test_subcommand git gc --quiet --no-detach <run-both.txt &&
> +    test_subcommand ! git gc --quiet --no-detach --skip-maintenance-befor=
e-detach <run-commit-graph.txt &&
> +    test_subcommand git gc --quiet --no-detach --skip-maintenance-before-=
detach <run-gc.txt &&
> +    test_subcommand git gc --quiet --no-detach --skip-maintenance-before-=
detach <run-both.txt &&
>   test_subcommand git commit-graph write --split --reachable --no-progress=
 <run-commit-graph.txt &&
>   test_subcommand ! git commit-graph write --split --reachable --no-progre=
ss <run-gc.txt &&
>   test_subcommand git commit-graph write --split --reachable --no-progress=
 <run-both.txt
>=20
> --
> 2.49.0.1266.g31b7d2e469.dirty
