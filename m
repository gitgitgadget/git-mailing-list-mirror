Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D741F404
	for <e@80x24.org>; Wed, 14 Feb 2018 21:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031113AbeBNVTg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 16:19:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37708 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030977AbeBNVTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 16:19:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so24411209wmv.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 13:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Jfk4iTaSRq0XyAj9YYsYq+fCB4iGghK6ONBm7axbAkw=;
        b=BC5LVKyOyf7nqVzmctv5Rz3a220seFSLWsnLonLovDX8tvX5CVBuBGllOQTPdz+mjx
         Qw7mcdDO90jhTvIUZfqxsIodt1tfNUvoyQaCQyum7m9Z90UxoSBeP//548RotZOsQMZi
         9c842V/rzc/gjcaRO7C8/X0nxjPmm7NeZQAmFOpKZG/pn0tySVC72yaOjbifVtshRFdG
         hsMp8O1JToRr2fxd4xhv8BDjDG8+O7gdaj6PVeX1OrQIp994LhysP6xGjOi+q8B+Le05
         EqWMWBbNhPyWn3U8bn/yFMkf0VbECckNljG3n6cXDI1Z8mm8SnTj/ATaY+v58ZlYfoMO
         j0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Jfk4iTaSRq0XyAj9YYsYq+fCB4iGghK6ONBm7axbAkw=;
        b=uHmiNzHt7WWsB/fIVU7fbK6slKLeZCFZdmtUEhw2SKPjVMfEbwVl5YEzuM/oNbsaL5
         tj9tGZwNQ4OHGZCOANwHDbZpZan9MHQ6o0zyXtNMlymaDb0GBzn0dd6JeVUcAT4f29fR
         Wm7xPaqBeWFxpho6jmoizO7Art16bvsIJkSFr1Iep8qLl9lRBFe9ZOiTeTSkRTzwC9Q5
         qoVGoIVR+z/2cKvyuL4idRF49OFzzGWk7RgreROKHgpLg1vW6F41+d0CY8MdNTOPkLn3
         42iWwbtxNsg/R2CTcrvK6uNzqYpDTXsgdtJIOQP0y3dd/x4iZuDVNN/n/LurTnFa/Qjn
         5fyQ==
X-Gm-Message-State: APf1xPBck08nnM+AShM4AFH6PEwVrjzlvnWhQ+wYUPmuGL4ohGMRQ6z4
        kyVMU2rlQfF4iDH0bFn1Kp6yw3c2WN8=
X-Google-Smtp-Source: AH8x227Q9xQYPHaNSR2aKCJPl6G1Xu6J4gGNX6Yc/AVAZ6UOoRfc2pZAfva6InBLXZ1OH5fT0Ww9Mg==
X-Received: by 10.28.134.205 with SMTP id i196mr340169wmd.117.1518643174115;
        Wed, 14 Feb 2018 13:19:34 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j125sm12368004wmd.19.2018.02.14.13.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 13:19:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com,
        avarab@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2 06/37] diff: rename 'this' variables
References: <20180129223728.30569-1-bmwill@google.com>
        <20180214185959.221906-1-bmwill@google.com>
        <20180214185959.221906-7-bmwill@google.com>
Date:   Wed, 14 Feb 2018 13:19:30 -0800
In-Reply-To: <20180214185959.221906-7-bmwill@google.com> (Brandon Williams's
        message of "Wed, 14 Feb 2018 10:59:28 -0800")
Message-ID: <xmqqh8qjmfq5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Rename C++ keyword in order to bring the codebase closer to being able
> to be compiled with a C++ compiler.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

The patch is not as bad as renaming "this" and leaving "that" behind
but in the original, "this" and "this_dir" were treated as a pair.
"this" was a score for a single item in the directory, "this_dir"
was the sum of these scores for entries in the directory.

So renaming "this" to "sum" and leaving "this_dir" as-is looks like
readability regression.  Perhaps replace "this_dir" with "sum_changes"
and "this" with "changes" instead, or something like that?

>  diff.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 0a9a0cdf1..d682d0d1f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2601,7 +2601,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
>  	while (dir->nr) {
>  		struct dirstat_file *f = dir->files;
>  		int namelen = strlen(f->name);
> -		unsigned long this;
> +		unsigned long sum;
>  		char *slash;
>  
>  		if (namelen < baselen)
> @@ -2611,15 +2611,15 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
>  		slash = strchr(f->name + baselen, '/');
>  		if (slash) {
>  			int newbaselen = slash + 1 - f->name;
> -			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
> +			sum = gather_dirstat(opt, dir, changed, f->name, newbaselen);
>  			sources++;
>  		} else {
> -			this = f->changed;
> +			sum = f->changed;
>  			dir->files++;
>  			dir->nr--;
>  			sources += 2;
>  		}
> -		this_dir += this;
> +		this_dir += sum;
>  	}
>  
>  	/*
