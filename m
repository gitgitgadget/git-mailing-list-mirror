Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5C41F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRVPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:15:53 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:38664 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRVPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:15:52 -0400
Received: by mail-wr0-f182.google.com with SMTP id h3-v6so8473431wrh.5
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSMZXy9iGJBFUukaU/RL9I9GR5jAY/spu/iMFJvbs0c=;
        b=OOzIXqJCIfjtsvR3UQ3GjfLYOq5ZExPapOgK8yeiJfs6/RVOIgBmKVnWwGVsHDHJri
         nQS3WSj+TreHnGh6TW5o8jtaatAGXhX7f/kkOnHww/qfK3Rb2FQ7Emz8UqLRViNeBgMD
         wpekpdrbrx/aKM6COISWSKdj/15P59ypvmGUyOSfdHWrvv/TW0GGKqu1N1PFLcPHlGcj
         pwQDntWr1rSWPmjttGm1wjgVjMUnSpLSZeNCm9FqGAHzzwXGVRaWuh+iuNElwvxHuZsq
         m0Q2HRDYa6/pUzz8DcP4LhvDXy+EJsBJDVwTAZdzLOjsislx+MaHMgIKES7howv1cYXE
         gtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSMZXy9iGJBFUukaU/RL9I9GR5jAY/spu/iMFJvbs0c=;
        b=Dt/a9oxz1dv0BbYWCdjDPIRKH3d0KgkWpcfSqhS8Od0rFEm5ZcSuZYT0KWDxoYCpta
         yZhtWSkCGiMGBtRU+7H5MWfpMJWIFI9SCwUFQZHPvmc5apNiN6JlMPLEEwPGzClHn9sH
         SJWWIaBu/vwTpH8KXE5QfBBYpHmldbVG1RbfMXoBfeAbkf/23fWyrNKOA/F3FQCj6Mkb
         N1icsRqa9UaqYEI3nqYlb1oYl2XdJ3fLFnK0ibPdzNrpXNrtvbN7z2l9R6GWVLWrqjJ9
         19oxHvZed70cmqw/Px7oDAj3n+9KMmO38WF/FCU2jETPcNxe/1kmVghyX9ksqzo8ibDr
         Szjw==
X-Gm-Message-State: ALQs6tALS2qQjrdg2HwlKTHZAb9GcGGmQBf52WEqZwzRx+LrINFhImx2
        r64amXFzlp8EcUcihv1hAEQ=
X-Google-Smtp-Source: AIpwx4+ov+58A8LNRSXUW7UaUF7vAiTw9cy0Rn5RmhkyyW5ioAOw1Pmg0pS1t7dDDZ8t9kqpeiEAxA==
X-Received: by 10.28.134.138 with SMTP id i132mr2753752wmd.101.1524086151093;
        Wed, 18 Apr 2018 14:15:51 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u10sm899522wme.12.2018.04.18.14.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:15:50 -0700 (PDT)
Date:   Wed, 18 Apr 2018 22:15:52 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] completion: improvements for git stash
Message-ID: <20180418211552.GA31895@hank>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
 <xmqqh8o8j4ni.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8o8j4ni.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/18, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > In this series we stop completing the 'git stash save' subcommand in
> > git-completion.bash.  The command has been deprecated for a while,...
> 
> Anything deprecated in Oct 2017 is still too young in Git's
> timescale, but this is the right thing to do in the longer term.

Fair enough.  I vaguely remembered this thread [1], that tried to add
'rm' back to the autocompletion after it was removed originally to try
and start the deprecation process.  Reading the thread again now
though it seems what you outline below to just not show "save" when
"git stash <TAB>" or "git stash s<TAB>" is typed makes more sense as a
step now.

I also notice that we never seemed to have taken any of the
suggestions made there (either adding 'rm' back to the completion
options, or going further in the deprecation process), though that's a
different topic :)

> Regarding [2/3], I think 
> 
>  - It is perfectly fine to stop offering "save" among the choices
>    when "git stash <TAB>" is given, so that we AVOID actively
>    suggesting "save" to those who do not know (or do not want to
>    learn) about it.  Instead we would knudge them towards "push".
>    After all, that is what "deprecation" is all about.
> 
>  - It also is OK to limit the offering to "show" against "git stash
>    s<TAB>", even though the user _could_ have meant "save" than the
>    above case with totally empty subcommand name.
> 
>  - It is questionable to stop offering "save" to "git stash
>    sav<TAB>" it is clear that the user wants to say "save" in this
>    case, as there is no other subcommand the user could have meant.
> 
>  - It is outright hostile to the end user if we stop completing "git
>    stash save --q<TAB>" with "--quiet".  At that point, we _know_
>    that the user wants "save", and getting in the way of those who
>    know what they are using does not feel quite right.
> 
> Of course, being more accomodating to existing users by taking the
> last two points above seriously would raise a separate issue of when
> we stop doing so, and if we should start doing something else.  If
> there is a way to implement a "reluctant completion" that gives
> "save" as a completion choice while giving a deprecation warning to
> let the user know of the plan for removal of "save", that would be
> good, for example.

Thanks for the suggestions, I'll take a closer look at what could be
done, and will send a re-roll.

> Thanks.

[1]: 01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com
