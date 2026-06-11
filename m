Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FB1A9F83
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146744; cv=none; b=DDUj5As6+3e4Ebo/rx1zDu25xCBL3Sfy0TbP5WNgKlWTuFc4IbN8RdxqW2YmbAaYoVo6t1myXTqzb2NyaG1j+MQ8/Um+9EN/OogSjXGwunCvvIT4BIvDuqQ89+PdsIeeqOTOFUZgPl2ngrHpfGScAWu2nRO8oPT3+jl/7uci8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146744; c=relaxed/simple;
	bh=hiy2vhmvWi+Mr+Ven0QBYYMYtpqEhk184kiYYGSEX7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo8mfimEpm6EFguMWmxT2TSQs7qBwyN8FlL09qLPaCyW24g3hBd7ChJ7rZz/t5jyuSspeEQR78cpe6tnV0DsIYpQVku8t7ICAaPq30jytxi9Mza+GBHx4sp4kTmsjz43mVl5AddwYb6ij6sj+pF0Nz4tFxrYSzaIPS7m8UN5wqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=kCRFVLKP; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=M70a4caY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="kCRFVLKP";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="M70a4caY"
DKIM-Signature: a=rsa-sha256; b=kCRFVLKP6fv5z6mlFatrPWANfe/57vWtIL8E7U8okG5IVGpdaX9g1h+eQ7GLoWtl2s0ESnZb2ruRQMnp7xmK7NsUKD7zTFhz+M/VbQSc5faV4bgPl7MvE9er/aKxrUbD7TxMLiRg1Vi0ou9R5L8Tw5fGbOkg8zB1xWsCQFigwtun9Zdow3AFJ0H7Is1EI+jS7Y3PPeXx8LIHKNlObRxUlhn5EwuVwXIA2jMlXcoWk3TF7vYG442AZAzEzsq8k8DoRcAJPt0t73/1SJ6t5i2O2RmFuvr9G0CdKOaIiMIXKfbSKcCrOvTd5IHvXf//W268D6vWRTRC6m3Cmag3MAP+TA==; s=purelymail3; d=malon.dev; v=1; bh=hiy2vhmvWi+Mr+Ven0QBYYMYtpqEhk184kiYYGSEX7k=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=M70a4caYiHSuS3AhzUWCr8se9OPKSzN+xiscQ3p4tA9DaELRynhmoPGcGiHVbo1pMfFPP4k9De2+k2cVsr5LeH7UNjUx2MDaLB13IzKU34oCbFIOaWW+wg9EE6ko+9A0mHLNfZlcJpM/U6h4d9risc/jcj1KVim6M+hyy7RsYpKdow8qAnPbXHYOd1paxFNjIP0wkGliW4dBHpmUdTIMy3N2QzTQ76HlSV9pkkNKCBrkWCyIJtbWxsFzFpW2pcSiFqdKe0vd2531shnDQbTeVXYUuzRBpJBbS1qqrNaOsMb1+bZKu1ITX+0q/9Ka6AsYQlJL8bLbsBQwXl9uIipCHw==; s=purelymail3; d=purelymail.com; v=1; bh=hiy2vhmvWi+Mr+Ven0QBYYMYtpqEhk184kiYYGSEX7k=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -214125557;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 11 Jun 2026 02:58:58 +0000 (UTC)
Message-ID: <21f74852-2209-4d77-94f4-b2b9412eb8e0@malon.dev>
Date: Thu, 11 Jun 2026 10:58:54 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] environment: move trust_executable_bit into
 repo_config_values
Content-Language: en-US
To: git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260610093635.139719-1-cat@malon.dev>
 <20260610093635.139719-4-cat@malon.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260610093635.139719-4-cat@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 17:36, Tian Yuchen wrote:
> Move the global 'trust_executable_bit' configurations
> into the repository-specific 'repo_config_values'
> struct. To ensure code readability, the getter functions
> 'repo_trust_executable_bit()' has been introduced.
> 
> For now, associated functions access this configuration by
> explicitly falling back to 'the_repository'.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>   apply.c       |  2 +-
>   environment.c | 11 +++++++++--
>   environment.h |  9 ++++++++-
>   read-cache.c  |  8 ++++----
>   4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 249248d4f2..fbb907d3c0 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3893,7 +3893,7 @@ static int check_preimage(struct apply_state *state,
>   		if (*ce && !(*ce)->ce_mode)
>   			BUG("ce_mode == 0 for path '%s'", old_name);
>   
> -		if (trust_executable_bit || !S_ISREG(st->st_mode))
> +		if (repo_trust_executable_bit(the_repository) || !S_ISREG(st->st_mode))
>   			st_mode = ce_mode_from_stat(*ce, st->st_mode);
>   		else if (*ce)
>   			st_mode = (*ce)->ce_mode;
> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..75069a884d 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -41,7 +41,6 @@
>   static int pack_compression_seen;
>   static int zlib_compression_seen;
>   
> -int trust_executable_bit = 1;
>   int trust_ctime = 1;
>   int check_stat = 1;
>   int has_symlinks = 1;
> @@ -142,6 +141,13 @@ int is_bare_repository(void)
>   	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>   }
>   
> +int repo_trust_executable_bit(struct repository *repo)
> +{
> +	return repo->gitdir?
> +		repo_config_values(repo)->trust_executable_bit :
> +		1;
> +}
> +
>   int have_git_dir(void)
>   {
>   	return startup_info->have_repository
> @@ -305,7 +311,7 @@ int git_default_core_config(const char *var, const char *value,
>   
>   	/* This needs a better name */
>   	if (!strcmp(var, "core.filemode")) {
> -		trust_executable_bit = git_config_bool(var, value);
> +		cfg->trust_executable_bit = git_config_bool(var, value);
>   		return 0;
>   	}
>   	if (!strcmp(var, "core.trustctime")) {
> @@ -720,5 +726,6 @@ void repo_config_values_init(struct repo_config_values *cfg)
>   {
>   	cfg->attributes_file = NULL;
>   	cfg->apply_sparse_checkout = 0;
> +	cfg->trust_executable_bit = 1;
>   	cfg->branch_track = BRANCH_TRACK_REMOTE;
>   }
> diff --git a/environment.h b/environment.h
> index 123a71cdc8..44b97be654 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -91,6 +91,7 @@ struct repo_config_values {
>   	/* section "core" config values */
>   	char *attributes_file;
>   	int apply_sparse_checkout;
> +	int trust_executable_bit;
>   
>   	/* section "branch" config values */
>   	enum branch_track branch_track;
> @@ -123,6 +124,13 @@ int git_default_config(const char *, const char *,
>   int git_default_core_config(const char *var, const char *value,
>   			    const struct config_context *ctx, void *cb);
>   
> +/*
> + * Getters for the `repo_trust_executable_bit` fields of `struct repo_config_values`.
> + * They check `repo->gitdir` to prevent calling repo_config_values()
> + * before the configuration is loaded or in bare environments.
> + */
> +int repo_trust_executable_bit(struct repository *repo);
> +
>   void repo_config_values_init(struct repo_config_values *cfg);
>   
>   /*
> @@ -160,7 +168,6 @@ int is_bare_repository(void);
>   extern char *git_work_tree_cfg;
>   
>   /* Environment bits from configuration mechanism */
> -extern int trust_executable_bit;
>   extern int trust_ctime;
>   extern int check_stat;
>   extern int has_symlinks;
> diff --git a/read-cache.c b/read-cache.c
> index cb4f4878c8..89f5c88c58 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -214,7 +214,7 @@ unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int mode)
>   	if (!has_symlinks && S_ISREG(mode) &&
>   	    ce && S_ISLNK(ce->ce_mode))
>   		return ce->ce_mode;
> -	if (!trust_executable_bit && S_ISREG(mode)) {
> +	if (!repo_trust_executable_bit(the_repository) && S_ISREG(mode)) {
>   		if (ce && S_ISREG(ce->ce_mode))
>   			return ce->ce_mode;
>   		return create_ce_mode(0666);
> @@ -228,7 +228,7 @@ static unsigned int st_mode_from_ce(const struct cache_entry *ce)
>   	case S_IFLNK:
>   		return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
>   	case S_IFREG:
> -		return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFREG;
> +		return (ce->ce_mode & (repo_trust_executable_bit(the_repository) ? 0755 : 0644)) | S_IFREG;
>   	case S_IFGITLINK:
>   		return S_IFDIR | 0755;
>   	case S_IFDIR:
> @@ -338,7 +338,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>   		/* We consider only the owner x bit to be relevant for
>   		 * "mode changes"
>   		 */
> -		if (trust_executable_bit &&
> +		if (repo_trust_executable_bit(the_repository) &&
>   		    (0100 & (ce->ce_mode ^ st->st_mode)))
>   			changed |= MODE_CHANGED;
>   		break;
> @@ -759,7 +759,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>   		ce->ce_flags |= CE_INTENT_TO_ADD;
>   
>   
> -	if (trust_executable_bit && has_symlinks) {
> +	if (repo_trust_executable_bit(the_repository) && has_symlinks) {
>   		ce->ce_mode = create_ce_mode(st_mode);
>   	} else {
>   		/* If there is an existing entry, pick the mode bits and type

There seem to be typos everywhere here, will change in the next reroll.

Regards, yuchen

