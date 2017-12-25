Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707F91F406
	for <e@80x24.org>; Mon, 25 Dec 2017 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdLYS0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 13:26:40 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37619 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdLYS0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 13:26:39 -0500
Received: by mail-wm0-f48.google.com with SMTP id f140so32408699wmd.2
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VK9s1+7U76/P0iU86pSk1N5mB1jLcf6RrNie1pZBBus=;
        b=h3puiZd6H+xvU2gPXhnvxMsJw6ebCyGMCbnM7UPWsN/MLGGIdVxZ1gtQgaw/xD4/u9
         H9PI3lmMcGPpvqVV/qcqus6icj0abzvneILLpGDMx54sbQmBfzH3ihblhEdDf1iomCL4
         AgA1cm/uNiq+MOypjf+0dPQLkaeonF8qsqxRDeSU6SMakvjOR5pWN3Y/moNvWzDoGnIc
         EitMNYd7ZLAn80P7Uif88+7jlouQtKgw9zl1cy07IJpDyh3SnPLieMMhsFFQuaywa62r
         DUtpFv8AR/PMRbvT1amXV7wZqbWgA8vK3DhpmvHPXB8UgwvVINbWJe43OrzdQzTSfLGM
         JVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VK9s1+7U76/P0iU86pSk1N5mB1jLcf6RrNie1pZBBus=;
        b=TcrEw0UR0nzOc+EiSsCEX9DuXfMxMc8rrj0MCrgaMeQ0zfdH8Mi6IFzztp1YonJfoS
         5fUYwWVNFMOTBq3DlI5eF+WBDn8+sQb7wkNm/tj5iKVya38fOjZk1A+G+EsjBXkC893f
         LtG8rTsBzkbDTyPHMsFjoTD8c9gWNjEHwuIf3Eau7NdvM2U2LwkMhJaq8ijtmw0n5FRb
         GQkJ9t9etM4/jXQWw4TIR2RmYe6l316h8r6M8D7PfUsqYRL1UEkk4O4EEKazF0sxAqii
         YyxYPxQj0VeJnZhySPRlwOoICMbSYd9975T8+7HyMssdeVfggnZi34OfdfSTjXJbq64e
         aGAw==
X-Gm-Message-State: AKGB3mKmrM/ontyt+jHY3e3Xr7g1Shacc4K3FZHmHXvlwroxK4odSchA
        SQ8wpS3Blq06YuSjdjFX/2HFx0fr
X-Google-Smtp-Source: ACJfBos1KjTmFSYYR1MQ3ZDbHkeU44m7Wj/QqU6LYFItq3AfBGEoLCGoV2WMbJaBrraN9vfuymLWtw==
X-Received: by 10.28.1.14 with SMTP id 14mr20351859wmb.51.1514226397620;
        Mon, 25 Dec 2017 10:26:37 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id a203sm9523843wmh.45.2017.12.25.10.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 10:26:36 -0800 (PST)
Subject: Re: [PATCH] status: handle worktree renames
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     alexmv@dropbox.com, git@vger.kernel.org
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
Date:   Mon, 25 Dec 2017 19:26:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171225103718.24443-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 25/12/2017 11:37, Nguyễn Thái Ngọc Duy wrote:
> Before 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
> in index" - 2016-10-24) there are never "new files" in the index, which
> essentially disables rename detection because we only detect renames
> when a new file appears in a diff pair.
> 
> After that commit, an i-t-a entry can appear as a new file in "git
> diff-files". But the diff callback function in wt-status.c does not
> handle this case and produces incorrect status output.
> 
> Handle this rename case. While at there make sure unhandled diff status
> code is reported to catch cases like this easier in the future.
> 
> The reader may notice that this patch adds a new xstrdup() but not a
> free(). Yes we leak memory (the same for head_path). But wt_status so
> far has been short lived, this leak should not matter in practice.
> 
> Noticed-by: Alex Vandiver <alexmv@dropbox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t2203-add-intent.sh | 15 +++++++++++++++
>  wt-status.c           | 24 +++++++++++++++++++-----
>  wt-status.h           |  1 +
>  3 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 1bdf38e80d..41a8874e60 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -150,5 +150,20 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
>  	)
>  '
>  
> +test_expect_success 'rename detection finds the right names' '
> +	git init rename-detection &&
> +	(
> +		cd rename-detection &&
> +		echo contents > original-file &&
> +		git add original-file &&
> +		git commit -m first-commit &&
> +		mv original-file new-file &&
> +		git add -N new-file &&
> +		git status --porcelain | grep -v actual >actual &&
> +		echo " R original-file -> new-file" >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
>  
> diff --git a/wt-status.c b/wt-status.c
> index ef26f07446..f0b5b3d46a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -376,6 +376,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
>  			strbuf_addch(&extra, ')');
>  		}
>  		status = d->worktree_status;
> +		if (d->worktree_path)
> +			one_name = d->worktree_path;
>  		break;
>  	default:
>  		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
> @@ -432,7 +434,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  		struct wt_status_change_data *d;
>  
>  		p = q->queue[i];
> -		it = string_list_insert(&s->change, p->one->path);
> +		it = string_list_insert(&s->change, p->two->path);
>  		d = it->util;
>  		if (!d) {
>  			d = xcalloc(1, sizeof(*d));
> @@ -459,6 +461,12 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  			/* mode_worktree is zero for a delete. */
>  			break;
>  
> +		case DIFF_STATUS_COPIED:
> +		case DIFF_STATUS_RENAMED:
> +			d->worktree_path = xstrdup(p->one->path);
> +			d->score = p->score * 100 / MAX_SCORE;
> +			/* fallthru */
> +
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
>  		case DIFF_STATUS_UNMERGED:
> @@ -467,8 +475,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  			oidcpy(&d->oid_index, &p->one->oid);
>  			break;
>  
> -		case DIFF_STATUS_UNKNOWN:
> -			die("BUG: worktree status unknown???");
> +		default:
> +			die("BUG: unhandled worktree status '%c'", p->status);
>  			break;
>  		}
>  
> @@ -548,6 +556,10 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  			 * values in these fields.
>  			 */
>  			break;
> +
> +		default:
> +			die("BUG: unhandled worktree status '%c'", p->status);
> +			break;
>  		}
>  	}
>  }
> @@ -1724,8 +1736,10 @@ static void wt_shortstatus_status(struct string_list_item *it,
>  	} else {
>  		struct strbuf onebuf = STRBUF_INIT;
>  		const char *one;
> -		if (d->head_path) {
> -			one = quote_path(d->head_path, s->prefix, &onebuf);
> +
> +		one = d->head_path ? d->head_path : d->worktree_path;
> +		if (one) {
> +			one = quote_path(one, s->prefix, &onebuf);
>  			if (*one != '"' && strchr(one, ' ') != NULL) {
>  				putchar('"');
>  				strbuf_addch(&onebuf, '"');
> diff --git a/wt-status.h b/wt-status.h
> index fe27b465e2..572a720123 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -48,6 +48,7 @@ struct wt_status_change_data {
>  	int mode_head, mode_index, mode_worktree;
>  	struct object_id oid_head, oid_index;
>  	char *head_path;
> +	char *worktree_path;
>  	unsigned dirty_submodule       : 2;
>  	unsigned new_submodule_commits : 1;
>  };
> 

Thanks, I`ve tested it and the reported case seems to work correctly, 
indeed.

But I`ve noticed that "--porcelain=v2" output might still be buggy - 
this is what having both files staged shows:

    $ git status --porcelain=v2
    2 R. N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file	original-file

..., where having old/deleted file unstaged, and new/created file 
staged with `git add -N` shows this:

    $ git status --porcelain=v2
    1 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 new-file

So even though unstaged value is correctly recognized as "R" (renamed), 
first number is "1" (instead of "2" to signal rename/copy), and both 
rename score and original file name are missing.

Not sure if this is a bug, but it seems so, as `git status` "Porcelain 
Format Version 2"[1] says the last path is "pathname in the commit at 
HEAD" (in case of copy/rename), which is missing here.

Regards, Buga

[1] https://git-scm.com/docs/git-status#_porcelain_format_version_2
