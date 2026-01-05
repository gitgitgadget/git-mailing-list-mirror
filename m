Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882B33A9F1
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623011; cv=none; b=uDQR4RBJK0fub64mD/JGmk2K+TID+mbGZO0NVxeYUR0zJID0wg3sooSrdRIuYF1oFpmJui6K87I3ALZ6E/yZQrmXvYHvh+RVYv/gNzLYciChGAZiw+c6S1hHvr+s2ESHE774jHUz2WJrsUmY0CCn1RXxrzyUwd8gJ8Ncw/WJUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623011; c=relaxed/simple;
	bh=qCpcRcNh77NdvqupTdztHKuaABwK5yVk1fGbpWXvLFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA4SwwVwE50rmpTtz5AWAoEXsnSeKVj5xbI/orOkcZvWyj+BupKImEALR+o8UuH4gMGnmWj3V1K9vcm+ADOtcL1gnvSldDN9fqWZna861OsZusIJ/3KIwsOCvSdDj5qJe51VOu2F2fFYOmO0Bwdoo9iXcJNRQIFG26nja2jc0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeCUz1Od; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeCUz1Od"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so37445825e9.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767623008; x=1768227808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7QXkJcCrbAoxbKGzrmD86qssZKSueGshgEPE9F+6LvI=;
        b=MeCUz1Odux/CW6PPQC4sHqff83d46dlbVu4GB5RCP+FceBbz5uef8ekpf2Sd1CTEip
         Kv9L9nRDPxlK3J6Yfjs1CJFArTbnw1SQyfs6C563siKoBraSf/90XHj/un55Wnlil2PB
         RscILBEAcqfdMy+i/Jgvyg9V9lCb60kWHw6BjPPS4eyB03waiOlegF0he1yAe+7sU7Ao
         PpUGSm0Agt83t0FWby3N8NecewHDxgoPZOn37xWrqGaq4f0pwebMSIHpD8enVWa5lbO1
         nCXFhQL8Wed6VHtJHEaT4PV64aV64cqu1n8s/wmX6/a1bWxPW/jv33nTPE4G/UavJmRE
         ajVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623008; x=1768227808;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QXkJcCrbAoxbKGzrmD86qssZKSueGshgEPE9F+6LvI=;
        b=B8RnTVVU2/KB2ApZiAeHBRFLEEPkZICgZvn449IITPo4Wc+SP9QMkAOuOgCwi+EB4Z
         c9J+3Uqy7OaNnW05NTpwrgmiOr7bxFsWjtJKuEstgz7EM2DhOpTNNolrT9iztkotpnsa
         SG2Mjbtc3fJJVN9hrYn8QWv2LUuCrtVHAobtVfJu4bGXDzKZo20jyPrucH3G7v2czZwl
         repveE+UZEEy88Nic9KkYF4YIZlHUEZW7zNfW2rdEvWqKD7wB7k3gy+YTf7KD6BSXZeX
         o6XBv+mO/j2IPMpETuTZ8Uo1/peM4bjG43TOq+9T6SmNFrDbS0L3dx9xnGmTuvWwaYNc
         Md7w==
X-Forwarded-Encrypted: i=1; AJvYcCV/HGD6WGk+FvAjgcxeyvrOf6s3xuUTepMkAjU3Ug5qo9IdJEqdaTARu/A5eLg9lSp9OqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yjWxpeTgmoSy37G5v97zqmREk/JBneVwRxHsgktAVtTlFqJz
	6e/u3XeUT3CfEduLRbzDug7EVewyFeOJlOXD3aaE52GHPCaFgcFlqca26LDFv+8r
X-Gm-Gg: AY/fxX46FWX0hhjempkh5rReyGm9YjRn6ORcEw/6quzv64hZTUgRYoYp+warNTbvqAD
	lJwTVs5/0PjlPmoqRZuywPrsrgAZajRvaEL/B5ZAcnvTd3C7yZuCOtLHjhWLZ1vOAv4lmtRkGxp
	ot6BD39KgLaUzTrXzfQgMpctvvc2taPNhIJWCsl7yVylUsgD4W/b1ZJuo98EKlfQVo78uTFVTRk
	BLf7Ocbh9O/Mh4tkO7k29HfLeMKtMf1JdrgLeKk7O0DwnGX1GpjdajG7QdKrc6EGe9jRodTge2R
	lbJ9u6FPvTZI9E4yZm7QEJOKUvRQOFUUctxae8fFLUGrxF7yr0I6GR8RkslBba1NWx3DPSqou7j
	TTYepr9ycbDQ84NXrHSg/klHQkoF0j1cXt4XhvPftMaHHUw5oD6vWFvFteawE6aECUrXlLgnZ6e
	ZreXXhJRc5GTmacJWI3axLH2MntdusJpGP1cFGyDlglUcZEYvImYTXcPwxX5JERkh6hg==
X-Google-Smtp-Source: AGHT+IEsdsB7VRUJRrp0Lejpe67zjPdBfp2HTOlqualDTxLD5Odfv+Nwqab9WSCFidOvC2Ab3k7fXQ==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-47d1954a165mr712277965e9.15.1767623007501;
        Mon, 05 Jan 2026 06:23:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f6asm164427735e9.6.2026.01.05.06.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 06:23:27 -0800 (PST)
Message-ID: <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
Date: Mon, 5 Jan 2026 14:23:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
References: <aVfzMsN2ouY3UBFG@ubuntu>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aVfzMsN2ouY3UBFG@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

On 02/01/2026 16:32, Olamide Caleb Bello wrote:
> When handling multiple repositories within the same process, relying on
> global state for accessing the "core.attributesFile" configuration can
> lead to incorrect values being used. It also makes it harder to isolate
> repositories and hinders the libification of git.
> The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> retrieve "core.attributesFile" via `git_attr_global_file()`
> which reads from global state `git_attributes_file`.
> 
> Move the "core.attributesFile" configuration into the
> `struct repo_settings` instead of relying on the global state.

This changes when the config setting gets parsed which unfortunately 
regresses the user experience when the setting is invalid.

If I run 'git -c core.attributesFile=~does-not-exist rebase -i' with git 
built from master it fails immediately with "fatal: failed to expand 
user dir in: '~does-not-exist'". With this patch applied it prompts me 
to edit the todo list and then fails when it tries to checkout the 
commit we're rebasing onto. Because "git rebase" expects reset_head() to 
return an error rather die if the checkout fails it is left in a strange 
state where only practical course of action for the user is to run "git 
rebase --abort".

It is quite common that moving from parsing config settings eagerly by 
calling repo_config() at startup to parsing them lazily via 'stuct 
repo_settings' causes regressions like this. We really should find a way 
to address that before moving more settings into 'struct repo_settings'

Thanks

Phillip


> A new function `repo_settings_get_attributesfile_path()` is added
> and used to retrieve this setting in a repository-scoped manner.
> The functions to retrieve "core.attributesFile" are replaced with
> the new accessor function `repo_settings_get_attributesfile_path()`
> This improves multi-repository behaviour and aligns with the goal of
> libifying of Git.
> 
> Note that in `bootstrap_attr_stack()`, the `index_state` is used only
> if it exists, else we default to `the_repository`.
> 
> Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
> The link to the GitHub CI is provided below
> https://github.com/git/git/actions/runs/20661817110
> 
> Changes in v2:
> --------------
> - Renamed the variable in the repo-settings struct to `attributes_file_path`
> - Modified the comment section of the accessor function declaration to
>    indicate the core.attributesFile is read via repo config.
> 
> Range diff vs v1:
> -----------------
> 1:  4975f77cde ! 1:  fc1dbec892 environment: move "core.attributesfile" into repo-setting
>      @@ Commit message
>           Note that in `bootstrap_attr_stack()`, the `index_state` is used only
>           if it exists, else we default to `the_repository`.
>       
>      -    Reported-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>      +    Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>           Mentored-by: Christian Couder <christian.couder@gmail.com>
>           Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>           Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>      @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
>        	if (*stack)
>        		return;
>       @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
>      - 		push_stack(stack, e, NULL, 0);
>        	}
>        
>      --	/* home directory */
>      + 	/* home directory */
>       -	if (git_attr_global_file()) {
>       -		e = read_attr_from_file(git_attr_global_file(), flags);
>       +	if (istate && istate->repo)
>      @@ repo-settings.c: void repo_settings_clear(struct repository *r)
>        	struct repo_settings empty = REPO_SETTINGS_INIT;
>        	FREE_AND_NULL(r->settings.fsmonitor);
>        	FREE_AND_NULL(r->settings.hooks_path);
>      -+	FREE_AND_NULL(r->settings.git_attributes_file);
>      ++	FREE_AND_NULL(r->settings.attributes_file_path);
>        	r->settings = empty;
>        }
>        
>      @@ repo-settings.c: void repo_settings_reset_shared_repository(struct repository *r
>        }
>       +const char *repo_settings_get_attributesfile_path(struct repository *repo)
>       +{
>      -+	if (!repo->settings.git_attributes_file) {
>      -+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file))
>      -+			repo->settings.git_attributes_file = xdg_config_home("attributes");
>      ++	if (!repo->settings.attributes_file_path) {
>      ++		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.attributes_file_path))
>      ++			repo->settings.attributes_file_path = xdg_config_home("attributes");
>       +	}
>      -+	return repo->settings.git_attributes_file;
>      ++	return repo->settings.attributes_file_path;
>       +}
>       
>        ## repo-settings.h ##
>      @@ repo-settings.h: struct repo_settings {
>        	unsigned long big_file_threshold;
>        
>        	char *hooks_path;
>      -+	char *git_attributes_file;
>      ++	char *attributes_file_path;
>        };
>        #define REPO_SETTINGS_INIT { \
>        	.shared_repository = -1, \
>      @@ repo-settings.h: int repo_settings_get_shared_repository(struct repository *repo
>       +/*
>       + * Read the value for "core.attributesfile".
>       + * Defaults to xdg_config_home("attributes") if the core.attributesfile
>      -+ * isn't available.
>      ++ * which is set via repo config isn't available.
>       + */
>       +const char *repo_settings_get_attributesfile_path(struct repository *repo);
>       +
> 
>   attr.c          | 19 +++++++++----------
>   attr.h          |  3 ---
>   builtin/var.c   |  2 +-
>   environment.c   |  6 ------
>   environment.h   |  1 -
>   repo-settings.c | 10 ++++++++++
>   repo-settings.h |  8 ++++++++
>   7 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 4999b7e09d..b081400c18 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
>   	return system_wide;
>   }
>   
> -const char *git_attr_global_file(void)
> -{
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> -
> -	return git_attributes_file;
> -}
> -
>   int git_attr_system_is_enabled(void)
>   {
>   	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
> @@ -912,6 +904,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
>   {
>   	struct attr_stack *e;
>   	unsigned flags = READ_ATTR_MACRO_OK;
> +	const char *attributes_file_path;
> +	struct repository *repo;
>   
>   	if (*stack)
>   		return;
> @@ -927,8 +921,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
>   	}
>   
>   	/* home directory */
> -	if (git_attr_global_file()) {
> -		e = read_attr_from_file(git_attr_global_file(), flags);
> +	if (istate && istate->repo)
> +		repo = istate->repo;
> +	else
> +		repo = the_repository;
> +	attributes_file_path = repo_settings_get_attributesfile_path(repo);
> +	if (attributes_file_path) {
> +		e = read_attr_from_file(attributes_file_path, flags);
>   		push_stack(stack, e, NULL, 0);
>   	}
>   
> diff --git a/attr.h b/attr.h
> index a04a521092..956ce6ba62 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -232,9 +232,6 @@ void attr_start(void);
>   /* Return the system gitattributes file. */
>   const char *git_attr_system_file(void);
>   
> -/* Return the global gitattributes file, if any. */
> -const char *git_attr_global_file(void);
> -
>   /* Return whether the system gitattributes file is enabled and should be used. */
>   int git_attr_system_is_enabled(void);
>   
> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..fd577f2930 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -72,7 +72,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
>   
>   static char *git_attr_val_global(int ident_flag UNUSED)
>   {
> -	char *file = xstrdup_or_null(git_attr_global_file());
> +	char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
>   	if (file) {
>   		normalize_path_copy(file, file);
>   		return file;
> diff --git a/environment.c b/environment.c
> index a770b5921d..ed7d8f42d9 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,7 +53,6 @@ char *git_commit_encoding;
>   char *git_log_output_encoding;
>   char *apply_default_whitespace;
>   char *apply_default_ignorewhitespace;
> -char *git_attributes_file;
>   int zlib_compression_level = Z_BEST_SPEED;
>   int pack_compression_level = Z_DEFAULT_COMPRESSION;
>   int fsync_object_files = -1;
> @@ -363,11 +362,6 @@ static int git_default_core_config(const char *var, const char *value,
>   		return 0;
>   	}
>   
> -	if (!strcmp(var, "core.attributesfile")) {
> -		FREE_AND_NULL(git_attributes_file);
> -		return git_config_pathname(&git_attributes_file, var, value);
> -	}
> -
>   	if (!strcmp(var, "core.bare")) {
>   		is_bare_repository_cfg = git_config_bool(var, value);
>   		return 0;
> diff --git a/environment.h b/environment.h
> index 51898c99cd..3512a7072e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -152,7 +152,6 @@ extern int assume_unchanged;
>   extern int warn_on_object_refname_ambiguity;
>   extern char *apply_default_whitespace;
>   extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>   extern int zlib_compression_level;
>   extern int pack_compression_level;
>   extern unsigned long pack_size_limit_cfg;
> diff --git a/repo-settings.c b/repo-settings.c
> index 195c24e9c0..cc53a3cd3b 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -5,6 +5,7 @@
>   #include "midx.h"
>   #include "pack-objects.h"
>   #include "setup.h"
> +#include "path.h"
>   
>   static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>   			  int def)
> @@ -158,6 +159,7 @@ void repo_settings_clear(struct repository *r)
>   	struct repo_settings empty = REPO_SETTINGS_INIT;
>   	FREE_AND_NULL(r->settings.fsmonitor);
>   	FREE_AND_NULL(r->settings.hooks_path);
> +	FREE_AND_NULL(r->settings.attributes_file_path);
>   	r->settings = empty;
>   }
>   
> @@ -230,3 +232,11 @@ void repo_settings_reset_shared_repository(struct repository *repo)
>   {
>   	repo->settings.shared_repository_initialized = 0;
>   }
> +const char *repo_settings_get_attributesfile_path(struct repository *repo)
> +{
> +	if (!repo->settings.attributes_file_path) {
> +		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.attributes_file_path))
> +			repo->settings.attributes_file_path = xdg_config_home("attributes");
> +	}
> +	return repo->settings.attributes_file_path;
> +}
> diff --git a/repo-settings.h b/repo-settings.h
> index d477885561..1209e1db83 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -68,6 +68,7 @@ struct repo_settings {
>   	unsigned long big_file_threshold;
>   
>   	char *hooks_path;
> +	char *attributes_file_path;
>   };
>   #define REPO_SETTINGS_INIT { \
>   	.shared_repository = -1, \
> @@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
>   void repo_settings_set_shared_repository(struct repository *repo, int value);
>   void repo_settings_reset_shared_repository(struct repository *repo);
>   
> +/*
> + * Read the value for "core.attributesfile".
> + * Defaults to xdg_config_home("attributes") if the core.attributesfile
> + * which is set via repo config isn't available.
> + */
> +const char *repo_settings_get_attributesfile_path(struct repository *repo);
> +
>   #endif /* REPO_SETTINGS_H */

