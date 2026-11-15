Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794738829;
	b=wQL9aT4Pd4zI1eFEvSKPmRTepZRjZYzSg07lZabkpPzpzjEp1rFMDJ9Yj/8FxlhPEKvU
	 JlJ0Z0tG2vVxUOX78mFLoJ+EwKsGkljnjxvSV8ZiyD1krAvyhQsLbLUyclKO9lXgoZbR2
	 eUhXjo6Bihu0wyoYB3aVpd4QIsqt/pRdaukZaKLFZEddLKOwkJdhfFQNGIGHZ3zduZlkR
	 S3tMw+3QhS5yyQtNPLWeBkIKROn3QLLiK6/HmNhVAN9Vg7UmrPUXvuc7xwaIAP6U6MYjC
	 STfdPnQigjTmchfsQIn5ZXxHdY1b2e+5TvHwV8nNOdz/HNPBAvZFgP4fxzDDedQfxrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aEMW0Ed3CibDuRClgboU1KLuB5cd1y1I6iH0uh4XykI=;
	b=Q1KwmL8gLrL1jsXHqtIgkMQKk4eLwmx2SGAS+wO6rxAz/DI3LLdyc2s29XhT5OvPO2Nt
	 xzr+10xZnKBDJPHXRFOc7Z6lbzk/aUsbZZgdMh0Ar8WXgGoY1SZu5w19iv/jaZ8hEUIpc
	 v90KvYVNqk37Yf2jerwD4ZFHx99ZzJL8d3reQVBpKNQRgsVbKUkxQJ1nDFQ38Dy8k8YST
	 J9Kwm3vfS0ai5TSQ2r08WBW5Mo4rbTLdgZoPmOvly5vwMcjwxQ2FNDUrztX+fByZLe12+
	 ms4ba9OoVUy/LhvNG8RZk26rzKbmfKLiVwaBBFtm+6d8cOt/Qnx5Azf/JZ2SWJtG6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cP6L0p/P";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A4606A31F
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 10:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE1A4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP6L0p/P
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4922dbcee23so1108386f8f.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794738827; x=1795343627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEMW0Ed3CibDuRClgboU1KLuB5cd1y1I6iH0uh4XykI=;
        b=cP6L0p/P6OgWCwS65xdcquBL6aVoKlcZE+bdu/ll3EoZ4sOEZEZ0YTev1kxN0I4som
         KMeSrJa4HjglUnt745nCLrI7QZDjw/MbHVbQZEx0UO8bVzYdLqQemJwhCjZJ3UqbM4W5
         1cHXxVFY06NzT0USKl1y8+x+Jy3kQGG0yiHBJ7CyPRM8n4dwJl9SCZz5pe9oYfKRmpyT
         CfFWbovq3QJB6f3qnbGcRd30pynU7Cb2zx9p29h+hCJKmR4DTqfc+E1v+Q1vxEehNoQd
         5/x9CrqTKfyxawmcBLAwQULJMEVThA6FPbET6qXeE8CAcDWJpyHt2v8TTGVY37FnQJg9
         LpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794738827; x=1795343627;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEMW0Ed3CibDuRClgboU1KLuB5cd1y1I6iH0uh4XykI=;
        b=mjrK+4DTqSd5G+8eYDUUlfCB35bxaHKz1pGSCDHAhPS/C4B+aesQ4LycJFbOUFDCfU
         fH+sSwVgueWTk8odXuECHwzMDrmFk27i8A3kr6PPRF/0YJvAH2QmVaDj8HMo6V4VAfEf
         BG5P5Xs6XPw3gzPRzsoZLO0Tb5/L3UEgkNhH7y+9Y01KEUXYmvwGGq2X+WRj4O3Jfic9
         iBh+4hQB3G+UtAW66WnTUCKfwAe3QhuOmCAxRcO7+Ki52m0/EOKHvVPcOAtg8o6C6WK1
         JqPfHpJtYCZ/B1+S1EEHsT4RvEMxU51A3MsUJB2aPN+TDAxLTBBzpEGfFKRsJdD3Ag5y
         T6jg==
X-Gm-Message-State: APuU4Z93ZGRtz2N0HJImYn0ZqmXKZlB8tGdIpuIp2Cr+B7Grx+Xw/s8F
	l9GmWhpYhs1kTj6QuOezk3+Buxg5pvOj+vgYMk8JE/OciqAW8lK5uGkR0Ujfbw==
X-Gm-Gg: AYBFou2F3SBB1Tnfe9HvwfDETC35GBcwBa116Auu6KnuGZN2Kxr8d4FZ+zcFj9RuLQK
	UuRR1wHamUTu87/a3/no6mNpeisLLGZ/QlOSmPnAwFsPEYJ2t/Ow4aI1LzKsvMYTpptjnlLmUnS
	Xtme49iTja8mCyW8YmFFDadgUhHw/h0MfSQeeMsjP3CceFvUyXf0/ut5dN+d+3yo5c69Aqg2G15
	46xwys9nawHzeDHA2hh6JIWcuBD08FKOgS2Hag1YKnGvDBK1dzkKlltGPq5DCnTMm/WbwCxOv69
	89WtouLc7yxXKxNXPJepgllQ448ArL7KylY0VE9N2MWb7pPjyGLz9ghXVuYoeGAvOqjZcBOXzAL
	zQxBsfS7675nFzhtKRgAqS+QCRFfEvqBkMk02o4kYDBXKFvJYnrk2jkLt7Emlu1STWMiruxUjcv
	TehyOvq3IYl17mXmVsl/3ixHq9vvd8xhMfNj0kckalcewiqJqW86apBxMVx+KNMIvtlyXrcSy24
	lEtomm8zHHrZeWGko4fhuh5i6+PT4GhBs9su4HObwSUVFnk4nUPBGNxxOrKDript7ybM3s4+YBh
	OvMAegJM57kvfq2nxQYeEwzioJXf8aE1ryO7I/rBjT+oDBCLxjsYn/IpIkHrINPWs1KvrIZVANR
	pJbA8eF4W6eaE1fTb+EtgSTvchyE+
X-Received: by 2002:a05:6000:4a06:b0:490:6327:96ba with SMTP id ffacd0b85a97d-49c7363113dmr13057448f8f.47.1794738826881;
        Sun, 15 Nov 2026 02:33:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm15256567f8f.9.2026.11.15.02.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 02:33:46 -0800 (PST)
Message-ID: <89511e61-4646-45df-b5ac-b52c9424072e@gmail.com>
Date: Sun, 15 Nov 2026 10:33:45 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v9 0/5] repo: add path keys to repo info
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi K Jayatheerth

On 14/11/2026 16:37, K Jayatheerth wrote:
> 
> Changes since v8:
>    - Dropped `path.hooks` and `path.cdup`.
>    - Renamed `path.toplevel.*` to `path.workingtree.*` to align with the
>      standard "working tree" glossary term while avoiding hyphens in
>      configuration variable names.
>    - Renamed `path.superproject-root.*` to `path.superprojectworkingtree.*`
>      to provide a descriptive name for scripts while avoiding hyphens.
>    - Renamed `path.git-prefix` to `path.prefix` to shorten it and avoid
>      hyphens.

The range-diff looks good. It is a shame we're still creating a new 
repository for each test when the majority of the tests could happily 
run in the repository that the test framework creates for us. No one 
else seems to mind that, even though it makes our test suite slower than 
it needs to be, so I'd be happy if this is merged as-is.

Thanks

Phillip
> Range-diff against v8:
> 1:  27b9811163 ! 1:  6cb242828b repo: add path.toplevel with absolute and relative suffix formatting
>      @@ Metadata
>       Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>       
>        ## Commit message ##
>      -    repo: add path.toplevel with absolute and relative suffix formatting
>      +    repo: add path.workingtree with absolute and relative suffix formatting
>       
>           Scripts frequently need to find the root directory of a repository's
>           working tree. Currently, this requires using `git rev-parse --show-toplevel`
>           or inferring it from other repository information.
>       
>      -    Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
>      +    Introduce `path.workingtree.absolute` and `path.workingtree.relative` keys
>           to `git repo info`. This allows scripts to retrieve the top-level
>           working tree path in a predictable, strictly formatted manner without
>           relying on `rev-parse`.
>      @@ Documentation/git-repo.adoc: values that they return:
>        `path.gitdir.relative`::
>        	The path to the Git repository directory relative to the current working directory.
>        
>      -+`path.toplevel.absolute`::
>      ++`path.workingtree.absolute`::
>       +	The canonical absolute path to the top-level directory of the
>       +	repository's working tree. Outputs an empty string if the repository
>       +	is bare.
>       +
>      -+`path.toplevel.relative`::
>      ++`path.workingtree.relative`::
>       +	The path to the top-level directory of the repository's working
>       +	tree relative to the current working directory. Outputs an empty
>       +	string if the repository is bare.
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>        	return 0;
>        }
>        
>      -+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
>       +{
>       +	const char *work_tree = repo_get_work_tree(repo);
>       +
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +	return 0;
>       +}
>       +
>      -+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_workingtree_relative(struct repository *repo, struct strbuf *buf)
>       +{
>       +	const char *work_tree = repo_get_work_tree(repo);
>       +
>      @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>        	{ "path.commondir.relative", get_path_commondir_relative },
>        	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>        	{ "path.gitdir.relative", get_path_gitdir_relative },
>      -+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>      -+	{ "path.toplevel.relative", get_path_toplevel_relative },
>      ++	{ "path.workingtree.absolute", get_path_workingtree_absolute },
>      ++	{ "path.workingtree.relative", get_path_workingtree_relative },
>        	{ "references.format", get_references_format },
>        };
>        
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
>        	'.git' \
>        	'GIT_DIR="../.git" && export GIT_DIR'
>        
>      -+test_expect_success 'path.toplevel absolute and relative' '
>      ++test_expect_success 'path.workingtree absolute and relative' '
>       +	test_when_finished "rm -rf repo" &&
>       +	git init repo &&
>       +	(
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
>       +
>       +		ROOT="$(test-tool path-utils real_path ..)" &&
>       +
>      -+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
>      -+		git repo info path.toplevel.absolute >actual.abs &&
>      ++		echo "path.workingtree.absolute=$ROOT" >expect.abs &&
>      ++		git repo info path.workingtree.absolute >actual.abs &&
>       +		test_cmp expect.abs actual.abs &&
>       +
>      -+		echo "path.toplevel.relative=../" >expect.rel &&
>      -+		git repo info path.toplevel.relative >actual.rel &&
>      ++		echo "path.workingtree.relative=../" >expect.rel &&
>      ++		git repo info path.workingtree.relative >actual.rel &&
>       +		test_cmp expect.rel actual.rel
>       +	)
>       +'
>       +
>      -+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
>      ++test_expect_success 'path.workingtree absolute and relative in a bare repository' '
>       +	test_when_finished "rm -rf bare.git" &&
>       +	git init --bare bare.git &&
>       +	(
>       +		cd bare.git &&
>       +
>      -+		echo "path.toplevel.absolute=" >expect.abs &&
>      -+		git repo info path.toplevel.absolute >actual.abs &&
>      ++		echo "path.workingtree.absolute=" >expect.abs &&
>      ++		git repo info path.workingtree.absolute >actual.abs &&
>       +		test_cmp expect.abs actual.abs &&
>       +
>      -+		echo "path.toplevel.relative=" >expect.rel &&
>      -+		git repo info path.toplevel.relative >actual.rel &&
>      ++		echo "path.workingtree.relative=" >expect.rel &&
>      ++		git repo info path.workingtree.relative >actual.rel &&
>       +		test_cmp expect.rel actual.rel
>       +	)
>       +'
> 2:  2274dd8be2 = 2:  9da5ce8a69 submodule: use repository to find superproject
> 3:  34c54cdafd ! 3:  deaf3ae42e repo: add path.superproject-root with absolute and relative suffixes
>      @@ Metadata
>       Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>       
>        ## Commit message ##
>      -    repo: add path.superproject-root with absolute and relative suffixes
>      +    repo: add path.superprojectworkingtree with absolute and relative suffixes
>       
>           Scripts working in multi-repository setups often need to identify the
>           top-level working tree of a superproject from within a submodule.
>           Currently, this is only exposed via `git rev-parse
>           --show-superproject-working-tree`.
>       
>      -    Introduce `path.superproject-root.absolute` and
>      -    `path.superproject-root.relative` keys to `git repo info`.
>      +    Introduce `path.superprojectworkingtree.absolute` and
>      +    `path.superprojectworkingtree.relative` keys to `git repo info`.
>           This exposes the core submodule context via a scriptable config-like key
>           using standard format rules.
>       
>      @@ Documentation/git-repo.adoc: values that they return:
>        `path.gitdir.relative`::
>        	The path to the Git repository directory relative to the current working directory.
>        
>      -+`path.superproject-root.absolute`::
>      ++`path.superprojectworkingtree.absolute`::
>       +	The canonical absolute path to the working tree root of the superproject
>       +	if the current repository is an initialized submodule. Outputs an empty
>       +	string if not in a submodule.
>       +
>      -+`path.superproject-root.relative`::
>      ++`path.superprojectworkingtree.relative`::
>       +	The path to the working tree root of the superproject relative to the
>       +	current working directory if the current repository is an initialized
>       +	submodule. Outputs an empty string if not in a submodule.
>       +
>      - `path.toplevel.absolute`::
>      + `path.workingtree.absolute`::
>        	The canonical absolute path to the top-level directory of the
>        	repository's working tree. Outputs an empty string if the repository
>       
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>        	return 0;
>        }
>        
>      -+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
>       +{
>       +	struct strbuf superproject = STRBUF_INIT;
>       +
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +	return 0;
>       +}
>       +
>      -+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_superprojectworkingtree_relative(struct repository *repo, struct strbuf *buf)
>       +{
>       +	struct strbuf superproject = STRBUF_INIT;
>       +
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +	return 0;
>       +}
>       +
>      - static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
>      + static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
>        {
>        	const char *work_tree = repo_get_work_tree(repo);
>       @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>        	{ "path.commondir.relative", get_path_commondir_relative },
>        	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>        	{ "path.gitdir.relative", get_path_gitdir_relative },
>      -+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
>      -+	{ "path.superproject-root.relative", get_path_superproject_relative },
>      - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>      - 	{ "path.toplevel.relative", get_path_toplevel_relative },
>      ++	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
>      ++	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
>      + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
>      + 	{ "path.workingtree.relative", get_path_workingtree_relative },
>        	{ "references.format", get_references_format },
>       
>        ## t/t1900-repo-info.sh ##
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
>        	'.git' \
>        	'GIT_DIR="../.git" && export GIT_DIR'
>        
>      -+test_expect_success 'path.superproject-root absolute and relative' '
>      ++test_expect_success 'path.superprojectworkingtree absolute and relative' '
>       +	test_when_finished "rm -rf sub super" &&
>       +	git init sub &&
>       +	test_commit -C sub initial &&
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
>       +		cd sub &&
>       +		ROOT="$(test-tool path-utils real_path ..)" &&
>       +
>      -+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
>      -+		git repo info path.superproject-root.absolute >actual.abs &&
>      ++		echo "path.superprojectworkingtree.absolute=$ROOT" >expect.abs &&
>      ++		git repo info path.superprojectworkingtree.absolute >actual.abs &&
>       +		test_cmp expect.abs actual.abs &&
>       +
>      -+		echo "path.superproject-root.relative=../" >expect.rel &&
>      -+		git repo info path.superproject-root.relative >actual.rel &&
>      ++		echo "path.superprojectworkingtree.relative=../" >expect.rel &&
>      ++		git repo info path.superprojectworkingtree.relative >actual.rel &&
>       +		test_cmp expect.rel actual.rel
>       +	)
>       +'
>       +
>      -+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
>      ++test_expect_success 'path.superprojectworkingtree returns empty when not in a submodule' '
>       +	test_when_finished "rm -rf repo" &&
>       +	git init repo &&
>       +	(
>       +		cd repo &&
>       +
>      -+		echo "path.superproject-root.absolute=" >expect.abs &&
>      -+		git repo info path.superproject-root.absolute >actual.abs &&
>      ++		echo "path.superprojectworkingtree.absolute=" >expect.abs &&
>      ++		git repo info path.superprojectworkingtree.absolute >actual.abs &&
>       +		test_cmp expect.abs actual.abs &&
>       +
>      -+		echo "path.superproject-root.relative=" >expect.rel &&
>      -+		git repo info path.superproject-root.relative >actual.rel &&
>      ++		echo "path.superprojectworkingtree.relative=" >expect.rel &&
>      ++		git repo info path.superprojectworkingtree.relative >actual.rel &&
>       +		test_cmp expect.rel actual.rel
>       +	)
>       +'
>       +
>      - test_expect_success 'path.toplevel absolute and relative' '
>      + test_expect_success 'path.workingtree absolute and relative' '
>        	test_when_finished "rm -rf repo" &&
>        	git init repo &&
> 4:  985403c7b3 < -:  ---------- repo: add path.hooks with absolute and relative suffixes
> 5:  486836ae52 ! 4:  de9e189714 repo: add path.index with absolute and relative suffixes
>      @@ Commit message
>       
>        ## Documentation/git-repo.adoc ##
>       @@ Documentation/git-repo.adoc: values that they return:
>      - 	working directory. Respects the `core.hooksPath` configuration. If
>      - 	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
>      + `path.gitdir.relative`::
>      + 	The path to the Git repository directory relative to the current working directory.
>        
>       +`path.index.absolute`::
>       +	The canonical absolute path to the repository's current index file.
>      @@ Documentation/git-repo.adoc: values that they return:
>       +	Returns the configured index path even if the repository is bare or the
>       +	file does not exist.
>       +
>      - `path.superproject-root.absolute`::
>      + `path.superprojectworkingtree.absolute`::
>        	The canonical absolute path to the working tree root of the superproject
>        	if the current repository is an initialized submodule. Outputs an empty
>       
>        ## builtin/repo.c ##
>      -@@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
>      +@@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
>        	return 0;
>        }
>        
>      @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, stru
>       +	return 0;
>       +}
>       +
>      - static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
>      + static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
>        {
>        	struct strbuf superproject = STRBUF_INIT;
>       @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>      + 	{ "path.commondir.relative", get_path_commondir_relative },
>      + 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>        	{ "path.gitdir.relative", get_path_gitdir_relative },
>      - 	{ "path.hooks.absolute", get_path_hooks_absolute },
>      - 	{ "path.hooks.relative", get_path_hooks_relative },
>       +	{ "path.index.absolute", get_path_index_absolute },
>       +	{ "path.index.relative", get_path_index_relative },
>      - 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
>      - 	{ "path.superproject-root.relative", get_path_superproject_relative },
>      - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>      + 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
>      + 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
>      + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
>       
>        ## t/t1900-repo-info.sh ##
>      -@@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null' '
>      - 	)
>      - '
>      +@@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>      + 	'.git' \
>      + 	'GIT_DIR="../.git" && export GIT_DIR'
>        
>       +test_repo_info_path 'index standard' 'index' '.git/index'
>       +
>      @@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null'
>       +	)
>       +'
>       +
>      - test_expect_success 'path.superproject-root absolute and relative' '
>      + test_expect_success 'path.superprojectworkingtree absolute and relative' '
>        	test_when_finished "rm -rf sub super" &&
>        	git init sub &&
> 6:  91a8dc3ab1 < -:  ---------- repo: add path.git-prefix
> 7:  84a9fb4060 ! 5:  97035f59f4 repo: add path.cdup
>      @@ Metadata
>       Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>       
>        ## Commit message ##
>      -    repo: add path.cdup
>      +    repo: add path.prefix
>       
>      -    Scripts sometimes need the relative path from the current working
>      -    directory to the repository's working tree root (cdup). While this
>      -    information can be retrieved through `git rev-parse --show-cdup`,
>      -    `git repo info` does not currently expose it as a scriptable key.
>      +    Scripts sometimes need the path from the repository's working tree root
>      +    to the current working directory. While this information can be derived
>      +    through existing Git commands, `git repo info` does not currently expose
>      +    it as a scriptable key.
>       
>      -    Introduce the `path.cdup` key to `git repo info`. The key returns the
>      -    path from the current working directory to the root of the working tree,
>      +    Introduce the `path.prefix` key to `git repo info`. The key returns
>      +    the path from the working tree root to the current working directory,
>           returning the empty string when invoked from the working tree root.
>       
>           Mentored-by: Justin Tobler <jltobler@gmail.com>
>      @@ Commit message
>       
>        ## Documentation/git-repo.adoc ##
>       @@ Documentation/git-repo.adoc: values that they return:
>      - `object.format`::
>      - 	The object format (hash algorithm) used in the repository.
>      + 	Returns the configured index path even if the repository is bare or the
>      + 	file does not exist.
>        
>      -+`path.cdup`::
>      -+	When the command is invoked from a subdirectory, show the
>      -+	path of the top-level directory relative to the current
>      -+	directory (typically a sequence of "../", or an empty string).
>      ++`path.prefix`::
>      ++	The path from the root of the working tree to the current working
>      ++	directory. Returns the empty string when the current working directory
>      ++	is the root of the working tree.
>       +
>      - `path.commondir.absolute`::
>      - 	The canonical absolute path to the Git repository's common
>      - 	directory (the shared `.git` directory containing objects,
>      + `path.superprojectworkingtree.absolute`::
>      + 	The canonical absolute path to the working tree root of the superproject
>      + 	if the current repository is an initialized submodule. Outputs an empty
>       
>        ## builtin/repo.c ##
>      -@@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
>      +@@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
>        	return 0;
>        }
>        
>      -+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_prefix(struct repository *repo, struct strbuf *buf)
>       +{
>      -+	const char *pfx = repo->prefix;
>      -+
>      -+	if (!is_inside_work_tree(repo)) {
>      -+		const char *worktree = repo_get_work_tree(repo);
>      -+
>      -+		if (worktree)
>      -+			strbuf_addstr(buf, worktree);
>      -+		return 0;
>      -+	}
>      -+
>      -+	while (pfx) {
>      -+		pfx = strchr(pfx, '/');
>      -+		if (pfx) {
>      -+			pfx++;
>      -+			strbuf_addstr(buf, "../");
>      -+		}
>      -+	}
>      ++	/*
>      ++	 * repo->prefix is NULL when the current working directory is
>      ++	 * the worktree root.
>      ++	 */
>      ++	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
>       +	return 0;
>       +}
>       +
>      - static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
>      + static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
>        {
>      - 	const char *common_dir = repo_get_common_dir(repo);
>      + 	const char *git_dir = repo_get_git_dir(repo);
>       @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>      - 	{ "layout.bare", get_layout_bare },
>      - 	{ "layout.shallow", get_layout_shallow },
>      - 	{ "object.format", get_object_format },
>      -+	{ "path.cdup", get_path_cdup },
>      - 	{ "path.commondir.absolute", get_path_commondir_absolute },
>      - 	{ "path.commondir.relative", get_path_commondir_relative },
>      - 	{ "path.git-prefix", get_path_git_prefix },
>      + 	{ "path.gitdir.relative", get_path_gitdir_relative },
>      + 	{ "path.index.absolute", get_path_index_absolute },
>      + 	{ "path.index.relative", get_path_index_relative },
>      ++	{ "path.prefix", get_path_prefix },
>      + 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
>      + 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
>      + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
>       
>        ## t/t1900-repo-info.sh ##
>       @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
>        	'.git' \
>        	'GIT_DIR="../.git" && export GIT_DIR'
>        
>      -+test_expect_success 'path.cdup at repository root' '
>      ++test_expect_success 'path.prefix at repository root' '
>       +	test_when_finished "rm -rf repo" &&
>       +	git init repo &&
>       +	(
>       +		cd repo &&
>      -+		echo "path.cdup=" >expect &&
>      -+		git repo info path.cdup >actual &&
>      ++		echo "path.prefix=" >expect &&
>      ++		git repo info path.prefix >actual &&
>       +		test_cmp expect actual
>       +	)
>       +'
>       +
>      -+test_expect_success 'path.cdup in subdirectory' '
>      ++test_expect_success 'path.prefix in subdirectory' '
>       +	test_when_finished "rm -rf repo" &&
>       +	git init repo &&
>       +	mkdir -p repo/sub/dir &&
>       +	(
>       +		cd repo/sub/dir &&
>      -+		echo "path.cdup=../../" >expect &&
>      -+		git repo info path.cdup >actual &&
>      ++		echo "path.prefix=sub/dir/" >expect &&
>      ++		git repo info path.prefix >actual &&
>       +		test_cmp expect actual
>       +	)
>       +'
>       +
>      -+test_expect_success 'path.cdup cwd outside the working tree' '
>      -+	test_when_finished "rm -rf repo" &&
>      -+	mkdir -p repo/tmp/x &&
>      -+	(
>      -+		cd repo &&
>      -+		git init test &&
>      -+		echo "path.cdup=$(pwd)/tmp/x" >test/expect &&
>      -+		cd test &&
>      -+		GIT_WORK_TREE=../tmp/x &&
>      -+		export GIT_WORK_TREE &&
>      -+		GIT_DIR=$(pwd)/.git &&
>      -+		export GIT_DIR &&
>      -+		git repo info path.cdup >actual &&
>      -+		test_cmp expect actual
>      -+	)
>      -+'
>      -+
>      - test_expect_success 'path.git-prefix at repository root' '
>      - 	test_when_finished "rm -rf repo" &&
>      - 	git init repo &&
>      + test_repo_info_path 'gitdir standard' 'gitdir' '.git'
>      +
>      + test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \

