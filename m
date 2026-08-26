Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1A346AFB
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752594; cv=none; b=RmKFsyMuHRiB53e6gzzWnmdYojCYWCCB92Cw2GuUHpAawfb96LCFbBH9bfI8fAOYbIVukfgA+RRFxWwqXGsFjlLXurI9BrTDJyE7CXQp8/kqLrFQAEmPF9GaApPewHyxsqU8r5aECHdG+4uNAExkgUjpVQSVh2AG3UbVDacFw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752594; c=relaxed/simple;
	bh=4f6TQl69DSLyCkw8K7Emn6HGEaETj9xD+zX2s3tl7H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwtumwIZl7oOAn5WMzB9j8+VP3Fv1pxjyyTlwJEfLyn6UTxtf+EYasVmB0hW3z9c7YRPnGUBf3VdoH/hT1DuJWh4Qa0meUFBbDadcCiDNb8VK5qZeV3xGm99HdD7GA4buTFBpKfzX36tHsrEktR6dZwBa4VDm1sY1SkshjmNVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxacRLHC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxacRLHC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482dbe4d247so427386f8f.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787752591; x=1788357391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=heyETM23Sz/UqdMrAEXkqM7LLQbjr0JMIpKDmRmR/7g=;
        b=XxacRLHCQdotJlmgc8wlzj8O//wdCgUnKjRm+bVavR4g7cLgkfqD9sIXLETAhUQ+6T
         1FoP5orzJe+YJimlrlWICWashz/STu5oI+m3PvZ+Aj+LNEQF2k9vNjiVHxyLLDurdn2e
         gdZytq0nzzHVV2YwXlkId1EPsRgN9cfVXzyz6TXuP/ouYS6gssBZmiw7bKvGFISKrRh5
         9vgHBghPcS/WgKLwnaucR86w6zeSNcWjvzJq3QToZsEkvTJRq0m21RG9XmLsxqwo1sNX
         Vq8ylfywjjec8e3EDMqxDbUfQMfPHeA7ATvinIQCUXJHGWDEm15KdxgfyZGjL4LxkC8H
         TIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752591; x=1788357391;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heyETM23Sz/UqdMrAEXkqM7LLQbjr0JMIpKDmRmR/7g=;
        b=XQUxPSHGfvp2/JYP7G/6f/1DTchNYuLTtjyXBMu7gCMYR06DoPPOc8Z2VQ+DKgEy8n
         9QUYe3oKhZ+B/k2dL4kw6uKTUBhp0KD35X8NUpfeAYQg90Mb2iakTG1XkT4Tp0VujRJ+
         OIef5qwep1LSduJn/uRxyRfVVGxBLQNLkxd3be5Q+xllAFIVFDrIsCXMLpz5ZOBp5bgn
         thSxlsINspScSnVzN0mSY2GM7wYuMxhw9rEU58yFkyAYGBu3C2VTakpYTnNGhid5hrAj
         RiM7e49+Kc3M2ou5rYG3zw+/vYf4fhqQ/g7pAh2DIso/zfIfkWxqRJ2s0cR6kr5+2wdH
         ULLw==
X-Forwarded-Encrypted: i=1; AHgh+RoO4fPbfH7YJGPsHkVpKMxmYhS+aQmdJGDGrJ8ct12Qe5+zBNtrncjhS7NTZgKEQyR1JkI=@vger.kernel.org
X-Gm-Message-State: AFuF++lAHOLrm+2UkhPGH+0B6R/fy9E9Ev7Iel23rF9j8o/e8pJlSVzq
	rgXjAwF38Jvisokq03QbgIhv/bzPxWASg9Wz31w/qD/ud6ogLjn/Knar
X-Gm-Gg: AR+sD131y1cAaPlEsGHmS+TVPnhXAZT/dI/XKF2dj4BH6Ao6us6rIEVoIrCeD96oA1f
	ExNGi2nXDZKeQdcRtESYWsOgBObSPwkGUctoei0lAyb8IKPOS23u+boR0zC3bDEjQvEEsC8KnII
	POFLg26fPnpedyE9Curgm9W0w/lipAgf7ZFZCRSCMYLrWsVxzCOqfsKfRDHFpPuYSaJKuIUxy6M
	kE/Qide0188wqxMijqnpJ97UiE2XaAgJ3MBbkXIB+ohhdLBf/sQsNboVXbB04B1ydN58BOStfnU
	mYOgcQNkFm9NBJ/uXcKrBzRy/HJzHI8I3z3krTHk8gv4blInuBKDpY6ITIH3380l4AX0mYkWfif
	Kcr4TcGTxkfNWxksGCc2TILu4amsbnWSufCEGHEn+bhmphmjdHofkhkAg43OWGQMDGW9gy1BzgN
	MH9DI/cw8Ojut069uYFT1o6YbUEHn7daApKoU/h3S9gAKdnj9OR7vZh6H5xGMldhy+8KoAa2qTq
	xuD8Qsw34PtarK0m0GnzGtE3Mx0xgrjSqNtSLhEbNMxlpcpDQCfQQ==
X-Received: by 2002:a05:6000:4020:b0:481:4761:45dc with SMTP id ffacd0b85a97d-482e26f1652mr7048098f8f.13.1787752590399;
        Wed, 26 Aug 2026 06:56:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28f5e2fsm2688392f8f.33.2026.08.26.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:56:29 -0700 (PDT)
Message-ID: <4688ee19-b782-456a-bed2-8cd2a4415736@gmail.com>
Date: Wed, 26 Aug 2026 14:56:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 26/08/2026 06:21, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Running `git commit --amend` during conflict resolution is an ugly
> foot-gun.  For many years, we have rejected amending during conflict
> resolution in the middle of
>    - a merge
>    - a cherry-pick
> However, this was never extended to other operations that can also
> produce conflicts:
>    - an `am` operation
>    - a revert
>    - a rebase
> 
> Extend it to handle these other cases now.

Excellent!

> Extending to `am`, revert, and the apply backend of rebase are fairly
> straightforward.  However, with the merge backend of rebase we have to
> be more careful, since it powers interactive rebases and
>    - the interactive machinery internally uses `git commit --amend` for
>      `squash` and `reword` directives
>    - users are expected to `git commit --amend` after hitting an `edit`
>      or `break` directive
> So, we need to be careful with rebase to only reject amending when doing
> conflict resolution.
> 
> A few files under the rebase-merge/ directory provide us the necessary
> information:
> 
>    - stopped-sha is written only when the rebase stops and hands control
>      back to the user, so its presence marks a genuine stop -- as opposed
>      to the sequencer's own internal `git commit --amend` while applying
>      a squash, fixup, or reword, during which no stopped-sha exists.
> 
>    - amend is written only when the rebase stops with HEAD already
>      pointing at the commit the user is meant to amend: a clean `edit`,
>      or a fast-forward `reword`. 

Also a fixup with conflicts, but in that case we do want to allow the 
user to amend even though there are conflicts so it's ok.

>      Its absence at a stop therefore means
>      the commit did not apply, so HEAD is the previously-applied commit
>      rather than the one being rebased -- exactly the case we refuse.
> 
> So for the merge backend we die when stopped-sha exists and amend does
> not.  This covers a plain conflicted pick as well as a conflicted `edit`
> (both leave HEAD on the previously-applied commit), while still allowing
> a clean `edit` or `reword` stop and a `break` stop (no stopped-sha).
> stopped-sha is unlinked at the start of the resume loop, so a resumed
> squash's internal amend is unaffected.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>      commit: refuse to amend during conflict resolution
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v1
> Pull-Request: https://github.com/git/git/pull/2389
> 
>   builtin/commit.c                | 41 ++++++++++++++++
>   t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
>   t/t3507-cherry-pick-conflict.sh | 11 +++++
>   t/t4151-am-abort.sh             | 11 +++++
>   4 files changed, 150 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..a9fd04366e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -30,6 +30,7 @@
>   #include "path.h"
>   #include "preload-index.h"
>   #include "read-cache.h"
> +#include "refs.h"
>   #include "repository.h"
>   #include "string-list.h"
>   #include "rerere.h"
> @@ -1336,6 +1337,46 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		else if (whence == FROM_REBASE_PICK)
>   			die(_("You are in the middle of a rebase -- cannot amend."));
>   	}
> +	if (amend && whence == FROM_COMMIT) {
> +		char *applying, *apply_dir, *stopped_sha, *amend_marker;
> +		int in_am, conflicted_stop;
> +
> +		/* Check middle of revert */
> +		if (refs_ref_exists(get_main_ref_store(the_repository),
> +				    "REVERT_HEAD"))
> +			die(_("You are in the middle of a revert -- cannot amend."));

I think it would be much cleaner to move this check and sequencer 
related ones below into sequencer_determine_whence() so that we don't 
have to hard code the paths here. It might be worth checking for "am" 
and the "apply" based rebase in that function as well.

The logic looks sound to me

Thanks

Phillip

> +		/* Check middle of `am` */
> +		applying = repo_git_path(the_repository,
> +					 "rebase-apply/applying");
> +		in_am = file_exists(applying);
> +
> +		free(applying);
> +		if (in_am)
> +			die(_("You are in the middle of an am session -- cannot amend."));
> +
> +		/* Check middle of rebase specifically stopped for conflicts */
> +		apply_dir = repo_git_path(the_repository,
> +					  "rebase-apply");
> +		stopped_sha = repo_git_path(the_repository,
> +					    "rebase-merge/stopped-sha");
> +		amend_marker = repo_git_path(the_repository,
> +					     "rebase-merge/amend");
> +		/*
> +		 * The apply backend only ever stops for conflicts; the
> +		 * merge backend writes stopped-sha but omits `amend`,
> +		 * which it writes only at a clean edit/reword stop.
> +		 */
> +		conflicted_stop =
> +			file_exists(apply_dir) ||
> +			(file_exists(stopped_sha) && !file_exists(amend_marker));
> +
> +		free(apply_dir);
> +		free(stopped_sha);
> +		free(amend_marker);
> +		if (conflicted_stop)
> +			die(_("You are resolving conflicts during a rebase -- cannot amend."));
> +	}
>   	if (fixup_message && squash_message)
>   		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>   	die_for_incompatible_opt4(!!use_message, "-C",
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff11abb2f2..01d4735b3b 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1884,6 +1884,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	test_grep "middle of a rebase -- cannot amend." err
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
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e

