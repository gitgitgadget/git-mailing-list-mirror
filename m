Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A14A20248
	for <e@80x24.org>; Sat, 23 Mar 2019 07:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCWHyl (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 03:54:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34738 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWHyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 03:54:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so890504eds.1
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1m6Ljp3C79N9/L+T88+qmYrth6Di/g8mPt+LdJaaVqo=;
        b=PXSn6b6E+1OmmbPUql0iVNv8SVhZDWr/l0tQDZcRKNobJvRwuhLbKjW6pmI0ZSn9kL
         ugfA+syJmdAbA1RDyhJD47mHkUuH/zUcDerEjSL0feBnAWEscuqE53l7ZYKlV9g5r3Y3
         A5pqxEkbBjZMSDWwkxXAZV/UNTI0F+4kU3iJJ0Gf4t8FBMgCNQfCFe0CeY/1XaePbkkV
         ZmOPCFayP6m6XK1NEj4gj/eD5NrQkJr6zVDhHnI3asEqQfudt+5xFnrJYUL+RpKPaHhF
         BuobO+FgdfF/C/7yvaCFzzaanmDLmEVoLuUxLs+Rm+wvFLnmhulRvzhjyetPqfHwFOmN
         QfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1m6Ljp3C79N9/L+T88+qmYrth6Di/g8mPt+LdJaaVqo=;
        b=VczCBKzPbMY9N1JyFnITpt0Yv6WI+51clzTKY0YPRmBg88Jc3AmJizaop7tte/PQgP
         Nll2VGwqfFAa6haGVGeSDz1QCdxY7G19KSCmyeZfLtNJK8whzqJBe7rdiAQsMhf3n9IN
         AY9OHZmx7TRX67W7Vkw6mbJMn/duPVaBvAwppYV/w2y234NUBAbs5qFS6HTyRSr6vXkf
         xI3TspAxk3FJivEjgbM748vNpru/9L+cQWW71aVof19W68WERHHctr9fVsJes/bfghX5
         Q4l5/3YyvxN7JT87k7fN+QHzeKSBHiEUNmhzB4qdQfSsMob3lfIv16mldai5mIZN9TZI
         DEaw==
X-Gm-Message-State: APjAAAX1sjmjo8Ytjq+Puc0juWPC2jmdNhX8s4MAJpdZtHlEHnU6PImu
        XOzBQVfOR63STKaxlfA33uqSkugzTE4=
X-Google-Smtp-Source: APXvYqwM7VhRWnP6fbcFe9DucqeF5dz5mwsgaBHfwNNl80Fzqe+OoHCAkSuyzGjULK56Uy4xmTwaOw==
X-Received: by 2002:a50:92b2:: with SMTP id k47mr8709234eda.148.1553327679442;
        Sat, 23 Mar 2019 00:54:39 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k13sm3346817edl.59.2019.03.23.00.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 00:54:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Keith Smiley <keithbsmiley@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make stashing nothing exit 1
References: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
Date:   Sat, 23 Mar 2019 08:54:37 +0100
Message-ID: <87d0mic9fm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 23 2019, Keith Smiley wrote:

> In the case there are no files to stash, but the user asked to stash, we
> should exit 1 since the stashing failed.
> ---
>  git-stash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 789ce2f41d4a3..ca362b1a31277 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -318,7 +318,7 @@ push_stash () {
>  	if no_changes "$@"
>  	then
>  		say "$(gettext "No local changes to save")"
> -		exit 0
> +		exit 1
>  	fi
>
>  	git reflog exists $ref_stash ||

Thanks for contributing, some points:

 * stash is currently (in the 'next' branch) being rewritten in C. It's
   a better move at this point to patch that version, this code is about
   to be deleted.

 * This is missing a corresponding test, and skimming the stash manpage
   we should document how these exit codes are supposed to act.

 * Shouldn't we do this consistently across all the other sub-commands?
   Trying some of them seems 'push' may be the odd one out, but maybe
   I've missed some (and this would/should be covered by
   tests). I.e. some single test that does a bunch of ops with no
   entries / nothing to stash and asserts exit codes.
