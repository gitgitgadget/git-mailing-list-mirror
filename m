Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8761F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJGSER (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 14:04:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSER (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 14:04:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so441924wmp.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=84Z2Ph/w7e2eIfdxYWqooQZZ2UrErbhUe94xV/eAfO4=;
        b=OUvae/Z3QnbPV6T6C5W4WMnslr7Hyo77pJRuqyUMUgZjSodA+nT4nxhx1+1cLRSXnc
         +sIxJqiTd9b76dijbwH5sPXST3zz2hSTMtPcR5wDJBvNG6QYSF+YwGUoUHrlgrHZWJFB
         asg7/ypPvUNzqR26Oj8+ojdROz7MjemB4BkPpmppg4hf9fK3ZD0DL8MMeybIPcY0lGLs
         rLcTS/cHQja+77dq90xX+3leouXWGxLk5niOAaPITMMLVXg+ShZJSxobtew8OFPnXeav
         A30u3LonrWbb+LTuHRQTNyod6O0zBlvV6pD4TbVJlwQ4FifET/xtrXeBNzVGFYP7QEtC
         H6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=84Z2Ph/w7e2eIfdxYWqooQZZ2UrErbhUe94xV/eAfO4=;
        b=bbLX3tOUAEs/1JrfnKAn6zeT+blhQQDYxVUXDLtgzCg85P737D/zVf+EWWWHPWYDTf
         PXuH9LOfU05KZ5MxtJvntV3k4YqVDSm77zQEHz/tss0Ll0eIfWUNyoFQESJQOozx01B7
         wpHcCepOiIPWTUlW/ndVukQcVFiDbjx4eFpa0Zmy271O2XBmgCc+dGQjtTvtZ+ei2Krv
         6XdyYpZo91AfuDqsFu0iPcMUKY+A4y/1JsD+JpZvYqf6jq4Vkj1KYl4CydMMkRjKVj2j
         kVahojMQwDDmRDaFf2Cm6ICY5ObNiaW5VF4kWXWhHV80flyrkjNX9+LK7VtLhKPdD95v
         uAHA==
X-Gm-Message-State: APjAAAViSAW9nJVfUZaBiux/vkZBFXZA1R4Rmmkip2vTlbR65JNZCRVi
        0dd+N/qRLG71ELBdNPJEKuo=
X-Google-Smtp-Source: APXvYqyuiYIOCp8BpsIqJ0kLSfDLXoPujqBsxoH+CFsHy80LoX8s0LgZ1+/R9WD4jVGpJTyly7OSTQ==
X-Received: by 2002:a1c:a616:: with SMTP id p22mr397541wme.3.1570471452645;
        Mon, 07 Oct 2019 11:04:12 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id r20sm30970910wrg.61.2019.10.07.11.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:04:11 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:04:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3] dir: special case check for the possibility that
 pathspec is NULL
Message-ID: <20191007180409.GD11529@szeder.dev>
References: <20191001184049.GA30113@generichostname>
 <20191001185524.18772-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001185524.18772-1-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 01, 2019 at 11:55:24AM -0700, Elijah Newren wrote:
> Commits 404ebceda01c ("dir: also check directories for matching
> pathspecs", 2019-09-17) and 89a1f4aaf765 ("dir: if our pathspec might
> match files under a dir, recurse into it", 2019-09-17) added calls to
> match_pathspec() and do_match_pathspec() passing along their pathspec
> parameter.  Both match_pathspec() and do_match_pathspec() assume the
> pathspec argument they are given is non-NULL.  It turns out that
> unpack-tree.c's verify_clean_subdirectory() calls read_directory() with
> pathspec == NULL, and it is possible on case insensitive filesystems for
> that NULL to make it to these new calls to match_pathspec() and
> do_match_pathspec().  Add appropriate checks on the NULLness of pathspec
> to avoid a segfault.
> 
> In case the negation throws anyone off (one of the calls was to
> do_match_pathspec() while the other was to !match_pathspec(), yet no
> negation of the NULLness of pathspec is used), there are two ways to
> understand the differences:
>   * The code already handled the pathspec == NULL cases before this
>     series, and this series only tried to change behavior when there was
>     a pathspec, thus we only want to go into the if-block if pathspec is
>     non-NULL.
>   * One of the calls is for whether to recurse into a subdirectory, the
>     other is for after we've recursed into it for whether we want to
>     remove the subdirectory itself (i.e. the subdirectory didn't match
>     but something under it could have).  That difference in situation
>     leads to the slight differences in logic used (well, that and the
>     slightly unusual fact that we don't want empty pathspecs to remove
>     untracked directories by default).
> 
> Denton found and analyzed one issue and provided the patch for the
> match_pathspec() call, SZEDER figured out why the issue only reproduced
> for some folks and not others and provided the testcase, and I looked
> through the remainder of the series and noted the do_match_pathspec()
> call that should have the same check.
> 
> Co-authored-by: Denton Liu <liu.denton@gmail.com>
> Co-authored-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Note: Applies on top of en/clean-nested-with-ignored, in next.
> 
> As with v1, the authorship is really mixed, so I don't know if I
> should use Co-authored-by (highlighted as a possibility by Denton), or
> the far more common Helped-by (as suggested by Junio but based on a
> more limited summary of the different contributions), or if perhaps
> Denton or SZEDER should be marked as the author and I be marked as
> Helped-by or Co-authored-by.  Since Denton commented on round 1, I
> used his suggestion for attribution in this round, but I'm open to
> changing it to whatever works best.
> 
> Changes since v2:
>   - This time actually removed the entire unnecessary comment
> 
> Range-diff:
> 1:  c495b9303c ! 1:  40392c6bba dir: special case check for the possibility that pathspec is NULL
>     @@ t/t0050-filesystem.sh: $test_unicode 'merge (silent unicode normalization)' '
>      +		git reset --hard &&
>      +		mkdir -p gitweb/subdir &&
>      +		>gitweb/subdir/file &&
>     -+		# it is not strictly necessary to add and commit the
>      +		git add gitweb &&
>      +		git commit -m "add gitweb/subdir/file" &&
>      +
> 
>  dir.c                 |  8 +++++---
>  t/t0050-filesystem.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 7ff79170fc..bd39b86be4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1962,8 +1962,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			((state == path_untracked) &&
>  			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
>  			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> -			  do_match_pathspec(istate, pathspec, path.buf, path.len,
> -					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
> +			  (pathspec &&
> +			   do_match_pathspec(istate, pathspec, path.buf, path.len,
> +					     baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
>  			struct untracked_cache_dir *ud;
>  			ud = lookup_untracked(dir->untracked, untracked,
>  					      path.buf + baselen,
> @@ -1975,7 +1976,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			if (subdir_state > dir_state)
>  				dir_state = subdir_state;
>  
> -			if (!match_pathspec(istate, pathspec, path.buf, path.len,
> +			if (pathspec &&
> +			    !match_pathspec(istate, pathspec, path.buf, path.len,
>  					    0 /* prefix */, NULL,
>  					    0 /* do NOT special case dirs */))
>  				state = path_none;
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 192c94eccd..a840919967 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '
>  	git merge topic
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		>Gitweb &&
> +		git add Gitweb &&
> +		git commit -m "add Gitweb" &&
> +
> +		git checkout --orphan todo &&
> +		git reset --hard &&
> +		mkdir -p gitweb/subdir &&
> +		>gitweb/subdir/file &&
> +		git add gitweb &&
> +		git commit -m "add gitweb/subdir/file" &&
> +
> +		git checkout master
> +	)
> +'

I don't like this test ;)

I only intended it as a "here is how to reliably reproduce the
segfault without all the clutter of the full git.git repository" that
I wrote way past my bedtime.  But I think that:

  - it shouldn't have the CASE_INSENSITIVE_FS prereq.  Yes, that
    segfault could only be triggered on a case insensitive filesystem,
    but the given sequence of commands should succeed in a case
    sensitive file system just as well.

    (Have no idea why I added that prereq in the first place; as I
    said above, it was way past my bedtime...)

  - it's in the wrong test script; it would be better among other
    tests checking what 'git checkout' should or must not overwrite
    when switching branches, but not sure which test script that is.

    (I think I added it to this test script, because it stood out a
    bit when grepping for case insensitive fs in the test suite; I
    play the "past my bedtime" card again :)

  - it's already satisfied by 'git checkout master' not failing, but
    it doesn't check whether the resulting contents of the worktree
    are as expected.

  - it still bothers me why that additional subdir was necessary to
    trigger the segfault.  Did you look into it?

