Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2655F208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeG2Uf3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 16:35:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39408 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2Uf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 16:35:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so11184606wmb.4
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wmntd8rumuQT8ffBpL5pQdB0mGRQFmlGZ0ZMQLNV82M=;
        b=DjvpWGcuO4aQmU3mnCv/J+BD1XYtdumEBSOvRrxC7e/D+ofe1CvqFZasOI7KMLJ5vo
         z/YxgVQJ8hXyv4HmOiqn4XzFIqsBeAhjoL7/sPb5roDUWxNPy3eSaPTp31VxLX5sjvqY
         Y4YedJH+OSJ/xeH/OVFk6LE5j0V9QHG5A5WKHnaYnK6ORSwHPhRN9zcoslBUX5rOn1zP
         Rj/94WKESXcNT9WILR8ekM2JrYpBbVUkxY/ucfkkWtVErbX9fYzmIx6nTj9fvXuBRD9M
         b9wg6QQV+gCXp8VWaG+NvuRANKMqJ0lBBnzADq3I4E3P/ftMyjcBZYbAEvIMNu5AV58A
         SPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmntd8rumuQT8ffBpL5pQdB0mGRQFmlGZ0ZMQLNV82M=;
        b=tfvSJNsySqO0YUt5k1i82wjqqYtMTO6B2IUS7FUv4aq9vTWXwdbIwplXlmX1ui7ljp
         PmScDX6ZJTrwF0nuu2XloXmoroIK6nb3QoRGgK3JOEVjAJSm1oKKHg3ZlVLot9mgDB9W
         Dyut6kNXE9GNelXSS+QrI8DeUfg12yFiBR42O69Y+T0zLwJt0pUeHk/7/QyEbUDfobpT
         AiGDGgW182+WqyQEiqZ4k4+3nlkJf+7HqFg5AJiWlVH2+bXlIflNj2w+dSSYNZJR0CPf
         ML3ykgVeUehd5puh98Pac6FGjK3cN5UCEhWMk2TSOHWdYP9K7XMB4Iuuvpvc7wFTc4K9
         EaZg==
X-Gm-Message-State: AOUpUlHoLMIsB/e5ajflzsyoESWXVmQ4ajjJr80TwJcsgxlru8/i6+1e
        ASZW++iQuRncPAObuxE75OI=
X-Google-Smtp-Source: AAOMgpdByLK1CMQau5y5V5w/MIbYM8iurU45iW/IeQDY6AHyo6SaJ0lW6VcytNui+XKAH5LRKvadSQ==
X-Received: by 2002:a1c:ad42:: with SMTP id w63-v6mr12989590wme.100.1532891041362;
        Sun, 29 Jul 2018 12:04:01 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id y14-v6sm18999133wrq.45.2018.07.29.12.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 12:04:00 -0700 (PDT)
Date:   Sun, 29 Jul 2018 20:03:59 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
Message-ID: <20180729190359.GD2734@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Just like tbdiff, we now show the diff between matching patches. This is
> a "diff of two diffs", so it can be a bit daunting to read for the
> beginner.
> 
> An alternative would be to display an interdiff, i.e. the hypothetical
> diff which is the result of first reverting the old diff and then
> applying the new diff.
> 
> Especially when rebasing often, an interdiff is often not feasible,
> though: if the old diff cannot be applied in reverse (due to a moving
> upstream), an interdiff can simply not be inferred.
> 
> This commit brings `range-diff` closer to feature parity with regard
> to tbdiff.
> 
> To make `git range-diff` respect e.g. color.diff.* settings, we have
> to adjust git_branch_config() accordingly.
> 
> Note: while we now parse diff options such as --color, the effect is not
> yet the same as in tbdiff, where also the commit pairs would be colored.
> This is left for a later commit.
> 
> Note also: while tbdiff accepts the `--no-patches` option to suppress
> these diffs between patches, we prefer the `-s` option that is
> automatically supported via our use of diff_opt_parse().

One slightly unfortunate thing here is that we don't show these
options in 'git range-diff -h', which would be nice to have.  I don't
know if that's possible in git right now, if it's not easily possible,
I definitely wouldn't want to delay this series for that, and we could
just add it to the list of possible future enhancements that other
people mentioned.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/range-diff.c | 25 ++++++++++++++++++++++---
>  range-diff.c         | 34 +++++++++++++++++++++++++++++++---
>  range-diff.h         |  4 +++-
>  3 files changed, 56 insertions(+), 7 deletions(-)
>
> [...]
> 
> diff --git a/range-diff.c b/range-diff.c
> index 2d94200d3..71883a4b7 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -6,6 +6,7 @@
>  #include "hashmap.h"
>  #include "xdiff-interface.h"
>  #include "linear-assignment.h"
> +#include "diffcore.h"
>  
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -258,7 +259,31 @@ static const char *short_oid(struct patch_util *util)
>  	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
>  }
>  
> -static void output(struct string_list *a, struct string_list *b)
> +static struct diff_filespec *get_filespec(const char *name, const char *p)
> +{
> +	struct diff_filespec *spec = alloc_filespec(name);
> +
> +	fill_filespec(spec, &null_oid, 0, 0644);
> +	spec->data = (char *)p;
> +	spec->size = strlen(p);
> +	spec->should_munmap = 0;
> +	spec->is_stdin = 1;
> +
> +	return spec;
> +}
> +
> +static void patch_diff(const char *a, const char *b,
> +			      struct diff_options *diffopt)
> +{
> +	diff_queue(&diff_queued_diff,
> +		   get_filespec("a", a), get_filespec("b", b));
> +
> +	diffcore_std(diffopt);
> +	diff_flush(diffopt);
> +}
> +
> +static void output(struct string_list *a, struct string_list *b,
> +		   struct diff_options *diffopt)
>  {
>  	int i = 0, j = 0;
>  
> @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
>  			printf("%d: %s ! %d: %s\n",
>  			       b_util->matching + 1, short_oid(a_util),
>  			       j + 1, short_oid(b_util));
> +			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))

Looking at this line, it looks like it would be easy to support
'--no-patches' as well, which may be slightly easier to understand that
'-s' to someone new to the command.  But again that can be added later
if someone actually cares about it.

> +				patch_diff(a->items[b_util->matching].string,
> +					   b->items[j].string, diffopt);
>  			a_util->shown = 1;
>  			j++;
>  		}
> @@ -307,7 +335,7 @@ static void output(struct string_list *a, struct string_list *b)
>  }
>  
>  int show_range_diff(const char *range1, const char *range2,
> -		    int creation_factor)
> +		    int creation_factor, struct diff_options *diffopt)
>  {
>  	int res = 0;
>  
> @@ -322,7 +350,7 @@ int show_range_diff(const char *range1, const char *range2,
>  	if (!res) {
>  		find_exact_matches(&branch1, &branch2);
>  		get_correspondences(&branch1, &branch2, creation_factor);
> -		output(&branch1, &branch2);
> +		output(&branch1, &branch2, diffopt);
>  	}
>  
>  	string_list_clear(&branch1, 1);
> diff --git a/range-diff.h b/range-diff.h
> index dd30449c4..aea9d43f3 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -1,7 +1,9 @@
>  #ifndef BRANCH_DIFF_H
>  #define BRANCH_DIFF_H
>  
> +#include "diff.h"
> +
>  int show_range_diff(const char *range1, const char *range2,
> -		    int creation_factor);
> +		    int creation_factor, struct diff_options *diffopt);
>  
>  #endif
> -- 
> gitgitgadget
> 
