Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756F2D7DD4
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843969; cv=none; b=PVg9sR5dDpMFVaAKKyY2KW/CCWTExlIAZLRzOSH+rhd5Q/2+rLcoV5npb5yCiEEGw9f8JyPN4FGtSiQHH2YFkWpxPtC61swWT8XtAgvPEHTbTCv0ozDRawUJph+jWKuDWNnzrrbCbFqJ2VefmqAYM9K6V3xbBmqR/I1RSLVKjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843969; c=relaxed/simple;
	bh=vemMfJ8CNizemrzvh8P3oAWw/D9pwQPeFycSjOpGoFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NisPS4W1IlFWSav5W0scSDaMA2iWmpPfsmYPo3n3MGUCqWqIxk78xufC/3dTl83YPVfs8bDM34xQK8It45zgerfPm9TzIyCZMnqCzffDuvSClXmWL8TuELXedFSvlbHC3hiqWg7GmY8yLehgJkOJ49Zbgo7dz9A/l543V+KKaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuDQDIdb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuDQDIdb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b14637dfdso5497405e9.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787843966; x=1788448766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRwNpbHxalQNesFIRdBNDibfWoynfmOeJWUHMIUm9PU=;
        b=XuDQDIdbBlxWfLFh4jFYY/NPzV2rV1T5WC6MoqFuIHuHrkK83RvAu2a4O/ZGTuy2kH
         6rY7mRewZ36TNffaCAzKFIVc5Ors0QQQr4Lcd7LSpA6ADv6a+vcX3rS7lf78EJ6b6BW6
         DpBloCVsaD9Tf59AYuOzo1VtzGfAttw0adsdtPUQE5VbzUqfrOurj4NNLq9d76tgJb3y
         AFYeyAsd8TeGcI7t8ihIfhbfGegI0jOisJBt+xkm9mzoh+KoKUPek3QX+0bN3xvDYwnf
         3tPCZqmYUmAkg8loDQyjZrKXjodh22YhUXb6p16i+vA9ZiPl1tEM31ycmyQwosWNZyUx
         jYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843966; x=1788448766;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRwNpbHxalQNesFIRdBNDibfWoynfmOeJWUHMIUm9PU=;
        b=sNdMF5cSykkZw1aP36tT59dn/+VTFYDm8aVwzOakNlYtm0scRbgS+G3TOkc7eeMACd
         xMgHNAYTqL67wFnIpE8txB4U+y4sCKHc3qjeBScgbSyuwm6Re3nXrmTKmN0BmYCKv8Lt
         zr1f2GZfPYH2bNYAxo8Qy/UY30pS33iYIhN9y3rlyUmdogcYsY36YSHbr2JyxnJ4m1WV
         m9rbEA7I04gO4KhJT5jSzQu5FEMmA/KNd6tTXS7jHJBq9o+cSn9SN8kuMCAGrm7v7Ipl
         GRbe+kENL+fwSBjsjQ2xea0Z7mXLJ7+WjUnxK2IoYR+0bbHrizWsE7S1H+Sp3O9Cx9xR
         JS8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpQ/PHVGZypjyF/iCb7nROtjyv5Mj/nbG9P0rsPz0cC40w47ohKHlPLdOAigDfFL4mN9WQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lM0735GFdivId5senptqHtXtUoUYdXlkGpdivwgiDrdrsx5vKc
	wLEgQoxX5Wv0yGfPMMIdmgCj4us5hEI5uxrOcAzl0N2o+2+IRBlSFvao
X-Gm-Gg: AR+sD10S1xrIAgzWEPuNjHCarU0tRdyTWp+eOk5/skfCQ2VQip+rYU38tq1guZE9ETZ
	Cn4NVO9qGpBjTEgwO3+zLrdP9AYagZ07vrqAd0Nh/tH5Uul0PgNxMBIOi7Rg5P8wu6xN4HXZjPb
	wBwjL8f2kjQ7NIr2t10934mT+tPFQMsPry+Nkyn3XjGN+AuzbHZ632joFbaOJWb1YALcjh+PWU1
	Itv9x1h6FrHYcVp8po32reBNLCJWqoIzHzmjfuVOW+rrXZqUlgEw2ZqATQTEfjadiVYnJwG3zeY
	bfmfxTJMibI7gydONxTA783U/7YeAxcxnd8mprpjw7qBLyq+IRlPx4r4HKegstybugcecsq+/Se
	urwqNbLZB6eOWQ+piJa5zunuxOyr9yktty+Cx0oPLO/9GWRD1ZNnm+K+wqBr/1gnUhU7uf835S/
	8DJezF0k52UbZ2ePb6HlDyjvUK4O2RJ41Aq52qu6pEkI1bUvBncyU02pUenq5F9/uzwmCdKhYOH
	EORfWFSh3hr7m+hrYhJDXfiYAHwrWuO1x1CLu6VQdQeGKf7KCLAVQ==
X-Received: by 2002:a05:600c:1c09:b0:49b:8f01:7119 with SMTP id 5b1f17b1804b1-49b8f017186mr73313635e9.14.1787843965345;
        Thu, 27 Aug 2026 08:19:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e2756112sm10602392f8f.0.2026.08.27.08.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:19:24 -0700 (PDT)
Message-ID: <aa248030-5275-465b-a4b5-683ca374672c@gmail.com>
Date: Thu, 27 Aug 2026 16:19:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] commit: refuse to amend during conflict resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
 <4a1461e52767227d9475de13cf250484f8ecd271.1787792534.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <4a1461e52767227d9475de13cf250484f8ecd271.1787792534.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 27/08/2026 02:02, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0d908d72bb..4a6054aae0 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1326,15 +1326,30 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		use_editor = 0;
>   
>   	/* Sanity check options */
> -	if (amend && !current_head)
> -		die(_("You have nothing to amend."));
> -	if (amend && whence != FROM_COMMIT) {
> -		if (whence == FROM_MERGE)
> +	if (amend) {
> +		if (!current_head)
> +			die(_("You have nothing to amend."));
> +		/*
> +		 * Refuse to amend in the middle of any operation that is
> +		 * meant to record its result as a new commit on top of HEAD
> +		 * rather than by rewriting HEAD.
> +		 */
> +		switch (sequencer_ongoing_operation(s->repo, whence)) {
> +		case ONGOING_NONE:
> +			break;
> +		case ONGOING_MERGE:
>   			die(_("You are in the middle of a merge -- cannot amend."));
> -		else if (is_from_cherry_pick(whence))
> +		case ONGOING_CHERRY_PICK:
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));

For rebase we distinguish between a conflict and a commit that becomes 
empty, but we don't do that for a cherry-pick. That's an existing 
problem though, not something we necessarily need to address in this series.

Moving the detection to a separate function and using an enum here is 
much nicer than the previous version.

> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..bd4a724410 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6966,6 +6966,71 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   	return 0;
>   }
>   
> +enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
> +						   enum commit_whence whence)
> +{
> [...]
> +	/*
> +	 * In the middle of a rebase that stopped for conflict resolution?
> +	 * The apply backend only ever stops for conflicts, so the presence
> +	 * of its state directory is enough.  The merge backend writes
> +	 * stopped-sha whenever it hands control back to the user, but omits
> +	 * `amend` unless it stopped with HEAD already pointing at the commit
> +	 * to be amended (a clean edit/reword stop); its absence therefore
> +	 * marks a conflicted stop.
> +	 */
> +	path = repo_git_path(r, "rebase-apply");
> +	found = file_exists(path);
> +	free(path);
> +	if (!found) {
> +		char *stopped_sha = repo_git_path(r, "rebase-merge/stopped-sha");
> +		char *amend_marker = repo_git_path(r, "rebase-merge/amend");
> +
> +		found = file_exists(stopped_sha) && !file_exists(amend_marker);

The sequencer defines rebase_path_stoppend_sha() and rebase_path_amend() 
so we can avoid having to hard code these paths throughout the code. 
Apart from that this all looks good to me.

Thanks

Phillip

> +		free(stopped_sha);
> +		free(amend_marker);
> +	}
> +	if (found)
> +		return ONGOING_REBASE_CONFLICT;
> +
> +	return ONGOING_NONE;
> +}
> +
>   int sequencer_get_update_refs_state(const char *wt_dir,
>   				    struct string_list *refs)
>   {
> diff --git a/sequencer.h b/sequencer.h
> index 64a9c7fb1b..3a4bd97db1 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -277,6 +277,29 @@ int sequencer_get_last_command(struct repository* r,
>   			       enum replay_action *action);
>   int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
>   
> +/*
> + * An in-progress operation that records its result (often a conflict
> + * resolution) as a new commit on top of HEAD, during which amending
> + * HEAD via "git commit --amend" is almost always a mistake.
> + */
> +enum ongoing_operation {
> +	ONGOING_NONE = 0,
> +	ONGOING_MERGE,
> +	ONGOING_CHERRY_PICK,
> +	ONGOING_REBASE_EMPTY,
> +	ONGOING_REVERT,
> +	ONGOING_AM,
> +	ONGOING_REBASE_CONFLICT
> +};
> +
> +/*
> + * Return which in-progress operation, if any, is underway; see enum
> + * ongoing_operation.  'whence' is the origin already computed for the
> + * pending commit.
> + */
> +enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
> +						   enum commit_whence whence);
> +
>   /**
>    * Append the set of ref-OID pairs that are currently stored for the 'git
>    * rebase --update-refs' feature if such a rebase is currently happening.
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 1e78dbfd90..7cf06e5f9a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1884,6 +1884,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	test_grep "resolving a commit that became empty -- cannot amend." err
>   '
>   
> +test_expect_success 'commit --amend is refused at a rebase conflict stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/patch &&
> +	test_path_is_missing .git/rebase-merge/amend &&
> +	echo resolved >conflict &&
> +	git add conflict &&
> +	test_must_fail git commit --amend --no-edit 2>err &&
> +	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +'
> +
> +test_expect_success 'commit --amend is refused when an "edit" pick conflicts' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 edit 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/patch &&
> +	test_path_is_missing .git/rebase-merge/amend &&
> +	echo resolved >conflict &&
> +	git add conflict &&
> +	test_must_fail git commit --amend --no-edit 2>err &&
> +	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +'
> +
> +test_expect_success 'commit --amend is allowed at a rebase edit stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach no-conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="edit 1 2 3 4" &&
> +		export FAKE_LINES &&
> +		git rebase -i A
> +	) &&
> +	test_path_is_file .git/rebase-merge/amend &&
> +	echo tweak >fileJ &&
> +	git add fileJ &&
> +	git commit --amend --no-edit
> +'
> +
> +test_expect_success 'commit --amend is allowed at a rebase break stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach no-conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="break 1 2 3 4" &&
> +		export FAKE_LINES &&
> +		git rebase -i A
> +	) &&
> +	test_must_fail git rev-parse --verify REBASE_HEAD &&
> +	echo tweak >fileJ &&
> +	git add fileJ &&
> +	git commit --amend --no-edit
> +'
> +
> +test_expect_success 'commit --amend is refused at an apply-backend conflict stop' '
> +	test_when_finished "rm -rf apply-backend" &&
> +	test_create_repo apply-backend &&
> +	(
> +		cd apply-backend &&
> +		test_commit base file &&
> +		git branch -M mainline &&
> +		test_commit upstream file upstream &&
> +		git checkout -b side mainline~1 &&
> +		test_commit conflicting file side &&
> +		test_commit unrelated other &&
> +		test_must_fail git rebase --apply mainline &&
> +		# the apply backend only ever stops for conflicts, and
> +		# leaves HEAD on the previously-applied commit
> +		test_path_is_dir .git/rebase-apply &&
> +		test_path_is_missing .git/rebase-apply/applying &&
> +		echo resolved >file &&
> +		git add file &&
> +		test_must_fail git commit --amend --no-edit 2>err &&
> +		test_grep "You are resolving conflicts during a rebase -- cannot amend" err
> +	)
> +'
> +
>   test_expect_success 'todo has correct onto hash' '
>   	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
>   	onto=$(git rev-parse --short HEAD~4) &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 44596cb1e8..42de398f76 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -364,6 +364,17 @@ test_expect_success 'failed revert sets REVERT_HEAD' '
>   	test_cmp_rev picked REVERT_HEAD
>   '
>   
> +test_expect_success 'commit --amend of revert fails' '
> +	pristine_detach initial &&
> +
> +	test_must_fail git revert picked &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	test_must_fail git commit --amend 2>err &&
> +
> +	test_grep "in the middle of a revert -- cannot amend." err
> +'
> +
>   test_expect_success 'successful revert does not set REVERT_HEAD' '
>   	pristine_detach base &&
>   	git revert base &&
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 8e1ecf8a68..9313a074b2 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -63,6 +63,17 @@ do
>   
>   done
>   
> +test_expect_success 'commit --amend during a failed am fails' '
> +	git reset --hard initial &&
> +	cp file-2-expect file-2 &&
> +	test_must_fail git am 000[1245]-*.patch &&
> +	echo resolved >file-1 &&
> +	git add file-1 &&
> +	test_must_fail git commit --amend 2>err &&
> +	test_grep "in the middle of an am session -- cannot amend." err &&
> +	git am --abort
> +'
> +
>   test_expect_success 'am -3 --skip removes otherfile-4' '
>   	git reset --hard initial &&
>   	test_must_fail git am -3 0003-*.patch &&

