Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481243;
	b=4Z0vxP5NrOCx1rE4oAiDciLAJt8mPOU1CsYZRbG3HNtqPFAi7QeNEN54m7XcEgHylGi1
	 pSrRa/c9HG8PF7TuVw/FaiRz3/OKLp5sbyfFjvrMOz9EaWotJb8r7IzSRvfKOWGfHBQEr
	 dUnrMCTXw+g2oblLsqX2z1CJotiYSCjHP1zf0azF4Lk7pg7rpmqbFI7AHjQm9hx+aseBy
	 RAK9auVAJTcPEbMfZJ71DirvUGrQb9Nf2ify3oZbzJz1o8mIlNv9CaXE/+GA/2VMr8fHB
	 oEainqGlF0BrY89hnAdxLOmoggLUSNetd90SZpRaJ6dvYK3kRtaKV+EoIsTgkEJqPyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ol3jJERVY8UKVfJscawKsBBMBd2LdK8gfkAZPZDSy3g=;
	b=ClINzSCpDzpTkb8eBKb4QzxPMVue8IFm+IzFwypGtX1NU/lfMWAjIwK1XPzLDj7PXzFy
	 VTjx7MVs3EG62bHJo1KjSZ9sl7Kz04NxmGZAtxpViBhifMqJkbPrA8vR2LpHJ5/gI26hn
	 49E3OI5EiKZofLg1XNu4vYnrb3GHPLlBBizZ2aP4sMNfSkPyQo61wAtcUurVtTR4tnRth
	 bXH/P7oUUsSuvjpqoP14Inbd+82eHP13lcy7e+LmNFme5VavSFI0Ix1m5wxlDwxPy5/zX
	 9bJi7JyRIbkduan/x8UeSxxOYDImkm3W4/vnRGXVh6XIgCpk8pZt5cR0exao+GgRujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WE1SXtUt;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6B606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WE1SXtUt
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so645429566b.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794481241; x=1795086041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ol3jJERVY8UKVfJscawKsBBMBd2LdK8gfkAZPZDSy3g=;
        b=WE1SXtUtuKHw0qF6SGgDzPPr7gaGm8G2k4CZq4ul5LKztivs2eTfysbdT62MC3Geti
         RO3bqAP4c3EeN/6YKB/okdakuq5YOSNYx7riSlr28VyGgt0ZQIjaqmbd1adE8RdxBomi
         UdamibFtCl2sj+e5XbXJV2YSq1H9b9ujegver8hmTqb7Qg7vlwxo5XgP5jqd9O3GAkaL
         4ssbEJFvrlPGI39QauyzpU9x108v5BTcCo+eCNJ4VdKlrSwr15wlJtdnSEI8WxNVCs4X
         lWzrHVhepdagUivCFthaUhcbqI57cuXhd/0a8QTHUZwDtVxJg5c6kOShjJAS0GFiM9Hu
         ZWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481241; x=1795086041;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ol3jJERVY8UKVfJscawKsBBMBd2LdK8gfkAZPZDSy3g=;
        b=CHbzGzFJc8t7zHSiC/8m+9aOYnVWAKY0cJNJ/jrID92axhENxsYU5zqdGgkxvQIALi
         IoivKYxAyKuoJvMw1hHbyfjwemn8e8ThN6VFX8v5Afo83/b28p1IzeR944tox0t2y9UI
         9OHQD8XBogvm0FJY2GP1+5P9hrGP73tXyjZvLAk/YiT8ZQlX2J5DsFhrRCxWyuApMv7l
         OG7/uaYo2CQZKPEFctNwftEkSVaK7iVXstF42DcEuqa0poAuN5GTBpyzpWw11pDFfg0f
         wTqtaK9DBoPlyuJzDS2v7SpLeeC1RZphL6x1+chDpnSF0F7T1zlpRhx7s1zVj/Jb/tdm
         HaDQ==
X-Forwarded-Encrypted: i=1; AL+hErEDe6/kQ1ZZhHb696uWnOwkOlq2FE6drSuyZ/92h4sZbJ4LjFX4688CuqsFge2y4vl9pfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/+uTAClpUs3Imzc3oRbCyVEj2wFFoOxNb12z8MBtloorLWAnP
	jWMQX3HPWM3QyZy/UxMzcdkYE4VWPkdUrPt4sMOmzXCEYqy0LH61DxV6
X-Gm-Gg: AYBFou3QQs9LBl8im+cliJAejKQruD7e46hGgi5rK4wkef4m8soeC0zESljb3jD3mnj
	tyevoSfoUTZe5wDJfSgsFaV0BnsnMUc/MaAvkUNCN0GibGTwnEEk3oYyCjilrHwOUY/dYD7+KK6
	Pdzrx4mpEDepn1yOdx4rSmgYJoI7JLjYSZ5VnRUoSXVwNQa+Rtzew8RJrmwlAyiLmKAJeFSITs/
	S9+nGOGgUXesM40ykghazFRtfBlt5P7jyhR1Hx9fwqnfpJtAT20IV2jnpCTqbJrKYMWRnxrsv3c
	8UTDHBT3cpJG/lhz5igSAnJH4qmK01W3DZXnAPPwsrEpLgYAY1wazBp7UlmyJkL4fDIIpRNGG9R
	OZgnJ6EOKEiVBDIiqPOrJnaYL7ra+m8tq7m5LMCknLmkwtm/nV8y+LdpTMLEzUCqjrEsxc2qQEU
	GtXVmk07haRPG/Z3CyymGzFvN9uWeJjRbNYxbcdIHe9e5k9v1FZd6FtdLxz4z+Hml78BQHHyHLm
	GynqSovcMdDCLfrHOi3ueNlDA/kcN/KjgVZ6SspCYzdXI7a6Itlzdo+otMyNZxHjgh22SdCJfWc
	+GosqTXY2qdRL8laszsuhcU3ZVX6QfRYsSfYBJL7PS+eYRqT+bar+HqeTvGhEhbI71ZUS5VDxsM
	lHaJ20bE=
X-Received: by 2002:a17:907:f448:b0:c4d:31f7:28e6 with SMTP id a640c23a62f3a-c5066b1d853mr427091566b.29.1794481240595;
        Thu, 12 Nov 2026 03:00:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a570875sm329280866b.19.2026.11.12.03.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:00:39 -0800 (PST)
Message-ID: <01a799bc-5493-4984-8b83-7f2aef698f85@gmail.com>
Date: Thu, 12 Nov 2026 11:00:37 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v13 1/6] fetch: add remote.<name>.fetchRefmap
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <07081828d1d65373bee4b2ef5e1916e65a217db6.1793357550.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <07081828d1d65373bee4b2ef5e1916e65a217db6.1793357550.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/10/2026 10:52, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a per-remote config variable, remote.<name>.fetchRefmap, that
> provides the default value for --refmap the same way
> remote.<name>.fetch already provides the default refspecs to fetch.
> 
> Unlike passing --refmap on the command line, which requires an
> explicit refspec to go with it, configuring remote.<name>.fetchRefmap
> on its own does not change what a refspec-less fetch does: it falls
> back to the same defaults as a remote with no fetchRefmap at all.
> 
> When remote.<name>.fetch is also configured, it still decides what to
> fetch, and the refmap maps what it fetches. This lets a remote name
> only a few branches and store them all through one refmap:
> 
>      [remote "cabal"]
>          fetch = master
>          fetch = next
>          fetch = seen
>          fetchRefmap = +refs/heads/*:refs/remotes/cabal/*

What happens if remote.cabal.fetch is a refspec and 
remote.cabal.fetchRefmap is set?

Thanks

Phillip

> Looking up the remote-tracking branch for a remote branch, as
> @{upstream} and "git branch --track" do, falls back to the refmap when
> remote.<name>.fetch has no match, so that these work for such
> branches too. A branch excluded by a negative refspec in
> remote.<name>.fetch stays excluded.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/config/remote.adoc |   7 ++
>   Documentation/fetch-options.adoc |   3 +
>   builtin/fetch.c                  |  16 +++-
>   remote.c                         |  20 +++-
>   remote.h                         |   6 ++
>   t/t5510-fetch.sh                 | 151 +++++++++++++++++++++++++++++++
>   6 files changed, 200 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 3a20d0f752..236ccca93e 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -33,6 +33,13 @@ remote.<name>.fetch::
>   	The default set of "refspec" for linkgit:git-fetch[1]. See
>   	linkgit:git-fetch[1].
>   
> +remote.<name>.fetchRefmap::
> +	The default value of the `--refmap` option, used to map refs being
> +	fetched to remote-tracking refs to store, the same way
> +	`remote.<name>.fetch` does for an explicit refspec.
> +	`remote.<name>.fetch`, if also configured, still decides what is
> +	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
> +
>   remote.<name>.push::
>   	The default set of "refspec" for linkgit:git-push[1]. See
>   	linkgit:git-push[1].
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 47dea1de8e..c2101a7b39 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -244,6 +244,9 @@ endif::git-pull[]
>   	refspecs and rely entirely on the refspecs supplied as
>   	command-line arguments. See section on "Configured Remote-tracking
>   	Branches" for details.
> ++
> +`remote.<name>.refmap` provides the default value for this option, the
> +same way `remote.<name>.fetch` provides the default refspecs to fetch.
>   
>   `-t`::
>   `--tags`::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 1f76ae6242..305934f5f4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -518,6 +518,12 @@ static struct ref *get_ref_map(struct remote *remote,
>   	struct ref *rm;
>   	struct ref *ref_map = NULL;
>   	struct ref **tail = &ref_map;
> +	/*
> +	 * The --refmap command line option, if given, takes precedence
> +	 * over remote.<name>.fetchRefmap.
> +	 */
> +	struct refspec *effective_refmap =
> +		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
>   
>   	/* opportunistically-updated references: */
>   	struct ref *orefs = NULL, **oref_tail = &orefs;
> @@ -528,6 +534,8 @@ static struct ref *get_ref_map(struct remote *remote,
>   	filter_prefetch_refspec(rs);
>   	if (remote)
>   		filter_prefetch_refspec(&remote->fetch);
> +	if (effective_refmap)
> +		filter_prefetch_refspec(effective_refmap);
>   
>   	if (rs->nr) {
>   		struct refspec *fetch_refspec;
> @@ -561,8 +569,8 @@ static struct ref *get_ref_map(struct remote *remote,
>   		 * by ref_remove_duplicates() in favor of one of these
>   		 * opportunistic entries with FETCH_HEAD_IGNORE.
>   		 */
> -		if (refmap.nr)
> -			fetch_refspec = &refmap;
> +		if (effective_refmap && effective_refmap->nr)
> +			fetch_refspec = effective_refmap;
>   		else
>   			fetch_refspec = &remote->fetch;
>   
> @@ -597,6 +605,10 @@ static struct ref *get_ref_map(struct remote *remote,
>   			if (has_merge &&
>   			    !strcmp(branch->remote_name, remote->name))
>   				add_merge_config(&ref_map, remote_refs, branch, &tail);
> +
> +			for (i = 0; i < remote->refmap.nr; i++)
> +				get_fetch_map(ref_map, &remote->refmap.items[i],
> +					      &oref_tail, 1);
>   		} else if (!prefetch) {
>   			ref_map = get_remote_ref(remote_refs, "HEAD");
>   			if (!ref_map)
> diff --git a/remote.c b/remote.c
> index 49ee2ea318..9acab2e01a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>   	ret->name = xstrndup(name, len);
>   	refspec_init_push(&ret->push, the_hash_algo);
>   	refspec_init_fetch(&ret->fetch, the_hash_algo);
> +	refspec_init_fetch(&ret->refmap, the_hash_algo);
>   	string_list_init_dup(&ret->server_options);
>   	string_list_init_dup(&ret->negotiation_restrict);
>   	string_list_init_dup(&ret->negotiation_include);
> @@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
>   
>   	refspec_clear(&remote->push);
>   	refspec_clear(&remote->fetch);
> +	refspec_clear(&remote->refmap);
>   
>   	free((char *)remote->receivepack);
>   	free((char *)remote->uploadpack);
> @@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
>   			return -1;
>   		refspec_append(&remote->fetch, v);
>   		free(v);
> +	} else if (!strcmp(subkey, "fetchrefmap")) {
> +		char *v;
> +		if (git_config_string(&v, key, value))
> +			return -1;
> +		refspec_append(&remote->refmap, v);
> +		free(v);
>   	} else if (!strcmp(subkey, "receivepack")) {
>   		char *v;
>   		if (git_config_string(&v, key, value))
> @@ -995,7 +1003,17 @@ void ref_push_report_free(struct ref_push_report *report)
>   
>   int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
>   {
> -	return refspec_find_match(&remote->fetch, refspec);
> +	char **result = refspec->src ? &refspec->dst : &refspec->src;
> +
> +	if (remote->fetch.nr && !refspec_find_match(&remote->fetch, refspec))
> +		return 0;
> +	if (refspec_find_match(&remote->refmap, refspec))
> +		return -1;
> +	if (refname_matches_negative_refspec_item(refspec->src, &remote->fetch)) {
> +		FREE_AND_NULL(*result);
> +		return -1;
> +	}
> +	return 0;
>   }
>   
>   static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
> diff --git a/remote.h b/remote.h
> index cca02033b9..ac485a584d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -90,6 +90,12 @@ struct remote {
>   
>   	struct refspec fetch;
>   
> +	/*
> +	 * How to map refs fetched without an explicit destination into our
> +	 * own namespace, the same as the --refmap command line option.
> +	 */
> +	struct refspec refmap;
> +
>   	/*
>   	 * The setting for whether to fetch tags (as a separate rule from the
>   	 * configured refspecs);
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 17c0be499c..b5eba020ad 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -927,6 +927,157 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
>   	)
>   '
>   
> +test_expect_success 'remote.*.fetchRefmap acts like --refmap on the command line' '
> +	test_when_finished "git -C three config --unset remote.origin.fetchRefmap" &&
> +	git branch -f side &&
> +	git -C three config remote.origin.fetchRefmap \
> +		"refs/heads/*:refs/remotes/other/*" &&
> +	(
> +		cd three &&
> +		git update-ref refs/remotes/origin/main base-origin-main &&
> +		o=$(git rev-parse --verify refs/remotes/origin/main) &&
> +		git fetch origin main &&
> +		n=$(git rev-parse --verify refs/remotes/origin/main) &&
> +		test "$o" = "$n" &&
> +		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
> +		git rev-parse --verify refs/remotes/other/main
> +	)
> +'
> +
> +check_fetched_refs () {
> +	git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
> +	cat >expect &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
> +	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
> +	git init -b main fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git -C fetch-refmap-upstream branch other &&
> +	git init fetch-refmap-baseline &&
> +	(
> +		cd fetch-refmap-baseline &&
> +		git remote add origin ../fetch-refmap-upstream &&
> +
> +		# Without fetch refspec, but with fetch refmap.
> +		git config --unset-all remote.origin.fetch &&
> +		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
> +
> +		# Nothing tracked, nothing fetched, no error.
> +		git fetch origin &&
> +		check_fetched_refs <<-\EOF &&
> +		EOF
> +
> +		# Nothing tracked, explicit ref on the command line.
> +		git fetch origin main &&
> +		check_fetched_refs <<-\EOF &&
> +		refs/remotes/origin/main
> +		EOF
> +
> +		# With both refmap and fetch configured, remote.<name>.fetch
> +		# wins: a refspec-less fetch follows it as usual, and
> +		# remote.<name>.fetchRefmap plays no part in deciding what to
> +		# fetch, only in mapping what is fetched.
> +		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
> +		git fetch origin &&
> +		check_fetched_refs <<-\EOF
> +		refs/remotes/origin/HEAD
> +		refs/remotes/origin/main
> +		refs/remotes/origin/other
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'remote.<name>.fetchRefmap stores branches named in remote.<name>.fetch' '
> +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
> +	git init -b master fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git -C fetch-refmap-upstream branch next &&
> +	git -C fetch-refmap-upstream branch seen &&
> +	git -C fetch-refmap-upstream branch other &&
> +	git init downstream &&
> +	(
> +		cd downstream &&
> +		git remote add cabal ../fetch-refmap-upstream &&
> +		git config --unset-all remote.cabal.fetch &&
> +		git config --add remote.cabal.fetch master &&
> +		git config --add remote.cabal.fetch next &&
> +		git config --add remote.cabal.fetch seen &&
> +		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
> +		git fetch cabal &&
> +		check_fetched_refs <<-\EOF &&
> +		refs/remotes/cabal/HEAD
> +		refs/remotes/cabal/master
> +		refs/remotes/cabal/next
> +		refs/remotes/cabal/seen
> +		EOF
> +		git branch --track topic cabal/next &&
> +		echo refs/remotes/cabal/next >expect &&
> +		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst remote.<name>.fetch entry in both places' '
> +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
> +	git init -b master fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git init downstream &&
> +	(
> +		cd downstream &&
> +		git remote add cabal ../fetch-refmap-upstream &&
> +		git config --unset-all remote.cabal.fetch &&
> +		git config --add remote.cabal.fetch \
> +			"+refs/heads/master:refs/remotes/custom/master" &&
> +		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
> +		git fetch cabal &&
> +		check_fetched_refs <<-\EOF
> +		refs/remotes/cabal/HEAD
> +		refs/remotes/cabal/master
> +		refs/remotes/custom/master
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
> +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
> +	git init -b main fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git -C fetch-refmap-upstream branch other &&
> +	git init downstream &&
> +	(
> +		cd downstream &&
> +		git remote add -t main origin ../fetch-refmap-upstream &&
> +		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
> +		git fetch origin other &&
> +		git branch --track topic origin/other &&
> +		test_cmp_config origin branch.topic.remote &&
> +		test_cmp_config refs/heads/other branch.topic.merge &&
> +		echo refs/remotes/origin/other >expect &&
> +		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'remote.<name>.fetchRefmap does not track a branch excluded by remote.<name>.fetch' '
> +	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
> +	git init -b main fetch-refmap-upstream &&
> +	test_commit -C fetch-refmap-upstream base &&
> +	git -C fetch-refmap-upstream branch secret &&
> +	git init downstream &&
> +	(
> +		cd downstream &&
> +		git remote add origin ../fetch-refmap-upstream &&
> +		git config --add remote.origin.fetch "^refs/heads/secret" &&
> +		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
> +		git fetch origin secret &&
> +		git rev-parse --verify refs/remotes/origin/secret &&
> +		test_must_fail git branch --track topic origin/secret 2>err &&
> +		test_grep "not a branch" err
> +	)
> +'
> +
>   test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
>   	git branch -f side &&
>   	(

