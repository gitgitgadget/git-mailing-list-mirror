Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FA296BCB
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783790517; cv=none; b=YJH6sqVQQW7xhwWamMnI2FkqfGmVN1H2gkLlAXKh/q4594k3vdZktiPWaSh2lyipHHHWTkwDRs+8mj+zNp0ecTuIwFu0QaWCCyKqrlPPqQPM4o3nwYUocz1UKTC94Kji86oqxnVzZwMJYPuGFO5WnnVYYEQNgBD4/pbqIx/YLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783790517; c=relaxed/simple;
	bh=hZ1rfFy8pefjWVq74QXlODUgAPLS1WX/Mj8cpMI8ER0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cQuNT1FveDEB8ayddN60xC3954yofL0NyscNIo39hO2VeZjYliDhGtD4AtPi6IuIe+11rXdD6oKYKzoNB3ww43js33QCKKsBZfUs57jtmF57iytxwZmEcGTUgvM/Oce52uFK8tB1eO6SFK2Tg5TAbFyLvNmev5fPa4bNnpkWSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRNKg5z8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRNKg5z8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso18648855e9.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783790514; x=1784395314; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLUUSR+FgO6YabQc/1HjFoBesymHOCW2IFvNe+ruClg=;
        b=iRNKg5z8ohQWPcs3dEqqjztTstuqOgRBKoo2Xv7OLz7Ve9oRW6Q0d+s5vABhGxpoKk
         hC3tvFHCuSmC1IMBFUg0oI70jnU05UpKAgci9je15Ft5R5o6vC6anYe0qA/Xsgvb9EDU
         cGM8YeXpBa4J6+owI5SKv6MjzisG7GwXFltoRYxqiaSZqZt3Iu62MCA9FIai+emMihh6
         aMwu9vMmypnpcJVqIE7gFPvnGzv2PGFspI93ik7hxCqcYSOEL3loRjwXOMy+MEoSDtor
         ejG+EFnDXr8163QJO2g4nLvNzt3AYliY7Dx+wk5+AuYh5mAKOkMurgRxVEa9h0ZjoFYo
         DG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783790514; x=1784395314;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLUUSR+FgO6YabQc/1HjFoBesymHOCW2IFvNe+ruClg=;
        b=H5CdwfrT2ujmob8r2rHlYf1NLy1dtzO3V4skPWFenoOW3H2IyAzGtQ9qfUeU2k5h0L
         ltvbvEwqlBY5aukDs++vwvS7d6B5e6IY4lpsGrmttG2NHEJee6dKxVmLLFFTmYX6rC3C
         y+QEuuozBF8tLXZV0530S75yU18wJIL3+9TVS89EvdWqZ32+mhYDSHy+qlbyzsPda+R9
         6ZoCSoTitj9Hjcqy037vuuUfzLuv7XBOVWjZQ8AoF5uhc8BGgXpoVReP7C0FPr/dhXVm
         4E7ISKVInLZtAtizuJkqbPeC1+2if8OlIToS9m2EfNjMPcuMAgWdJ0QghYDZ0QE1PsQh
         6kBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8GKL+BKLNhUqQcCMgcxnFJWJjV9EaSkff2c2jm8y3nSUzEboMo/aPhYFbAKGn+qJXkZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZ2vVUbuQzcH7EJlGOZlUglN4X9X10jIpModFdCQbgiAy/ZrK
	K65qJvx/Vct2yM7QK/Kzl7JatMYvrMTTzeYjdG9VZU+a/bohEt6XuTm9
X-Gm-Gg: AfdE7cllgjh5rMfCJzFO64wmW2gYtnIQfsP3OQhDKkWkfQPS888Dda/0c5eqIvt8Si+
	YSPIjVduPqXdCOqGOk7HBUOHyRfPqJbVfUkXnafApFVqkuGwYG6qZbYcyjDSl5Xv6UZuuUifgRk
	W43hGqvczAe0s7WSlaNKkUlQtgSzDrMb/HUiJeeOJnZ1prRN/I5ggE4UBIrU0fgEGXMxvtb3NOU
	Sj06AxlmeqDax8AirX2efPgUl/h+AYCdhEsou63mWC590ogP9pRip4bxNIA0qRThVoGA4pJU53d
	EZb87HlMWZ6UiPCTyijw+L90vnClEkvUrMJPYhwrmapcdK2EdwNgwTpDIbqRhKjQbpFQe0Jcc+t
	HTEohHcMwL7eCvFDLCpamKn2uNwCcLSpPnVyQ96eCzcTUfkF1e+p228Rn7IrJiK1wjwtr0q4say
	gmSNBHMDG3RSvoSstF/C/D3E4zuPvVf3lwqC++ushXquUFZ1xNSw15DEbQaePNC9t9UyOAKfQs5
	fSOdEZKOyt7C3Zb1RpPGlIQU7fFpWovII26tD/HTtJyxod4wmUDmEebLOdkiAaquKJhIc8pS608
	UTaKkOtU4labfthi78PIsaPcFc/CWxHs1wleF4dxc1vc0hPrbQnRwhUPoMZtqGBEVrM8dw==
X-Received: by 2002:a05:600c:6d8c:b0:493:d0f7:69c3 with SMTP id 5b1f17b1804b1-493f882ec68mr19037395e9.33.1783790513798;
        Sat, 11 Jul 2026 10:21:53 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm25557183f8f.16.2026.07.11.10.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 10:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 19:21:52 +0200
Message-Id: <DJVWYOJNU0IW.1M107L4ABH54V@gmail.com>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Ayush Chandekar" <ayu.chandekar@gmail.com>,
 "Olamide Caleb Bello" <belkid98@gmail.com>
Subject: Re: [PATCH v9 1/9] repository: introduce repo_config_values_clear()
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
 <20260709161145.13349-2-cat@malon.dev>
In-Reply-To: <20260709161145.13349-2-cat@malon.dev>

On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
> As part of the ongoing libification effort, dynamically allocated
> global configuration variables are being moved into
> 'struct repo_config_values'. To prevent memory leaks, we need a
> destructor to free these heap-allocated variables when a repository
> instance is torn down.
>
> Introduce 'repo_config_values_clear()' in environment.c and invoke it
> from 'repo_clear()' in repository.c. As a starting point, update this
> new function to handle the cleanup of 'attributes_file'.

Makes sense.

>
> Note:
>
> Submodules are currently not supported by repo_config_values(), which
> explicitly BUG()s out if 'repo !=3D the_repository'. Since repo_clear()
> cleans up all repository instances, we must bypass them to prevent
> crashing.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 19 +++++++++++++++++++
>  environment.h |  9 +++++++++
>  repository.c  |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/environment.c b/environment.c
> index ba2c60103f..13677484de 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -726,3 +726,22 @@ void repo_config_values_init(struct repo_config_valu=
es *cfg)
>  	cfg->sparse_expect_files_outside_of_patterns =3D 0;
>  	cfg->warn_on_object_refname_ambiguity =3D 1;
>  }
> +
> +void repo_config_values_clear(struct repository *repo)
> +{
> +	struct repo_config_values *cfg;
> +
> +	/*
> +	 * NEEDSWORK: Submodules are currently not supported by
> +	 * repo_config_values(), which explicitly BUG()s out if
> +	 * repo !=3D the_repository. Since repo_clear() cleans up all
> +	 * repository instances, we must bypass them here to prevent
> +	 * crashing.
> +	 */
> +	if (repo !=3D the_repository)
> +		return;
> +
> +	cfg =3D repo_config_values(repo);
> +
> +	FREE_AND_NULL(cfg->attributes_file);
> +}
> diff --git a/environment.h b/environment.h
> index 6f18286955..c4a6a45704 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -135,6 +135,15 @@ int git_default_core_config(const char *var, const c=
har *value,
>
>  void repo_config_values_init(struct repo_config_values *cfg);
>
> +/*
> + * Frees memory allocated for dynamically loaded configuration values
> + * inside `repo_config_values`.
> + *
> + * As dynamically allocated variables are migrated into this struct,
> + * their FREE_AND_NULL() calls should be appended here.
> + */
> +void repo_config_values_clear(struct repository *repo);

I think that I'm not comfortable having the _init() and the _clear()
functions with different signatures.

_clear() takes struct repository to dodge a BUG().

I would like to have both signatures equal, why can't we just do directly:

  void repo_config_values_clear(struct repo_config_values *cfg)
  {
  	FREE_AND_NULL(cfg->attributes_file);
  }

and call from repo_clear():

  repo_config_values_clear(&repo->config_values_private_)

I get that the workaround might be to not access directly to
&repo->config_values_private_ which repo_config_values() returns but for
example initialize_repository() access this _private_ field directly as
well.

Even with the NEEDSWORK it is a silent return, what will happen when
submodules are supported? If no one remembers to change it we will leak
the submodules silently.

Also at repo_init(), initialize_repository() sets repo->initialized
before anything can fail and call repo_clear() but
repo_config_values_clear() should be able to free attributes_file even
just after a memset() (which happens before initialize_repository()).
But calling repo_config_values has a BUG() in case of
!repo->initialized are we comfortable with this assert?

> +
>  /*
>   * TODO: All the below state either explicitly or implicitly relies on
>   * `the_repository`. We should eventually get rid of these and make the
> diff --git a/repository.c b/repository.c
> index 187dd471c4..b31f1b7852 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
>  	FREE_AND_NULL(repo->parsed_objects);
>
>  	repo_settings_clear(repo);
> +	repo_config_values_clear(repo);
>
>  	if (repo->config) {
>  		git_configset_clear(repo->config);

Regards,
Pablo
