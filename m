Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B73D47BC
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368833; cv=none; b=KL4o3jmbDAyYAmVmMw/vHEm/PPLfh3tTdnEkdX7e2RwdL2fmX8/OohoaBzm/HVUEM5/AkrcSYrortR3Q3xAtFrrPLtRNNayjI2VprITeKxpPQVx0ZjC5K8327ZYNYkWDhzLPsuJV3gXHwF9BEvVbe3MSRNMpnlIrGot9o+aAFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368833; c=relaxed/simple;
	bh=rzvl+Ki7pqd/tB51Ys+UwECMiOU820fnYX9IhldceLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=psnIZy8sczGtJmLyTXzrhtKDrunyximX4fq+9l1JRyDDCPx7bph3SNiK5G/1J8PXHZJR5JPgsVz1GKlVta8EX3ehKNBFI7OTYkGEmeBbDmcp9ggMuKF1bBxORDmWQTPlAwGYnIvCQ+Kk9E+bSiEpE/Tv2CNWVTmTdPiBSsuIueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6N06ZSm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6N06ZSm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so95628835e9.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368830; x=1777973630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozOm77GdlhpEFQ0NVNHbHbPmwIOdxro5E8hUkcrWyjs=;
        b=c6N06ZSmIZuhnpE9M+hm5CZOTSOqIW3XciJSNyVN+vwKxjniP9nnI2mcLP0GzvvGwJ
         gn5LuT4f/i9TuJW+4LbkDNGeYCiHzWzGpJLpMJzGhsTts0ioWGINTLWDi6WI0t00VR2N
         KptInwou950E2atP9EiMTKG66jyM5mddC1KRKAPGhYGvVGKfqRPG6swuZMtwK0hyLIKf
         3r1WsUYNs/HhhT9fmXacsK9SfVUAku5wbnSWres52LHDZHc8yLvZki7x+HVhCoDF30U8
         0TpdUZIS1kEOjPF5eLjEQ6OME0uwz6Eb1hpoBwigSbpfMDXJeZJmKkQ8WosbtzJQhLS/
         1Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368830; x=1777973630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozOm77GdlhpEFQ0NVNHbHbPmwIOdxro5E8hUkcrWyjs=;
        b=EXrC8TEEYP0PYBzrjVg97AewgQl0yMW7hppmoABD3M1aZy/wNH9esM3CBC0Nf/9m3x
         c1udKjdegPL88UbRMSuKf/8OO1dyvxM7E4bT8IqB45u6gWOyvqIp1tKHqvNDgYbfD4hd
         /GDVJ4zizvod87pYEWvqQd2PI/FaUbsJ6jYfbIunatVGhTfjjs4F9KKxdR9E+7V/nnko
         qYFRNy3Wh/ezUVvFztCMRiCso9ogrw8hHP4hzvNJkXiimiat9nclohVWXJlLJyU5IrDb
         EJO4p45zc+7cdxhoHWklFZFPPUfykkOrduY5DCXNqqMw6p7UrMxBDtbRAfQMr5SeQy06
         9CYA==
X-Forwarded-Encrypted: i=1; AFNElJ/gYS53cWOcMxJ3ET7m9rGZJ9rJfNT6wWYxrFoP6RNRAaBNRtTY8AJbJdbjkN7T7R85L3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUetUUuZVYtQCrhCmOY6kIcw/OxZslNXCmTmhN6D4wrbLpqFy
	8mAu+OHXVt4GnSC+D9akrnSovhdxvIf3WEJJRNfQvj2d8CKUTZofT2eW
X-Gm-Gg: AeBDieusDIDYHJ4oliaUnhuXW5gMj4aqviCzMS/WE9GG7Czwzbq230ENc4BYckJgJt8
	FtOqT4UX+6MBofflxeMoQoJrauuv2HYBWztoG99hMfqPOlNfDnE3BO1MDoYPg7Wjgz4dMyPWcpF
	VQxLSUAPBgT5h1EzmoEi/l1gsB4b9e7URIjT5LLGNZssvITrmpNWXG2hx9hHympDvMzglum8e1w
	sfxM+sk/dzMmQe77VFSdf7mtfs0nyc/Drl5oAV9yKEQRKSJkVude2SfQ55jvKc+EsuyG3QI3CCh
	3U5fiLhf2wMB7ELDEMyJFEvKmu4MrdUjEnrYPhnvsG4ndbCFdK72TgD0bKeghgQTmRQxoj13Lp0
	5TsrhE3lbNP7xUgIXwJeNykDidlUIJLOarp0WXwwues0I7UCBo2nnP/ABUVXaC5tbAFm4js9JfV
	CD0ehbQF44y1ZJP5K8WvbM3laehXN9fi/BYbBql8rRVQpdLs1mK0xFOJrSHnJkcN4XG2uSYIDLk
	IRIqiW6648e9gE7qZg9Ttdn
X-Received: by 2002:a05:600c:1393:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48a77b270efmr36326665e9.29.1777368830051;
        Tue, 28 Apr 2026 02:33:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77af1bacsm39526975e9.4.2026.04.28.02.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:33:49 -0700 (PDT)
Message-ID: <04b49202-d1bb-45a1-ae4d-4a87a5822ba1@gmail.com>
Date: Tue, 28 Apr 2026 10:33:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 4/5] checkout: rollback lock on early returns in
 merge_working_tree
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <f35842408527a8c69f9936cdb127fb35efe2509c.1777065012.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <f35842408527a8c69f9936cdb127fb35efe2509c.1777065012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> merge_working_tree() acquires the index lock via
> repo_hold_locked_index() but several early return paths exit
> without calling rollback_lock_file(), leaving the lock held.
> While this is currently harmless because the process exits soon
> after, it becomes a problem if the function is ever called more
> than once in the same process.
> 
> Add rollback_lock_file() calls to all early return paths.

Thanks for splitting this out, it looks good

Phillip

> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   builtin/checkout.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e031e61886..c80c62b37b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -783,8 +783,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   	struct tree *new_tree;
>   
>   	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
> -	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
> +	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
> +		rollback_lock_file(&lock_file);
>   		return error(_("index file corrupt"));
> +	}
>   
>   	resolve_undo_clear_index(the_repository->index);
>   	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
> @@ -797,14 +799,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   	} else {
>   		new_tree = repo_get_commit_tree(the_repository,
>   						new_branch_info->commit);
> -		if (!new_tree)
> +		if (!new_tree) {
> +			rollback_lock_file(&lock_file);
>   			return error(_("unable to read tree (%s)"),
>   				     oid_to_hex(&new_branch_info->commit->object.oid));
> +		}
>   	}
>   	if (opts->discard_changes) {
>   		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
> -		if (ret)
> +		if (ret) {
> +			rollback_lock_file(&lock_file);
>   			return ret;
> +		}
>   	} else {
>   		struct tree_desc trees[2];
>   		struct tree *tree;
> @@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
>   
>   		if (unmerged_index(the_repository->index)) {
> +			rollback_lock_file(&lock_file);
>   			error(_("you need to resolve your current index first"));
>   			return 1;
>   		}
> @@ -857,15 +864,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   			struct strbuf sb = STRBUF_INIT;
>   			struct strbuf old_commit_shortname = STRBUF_INIT;
>   
> -			if (!opts->merge)
> +			if (!opts->merge) {
> +				rollback_lock_file(&lock_file);
>   				return 1;
> +			}
>   
>   			/*
>   			 * Without old_branch_info->commit, the below is the same as
>   			 * the two-tree unpack we already tried and failed.
>   			 */
> -			if (!old_branch_info->commit)
> +			if (!old_branch_info->commit) {
> +				rollback_lock_file(&lock_file);
>   				return 1;
> +			}
>   			old_tree = repo_get_commit_tree(the_repository,
>   							old_branch_info->commit);
>   
> @@ -897,8 +908,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   			ret = reset_tree(new_tree,
>   					 opts, 1,
>   					 writeout_error, new_branch_info);
> -			if (ret)
> +			if (ret) {
> +				rollback_lock_file(&lock_file);
>   				return ret;
> +			}
>   			o.ancestor = old_branch_info->name;
>   			if (!old_branch_info->name) {
>   				strbuf_add_unique_abbrev(&old_commit_shortname,
> @@ -920,8 +933,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   					 writeout_error, new_branch_info);
>   			strbuf_release(&o.obuf);
>   			strbuf_release(&old_commit_shortname);
> -			if (ret)
> +			if (ret) {
> +				rollback_lock_file(&lock_file);
>   				return ret;
> +			}
>   		}
>   	}
>   

