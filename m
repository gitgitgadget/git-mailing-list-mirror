Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802141;
	b=doiwXMsQfjqpvE42EHxWRJsHuXJZ4hcvMalw1MxQyL6fHLDmdGJfKSoIa8gYfjw+OF5a
	 O4Yv0xkkLy5ww7r09OqF5Ke5aoTW0T7TPJrcJQi6m25UTHneapUwrz/OBz7RqiWQ0orwe
	 vadslIWOO80BWdTMpfxfchNuiBVnhvltnqi4jAPmX54gNIi9OVGyVqylGk3zpyu+H/lOz
	 iBVKCuw5D9hRg7yUqmxzi8Atceoj1Hu+G9yhuh/I1uQ/ta8GdQ6Pz3OmMA5sti996xFsq
	 uu54S/s8NyhB4YcesOdFCE125Sm2DNtVnrVIIdlrMcq3ww6L2EHkpvtTwlBaARZatGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VOHHXg3hqE9TkQiiJ1i60IbVfuXpMF7jdNJLtIG7izo=;
	b=UdbfuPLigNhhUdYm40+Ex3J0YdTcGxDxyG02IWDLCExw/atyRCQZXQtctlAb0xNW2Nl8
	 3+ltFlAxRPlgDrMrEKNYbNMl13i05TnrnkKM4jpqPYCPfxYK8PlhGvlPGAbehfyoklFtx
	 xUrCg4euVqHMJs3SsiZ1PdNfBLSTGg/DYswJKQaQZ96lUNjpY6TmKrQCJXLJx7kLp1yBh
	 jZvBA24peW1rq2nnY7foiaOFDT+3Qmqb4Yqy9XjZDEXiEEwN2Z0+LkjhtYKfy4SuONw8h
	 FQ6K7StRTThiqyboqo7JhcYS3Q7IHhIeuyFqX6WCIW/aq/k+WNFRQLQR1JTexKZtktA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtwMMjms;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC81606A32C
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC81606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtwMMjms
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so6404295e9.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802139; x=1794406939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOHHXg3hqE9TkQiiJ1i60IbVfuXpMF7jdNJLtIG7izo=;
        b=FtwMMjmsARYdmekCgKYwMPrtUwVrkLkPD2I8CkfGCHlhvZrRiCNbXVYtgOs8dRm2EC
         aCZZdLytjz6EERmmrhJEIakY4CKelbx0r3+DgWmHjYcTKKQV9VLurcGxTMEIvjEfQjdQ
         YU93JdbFs9spAD4XDocXjpq+7ninngQ93yt0VctgK0s4U6v8Dc31yuexa8Hb4WM76V6M
         zXqCI3rXKSUWo4O6FLZD/skdS/JDaZufDnpVDCqyJVA5okKRfYohFqDCs1CWqwGATETq
         BKOQgttNFp0sEMYIx5hmkdYzDGhejb2XuSMk3YUiZ0AaL56wMqqE/Rfm7pf6R5IfO425
         y0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802139; x=1794406939;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOHHXg3hqE9TkQiiJ1i60IbVfuXpMF7jdNJLtIG7izo=;
        b=McnBz+DTLYGptzVuJ6bkqnHNm/LcedNPbh4Xl3jbmN4gXH6fBn2afuVoOlj+uSeL78
         rH9xgzwRAIGe1RryXhvH0hwMjfdClp5iUo8yyroz85YQ+sNTX1531HV4FgQ+iBT5t3AJ
         kg9wBCfqmgPT4LADDjY8H2B4kH1D+NHZ6iflH1PYbzJlne1blGV5oCGZj7MeuCdil8uY
         y2VF635RE/oDZ5PJa8Z7LfVypPEXzbZDNBX9P5lE0imiFE6WMyRSKhfRp+dITPiNczWn
         kGT6rDazp27e4mGjVyzdHra6BigWP03UZA3huPMYt0yQBc2suEotL2JWP0zWPIEWyrna
         AG6w==
X-Forwarded-Encrypted: i=1; AKwUvBwkx+RnRpKuJrSmaEJbVEwbts4S2QXesDd80eK5JHdYwXfjb//vICdZQ58eQq88rBKszWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IYxq/b4IDBRpCWVrlnHyCKHJv+42Ws9Dr79LJra9hPO/nthGa
	RVgd4MrO7ayRrnQ9BQqPm92qUWCt2aWO9etjnGoG8E3W0u6xnIjxp16v
X-Gm-Gg: AYBFou18nvq3BdSCmvd9GXdY2oeLReEMd9rgcCA1rb2/CAqxFgieqs89+HlT7/tTDkj
	h/DwE9k1DEZQ5gxBCJPNH165EjcXr1lUeBTx/upG+I4hKTe2HJPYB21JkxUHUqNBhkb7qpywL3h
	dFhu1HPtLWDNovTOk8dTke4+QnrTva3b4MuKU8Drx/AbAylYPOWvbp+5lQ9wQWvdTSXdn6Dl8Kj
	HIs8Mbhs4g3udjuKJQEdDvf/c+N9m1vBHCEJNRIeV4thj1G5w0HWsUkPL4K+LeRFeZEVWNVG3N1
	fCZAjwVaNpQ0JmhbP0VT6cIlmHMM3twFLtolCDHo8ye/yiGaOmZ2T++HJbqtZNrpQmtNFq2gFgS
	QJaMMllpMpzzWMGEQrYdnWjsXzDZXLytKlidSTbFlcRn/A8VPUTQg5T1W6IuXIb3xZiw6PSWhhe
	oBOmf8Hg/JxcRcvbAZiVZnk+ghEpG+QzHrC+uoejVf86YbYKnQQx6y5SgFX6pnxiOs9elEj1rUi
	6Q84aSdCziXVs2SyDgLFpHBXumlVlqNQDB/zY0VVFAwjLRlJBt9Dn4Tx/FyCbz8lw1KrKgr2r86
	RwB1Y/8zTGYJbZmeMEHkm2yuKahWaqAlqUw0qePbcMVu/ew3CWfBkPjJJA6v9VR+Nc5WQ35Vvmi
	RU85H887FvVMQutpMHTWKMDQ3O+rvNxqT
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ac151a84f0mr373555185e9.3.1793802138409;
        Wed, 04 Nov 2026 06:22:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:483d:7f57:1b4d:f762? ([2a0a:ef40:724:6601:483d:7f57:1b4d:f762])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm233283515e9.3.2026.11.04.06.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:22:17 -0800 (PST)
Message-ID: <5c68ca5e-bee7-42c7-9693-2e1e941abc81@gmail.com>
Date: Wed, 4 Nov 2026 14:22:21 +0000
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
Subject: Re: [PATCH v2] sequencer: refuse to pick or revert shallow boundary
 commits
Reply-To: phillip.wood@dunelm.org.uk
To: Nakul V S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Nakul V S <vsnakul@gmail.com>
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
 <pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2026 14:05, Nakul V S via GitGitGadget wrote:
 >
>      Changes since v1:
>      
>       * Also refuse cherry-pick and rebase (merge, interactive and --apply
>         backends), as suggested by Phillip.
>       * Check when the list of commits is built rather than in
>         do_pick_commit(), so a refused command leaves no state behind. Uses a
>         single shared helper.
>       * --allow-shallow-boundary is now accepted by cherry-pick as well, and
>         is saved across --continue.
>       * Dropped the option from the revert synopsis.
>       * rebase --autostash restores the user's changes if the rebase is
>         refused.

Sounds good

>      Not covered here: git commit --amend, and pick/revert lines typed into
>      the rebase todo by hand.

As Junio said, we can add those later.

> diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
> index f4cd8b9db7..ff6f1bf01d 100644
> --- a/Documentation/git-cherry-pick.adoc
> +++ b/Documentation/git-cherry-pick.adoc
> @@ -178,6 +178,15 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
>   	Pass the merge strategy-specific option through to the
>   	merge strategy.  See linkgit:git-merge[1] for details.
>   
> +--allow-shallow-boundary::
> +	By default, 'git cherry-pick' refuses to pick a commit that is a
> +	shallow boundary (i.e. a commit listed in `.git/shallow`).
> +	Its parents are missing from this repository, so it looks like
> +	a root commit that added every file in its tree, and picking it
> +	would add all of them.  This option overrides that safeguard.

Unless someone can come up with a realistic use for this option I'd be 
inclined to drop it.

> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 6536ebdc90..ed2ce2d46a 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -822,6 +822,13 @@ repository that you share.
>   See also <<RECOVERING_FROM_UPSTREAM_REBASE,RECOVERING FROM UPSTREAM REBASE>>
>   below.
>   
> +If the commits to be rebased include a shallow boundary commit (a
> +commit listed in `.git/shallow`), the rebase refuses to start, because
> +the missing parents make that commit look like a root commit that added

I think
	because it looks like a root commit. Run `git fetch --unshallow`
	to fetch the missing history first.

would be sufficient

> +every file in its tree.  This applies to both the `merge` and `apply`
> +backends, and nothing is changed when the rebase is refused.  Run
> +`git fetch --unshallow` to get the missing history first.
> +

> diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
> index ffba365e63..288eddcf6e 100644
> --- a/Documentation/git-revert.adoc
> +++ b/Documentation/git-revert.adoc
> @@ -122,6 +122,16 @@ include::rerere-options.adoc[]
>   	configuration variable can be used to enable this option by
>   	default.
>   
> +--allow-shallow-boundary::
> +	By default, 'git revert' refuses to revert a commit that is a
> +	shallow boundary (i.e. a commit listed in `.git/shallow`).
> +	Its parents are missing from this repository, so it looks like
> +	a root commit that added every file in its tree, and reverting
> +	it would remove all of them.  This option overrides that
> +	safeguard.

As above, do we really need this option?

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 535db60181..2305a3a495 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -34,6 +34,7 @@
>   #include "sequencer.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> +#include "shallow.h"
>   #include "trace2.h"
>   #include "hook.h"
>   #include "trailer.h"
> @@ -288,6 +289,8 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
>   	return write_basic_state(opts, head_name, onto, orig_head);
>   }
>   
> +static int cleanup_autostash(struct rebase_options *opts);
> +

Lets move cleaunup_autostash() in a separate, preparatory, commit, 
rather than littering the code with unnecessary forward declarations.

>   static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   {
>   	int ret = -1;
> @@ -309,6 +312,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   				    &make_script_args, flags);
>   	if (ret) {
>   		error(_("could not generate todo list"));
> +		/* Nothing has been started yet; put back what we stashed */
> +		cleanup_autostash(opts);

Is this related to the other changes in this patch?

>   		goto cleanup;
>   	}
>   
> @@ -618,6 +623,55 @@ static int move_to_original_branch(struct rebase_options *opts)
>   	return ret;
>   }
>   
> +/*
> + * The "apply" backend does not go through the sequencer, so check here that
> + * none of the commits "git format-patch" is about to turn into patches is a
> + * shallow boundary commit.  This walks the same set of commits as run_am().
> + */
> +static int check_no_shallow_boundary_to_apply(struct rebase_options *opts)
> +{
> +	struct rev_info revs;
> +	struct strvec args = STRVEC_INIT;
> +	struct commit *commit;
> +	int ret = 0;
> +
> +	if (!is_repository_shallow(the_repository))
> +		return 0;

It's good that this returns early in non-shallow repositories, but 
cherry-pick detection is expensive as we have to calculate the diff of 
each commit on both sides of the merge-base. Ideally we'd only walk the 
commits once and feed the commit object ids into

	git format-patch --stdin --no-walk=unsorted ...

to generate the patches. The way the code is currently structured makes 
that slightly tricky as it checks out "onto" before generating the 
patches. I think we could move the checkout of "onto" into run_am() so 
that it is separate to the fast-forward case in cmd_rebase(). Then we 
could generate the patches and check for shallow grafts with a single 
revision walk before checking out "onto".

> diff --git a/sequencer.c b/sequencer.c
> index 508ec71792..8d38ac3878 100644
> --- a/sequencer.c
> +++ b/sequencer.c
>   
> +/*
> + * A shallow boundary commit has had its parents hidden, so it looks like
> + * a root commit that added every file at once.  Picking or reverting it
> + * would not do what the user expects, so refuse before anything is
> + * started.
> + */
> +int sequencer_refuse_shallow_boundary(struct repository *r,
> +				      const struct commit *commit, int allow)
> +{
> +	if (allow || !is_shallow_boundary_commit(r, &commit->object.oid))
> +		return 0;
> +	return error(_("commit %s is a shallow boundary commit; its parents "
> +		       "are missing from this clone (use 'git fetch --unshallow' "
> +		       "to get them)"),

I wonder if it would be helpful to add a hint explaining why we refuse 
to cherry-pick, revert or rebase shallow boundary commits. There is 
nothing specific to the sequencer here, so if we want to add checks to 
other commands like "git commit --amend" in the future, maybe this 
should live in shallow.c? Alternatively we may want to use separate, 
more specific messages in each case.

> +		     oid_to_hex(&commit->object.oid));
> +}
> +
>   static int walk_revs_populate_todo(struct todo_list *todo_list,
>   				struct replay_opts *opts)
>   {
> @@ -3481,13 +3502,18 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>   	encoding = get_log_output_encoding();
>   
>   	while ((commit = get_revision(opts->revs))) {
> -		struct todo_item *item = append_new_todo(todo_list);
> -		const char *commit_buffer = repo_logmsg_reencode(the_repository,
> -								 commit, NULL,
> -								 encoding);
> +		struct todo_item *item;
> +		const char *commit_buffer;
>   		const char *subject;
>   		int subject_len;
>   
> +		if (sequencer_refuse_shallow_boundary(the_repository, commit,
> +					    opts->allow_shallow_boundary))
> +			return -1;
> +
> +		item = append_new_todo(todo_list);
> +		commit_buffer = repo_logmsg_reencode(the_repository, commit,
> +						     NULL, encoding);

This covers cherry-picking or reverting multiple commits

> @@ -5692,6 +5721,9 @@ static int single_pick(struct repository *r,
>   	int check_todo;
>   	struct todo_item item;
>   
> +	if (sequencer_refuse_shallow_boundary(r, cmit, opts->allow_shallow_boundary))
> +		return -1;

This covers cherry-picking or reverting a single commit.

>   	item.command = opts->action == REPLAY_PICK ?
>   			TODO_PICK : TODO_REVERT;
>   	item.commit = cmit;
> @@ -6078,6 +6110,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
>   	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
>   	int skipped_commit = 0;
> +	int ret = 0;
>   	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
>   	struct strbuf label_from_message = STRBUF_INIT;
>   	struct commit_list *commits = NULL, **tail = &commits, *iter;
> @@ -6141,6 +6174,10 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   		}
>   		if (is_empty && !keep_empty)
>   			continue;
> +		if (sequencer_refuse_shallow_boundary(the_repository, commit, 0)) {
> +			ret = -1;
> +			goto cleanup;
> +		}

This covers "git rebase -r", and on error we cleanup properly - good

> @@ -6394,6 +6432,10 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
>   		}
>   		if (is_empty && !keep_empty)
>   			continue;
> +		if (sequencer_refuse_shallow_boundary(r, commit, 0)) {
> +			ret = -1;
> +			goto cleanup;
> +		}

This covers a regular rebase.


> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 939e7a16a6..49da8427cf 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -256,4 +256,212 @@ test_expect_success 'cherry-pick is unaware of --reference (for now)' '
>   	test_grep "^usage: git cherry-pick" actual
>   '
>   
> +# Tests for shallow boundary safeguard

There are an awful lot of new tests here, many more than there are 
places where we check for a shallow boundary. It would be a good idea to 
check whether each test actually adds any new coverage. Also the rebase 
tests should live in one of the rebase test files (maybe t3400?)

Thanks for re-rolling, this is definitely moving in the right direction.

Thanks

Phillip

> +test_expect_success 'setup shallow boundary tests' '
> +	git init shallow-src &&
> +	test_commit -C shallow-src A &&
> +	test_commit -C shallow-src B &&
> +	test_commit -C shallow-src C &&
> +	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" shallow-repo &&
> +	git -C shallow-repo rev-parse --verify B >boundary &&
> +	test_cmp shallow-repo/.git/shallow boundary
> +'
> +
> +test_expect_success 'revert of shallow boundary commit is refused' '
> +	git -C shallow-repo reset --hard C &&
> +	test_must_fail git -C shallow-repo revert --no-edit B 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/sequencer &&
> +	test_path_is_missing shallow-repo/.git/REVERT_HEAD &&
> +	git -C shallow-repo rev-parse C >expect &&
> +	git -C shallow-repo rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'cherry-pick of shallow boundary commit is refused' '
> +	git -C shallow-repo checkout -q --detach C &&
> +	git -C shallow-repo rm -rq . &&
> +	git -C shallow-repo commit -q -m empty &&
> +	git -C shallow-repo rev-parse HEAD >expect &&
> +	test_must_fail git -C shallow-repo cherry-pick B 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	git -C shallow-repo rev-parse HEAD >actual &&
> +	test_cmp expect actual &&
> +	git -C shallow-repo reset -q --hard C
> +'
> +
> +test_expect_success 'revert of non-boundary commit in shallow repo works' '
> +	git -C shallow-repo revert --no-edit C &&
> +	git -C shallow-repo reset -q --hard C
> +'
> +
> +test_expect_success 'multi-commit revert is refused before anything is reverted' '
> +	test_must_fail git -C shallow-repo revert --no-edit C B 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/sequencer &&
> +	git -C shallow-repo rev-parse C >expect &&
> +	git -C shallow-repo rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--allow-shallow-boundary overrides the revert check' '
> +	git -C shallow-repo revert --no-edit --allow-shallow-boundary B &&
> +	test_path_is_missing shallow-repo/B.t &&
> +	git -C shallow-repo reset -q --hard C
> +'
> +
> +test_expect_success '--allow-shallow-boundary overrides the cherry-pick check' '
> +	git -C shallow-repo checkout -q --detach C &&
> +	git -C shallow-repo rm -rq . &&
> +	git -C shallow-repo commit -q -m empty &&
> +	git -C shallow-repo cherry-pick --allow-shallow-boundary B &&
> +	test_path_is_file shallow-repo/B.t &&
> +	git -C shallow-repo reset -q --hard C
> +'
> +
> +test_expect_success '--allow-shallow-boundary survives --continue' '
> +	test_commit -C shallow-repo conflict-1 file one &&
> +	test_commit -C shallow-repo conflict-2 file two &&
> +	test_must_fail git -C shallow-repo revert --no-edit \
> +		--allow-shallow-boundary conflict-1 B &&
> +	echo resolved >shallow-repo/file &&
> +	git -C shallow-repo add file &&
> +	git -C shallow-repo revert --continue &&
> +	test_path_is_missing shallow-repo/B.t &&
> +	git -C shallow-repo reset -q --hard C
> +'
> +
> +test_expect_success 'revert and cherry-pick in a non-shallow repo are unaffected' '
> +	git init full-repo &&
> +	test_commit -C full-repo A &&
> +	test_commit -C full-repo B &&
> +	git -C full-repo revert --no-edit B &&
> +	git -C full-repo cherry-pick B &&
> +	test_path_is_file full-repo/B.t
> +'
> +
> +test_expect_success 'rebase of a range containing a shallow boundary is refused' '
> +	git -C shallow-repo checkout -q --detach C &&
> +	git -C shallow-repo rev-parse C >expect &&
> +	test_must_fail git -C shallow-repo rebase --root 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/rebase-merge &&
> +	git -C shallow-repo rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --rebase-merges is refused as well' '
> +	test_must_fail git -C shallow-repo rebase --rebase-merges --root 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/rebase-merge
> +'
> +
> +test_expect_success 'rebase --apply of a range containing a shallow boundary is refused' '
> +	git -C shallow-repo checkout -q --detach C &&
> +	git -C shallow-repo checkout -q --orphan unrelated &&
> +	git -C shallow-repo rm -rfq . &&
> +	test_commit -C shallow-repo unrelated &&
> +	git -C shallow-repo checkout -q --detach C &&
> +	git -C shallow-repo rev-parse C >expect &&
> +	test_must_fail git -C shallow-repo rebase --apply \
> +		--onto unrelated unrelated 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/rebase-apply &&
> +	git -C shallow-repo rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --apply restores an autostash when refusing' '
> +	echo dirty >shallow-repo/C.t &&
> +	test_must_fail git -C shallow-repo rebase --apply --autostash \
> +		--onto unrelated unrelated 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	echo dirty >expect &&
> +	test_cmp expect shallow-repo/C.t &&
> +	git -C shallow-repo stash list >stashes &&
> +	test_must_be_empty stashes &&
> +	git -C shallow-repo checkout -q -- C.t
> +'
> +
> +test_expect_success 'rebase --apply that does not replay the boundary is unaffected' '
> +	git -C shallow-repo checkout -q -B apply-topic C &&
> +	test_commit -C shallow-repo E &&
> +	git -C shallow-repo rebase --apply --onto unrelated C &&
> +	test_path_is_file shallow-repo/E.t
> +'
> +
> +test_expect_success 'rebase that does not replay the boundary is unaffected' '
> +	git -C shallow-repo checkout -q -B topic C &&
> +	test_commit -C shallow-repo D &&
> +	git -C shallow-repo rebase C
> +'
> +
> +test_expect_success 'rebase restores an autostash when refusing (merge backend)' '
> +	git -C shallow-repo checkout -q --detach C &&
> +	echo dirty >shallow-repo/C.t &&
> +	test_must_fail git -C shallow-repo rebase --autostash --root 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/rebase-merge &&
> +	echo dirty >expect &&
> +	test_cmp expect shallow-repo/C.t &&
> +	git -C shallow-repo stash list >stashes &&
> +	test_must_be_empty stashes &&
> +	git -C shallow-repo checkout -q -- C.t
> +'
> +
> +test_expect_success 'interactive rebase restores an autostash when refusing' '
> +	echo dirty >shallow-repo/C.t &&
> +	test_must_fail env GIT_SEQUENCE_EDITOR=: \
> +		git -C shallow-repo rebase -i --autostash --root 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_missing shallow-repo/.git/rebase-merge &&
> +	echo dirty >expect &&
> +	test_cmp expect shallow-repo/C.t &&
> +	git -C shallow-repo stash list >stashes &&
> +	test_must_be_empty stashes &&
> +	git -C shallow-repo checkout -q -- C.t
> +'
> +
> +test_expect_success 'rebase onto new upstream work in a shallow clone still works' '
> +	git clone --no-local --depth=1 "file://$(pwd)/shallow-src" shallow-local &&
> +	test_commit -C shallow-local local &&
> +	test_commit -C shallow-src upstream &&
> +	git -C shallow-local fetch origin &&
> +	git -C shallow-local rebase origin/HEAD &&
> +	test_path_is_file shallow-local/upstream.t &&
> +	test_path_is_file shallow-local/local.t
> +'
> +
> +test_expect_success 'single-commit shallow clone: revert and cherry-pick are refused' '
> +	git init one-src &&
> +	test_commit -C one-src only &&
> +	git clone --no-local --depth=1 "file://$(pwd)/one-src" one-shallow &&
> +	git -C one-shallow rev-parse HEAD >expect &&
> +	test_must_fail git -C one-shallow revert --no-edit HEAD 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_must_fail git -C one-shallow cherry-pick -n HEAD 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	test_path_is_file one-shallow/only.t &&
> +	git -C one-shallow rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'revert and cherry-pick work once the clone is unshallowed' '
> +	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" unshallowed &&
> +	test_must_fail git -C unshallowed revert --no-edit HEAD~1 2>err &&
> +	test_grep "shallow boundary commit" err &&
> +	git -C unshallowed fetch --unshallow &&
> +	git -C unshallowed revert --no-edit C &&
> +	test_path_is_missing unshallowed/C.t &&
> +	git -C unshallowed cherry-pick C &&
> +	test_path_is_file unshallowed/C.t
> +'
> +
> +test_expect_success '--allow-shallow-boundary cannot be combined with --abort' '
> +	test_must_fail git -C shallow-repo revert --abort \
> +		--allow-shallow-boundary 2>err &&
> +	test_grep "cannot be used with" err
> +'
> +
>   test_done
> 
> base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7

