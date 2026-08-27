Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE5175D53
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844423; cv=none; b=tbcgf7gWZBS4SkbMgmllKgAkB08vZt25ZUBhOWsYxS82Cysj3vjbuHlw+I+LZA5wdKXX9+LNnuVozQrcwxc1esLsp42OW2epNhnaprujiJdfZo/i5Gp2wtFXEcDGKMqrL9BbAjWdqJY8mZNQXIcnk1Ql35Y7dvmmkAoUo4VZ4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844423; c=relaxed/simple;
	bh=nPzM7GaQKBvx2P2YhA8PdYBH2KelOwcZGMLx4iPxbMM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HF0TxjP/XYtSwH4qZuBoLSGwCnhyMV0cDTeEuMwfE4l/UN9y9hqThobEcXNumEgTILTA5CA6egp4JAmMHxx2CsfppibC2GsTkOZXpfiX12+GgZMb4LC8EkJ8RV7JpNvjBshq/ZYCTvMzgvdn3BvaW+X8lLL8Bsn+suPdlPCA5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r411nPd6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r411nPd6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so791923f8f.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844420; x=1788449220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPSNA3yL7xPM2gHeh/zz6XdUYBnzXUhDYSf33oPnm/c=;
        b=r411nPd6glusmF6RGTLch5H4ex7WFEniWZllmoSWb+gC0EeYlx+cdjipksivK5/NQU
         zvp4G/G9g3otUH3OB71Lv0QssSSG6+rQhOK6Wyad2qGYxsZ2nAm9FsgvWWsiUi0J5s3y
         Wcj8Qy/Lb/YXb4nEQhwK/nUXHskK9+NMGexISMGy9IJNy9TLCEuN11v5kqGC5Wu9VxG5
         OojflY9SqXa9c2o1wT9hFRfWRrXKz0OdflmN/Z8iYy5mfTzsBBuBeJn3TMrRTeSFW5KK
         QPnVs9kUHfHlH2WZNPiT2WDdgL8m/8g9K4JenC4ENUTVqJU3qZaYYaYdsd1NvaxcfnZP
         KmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844420; x=1788449220;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPSNA3yL7xPM2gHeh/zz6XdUYBnzXUhDYSf33oPnm/c=;
        b=OW3tuXgwWmdIgisqlIT8cZ9Or1evgX5TFcgY+S0aMrl346jgWJfPt0WRUYuQhm8mSm
         s83oAL8UhlH5EtewnbYCGd8MLtwAFGpCbEWYA+/raEoTfdHTvWf6w+b+nGbaBrTHeFtM
         jOLrp9Iqy3RaA5IhS6MA9ehogUgRdGLIo5H3twOH/cC9/SxswtqD3m17YvkyVmgjfqD2
         MafTkpRmdPh/iw9CE9Htrhm4CLZS/Sn3iML2tffBd9dn7O6nCjNYeLMw8Qu3GVs+3III
         wmP52MoqZogPE5ZMkj43sIQyR82OyPAbVC1+Bxr16pzIZh8/UFKzoP4TjTnCvrbu4VyP
         uSiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQ1wgDKCl3nvzP7yogv0AEOrBqApLh9WEAJ4Smssgbq5gxv4+owyDuRafCOsGdQL6oqks=@vger.kernel.org
X-Gm-Message-State: AFuF++lhppa/aq+twKVQwp5YRjFGnY8JquB3zO9wnT3IUUcnTzfQljuh
	VWrj6kOFNT8aFfyrLWqYt91MjMMm6KxGi4NrFdEYwvKZ51YO5JfMfo3PnemvdQ==
X-Gm-Gg: AR+sD12VkT9yD2xG55HiZKp2UeU/WxuwGhW81j6BxzOVV0hmnbTC885U2ESnujgREhQ
	hr8z0o+yIQCTtgME89sUpY21nj4CePTAoVwqofooJktyVVBmoOjqbyG86vwQZL5npnqf+/COuE1
	vEtx6+MzDwIegb9HLUxQCO7pUhis4dQ/xTKbfsdCNE8CJOo7si0TJFNWioUosoT+P/7u6nHvfth
	t/4hQz9b5Uas3zcQO54ZNi+aNBxcCO5gTLS/Yykv2V2L+7OLcGXJcJ0NdYcyfOJbIPctQ7juW4b
	OU1FWYX9b2qihs5LQmrH60x4w8/cZdg25wAWT6Pju13OtylrA/MgnNFhKy+joUUaJJBWQK9nh2q
	atXSfPPHj1XozJiescL2sz4pEJCQx7l6g/700It9gGNtgYFJURlSWSR41IOSaMehQLFG8nCJKuv
	0aEqU3tSfJguMHQFSJAAbynwA8DU2m9po7PRuY4+MsB2dFNmYyRLh6ANCcaqPeZlzGH0p/WQsBq
	9YbtHulp5lBUqxsI9vj0/+pF2DAlabWKVOpLo9LiXjDHHn5ny0Jqg==
X-Received: by 2002:a05:600c:198a:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-499dc7019ebmr184345475e9.6.1787843977803;
        Thu, 27 Aug 2026 08:19:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b494228bfsm57360435e9.2.2026.08.27.08.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:19:37 -0700 (PDT)
Message-ID: <e78b522f-24a2-4913-80a0-4213f421d2bd@gmail.com>
Date: Thu, 27 Aug 2026 16:19:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] commit: refuse partial commits during conflict
 resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
 <e0be8cdf63446e0535e020abbff2ec209cb518d4.1787792534.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e0be8cdf63446e0535e020abbff2ec209cb518d4.1787792534.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 27/08/2026 02:02, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Similar to the previous commit, just as `git commit --amend` is a
> foot-gun during conflict resolution, so is a partial commit (`git commit
> <paths>`).  Recording a conflict resolution is about capturing the state
> of the entire tree on top of HEAD, not a subset of paths.  For many
> years we have rejected partial commits in the middle of
>    - a merge
>    - a cherry-pick
>    - a rebase that stopped at a pick
> 
> but, just like amending, this was never extended to the other
> operations that can also leave conflicts to resolve:
>    - an `am` operation
>    - a revert
>    - a rebase that stopped for conflict resolution
> 
> Reuse sequencer_ongoing_operation(), introduced for the analogous
> `--amend` check, to detect all of these and refuse the partial commit.

Good idea and the changes look good too

Thanks

Phillip


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c                | 22 ++++++++++++++-------
>   sequencer.h                     |  5 +++--
>   t/t3404-rebase-interactive.sh   | 34 +++++++++++++++++++++++++++++++++
>   t/t3507-cherry-pick-conflict.sh | 11 +++++++++++
>   t/t4151-am-abort.sh             | 11 +++++++++++
>   5 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 4a6054aae0..9da3f1191b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -515,13 +515,21 @@ static const char *prepare_index(const char **argv, const char *prefix,
>   	 */
>   	commit_style = COMMIT_PARTIAL;
>   
> -	if (whence != FROM_COMMIT) {
> -		if (whence == FROM_MERGE)
> -			die(_("cannot do a partial commit during a merge."));
> -		else if (is_from_cherry_pick(whence))
> -			die(_("cannot do a partial commit during a cherry-pick."));
> -		else if (is_from_rebase(whence))
> -			die(_("cannot do a partial commit while resolving a commit that became empty."));
> +	switch (sequencer_ongoing_operation(the_repository, whence)) {
> +	case ONGOING_NONE:
> +		break;
> +	case ONGOING_MERGE:
> +		die(_("cannot do a partial commit during a merge."));
> +	case ONGOING_CHERRY_PICK:
> +		die(_("cannot do a partial commit during a cherry-pick."));
> +	case ONGOING_REBASE_EMPTY:
> +		die(_("cannot do a partial commit while resolving a commit that became empty."));
> +	case ONGOING_REVERT:
> +		die(_("cannot do a partial commit during a revert."));
> +	case ONGOING_AM:
> +		die(_("cannot do a partial commit during an am session."));
> +	case ONGOING_REBASE_CONFLICT:
> +		die(_("cannot do a partial commit while resolving conflicts during a rebase."));
>   	}
>   
>   	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> diff --git a/sequencer.h b/sequencer.h
> index 3a4bd97db1..634d1ddcb3 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -279,8 +279,9 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   
>   /*
>    * An in-progress operation that records its result (often a conflict
> - * resolution) as a new commit on top of HEAD, during which amending
> - * HEAD via "git commit --amend" is almost always a mistake.
> + * resolution) as a new commit on top of HEAD.  Some ways of invoking
> + * "git commit" -- amending HEAD, or a partial commit -- are almost
> + * always a mistake during such an operation.
>    */
>   enum ongoing_operation {
>   	ONGOING_NONE = 0,
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7cf06e5f9a..1314b0fd05 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1971,6 +1971,40 @@ test_expect_success 'commit --amend is refused at an apply-backend conflict stop
>   	)
>   '
>   
> +test_expect_success 'partial commit is refused at a rebase conflict stop' '
> +	test_when_finished "git rebase --abort" &&
> +	git checkout --detach conflict-branch &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 3" &&
> +		export FAKE_LINES &&
> +		test_must_fail git rebase -i A
> +	) &&
> +	echo resolved >conflict &&
> +	git add conflict &&
> +	test_must_fail git commit conflict 2>err &&
> +	test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
> +'
> +
> +test_expect_success 'partial commit is refused at an apply-backend conflict stop' '
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
> +		echo resolved >file &&
> +		git add file &&
> +		test_must_fail git commit file 2>err &&
> +		test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
> +	)
> +'
> +
>   test_expect_success 'todo has correct onto hash' '
>   	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
>   	onto=$(git rev-parse --short HEAD~4) &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 42de398f76..c3d024c97f 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -375,6 +375,17 @@ test_expect_success 'commit --amend of revert fails' '
>   	test_grep "in the middle of a revert -- cannot amend." err
>   '
>   
> +test_expect_success 'partial commit during a revert fails' '
> +	pristine_detach initial &&
> +
> +	test_must_fail git revert picked &&
> +	echo resolved >foo &&
> +	git add foo &&
> +	test_must_fail git commit foo 2>err &&
> +
> +	test_grep "cannot do a partial commit during a revert." err
> +'
> +
>   test_expect_success 'successful revert does not set REVERT_HEAD' '
>   	pristine_detach base &&
>   	git revert base &&
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 9313a074b2..c80269e015 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -74,6 +74,17 @@ test_expect_success 'commit --amend during a failed am fails' '
>   	git am --abort
>   '
>   
> +test_expect_success 'partial commit during a failed am fails' '
> +	git reset --hard initial &&
> +	cp file-2-expect file-2 &&
> +	test_must_fail git am 000[1245]-*.patch &&
> +	echo resolved >file-1 &&
> +	git add file-1 &&
> +	test_must_fail git commit file-1 2>err &&
> +	test_grep "cannot do a partial commit during an am session." err &&
> +	git am --abort
> +'
> +
>   test_expect_success 'am -3 --skip removes otherfile-4' '
>   	git reset --hard initial &&
>   	test_must_fail git am -3 0003-*.patch &&

