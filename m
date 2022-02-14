Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BDC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 16:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354818AbiBNQOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:14:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiBNQOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 11:14:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F7D48
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:14:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s1so15813128qtw.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vaQ0xnNiIFZskoBaBlmPZW21vjK7IMNKqJSOKdbDIk4=;
        b=d3UhtnDCouYQuSIft2K3IsuhP183w3pSKa0ZDrSKUpvrPrB+BlKYtUXLYVxVSRjzVU
         w3uJtMlhSACkB4mpRN5RFscQuQkvCfZQ+3Ts8QyX3mnYW1Zabk6nXypp3lGgo9ZeCSyL
         YI7xmbULkGJ14sEeYYpKNw2l98LOe6kMB3LrYGhc1JkZo5yiFitO1o5X3qPLQCA3vWpC
         o6BegEzO3oWVQ6vUFCxp4iZRXKgB4zNgWSKyXn274Kl+G920FOPAwOrVznxdulv+o/iB
         Vsaz/Vn8bCkoupbjci8hZZO/365DUYmPcdf4/t7UotSxRubPa+jKM8lxaCE+ORDccTFG
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vaQ0xnNiIFZskoBaBlmPZW21vjK7IMNKqJSOKdbDIk4=;
        b=3V+j5uMCVZarckmeYwDHSKdDgCFblBaXaxorWIsH+UMt5SwxknO0Pa8+/pq6iNNiQN
         W9RPIXp3AtLtkqGi+jC0rA+Nug1yHkE9aKDzC5xRFBT1jX+5yJyyZE6D92224PQAWr6w
         bO5fiQrMFeuhGdByNadtHlN1+T/pI6vU6mmuxUAC2fjoNfN6pk5Dec1m4N4kJCpMi1zq
         Pi6DIMZ2EnRCEmOAGlqutzSu4u83P3qbvFaWGs+7MSuUYdgtzd+eiwuQz3KWpaKRxe48
         UW0h5IPNbEhNj1YdivRFXjLZTWnlaOzvvubh6BIInj1YrvnlonTUhGnaH78yZydxN6gx
         JTfg==
X-Gm-Message-State: AOAM531ZD5JuV/I+36FmgM5nQGKbiPsImoZIkhKRBT4+eWtz0LuwfggH
        ERo5LmwUJSiX3fRCMjgqegDR
X-Google-Smtp-Source: ABdhPJwXxwKQ0PZ1x4HskxvAgjusCMw2VDuoVprGOxT8xmadXqmHBv/Wu6/zrbeRm+NnP5Pq0tfuug==
X-Received: by 2002:a05:622a:1351:: with SMTP id w17mr387017qtk.447.1644855250235;
        Mon, 14 Feb 2022 08:14:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id u35sm18089835qtc.26.2022.02.14.08.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:14:09 -0800 (PST)
Message-ID: <d9bdf8c0-a449-ef12-fa80-5976ea9bd6c4@github.com>
Date:   Mon, 14 Feb 2022 11:14:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 7/7] sparse-checkout: make --cone the default and
 deprecate --no-cone
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <e30119b96dfaf9fdb82039cab84f8b81caacc1de.1644712798.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <e30119b96dfaf9fdb82039cab84f8b81caacc1de.1644712798.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Make --cone mode the default, and deprecate --no-cone mode.  While we
> have no current plans to actually remove --no-cone mode, we think users
> would be better off not using it.  Update the documentation accordingly,
> including explaining why we think non-cone mode is problematic for
> users.

"deprecate" is a good word here. The functionality remains, but we make
clear recommendations to not use it. 

> While at it, since the new default just uses directories and removes the
> need to understand patterns, we can mark multiple sections in the manual
> as "INTERNALS" to reflect the fact that users do not need to wade
> through those sections to understand how to use the command any more.
> We can instead add a simple EXAMPLES section to the manual which
> distills the necessary bits from the more complex INTERNALS sections.

> -SPARSE CHECKOUT
> ----------------
> +EXAMPLES
> +--------
> +`git sparse-checkout set MY/DIR1 SUB/DIR2`::
> +
> +	Change to a sparse-checkout with all files (at any depth) under
> +	MY/DIR1/ and SUB/DIR2/ present in the working copy (plus all
> +	files immediately under MY/ and SUB/ and the toplevel

Do we like "toplevel" or "top-level"?

> +	directory).  If already in a sparse checkout, change which files

There is some inconsistency between "a sparse checkout" and
"a sparse-checkout" here. I'm happy with either as long as we
stay consistent.

> +	are present in the working copy to this new selection.  Note
> +	that this command will also delete all ignored files in any
> +	directory that no longer has either tracked or
> +	non-ignored-untracked files present.
> +
> +`git sparse-checkout disable`::
> +
> +	Repopulate the working directory with all files, disabling sparse
> +	checkouts.
> +
> +`git sparse-checkout add SOME/DIR/ECTORY`::
> +
> +	Add all files under SOME/DIR/ECTORY/ (at any depth) to the
> +	sparse checkout, as well as all files immediately under
> +	SOME/DIR/ and immediately under SOME/.  Must already be in a
> +	sparse checkout before using this command.
> +
> +`git sparse-checkout reapply`::
> +
> +	It is possible for commands to update the working tree in a way
> +	that does not respect the selected sparsity directories, either
> +	because of special cases (such as hitting conflicts when
> +	merging/rebasing), or because some commands didn't fully support
> +	sparse checkouts (e.g. the old `recursive` merge backend had
> +	only limited support).  This command reapplies the existing
> +	sparse directory specifications to make the working directory
> +	match.
> +
> +INTERNALS -- SPARSE CHECKOUT
> +----------------------------

I like this switch to talk about "internals".

> +INTERNALS -- NON-CONE PROBLEMS
> +------------------------------
> +
> +The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
> +`add` subcommands is defined to be a bunch of patterns (one per line)
> +using the same syntax as `.gitignore` files.  In cone mode, these
> +patterns are restricted to matching directories (and users only ever
> +need supply or see directory names), while in non-cone mode any
> +gitignore-style pattern is permitted.  Using the full gitignore-style
> +patterns in non-cone mode has a number of shortcomings:
...
> +For all these reasons, non-cone mode is deprecated.  Please switch to
> +using cone mode.

I appreciate your very clear description here, as it helps make the
case for us.

> +INTERNALS -- FULL PATTERN SET
> +-----------------------------
> +
> +As noted above, the sparse-checkout file uses the same syntax as
> +`.gitignore` files; see linkgit:gitignore[5] for details.  Here, though,
> +the patterns are being used to select which files to include rather than
> +which files to exclude.
> +
> +To complicate things a bit further, while
> +`$GIT_DIR/info/sparse-checkout` is usually used to specify what files
> +are included, you can also specify what files are _not_ included, using
> +negative patterns. For example, to select everything, and then to remove
> +the file `unwanted`:

...

> -----------------
> +INTERNALS -- CONE PATTERN SET
> +-----------------------------

I wonder if this should be moved further up, above of the non-cone
internals.

> -The full pattern set allows for arbitrary pattern matches and complicated
> -inclusion/exclusion rules. These can result in O(N*M) pattern matches when
> -updating the index, where N is the number of patterns and M is the number
> -of paths in the index. To combat this performance issue, a more restricted
> -pattern set is allowed when `core.sparseCheckoutCone` is enabled.
> +The full pattern set allows for arbitrary pattern matches and
> +complicated inclusion/exclusion rules. As noted above, this can result
> +in O(N*M) pattern matches when updating the index, where N is the number

I see you are including information about O(N*M) "as noted above". I think
the cone pattern set should shift to assume it's the first mode people read,
and then the comparisons can happen in the non-cone mode internals.
 
>  If your repository contains one or more submodules, then submodules
>  are populated based on interactions with the `git submodule` command.
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 6e0af166f80..aa2c66f15e3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -395,13 +395,13 @@ static int update_modes(int *cone_mode, int *sparse_index)
>  
>  	/* Set cone/non-cone mode appropriately */
>  	core_apply_sparse_checkout = 1;
> -	if (*cone_mode == 1) {
> +	if (*cone_mode == 1 || *cone_mode == -1) {
>  		mode = MODE_CONE_PATTERNS;
> -		core_sparse_checkout_cone = 1;
> +		if (record_mode)
> +			core_sparse_checkout_cone = 1;
>  	} else {
>  		mode = MODE_ALL_PATTERNS;
> -		if (record_mode)
> -			core_sparse_checkout_cone = 0;
> +		core_sparse_checkout_cone = 0;
>  	}

Ok, this "record_mode" is showing up again here, so I assume it is
important and based on whatever is the default.

You are right that this commit is big. I think there are a few ways
to split it up to be easier to review:

1. Make test changes to insert "--no-cone" wherever needed.
2. Make default switch in code and change docs only to say which is
   the default.
3. Rename the sections of the document and move their current
   contents.
4. Update the non-cone docs with the reasons for its deprecation.

I also think that you've got two full _series_ on your hands. The
patches 1-6 are likely easier to review quickly and get merged while
we leave this deprecation series (this patch, split up as you see
fit) up for discussion.

I am in support of this idea, and I will make that case on your
cover letter.

Thanks,
-Stolee
