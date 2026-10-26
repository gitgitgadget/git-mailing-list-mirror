Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007880;
	b=TFTQiRKE/kNh0hXXANPIXRavu8k/nUwP5kXVfaHG/WFh9VnWpH9OEJISl/Mw53IQBm4/
	 EYKzM/3M8f9pEMDwFyJIj0XktKs0pipnbALOo+fdXiLwd+QziNwBA8yUD7UuN7DvnEzkO
	 8/pSpNmS510zBMMfpMpvtq4fWKrGcSzyMbuQjhUaQsuwmAmhxKllHM7Kgg+j8Nd9NHmYv
	 mpRHwfmhA9LI+rDZCnmdxlv0+onejCRm1qugNVv/fkVfx1oVdrsABtzcqB9Q5WM0EEnle
	 QojsiqMGS61y8YbePTEwANxpcCZYITYjSPJrjN+CP5J4DDkNRDDpPT198/mG3zwMtdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8rqR3HKL6vgeJvOs2C3lrLp+ZFVVE31LS0WJToADb5k=;
	b=U0Grb5tHEdVjcjNahRM0FiJdHhg2dQVwgiJpiVdmuHyzeGexGZv9c3bwUcs2R0KQNjvK
	 wXyRcU+TinkuEz3meLSUHUn8zi3opqc3sCzDmjYk8ufTTQxMQqwyai3Tv8ypNVhWDQxjQ
	 lWYTmQoiR6S7vcn224vAup0JyTxAHddvskRTNZVg0mM55Buahgx+z5YhPwr5Gp8PVlcay
	 JkX7RVhpBCPyENi1zoE5fejpO/jAIJk5VOJmorkhnY8axwwvqyiWmmejqJgcHY0bB0YG5
	 SqNdTR/pXqPAwqbIDgQv/4zCV2Dbqkif9gI1ilnNJkZSe3e+aQAI/c7nIy7t8wB9nxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fYjW7yUa;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24837606A320
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24837606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fYjW7yUa
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so8624705e9.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007878; x=1793612678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rqR3HKL6vgeJvOs2C3lrLp+ZFVVE31LS0WJToADb5k=;
        b=fYjW7yUafoVugk98Qwtksn8BT6eyDMpMFJsAwClmetex0RFrVMJtYfXC1PHk8p5ugg
         NPcNHxCKZgwYd6owgjrLRBbz2GhZkUnlmnLqxYVTsaE2s3Y0pyFlF0821dCKYZEee+24
         w64EEHahEY+TcChxnMRANg2ih1aY5Bermr6NN4gkwKMGh3IEegPinjzi6tx8YYXiaXce
         SesfHadUOsmn8uPmLeT9ZC11mwQN60eak4wdjKA/8rTEG1TdEeeXnXqPfcyHj+/n3R3w
         9bLIa6DeiNYjfkMKy1hnD98JyfWakAtQrRFgwnVHy+r8lpIrxx43Nx3njujZqx3Lu24W
         zVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007878; x=1793612678;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rqR3HKL6vgeJvOs2C3lrLp+ZFVVE31LS0WJToADb5k=;
        b=qG4JKQl7P7f5WKE+GgOuNzNAZc5zCA63+QRdBzk46dkjS7sPAPK/Y7owJDTt6Jo/H4
         8Jj7IKBmPnk4reNNmR7AjXbCkitkzhT1OWChx8m2PFh9Lc3ZQXsuovwM0Rw1v8X3AnCR
         7HZZYFQOkXBpTcMStRbkq20amVTwbMZrnE2soKw3vLAiLujA5QOeTzFuMqASe9/JUOOX
         JId/pvsBluKWUCZdYKfTMgsRRsy73MnKEP2YBy0mKNT/Z8XZbYd6MHyvbaXIwtIKSrGW
         0CG/wcYY2vHa/WzXE114Pg4DRDncljzplfM3rZuI26m3uYD1wXsqQ64F87HBgoLZ+CSt
         D5uw==
X-Forwarded-Encrypted: i=1; AKwUvBzd8hl1ZD2ik08tM9/MAEXNCqb687gI6t90DHxw+OQDFFN9K3Bkcx17+SXpB3daDgjCPcU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFh+nC2KCifrLEGOG8zb+q4Zmw3cdzad/ikEmdU3/JzvM+zAL/
	8jVTaH/GPLMm8MEODMtDm1Ow7NJv8+PBD+5PQUYUvJrLKH6havUqzlLS
X-Gm-Gg: AYBFou3I+Kn/MdfmpVkRPseBHL2rRfV4DVDuYMPVcIUTmZ0eMqhjLUVZQhlKN1w9qWJ
	XZdxQtXgmoOw4699S+JQkfB2c9iWX34q5j0b4zcc0sTS7ys0wSOrBFPkaGFUK+Lp9gafa2tmmc0
	xihnwyDY32/axb05f4btWSju709YyZkZWA7ANzj9o6P5DC+zNB5moU2fJwlEsRrCD8Wfk/2rxSO
	GXCW8dOF1X4a6rHEgssTyImdVQFO0wXQh6P86RUlud9Vf/r/fUhiNlrL+Nj+LfPA4Z7nmaVQvv9
	LqJCvVgDJMT+xiSS3tIiV5JJwEgQ2dbiFp5ec/FrJruFX565CRKANyQnAG+/Fw+5w6tfLtQWCdh
	JExwkh+3Z2SK4NSCkAtVP//EsGeTD9BH9leL16TmrnELFTszt8gkE4MR3US5e29D+8HoJXjbwTq
	VMj5Q2mh8FZXn7qM1GaUQBjk6jp/JdcLoq7hfUqxM2/dIP9sU2lDLRKvWe1FawdSeqVQzcKzEiJ
	WaK6jYfpPFK6iZbJVIJ3c+ajTq3dF8asbRs6ljQ7C3MbcxVaR5znVvjPJz/hdzocQ/GClOHL+1s
	ssqrLbVThT1MoSiHACcvhAze2Oy9ckFg8Q==
X-Received: by 2002:a05:600c:6749:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a35ad01261mr104924465e9.2.1793007878284;
        Mon, 26 Oct 2026 02:44:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm180462655e9.13.2026.10.26.02.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:44:37 -0700 (PDT)
Message-ID: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
Date: Mon, 26 Oct 2026 09:44:36 +0000
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
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 20/10/2026 14:42, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a per-remote config variable, remote.<name>.refmap, that provides
> the default value for --refmap the same way remote.<name>.fetch
> already provides the default refspecs to fetch.

The second half of this sentence seems redundant to me. Can we please 
call the new config setting "remote.<name>.fetchRefmap" so that it is 
clear it applies to fetches. That would also allow us to add a matching 
"remote.<name>.pushRefmap" in the future to map the refnames of refs 
that are pushed without setting up a default set of refs to push.

> Like --refmap itself,
> it only maps refs that are actually being fetched, so it has nothing
> to do when there is nothing explicit to fetch, on the command line or
> via remote.<name>.fetch.

So the default value behaves like the option - why wouldn't it?

> A refspec-less fetch with a refmap configured but nothing else to say
> what to fetch falls back to the same defaults as a remote with no
> refspec or refmap at all. Only an explicit --refmap given on the
> command line with no command-line refspec to go with it is still
> rejected, since that combination is a plain mistake to type, unlike a
> remote.<name>.refmap configured on its own. A remote.<name>.fetch
> that is also configured is used as before.

I'm afraid I cannot understand what this paragraph is trying to say.

> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
>   
> +remote.<name>.refmap::
> +	The default value of the `--refmap` option for linkgit:git-fetch[1].
> +	Used to map remote refs being fetched to remote-tracking refs to
> +	store. See the `--refmap` entry in linkgit:git-fetch[1].

I'm not sure we need to link to the git fetch documentation twice. It 
would be useful to explain how this interacts with remote.<name>.fetch. 
The documentation for "--refmap" says that if it is given the refspec 
config is ignored - so does setting this mean remote.<name>.fetch is 
ignored?

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> ++
> +`remote.<name>.refmap` provides the default value for this option, the
> +same way `remote.<name>.fetch` provides the default refspecs to fetch.

As above the second half of this sentence doesn't really add anything.

Thanks

Phillip

>   
>   `-t`::
>   `--tags`::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 1f76ae6242..ffcb5ba29a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -518,6 +518,12 @@ static struct ref *get_ref_map(struct remote *remote,
>   	struct ref *rm;
>   	struct ref *ref_map = NULL;
>   	struct ref **tail = &ref_map;
> +	/*
> +	 * The --refmap command line option, if given, takes precedence
> +	 * over remote.<name>.refmap.
> +	 */
> +	struct refspec *effective_refmap =
> +		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
>   
>   	/* opportunistically-updated references: */
>   	struct ref *orefs = NULL, **oref_tail = &orefs;
> @@ -561,8 +567,8 @@ static struct ref *get_ref_map(struct remote *remote,
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
> diff --git a/remote.c b/remote.c
> index 49ee2ea318..c9252a90f4 100644
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
> +	} else if (!strcmp(subkey, "refmap")) {
> +		char *v;
> +		if (git_config_string(&v, key, value))
> +			return -1;
> +		refspec_append(&remote->refmap, v);
> +		free(v);
>   	} else if (!strcmp(subkey, "receivepack")) {
>   		char *v;
>   		if (git_config_string(&v, key, value))
> @@ -995,7 +1003,9 @@ void ref_push_report_free(struct ref_push_report *report)
>   
>   int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
>   {
> -	return refspec_find_match(&remote->fetch, refspec);
> +	if (remote->fetch.nr)
> +		return refspec_find_match(&remote->fetch, refspec);
> +	return refspec_find_match(&remote->refmap, refspec);
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
> index 17c0be499c..ec5cd9dca6 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -927,6 +927,69 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
>   	)
>   '
>   
> +test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
> +	test_when_finished "git -C three config --unset remote.origin.refmap" &&
> +	git branch -f side &&
> +	git -C three config remote.origin.refmap \
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
> +test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
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
> +		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
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
> +		# remote.<name>.refmap plays no part in deciding what to
> +		# fetch, only in remapping something that is already being
> +		# fetched by name.
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
>   test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
>   	git branch -f side &&
>   	(

