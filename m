Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A8D1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeJXNgr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:36:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39339 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXNgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:36:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so3109827wrv.6
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ZfD/pklqbldXvLVIeyvLsU4aDb1xGpoKnTL/PhQdLc=;
        b=JMmjaxwUDL6whnT/+lpc+sAKkPAefJSSumhXODfyYnNIzmm+mNaKkOYiy5sgdwmzim
         2TXb99IbAHZSbaBGi7fekNPBX1SX/U2k/u+YmdeSLLz16cFoJMdkkIK2/9eQQY+mQdch
         RDDMARnHIE/ucm6pGHykzwhJrNxZO9sa2lBplLO5kVX4TAjFz1czhoCj4IsdHlkjHVGH
         3W71II4OqmaKI0Zz5wRPAoixBjW8HGq0RV5OEjjR69Gq2SUsIqRS+stDDrcGMxoRrcEL
         5MRBPkPjSbWkoNhnzvB98G8t1YBDjlspnC+l9gXmgVUoPT4hKjlN35agJWNV7Ybn8+19
         1Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ZfD/pklqbldXvLVIeyvLsU4aDb1xGpoKnTL/PhQdLc=;
        b=b5QwcoeeOlypvX2fvfMdMTozbqgG0LNIk5EC0NCTdKgtgFoit9LGgveqgaZ9uDuvhD
         On6VjdjckabLjspJNCnieAv5ZhIioWDLIL2QmWPEcsd/sY0katfi7ejjX8vDGX3P4VuU
         nSxEjkFcSHM0yZ2DHsbOr96E7CmK1iWRH4p5jbuDrfZaMldGTzLhk//F9MBN94au9jVt
         7EYqozi2svQGSNQiSspnwUhjkJp87ji0xqjDsMHcMOlFq7fY1hRpC0qm0JeA4+bHtU2G
         zcv0IhUeclvRXtgKLmJc0uHnRWDKkn/pYpJ+hMUG/7KlnXgAQOOCeCJ0TAXrLnLUsWcD
         7byw==
X-Gm-Message-State: AGRZ1gJhCc5paHodHFTd5rDXeEIAq1dJ9O1ept72j5zhnz0aNKPFtnhg
        8Vh5ppjHhd8xWx9TsawdOII=
X-Google-Smtp-Source: AJdET5cBkacoAuwslo+pJ5FkhqCZ53WSJHfnWsrBEzkLiVEOl5jYBj/7qztEnegFWCYiES+sCTh+Vg==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr1057139wrx.103.1540357816546;
        Tue, 23 Oct 2018 22:10:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q190-v6sm1772518wmg.40.2018.10.23.22.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:10:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com
Subject: Re: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments
References: <20181024022500.GA29011@archbookpro.localdomain>
Date:   Wed, 24 Oct 2018 14:10:14 +0900
In-Reply-To: <20181024022500.GA29011@archbookpro.localdomain> (Denton Liu's
        message of "Tue, 23 Oct 2018 22:25:00 -0400")
Message-ID: <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Subject: Re: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments

Other people may point it out, but s/Accept/accept/.

> In line with how difftool accepts a -g/--[no-]gui option, make mergetool
> accept the same option in order to use the `merge.guitool` variable to
> find the default mergetool instead of `merge.tool`.
> ...
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 9a8b97a2a..e317ae003 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -350,17 +350,23 @@ guess_merge_tool () {
>  }
>  
>  get_configured_merge_tool () {
> -	# Diff mode first tries diff.tool and falls back to merge.tool.
> -	# Merge mode only checks merge.tool
> +	# If first argument is true, find the guitool instead
> +	if [ "$1" = true ]

Don't use [] in our shell script (see Documentation/CodingGuidelines);
say

	if "$1" = true

instead.

> +	then
> +		gui_prefix=gui
> +	fi
> +
> +	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
> +	# Merge mode only checks merge.(gui)tool
>  	if diff_mode
>  	then
> -		merge_tool=$(git config diff.tool || git config merge.tool)
> +		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
>  	else
> -		merge_tool=$(git config merge.tool)
> +		merge_tool=$(git config merge.${gui_prefix}tool)
>  	fi

In mode_ok shell function, we seem to be prepared to deal with a
case where neither diff_mode nor merge_mode is true.  Should this
codepath also be prepared to?  

This is not a comment to point out an issue with this patch.  It is
a genuine question on the code after (or before for that matter)
this patch is applied.

Thanks.
