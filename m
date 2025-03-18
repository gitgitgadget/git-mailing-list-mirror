Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254A14B08E
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306497; cv=none; b=J2ofZXbBjFMtgzhr3jqZDQEFuYF8PqSxukjkzLT6y54tht3khC1uUSr6A4IIuyOBk4mmTZPRMwo6s2Pm2Tw+/K9xbglhZ7w8HDOnm2Kugyzz7wT2NPG3IusCqxJ2igquSryoFTbPSE2end0FqxfdUxGbS6kG8ocAKLm4ynEHQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306497; c=relaxed/simple;
	bh=k8xGgUh+M0tddw7cZtNtDsbo+EG5z/BH5OiUkKOcqK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwJ0jnj+d0hWEgHlgSQgnXy7XloFz3KcBCfGWYjDTvt1uXDht40+gMkXXSVDDr78oBg8EOAwcOTWYuC+xZaVusP/h3r1guyeI4SR+MMcnEivQ61R09wOQCDSRKd3V1Xv/mELzrFuyT4RFeV9FMs6ukca3mGBRJ0dcpQ3r+tcxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrCVjVrd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrCVjVrd"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so9033252a12.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306490; x=1742911290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP+0jQ2p0RyHlOSbhZjVXbcai6KDTJSQwP8TtYuuuC8=;
        b=QrCVjVrdlfFAX5N63a9FgwABF4yPiaJZvlPf0FeJ7cI+vwhNtlaeGynh/xqLMVeQcg
         Rg9SsSB+xwW+nI+bzFvutA4S/8rDMf03dI0ufwy4IoA5Xmc0TLzBMmAY+ZjHm+q9gC/E
         nB9ksLXQxJgQz45Jsw5VvUTxD9EuAl2hATsAxEZD+VXzUvSXmum4Ul3xaOI3vCb8dy7A
         0/Jfm6vsLzSTypkZrHqX0JYUsN0uXRu4yTRcIVcdgTnNnO7vkkyj2KgTR1H4q9MH2yL9
         IL4wN+7LCpxPsp0Reb/6fiQbVvwE3mGghsX66pcd8yCHVa+KKgJYF+1nb6cTr+6SHCAL
         ejEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306490; x=1742911290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP+0jQ2p0RyHlOSbhZjVXbcai6KDTJSQwP8TtYuuuC8=;
        b=lItYa4kLiVK2sUWYzpSJ7Pvkz1SNaKHbllWdrkDKNdf4vuMcwLZhdy0b9MXtgTn3ev
         7SGs9E0Zc767B+p49TntWHyoUWP4D0otZ3eDC2xvNcVbYKISsL+1aX4GlPrC2Ef9RV68
         5/ZhGDeqZSkevs7jYSCv5y1BxwF0aKQxLuGrbZw/oO66JYSRd5aNQQ7Djxj+HCih9EGw
         HdI75e6cfWIwN+cO7VaNQJ3stn7LZnxGyX3TsC1fyg9U12C8yZVerQ+z68LjWa8Bi5Q1
         3NFgrCvEJUD/clc2A8qd0TuHH/IeAFsL+Zj0ChUQCHkcEbb3Alc83HVfqfmF9pF9qImW
         +Xjg==
X-Gm-Message-State: AOJu0YwSCgqohaujWDvitdFjAjOfkkgHT7nZDAGUvbGYkNzofANX8jUI
	eGAoepA6YkM0jbHnTPNZnPPKdiYLwb5qk9BVpTG7tKiwRBku9ckrnDC9KjbPh/yNfoYV493LKA6
	9hLnxYDGkUvch7bTfCg8zXSCgub8=
X-Gm-Gg: ASbGncuR0P974erfFkXGw7Nyfs1peA1EJbkZUwhpp8wmuI96yHIdgFmaRkayUI2Yx9q
	7188sQup7vpswO9YZCpREX8p5z8Mip/oE30iICHPANgj1h8lFb7bVkCyablmbwV8kX1uDprESAk
	1zwwuqJSesUHG3bXlDmI67vPXHFyeu/DtE7vGJiksvMqFGWGkmAtezDqNbw47Q
X-Google-Smtp-Source: AGHT+IGr0Qm+bFTSd8C3rjpoYKbitXRk4fwRazCcznNUlM3APq+7Os5rGgPDeJkLW4054GN/B+reeGWO1Q5N0Z8wpnc=
X-Received: by 2002:a05:6402:50c9:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e89f54cdc4mr18077437a12.13.1742306489270; Tue, 18 Mar 2025
 07:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
 <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
In-Reply-To: <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Mar 2025 15:01:16 +0100
X-Gm-Features: AQ5f1JoUbHORjTBGicVcV9eUZwU-tvXI1e1cWcSer7D73zM2iqQ3ar3M9kIQ4lc
Message-ID: <CAP8UFD2+xQQbUevHTQangg__dq2M615pHLhYYUf7b9shpShD9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 9:41=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:

> +Options for `drop`
> +~~~~~~~~~~~~~~~~~~~~
> +
> +--all::
> +       Drop the reflogs of all references from all worktrees.
> +
> +--single-worktree::
> +       By default when `--all` is specified, reflogs from all working
> +       trees are dropped. This option limits the processing to reflogs
> +       from the current working tree only.

It seems to me that "--current-worktree" would have been clearer than
"--single-worktree", but I understand that it would have been
confusing to have a different name for basically the same option in
`git reflog expire` and `git reflog drop`.

> +       argc =3D parse_options(argc, argv, prefix, options, reflog_drop_u=
sage, 0);
> +
> +       if (argc && do_all)
> +               usage(_("references specified along with --all"));
> +
> +       if (do_all) {
> +               struct worktree_reflogs collected =3D {
> +                       .reflogs =3D STRING_LIST_INIT_DUP,
> +               };
> +               struct string_list_item *item;
> +               struct worktree **worktrees, **p;
> +
> +               worktrees =3D get_worktrees();
> +               for (p =3D worktrees; *p; p++) {
> +                       if (single_worktree && !(*p)->is_current)

It looks like 'single_worktree' is only used here. This means that if
a user forgets to add --all and only uses --single-worktree, nothing
will happen and it seems to me that the command will exit with code 0.
Even if `git reflog expire` already works like that, I think this is a
bit unfortunate.

Otherwise this patch series looks very well done to me.

Thanks!
