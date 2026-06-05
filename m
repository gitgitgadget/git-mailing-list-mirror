Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67D305662
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667407; cv=none; b=BHHPtl1ENV9NoqzWExOufL4Rlev5vFQs664B9DzzpQ9qxa10wKVqdzAiHoZtFjuJCJCN7miFb37rsoVL4XI0yn1Eva928xBcBUfPQ+9IOzbzbzsHhMSc72ElL3jHsvB4442opDRIBGwIVAMvOsl5jQseC0pGjPagy8Rkc5k8xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667407; c=relaxed/simple;
	bh=36Yq3/ABfnQicQj5Ua0NK5L7xdwkIfD42JJAeAsho1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUvXXBr6OTNAUKminNW6ANDnmO6El/YFsvtTLxeFFXdiWXhzoX3GhlR3ySwsiCjuGKPGcjZVoQRFP0kvSEhpCyO0Ns2GaszDvTczq16dXtFDk3ntMu3GwoUcS8rv1jvwiuGpiqiIolg4eoEQe7Vsiq+D1U3hfpr3nVbDNSe6Pi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c51o2NDQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c51o2NDQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so1504054f8f.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667405; x=1781272205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gl3uXN6kgazh3UTbpfhICbKUu+8sWyHNAZh109HiBA=;
        b=c51o2NDQbw6+ZgCOPfuJj4Yze8HXpmpoU30brwjdw0Hwmb1sxk5eEp1+cPc84+xX0N
         066u4iXgvwwUn+XmTdy1muElT5c6qeZjJKV6KBEbZRlkPvqiZr3SCeN4kjJO+MiGCavE
         XNeY3rFzNMJ9GcHcndu8KzOWlQMzwpCvUDEejnHhnvZwdeUQI/6WliPpWW8YXEr3E381
         LYyN7l62Q4Ztex+x+FiLOqZN3WKO8NCuzb/B3lVBivHZCuMqCoNiFf3i7ErVVQjanOvm
         uY7l0PSfVPYxQIgPc01xXk7mLMmCTYhiXUYOnNJa1JJbh00Iemy89fyiSgXcoP+44CHS
         dvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667405; x=1781272205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gl3uXN6kgazh3UTbpfhICbKUu+8sWyHNAZh109HiBA=;
        b=lMAnUlGoIuWSVGY/jHRxUV90gl5mLmwYQvjLfJl9+0GVvoPQFW7H2XnettXuSc90vq
         5DRgmXaU60dOFPf2nPGyS1ivS0HP9v9BFF2U6Kly7VDEg3drt6bho87w7xhUkIjyHmJA
         AAcPTLTx2eLc+bB4wG+GIkRItGi2cMkcoT09jmNK2DN5Apa576bZX1oNZsVdkcVwewQR
         0qGBfwxpwtQoUpQ1UgzU3+dPp6acji05w/VXXodgOCOUbh2HWe9Ms0r4VAL46xk0x73n
         KtaD/5SP84qX5JRH/h+6wcNvkI3a1EK1O1rbcTY3BtXV0OPU5iW1e7t5pXGKejoL9hm3
         FFcA==
X-Forwarded-Encrypted: i=1; AFNElJ8FIal70sy8lsosGwz6COMmtrT+pHEWfYjOCvZJVyT2chNg4k+2JIPRj0E7BaNWrYWzehc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYuqrbiXWhJK8vNvK4ix8MeZdqZFCQA8PEToj82Yl0ctnA4XU
	CV9n+ji6vG4bsz5Ng4vLJ9JjjLuFc1MMhxDhpbwcCYnP00kYBy28XZaZ
X-Gm-Gg: Acq92OEKnbegOXZ3Owio1/yjKeQyu8Q62B+FieQO/9lE+/5hRvkpAkjk7JR8Ht2vCWE
	eAOuGZEmsJraRZMbGLCzz8V4ohvuBT9wIh+LNIhdpbmRtOyzSTa+Jnzx06MbLAzVfFyw4CHMKJF
	HD0oLeij2VHV7Qs562B2EGD4T/vrHN1RsgzUql61R7UxVyT1aRkNgpoX/7faj3nuev/HXsy/sDa
	hL5aIiphmZ9LkBf5OHB6oSIH+sP4Ht/issG86C2giJjQKL2Cb6ZBqyREQcqE0DBgBqy3B/s1Wh7
	V9rZj2CkbmmPq3kuzztUL5/y8+vMgtwgHVcnMNx1iTH3H9x4PYeCWvI3Pfz8USwE4qv6b+M9ADV
	KpK/egSB4GOWstH/PR8pLjChJWfuFSBwlxdWTzo5bQTHLu6VzjHbvoTer9Mu2n+ODIvTVK9S4UK
	WX1a8LZRZ1oh2fxuz3E6yyVAlRGopeTH6F0QABW1WDZYFyVXuSFGLbw7EXLwrIQFvQ6dLb+6ars
	bnrD8FgEUac4Q==
X-Received: by 2002:a05:600c:4444:b0:490:b9c3:6c59 with SMTP id 5b1f17b1804b1-490c260579fmr57548755e9.29.1780667404974;
        Fri, 05 Jun 2026 06:50:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm28492575f8f.5.2026.06.05.06.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:50:03 -0700 (PDT)
Message-ID: <734ce28a-d693-444b-b74b-2891e245de38@gmail.com>
Date: Fri, 5 Jun 2026 14:49:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 3/6] branch: prepare delete_branches for a bulk caller
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
 <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <004a96f7a447ad8dcbcabeb36502330c2399f829.1780477479.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <004a96f7a447ad8dcbcabeb36502330c2399f829.1780477479.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/06/2026 10:04, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add no_head_fallback and dry_run flags to delete_branches() so a
> bulk caller (the upcoming --prune-merged) can ask strictly about
> merged-into-upstream without a silent fallback to HEAD, and
> rehearse deletions with the same "Would delete branch ..." wording
> as the live run. Existing callers pass 0 for both and keep current
> behavior.
> 
> When no_head_fallback is set, head_rev stays NULL through to
> branch_merged(), whose "merged to X but not yet merged to HEAD"
> reminder otherwise compares against HEAD. For the bulk caller
> every candidate is known to have an upstream, so HEAD is
> irrelevant. Guard the block on head_rev so the NULL case skips
> it instead of treating "NULL != reference_rev" as "diverges from
> HEAD" and emitting a spurious warning.

Same comment as the last patch - use a flags argument rather than lots 
of individual booleans that make the call sites hard to read.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   builtin/branch.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 93d8eae891..09afdd9257 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -169,10 +169,13 @@ static int branch_merged(int kind, const char *name,
>   	 * upstream, if any, otherwise with HEAD", we should just
>   	 * return the result of the repo_in_merge_bases() above without
>   	 * any of the following code, but during the transition period,
> -	 * a gentle reminder is in order.
> +	 * a gentle reminder is in order.  Callers that opt out of the
> +	 * HEAD fallback by passing head_rev=NULL are not interested in
> +	 * the reminder either: they have already established that the
> +	 * branch has an upstream, so HEAD is irrelevant to the decision.
>   	 */
> -	if (head_rev != reference_rev) {
> -		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
> +	if (head_rev && head_rev != reference_rev) {
> +		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
>   		if (expect < 0)
>   			exit(128);
>   		if (expect == merged)
> @@ -225,7 +228,8 @@ static void delete_branch_config(const char *branchname)
>   }
>   
>   static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet, int warn_only)
> +			   int quiet, int warn_only, int no_head_fallback,
> +			   int dry_run)
>   {
>   	struct commit *head_rev = NULL;
>   	struct object_id oid;
> @@ -259,7 +263,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	}
>   	branch_name_pos = strcspn(fmt, "%");
>   
> -	if (!force)
> +	if (!force && !no_head_fallback)
>   		head_rev = lookup_commit_reference(the_repository, &head_oid);
>   
>   	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
> @@ -330,13 +334,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   		free(target);
>   	}
>   
> -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
> +	if (!dry_run &&
> +	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
>   		ret = 1;
>   
>   	for_each_string_list_item(item, &refs_to_delete) {
>   		char *describe_ref = item->util;
>   		char *name = item->string;
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
> +		if (dry_run) {
> +			if (!quiet)
> +				printf(remote_branch
> +					? _("Would delete remote-tracking branch %s (was %s).\n")
> +					: _("Would delete branch %s (was %s).\n"),
> +					name + branch_name_pos, describe_ref);
> +		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
>   			char *refname = name + branch_name_pos;
>   			if (!quiet)
>   				printf(remote_branch
> @@ -1003,7 +1014,7 @@ int cmd_branch(int argc,
>   		if (!argc)
>   			die(_("branch name required"));
>   		ret = delete_branches(argc, argv, delete > 1, filter.kind,
> -				      quiet, 0);
> +				      quiet, 0, 0, 0);
>   		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();

