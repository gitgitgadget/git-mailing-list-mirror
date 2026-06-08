Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBE38D3FD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944642; cv=none; b=Mh4WVVYNFn5L6+GlT+kYrqIlWFo+FoaS2HTR8LFdo6xsmJyGjCa30ce6/Yeugwkldfh8X2gqwaZbL1JkeQiHw5XP0GtBiNzPhFny3oOMP7hjkVU2mLsdAljWJif8Va+4gpq7PY3RY7HnbxiS7CjfjanIlQLkBZC6d6qJsIwBpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944642; c=relaxed/simple;
	bh=kbOLJ3pSk1JjiNkRo9VYoxadubhBXBf9KRbB8gkEQsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLmy7SeAaayUsmgbnMp+fG6t6owAp8eFOsk3g/3OEJhQ6LiHjVfIkNu+XEzr44wRjiF59mMwyfwZZBvqQQOHZ1iBOQmrvHtS43E3enoJF7tiT7gTHWFEiNAnYVdfqH5MYPOhs6hJ08a61+85Q6q1Y4xLHi0evRHrzWwvl7zcQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABS/GION; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABS/GION"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6da33a561so3871542a34.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944640; x=1781549440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV73pIbL2IOKvA1UsmK00lo+lnqru9vaUSwJUSAQh6Q=;
        b=ABS/GIONnM4rTLVW/gt+Yb5ssPovIygjsl1GLcPxjWjv6+CyBLvC+qQfrEtVerevai
         99qwAWOkDx8Vn7lZvLRj4tV+2ENA86RfPvPP1S4JG6FP/WdAgfjQlyCNl2Q86q09bFev
         aQHbHmz+aSEBHheeSQHkre21z8ofbxlPEW4GF/Y04t05wMN+fEHsToOtTk2OeYxNPSEr
         jqVOzX2pWXdfQdEDUAa/DtajWxYuYmjCfWxHzcF+PiEYQI/V8VQGWabGBpiq+Z2h8gKF
         0dBwJnnoCHc2ORRS2pOnVULFf4OYSDSk+KMlwztjUB7LUIWQxVK8IjBWrXG0taZsSQzD
         oHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944640; x=1781549440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cV73pIbL2IOKvA1UsmK00lo+lnqru9vaUSwJUSAQh6Q=;
        b=W6c2mOZ+mmuqAfMS2rcRr3csOxa54B7XoarrXCM8HYwEJWPr7VoSpguTLjdZqXMOeV
         rTpcR7/QQmuck9C8ZobKoPyGwtj6qGdo5uUMqfC+9MDLGGworEyXxXnLfPL8OLy+9EH9
         Tn3p5Rr03qdXpmV9+N50ok+XOG0B6q2aAMn549vvYkXIg5jaLoUN8LuD55PLj7nS60u1
         c7NBg0CNASSZmucypJkEmIvOsUt3adfiQdghamP58H2REMdFSiGKUn2UwVu343w8k09h
         OHIOTHOU6UDv0E7f9r4lHhkxfPW6ZpLf8hQ3y/iZfBI6xVLPyggJMsc8rwZqrRfuKY6b
         h1bg==
X-Gm-Message-State: AOJu0YxE2iZnNzxZq1Awv7Q8+3KROZlwwc816Ea00qTpQQjYuvkmawiy
	pauzJ0XPb+EfSmvPQdGmmk6FNeEZUcNvWjva7HgifxSDsEa28i4Osd1C
X-Gm-Gg: Acq92OE7o8FmexePFZCCWAP0IerE82D2lTs5OrBck78153FJyhBIztz7zY7tnwgUAND
	W14eQnVi5bFDpMnxr0dTTz3mTJj3yawycuCjKlCqXq09nfginvz3MEqwhQPlW9IZ3D2oBm1NR66
	Qdduf9wJ30Mv4N+z4da2TfWtTuIj23Vq5xz8ngAh8vdl6gr4oDDAOMyNpjg/y4EHTlQBf/IJsdy
	8ldQuTt3b8yUfQ8mkGEYU/u8cIMn5ehVrYVC5eTJq4wuV5UC+Pp6J1I9/CLiWmYlZjhWP8EcILA
	2kxCHF+OgeQyFJBhr9pRb/dm5l9Eh0nvG9UNzK3GvBAQRcPwcsHqtiUoefrZAo3lRN4jfDRC/pT
	3WLne0A5qhiB8WNAWznBGvaH6VqqXGSoQ9D4CA0LLYhFpLZ563WniGvBf9Lk+pf8ag5bqE0fvdR
	tm8gE7dkfnneiOHNM48By/hCrmzos=
X-Received: by 2002:a05:6830:82c9:b0:7e6:e114:899b with SMTP id 46e09a7af769-7e70ca0bdf6mr10066880a34.21.1780944639719;
        Mon, 08 Jun 2026 11:50:39 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e796c675sm12865330a34.24.2026.06.08.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:50:39 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:50:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Subject: Re: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
Message-ID: <aicDOlJdUrgMi3sA@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>

On 26/06/05 10:00PM, K Jayatheerth wrote:
> Scripts often need to locate the `.git` directory. While `git rev-parse`
> provides this, it relies on command-line flags to dictate path formatting.
> 
> Introduce `path.gitdir.absolute` and `path.gitdir.relative` keys to
> `git repo info`. Exposing separate format-specific keys instead of a base
> `path.gitdir` key avoids default fallbacks and requires callers to state
> their format requirements explicitly. Both keys use `format_path()` to
> resolve paths.

Makes sense.

> To test these keys, introduce the `test_repo_info_path` helper in
> `t/t1900-repo-info.sh`. The helper evaluates paths dynamically and accepts
> environment variable prefixes. This prepares the test suite for future path
> keys that depend on environment overrides, such as `commondir`.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  6 ++++++
>  builtin/repo.c              | 26 ++++++++++++++++++++++++++
>  t/t1900-repo-info.sh        | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 42262c1983..a0dca7ce88 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -104,6 +104,12 @@ values that they return:
>  `object.format`::
>  	The object format (hash algorithm) used in the repository.
>  
> +`path.gitdir.absolute`::
> +	The canonical absolute path to the Git repository directory (the `.git` directory).
> +
> +`path.gitdir.relative`::
> +	The path to the Git repository directory relative to the current working directory.
> +
>  `references.format`::
>  	The reference storage format. The valid values are:
>  +
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 71a5c1c29c..6e97f6a0e4 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -7,12 +7,14 @@
>  #include "hex.h"
>  #include "odb.h"
>  #include "parse-options.h"
> +#include "path.h"
>  #include "path-walk.h"
>  #include "progress.h"
>  #include "quote.h"
>  #include "ref-filter.h"
>  #include "refs.h"
>  #include "revision.h"
> +#include "setup.h"
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "shallow.h"
> @@ -75,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
>  	return 0;
>  }
>  
> +static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *git_dir = repo_get_git_dir(repo);
> +
> +	if (!git_dir)
> +		return error(_("unable to get git directory"));
> +
> +	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);

For absolute paths, I don't think we actually need the prefix, but
providing it doesn't probably matter too much either way.

> +	return 0;
> +}
> +
> +static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *git_dir = repo_get_git_dir(repo);
> +
> +	if (!git_dir)
> +		return error(_("unable to get git directory"));
> +
> +	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
> +	return 0;
> +}

Looks good.

> +
>  static int get_references_format(struct repository *repo, struct strbuf *buf)
>  {
>  	strbuf_addstr(buf,
> @@ -87,6 +111,8 @@ static const struct repo_info_field repo_info_field[] = {
>  	{ "layout.bare", get_layout_bare },
>  	{ "layout.shallow", get_layout_shallow },
>  	{ "object.format", get_object_format },
> +	{ "path.gitdir.absolute", get_path_gitdir_absolute },
> +	{ "path.gitdir.relative", get_path_gitdir_relative },
>  	{ "references.format", get_references_format },
>  };
>  
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 39bb77dda0..0660b00bbc 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -155,4 +155,37 @@ test_expect_success 'git repo info -h shows only repo info usage' '
>  	test_grep ! "git repo structure" actual
>  '
>  
> +test_repo_info_path () {
> +	field_name=$1
> +	expect_absolute_eval=$2
> +	expect_relative=$3
> +	env_prefix=$4

nit: I was a bit uncertain regarding the purpose of env_prefix here.
Since the env_prefix is not used by any tests yet, I wonder if it we
should delay adding it until the next patch. If we want to reduce churn
though, I think we could also swap the order of patch 3 and 4.

> +
> +	test_expect_success "query individual key: path.$field_name.absolute${env_prefix:+ ($env_prefix)}" '
> +		(
> +			cd test-repo/sub &&
> +			expect_absolute=$(eval "$expect_absolute_eval") &&

Can we just compute `expect_absolute` prior to passing it instead of
using eval here?

> +			echo "path.$field_name.absolute=$expect_absolute" >expect &&
> +			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.absolute\"" >actual &&
> +			test_cmp expect actual
> +		)
> +	'
> +
> +	test_expect_success "query individual key: path.$field_name.relative${env_prefix:+ ($env_prefix)}" '
> +		(
> +			cd test-repo/sub &&
> +			echo "path.$field_name.relative=$expect_relative" >expect &&
> +			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.relative\"" >actual &&
> +			test_cmp expect actual
> +		)
> +	'
> +}
> +
> +test_expect_success 'setup test repository layout for path fields' '
> +	git init test-repo &&
> +	mkdir -p test-repo/sub
> +'
> +
> +test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'

hmmm, do we expect the path suffix to be the same between relative and
absolute paths for all test cases? If so, we could just have a single
`expect_path_suffix` argument and let the helper compute the appropriate
absolute and relative paths internally.

-Justin
