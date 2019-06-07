Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0651F462
	for <e@80x24.org>; Fri,  7 Jun 2019 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFGKDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 06:03:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39952 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGKDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 06:03:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so1526861wre.7
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DS8FAIwxzpycHXnMs+e+ASw1Knuj9ok4Q7YqH0Nx8xw=;
        b=dt0SYRlkf2HBIaIjA/VRw6YC6TcpTs1z1cYuHLeGjcSx/vhIHc8F2zmOWNHKer+tMs
         MpreVq6ROXifYcF9cyDGwXigkgxoA25kSsUncvRnHH2FjQ/q2t+y15iIYb1NSCk8I3Yc
         9hClE9wA28sr8TYbDanx3giel/HQJFlZ5/IIH1PtYRy6hoP4VChiUibQ8FSQAojjMh9n
         KyQiFfQ7QSjCY8IZ9A76jR0mpz1Fs9PlPzpiAvVAuFWmw2eGvfMP/KV+rJQlQM8rjUFF
         AdKYzZhnKDQPLmAaVQC1JA6MYbb/qgG/6+lVu8Fz01kxpnrDeBAS68uHVoI/BMS4XANl
         +nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DS8FAIwxzpycHXnMs+e+ASw1Knuj9ok4Q7YqH0Nx8xw=;
        b=m2WHWkA5ERLDy+iCPlhtrGQa0nJV3uCuu6wyzYbwcjG1p9Z2lOUAlvqwD81r9+RbeT
         4Sfc7P2f/nnZFblPtMz6fKhelbCcj9oS/PnFyykF+4QkD2ZWasC7hgqZ6i/ks+QE/qN4
         NElMi11wXT09d3sEXylLnmveyiNYxKZGJTvl+qtbQy4MaajJT2AFfh0nj6R1L6mCZ34n
         XlEJ/3qOR0oBsO8fyWpZ90+mxve4Bb1r5eV6+hBWeIS+Y/lczr89qd84UtPLRglBVJe/
         sxZ3puIiOtrqnpTpQ1yMQT0mCCTmhRi9TVH11MMpUx/U+d0xzn4m6Np8W2FNB3is9Ny/
         7ZQQ==
X-Gm-Message-State: APjAAAVITI9bGukMFZuOsDybM6/HsNPOH8210Ng3suUu/uKv6Ij1wFoU
        L+sLK4gM6GeX58MTnJG3HyY=
X-Google-Smtp-Source: APXvYqw9Cq0D2mhn+Fm80zObgbtD5ZUHWxJFnBYlBSad91LgoCNNwPiUctFLHd+YytoMgZCPSVdLdA==
X-Received: by 2002:a5d:6389:: with SMTP id p9mr17939267wru.297.1559901778632;
        Fri, 07 Jun 2019 03:02:58 -0700 (PDT)
Received: from szeder.dev (x4db55da0.dyn.telefonica.de. [77.181.93.160])
        by smtp.gmail.com with ESMTPSA id w23sm1386466wmc.38.2019.06.07.03.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 03:02:57 -0700 (PDT)
Date:   Fri, 7 Jun 2019 12:02:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
Message-ID: <20190607100252.GA24208@szeder.dev>
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607093034.816-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 07, 2019 at 04:30:34PM +0700, Nguyễn Thái Ngọc Duy wrote:
> "git <cmd> --git-completion-helper" could fail if the command checks for
> a repo before parse_options(). If the result is cached, later on when
> the user moves to a worktree with repo, tab completion will still fail.
> 
> Avoid this by detecting errors and not cache the completion output. We
> can try again and hopefully succeed next time (e.g. when a repo is
> found).
> 
> Of course if --git-completion-helper fails permanently because of other
> reasons (*), this will slow down completion. But I don't see any better
> option to handle that case.

I think a permanently failing 'git cmd --git-completion-helper'
shouldn't really happen, unless there is a bug in the completion
script or the git installation or similar exceptional situation.  And
then that issue should be fixed, but I don't think we should worry
about an extra subshell and git process in those situations.

> (*) one of those cases is if __gitcomp_builtin is called on a command
>   that does not support --git-completion-helper. And we do have a
>   generic call
> 
>     __git_complete_common "$command"
> 
>   but this case is protected with __git_support_parseopt_helper so we're
>   good.
> 
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9f71bcde96..a515de8501 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -398,13 +398,15 @@ __gitcomp_builtin ()
>  	eval "options=\$$var"
>  
>  	if [ -z "$options" ]; then
> +		local nocache=
>  		# leading and trailing spaces are significant to make
>  		# option removal work correctly.
> -		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) "
> +		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) " || nocache=t

Why not just 'return' here?

If we return, then it won't list any options, and the shell should fall
back to regular file completion.  With this patch it will still list
extra options, if there are any, and I don't really see the point in
doing that.


> +
>  		for i in $excl; do
>  			options="${options/ $i / }"
>  		done
> -		eval "$var=\"$options\""
> +		test -n "$nocache" || eval "$var=\"$options\""
>  	fi
>  
>  	__gitcomp "$options"
> -- 
> 2.22.0.rc0.322.g2b0371e29a
> 
