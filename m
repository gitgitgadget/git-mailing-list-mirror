Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628458;
	b=QcmEbLR0BZYIYjfiyIhPAfZEMkPzbIiwzunFU/r08GQG1p0xDXwoWwEL/MNinQlNPwFj
	 /NOk0u5TWy1XbVWm3tQw1HN26BK6NJLy9S5c+ik+iKcr+x8gvFPHb4EyYl7icgclwRHWv
	 whO8e9T9CiosiEILkRC8coxpARsA5Zl9DMtJ+LFoH0Mp4m2Bd9HMmEonycUB4UpmtBbiH
	 UubmOiDMQn41X9SuxMunotaQ8kE4tNUx1W3tx/lg1gXE7Sa/99Cj4iBNwIv/aEXyJsuVh
	 TD0uSV/Ne5X9GpQikHzY22vNoDYUkkO9W7EFrDidH4EJfxnDd8u5tC2h8R9JlMceFGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fKI4t2EJfSIbyV5NFugrt9xaDaqtBamiepx7yzzfBko=;
	b=vMO7kHR6ZLfXuruR79v2FbIqAN/4Y0QhgFfXQSoiI93Cc7SxPFPARQsvy082RObIcCMD
	 FMOSLxf/zQLUDW7mQvTC7YDYnF8fT2IzvFf9Y4nJ2c6goSIVmjva/cQm0pPjx0e74jtAM
	 OVz8sQhhJBUls7hfX8FdpomwC7lhhcTY137Cz/QSM86lDskxJlgeCb9c7JrHk0xyQx1PZ
	 r0qOD5mxF+2+3cau2gLIyYjbgz4qIQmy0HGs2WWfs1T1dsbSpV5BaV32V2LY/OLH3/SS3
	 DxuMUX5wqPYA9CKQGaT+yQt8LwOUjc6sNRlH2XwgsNJi30yLxmjo1Rai2scnW/osI8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbJfVn6f;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72545606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72545606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbJfVn6f
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so1831968f8f.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628457; x=1794233257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKI4t2EJfSIbyV5NFugrt9xaDaqtBamiepx7yzzfBko=;
        b=EbJfVn6fGR1/sxvx+I0vC5ANUZN3kV33iRZLgWxbfGM4TRVJd/BglHtxlTz5+3P3Nw
         gqZVGwRr8NjX6g/1B5hGpi3a3UPZ7ESbmanLzxM2IIC8eZ6Zv3BNkwA2o6QxlxM+lMGW
         i6/UzIDwno7AvKNY2wQEB80nFvNrP2yemRyjpDgTdYqx+w0Dw8bWvwvkOvdtmN09r2H+
         shTl/VAKmkX7aUR04noc3OhTHxDl0c9x+iD91W8JTCsIgQtNs5WEXIrpWQIt8m5tCkX2
         0TYl5++bu9n+gSMSTUACNqv216+6v8JUjTMuIY+WZUSSNNDA4xR7FdbXJnpnOlw3TZ1i
         lWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628457; x=1794233257;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKI4t2EJfSIbyV5NFugrt9xaDaqtBamiepx7yzzfBko=;
        b=pITs9lWF/9obPvixGT1qQ8jM6olJQOpeq8dSrRQ9253tpHeg9HoiaU4OabYLM0H1CM
         HbMMwVV58vchPbsyCr2U1JvpQrU6DWawouaUcdWia46kjmB7FfprKxKmgyn0NU2rgkVy
         sYFmCLE9CeoTwWdsALQe/PNj0xxvbhIrDvnkP7Zl1qxbMd9MpENhiLAeUiL3l0NkZXT4
         TUn6gGEg+AZ2bp2hbZsfJKaqnoTkZiOdLrePHdOpthvY7jJVEmAtZrhUWkjb7XuwEXzL
         N/idRQHthmmeQ2bPw3pnf8aJneGz07Pt+jUid6o7TPllbbvydZCOz8LYjBnPxb7WIJT/
         NwTg==
X-Forwarded-Encrypted: i=1; AKwUvBwE0BQFUulQcuMakiX0OphAOGCrGjYLB+xaqxf5pZG46Qv8iuuCuifzSusk+VIHN5088go=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVSObcAJ3OGIKbQz5O+Fgi2ZLBKi4nLnRWuhdFPmk6fOkpph4g
	C7ZKVeATKjoG4cwBKWIEyswLOk9bDtdYUh+RgFEnorf0cT3VrQKQAs11
X-Gm-Gg: AYBFou1l1pETcuPmTJIsG+Q/hsSTpdpohoUFEXhWIQXd/wyNjxGCBhMniO1jo/gKwxn
	X7+pMXXzpEo7DemNmJRMG3xWiU0qIPXHISJOXcrJM/e4sszk3OUzfcBsWdmaBxpU4UreJ9eg4wW
	ZlQB2PnsAA3a9ztemXHx+rzSCO+R8ha/QiL2o1jp1sHKmHeE9PSTK0oT66SdLGy4efbgoQagnoU
	7+FuUrOFoMx6Qrtjva3hXe5hCwyVTMeV11/19irIfDXwHBvBoL0PQYemHojYgKAJC1Qy0+o+5hy
	5s05x0u9IJBDulPcBWuiPZUis9NmYZ0coLbfMeldhAOKlxrvHcOlT9Jr2FNez9DXxLCn3ORtygp
	4s88dgNZLg54QhLjTIFGg68RLSyHAES8mVZLPzJR2lnw4QcJVgcKpSc/u42y8lTJWKLYXNlSv7m
	2UKGBQIei5wa2uRGy3jL1C3LFKLPoEAHvcZKCcrFxmSXNlKVr7D1mU1HpPitX5srW75yyzXvYOv
	LYVP8wEPNuHt8JjHX01FQahZwS+yhUnokLhccBxlslvexEcfEQZs4+CLaRD0bo3ZZKshfN31/+6
	vqOGRJ5Pvji7D0/7GASLfUtpc0EYKzJYtEbv+y+odQ2YSvxXQUsgxpMEMgVSqwDQp4RU7OkNXrH
	j4L2Jaw==
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr15004415e9.23.1793628456405;
        Mon, 02 Nov 2026 06:07:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm378568385e9.1.2026.11.02.06.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:07:35 -0800 (PST)
Message-ID: <bf554c5f-066c-4e58-a583-0f95aedecf95@gmail.com>
Date: Mon, 2 Nov 2026 14:07:33 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] worktree remove: refuse a worktree in the middle of a
 rebase or bisect
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261024165311.57387-1-me@jaspermayone.com>
 <20261030142137.54750-1-me@jaspermayone.com>
 <20261030142137.54750-2-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261030142137.54750-2-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 30/10/2026 14:21, Jasper Mayone wrote:
> "git worktree remove" refuses a worktree with modified or untracked

"refuses to move" would be clearer

> files unless --force is given, but it removes a worktree that is in
> the middle of a rebase, a "git am" session, a bisect or a cherry-pick
> or revert sequence when its files happen to be clean. The state of
> that operation lives in the worktree's own $GIT_DIR, so it is lost
> with the worktree. A rebase stopped at an "edit" or "break" line, an
> "exec" that failed, or a cherry-pick sequence after a conflict was
> resolved and committed is clean in this sense and still has work in
> progress.

Cherry picking or reverting a single commit that contains no new changes 
also looks clean, but there is still a cherry-pick operation in progress 
as CHERRY_PICK_HEAD exists. One could argue that, because the user 
doesn't really lose any work, we don't lose much by deleting such a 
worktree but we're still deleting a worktree that contains an 
in-progress operation. Fixing that case simply requires us to see if 
CHERRY_PICK_HEAD, or REVERT_HEAD exist.

> Treat such a worktree as unclean: refuse to remove it unless --force
> is given, and name the operation in the message.
> 
> A worktree whose directory is already gone is still removed without
> --force, as before: the check is part of the check for a clean
> worktree, which is only done when the directory exists.

Sensible

> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>

I'm not sure what I've done anything to help with this patch

> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index e6e77252ab..da4c38f909 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -142,9 +142,10 @@ the new working tree location.
>   `remove`::
>   
>   Remove a worktree. Only clean worktrees (no untracked files and no
> -modification in tracked files) can be removed. Unclean worktrees or ones
> -with submodules can be removed with `--force`. The main worktree cannot be
> -removed.
> +modification in tracked files) can be removed. A worktree in the middle
> +of a rebase, a `git am` session, a bisect or a cherry-pick or revert

"bisect, cherry-pick or revert"

> +sequence is not clean either, 

"either" doesn't make sense, because you've not described the unclean 
case yet. This line needs folding as well.

> because removing it loses that state. Unclean worktrees or ones with submodules
> +can be removed with `--force`. The main worktree cannot be removed.

A list of the conditions that require --force might make this section 
clearer.
>   `repair [<path>...]`::
>   
> @@ -189,7 +190,9 @@ twice. If the destination is already assigned to some other worktree but is
>   missing (for instance, if _<new-path>_ was deleted manually), then `--force`
>   allows the move to proceed; use `--force` twice if the destination is locked.
>   +
> -`remove` refuses to remove an unclean worktree unless `--force` is used.
> +`remove` refuses to remove an unclean worktree, or one in the middle of a
> +rebase, `git am` session, bisect, or cherry-pick or revert sequence,

too many "or"s as above

> +unless `--force` is used.
>   To remove a locked worktree, specify `--force` twice.
>   
>   `-b <new-branch>`::
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 77ecd0f71f..ed08de1f43 100644
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
> @@ -1408,6 +1409,32 @@ static void check_clean_worktree(struct worktree *wt,
>   			  original_path, ret);
>   }
>   
> +/*
> + * A rebase, "git am", bisect or cherry-pick/revert sequence keeps its
> + * state in the worktree's own $GIT_DIR, and removing the worktree
> + * throws that away even when "git status" says the files are clean.
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
> +	if (is_directory(worktree_git_path(wt, "sequencer")))
> +		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
> +		    original_path);
> +}

This looks correct, though I wish we had a standard function that 
returned an enum describing which operation was in progress, rather than 
having to open code this sort of thing.

>   static int delete_git_work_tree(struct worktree *wt)
>   {
>   	struct strbuf sb = STRBUF_INIT;
> @@ -1461,8 +1488,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
>   	strbuf_release(&errmsg);
>   
>   	if (file_exists(wt->path)) {
> -		if (!force)
> +		if (!force) {
> +			check_no_operation_in_progress(wt, av[0]);

This triggers the new check when the worktree directory exists - good.

>   			check_clean_worktree(wt, av[0]);
> +		}
>   
>   		ret |= delete_git_work_tree(wt);
>   	}
> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 69768c1207..4eb56a8911 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -271,4 +271,63 @@ test_expect_success 'move worktree with relative path to absolute path' '
>   	test_cmp expect .git/worktrees/absolute/gitdir
>   '
>   
> +test_expect_success 'remove worktree in the middle of a rebase' '
> +	test_when_finished "rm -rf mid-rebase; git worktree prune" &&
> +	git worktree add --detach mid-rebase init &&
> +	test_commit -C mid-rebase rebase-me &&
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
> +	git worktree add --detach mid-am init &&
> +	test_commit -C mid-am am-me &&
> +	git -C mid-am format-patch -1 --stdout >patch &&
> +	git -C mid-am reset --hard init &&
> +	echo conflict >mid-am/am-me.t &&
> +	git -C mid-am add am-me.t &&
> +	git -C mid-am commit -m conflict &&
> +	test_must_fail git -C mid-am am ../patch &&
> +	git -C mid-am reset --hard &&

If we're running a lot of consecutive commands in a worktree, it is 
clearer to use a subshell

	(
		cd mid-am &&
		...
	) &&

I wonder how hard it would be to extend the "setup" test to create a 
branch that has conflicts when it is applied with am, cherry-pick, or 
rebase, so that we don't have to set up the conflicts in each test.

Thanks

Phillip

> +	test_must_fail git worktree remove mid-am 2>err &&
> +	test_grep "in the middle of an am session" err &&
> +	git worktree remove --force mid-am
> +'
> +
> +test_expect_success 'remove worktree in the middle of a bisect' '
> +	test_when_finished "rm -rf mid-bisect; git worktree prune" &&
> +	git worktree add --detach mid-bisect init &&
> +	test_commit -C mid-bisect bisect-one &&
> +	test_commit -C mid-bisect bisect-two &&
> +	git -C mid-bisect bisect start HEAD init &&
> +	test_must_fail git worktree remove mid-bisect 2>err &&
> +	test_grep "in the middle of a bisect" err &&
> +	git worktree remove --force mid-bisect
> +'
> +
> +test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
> +	test_when_finished "rm -rf mid-pick; git worktree prune" &&
> +	git worktree add --detach mid-pick init &&
> +	git -C mid-pick switch -c pick-src &&
> +	test_commit -C mid-pick pick-one &&
> +	test_commit -C mid-pick pick-two &&
> +	git -C mid-pick switch --detach init &&
> +	echo conflict >mid-pick/pick-one.t &&
> +	git -C mid-pick add pick-one.t &&
> +	git -C mid-pick commit -m conflict &&
> +	test_must_fail git -C mid-pick cherry-pick pick-src~1 pick-src &&
> +	git -C mid-pick checkout --theirs pick-one.t &&
> +	git -C mid-pick add pick-one.t &&
> +	git -C mid-pick commit --no-edit &&
> +	test_path_is_dir .git/worktrees/mid-pick/sequencer &&
> +	test_must_fail git worktree remove mid-pick 2>err &&
> +	test_grep "in the middle of a cherry-pick or revert" err &&
> +	git worktree remove --force mid-pick
> +'
> +
>   test_done

