Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049B1F4612
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435567; cv=none; b=U07T6vH68mKhye532sznmG7vN0bIy+6LrzKvdzaKx1HN4tlNK/znbmaLA8XKymcYE81OIiY1PVJM8NG6xWdTlN2qd3gPnAiebdNl7bQXmOQmjSFirDlIbJgL2wlrL3GuYDW4oECb22y67q0AnY9tTGbUsQBksVEC84kgM8xzGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435567; c=relaxed/simple;
	bh=B2zqIZ43FnjzCVH3c5jMdnFKFJRFQCwq5OL8xMfBBRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1+uMdA8CgzlhMYt0UWAJl8R9Woab+wkm18gpvGfZCQeB6u/U6zhrBzwyEAPy11LoVS+pYUccCGgUvetzGcP8wI9N9LwWhXuNIT5xjpnbyinwNMZ+kfaWXH3+ADLFLrXTJFw0x5HUiD13RQdGENhM7jYV4TQRmFUdodNkMgiy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so4837886d6.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435565; x=1747040365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ9dqKFtGpfdkUHEg/x3dKYWWBvPDtsy2tgYRTTSeqA=;
        b=m3Ln9S3j5AMo4JT7hujEGtlvM0rW41rN0vGUNwCEMBR8kJT7XBo4/KkELcK2OOJrM/
         XqSNTTwOxmvYy0rfrkNqzvc5qlgbaY4JY3x82NUwms2JNzArsWBrm6Wo7SkFFrGh60XM
         9r/Ej6To6QxH7UkR6XuO6qbn2U1G6T2kxT909mvo2C/Oqw0fP0mLV6v2hK9XaEF6f1e7
         3QN9tVVRgpw6cqjQWtEjZ+8xfYzGXBU50Hx3PfYhL1Y1O1farh4jWbuJAApBXgrIZ1LO
         tWmCWptedXc8nTGKdm3IGgSxoMHzj3FdF4GjAwn3Fn1UGymE42PtV0DjtcpYE6B9YsJN
         9YsA==
X-Gm-Message-State: AOJu0Yykg4+wxyqzxnjqRokFLBLnrn0PzD+DI59mTOm5gtEShRtwuVKr
	N2hIEVHp+gC3BFESUVpe9aTi8D+9HSGdCGMQ3viNSc3RNqK2x/CTvo+Mf4mqmyz4bUV1Lv4BUBq
	eJIo51E7dtQlZmh6prCqmtTnN2a8=
X-Gm-Gg: ASbGncsj/kZdzmzNIq62bLmOmU54UXcIl8IazB4BbdPcTXciqXp8+b5hXkGUax0RnZu
	dlspezN0m5OqUFGQO3YgULC0t8rPlTV4fIskCM1M+7V1B8POR7cRrdu9ObNQ5Xz2/8EKDKEZGvB
	omTh5yhy9+1aZB9Fvh1KwJi+F4UigqRxGZJM/4tuzj+tXrktzNcrw1iH0=
X-Google-Smtp-Source: AGHT+IHWvwZLb+PW5D1Y6A91e2UW0AbCCcIyinVJEcDmut7FCHa3cQNdkrycXI25+hb5pO8C6+P/5ySLOymjXMPaFqQ=
X-Received: by 2002:a05:6214:21ed:b0:6e8:c713:3222 with SMTP id
 6a1803df08f44-6f515657098mr61567596d6.11.1746435564861; Mon, 05 May 2025
 01:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im> <20250502-pks-maintenance-missing-tasks-v3-5-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-5-13e130d36640@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 May 2025 04:59:14 -0400
X-Gm-Features: ATxdqUG3AkG3GyoRbBMkBMDZSQtT3TWLq4UlLsVvdJUFzD_U3cQxcCoOb3mCRhM
Message-ID: <CAPig+cScor=E2i4w99NCrsaUd-Po=FqhkrLSyT69PSo1+h2dRw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] builtin/maintenance: introduce "worktree-prune" task
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:44=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
> not yet have a task for this cleanup. Introduce a new "worktree-prune"
> task to plug this gap.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -346,6 +347,45 @@ static int maintenance_task_worktree_prune(struct ma=
intenance_run_opts *opts UNU
> +static int worktree_prune_condition(struct gc_config *cfg)
> +{
> + [...]
> +       git_config_get_int("maintenance.worktree-prune.auto", &limit);
> +       if (limit <=3D 0) {
> +               should_prune =3D limit < 0;
> +               goto out;
> +       }
> +
> +       if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) =
||
> +           get_worktree_names(the_repository, &worktrees) < 0)
> +               goto out;
> +
> +       for (size_t i =3D 0; i < worktrees.nr; i++) {
> +               char *wtpath;
> +               strbuf_reset(&reason);
> +               if (should_prune_worktree(worktrees.v[i], &reason, &wtpat=
h, expiry_date)) {

As I was reading the commit message, I had concerns that if this
implementation was rolling its own pruning logic, it might overlook
conditions such as a worktree being locked, so I'm glad to see that
you're using should_prune_worktree() here rather than reinventing the
wheel.

> +                       limit--;
> +
> +                       if (!limit) {
> +                               should_prune =3D 1;
> +                               goto out;
> +                       }
> +               }
> +               free(wtpath);

This leaks `wtpath` when it takes the `goto out` arm.

> +       }
> +
> +out:
> +       strvec_clear(&worktrees);
> +       strbuf_release(&reason);
> +       return should_prune;
> +}
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -493,6 +493,77 @@ test_expect_success 'reflog-expire task --auto only =
packs when exceeding limits'
> +test_expect_success 'worktree-prune task with --auto honors maintenance.=
worktree-prune.auto' '
> +       # A negative value should always prune.
> +       test_expect_worktree_prune git -c maintenance.worktree-prune.auto=
=3D-1 maintenance run --auto --task=3Dworktree-prune &&
> +
> +       mkdir .git/worktrees &&
> +       : >.git/worktrees/first &&
> +       : >.git/worktrees/second &&
> +       : >.git/worktrees/third &&
> +
> +       # Zero should never prune.
> +       test_expect_worktree_prune ! git -c maintenance.worktree-prune.au=
to=3D0 maintenance run --auto --task=3Dworktree-prune &&
> +       # A positive value should require at least this man prunable work=
trees.

s/man/many/
