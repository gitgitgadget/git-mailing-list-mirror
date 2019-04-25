Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F2B1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfDYKCo (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:02:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54724 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDYKCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:02:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so8428863wml.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KOs63o+7ynoXXniCVega0Oeq1omSGl0X8f7SK14hH7Q=;
        b=CniCbhJbrfn+FYi04nZ1GQAeL98Tc4o8JPsVmdyahSlnhoEoxEsNZKdim2PvmlMpQd
         9PJfL1ZEdj+tNjPjX6HovoSXxfxedtBcK9+nOciMUe0smqVIrVNJJjT1ekxZ9BYASJoI
         DXgTPtHs4TH2STa/WJ6PZvZbobLeOk6dhoInhktwnCTbmFpvswMEKWuSBw/NIeuRdyck
         boSBnoLXJha3igH7m+AuSCTiGcy+5bC2Avto/WGf1yW5z14Bcyase5iUF7sTKXx77JZQ
         KO+TGX8KqFV+nMY1MU4suK6vDJbBP9PgNSSAvTzLCgUrpxf9aP+vWUByLghvE2azwMK2
         Wp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOs63o+7ynoXXniCVega0Oeq1omSGl0X8f7SK14hH7Q=;
        b=NYdZyVXSq6tsbfxzJqyYJclRHV7yOcKsu5sQt5lxmgpd97LRC/tSNjcyEIZG8s1Drv
         ajjIeLBXtmzyaFVVApQaeXpiQnGzrwMR4Nn6eBwFT0B5H5e+bcLcdTq/rJ8KH+a7LWfd
         l99hH6yQRFdRNn0DQec9KUetjptayptxY+I/DhrbvHCeZgEmwOVx0o0tPswggUscRyg0
         Xygo56dQ/J9+CWS29OjsNeRdfY+l0oxm7CuGgAFspKSxyjtuUOkEbQ35guu0HH+ON8ua
         tsgznM6R3+OAEVq7vLDF1smsZBW4VyYJK2ZTaGJ/O8/SlMVKRu59w8JXBJ3OfQF5UO7r
         rHvQ==
X-Gm-Message-State: APjAAAUUs6Pi7/VMkwf4WLuFgHPeXYXx8VlT+pHrMMPvdAIucrfw7evV
        L0IeO0UXm47E/WRBUtUvIcU=
X-Google-Smtp-Source: APXvYqzzJCgYvNXGWUpk58SScTdhLmosZ/dcuSandhTBFvjIHWgsCZKtyEZ+L5V61XcrSVbBtFmLcw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2902874wmc.124.1556186561683;
        Thu, 25 Apr 2019 03:02:41 -0700 (PDT)
Received: from [192.168.2.201] (host-92-26-127-169.as13285.net. [92.26.127.169])
        by smtp.googlemail.com with ESMTPSA id u15sm5591087wrt.40.2019.04.25.03.02.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 03:02:41 -0700 (PDT)
Subject: Re: [PATCH v6 15/27] switch: add --discard-changes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, rybak.a.v@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-16-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <17402ee1-68c1-e51f-dc32-0795e0b63bc8@gmail.com>
Date:   Thu, 25 Apr 2019 11:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329103919.15642-16-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/2019 10:39, Nguyễn Thái Ngọc Duy wrote:
> --discard-changes is a better name than --force for this option since
> it's what really happens.

I didn't realize when I suggested the name that --force overwrites
untracked files as well as discarding changes from tracked files. I
think we should document that. It would be nice if read-tree --reset -u
took an optional argument so read-tree --reset=tracked -u would not
overwrite untracked files. Then we could have --discard-changes just
discard the changes and not overwrite untracked files. I had a quick
look at unpack trees and it looks like a fairly straight forward change
(famous last words) - perhaps I'll have a go at it next week.

Best Wishes

Phillip

> --force is turned to an alias for
> --discard-changes. But it's meant to be an alias for potentially more
> force options in the future.
> 
> Side note. It's not obvious from the patch but --discard-changes also
> affects submodules if --recurse-submodules is used. The knob to force
> updating submodules is hidden behind unpack-trees.c
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/checkout.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 319ba372e3..6d0b2ef565 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -53,6 +53,7 @@ struct checkout_opts {
>  	int count_checkout_paths;
>  	int overlay_mode;
>  	int no_dwim_new_local_branch;
> +	int discard_changes;
>  
>  	/*
>  	 * If new checkout options are added, skip_merge_working_tree
> @@ -680,7 +681,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  		return error(_("index file corrupt"));
>  
>  	resolve_undo_clear();
> -	if (opts->force) {
> +	if (opts->discard_changes) {
>  		ret = reset_tree(get_commit_tree(new_branch_info->commit),
>  				 opts, 1, writeout_error);
>  		if (ret)
> @@ -802,7 +803,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>  
> -	if (!opts->force && !opts->quiet)
> +	if (!opts->discard_changes && !opts->quiet)
>  		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
>  
>  	return 0;
> @@ -1309,6 +1310,9 @@ static int checkout_branch(struct checkout_opts *opts,
>  	if (opts->force && opts->merge)
>  		die(_("'%s' cannot be used with '%s'"), "-f", "-m");
>  
> +	if (opts->discard_changes && opts->merge)
> +		die(_("'%s' cannot be used with '%s'"), "--discard-changes", "--merge");
> +
>  	if (opts->force_detach && opts->new_branch)
>  		die(_("'%s' cannot be used with '%s'"),
>  		    "--detach", "-b/-B/--orphan");
> @@ -1445,6 +1449,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		opts->merge = 1; /* implied */
>  		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
>  	}
> +	if (opts->force)
> +		opts->discard_changes = 1;
>  
>  	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
>  		die(_("-b, -B and --orphan are mutually exclusive"));
> @@ -1600,6 +1606,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  			   N_("create and switch to a new branch")),
>  		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
>  			   N_("create/reset and switch to a branch")),
> +		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
> +			 N_("throw away local modifications")),
>  		OPT_END()
>  	};
>  	int ret;
> 

