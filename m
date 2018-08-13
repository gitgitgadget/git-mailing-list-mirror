Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DBD1F428
	for <e@80x24.org>; Mon, 13 Aug 2018 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeHMVye (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:54:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35088 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeHMVyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:54:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so9938595wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+s69Lez/yGRvklS2z7W1Kh3rLk2WdCTwwMPDTJpGOMQ=;
        b=t3/ZxufQGQb7+P4DYPpq/74S7yXCfbijOad9JSxOz/0fh5+rCw1LEU7Deo6GRDu8xQ
         K/OvWTfdfFczj+/5gogxuKLKCG2mLmnFK2H0j/87i3rgz+7gx1A9Ae5qIvGpkwUQGHGh
         GDy2jkO6vlwJB0ImAOFrH28TFM03ubC5Es8wKIFRLiPWanUwwHFYMVv7cQGYFPaNyA5H
         2r9hBrVgBSvZStn4QVEf+ycIzCydYse0GS6WBtDaQU/A32GQGuCmSsRe2tHSCOm5/IDJ
         JC0w4PXbsbJh9zjyPcuH+Xxl/TNuqBEyeiURkGs2ka15sim+sa4dW+vLLlFX0Ih83+I+
         n17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+s69Lez/yGRvklS2z7W1Kh3rLk2WdCTwwMPDTJpGOMQ=;
        b=N32+ex6k/3pOJ9o/t6zywh54faVtHoW8/nAl8kSmfu8+ifbStDx8P0GhJSe04cujNn
         ImcVGjyMYAlbMbd75mCuA0B+a+R9fRa1Lf8xkmoipgHrcbD+VciJMuM+8d4Dtlc10Puy
         aoR3migxSGYr6vr4JJHKIUgCgMBkffkAe18kn5L6hE5ymqLcAtIIx/p6miLJg0wzl3nd
         63/d8ygw96KgVapYk1ydPOqrRTXv9z+cfxgIHthWsUYDEexIo/AKINhxw9u3ADpB+Wne
         Vv4qw0jMWCbmi2c4NLEEeX+JYwEcGSUJ0mGBslR0plYn1tP2evka9uu6DQq66NX+DRWg
         0U2A==
X-Gm-Message-State: AOUpUlGHxfYW+KqXxlQtvIx1t/1DdxzTdO0wOVhbOANKRuFnxJgl7M3v
        s1UOl5z3J7ZqLMSa1xYoz7Q=
X-Google-Smtp-Source: AA+uWPzUhR3F8kq8kzbylAR1ykWxx/wRdBuPG87xZZ83U7f1i8SCtfEOnwv78W7l0PitMFA8ySEvPA==
X-Received: by 2002:a1c:c685:: with SMTP id w127-v6mr9303072wmf.133.1534187461174;
        Mon, 13 Aug 2018 12:11:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 198-v6sm21195276wmm.0.2018.08.13.12.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:11:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Guriev <guriev-ns@ya.ru>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mergetool: don't suggest to continue after last file
References: <20180813050929.5531-1-guriev-ns@ya.ru>
Date:   Mon, 13 Aug 2018 12:11:00 -0700
In-Reply-To: <20180813050929.5531-1-guriev-ns@ya.ru> (Nicholas Guriev's
        message of "Mon, 13 Aug 2018 08:09:29 +0300")
Message-ID: <xmqq600e5bgb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Guriev <guriev-ns@ya.ru> writes:

> This eliminates an unnecessary prompt to continue after failed merger.
> The patch uses positional parameters to count files in the list. If only
> one iteration is remained, the prompt_after_failed_merge function is not

s/is remained/remains/, I think.

Other than that, nicely done and nicely explained.

Thanks; will queue.

> called.
>
> Signed-off-by: Nicholas Guriev <guriev-ns@ya.ru>
> ---
>  git-mergetool.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index c062e3d..d07c7f3 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -491,14 +491,16 @@ main () {
>  	printf "%s\n" "$files"
>  
>  	rc=0
> -	for i in $files
> +	set -- $files
> +	while test $# -ne 0
>  	do
>  		printf "\n"
> -		if ! merge_file "$i"
> +		if ! merge_file "$1"
>  		then
>  			rc=1
> -			prompt_after_failed_merge || exit 1
> +			test $# -ne 1 && prompt_after_failed_merge || exit 1
>  		fi
> +		shift
>  	done
>  
>  	exit $rc
