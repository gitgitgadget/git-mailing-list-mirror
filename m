Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCD11F42E
	for <e@80x24.org>; Sun,  6 May 2018 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeEFIYp (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 04:24:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40695 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeEFIYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 04:24:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id p85-v6so985915lfg.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BSdHYVFUUPxjmFXpt+A3MFURUsqRSmXTbcJsbYLOcpc=;
        b=iO68jyuGO8meEDTdfRWJ3kA87v02fjqQERfRkjBIJzw+cShVLuhrtIc6gJauMOmtp8
         IwG87JRJ+hSSF/u5o23qVUU3u8wkkYil3yKBhRCZVzqoK7do7Mpg8grCW9CfhjBnmKYf
         sGl0cPp8klssEerM5kRSxyKPv7YF8+L5UouRWFhCgiAFYkAbp8keT5ao+MvyhX/4Jy0P
         wGzd5xAqAj5YCXKEFgvOygGL+PRXfD0gUwZhOF34cGwtQmMUsrO8tbpIWl5BWVsWnJTC
         7Pg2NpqkFkV6E/e0iw//R6Grl64ELrghO2z2X7tsNI+aqcrUN/pNVxejunKjddB5TAlW
         0Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BSdHYVFUUPxjmFXpt+A3MFURUsqRSmXTbcJsbYLOcpc=;
        b=K81aRt+MxAbFL1SQW3TGbWY9dS3RvX23/j/pUiD7ZY0kK5eUzaK2bRzDLlgaYUJJsM
         Eb51J9Ro26r8GI8r0Dp7i8IQyzYhP9bSz6gxdfMtkl4qHujavRNEiOeGLJEZMgfglS8s
         nP4z7mxhmkmchZjOrS/Hxz6P3Okzbexhf7PzzNRCcZgfV9lhs7UdWo5z3ErGcsLevsyZ
         OP+Eu3/oZd51pMy/NJ/61GwwrHiJLp4in5KCLAmKPp8dG6O4U/gNblf63J1Qk8KjUCNg
         YjvKAjM32SnS6qnEhXkTIY4ScxBoP7FulI27kijjT/JxSpzVzKZSCawrtTtoENncgWVa
         Kg6Q==
X-Gm-Message-State: ALQs6tAVgDMUK4E1FQP/1+mBjsy530i5mtxuE4H7XRYWnMIdFQkJGh7U
        S0tLzvWwubjwouCH9zuJLps=
X-Google-Smtp-Source: AB8JxZqq6OHSCLLDjwNRYnCld5V6tMAydO95ggJvANacOVRV37pb8ppoomOy+Qasv9aHyavJCNjWdQ==
X-Received: by 2002:a19:690e:: with SMTP id e14-v6mr20339891lfc.44.1525595082839;
        Sun, 06 May 2018 01:24:42 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p88-v6sm3862401lja.0.2018.05.06.01.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 May 2018 01:24:41 -0700 (PDT)
Date:   Sun, 6 May 2018 10:24:40 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 18/18] completion: support branch-diff
Message-ID: <20180506082440.GA26958@duynguyen.home>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 05:35:11PM +0200, Johannes Schindelin wrote:
> Tab completion of `branch-diff` is very convenient, especially given
> that the revision arguments that need to be passed to `git branch-diff`
> are typically more complex than, say, your grandfather's `git log`
> arguments.
> 
> Without this patch, we would only complete the `branch-diff` part but
> not the options and other arguments.
> 
> This of itself may already be slightly disruptive for well-trained
> fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
> `git branch origin/master`, as we now no longer automatically append a
> space after completing `git branch`: this is now ambiguous.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/completion/git-completion.bash | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 01dd9ff07a2..45addd525ac 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1496,6 +1496,24 @@ _git_format_patch ()
>  	__git_complete_revlist
>  }
>  
> +__git_branch_diff_options="
> +	--no-patches --creation-weight= --dual-color
> +"
> +
> +_git_branch_diff ()
> +{
> +	case "$cur" in
> +	--*)
> +		__gitcomp "

You should use __gitcomp_builtin so you don't have to maintain
$__git_branch_diff_options here. Something like this

-- 8< --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 45addd525a..4745631daf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1496,18 +1496,11 @@ _git_format_patch ()
 	__git_complete_revlist
 }
 
-__git_branch_diff_options="
-	--no-patches --creation-weight= --dual-color
-"
-
 _git_branch_diff ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			$__git_branch_diff_options
-			$__git_diff_common_options
-			"
+		__gitcomp_builtin branch-diff "$__git_diff_common_options"
 		return
 		;;
 	esac
-- 8< --


> +			$__git_branch_diff_options
> +			$__git_diff_common_options
> +			"
> +		return
> +		;;
> +	esac
> +	__git_complete_revlist
> +}
> +
>  _git_fsck ()
>  {
>  	case "$cur" in
> -- 
> 2.17.0.409.g71698f11835
