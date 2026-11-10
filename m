Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329248;
	b=g8Tzre0sjMJI5hCZJIjh756fG/2v/+XeekBtWE9jIJjqdvUpZ4AuywOTLMuoCWxy7kRY
	 sZJk2uTOHwbkh6J2qLFWXkZ8u3uOKkruYcsrvEEeU5WDaDVOWasbAjov45utMMY5BC5SQ
	 WuEabObUEA6FQhapAJ6Un//DNNxtW4Q9610U/qUKy9RNcjSA/dwYVRIQ33nOWMpakpopz
	 k1E0CrhHCK1mKHUaEH89RXg/Ch5l6DkHXlywm2zPylAHRLiDGOAqpc00k2LP9ihN7bzvK
	 SdgGjvXUhDpZCHf1fmxbWUGEXH2TJzvDJINaioHmGjMEOKAdEo0272Rvt73qrGrg1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oDhZU7bfkxCi+GlWVxIz8a05XOlbeIr5q9WqfL31HyY=;
	b=CpVPSOk411rB0d/4UWiPcb5OBEBmfH5tbvjeESJCPmVYkyikc8FPQcklQnGkyvmawR60
	 R4kRvC3iVPEuGicpTxFYCeYqXJH6x6Kw00pEAE+1hM8Arsk3qS4gb6DcvGAq6tKzqtWY/
	 vI2+XJqulgZfzQch2CXQLfGvBZKDrCUyVl7YJIpovmI4MDyay+lAoZ2wz1sSGY0+C/BYr
	 M9OtU2Ms2bE6X12jjpY64vfWX1LyIOCZjOeE72H4b5YAXEsMpU8XfLO9U1AZXO41k3zpL
	 VMBirunpVhc9T5VVTUBdzBu+dqcfDM5lfVnsSRvvQdydtNEJNxBKsms9QhIeL2s2jQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVjgJL8J;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87E60A2613
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF87E60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVjgJL8J
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so22458595e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329246; x=1794934046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDhZU7bfkxCi+GlWVxIz8a05XOlbeIr5q9WqfL31HyY=;
        b=BVjgJL8JIy1NWfcgUxeltSqelVRN5LrZEa3CTWOG1yLkCnsQG14HnFBOriiScmTqgr
         XPF2txtdkqY/1OpVAZN+TqIOA2Y0mETHjqwoQQSmUbCGZNQeR1Yo81IucLnD3jXqL+4I
         ybWVZmhqa62WMzBRMr4DFIndyHFDye+XL6LYAnJtTeadhmNBpNNcIEI3VaoXLZGzXdMd
         O+e37YksRoEmHl9g5X1m6dUoqp0ixq07i2Kr2oE5NbBA6J6k1GoBpJgKdPpH9uvRUIpG
         9o3CaUUO8lVpLdscYhpZYIIDOBXfRnAEba9bhJmwmsGNYQDs73ml8rYaJ6rqItGAwySX
         MjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329246; x=1794934046;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDhZU7bfkxCi+GlWVxIz8a05XOlbeIr5q9WqfL31HyY=;
        b=qIPnVYGpQuraCUQ6Crq5f5wZBUrlzlDndhherCL4Z0mpaNaiYWumi6EZAlFUOU031x
         7MED7XfXn6rQy1+a2Xv27fxUG1Sg9qNFthvWBN0SjRP3U8f//s3l1MxjnU+ipVIKRCyT
         G/JPLvXAHkqwIErKFPD3ZhG+zG1KZbzqQYNMdmpRSt9XRMlRxyQer/7wCUdnWOgX1iY6
         20Ga5yT3Tw21F0XmDqR590OqdgSNNLN/82LNh+dkm3UsEsVxCdha6co0732++rzLqF+O
         AnLRGbnRlG0KS93k1oqazufQlKyGrs6+kYGn43iaQmUWK87D8TLYH+7rcwjVjHzK8qDu
         iA5g==
X-Forwarded-Encrypted: i=1; AL+hErHkBaq/cVroZnjkiRnBRWE/Q5w1LDWFyYVXtTLmCbQhHDC0XRILmFkfrPPrpK7mCNpE9Fs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s7ayI2YfoR08KeJRUuNSHWTIoMxra4zUiUUzn8fViuyQkuXVM
	PE3o7GyKXNVv0p4N5CMvJY9Re8LKUt2/RvkGF7ubTNjOFGRmWb9FJHgA
X-Gm-Gg: AYBFou15ftcBcegBmam6tV2TJXwGJaeISfTm6me5n79xDJvOB0I4Rqs5hfQoVuTkSw/
	eci7moJduklSvzJ+765WxctA4c9wBqWaQNPkxEW5VLGzDJ+Ydra02RfIC4jITv0yAzWpPsS2U7k
	MbMBCY9Q+VLMuWhEzYE6WHQZSF/YhiPqzHKKNnojZsc4fPJniobDSWPA+wD3a/VgXRxFElCCQJg
	+QGRJA5GObVNJoEQGfltDpyC0b7nhQINggwOSqh4+VMdNvaOjLvBaGY1SwH7+k2m/t8lwhH/bNq
	lrdPJwHq0KWjXBqXkOLg5HYcy+hHttR9fjzw59JfbZEjChzaW+7YzyXm9mKhRXjm3hEHO7ffnJh
	dHDGIUfnUhn+UQ4sSZs44IbrwzUj1KoYNVXLT2G37blzan9m9YwsPIvrAgxPAioK0dzT/2OI3PD
	nBCshf/e9Kj7+ynhVFCodKURdyw7nx4ATA130NC/MFqrkNtUNQmKGsOaT2lsJua2AKfNDlV6bMY
	rGLnH3oF+PLXgtQsx+YcHuBD4veebVS1fDUs9ZCpjHNa5Nqc6n9BVllVJ8AORkHYIlQ3uDXB1V1
	JYhhUNNuMA1zYAAICBl3k7nUvTB5OCYyif6NHlIAKrZ4rSCyRZsjVhV/ULPDZmhQfxM//uLumAD
	DkuoT5h8=
X-Received: by 2002:a05:600c:4f47:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4ba0234bc10mr57789835e9.20.1794329245976;
        Tue, 10 Nov 2026 08:47:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm5926182f8f.10.2026.11.10.08.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:47:25 -0800 (PST)
Message-ID: <8667d7b4-ffb4-4285-be67-10a85730c359@gmail.com>
Date: Tue, 10 Nov 2026 16:47:24 +0000
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
Subject: Re: [PATCH v4 1/4] worktree remove: refuse a worktree in the middle
 of an operation
Reply-To: phillip.wood@dunelm.org.uk
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-2-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261102182930.3511-2-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 02/11/2026 18:29, Jasper Mayone wrote:
> 
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index e6e77252ab..4a7dc47dd8 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -141,10 +141,16 @@ the new working tree location.
>   
>   `remove`::
>   
> -Remove a worktree. Only clean worktrees (no untracked files and no
> -modification in tracked files) can be removed. Unclean worktrees or ones
> -with submodules can be removed with `--force`. The main worktree cannot be
> -removed.
> +Remove a worktree. The main worktree cannot be removed. Without
> +`--force`, a worktree is not removed when:
> ++
> +--
> +* it has untracked files or modifications in tracked files,
> +* it has submodules, or

This is a list so each item should be a self contained sentence, we 
should drop the comma above and ", or" here.

> +* it is in the middle of a rebase, a `git am` session, a bisect, a
> +  cherry-pick or a revert, because removing it loses the state of that
> +  operation.

Looking at the html rendering of this, it is slightly odd that "git am" 
is in a different font to the rest of the command names. As we're 
creating a list we could have a separate item for each command, I'm not 
sure whether that would be clearer or not.

The rest of this patch looks good

Thanks

Phillip

> +--
>   
>   `repair [<path>...]`::
>   
> @@ -189,7 +195,8 @@ twice. If the destination is already assigned to some other worktree but is
>   missing (for instance, if _<new-path>_ was deleted manually), then `--force`
>   allows the move to proceed; use `--force` twice if the destination is locked.
>   +
> -`remove` refuses to remove an unclean worktree unless `--force` is used.
> +`remove` refuses to remove a worktree in the cases listed under
> +`remove` above unless `--force` is used.
>   To remove a locked worktree, specify `--force` twice.
>   
>   `-b <new-branch>`::
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 77ecd0f71f..7f53215cda 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -26,6 +26,7 @@
>   #include "submodule.h"
>   #include "utf8.h"
>   #include "worktree.h"
> +#include "wt-status.h"
>   #include "quote.h"
>   
>   #define BUILTIN_WORKTREE_ADD_USAGE \
> @@ -1408,6 +1409,38 @@ static void check_clean_worktree(struct worktree *wt,
>   			  original_path, ret);
>   }
>   
> +/*
> + * A rebase, "git am", bisect, cherry-pick or revert keeps its state in
> + * the worktree's own $GIT_DIR, and removing the worktree throws that
> + * away even when "git status" says the files are clean.
> + */
> +static void check_no_operation_in_progress(struct worktree *wt,
> +					   const char *original_path)
> +{
> +	struct wt_status_state state = { 0 };
> +
> +	if (wt_status_check_rebase(wt, &state)) {
> +		if (state.am_in_progress)
> +			die(_("'%s' is in the middle of an am session, use --force to delete it"),
> +			    original_path);
> +		die(_("'%s' is in the middle of a rebase, use --force to delete it"),
> +		    original_path);
> +	}
> +	if (wt_status_check_bisect(wt, &state))
> +		die(_("'%s' is in the middle of a bisect, use --force to delete it"),
> +		    original_path);
> +	wt_status_state_free_buffers(&state);
> +	if (refs_ref_exists(get_worktree_ref_store(wt), "CHERRY_PICK_HEAD"))
> +		die(_("'%s' is in the middle of a cherry-pick, use --force to delete it"),
> +		    original_path);
> +	if (refs_ref_exists(get_worktree_ref_store(wt), "REVERT_HEAD"))
> +		die(_("'%s' is in the middle of a revert, use --force to delete it"),
> +		    original_path);
> +	if (is_directory(worktree_git_path(wt, "sequencer")))
> +		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
> +		    original_path);
> +}
> +
>   static int delete_git_work_tree(struct worktree *wt)
>   {
>   	struct strbuf sb = STRBUF_INIT;
> @@ -1461,8 +1494,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
>   	strbuf_release(&errmsg);
>   
>   	if (file_exists(wt->path)) {
> -		if (!force)
> +		if (!force) {
> +			check_no_operation_in_progress(wt, av[0]);
>   			check_clean_worktree(wt, av[0]);
> +		}
>   
>   		ret |= delete_git_work_tree(wt);
>   	}
> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 69768c1207..2e45cd77f9 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -271,4 +271,98 @@ test_expect_success 'move worktree with relative path to absolute path' '
>   	test_cmp expect .git/worktrees/absolute/gitdir
>   '
>   
> +test_expect_success 'setup commits that conflict for am, cherry-pick and revert' '
> +	git worktree add --detach conflict-setup init &&
> +	(
> +		cd conflict-setup &&
> +		test_commit base conflict.t base &&
> +		git switch --detach init &&
> +		test_commit side conflict.t side &&
> +		test_commit side-two
> +	) &&
> +	git worktree remove conflict-setup
> +'
> +
> +test_expect_success 'remove worktree in the middle of a rebase' '
> +	test_when_finished "rm -rf mid-rebase; git worktree prune" &&
> +	git worktree add --detach mid-rebase side &&
> +	test_must_fail git -C mid-rebase rebase -f -x false init &&
> +	test_must_fail git worktree remove mid-rebase 2>err &&
> +	test_grep "in the middle of a rebase" err &&
> +	test_path_is_dir mid-rebase &&
> +	git worktree remove --force mid-rebase &&
> +	test_path_is_missing mid-rebase
> +'
> +
> +test_expect_success 'remove worktree in the middle of an am session' '
> +	test_when_finished "rm -rf mid-am patch; git worktree prune" &&
> +	git format-patch -1 --stdout side >patch &&
> +	git worktree add --detach mid-am base &&
> +	(
> +		cd mid-am &&
> +		test_must_fail git am ../patch &&
> +		git reset --hard
> +	) &&
> +	test_must_fail git worktree remove mid-am 2>err &&
> +	test_grep "in the middle of an am session" err &&
> +	git worktree remove --force mid-am
> +'
> +
> +test_expect_success 'remove worktree in the middle of a bisect' '
> +	test_when_finished "rm -rf mid-bisect; git worktree prune" &&
> +	git worktree add --detach mid-bisect side-two &&
> +	git -C mid-bisect bisect start side-two init &&
> +	test_must_fail git worktree remove mid-bisect 2>err &&
> +	test_grep "in the middle of a bisect" err &&
> +	git worktree remove --force mid-bisect
> +'
> +
> +test_expect_success 'remove worktree in the middle of a cherry-pick' '
> +	test_when_finished "rm -rf mid-pick; git worktree prune" &&
> +	git worktree add --detach mid-pick base &&
> +	(
> +		cd mid-pick &&
> +		test_must_fail git cherry-pick side &&
> +		git checkout --ours conflict.t &&
> +		git add conflict.t &&
> +		git rev-parse --verify CHERRY_PICK_HEAD
> +	) &&
> +	test_path_is_missing .git/worktrees/mid-pick/sequencer &&
> +	test_must_fail git worktree remove mid-pick 2>err &&
> +	test_grep "in the middle of a cherry-pick," err &&
> +	git worktree remove --force mid-pick
> +'
> +
> +test_expect_success 'remove worktree in the middle of a revert' '
> +	test_when_finished "rm -rf mid-revert; git worktree prune" &&
> +	git worktree add --detach mid-revert base &&
> +	(
> +		cd mid-revert &&
> +		test_must_fail git revert side &&
> +		git checkout --ours conflict.t &&
> +		git add conflict.t &&
> +		git rev-parse --verify REVERT_HEAD
> +	) &&
> +	test_path_is_missing .git/worktrees/mid-revert/sequencer &&
> +	test_must_fail git worktree remove mid-revert 2>err &&
> +	test_grep "in the middle of a revert" err &&
> +	git worktree remove --force mid-revert
> +'
> +
> +test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
> +	test_when_finished "rm -rf mid-pick-seq; git worktree prune" &&
> +	git worktree add --detach mid-pick-seq base &&
> +	(
> +		cd mid-pick-seq &&
> +		test_must_fail git cherry-pick side side-two &&
> +		git checkout --theirs conflict.t &&
> +		git add conflict.t &&
> +		git commit --no-edit
> +	) &&
> +	test_path_is_dir .git/worktrees/mid-pick-seq/sequencer &&
> +	test_must_fail git worktree remove mid-pick-seq 2>err &&
> +	test_grep "in the middle of a cherry-pick or revert" err &&
> +	git worktree remove --force mid-pick-seq
> +'
> +
>   test_done

