Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CC41F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 16:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394383AbfJQQoc (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 12:44:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394316AbfJQQob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 12:44:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so3269187wmc.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E00S0VaDyFs1rjS554mMwPDCXhPuIWUZ0gogl77NCuE=;
        b=CJjWPALbV26flBoWdgyD8HERNPSwd3C/QkImG2xgu/oXh6M9gMqZffm7aKxn+SXTtD
         8S/VziG2tY6exp97Bcg+E2bDhYG6QvPRzbLD1I6GNHyRHmOUvnTcq+Uy7UC2utd8o8o3
         WZsMKG4fcsx75xgqzwBI6ePPEJ1PVa/EEsTHLCBk/Bbe8ZMpOm5pwyqRViOZIPj5HQdw
         lGi5xPNUz5GddywhHiZrdJpPVwXmogb73mIcZjAI7o3PkN/7BxEdtP7n9m9ZYt1BovKM
         9FuFwW7xptDFwqriWB7ljozWOCvhjJS8wOzovgYsWbZhXTpE9+ckgIFnYjRGeQ1Z7Ci9
         7tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E00S0VaDyFs1rjS554mMwPDCXhPuIWUZ0gogl77NCuE=;
        b=NzZF00Ijp+wlkxuRu066yxOdbbwFy9nLG8lH3q9QdJ2J/NhUpIXh3lhwMx8agyizPe
         PE9UHpg7h7JP462AHmhoQ3elkFCY883lDvQ+r4SxUp/kPbmLIgMOt4wESFkggNYxycEB
         xKtDXriq7BaclPKGxzW9m/7lsyq+T/dFSmJ/9EAr2ImsgCLGf2saFaIx9Wxl1RbhYBZ4
         nFFtAF04wFvwi7hCSrERAQ7rTiTSR4zeuUndkfCkC7M1qD0rYKg1sfeoOTaJVFj95Z0H
         BDEfd8hUnBPaE6mQ37NQiADozImAkYYlp6NIGOG6dvffgOxkE5rzCzOUv6ucQRiMctgV
         emuQ==
X-Gm-Message-State: APjAAAUJ1BVt+y6drueHzjGQZnlfJLrT0L1zrQDKA/8UFI5eZO+133y7
        bEQK7PDS0vTGRRWj3SJ+s8c8qoeF
X-Google-Smtp-Source: APXvYqx/oBKkPSu8sK+yu3K3w+ByVZ/ZGpLTC3ENt3n7b0qtMlcNJT/bKWO9LlHqoTMwFECtvMWF/g==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr3631720wmg.31.1571330669874;
        Thu, 17 Oct 2019 09:44:29 -0700 (PDT)
Received: from szeder.dev (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id t83sm4119839wmt.18.2019.10.17.09.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 09:44:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 18:44:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Make die_if_checked_out() ignore missing worktree
 checkouts.
Message-ID: <20191017164426.GX29845@szeder.dev>
References: <20191017162826.1064257-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017162826.1064257-1-pjones@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:28:25PM -0400, Peter Jones wrote:
> Currently if you do, for example:
> 
> $ git worktree add path foo
> 
> And "foo" has already been checked out at some other path, but the user
> has removed it without pruning, you'll get an error that the branch is
> already checked out.  It isn't meaningfully checked out, the repo's
> data is just stale and no longer reflects reality.
> 
> This makes it so that if nothing is present where a worktree is
> supposedly checked out, we ignore that the worktree exists, and let it
> get cleaned up the next time worktrees are pruned.
> 
> (I would prune it instead, but prune isn't available from libgit
> currently.)
> 
> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---
>  branch.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/branch.c b/branch.c
> index 579494738a7..60322ded953 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -360,6 +360,9 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
>  	wt = find_shared_symref("HEAD", branch);
>  	if (!wt || (ignore_current_worktree && wt->is_current))
>  		return;
> +	if (access(wt->path, F_OK) < 0 &&
> +	    (errno == ENOENT || errno == ENOTDIR))
> +		return;

I think this check is insuffient: even if the directory of the working
tree is not present, the working tree might still exist, and should
not be ignored (or deleted/pruned in the second patch).

See the description of 'git worktree lock' for details.

>  	skip_prefix(branch, "refs/heads/", &branch);
>  	die(_("'%s' is already checked out at '%s'"),
>  	    branch, wt->path);
> -- 
> 2.23.0
> 
