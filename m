Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA42239E9B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647883; cv=none; b=G6NneJWL8mcRFahkB9fHWT274XlW9kDr73HIiggODFfZb9Pv2i/SiibJAKeKs6cm0o3HCD2mBHGppNapmZdmiSisswFSSBcASqbd5gIirESUri+pJUhyv//bGApN5KOJSEOiyVU5w/BzzSd7zWv5uuNz3D/INkhywYWIBvUumEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647883; c=relaxed/simple;
	bh=MI/32LOr97rjviJNRZehFmVKgu1x7Nys1+pmDmoqu68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqPN4R4XSIZefpO/lYBuq0aaBRQHvVfb0DRUAouHvI9XQrgtuj7JIl7sCZT5PsHP9sm2i4rXdd06RBoC8NRQzGBo83godwzPrRIlMHbLVYzeJ7LtaNZ+o+M5ac0LYIjGL7iNklS89Zzn3Rto4M/oXc8QX8A0QNHDp2KjzsUJ0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4M33fAU; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4M33fAU"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-441e193c001so598136b6e.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647881; x=1761252681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXdCrx6CGptwWN5udpRAmUy3Fb8lQme71LvZf1FQ06g=;
        b=b4M33fAUGGBAEGIy+KXDHR/HHmnNgwqGXaUXBAmoAvto/56jcjRJ723zzi/SWfV6iW
         ocapyz37MNaeA9+SEuEmGRVbYmI64iOL6rNJBdr6mhSJiuNhm5LK9LFZ3IB0VAq5b2Qu
         +5EtoUx4LFyOrdDLHFQRR23LEndDY/hPJ/WO2f5e/s0u+7OCR8zJeguFRpUVZFWCYTkd
         daWSQhzlLzKiKdWu7wS9WZgpg5bGMp7olPKBUhXT9FN7DmWryoHa2hqqY91xyuF3nwGe
         KFI4kyMLkm5rzNJDxB78hg/QV37a53JIUN6TpLtnWye50hSGRVGmldtk+yADVAC2VCUS
         zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647881; x=1761252681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXdCrx6CGptwWN5udpRAmUy3Fb8lQme71LvZf1FQ06g=;
        b=EjcGIxfFLIHmM8NgVhti9yZU9Lk+tbMi856iKkbm6fzLUo/yiXXve5Y1ap2PeOaHP+
         jFWqvBxii/n35mY0312XdesAYwsNHMHtjLtbg9oeO2duNT0FZ9krEg8v/MSVIpWMxYw6
         e39cWcjAjogOJJ22H3GONHxGVoy9jFUJlB1jxVrVSY2CyZX6IAjoefcWTHrR6/3yiYA6
         YEkFGVwXYgc8dA5VazIVC5CSlPcecOAjntVIw/MM7YUC4tfK6sLaZjwBpzMnDUmtGWZK
         oeNXq7Pi44CWTCvWKltalGjyFJYrUqe++Xap9GwRPDx4oA5YR9wghieu8W9JoOwyJgGJ
         jU1w==
X-Gm-Message-State: AOJu0YziK6thCnuiX6F2P+TR64bQufBFG637Ity8TiKi/6DwFpnjg/xx
	wQnG+emdEuLJdz89+o0wm0d9o4sEu/ZWN+vjyS2Z2OLBj2P6HL1pgIN03jfQIQ==
X-Gm-Gg: ASbGncvBzjUNn9n65LmSBt6PyuycRUmzRf/76brhqO7c5rOzWZUQzk5zTmCJjQhhpxh
	5auH4zY+RJvFPGQXaEpQ4OF+rmy6QqGf3s8LVQsQVw/Xi4fwu08Ebu/POSbAtYyP6V9Sb2IDIXk
	CzJn9B/7MqXDpS+L3Amo8K3ukBsjGOYfzium1+Rlx+m+qwd1NEUZzhr2JqYfqWggEqBuJejee+g
	f7+xk5spWihgHoEu0g7vypypXjFYxphry5g/dr630Q7/ma+YGW2RKID0ffwDSTQ8k4x1sc0z3QZ
	PVhq65pZwjjnTYfPYjkKkhje5RxjTFFAsEt6+ZN6/SwV+jDwG3maG8Vb1ubNJtZUbi0eGHpHKzG
	IXSEt7Uej8I5x+I8fZSwryCbG2SL8pydmtTYlbPcah+DZX9B3CDEzvSiBtRoChbBcNuPuXw==
X-Google-Smtp-Source: AGHT+IGEulDC+2jUhG+OXMm5l9BTMYsQsk8luRHuHhdL/VGmUKsiqXSFzXJxMHyYBKYRwrh4w4VYew==
X-Received: by 2002:a05:6808:1929:b0:43d:1d20:9486 with SMTP id 5614622812f47-443a3095643mr635460b6e.43.1760647880923;
        Thu, 16 Oct 2025 13:51:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c27dfea199sm215759a34.19.2025.10.16.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:51:20 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:51:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <uos7cczvzlrwjgcyhzyfirck62qjnb4zcoy6ga2o3pbnba7cfj@ag2pnonze5tu>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>

On 25/10/16 09:26AM, Patrick Steinhardt wrote:
> Introduce a new "geometric-repack" task. This task uses our geometric
> repack infrastructure as provided by git-repack(1) itself, which is a
> strategy that especially hosting providers tend to use to amortize the
> costs of repacking objects.
> 
> There is one issue though with geometric repacks, namely that they
> unconditionally pack all loose objects, regardless of whether or not
> they are reachable. This is done because it means that we can completely
> skip the reachability step, which significantly speeds up the operation.
> But it has the big downside that we are unable to expire objects over
> time.
> 
> To address this issue we thus use a split strategy in this new task:
> whenever a geometric repack would merge together all packs, we instead
> do an all-into-one repack. By default, these all-into-one repacks have
> cruft packs enabled, so unreachable objects would now be written into
> their own pack. Consequently, they won't be soaked up during geometric
> repacking anymore and can be expired with the next full repack, assuming
> that their expiry date has surpassed.

So normal geometric repacks don't ever check for unreachable objects,
even if all the packs are being merged together. With this new strategy
though, when a geometric repack would normally merge together all packs,
we instead to an all-into-one repack which does check for unreachable
objects.

Does checking for unreachable objects in this case slow down the repack
significantly?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1566,6 +1568,101 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
>  	return 0;
>  }
>  
> +static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
> +					     struct gc_config *cfg)
> +{
> +	struct pack_geometry geometry = {
> +		.split_factor = 2,
> +	};
> +	struct pack_objects_args po_args = {
> +		.local = 1,
> +	};
> +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	existing_packs.repo = the_repository;
> +	existing_packs_collect(&existing_packs, &kept_packs);
> +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> +	pack_geometry_split(&geometry);
> +
> +	child.git_cmd = 1;
> +
> +	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
> +	if (geometry.split < geometry.pack_nr)
> +		strvec_push(&child.args, "--geometric=2");
> +	else
> +		add_repack_all_option(cfg, NULL, &child.args);

Here we do the full repack when the all packs are to be merged. Makes
sense.

[snip]
> @@ -1608,6 +1705,11 @@ static const struct maintenance_task tasks[] = {
>  		.background = maintenance_task_incremental_repack,
>  		.auto_condition = incremental_repack_auto_condition,
>  	},
> +	[TASK_GEOMETRIC_REPACK] = {
> +		.name = "geometric-repack",
> +		.background = maintenance_task_geometric_repack,
> +		.auto_condition = geometric_repack_auto_condition,
> +	},

Here we configure the new maintenance task. Nice :)

The rest of this patch looks good.

-Justin
