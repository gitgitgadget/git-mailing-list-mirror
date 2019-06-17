Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BA61F462
	for <e@80x24.org>; Mon, 17 Jun 2019 05:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbfFQFvs (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 01:51:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfFQFvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 01:51:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so7621247wmj.5
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mfsS3KG+ahnS97przxH9VXCXAMDzNeiigc8j5d166s=;
        b=i50DMvAhQhDUopdoNog5Z5Bh0B+599ci0sBg61llg0j/LOGE4tWAeUkv+QMNEoNiG8
         iQ6cSYlD4Y3023ciDq2eAMYT0OD8WD9wl1yIWAQIPt6ZLYvCm/FqK52qIj4i+u6JNhVD
         D8IPBbMNpZrY0OhGQ/xO40NUGmQetejlgINGkh5rDswGFwSMCCVy94kBS9V4LkXEJmCI
         ChwjTUAM+6tjyL2f3jn7UVwfCCqGxQG2NedX/wETUWl4rpcoK9tPR7jQP+9Vgijydm9H
         lP98MpyyHMXU4FHEBR4vBRcHFL8J2qZSjeZScOlKU4slMfnu4FccFCySGegdSx0KELRp
         lzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mfsS3KG+ahnS97przxH9VXCXAMDzNeiigc8j5d166s=;
        b=biu+ZqcwEchUfK1WHaJQnKCdpxe/UAr5UFUZlSSOD5eH3AVVI6G+XJHhchzMGOc7Nx
         NHjhZZGOaZNhVVZkSLdRnhnfNDMsHX/0sfhew/OxhwhhVONzVOfCfWh7NP4UvR9UpAsH
         jpKnlFhcTkjG4m916nGkutujdZ1TXjhnsKHY+K8+RpAPwQM4NuMf1kpV3vEakXTKTcr5
         VecHi/dqyzMMdpjdk9z/SSvqR2K+s536YEbj6Go2PeUNNMgQSfxlAQ7raZCIFvtl9FLH
         b5xcCJYxL8avJtNT/8Q7nEPsw2DasoMJhREDsqPpun/2vQ9YnHgaaZdzJy6nMLeWUBF2
         14aA==
X-Gm-Message-State: APjAAAXh3tVFaU/Yz3CteseD/OHDCMx/t7Gr/USSxPImFqMCQeKdDg2q
        PWKcTJN0KGItEYyZ7XQXNla/+G5B/z0=
X-Google-Smtp-Source: APXvYqy8XDCHxcPrYRaUvq6pViv7cNXx0EfH1JXaU0TzgUPXn2xf74r5+qbVqC1zKwzoKeB5BdWoOw==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr18302022wmh.1.1560750705882;
        Sun, 16 Jun 2019 22:51:45 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id x6sm11605535wru.0.2019.06.16.22.51.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 22:51:44 -0700 (PDT)
Date:   Mon, 17 Jun 2019 06:51:42 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        martin.agren@gmail.com, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 1/4] sequencer: add advice for revert
Message-ID: <20190617055142.GD11340@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-2-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616082040.9440-2-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/16, Rohit Ashiwal wrote:
> In the case of merge conflicts, while performing a revert, we are
> currently advised to use `git cherry-pick --<sequencer-options>`
> of which --continue is incompatible for continuing the revert.
> Introduce a separate advice message for `git revert`. Also change
> the signature of `create_seq_dir` to handle which advice to display
> selectively.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
> changes:
>     - change BUG()'s message under create_seq_dir
> 
>  sequencer.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..d80e1c3fbb 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2650,15 +2650,37 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  	return 0;
>  }
>  
> -static int create_seq_dir(void)
> +static int create_seq_dir(struct repository *r)
>  {
> -	if (file_exists(git_path_seq_dir())) {
> -		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> +	enum replay_action action;
> +	const char *in_progress_error = NULL;
> +	const char *in_progress_advice = NULL;
> +
> +	if (!sequencer_get_last_command(r, &action)) {
> +		switch (action) {
> +		case REPLAY_REVERT:
> +			in_progress_error = _("revert is already in progress");
> +			in_progress_advice =
> +			_("try \"git revert (--continue | --abort | --quit)\"");
> +			break;
> +		case REPLAY_PICK:
> +			in_progress_error = _("cherry-pick is already in progress");
> +			in_progress_advice =
> +			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
> +			break;
> +		default:
> +			BUG(_("unexpected action in create_seq_dir"));

As Phillip mentioned in the previous round, this doesn't need to be
translated.  I'd go one step further and say this should not be
translated.  Translating it just adds extra work for translators for a
message that the user will (hopefully) never see.

In fact if we look through the rest of the codebase, BUG() messages
are never translated anywhere, and neither is the one in 3/4.

> +		}
> +	}
> +	if (in_progress_error) {
> +		error("%s", in_progress_error);
> +		advise("%s", in_progress_advice);
>  		return -1;
> -	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
> +	}
> +	if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
>  				   git_path_seq_dir());
> +
>  	return 0;
>  }
>  
> @@ -4237,7 +4259,7 @@ int sequencer_pick_revisions(struct repository *r,
>  	 */
>  
>  	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir() < 0)
> +			create_seq_dir(r) < 0)
>  		return -1;
>  	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
>  		return error(_("can't revert as initial commit"));
> -- 
> 2.21.0
> 
