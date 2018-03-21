Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B721F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeCUWHi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:07:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38383 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeCUWHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:07:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id l16so12617501wmh.3
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fnuVCg9do3A9OupT5vd0SMs9LBcjajvKjGWL6zV5Ruk=;
        b=aON7xq+m5r1BJDkYh2tJChrDAeA3F4HaxQ0xYluRnj3l2WV5p0kza+G2bdkeFAmGMI
         QL8fBBqsRxnbYxCK91R2wU1e+60NkL05UJUNIoso3mwPsCK2p3rAGcVRZGy/NegXegG/
         4dFpF2oBzrSp0fXOgKNwltI1ST67nHp7puRplrEj3h3v0xIdrfpEtZL225xUW7I4Zbpp
         X3J3wmTo3cio4lZdtHIi6MY1U/KLir5vmbBYyMENaPMFYcrqbAXDqHyyHmer4FmXo8dv
         hU9xww9Diu9FP3XFRXIsKMYjeQA+L68ptpwl+6tCu0RwyAQS3rZY5ngr7E4k7waTmUMB
         HEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fnuVCg9do3A9OupT5vd0SMs9LBcjajvKjGWL6zV5Ruk=;
        b=qLjiodfmd/VxiVSDmctu0JuBtVRL9YYXmUBfahlEzlJ5hV7j88xT7s+yPdHrW+H2Hf
         cl/xctbV9e6llNzySPqV5zuqq0eHFgBpjmNij0oHFwMpG7Rj+gS2Bm0Dol6uipKqTPV1
         q48Z2uoiCDyYywWNdgwY+bWWCpuC+gnrpmW3kbGfMQP3XeYeqwMN8BUZMT0uJaSuICos
         W6srsveC/B3jv4aCgdDyvTv84pIhQaVu7+nOJMqtuppObiSxxsBGSTcKNq0G2TuCUxFm
         5nn8+4tFXIo9sk1ZrpY1mN4yxesJwLtYxvWbcKYHM7fjL3/TdXRL5PhOnil2ugd7ICMv
         5RPA==
X-Gm-Message-State: AElRT7EGXDNfuDzPAvqmXB/I3KTpeDtBQqH3r/Vhjq/icmVX24azRi2I
        E4XYpBILmaHzfOE9b34MZQ8=
X-Google-Smtp-Source: AG47ELuGpQh+3lqGdigCgFVR1MOvmlzz71U3XeVPd555KtgwknRIx/r5wTsJIe8RxupIkhPux/7X9g==
X-Received: by 10.28.35.76 with SMTP id j73mr3549110wmj.103.1521670056342;
        Wed, 21 Mar 2018 15:07:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n64sm5065773wmd.11.2018.03.21.15.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:07:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH] stash: drop superfluos pathspec parameter
References: <20180316223715.108044-1-gitster@pobox.com>
        <20180319232156.30916-1-t.gummerer@gmail.com>
        <20180319232156.30916-3-t.gummerer@gmail.com>
        <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
        <20180321213626.GG2224@hank> <20180321215310.GH2224@hank>
Date:   Wed, 21 Mar 2018 15:07:35 -0700
In-Reply-To: <20180321215310.GH2224@hank> (Thomas Gummerer's message of "Wed,
        21 Mar 2018 21:53:10 +0000")
Message-ID: <xmqqzi31m6ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 03/21, Thomas Gummerer wrote:
>>
>> Argh I just noticed we could drop the "$@" here, as this is no longer
>> the pathspec case.  It doesn't hurt anything, except it may be a bit
>> confusing when reading the code.
>> 
>> Although if we end up implementing 'git checkout --index <pathspec>',
>> we'd have to add it back, but we do have a test covering this case, so
>> there's no worries about forgetting to add it back.
>
> Here's a patch for that.  Not sure it's worth doing, but since we're
> already touching the area, this may be a good cleanup.

OK, I can go either way, and since you have already written a
change, let's not waste it ;-)

Thanks.

>
> This is based on top of tg/stash-untracked-with-pathspec-fix.
>
> --- >8 ---
> Subject: [PATCH] stash: drop superfluos pathspec parameter
>
> Since 833622a945 ("stash push: avoid printing errors", 2018-03-19) we
> don't use the 'git clean' call for the pathspec case anymore.  The
> commit however forgot to remove the pathspec argument to the call.
> Remove the superfluos argument to make the code a little more obvious.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  git-stash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4e55f278bd..d31924aea3 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -310,7 +310,7 @@ push_stash () {
>  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
>  		if test -n "$untracked" && test $# = 0
>  		then
> -			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
> +			git clean --force --quiet -d $CLEAN_X_OPTION
>  		fi
>  
>  		if test $# != 0
