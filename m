Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FD80C02
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212699; cv=none; b=tFa7V0AhhDRVhzJ5x4fKWU9rmIhMyN1FAO5KWSwrQp1Hy9cTbirPKM3cnhsPmjLZfcldw/NnVbghDbu4VMtURsPIk1l1dqZ704Q0SxXTaE4iCSoNFOsBTPJFB3WmQ1GFw4vTT9tbfBzKTZi3DGcKNBshh+BRDAtx0EwuOl42aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212699; c=relaxed/simple;
	bh=s6RxSozvyfCXrd7XtN5bvp6S0WH9Q0GrlqtzafAlRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDCdDYej4gm738vibTRKIOS9PSI6d3pj5+R43z9Ifg5VNnu3PjK3o7bD1BukquFmmWAwekEqkB9k32Dh2uOgNcPqYmHmzdmuDWjObkuqndSvkzDm9pjXyQ+mhcOC//d29LabV9BmvpCwXbJaFyQzsXEFksjqTiIq68QtfcGxBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMJCvGuR; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMJCvGuR"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73e5792cb9dso1830624a34.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753212694; x=1753817494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCOXWCsq7YxM20X03TDJiz26qa2xYgJjqeaSzYe7QCM=;
        b=dMJCvGuRYOf8XIbTtLSC4HP4l3LwaupLY5NxgjRdDeHPm2iHsfYceJkETunXK+tPmd
         jXX+y7RcfmXtRL7YZr1T2dOE93Yk/7Ozist9vzUJP0aPePtXM1tGEaasu2HZR5csC3SB
         RUFyYIwme0ctir7NxV5o+qmIJf+Pao615Rhw4WcwKoHf9NK5kMw8ZxJ88o+5fkH7XF7e
         smJe4UHNN70B4muPplkY85PVlz/Vv0Z4XpgNt7GczzalARKzIB7MY6T812hWHKPzFAan
         mE4+ExCV0jyN7CDi1NBU7ZdYrnHAlidDMB3+MvM2gRGvoC1hfj099iROhume85oVN1bj
         oyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212694; x=1753817494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCOXWCsq7YxM20X03TDJiz26qa2xYgJjqeaSzYe7QCM=;
        b=r4BNRbe9JnXRvaZUX3vJ1gcCbGrca3veCqgN8TBpNf+p3dqilk8ob+50AAktO1UdvL
         U+RRDFfTAwxY5LvEwQsXurLyAr/xm+2tvJhT8Mu/M7Jt6YGoB7KnEW2uuhYIpb+Iz7bP
         vkoK4FdZ22xypYKxxblRKExeB7LP3Qs8tnza5LJBVckgBEFri/N7nFL/GxWbAbXiSK/C
         jMV0ymUAakrTdMKidGo4YD2YF9IG16kevcoSATHzrSr/4GLwbZ7PD7TIFzeKlDkbZ+0o
         +R1Jv46UcaEmzKr6NWCu9khvHSXUl4FjJIPOkK742UdQRLU1tEgcUsSr76no/wUaaD0r
         WB5Q==
X-Gm-Message-State: AOJu0YxGsj+w1n1P/S/6QFIcUbb4nreBMoDQuEH1vRsSROUyyc1ibzKk
	VL1AHDppL4tgeeQKYzhik26SmEzpzABYV4ASnlWm4OQQvSbV4QtXPxdR
X-Gm-Gg: ASbGncsAgM75OlS0keKAK5ePxrohFiHEH3fAxq/AntJo5h+TMuIF8maXCo1h7eECI46
	c3CNrVHm1a7+Bvg2yDNGiMxNIkL3SF8n75QwvZxGPn/yZXnFGj91do1gJ3f7rFlEZNEOYjj1iNG
	KDIUdBqjA4OD7xXMggW/6XNw7xYy3ceYXuZUz6H7WEPDzwKsg0JOXafwHy6cz1oTs7otiCY61Lz
	PuZ8QtHx+AuKiHJvng1qPvwg5Fqt5SZ53SMHPM3+nDSkTxo3jYUHzZZuxDBrNVSgoXN458cc9Za
	6I2WUlvoVw+HmG1GcPelWPNgAOEjwZn8vKMPSi3GWxESkF2I6ed48eawymhnO7l5gv8JQTBNKnk
	9MqIQ+D4/yz31TK4=
X-Google-Smtp-Source: AGHT+IE8Su0AlmF2v0x3+zM6q23yqMxLb02rMHebpODCbznlH9g9mWG2Yp9IL0V45kt7UM68YuO56Q==
X-Received: by 2002:a05:6830:348e:b0:73e:b9a3:699f with SMTP id 46e09a7af769-74080520e87mr314905a34.6.1753212694343;
        Tue, 22 Jul 2025 12:31:34 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e836262e5sm3747306a34.19.2025.07.22.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:31:33 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:25:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
Message-ID: <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722002835.33428-3-lucasseikioshiro@gmail.com>

On 25/07/21 09:28PM, Lucas Seiki Oshiro wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
> 
> The flag `--show-ref-format` from git-rev-parse is used for retrieving
> the reference format (i.e. `files` or `reftable`). This way, it is
> used for querying repository metadata, fitting in the purpose of
> git-repo-info.
> 
> Then, add a new field `references.format` to the repo-info subcommand
> containing that information.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  4 ++
>  builtin/repo.c              | 75 ++++++++++++++++++++++++++++++++++++-
>  t/meson.build               |  1 +
>  t/t1900-repo.sh             | 50 +++++++++++++++++++++++++
>  4 files changed, 128 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1900-repo.sh
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index caee7d8aef..cf8483ec49 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -29,6 +29,10 @@ INFO KEYS
>  The set of data that `git repo` can return is grouped into the following
>  categories:
>  
> +`references`::
> +Reference-related data:
> +* `format`: the reference storage format
> +
>  SEE ALSO
>  --------
>  linkgit:git-rev-parse[1]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index d4f01e35e2..5beae0f781 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,12 +1,83 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "refs.h"
>  
> -static int repo_info(int argc UNUSED, const char **argv UNUSED,
> -		     const char *prefix UNUSED, struct repository *repo UNUSED)
> +typedef const char *get_value_fn(struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	get_value_fn *add_field_callback;
> +};
> +
> +static const char *get_references_format(struct repository *repo)
> +{
> +	return ref_storage_format_to_name(repo->ref_storage_format);
> +}
> +
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] = {
> +	{ "references.format", get_references_format },
> +};

Ok, so each key has a corresponding callback that is used to get its
value. This works fine when we have one operation/callback per key, but
I could see this being a bit inflexible in cases where performing a
single operation could be expected to generate multiple keys worth of
information at a time.

I certainly see this being the case with git-repo-stats where, for
example, interating over references will produce multiple keyvalues
indicating the number of branches, tags, remotes, etc. But, maybe for
git-repo-info this will not be as much of a concern?

> +
> +static int repo_info_fields_cmp(const void *va, const void *vb)
> +{
> +	const struct field *a = va;
> +	const struct field *b = vb;
> +
> +	return strcmp(a->key, b->key);
> +}
> +
> +static get_value_fn *get_value_callback(const char *key)
>  {
> +	const struct field search_key = { key, NULL };
> +	const struct field *found = bsearch(&search_key, repo_info_fields,
> +					    ARRAY_SIZE(repo_info_fields),
> +					    sizeof(struct field),
> +					    repo_info_fields_cmp);
> +	return found ? found->add_field_callback : NULL;
> +}
> +
> +static int qsort_strcmp(const void *va, const void *vb)
> +{
> +	const char *a = *(const char **)va;
> +	const char *b = *(const char **)vb;
> +
> +	return strcmp(a, b);
> +}
> +
> +static int print_fields(int argc, const char **argv, struct repository *repo)
> +{
> +	const char *last = "";
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		get_value_fn *callback;
> +		const char *key = argv[i];
> +		const char *value;
> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		callback = get_value_callback(key);
> +
> +		if (!callback)
> +			return error("key %s not found", key);
> +
> +		value = callback(repo);
> +		printf("%s=%s\n", key, value);
> +		last = key;
> +	}

If the user does not input any keys, we simply do nothing. I do wonder
if this is really the best default behavior. Maybe instead we should
error out? Or maybe treat it as though all keys were requested?

-Justin

> +
>  	return 0;
>  }
>  
> +static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
> +		     struct repository *repo)
> +{
> +	return print_fields(argc - 1, argv + 1, repo);
> +}
> +
>  int cmd_repo(int argc, const char **argv, const char *prefix,
>  	     struct repository *repo)
>  {
