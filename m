Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EC51FF6D
	for <e@80x24.org>; Mon, 19 Dec 2016 05:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbcLSFfP (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 00:35:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36195 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbcLSFfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 00:35:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id w68so1248062pgw.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0dKxLpBRDRN0mNd9qLF3X9dtpwWmuxpAj9p6hOmBb4=;
        b=rhAtPQa4qg5yShUYAqxTHxNO7yOyJ4caFfKNy7Zy5rwEnxQff/wxEBh3kPFHompDBb
         phQWEOn4cqh1W0mWmFqVuVV1SIyiM/hPTDZ34dMO+EFdAwTAKpdX6YDu2B279+XsHUzU
         Br8aC5MM/sIhjo6FUu5Ghxmt9HaUoVd+M5oa+oS6nq7PTm9pc0IvuBMWu6KM15ukGW8r
         rSslghr0R6s6XwWMF7/WzdHujc77rCJNROeU771LRoZUU58Vrc5Hwnweob7EXMA0NPpm
         7hN2K4paItF5CEoUGodJOKQtixjtRUTFzmvBQswSjt0/Qj+nCLrCT+4+RhYKIHtJCTMg
         B/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0dKxLpBRDRN0mNd9qLF3X9dtpwWmuxpAj9p6hOmBb4=;
        b=RLNfIJPY16RveqF+jSxahugAXLS/BbwKEE3JO5T/HSAVDVFwADGF6g1mNK63hCbwoR
         /ES81cujkhC+jwc76xjo3XkKAoZSSGDqBadt+sJM5HFCSYhoRsnXR1MsFycJoQKGzG2p
         9avh6/4J0bpLBzKED7rK4pW3INYZYoRm33zZKwujMMOHUzbIvsz2Nk0ghxtl1DvcnN81
         ziX6pZaqEABZ9H968pfIjEmBPBiQVrKrrUfqTIJzmuWuFUiovkkETAFF0LQ9M1osEdqf
         hVhBG7/hX3dkkxApXVcvv99lUBFtVy1zE6lbPTntAuCzKwortRa2SnFCkg4qhAPcX4E7
         QLcA==
X-Gm-Message-State: AKaTC02hlQCAofsI9cygyrNKUsAjHuBOnFCUvZB/H1AO9Vz9aJn5S0NbldS6buwljffPMA==
X-Received: by 10.84.216.21 with SMTP id m21mr31438005pli.119.1482125713612;
        Sun, 18 Dec 2016 21:35:13 -0800 (PST)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id g63sm27616574pfd.60.2016.12.18.21.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2016 21:35:12 -0800 (PST)
Date:   Mon, 19 Dec 2016 12:35:07 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCHv8 6/6] submodule: add absorb-git-dir function
Message-ID: <20161219053507.GA2335@duynguyen.vn.dektech.internal>
References: <20161212190435.10358-1-sbeller@google.com>
 <20161212190435.10358-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212190435.10358-7-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 11:04:35AM -0800, Stefan Beller wrote:
> diff --git a/dir.c b/dir.c
> index e0efd3c2c3..d872cc1570 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2773,3 +2773,15 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  	free(work_tree);
>  	free(git_dir);
>  }
> +
> +/*
> + * Migrate the git directory of the given path from old_git_dir to new_git_dir.
> + */
> +void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
> +{
> +	if (rename(old_git_dir, new_git_dir) < 0)
> +		die_errno(_("could not migrate git directory from '%s' to '%s'"),
> +			old_git_dir, new_git_dir);
> +
> +	connect_work_tree_and_git_dir(path, new_git_dir);

Should we worry about recovering (e.g. maybe move new_git_dir back to
old_git_dir) if this connect_work_tree_and_git_dir() fails?

Both write_file() and git_config_set_.. in this function may die(). In
such a case the repo is in broken state and the user needs pretty good
submodule understanding to recover from it, I think.

Recovering is not easy (nor entirely safe) either, though I suppose if
we keep original copies for modified files, then we could restore them
after moving the directory back and pray the UNIX gods that all
operations succeed.
--
Duy
