Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAA470E9D
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859106; cv=none; b=ajzW+QAC+WkMb1RwhDBlw5AhA6WMTi7RxauKHEuKhmCb/tBOTamd1XqXpzl1D3LjmDt2nkN4hFOfFyS5xMhcC5Ht8EXKozpScaKFtczv6oYi67R6wqD6j3lIIig4iz24KFaP3F+0mDj9Bp1Ko0aaGvrcXTKToD41CqcTeR9F3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859106; c=relaxed/simple;
	bh=BMRF7xK5l35n9409YOpk2yqATDNX9Eu4MKG+eGj6ytI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYflphGwrA6IklGWbObNYED7DVubeWemD9l2lUeoRsuJ6WYkfGDl8w6uqsfH4niaQqQ/qDqbZ1mjg1kKFNJ36T8kspjo1VItsS+FGe0XKrvQqy6sRO0Rc/cxABWoYmMHKPY5ficmRg5VPbeA2ugQ4CcMZdICmQYSepaIHgJvlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pr2c1Ok7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr2c1Ok7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so33764285e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785859099; x=1786463899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVNdfa+8OnN1D3giiFL7Y3Nna4VRe3cTcrgoVHGv3Ns=;
        b=pr2c1Ok79r5PJghdMC4quwVIfSql1Rdvc9est8aO5mzAHZEgjw6kFDmaZXs3KInFw4
         zSbyN/RhricNhbrg6RDFxCP3QgmSE+PlX/kzO+tQKgLemMaiUzdQt70BxEOkAfpWDN4P
         VtrxPF9/fmd9jbQ4tlmyKF+0WGRQWUb46kkfrBrhe5WQs3s1JPHfWvFsu1wsp6zcF4mW
         9NCIWka/UY80CV7WE6qtZT5HvLUP8moqxr3IoKhx/20MZRqq5DAXQrQicNnjDEtS4Kqt
         5WkCy72R1PsqaU6uNZY+SdCqXOynnvXEZH0U1tWfhT2zvy6IbBit9wQFGhGM/Dxntx2B
         tHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859099; x=1786463899;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVNdfa+8OnN1D3giiFL7Y3Nna4VRe3cTcrgoVHGv3Ns=;
        b=OK5dGC/IELlRLP3xCOmxgFhaPQ4yXVi5cRgMqZSsstr3IyEpnV7SIbh6Y2qEAaA1fO
         2xJf9GLM1Li+iLDbaxZnCcc2eJtsAL4vNzAlqBK07dvGmYOcR0J/ZcGo7dAp7ryRxuxN
         Eikd7frIZQpTmSD0qlpFX6H56TZQpdJkVzo0PhlaZJfEA37GvSqZXgBxe5AoCRpqT6cl
         RKO+V30owwzbehJSjEXOOScus97a4Ifc3O0BXZr23Q928isoTAsKanGBE7HxeoYXSqiF
         Nfib8hUYpMhFFAo9VT+D7y5XkvmxfTg/V+DxJ1fmfjZSWRvRbJIuDBg1CTyVQchME4l9
         kaUQ==
X-Forwarded-Encrypted: i=1; AHgh+RptOb0je3JjrrBHzN9zD4QHs87acaZuudVeUPm4Hl7Ony6bz0pjbXE/ALmY6Y06dW0rP+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWAfm0pc1qfCX5e8H6lccC01BuLs+ygns8nt+1iXGGcX+DWsh
	NBn6QafsHvVXKvgxqrjARXHjkOHGLm0UaTHSLuwxjNiTRvRp8MAjnt05
X-Gm-Gg: AR+sD10eQZ2zzTNHaVzAhKLavaZEmoFN49B2GQyWLTRWZrZvSXa0baky1GUVhgv0u1p
	+v9+ikUvz0rw6BIENYG0KQzhdTZz/XG/uKpsmRLrOLWVccxS33k/H7kxDcqdRTbfTt4Mg5zFNs+
	KtKptET0s1ti1hFGmYwFPcJMRbPGIvOl3sMSZp6qTQ3PyFBByN9HWrOV4qKa2htwmUZU4PJhdvp
	MIht0k26EUznlFmNNE8Op9dGYAqjI6Wf6m11vkQnPQg/QNB/Dw75ozZkMEoLrPo91yKpPkYZBSq
	38bwmCMmhA/LzU7M9lucZNJp0RZaXYDHH1lDWdpcNpBJOyntNcHrhZtdeZt1r97VwOU0aKb8dV+
	eqJktGORGNahajAvZHT3Mx2kVlDotKqCz7VQsBFYODliiwdfkj1Vb8omj1ZoY5havbGGeqm/e49
	vHD96E+aglCF4uigG3VZRKAge10Xp4J6dEAtb5yU9wT689dPqw6i0wPDZwjNcr6eNiVqqCoe9lU
	6Wm9LxdnYhMHXyCS2XaoPuBPIA8GjGxxeMUMGf14K4=
X-Received: by 2002:a05:600c:8b14:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4980c66d940mr383275355e9.5.1785859098419;
        Tue, 04 Aug 2026 08:58:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04c2a1sm8231895e9.14.2026.08.04.08.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 08:58:17 -0700 (PDT)
Message-ID: <0ea7bbec-3381-4bc6-99a9-2c3b5d1bfebd@gmail.com>
Date: Tue, 4 Aug 2026 16:58:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v24 0/7] branch: delete-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
 <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/07/2026 14:58, Harald Nordgren via GitGitGadget wrote:
> Changes in v24:
> 
>   * Map branches through the configured push and fetch refspecs before
>     deciding whether pushing would update their upstream.
>   * Protect only the direct upstream of surviving work, delete deeper merged
>     bases and clear stale upstream configuration.
>   * Clarify that --delete-merged takes upstream patterns in docs.
> 
> Range-diff vs v23:
> 
>   1:  0c4fe549cb ! 1:  59157142b3 branch: add --forked filter for --list mode
>       @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>        +'
>        +
>        +test_expect_success '--forked composes with --no-merged' '
>       -+	git -C forked branch --forked "origin/*" --no-merged origin/one \
>       -+		--format="%(refname:short)" >actual &&
>       ++	git -C forked branch --forked "origin/*" --no-merged origin/one --format="%(refname:short)" >actual &&

We wrap our lines at 80 columns. I know I suggested unwrapping some very 
short lines in another patch, but these are far too long.

>        +	echo local-one >expect &&
>        +	test_cmp expect actual
>        +'
>       @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>        +'
>        +
>        +test_expect_success '--forked narrows a <pattern> argument' '
>       -+	git -C forked branch --forked "origin/*" "local-*" \
>       -+		--format="%(refname:short)" >actual &&
>       ++	git -C forked branch --forked "origin/*" "local-*" --format="%(refname:short)" >actual &&
>        +	cat >expect <<-\EOF &&
>        +	local-one
>        +	local-two
>   2:  2d20015ba9 ! 2:  5d310da9aa branch: convert delete_branches() to a flags argument
>       @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
>        -		int flags = 0;
>        +		int ref_flags = 0;
>         
>       - 		copy_branchname(&bname, argv[i], allowed_interpret);
>       - 		free(name);
>       + 		copy_branchname(the_repository, &bname,
>       + 				argv[i], allowed_interpret);
>        @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
>         					     RESOLVE_REF_READING
>         					     | RESOLVE_REF_NO_RECURSE
>   3:  34b37aeb43 = 3:  263e90f6ed branch: let delete_branches skip unmerged branches on bulk refusal
>   4:  606ce4082c = 4:  22e31fd35c branch: prepare delete_branches for a bulk caller
>   5:  5fd74f0050 ! 5:  d9f93e66c9 branch: add --delete-merged <branch>
>   [...]

As far as I can see, from here ...

>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +struct stacked_branch_data {
>        +	struct strset *deletable_branch_names;
>        +	struct strset *protected_branch_names;
>       -+	struct strset *visited_branch_names;
>        +};
>        +
>       -+static int collect_stacked_branch_bases(const struct reference *ref,
>       -+					void *cb_data)
>       ++static int collect_stacked_branch_base(const struct reference *ref,
>       ++				       void *cb_data)
>        +{
>        +	struct stacked_branch_data *data = cb_data;
>        +	const char *branch_name;
>       ++	struct branch *branch;
>       ++	const char *upstream_refname;
>       ++	const char *upstream_branch_name;
>        +
>        +	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
>        +		BUG("expected local branch ref, got '%s'", ref->name);
>        +	if (strset_contains(data->deletable_branch_names, branch_name))
>        +		return 0;
>        +
>       -+	while (strset_add(data->visited_branch_names, branch_name)) {
>       -+		struct branch *branch = branch_get(branch_name);
>       -+		const char *upstream_refname = branch_get_upstream(branch, NULL);
>       -+		const char *upstream_branch_name;
>       -+
>       -+		if (!upstream_refname ||
>       -+		    !skip_prefix(upstream_refname, "refs/heads/",
>       -+				 &upstream_branch_name) ||
>       -+		    !strset_contains(data->deletable_branch_names,
>       -+				    upstream_branch_name))
>       -+			break;
>       -+
>       -+		strset_add(data->protected_branch_names, upstream_branch_name);
>       -+		branch_name = upstream_branch_name;
>       -+	}
>       ++	branch = branch_get(branch_name);
>       ++	upstream_refname = branch_get_upstream(branch, NULL);
>       ++	if (!upstream_refname ||
>       ++	    !skip_prefix(upstream_refname, "refs/heads/",
>       ++			 &upstream_branch_name) ||
>       ++	    !strset_contains(data->deletable_branch_names,
>       ++			    upstream_branch_name))
>       ++		return 0;
>        +
>       ++	strset_add(data->protected_branch_names, upstream_branch_name);
>        +	return 0;
>        +}
>        +
>        +static void protect_stacked_branch_bases(struct ref_store *refs,
>       -+					 struct strset *deletable_branch_names)
>       ++					 struct strset *deletable_branch_names,
>       ++					 struct strset *protected_branch_names)
>        +{
>       -+	struct strset protected_branch_names = STRSET_INIT;
>       -+	struct strset visited_branch_names = STRSET_INIT;
>        +	struct stacked_branch_data data = {
>        +		.deletable_branch_names = deletable_branch_names,
>       -+		.protected_branch_names = &protected_branch_names,
>       -+		.visited_branch_names = &visited_branch_names,
>       ++		.protected_branch_names = protected_branch_names,
>        +	};
>        +	struct refs_for_each_ref_options opts = {
>        +		.prefix = "refs/heads/",
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +	struct hashmap_iter iter;
>        +	struct strmap_entry *entry;
>        +
>       -+	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
>       ++	refs_for_each_ref_ext(refs, collect_stacked_branch_base, &data, &opts);
>        +
>       -+	strset_for_each_entry(&protected_branch_names, &iter, entry)
>       ++	strset_for_each_entry(protected_branch_names, &iter, entry)
>        +		strset_remove(deletable_branch_names, entry->key);
>       ++}
>        +
>       -+	strset_clear(&visited_branch_names);
>       -+	strset_clear(&protected_branch_names);
>       ++static void clear_deleted_upstreams(struct strset *protected_branch_names,
>       ++				    struct strset *deletable_branch_names)
>       ++{
>       ++	struct strbuf key = STRBUF_INIT;
>       ++	struct hashmap_iter iter;
>       ++	struct strmap_entry *entry;
>       ++
>       ++	strset_for_each_entry(protected_branch_names, &iter, entry) {
>       ++		struct branch *branch = branch_get(entry->key);
>       ++		const char *upstream_refname = branch_get_upstream(branch, NULL);
>       ++		const char *upstream_branch_name;
>       ++
>       ++		if (!upstream_refname ||
>       ++		    !skip_prefix(upstream_refname, "refs/heads/",
>       ++				 &upstream_branch_name) ||
>       ++		    !strset_contains(deletable_branch_names,
>       ++				    upstream_branch_name))
>       ++			continue;
>       ++
>       ++		strbuf_addf(&key, "branch.%s.merge", branch->name);
>       ++		repo_config_set_gently(the_repository, key.buf, NULL);
>       ++		strbuf_reset(&key);
>       ++		strbuf_addf(&key, "branch.%s.remote", branch->name);
>       ++		repo_config_set_gently(the_repository, key.buf, NULL);
>       ++		strbuf_reset(&key);
>       ++	}
>       ++
>       ++	strbuf_release(&key);
>        +}

... to here pretty much takes us back to V19 with the difference that we 
only prune protected branches from the deleteable set after we've 
visited all the branches - looks good.

>        +static int branch_pushes_to_upstream(struct branch *branch,
>        +				     const char *upstream)
>        +{
>        +	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
>       ++	char *push_refname = NULL;
>        +	char *tracking = NULL;
>        +	int ret = 0;
>        +
>       -+	if (remote)
>       -+		tracking = apply_refspecs(&remote->fetch, branch->refname);
>       ++	if (!remote)
>       ++		return 0;
>       ++	if (remote->push.nr)
>       ++		push_refname = apply_refspecs(&remote->push, branch->refname);
>       ++	else
>       ++		push_refname = xstrdup(branch->refname);
>       ++	if (push_refname)
>       ++		tracking = apply_refspecs(&remote->fetch, push_refname);
>        +	if (tracking && !strcmp(tracking, upstream))
>        +		ret = 1;
>       ++	free(push_refname);>        +	free(tracking);
>        +	return ret;
>        +}

This looks good now - we map the branch name with the push refspec if 
there is one and then with the fetch refspec.

The test changes below look good as well.

Apart from the overlong lines in patch 1 which I'm not sure are worth a 
re-roll on their own, this looks ready to be merged to me

Thanks

Phillip

>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +create_merged_branch () {
>        +	(
>        +		cd repo &&
>       -+		git checkout -b "$1" origin/next --track &&
>       ++		git checkout -b "$1" --track origin/next &&
>        +		git commit --allow-empty -m "$1 work" &&
>        +		git push origin "$1:next"
>        +	)
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	test_cmp expect actual
>        +}
>        +
>       -+test_expect_success '--delete-merged keeps cloned main without a default push remote' '
>       ++test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
>        +	setup_repo_for_delete_merged &&
>        +	(
>        +		cd repo &&
>       ++		test_cmp_config origin branch.main.remote &&
>       ++		test_cmp_config refs/heads/main branch.main.merge &&
>        +		git checkout --detach &&
>        +
>        +		git branch --delete-merged */* &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	create_merged_branch merged &&
>        +	(
>        +		cd repo &&
>       -+		git checkout -b unmerged origin/next --track &&
>       ++		git checkout -b unmerged --track origin/next &&
>        +		git commit --allow-empty -m "unmerged work" &&
>       -+		git checkout -b tracks-other other/main --track &&
>       ++		git checkout -b tracks-other --track other/main &&
>        +		sha=$(git rev-parse --short merged) &&
>        +
>        +		git branch --delete-merged origin/next merged >actual 2>&1 &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	(
>        +		cd repo &&
>        +		git config remote.pushDefault fork &&
>       -+		git checkout -b local-to-delete main --track &&
>       -+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
>       -+		git branch --set-upstream-to=origin/topic upstream-gone &&
>       -+		git update-ref -d refs/remotes/origin/topic &&
>       -+		git checkout -b tracks-other other/main --track &&
>       ++		git checkout -b local-to-delete --track main &&
>       ++		git config branch.upstream-gone.merge refs/heads/topic &&
>       ++		git checkout -b tracks-other --track other/main &&
>        +		git checkout checked-out &&
>        +
>       -+		git branch --delete-merged origin/* \
>       -+			--delete-merged main &&
>       ++		git branch --delete-merged origin/* --delete-merged main &&
>        +
>        +		check_branches <<-\EOF
>        +		checked-out
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	)
>        +'
>        +
>       ++test_expect_success '--delete-merged maps push refspecs to upstreams' '
>       ++	setup_repo_for_delete_merged &&
>       ++	(
>       ++		cd repo &&
>       ++		git checkout -b topic &&
>       ++		git config remote.origin.push "refs/heads/topic:refs/heads/published" &&
>       ++		git push origin &&
>       ++		git branch --set-upstream-to=origin/published topic &&
>       ++		git checkout -b other-topic --track origin/published &&
>       ++		git checkout --detach &&
>       ++
>       ++		git branch --delete-merged origin/published &&
>       ++
>       ++		check_branches <<-\EOF
>       ++		main
>       ++		topic
>       ++		EOF
>       ++	)
>       ++'
>       ++
>        +test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
>        +	setup_repo_for_delete_merged &&
>        +	create_merged_branch feature &&
>        +	(
>        +		cd repo &&
>       -+		git checkout -b topic feature --track &&
>       ++		git checkout -b topic --track feature &&
>        +		git commit --allow-empty -m "topic work" &&
>        +
>        +		git branch --delete-merged origin/next 2>err &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	)
>        +'
>        +
>       -+test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
>       ++test_expect_success '--delete-merged clears the deleted upstream of a protected branch' '
>        +	setup_repo_for_delete_merged &&
>        +	(
>        +		cd repo &&
>       -+		git config remote.pushDefault fork &&
>       -+		git branch lower origin/next --track &&
>       -+		git branch mid lower --track &&
>       -+		git checkout -b tip mid --track &&
>       ++		git branch --track lower origin/next &&
>       ++		git branch --track mid lower &&
>       ++		git checkout -b tip --track mid &&
>        +		git commit --allow-empty -m "tip work" &&
>       ++		sha=$(git rev-parse --short lower) &&
>        +
>       -+		git branch --delete-merged origin/next \
>       -+			--delete-merged lower >actual 2>&1 &&
>       -+		test_must_be_empty actual &&
>       ++		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
>       ++		echo "Deleted branch lower (was $sha)." >expect &&
>       ++		test_cmp expect actual &&
>        +
>        +		check_branches <<-\EOF &&
>       -+		lower
>        +		main
>        +		mid
>        +		tip
>        +		EOF
>        +
>       -+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
>       ++		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
>        +		cat >expect <<-\EOF &&
>       -+		branch.lower.remote origin
>       -+		branch.lower.merge refs/heads/next
>       -+		branch.mid.remote .
>       -+		branch.mid.merge refs/heads/lower
>        +		branch.tip.remote .
>        +		branch.tip.merge refs/heads/mid
>        +		EOF
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
>        +	setup_repo_for_delete_merged &&
>        +	(
>        +		cd repo &&
>       -+		git branch c-lower origin/next --track &&
>       -+		git branch b-mid c-lower --track &&
>       -+		git checkout -b a-tip b-mid --track &&
>       ++		git branch --track c-lower origin/next &&
>       ++		git branch --track b-mid c-lower &&
>       ++		git checkout -b a-tip --track b-mid &&
>        +		git commit --allow-empty -m "tip work" &&
>        +
>       -+		git branch --delete-merged origin/next \
>       -+			--delete-merged "c-*" &&
>       ++		git branch --delete-merged origin/next --delete-merged "c-*" &&
>        +
>        +		check_branches <<-\EOF &&
>        +		a-tip
>        +		b-mid
>       -+		c-lower
>        +		main
>        +		EOF
>        +
>       -+		git branch --delete-merged origin/next \
>       -+			--delete-merged "c-*" >actual 2>&1 &&
>       ++		git branch --delete-merged origin/next --delete-merged "c-*" >actual 2>&1 &&
>        +		test_must_be_empty actual &&
>        +
>        +		check_branches <<-\EOF
>        +		a-tip
>        +		b-mid
>       -+		c-lower
>        +		main
>        +		EOF
>        +	)
>   6:  6494be7c75 ! 6:  aa845096d8 branch: add branch.<name>.deleteMerged opt-out
>       @@ Documentation/config/branch.adoc: for details).
>        
>         ## Documentation/git-branch.adoc ##
>        @@ Documentation/git-branch.adoc: A branch is not deleted when:
>       - +
>       - --
>       - * its configured upstream ref no longer exists,
>       --* it is checked out in any worktree, or
>       -+* it is checked out in any worktree,
>       - * pushing it by name to the remote configured by
>       -   `branch.<name>.remote` would update its upstream, so it cannot be
>       -   distinguished from a branch that just looks "fully merged" right
>       --  after a pull.
>       -+  after a pull, or
>       +   distinguished from a branch that just looks fully merged right
>       +   after a pull; this is determined by the remote's configured push and
>       +   fetch refspecs,
>       +-* it is the local upstream of a branch that is not being deleted.
>       ++* it is the local upstream of a branch that is not being deleted, or
>        +* `branch.<name>.deleteMerged` is set to `false`.
>         --
>         +
>       - A branch whose work has not yet been merged into its upstream is
>       + When such a local upstream branch has its own upstream deleted by the
>        
>         ## builtin/branch.c ##
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       - 	struct ref_array candidates = { 0 };
>         	struct strset deletable_branch_names = STRSET_INIT;
>       + 	struct strset protected_branch_names = STRSET_INIT;
>         	struct strvec branches_to_delete = STRVEC_INIT;
>        +	struct strbuf key = STRBUF_INIT;
>         	struct hashmap_iter iter;
>       @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
>         	}
>         
>        @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       - 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
>       - 				      flags);
>       + 		clear_deleted_upstreams(&protected_branch_names,
>       + 					&deletable_branch_names);
>         
>        +	strbuf_release(&key);
>         	strvec_clear(&branches_to_delete);
>       + 	strset_clear(&protected_branch_names);
>         	strset_clear(&deletable_branch_names);
>       - 	ref_array_clear(&candidates);
>        
>         ## t/t3200-branch.sh ##
>        @@ t/t3200-branch.sh: test_expect_success '--delete-merged requires a value' '
>   7:  7102c931e2 ! 7:  96ebfd6ec6 branch: add --dry-run for --delete-merged
>       @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
>         git branch (-c|-C) [<old-branch>] <new-branch>
>         git branch (-d|-D) [-r] <branch-name>...
>         git branch --edit-description [<branch-name>]
>       --git branch (--delete-merged <branch>)... [<pattern>...]
>       -+git branch [--dry-run] (--delete-merged <branch>)... [<pattern>...]
>       +-git branch (--delete-merged <pattern>)... [<branch-pattern>...]
>       ++git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
>         
>         DESCRIPTION
>         -----------
>       -@@ Documentation/git-branch.adoc: A branch that a surviving branch depends on through a chain of local
>       - upstreams is kept, so a branch is never deleted out from under stacked
>       - work.
>       +@@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into its upstream is
>       + silently skipped. Delete it with `git branch -D` if you want to
>       + remove it anyway.
>         
>        +`--dry-run`::
>        +	With `--delete-merged`, print which branches would be
>       @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
>         			char *refname = name + branch_name_pos;
>         			if (!(flags & DELETE_BRANCH_QUIET))
>         				printf(remote_branch
>       +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
>       + 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
>       + 				      flags);
>       +
>       +-	if (!ret)
>       ++	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
>       + 		clear_deleted_upstreams(&protected_branch_names,
>       + 					&deletable_branch_names);
>       +
>        @@ builtin/branch.c: int cmd_branch(int argc,
>         	int delete = 0, rename = 0, copy = 0, list = 0,
>         	    unset_upstream = 0, show_current = 0, edit_description = 0;
>       @@ builtin/branch.c: int cmd_branch(int argc,
>         	int noncreate_actions = 0;
>         	/* possible options */
>        @@ builtin/branch.c: int cmd_branch(int argc,
>       - 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
>       - 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
>       + 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
>       + 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
>         			PARSE_OPT_NONEG, parse_opt_strvec),
>        +		OPT_BOOL(0, "dry-run", &dry_run,
>        +			N_("with --delete-merged, only print which branches would be deleted")),
>       @@ builtin/branch.c: int cmd_branch(int argc,
>        
>         ## t/t3200-branch.sh ##
>        @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected merged branches' '
>       - 		git checkout -b tracks-other other/main --track &&
>       + 		git checkout -b tracks-other --track other/main &&
>         		sha=$(git rev-parse --short merged) &&
>         
>        +		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
>       @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
>         		echo "Deleted branch merged (was $sha)." >expect &&
>         		test_cmp expect actual &&
>        @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
>       - 		git checkout -b topic feature --track &&
>       + 		git checkout -b topic --track feature &&
>         		git commit --allow-empty -m "topic work" &&
>         
>        -		git branch --delete-merged origin/next 2>err &&
>       @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a
>         		check_branches <<-\EOF &&
>         		feature
>         		main
>       -@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
>       - 		git checkout -b tip mid --track &&
>       +@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstream of a protected
>         		git commit --allow-empty -m "tip work" &&
>       + 		sha=$(git rev-parse --short lower) &&
>         
>       -+		git branch --dry-run --delete-merged origin/next \
>       -+			--delete-merged lower >actual 2>&1 &&
>       -+		test_must_be_empty actual &&
>       ++		git branch --dry-run --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
>       ++		echo "Would delete branch lower (was $sha)." >expect &&
>       ++		test_cmp expect actual &&
>        +
>        +		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
>        +		cat >expect <<-\EOF &&
>       @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain
>        +		EOF
>        +		test_cmp expect actual &&
>        +
>       - 		git branch --delete-merged origin/next \
>       - 			--delete-merged lower >actual 2>&1 &&
>       - 		test_must_be_empty actual &&
>       + 		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
>       + 		echo "Deleted branch lower (was $sha)." >expect &&
>       + 		test_cmp expect actual &&
>        @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
>         	)
>         '
> 

