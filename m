Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488828;
	b=fzVIqNv0u37lRLOexTRsiAqJQP8QzD8dwA1RwJa4UicvKXuRozdiIX1dfKTrNnOsOhpq
	 rpClRwdDckSxwWTfR/zxPRLuy0fxS7+GxNFpvXY06XfPRXMJAqX1M9xCprPhHiu6bGdeL
	 b1vNX635RseBMG/BcIckUsC3XQc1jEANggrY7vgTr23TWk6pOslH0YSLcqQUKjyrjSxEr
	 O8vsEjkOZMkS5Dhtmkf7Qtdi6jMSWnmtLMJlFlVGGP2JkgiWe4Y1sYnwOZ/hyE6XQ7TlP
	 wjfjLSMuFSa8fQ9Ptg18kRr0QklmpAuVH3B50ho2bJ/PFDULAg1yrjh13hJ7uu0/0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=feBfKzh46Am812S8dwkZ3OpNpc/y79OQMU1WmrE5UUo=;
	b=dDOvU2k/ByyKsoZibRNfPWKPRo631ZmCb4xENg8HSt4ogTagOH57/3Pj2VTL87cgLcji
	 tgdCaX6qL8P2I6Th9+5djUdztXJwnwZKlUaB378OxDgdHmEvA24dPG8I624jPQ4kJ5QAd
	 McFcAfd/O8pi301Bal5F7L36qaJG4sB3dDKl7cmO5+LgyjgoFMGACq7uuvKoaObet/64T
	 KL3syqPuAKTvwSBu1qGOK4Z8GMpfWMkf3donqkh/uj0l2rw9nWBqyOmZWZlrvuIbvV106
	 dJBiq8uwNyOKsnRUDbhaYnyqHirBMjUSkvtg7wABvu4rP8dk68wpmPNvjnaVTBfOkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jx7pAqc0;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A11606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A11606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jx7pAqc0
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so23126635e9.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488826; x=1793093626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=feBfKzh46Am812S8dwkZ3OpNpc/y79OQMU1WmrE5UUo=;
        b=jx7pAqc06qVuytYmprCBoOAVeSGtPXvEpUi8voPAU6Rx5JLWLDWUNeyd2SAfMm1Bu6
         7ZrEn1/nZFQdtiO7vwvJksEzx1DLzbO3hoD5NWv5wermyOHWSCuj5nbzb3wi58sCBEv+
         YcYMvGRHyo3z469/9407Z6oGs/5yJprOho3tY+9M4QJPri9rd2F5c2xrnJIcrZszPzxD
         yx/MOWO0Tc0WtKeeza3ZQ9QcqbnKN7CSR8C/avXFdR91pNo4frZFB3PmDXovWlIBbt7f
         +ZnwxmDJr/Iy4TEU47MKHHJfNq7/cTMOt51Ti0jwLR0TphKGIbTaL3TC/Zu/6RwGo/aO
         SLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488826; x=1793093626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=feBfKzh46Am812S8dwkZ3OpNpc/y79OQMU1WmrE5UUo=;
        b=u2sMS3zM8iAXkhCDnpR7w5+QR6sSJ5gIMOtPrfpBlQALPigvA3qb5PeV0agPKdIx2c
         mVD4kG6EmWMWpnNr+4W0YhqXkbwCq5ihXzCAWjTElYykQv7q3BybJ+NcN2iWqwrc0w53
         joVUYvFgYt95J5Ik6/w1xVgGTA4/HE0Eodv3xP663yhUqxcJtTU99RcbVOESHGWBoI5e
         DrLihaI75qasxZ7RfcbKGOpDlgJRaaXOSETwBnhkfD1H+mLjTVPSkdpZ4YrWRh8tzKW+
         Vl1n17XKjeYg6ua/z9AyM00sBylwEmWaxkcojol8AebIRrzuT1BquiI8YKDSzKEYeI+v
         O/8w==
X-Forwarded-Encrypted: i=1; AKwUvBzp1Nrq6hY59W3C/dSWDJhuJdJ3q7rVXCeidQ4qfsUA+0+R5awJfR8ENWd0kN0T4DG4XEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpvMOQScNomtDzxq0MOPXK8Lhb8UI0EtJiFO+bi/WhCJd5cp6G
	exSWKhxcEYQq05/IRyjzQhKW8NFgXRInopvYNcRZB1nEuPEOPKMhLUvb
X-Gm-Gg: AYBFou1Dcyxu11HsEz5AOxHsiDI+IgQIivf4YGtLnCIbGb3UF070CXX82hUyLCfZtHD
	7umoiGHYoqLiuf3QA8RHe8XKgSK+8NgHxVBFuxX0hl3qFXROD68N2jqhFGWleDzrDzDojw5G2lN
	GYkNPT+kcmrD5XRXaQgUtq4fBhDzVdXMxVbfWzvCKBvRp7IayRF9o1EGC/jji6hP8TEVd1LOpsa
	1+i7e1QsfWqj3pE6gSivgelm+D+5iIS1D8eOUVfHgJNHTqJas7vnpzWcgSjMWBy1PDg+aC/EdVd
	aC2C95TxH7bbWOqbqbwsqv9IBLR/6VNXmHvYxFvKyA+OPbrIReEuc1H0JKnUfBy76tDmq3Eh8ky
	8XX6J1Z6R7AT3P4k89yh2Lki0qEjsAQ8MmLGxP5Wsj1u+oNV0UWRvNkkAAfabIgJ2a8hTdybv8y
	jJLw7u8Wp4KtjWqASkrm5CN2Oj5LsKoFr6c+Jem6QBQOTTWnVfzU4obJkHiewv5B6E5jC/HD6Qu
	mr9PJY+41CwCVN8ElGn0Mqc80PRIsX4RzJK4FBmLuNRXSDqtu3R
X-Received: by 2002:a05:600c:190f:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4a1d762b85bmr217437785e9.35.1792488825849;
        Tue, 20 Oct 2026 02:33:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3597sm57608225e9.2.2026.10.20.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:33:45 -0700 (PDT)
Message-ID: <5030377b-58c8-4193-8d72-79955082269f@gmail.com>
Date: Tue, 20 Oct 2026 10:33:42 +0100
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
Subject: Re: [PATCH] status: compare against both upstream and push branch by
 default
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 19/10/2026 20:23, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> In a triangular workflow, where a branch is pulled from one place and
> pushed to another, "git status" only compares the branch to its
> upstream. It says nothing about the branch it is pushed to unless
> status.compareBranches is configured.
> 
> Show both comparisons by default. When the two resolve to the same
> branch, which is the common case, only one comparison is shown, so the
> output for most users does not change. Setting status.compareBranches
> to "@{upstream}" gives the previous output.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      status: compare against both upstream and push branch by default
>      
>      Make @{upstream} @{push} the default for status.compareBranches. When
>      both resolve to the same branch only one comparison is shown, so most
>      users see no change.

If you want to change the default value of a config variable it is 
helpful to explain why the current default was chosen as well as why you 
think the new default is better. In this case wasn't there some 
discussion about the default value when the variable was introduced? 
Providing that context would make it much easier for people to judge if 
this change is a good idea.

Thanks

Phillip


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2458%2FHaraldNordgren%2Fstatus-compare-branches-default-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2458/HaraldNordgren/status-compare-branches-default-v1
> Pull-Request: https://github.com/git/git/pull/2458
> 
>   Documentation/config/status.adoc | 11 ++++++-----
>   remote.c                         |  1 +
>   t/t5505-remote.sh                |  1 -
>   t/t6040-tracking-info.sh         | 30 +++++++++++++++---------------
>   4 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
> index b5dd85b761..1d847d3a8a 100644
> --- a/Documentation/config/status.adoc
> +++ b/Documentation/config/status.adoc
> @@ -23,8 +23,9 @@ status.compareBranches::
>   	are supported. They are interpreted as `branch@{upstream}` and
>   	`branch@{push}` for the current branch.
>   +
> -If not set, the default behavior is equivalent to `@{upstream}`, which
> -compares against the configured upstream tracking branch.
> +If not set, the default behavior is equivalent to `@{upstream} @{push}`,
> +which compares against both the configured upstream and push tracking
> +branches.
>   +
>   The entries are shown in the order they appear in the configuration.
>   Duplicate entries that resolve to the same ref are suppressed after
> @@ -36,11 +37,11 @@ Example:
>   +
>   ----
>   [status]
> -	compareBranches = @{upstream} @{push}
> +	compareBranches = @{upstream}
>   ----
>   +
> -This would show comparisons against both the configured upstream and push
> -tracking branches for the current branch.
> +This would only show the comparison against the configured upstream
> +tracking branch for the current branch.
>   
>   status.displayCommentPrefix::
>   	If set to true, linkgit:git-status[1] will insert a comment
> diff --git a/remote.c b/remote.c
> index 71170f36a9..6fdb4b84da 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2465,6 +2465,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   		string_list_remove_empty_items(&branches, 0);
>   	} else {
>   		string_list_append(&branches, "@{upstream}");
> +		string_list_append(&branches, "@{push}");
>   	}
>   
>   	upstream_ref = branch_get_upstream(branch, NULL);
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 5fbfcb0848..f77753605f 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -34,7 +34,6 @@ setup_url_pushremote () {
>   		git checkout -b topic --track origin/main &&
>   		git commit --allow-empty -m topic-change &&
>   		git config push.default current &&
> -		git config status.compareBranches "@{upstream} @{push}" &&
>   		git config branch.topic.pushRemote "$fork_url" &&
>   		git push
>   	)
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index e95d420972..e10cde090d 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -331,19 +331,6 @@ test_expect_success 'status.compareBranches deduplicates when upstream and push
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> -	test_config -C test status.compareBranches "@{upstream}" &&
> -	git -C test checkout main &&
> -	git -C test status >actual &&
> -	cat >expect <<-EOF &&
> -	On branch main
> -	Your branch is up to date with ${SQ}origin/main${SQ}.
> -
> -	nothing to commit, working tree clean
> -	EOF
> -	test_cmp expect actual
> -'
> -
>   test_expect_success 'status.compareBranches with only push shows only push' '
>   	test_config -C test push.default current &&
>   	test_config -C test status.compareBranches "@{push}" &&
> @@ -361,9 +348,8 @@ test_expect_success 'status.compareBranches with only push shows only push' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
> +test_expect_success 'status shows ahead of both upstream and push branch by default' '
>   	test_config -C test push.default current &&
> -	test_config -C test status.compareBranches "@{upstream} @{push}" &&
>   	git -C test checkout -b feature3 origin/main &&
>   	git -C test push origin HEAD &&
>   	(cd test && advance work) &&
> @@ -380,6 +366,20 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream}" &&
> +	git -C test checkout feature3 &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature3
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'checkout with status.compareBranches shows both branches' '
>   	test_config -C test push.default current &&
>   	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> 
> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb

