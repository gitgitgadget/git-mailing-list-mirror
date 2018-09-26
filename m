Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4AB1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIZVaG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 17:30:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38648 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZVaG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 17:30:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so2795887wmi.3
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TteCk07OfU3d4nsdRZ3nvXzKCajE2ScMcKD68eNRNIM=;
        b=D40FRSz1AJR19PSN1EHeGgz8l/Akk2NN3bKrAwvQBfDtmyVn6czM9GvPJ0gi8irsRN
         R4l/OyCQ89rvRREPKWE4msWvaTTfPVJiXk7Jf4GsosH3y9cd+5VG1wsDAs8KmLvDy9Dy
         hkhKyRRYk6OxSuAtG0KZWhcPA/QTCVz5LSmNgdUqp1u6G/lnQfenCC/HuCuzjqjAynfc
         FGgTvRL6meli6GZZktzpZhaLS2XvH6h/Wkz82lxa9UID0lDJFMbNdSl9OAWu0lwH+8se
         HRnE4SkHX8CxKteDnnOPIZHBmd5KOXhl1emnOG/w/C4EL8LM17ZHMmf7tuI3LaxFoh1J
         fVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TteCk07OfU3d4nsdRZ3nvXzKCajE2ScMcKD68eNRNIM=;
        b=fYnQdqwanwaCp1ex61BI8WDyq6qY129HtR2eLrD0CDrelY6qcpZ5BiYfMC7VXYW1Cf
         zZJpnQ0rnDAKSPPMwxbLym9GrP+g+Kyur3IsEwYSitIEP4oOt60XYo2dH5jwivT5fpY/
         T6W4rfCwlGWs3BjiwHClzYcuZim0GiYQnVA0flyVXBpi3fAsY1LyXJnhOCd6hZ/5oUu6
         T9K5HCRuH9kBubroCvBWdUNQnvj/NJOTb27koj81M6OgpyERCFf75IfsfPFTkAU7eYK+
         aCCJPw/6EsJ9wre6Wzuqm1p+2f2Vpal2XTU0D5eDY1HKGKMumKkqAko6IbU5R8liWqTq
         pGmg==
X-Gm-Message-State: ABuFfoh6+g6gD3NiRibw03ujaSEMyblVtCfHYbjQtFa71d9I3nufIYEi
        AIEz3gj3pT/uEXvh10MDuiQ=
X-Google-Smtp-Source: ACcGV62y10k/AMVJu72e/+4jFPVxhlZZmayWPpHWbCLnYIVZs8oW0KeXjp2vVS1XJmLm15jGyfEsgg==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr4651722wmd.7.1537974999184;
        Wed, 26 Sep 2018 08:16:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h73-v6sm12200510wma.11.2018.09.26.08.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:16:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
Date:   Wed, 26 Sep 2018 08:16:36 -0700
In-Reply-To: <20180926102636.30691-1-rv@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Wed, 26 Sep 2018 12:26:36 +0200")
Message-ID: <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> I often use 'git <cmd> --help' as a quick way to get the documentation
> for a command. However, I've also trained my muscle memory to use my
> aliases (cp=cherry-pick, co=checkout etc.), which means that I often end
> up doing
>
>   git cp --help
>
> to which git correctly informs me that cp is an alias for
> cherry-pick. However, I already knew that, and what I really wanted was
> the man page for the cherry-pick command.
>
> This introduces a help.followAlias config option that transparently
> redirects to (the first word of) the alias text (provided of course it
> is not a shell command), similar to the option for autocorrect of
> misspelled commands.

While I do agree with you that it would sometimes be very handy if
"git cp --help" behaved identically to "git cherry-pick --help" just
like "git cp -h" behaves identically to "git cherry-pick -h" when
you have "[alias] cp = cherry-pick", I do not think help.followAlias
configuration is a good idea.  I may know, perhaps because I use it
all the time, by heart that "cp" is aliased to "cherry-pick" and
want "git cp --help" to directly give me the manpage, but I may not
remember if "co" was commit or checkout and want to be concisely
told that it is aliased to checkout without seeing the full manpage.
Which means you'd want some way to command line override anyway, and
having to say "git -c help.followAlias=false cp --help" is not a
great solution.

If we expect users to use "git cp --help" a lot more often than "git
help cp" (or the other way around), one way to give a nicer experience
may be to unconditionally make "git cp --help" to directly show the
manpage of cherry-pick, while keeping "git help cp" to never do
that.  Then those who want to remember what "co" is aliased to can
ask "git help co".

> +		/*
> +		 * We use split_cmdline() to get the first word of the
> +		 * alias, to ensure that we use the same rules as when
> +		 * the alias is actually used. split_cmdline()
> +		 * modifies alias in-place.
> +		 */
> +		count = split_cmdline(alias, &argv);
> +		if (count < 0)
> +			die("Bad alias.%s string: %s", cmd,
> +			    split_cmdline_strerror(count));
> +
> +		if (follow_alias > 0) {
> +			fprintf_ln(stderr,
> +				   _("Continuing to help for %s in %0.1f seconds."),
> +				   alias, follow_alias/10.0);
> +			sleep_millisec(follow_alias * 100);
> +		}
> +		return alias;

If you have "[alias] cp = cherry-pick -n", split_cmdline discards
"-n" and the follow-alias prompt does not even tell you that it did
so, and you get "git help cherry-pick".  This code somehow expects
you to know to jump to the section that describes the "--no-commit"
option.  I do not think that is a reasonable expectation.

When you have "[alias] cp = cherry-pick -n", "git cp --help" should
not do "git help cherry-pick".  Only a single word that exactly
matches a git command should get this treatment.

>  	}
>  
>  	if (exclude_guides)
