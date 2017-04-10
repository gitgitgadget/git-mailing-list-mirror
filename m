Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4018C20970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbdDJKgu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:36:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33000 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbdDJKgt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:36:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so25273849pgf.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hrbT5JIOVdwNXZkFFn+Z87gbkDlmIqNsjonbhjj2FM=;
        b=VtQjkEvbj9uNbUMH+UjrzDp/hWzBps8NJymCTYRwJu0nkSeX0F3XC0xg1cMiw7Qwvf
         TTfcWk+Mg6KJPob5YsDWcWJBsCpxbvfZaS9sS9U6cBfNpZ2wv41nbUYN4s8SFchlUNJ7
         7+SKwcqznT5WJ//BQb0kFPL9auWIq5XrOSf+iolwnEyJMzbTXO6oR+TeyU+RqUfyYvw/
         fMOEuNjx37Zne7u4ikAvcFgrJcTbNy/BUklmziYy9j600k6ZUT9hkVv+fXgkhNM7uQ3D
         UO8BdHGNYq2iWn7ZAWeeiVnXY1VJEdNKT/3EzaTOBUMLn4cazvjvVfgqWdIH/ikgA9PY
         75Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hrbT5JIOVdwNXZkFFn+Z87gbkDlmIqNsjonbhjj2FM=;
        b=Ge4iLi+u95c5gFrC9u3sE/vF/n5W6Gj/HME9svaj0wtPs/r6C076GQCLpXddZ8zAg3
         t4iF2zeQK9wMLzwk6EfiImuUVi05twSy2MBdHfYiF0H4vFDDS675Ch8RMTS4vQEi3JNj
         eRg/TCYw1kLLkaINYxfK+nJUjIAYqgJKrKMSEVi9XE8tHvwpsdNrXpcK907FmEGjDXSi
         5G4zxdoM1Or9VAKgOq/IqRqayw1OHR7YlrH0ayV9+gEADsniwk4bQV2H03DgE0bV0epQ
         Zsq3L0FB+j9bXh/elUtNiZMkP3XU0D1RQWPC+XqHGmC11rzmXD/WvN0Yd4eLx2CIvEJX
         O2HA==
X-Gm-Message-State: AFeK/H3+RNioudz5z4/F3KQpUUJy4Dq7lNgXyScpP1WKR/kGMeK+F8J5kmGhnaiv9JuLeQ==
X-Received: by 10.99.104.9 with SMTP id d9mr55716016pgc.27.1491820608826;
        Mon, 10 Apr 2017 03:36:48 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id w28sm23899508pfl.115.2017.04.10.03.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 03:36:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 10 Apr 2017 17:36:43 +0700
Date:   Mon, 10 Apr 2017 17:36:43 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/3] merge-recursive.c: conflict using sparse should
 update file
Message-ID: <20170410103643.GC19325@ash>
References: <20170407192357.948-1-kewillf@microsoft.com>
 <20170407192357.948-2-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407192357.948-2-kewillf@microsoft.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 12:23:55PM -0700, Kevin Willford wrote:
> Update the file when there is a conflict with a modify/delete scenario
> when using the sparse-checkout feature since the file might not be on disk
> because the skip-worktree bit is on and the user will need the file and
> content to determine how to resolve the conflict.

I'm a bit uncertain about this, but it's mostly because I'm not
familiar with merge-recursive.c. I think the general principle is, if
a file is conflicted it must NOT have skip-worktree bit on and the
worktree version must be restored at the same time the bit is removed.

I think we should do that (restore the worktree version) when the
skip-worktree bit is removed. What I'm not sure is when the bit is
removed in this code.

I'm guessing that the bit is removed by unpack_trees() with the
threeway merge. Maybe we should restore the worktree version there at
that time. It does not matter what conflict type it is, just restore
the file (which should be what merge-recursive.c expects in normal
case) then merge-recursive.c can proceed to update, delete or whatever
to present the conflict to the user.

>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  merge-recursive.c                |  8 ++++++++
>  t/t7614-merge-sparse-checkout.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100755 t/t7614-merge-sparse-checkout.sh
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b7ff1ada3c..54fce93dae 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1103,6 +1103,14 @@ static int handle_change_delete(struct merge_options *o,
>  			       "and %s in %s. Version %s of %s left in tree."),
>  			       change, path, o->branch2, change_past,
>  			       o->branch1, o->branch1, path);
> +			/*
> +			 * In a sparse checkout the file may not exist. Sadly,
> +			 * the CE_SKIP_WORKTREE flag is not preserved in the
> +			 * case of conflicts, therefore we do the next best
> +			 * thing: verify that the file exists.
> +			 */
> +			if (!file_exists(path))
> +				ret = update_file(o, 0, a_oid, a_mode, path);
>  		} else {
>  			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>  			       "and %s in %s. Version %s of %s left in tree at %s."),
> diff --git a/t/t7614-merge-sparse-checkout.sh b/t/t7614-merge-sparse-checkout.sh
> new file mode 100755
> index 0000000000..6922f0244f
> --- /dev/null
> +++ b/t/t7614-merge-sparse-checkout.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +
> +test_description='merge can handle sparse-checkout'
> +
> +. ./test-lib.sh
> +
> +# merges with conflicts
> +
> +test_expect_success 'setup' '
> +	test_commit a &&
> +	test_commit file &&
> +	git checkout -b delete-file &&
> +	git rm file.t &&
> +	test_tick &&
> +	git commit -m "remove file" &&
> +	git checkout master &&
> +	test_commit modify file.t changed
> +'
> +
> +test_expect_success 'merge conflict deleted file and modified' '
> +	echo "/a" >.git/info/sparse-checkout &&
> +	test_config core.sparsecheckout true &&
> +	test_must_fail git merge delete-file &&
> +	test_path_is_file file.t
> +'
> +
> +test_done
> -- 
> 2.12.2.windows.2.1.g7df5db8d31
> 
