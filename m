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
	by dcvr.yhbt.net (Postfix) with ESMTP id 230AD1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKRR5g (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 12:57:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRR5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 12:57:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id l4so10186275plt.13
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 09:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBZ1tvGVIQI0m4jcWcuWjT/2DPDizCKFdrHcDMcXTZk=;
        b=UzgwXYNVr0X/SOhDbx8tLscxksoaFiPSSSOCRT4XXh88lxqzSPHBi3SolCTJcuznjt
         1A5tC1YRDAyJTg4t+n13EJqCB9w38dKSUMEAagENp8I/JkHA56aonZyuxwESlTARgJmB
         F9ikdiiuG7zkFqhBRRShj/rdVBq24U4kzmgDOKE7/ZBbyaSp61HmJHG70NAJnhtj0lYt
         RvPwzprNxPuxjapRaxBEjp7hFTak5B4+sKaSStdkJJUm3UBOb1J/kOOyi3K77pdQ9Axv
         jp29dxOvGIklSZpq1GGKaxk3+I9c29vczS79QlRnFQu8u8+i73uJWFRh2UCmJ/ocoiLD
         vkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBZ1tvGVIQI0m4jcWcuWjT/2DPDizCKFdrHcDMcXTZk=;
        b=CvovS5cgBcraUdJ7ReT63pFyaG63AoPzbeJgCYo522L84vyH0+k7OZICquvJFbxrWK
         AUh1/xCqMXDnf89FIJqxKeM8SN7KmsB22t+SVcEH3htIWkVrCXRdv2dNZ0mEGJcDXBbr
         w1pjlVrfIOxjo45GVWnPdwtTRIBcP462UjmzV7k0W2gSUpJDwdRj3fDkzLkIJqjzCCTk
         R6kdclVpCjgHwDAS4Sc4KzVDxgPX1SDp2mxKCBQaXOLeHf95Lf4BhjX7b9Rs1H1Bjhz5
         855/Xzk+8PIgxQ9+GbcSrKDjNSwfKaGmDZ6sSMawDdtPx2x+e6Latzbfkb35l9gFH/j8
         0IyA==
X-Gm-Message-State: APjAAAU8l2KrjidoOZQEi6k5z2gqRLxYQzcgFlQEe1XkdWPfwIDXshjW
        ubhClL1jHDUYG1YERDf9MA0=
X-Google-Smtp-Source: APXvYqzIe1k87MUAW7Sf3Y8VsoSA65fZCHIKUl8lsPh6dnwzlmTvCq3uZa2NfJrdyZD2eUk9HSFhNg==
X-Received: by 2002:a17:90a:3746:: with SMTP id u64mr335266pjb.4.1574099854806;
        Mon, 18 Nov 2019 09:57:34 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id d7sm24138044pfc.180.2019.11.18.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:57:33 -0800 (PST)
Date:   Mon, 18 Nov 2019 09:57:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org, yuelinho777@gmail.com, gitster@pobox.com,
        mhagger@alum.mit.edu, pclouds@gmail.com
Subject: Re: [PATCH] enable a timeout for hold_lock_file_for_update
Message-ID: <20191118175732.GA11649@generichostname>
References: <20191118134750.1901ED756F@wsmn.osm-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118134750.1901ED756F@wsmn.osm-gmbh.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Thanks for the patch. I'm not too familiar with the lockfile codebase of
git but here are some general comments:

> Subject: [PATCH] enable a timeout for hold_lock_file_for_update

We prefer subjects in the format of "<area>: <brief subject>" so
perhaps, we could rewrite this to:

	lockfile: learn core.filesLockTimeout configuration

On Mon, Nov 18, 2019 at 02:42:17PM +0100, Martin Nicolay wrote:
> The new funktion get_files_lock_timeout_ms reads the config

s/funktion/function/

> core.filesLockTimeout analog get_files_ref_lock_timeout_ms.

Perhaps s/analog/similar to/ ?

> 
> This value is used in hold_lock_file_for_update instead of the
> fixed value 0.
> ---
> While working with complex scripts invoking git multiple times
> my editor (emacs with standard version control) detects the
> changes and apparently calls "git status". This leads to abort
> in "git stash". With this patch and an appropriate value
> core.fileslocktimeout this problem goes away.
> 
> While it may be possible to patch the elisp scripts of emacs (and
> all other similar callers) to call "git status" with
> --no-optional-locks it seems to me a better approarch to solve this
> problem at its root: calling hold_lock_file_for_update_timeout with
> a timeout of 0 ms.
> 
> The implementation with the function get_files_lock_timeout_ms is 
> adopted from a similar usage of get_files_ref_lock_timeout_ms.

It might be good to include the above three paragraphs in your commit
message. Not only do they describe the change but, more importantly,
they describe _why_ the change is being made.

> 
> BTW: is there a way to link this version of the patch to the previous
> version to reduce the work for reviewers?

When you generate your patches, run

	git format-patch --in-reply-to=<r> -v<n>

where <r> is the Message-ID of your last patch and where <n> is the
version of the patch (in this case, it should've been 2 since you sent
out one before).

> 
>  Documentation/config/core.txt |  6 ++++++
>  lockfile.c                    | 16 ++++++++++++++++
>  lockfile.h                    |  4 +++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 852d2ba37a..230ea02560 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -482,6 +482,12 @@ core.packedRefsTimeout::
>  	all; -1 means to try indefinitely. Default is 1000 (i.e.,
>  	retry for 1 second).
>  
> +core.filesLockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	lock an individual file. Value 0 means not to retry at
> +	all; -1 means to try indefinitely. Default is 0 (i.e., don't
> +	retry at all).
> +
>  core.pager::
>  	Text viewer for use by Git commands (e.g., 'less').  The value
>  	is meant to be interpreted by the shell.  The order of preference
> diff --git a/lockfile.c b/lockfile.c
> index 8e8ab4f29f..7301f393d6 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -145,6 +145,22 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  	}
>  }
>  
> +/*
> + * Get timeout for hold_lock_file_for_update.
> + */
> +long get_files_lock_timeout_ms(void)
> +{
> +	static int configured = 0;
> +
> +	static int timeout_ms = 0; /* default */
> +	if (!configured) {
> +		git_config_get_int("core.fileslocktimeout", &timeout_ms);
> +		configured = 1;
> +	}
> +
> +	return timeout_ms;
> +}
> +
>  void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
>  {
>  	if (err == EEXIST) {
> diff --git a/lockfile.h b/lockfile.h
> index 9843053ce8..a0520e6a7b 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -163,6 +163,8 @@ int hold_lock_file_for_update_timeout(
>  		struct lock_file *lk, const char *path,
>  		int flags, long timeout_ms);
>  
> +long get_files_lock_timeout_ms(void);
> +
>  /*
>   * Attempt to create a lockfile for the file at `path` and return a
>   * file descriptor for writing to it, or -1 on error. The flags
> @@ -172,7 +174,7 @@ static inline int hold_lock_file_for_update(
>  		struct lock_file *lk, const char *path,
>  		int flags)
>  {
> -	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
> +	return hold_lock_file_for_update_timeout(lk, path, flags, get_files_lock_timeout_ms() );

Style nit: remove the space after the function call.

Thanks,

Denton

>  }
>  
>  /*
> -- 
> 2.13.7
> 
