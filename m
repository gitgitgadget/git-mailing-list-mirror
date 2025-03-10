Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85221DED4B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641430; cv=none; b=RqIi5HzP6mMzlEbDI+qPi0VC3Uxq7vNyZUCOa0AU0eLTOvzUzUY+ee/SYwgCHfHIW6tAqFcaFj3/rDCcmL8bwvs85kcIPKyszBPnda1M8hM/gTJU2NaucFcocZwU9ztqbaI/j/YbVliRjIv6RsVw+g9jMjYxJ1/pcXrk8hodZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641430; c=relaxed/simple;
	bh=Hn0jgOYWyV2fOWXNpBbjBVod/6b8jpItqsGVSjTppGE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/BT7XVdsXsIW6PlaGPH/Ddn+Mb/iKUmttE9h8F6nuB19KBkQD3DTjY6d9ozVzle0ksb0pVNpUDwSH589YlljWAx0oHbWYWsIrmloPsLlz0wkJNNFPrCz0raNxM6EPlkjJPns44SSoVUuCp1yWf5kafZalPmmZHW5fEnHdivtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZZvW2Cn; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZZvW2Cn"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d6ac4d5a9so571514241.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741641427; x=1742246227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBSyrEEq94GxFj7C3AwiChJqDV4++45CPHYK25EBRYM=;
        b=JZZvW2Cn8p/dxtP1EanXFURAILVSOpjloCWeE6/sDKXyK7yrwsWXqV4Bp05GxGSItH
         o92pRzPUL/1GrcT139QILfn3evmTPcVxv4HM5h6aHUF85WEuwpf85PkeWuO8S2Fm2UIk
         RLPnoT5pu7eOr89MEe5caA9dRoSsClyfZE+biMgH1ujkcQRgHIcBtjI5PSYe8DskU7K5
         KRZtHXgh7t/AQ7ISv4ijwtAEJ+Lfz+Y2otawxWkPzyLe2d0U9LOv6WDiXjPDgk8bQXb2
         64aorw/+G6xIqdcMZ5isBJdLYgz21YDA4HIfnl0ZSckggNG91HEE+vVo5IIyrfy5UhRZ
         CUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641427; x=1742246227;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBSyrEEq94GxFj7C3AwiChJqDV4++45CPHYK25EBRYM=;
        b=o0Xk05J1LqvikaEHxyTweLv8MauEbI0v4CAPPS2DifEAs2lTH8dxBdFXjo2pwIxNU+
         de6WTO1CEsjdhiRcb3C2xBagRGRMeXkylEyobA+dlsit2qlSN6C5hRkKFXks7gKHlwtX
         GKLvPBvtse4eXqp2j2NZP+Bbl7KfS3n9qmzJCGxFFIkGqemB4AaMMuR8lSzWEp1L/SDA
         NgE6HnZt2llWdvTw7Ctkwk32aBO3OlNf02fZrtwxRj8KuRNFmkVfX7TN92df9oIqa4iq
         S/Hmv0Bjv1MKjvBLtCaKfesiLCQudwyq9od//aOh43QxCc4g1HvXTD9lO6WlmHW/iOC2
         bhuw==
X-Gm-Message-State: AOJu0Yy8COAJA4pdrxxA8+Adg8NcAgt5oDOCcfLJaXQsqRuIl1enoAU6
	jf8u7QMqIM87UgLEsj4MBtZkkgD/Nm+TBfat+5lyu7Hpv7JM7iGGi8HsURnbbcJPpLwQ+inKutc
	1N97Mr5TLqxN0TlL75zPOSX0cyOo=
X-Gm-Gg: ASbGncv+cICEnuAT7vAuSB5Mc3V6toqpBT8jrTzUKdA8g0Jpxx/FswKswsUM+WWqwF+
	FbP7jLR+4KNH+BeGkyhkjEbgimamcwW5GRXnKZUGkz40Ay+mBObdOraUZsSRaXofTQMUK71Y+i4
	34S0V54MOOa8a8QEwtnKTgKfwmC7VBCWrB+xh33Ka9cUkIA8B9AgfP0HqpmSrqZxlvSiHoK+s=
X-Google-Smtp-Source: AGHT+IFLBHVNh4rueAC70NTkmWALNEUTp7FF1AsYyoqvc+TxBGIHlodjiye3V3zfjdJe2Y/sy2CdjHwp8/19IHxDpn4=
X-Received: by 2002:a05:6102:41a8:b0:4c1:992c:b95d with SMTP id
 ada2fe7eead31-4c30a67e5fdmr8940183137.17.1741641427427; Mon, 10 Mar 2025
 14:17:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 14:17:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250310151048.69825-3-ayu.chandekar@gmail.com>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com> <20250310151048.69825-3-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 14:17:06 -0700
X-Gm-Features: AQ5f1JoWxf0OFwQ9sjnQ4Bl6WwRev-OTqUs_N4HSzN4g4qksPQ3YyL4QDEyrPDk
Message-ID: <CAOLa=ZT=zGTF2DLEy9VjXhcUN3wEi7_R=8O6nV-TtBXKT=ENXg@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] attr: use `repo_settings_get_attributesfile_path()`
 and update callers
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000009bf82c0630037ec8"

--0000000000009bf82c0630037ec8
Content-Type: text/plain; charset="UTF-8"

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Update attribute-related functions to retrieve the "core.attributesfile"
> configuration via the new repository-scoped accessor
> `repo_settings_get_attributesfile_path()`. This improves behaviour in
> multi-repository contexts and aligns with the goal of minimizing
> reliance on global state.
>

We should also talk about the modifications made to pass around the
repository struct.

> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  attr.c               | 28 ++++++++++------------------
>  attr.h               |  7 +++----
>  builtin/check-attr.c |  2 +-
>  builtin/var.c        |  2 +-
>  4 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 0bd2750528..8f28463e8c 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
>  	return system_wide;
>  }
>
> -const char *git_attr_global_file(void)
> -{
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> -
> -	return git_attributes_file;
> -}
> -
>  int git_attr_system_is_enabled(void)
>  {
>  	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
> @@ -906,7 +898,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
>  	}
>  }
>
> -static void bootstrap_attr_stack(struct index_state *istate,
> +static void bootstrap_attr_stack(struct repository *repo, struct index_state *istate,

Nit: here and other places, can this be a 'const'?

>  				 const struct object_id *tree_oid,
>  				 struct attr_stack **stack)
>  {
> @@ -927,8 +919,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	}
>
>  	/* home directory */
> -	if (git_attr_global_file()) {
> -		e = read_attr_from_file(git_attr_global_file(), flags);
> +	if (repo_settings_get_attributesfile_path(repo)) {
> +		e = read_attr_from_file(repo_settings_get_attributesfile_path(repo), flags);
>  		push_stack(stack, e, NULL, 0);
>  	}
>
> @@ -946,7 +938,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	push_stack(stack, e, NULL, 0);
>  }
>
> -static void prepare_attr_stack(struct index_state *istate,
> +static void prepare_attr_stack(struct repository *repo, struct index_state *istate,
>  			       const struct object_id *tree_oid,
>  			       const char *path, int dirlen,
>  			       struct attr_stack **stack)
> @@ -969,7 +961,7 @@ static void prepare_attr_stack(struct index_state *istate,
>  	 * .gitattributes in deeper directories to shallower ones,
>  	 * and finally use the built-in set as the default.
>  	 */
> -	bootstrap_attr_stack(istate, tree_oid, stack);
> +	bootstrap_attr_stack(repo, istate, tree_oid, stack);
>
>  	/*
>  	 * Pop the "info" one that is always at the top of the stack.
> @@ -1143,7 +1135,7 @@ static void determine_macros(struct all_attrs_item *all_attrs,
>   * If check->check_nr is non-zero, only attributes in check[] are collected.
>   * Otherwise all attributes are collected.
>   */
> -static void collect_some_attrs(struct index_state *istate,
> +static void collect_some_attrs(struct repository *repo, struct index_state *istate,
>  			       const struct object_id *tree_oid,
>  			       const char *path, struct attr_check *check)
>  {
> @@ -1164,7 +1156,7 @@ static void collect_some_attrs(struct index_state *istate,
>  		dirlen = 0;
>  	}
>
> -	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
> +	prepare_attr_stack(repo, istate, tree_oid, path, dirlen, &check->stack);
>  	all_attrs_init(&g_attr_hashmap, check);
>  	determine_macros(check->all_attrs, check->stack);
>
> @@ -1310,7 +1302,7 @@ void git_check_attr(struct index_state *istate,
>  	int i;
>  	const struct object_id *tree_oid = default_attr_source();
>
> -	collect_some_attrs(istate, tree_oid, path, check);
> +	collect_some_attrs(the_repository, istate, tree_oid, path, check);
>

The other places in the same file we pass around the 'repository'
struct, but here we use 'the_repository'. Even below, we modify an
external function's signature to avail the 'repository' struct.

Can't we modify 'git_check_attr()' to also receive a 'repository'? If
not, perhaps it would be much simpler to simply pass 'the_repository'
everywhere and cleanup this file in another follow up series?

>  	for (i = 0; i < check->nr; i++) {
>  		unsigned int n = check->items[i].attr->attr_nr;
> @@ -1321,14 +1313,14 @@ void git_check_attr(struct index_state *istate,
>  	}
>  }
>
> -void git_all_attrs(struct index_state *istate,
> +void git_all_attrs(struct repository *repo, struct index_state *istate,
>  		   const char *path, struct attr_check *check)
>  {
>  	int i;
>  	const struct object_id *tree_oid = default_attr_source();
>
>  	attr_check_reset(check);
> -	collect_some_attrs(istate, tree_oid, path, check);
> +	collect_some_attrs(repo, istate, tree_oid, path, check);
>
>  	for (i = 0; i < check->all_attrs_nr; i++) {
>  		const char *name = check->all_attrs[i].attr->name;
> diff --git a/attr.h b/attr.h
> index a04a521092..1ff058bef7 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -213,11 +213,13 @@ void git_check_attr(struct index_state *istate,
>  		    const char *path,
>  		    struct attr_check *check);
>
> +struct repository;
> +
>  /*
>   * Retrieve all attributes that apply to the specified path.
>   * check holds the attributes and their values.
>   */
> -void git_all_attrs(struct index_state *istate,
> +void git_all_attrs(struct repository *repo, struct index_state *istate,
>  		   const char *path, struct attr_check *check);
>
>  enum git_attr_direction {
> @@ -232,9 +234,6 @@ void attr_start(void);
>  /* Return the system gitattributes file. */
>  const char *git_attr_system_file(void);
>
> -/* Return the global gitattributes file, if any. */
> -const char *git_attr_global_file(void);
> -
>  /* Return whether the system gitattributes file is enabled and should be used. */
>  int git_attr_system_is_enabled(void);
>
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 7cf275b893..1b8a89dfb2 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -70,7 +70,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
>  		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
>
>  	if (collect_all) {
> -		git_all_attrs(the_repository->index, full_path, check);
> +		git_all_attrs(the_repository, the_repository->index, full_path, check);
>  	} else {
>  		git_check_attr(the_repository->index, full_path, check);
>  	}
> diff --git a/builtin/var.c b/builtin/var.c
> index ada642a9fe..8fbf5430a4 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -71,7 +71,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
>
>  static char *git_attr_val_global(int ident_flag UNUSED)
>  {
> -	char *file = xstrdup_or_null(git_attr_global_file());
> +	char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
>  	if (file) {
>  		normalize_path_copy(file, file);
>  		return file;
> --
> 2.48.GIT

--0000000000009bf82c0630037ec8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 63e08c60ffa7b6aa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUFZ0RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3JFQy93S2ttNWoxR3JtUWlZQU1COW5kb0MvV0VJVQpUODREdVFLSjdW
YVRyRWhUSlNXajhVejR6cXp3SUJ0d3pvRFFlaFJEam55RWtaTGRGcTYwNjhyb1NjZTQzd01NCmFy
Nm9ENUtwcS9IS2tQalRTdHhUbFdpSGdvc2t5UGQyVi9iOWdMWC8rdnR6b09XQlZFSE9xY2dvV0sz
bE11amwKTTl6aG5yZjJ1WjhxT25GcThGQUg0R0NFOVB0WGM2bnBUME05QmRJcWlDL0RtalMydGtS
UlE5ajJTZGlFVXcyTQp2Q3BacTBQdUFoekdsL0k4TE0ydm1rL1VRNGh4VWw5VzByL0dGeEprcnpR
Sm04VFRJbXlTRnBXQ3psck8yaG1ICnJZUmZJNDAzQW54RUVtZnJtYzFXaDg4STZoeHB2clJkOXVt
QVplYTR5TmoyODV4aXVDdSs5bTVFRCtrUnFVMUQKaGNsclM4dWphc1FuOGVpRzJIWGNhUy9IMjRO
bEtMS2RIakdsVFZpUjVUNUxsQXY0dUxOT2Z5SXFldWVEMzI3dwo3V1Vta2w2RXFRRVJjUm9sSGJ2
ejhtM1JMNXRiZThDNmZJanlXdk9KZ2UyN1MrUlp5TE1VU216eTl6V01DZzJmClI2NFZhNE82c0Vw
NVNETUFJOVhCUFFVaU1KL2ZVL2xEU2dlNU5yND0KPTM4VksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009bf82c0630037ec8--
