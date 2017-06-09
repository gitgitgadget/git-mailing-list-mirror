Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D081F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdFIQ25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:28:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36252 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdFIQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:28:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so8068699pgb.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iGvPofeM7agtCAob3r9U3MP6PP8oPddUbSxY3JQIpeM=;
        b=ms7bMBJ/dVY12O0EHTKYmbJr8kgcKwoJNehSfnyGS93KrQO4ihnidMY/wWpVNP3GiV
         UfdmEwrKal3wzYDElyCYo90YAAIWZ7I6QLw0xb/UgmHo/ZbS0bHdSQ/3tJ6w4248K48l
         NhY5I1wQSQXMnfqvtXilsHxmqQeJtt0eAay0+s8rKxetGK8v5CMciEfXUBStZi6N8YEy
         HASGfQ8/SoO9NhivK5SAGeepLUpWnMjTEyV/boSpEH9NOVZrL9anDlMIUO31xyixn6La
         GWUoQ6M/Xeo2WOCIQoN/1rNzf1ZXe3yYTJcFuoMIRj3Z4dt92RBiEbjq8S7z6T+e4mR1
         ND5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iGvPofeM7agtCAob3r9U3MP6PP8oPddUbSxY3JQIpeM=;
        b=AgwsPa0qAQIhuCyjAGl9gtkkTyiq7gZ1I4ygZPAuiiSG56tzZ8vwIzLEJI+7EwfB3D
         GctC55lwS5n0hj+M7pMbreF2OCYaI4nMG1zlJChFhLAlGxV/Sks9G5KFsczdb+vUiEIX
         r+Qvp2zblxs8j7UjG56Cy6YMvpL4aEywsaf5oPHU7K1HVLxFjULzaOa/W1P2SZADtxEc
         PBWdgpx5V4/tFR/8IO+xz3woF0KGcb2LReUWI0w+f2xYOgcco6Y0qjPH5XceyFRQjeXn
         KqTvYszvGnJ82thYKqcZzROV20H5bhrtdn3jf/9emF8hhIiUgX9wCM/kzeHZpHVZqC3y
         fYcw==
X-Gm-Message-State: AODbwcDk6s5/IqpQIu+q/1lMkJv+JXyLV19dC3DWerSRnmydKIIcGZOE
        v8J3goGqhC4aag==
X-Received: by 10.84.171.193 with SMTP id l59mr43193097plb.139.1497025735901;
        Fri, 09 Jun 2017 09:28:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id w10sm2882780pge.48.2017.06.09.09.28.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 09:28:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
Date:   Sat, 10 Jun 2017 01:28:54 +0900
In-Reply-To: <20170607033308.33550-1-emilyxxie@gmail.com> (Emily Xie's message
        of "Tue, 6 Jun 2017 23:33:08 -0400")
Message-ID: <xmqq60g56s6x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> An empty string as a pathspec element matches all paths.  A buggy
> script, however, could accidentally assign an empty string to a
> variable that then gets passed to a Git command invocation, e.g.:
>
>   path=... compute a path to be removed in $path ...
>         git rm -r "$path"
>
> which would unintentionally remove all paths in the current
> directory.
>
> The fix for this issue comprises of two steps. Step 1, which warns
> that empty strings as pathspecs will become invalid, has already
> been implemented in commit d426430 ("pathspec: warn on empty strings
> as pathspec", 2016-06-22).
>
> This patch is step 2. It removes the warning and throws an error
> instead.
>
> Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> Reported-by: David Turner <novalis@novalis.org>
> ---

We started this at v2.11.0 at the end of November 2016, and this
cycle is expected to complete at around the end of July 2017, so
this patch makes it a 8-month deprecation cycle.  I think that it
should be long enough.

Thanks.

> diff --git a/pathspec.c b/pathspec.c
> index 50f76ff..65e18b1 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -638,12 +638,10 @@ void parse_pathspec(struct pathspec *pathspec,
>  	}
>  
>  	n = 0;
> -	warn_empty_string = 1;
>  	while (argv[n]) {
> -		if (*argv[n] == '\0' && warn_empty_string) {
> -			warning(_("empty strings as pathspecs will be made invalid in upcoming releases. "
> -				  "please use . instead if you meant to match all paths"));
> -			warn_empty_string = 0;
> +		if (*argv[n] == '\0') {
> +			die("empty string is not a valid pathspec. "
> +				  "please use . instead if you meant to match all paths");
>  		}
>  		n++;
>  	}

The {} around a single statement becomes unnecessary, so I'll remove
them while queuing.
