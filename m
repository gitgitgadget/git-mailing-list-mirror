Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C971FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdBMUps (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:45:48 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:35758 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbdBMUpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:45:47 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so2855222ith.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zq0lM3aUmM/4yO13L+Un8nYcgKrbSuDH6GQ3MGoC7eg=;
        b=QIhDkFtMiwgtntKLgAHKSgvtcIdYLNBYNeHoz9Zn9DfGq3ghcnufi9DMUtwmswY7bM
         pJi9YCKudg8Vh59NV3CYsSezt8z8X0ODys291JFNxk20oImj3W9nkw0V4HD4POpNgM+k
         nS/ezKa1+FwJ/jSor1XhpQ+kiA86kdulRKknHbAi5yyckyGF7Dp+gPV/RTMCRAJjUmn5
         rIWOlb0lSKreev0aTptogVZvPx8qq6zZrTWLotnGchBlm1z1tT9f/HdJdrv4MLYgJY4h
         gyfoyDxZuU1Jul7EniELTWAEKiTo1Stw8zzpmvIjvMSvQqDF8Bebt6g3c/gq+0gEwEnu
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zq0lM3aUmM/4yO13L+Un8nYcgKrbSuDH6GQ3MGoC7eg=;
        b=WhkOBv6yTMV4utc+1wE4krc7FtT9b0SK6WFr884YA3LG/gxN2mIX/yDyTE+uF9Mhia
         gwfAwJ049MM30TIg3W9kZQzbBYNaFKssaD5CYfDOAqdCjGT5vmykm6gu4M15R03qizTl
         hXs0Z23RLjYA2lIehv7kveNSaoIriU4WNS6tJp4mWoA4HhpCAhyJ8d4JL1oARmeYjUd2
         92wS2qeZbPlAVGPezDLX4pL5dQc63hMXgfFoJ2dv4VZXpyTqFXS1VlOyQ2CcCp3UMiU/
         SHlLyuFMW3/YNkOCwlnHVW2dSOZM2QFg1fhnOvp3kwS/fndXFoHKmzSERnoETRCQ6hkg
         O6Hw==
X-Gm-Message-State: AMke39lCEIpInhT6YNbzHG1bxbRu/T1JZWS04YYRwFblsw9rOYX9jzZM7zm2yIlJ7PQwlw==
X-Received: by 10.84.225.146 with SMTP id u18mr6061769plj.157.1487018746868;
        Mon, 13 Feb 2017 12:45:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id x15sm16377815pgo.56.2017.02.13.12.45.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:45:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: restore removed line continuating backslash
References: <20170213192036.10671-1-szeder.dev@gmail.com>
Date:   Mon, 13 Feb 2017 12:45:45 -0800
In-Reply-To: <20170213192036.10671-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 13 Feb 2017 20:20:36 +0100")
Message-ID: <xmqqfujhddl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Recent commit 1cd23e9e0 (completion: don't use __gitdir() for git
> commands, 2017-02-03) rewrapped a couple of long lines, and while
> doing so it inadvertently removed a '\' from the end of a line, thus
> breaking completion for 'git config remote.name.push <TAB>'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>
> I wanted this to be a fixup!, but then noticed that this series is
> already in next, hence the proper commit message.

We get "--format=... : command not found"?
Thanks for a set of sharp eyes.

> I see the last What's cooking marks this series as "will merge to
> master".  That doesn't mean that it will be in v2.12, does it?

I actually was hoping that these can go in.  Others that can (or
should) wait are marked as "Will cook in 'next'".

If you feel uncomfortable and want these to cook longer, please tell
me so.

Thanks.

>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 993085af6..f2b294aac 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2086,7 +2086,7 @@ _git_config ()
>  	remote.*.push)
>  		local remote="${prev#remote.}"
>  		remote="${remote%.push}"
> -		__gitcomp_nl "$(__git for-each-ref
> +		__gitcomp_nl "$(__git for-each-ref \
>  			--format='%(refname):%(refname)' refs/heads)"
>  		return
>  		;;
