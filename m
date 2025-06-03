Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DB4C98
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988580; cv=none; b=tJEs1IVUYwjynWN/GUkBwns5jmSGZc10Md5F0EmA+YjRYJsEl0c9ysPIw/OQtsx7KXlOjvSYx/pswDtzcwy4TT41hzaCmQwZorRtJv+NmfBskFdtBTkkz7xoF4tAueKTId54ljKHm0ZsppzM0Novt7liCoL6i3LEU+SKbiC4B/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988580; c=relaxed/simple;
	bh=tZe6hHs7UeKJlT3aFyHdHhYLRxVNMuaXdMJoSz9LZUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G93MfvUG5PliWshqaZh4jej5befU9aooYmGPDYoE+jkryPcshzDlazSkSopbUP8so23WrNTLOkswysA5zBCJhPqEl0J0vEqbb7jbbmBAB/kP7V1wTR2b9u8//DhzbinImPZJr55XWviLejCz9U99goI2rHr5KSwk6Mv7KiJg1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=H8zXz2dF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="H8zXz2dF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e64b430daso54847567b3.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748988577; x=1749593377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bK8wpiDoeK1yPmvbW9aQ+ayptoA+3tVzUVto5Ygj4+4=;
        b=H8zXz2dFwO4ghlpzZVQ94qspa/bt8jqYwYM/r51Gn44gKxqCDqw3xs9c24eOYzZLfb
         s6ig5mJ49fH6u6lm5aDiEtG/3DIcLtIKhuR6m6SbSftc17wgOTTbjMOtpLis/yZr8f2N
         4je1VM1J2eSzsHUB0A5L94a+R+/3RmrjUxDn0o7yoILPgDChRIsL+Vtl6XBne8JEd6xp
         /RY/dtaoE0jAUZiYnUN2IRFlWb1VeoesEOrKYjNWTwCLg/cSsQjxbBy1BVjZmd83R/3N
         sQlFnL0xMNJGq85GDxNO33rKaByAtwY2Dm/8YpxLmGg4+7OO/6fyJSy7SfClGUWhlNuj
         LOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988577; x=1749593377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK8wpiDoeK1yPmvbW9aQ+ayptoA+3tVzUVto5Ygj4+4=;
        b=s7tbJd5WIESK12NalRitCeSZMXl0U0qDF6AJ8bMgVFtGbL/IntnP/5Oh9IKAgmNGxz
         XoDPcN2HwPPVHWuzi3pqGH0l5WoILZfxFJo3zwbaFBX1t7kSgxphiIF44byuASpJ1FSG
         B6AllcWM+HtbBHbUy94ItTsEQIwiW5h1D8c8x7ODZNj80rgmmYBIVygcxoZ68iFUIewv
         pNmD/RnMtyB6OyZ37TfH44sSpFKlcSi9atgA/gLmhtYPR7qA/BNuAIAbrptkM2wVMh+O
         1uzh5q1FN9BQOORHbz9DLI99fPTOGgfY5M69eqJR275bfBIhQ2sZNXiXmz1Bn+jnxE+n
         fVJg==
X-Gm-Message-State: AOJu0YxZBbxOpmdjCBQbo1uFQyae9FneTCNc55ZLfbTVNk5boIJoSNUM
	Il8nz2WZ1M2Itijcctt+Hm5HNx5G+HY83JB0/EoEU546EEsBKT36ZR6vpw0CJWAG24JMMIoUl7g
	eqWUq
X-Gm-Gg: ASbGncu8T7PsL1Omwsdw+L2i42LnBwX2cwOicfPBhCv3ZhrPtNbruA5xiKMR7oDzYex
	8v9qFEF5mdQP+2ayuocqdACe6pIssuTAp4YM7eBopzOzM3ObJ+YyS/7bDfZtRS2WkOqME2be5N8
	MDOQosZBGQJwGmZLEDO/8DDOknqbjiD1QtCfsQafkc2z2NIuIca4m5kJc4yD8/Dd1NkBvUfhiLI
	KATETXxhLGl0WB8kCTW3VNdmdw63Tfp3GKk8li8oFF527u8EtzD4XX5Fb+pLxz70VHT4MCR5fho
	ZtFOxkBwuWLznOL52y87XTZjVYsJoSoGtz64I//eXCrLUYEini/nyEKDmdJYozLncOT5bcjIAo6
	AyA16dv8uuoGbt1W7jfrV7AM2aK45NzkrWw==
X-Google-Smtp-Source: AGHT+IH0vOSOs8M7G3BckultMzGEC3GDSenl+Wm/QEmh9d7UbIx0+86EZzgqxWgmQqij2uu9WZKjlw==
X-Received: by 2002:a05:690c:f82:b0:70e:2d17:84b3 with SMTP id 00721157ae682-710d9e16b1cmr6535837b3.37.1748988576987;
        Tue, 03 Jun 2025 15:09:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8acd4b46sm27061507b3.72.2025.06.03.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:09:36 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:09:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4] pack-bitmap: remove checks before bitmap_free
Message-ID: <aD9ylkFDWqapFjey@nand.local>
References: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
 <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>

On Tue, Jun 03, 2025 at 06:20:49AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
> if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
> use roots_bitmap as a mutable reference but not takes roots_bitmap's
> ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.
> And this leak currently lacks a dedicated test to detect it.
>
> To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
> always calling bitmap_free(roots_bitmap);

This sentence might be more clear if it were written as:

    To fix this leak, unconditionally free the roots_bitmap regardless
    of whether or not cascade_pseudo_merges_1() succeeds.

> To trigger this leak, we need a pseudo-merge whose size is equal to
> or smaller than roots_bitmap (which corresponds to the set of "haves"
> commits in prepare_bitmap_walk()). To do this, we can create two
> commits: A and B. Add A to the pseudo-merge list and perform a traversal
> over the range A..B. In this scenario, the "haves" set will be {A},
> and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
> due to the missing roots_bitmap cleanup.

I don't think this is quite right. Calling cascade_pseudo_merges_1()
succeeds (and returns a non-zero value) when one or more pseudo-merges
are satisfied. A pseudo-merge is satisfied here when its parents bitmap
is a *subset* of the roots_bitmap, not when it has a smaller size.

The precise definition of one bitmap being a subset of another can be
found in ewah/bitmap.c::ewah_bitamp_is_subset(). But in general one
bitmap is a subset of the other if the set of bit positions with value
"1" from one is a subset of the same set from the other bitmap.

I think that's what you meant by "smaller", but I think it's worth
clarifying here.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index ac6d62b980c..8727f316de9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
>  			bitmap_set(roots_bitmap, pos);
>  		}
>
> -		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
> -			bitmap_free(roots_bitmap);
> +		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
> +		bitmap_free(roots_bitmap);

Makes sense.

> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index 56674db562f..e665001a410 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -445,4 +445,24 @@ test_expect_success 'pseudo-merge closure' '
>  	)
>  '
>
> +test_expect_success 'use pseudo-merge in boundary traversal' '
> +	git init pseudo-merge-boundary-traversal &&
> +	(
> +		cd pseudo-merge-boundary-traversal &&
> +
> +		git config bitmapPseudoMerge.test.pattern refs/ &&
> +		git config bitmapPseudoMerge.test.threshold now &&

Setting the unstable threshold here should be unnecessary, since the
unstable portion of the group only includes matching commits beyond the
threshold that *don't* already have a bitmap. Since "A" is the only
commit at the time you write the bitmap below, it will always be
selected, and thus never appear in the unstable portion of a
pseudo-merge group.

> +		git config bitmapPseudoMerge.test.stableThreshold now &&

This one is technically unnecessary, but only because test_commit starts
at the $test_tick value, which is very far in the past (beyond the
default value of 1.month.ago).

> +		test_commit A &&
> +		git repack -adb &&
> +		test_commit B &&
> +
> +		echo '1' >expect &&

Please do not use single-quotes in a test script. It happens to work in
this instance, but it is easy to break.

> +		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 \
> +			git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&

This test needs to use the boundary-based bitmap traversal routines, but
I'm unclear on why you're using the GIT_TEST_-environment variable to
enable them.

Is there a reason that we can't rely on the usual repository
configuration here? I would have expected something like this (which
should apply cleanly on top of your patch):

--- 8< ---
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index e665001a41..491ef404ea 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -453,14 +453,14 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 		git config bitmapPseudoMerge.test.pattern refs/ &&
 		git config bitmapPseudoMerge.test.threshold now &&
 		git config bitmapPseudoMerge.test.stableThreshold now &&
+		git config pack.useBitmapBoundaryTraversal true &&

 		test_commit A &&
 		git repack -adb &&
 		test_commit B &&

-		echo '1' >expect &&
-		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 \
-			git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
+		echo 1 >expect &&
+		git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
 		test_cmp expect actual
 	)
 '
--- >8 ---

> +		test_cmp expect actual

Hmm. I suppose, although it feels a little clunky to me to write
something like "echo 1 >expect". I would imagine that you'd do something
like:

    test 1 -eq $(git rev-list --count --use-bitmap-index HEAD~1..HEAD)

instead. Or if you wanted to split them off into separate lines, you
could do:

    nr=$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
    test 1 -eq "$nr"

Thanks,
Taylor
