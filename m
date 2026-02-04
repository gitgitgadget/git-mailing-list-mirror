Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CD3112B0
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223153; cv=none; b=nSihak1mA6BzUVnFW361m+7XALnolpGi6l/kYVdLM1y1fPQEyur9/vxOYYYq9Q0d3igB7QW3e2FvqYevy7ee2mtONujPq8XaI8dGan5746xyOKcI3pdsCwl56mIA/kvl4/1G4o8bs9avp8sBmt88u9CWGcj81EHw9yGf2YCzFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223153; c=relaxed/simple;
	bh=Y7Skb1vYsNTh972V8LB2dYwiK3ZOuF7cPbATogbJ4CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYQ0edMFverswxAeg7EKLmB6z24YOUX/K1utmOgeB30yxXBjZAATme6ydCGKPynRPGsfBt484WuU7oURA6DBKHAcgLuQuQJfZtbzbhv8gc7M76EwkmMm8IL1mcl8tMXr8I9efuAW6UW/nNBibPQLxSzshpTKN3moJtCKPRq3wU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3bbDXjo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3bbDXjo"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so54924435e9.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770223151; x=1770827951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N10V9gARK5ON0swmoERtfNIfv3PNN4iguUakTGMVAoU=;
        b=i3bbDXjo2csy33DC60Boe/X8cd8E0jgB8OLCJ+4zs9gbPJFdl4oapSWJNsUC3Ghwyh
         x5OWo3Z/gzYwopYpvi/umLsFDgdJl8QFrfQS3X4ga5XH3RO49WiGcK9pyg/8xkSJ+nUq
         si2sYhPYBE1FSLrQoLhFr/GNJvscA5x8f33Bs62RyCIuOa+oDMnHRY9Gg1GBMxx5iGAt
         ug2mds7YIVs9RufqMYxoXPce/1vY7tBID+CxgFCfZaemkE1B6XfvH4m8J79pgmUwEA//
         Pbdz59zqOj7WlB4x3njZFNvHabv/w5a6eEfi+d9wzjKIbR+0czErCnNWvOK3Bocj4eQV
         sGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223151; x=1770827951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N10V9gARK5ON0swmoERtfNIfv3PNN4iguUakTGMVAoU=;
        b=kDRxkFOtQgv1t3Lb1Y64T0EEUb/aUtBPgm1EemX/Y0VKdukR/g6JmBB7DfzUcW7HrI
         Y7HFXFBIw7V2ETaZzt+Pk736EpAsxllCUgUx6Lm5XsW6GYYtE1Qcl6EB+6VSy5s76M3V
         nB0hOHf9fxf5w74HBBT8xHQhfpypKh1tEqEkX6nGk5PfZuQE/C1MAnc811Z6dACuuYFa
         0i7VvBSjZo4kskl45YLixePVw3/JsETBvQoESC9ekUwAPQkb91mwyYwQKFkYO8dnitjK
         dK2DEWUMRPquceqKTWdiBdDGD1yhbmapxd0WJiEqmrFOO3bJGqAxQcLEi/EVOlvbSqpt
         Occg==
X-Forwarded-Encrypted: i=1; AJvYcCWOrH9MHleCLXEa00ABSOW/HiiYeZWsDXsKS2msSzrSo+TPlL+JkuS6tiYm6J0c/QqghjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0qs28KG/nw5CGmWQj1Ivt3l6lqBgHDdilAaWbUO6QM1YtnEk
	jRrQfPaxpjzcsBdDtWL9gyk33rN7lB6soYoKx0VYLO8AOdRfawf/dHAL
X-Gm-Gg: AZuq6aJy02gCpJbhFkdaGmDqQ+SvFpn6G0fBsrf494c+j6aq525C0NkDTANkawobEW8
	J+hffJbURiVGT0AQqw2TzKp6lm+8l1fgOU7ZI8exYv7kqb0pWKc0fd39QETp/wCdW+z7BfvOId5
	Vc3m4U8Qr+joK4H2Sbvz+UtcAdKxwf7W0yjuI8qpLHh+7KFHK8XRdruLYXIVf2sJFS5jvAfoc9S
	tY0xydNow027nJr5/DGRlbYgDLCF106PPYn9npI0iVFvSrQNhFX5U3OSs+IRwjA3+Nzy16batrG
	OvQJsUtaGKKMLJzv34CsbOoJLQC3BzgdRbDLa9m+tfx7GL//ESHc4xmdpv1YsUkDKcACFaZVXfG
	Eje6S92As51IVlbOmRw/kM9ox44+0Uw9y0UGRuNrWyIKnJ2bMK4DcCJuEURs6cOlpsSCo4hxyWP
	PPTCXxObqXA/qNzs8QsZaJkkm1w3zTnpwoxynu7ShvOMZZSJLKk1z8vO5hce5Ukm5GiA==
X-Received: by 2002:a05:600d:644f:10b0:47e:e20e:bbb4 with SMTP id 5b1f17b1804b1-4830e99204emr35842245e9.26.1770223150643;
        Wed, 04 Feb 2026 08:39:10 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483107e62d6sm54124735e9.0.2026.02.04.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:39:10 -0800 (PST)
Message-ID: <c95a7730-7b14-4be0-a4e4-861b2f5430ea@gmail.com>
Date: Wed, 4 Feb 2026 16:39:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com
References: <cover.1770127568.git.belkid98@gmail.com>
 <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2026 15:42, Olamide Caleb Bello wrote:
> The `core.attributeFile` config value is parsed in
> git_default_core_config(), loaded eagerly and stored in the global
> variable `git_attributes_file`. Storing this value in a global variable
> can lead to it being overwritten by another repository when more than one
> Git repository run in the same Git process.
> 
> Create a new struct `repo_config_values` to hold this value and
> other repository dependent values parsed by `git_default_config()`.
> This will ensure the current behaviour remains the same while also
> enabling the libification of Git.
> 
> An accessor function 'repo_config_values()' is created and used to access
> the new struct member of the repository struct.
> This is to ensure that we detect if the struct repository has been
> initialized and also prevent double initialization of the repository.

Sounds sensible. This paragraph could be reflowed.

> It is important to note that `git_default_config()` is a wrapper to other
> `git_default_*_config()` functions such as `git_default_core_config()`.
> Therefore to access and modify this global variable,
> the change has to be made `git_default_core_config()`.

I'm not sure what this paragraph is saying with regard to the changes in 
this patch.

> --- a/environment.c
> +++ b/environment.c
> @@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
>   	/* Add other config variables here and to Documentation/config.adoc. */
>   	return 0;
>   }
> +
> +void repo_config_values_init(struct repo_config_values *cfg)
> +{
> +	cfg->attributes_file = NULL;
> +}

Should we be free()ing cfg->attributes_file when the repository instance 
is free()d? At the moment we're using "the_repository" which points to a 
static instance so it does not make any practical difference but once we 
start storing the config per-repository instance we will need to free 
the config when the repository instance is free()d.

> diff --git a/repository.c b/repository.c
> index c7e75215ac..a9b727540f 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -50,13 +50,25 @@ static void set_default_hash_algo(struct repository *repo)
>   	repo_set_hash_algo(repo, algo);
>   }
>   
> +struct repo_config_values *repo_config_values(struct repository *repo)
> +{
> +	if(!repo->initialized)
> +		BUG("config values from uninitialized repository");

This check and the one in initialize_repository() below assume that the 
repository instance is zeroed out when it is created, that's a 
reasonable requirement but we should probably document it as our other 
data structures tend not to require that they're zeroed out before they 
are initialized. For example

	struct strbuf buf;
	strbuf_init(&buf, 0);

is perfectly fine as strbuf_init() does not assume the instance passed 
to it has been zeroed out.

As we only support retrieving values from "the_repository" at the moment 
we should perhaps add

	if (repo != the_repository)
		BUG("trying to read config from wrong repository instance");

Everything else looks fine to me

Thanks

Phillip

> +	return &repo->config_values_private_;
> +}
> +
>   void initialize_repository(struct repository *repo)
>   {
> +	if (repo->initialized)
> +		BUG("repository initialized already");
> +	repo->initialized = true;
> +
>   	repo->remote_state = remote_state_new();
>   	repo->parsed_objects = parsed_object_pool_new(repo);
>   	ALLOC_ARRAY(repo->index, 1);
>   	index_state_init(repo->index, repo);
>   	repo->check_deprecated_config = true;
> +	repo_config_values_init(repo_config_values(repo));
>   
>   	/*
>   	 * When a command runs inside a repository, it learns what
> diff --git a/repository.h b/repository.h
> index 6063c4b846..9717e45000 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -3,6 +3,7 @@
>   
>   #include "strmap.h"
>   #include "repo-settings.h"
> +#include "environment.h"
>   
>   struct config_set;
>   struct git_hash_algo;
> @@ -148,6 +149,9 @@ struct repository {
>   	/* Repository's compatibility hash algorithm. */
>   	const struct git_hash_algo *compat_hash_algo;
>   
> +	/* Repository's config values parsed by git_default_config() */
> +	struct repo_config_values config_values_private_;
> +
>   	/* Repository's reference storage format, as serialized on disk. */
>   	enum ref_storage_format ref_storage_format;
>   
> @@ -171,6 +175,9 @@ struct repository {
>   
>   	/* Should repo_config() check for deprecated settings */
>   	bool check_deprecated_config;
> +
> +	/* Has this repository instance been initialized? */
> +	bool initialized;
>   };
>   
>   #ifdef USE_THE_REPOSITORY_VARIABLE

