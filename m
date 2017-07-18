Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB0B2082F
	for <e@80x24.org>; Tue, 18 Jul 2017 07:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdGRHQx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 03:16:53 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36408 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdGRHQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 03:16:52 -0400
Received: by mail-ua0-f171.google.com with SMTP id 35so13118177uax.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JSPPhhLtWTcq4hbXgpJ5KPgyx/cBmQudfCrgwfXaEXk=;
        b=YCf62P2TqNzOLboJVnXiyd33Omxns4DuBaTbJgQ7ZIU3LMpbaqTs2BAbnxPiq0uFiD
         D/oPtc8ATRMBcHDKS6nsP2BN3uOBJoYccYrvgAnq+WdO/06xXgcPls5gvRu5eIhUcMth
         m+2MKpd+6RMD6+tbi/Ls8znV3/WPfkqXJWRjMbCWLJCgXGLXb6euv4inwTMi/9jDlc+W
         GsXcggPsXoqaTEzMKgmjYpw8fSl11g2PVDIlKcWcKn4Xjh1aq+A68x+AQ1YsZz1SoaR7
         Ge7lPfVJXhUwJ7NaHRhyBvfwBNU0gW3SN948TCGbyCNdL1NwHxa5FViTCKbNWiC69CKY
         zSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JSPPhhLtWTcq4hbXgpJ5KPgyx/cBmQudfCrgwfXaEXk=;
        b=s6msCe6vUkut+FpLx912uDAQ61xG21bmv6NyzlIzNGKj05dNccWkNk8EVkZoOKjfQn
         Zq3GJHgy9QC38ArmXELJdtzEizdBUmxXsosgFnNVX6WQGBFTxlD1YnPK5dk3v7Ufsj06
         PukMOnV5bWmXJU+qgFuKrB7B2reTA9RwWEFZl+Fh5E5h9nCnuoY2YtcbP7/hCRJGODGW
         EQT5hFa3LH8tsMYULwxSECQpBKus2EGthtvPBRry/XHGRoNPsp0JV+Ojfw6l4Zv8ENTb
         mzGKEUsr9pCLG2dHM2Fe8i6CDUl0Zyct4bBE9v57+QfrkcMoP+1HGq5yH3m2sfPToaZ0
         LFPA==
X-Gm-Message-State: AIVw111bOco5khBmE0fwXHVAxNZ9hS5FLTKANx/wEiDi9Rgq5qYDqt68
        HsgvX9vSOVqieDBeSroRf0MmPYZIqg==
X-Received: by 10.31.0.69 with SMTP id 66mr106112vka.31.1500362211539; Tue, 18
 Jul 2017 00:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.223 with HTTP; Tue, 18 Jul 2017 00:16:50 -0700 (PDT)
In-Reply-To: <xmqqinjdqo1i.fsf@gitster.mtv.corp.google.com>
References: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
 <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com> <CAGZ79kYd+3OoUBcsTS9=S9qEUwKj9ypyHyjXLBW=KjWOVoae4A@mail.gmail.com>
 <CAFirYm_UzUe=zSefAVpt45OuEwKyn7bAZbumLXYWbPFVRahPew@mail.gmail.com> <xmqqinjdqo1i.fsf@gitster.mtv.corp.google.com>
From:   Laurent Humblet <laurent.humblet@gmail.com>
Date:   Tue, 18 Jul 2017 09:16:50 +0200
Message-ID: <CAFirYm8G-8DAfapeSvuRk1QghBZE1W0Pa1h+NDMvVNT5Kd354w@mail.gmail.com>
Subject: Re: Warning suggestion for git stash drop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh great, an answer 20 days later ... Sorry about this.

I have been reading a bit on the topic and found that for Bash we
should be using shell functions over aliases so I wrote this function
to be simply added to the .bashrc:

# 'git stash drop' confirm shell function
git() {
    if [[ $@ == "stash drop" ]]; then
        read -r -p "Are you sure you want to drop your stash? [y/N] " response
        case "$response" in
            [yY][eE][sS]|[yY])
                command git "$@"
                ;;
        esac
    else
        command git "$@"
    fi
}

Be careful, I'm no Bash expert and I don't believe it is fully POSIX
compliant but it's a good start I think.  This could also be used for
the 'rm -rf' command or any other potentially dangerous command I
believe.  Maybe there is a place for a .bashrc_safe_shell_functions
that could be loaded by the user to add confirmation before all
potentially dangerous commands but it'll be for another thread.

Thank you for your help guys and keep up with your excellent work on Git!

All the best,
Laurent


On 30 June 2017 at 21:21, Junio C Hamano <gitster@pobox.com> wrote:
> Laurent Humblet <laurent.humblet@gmail.com> writes:
>
>> Thank you for your feedback.
>>
>> I suppose that turning a hypothetical confirmation option 'on' would
>> impact a stash pop for instance as it automatically drops the stash if
>> it was applied without conflicts.
>>
>> What about a --confirm flag?  You could then simply alias 'git stash
>> drop --confirm' locally and it wouldn't impact anything else?
>
> I think that is probably trivial to add, but how would you make sure
> you give it?  One way may be to train your fingers to type "git sd"
> with something like this in your ~/.gitconfig:
>
>         [alias] sd = "stash drop --confirm"
>
> but at that point, you could instead have something like the
> following in you ~/bin/git-sd and get the same effect:
>
>         #!/bin/sh
>         if tty -s
>         then
>                 echo >&2 "are you sure you want to drop all stash entries?"
>                 case "$(read)" in
>                 [Yy]*) ;;
>                 *) echo >&2 "ok, let's not drop 'em"; exit 0 ;;
>                 esac
>         fi
>         exec git stash drop
>
> without adding the "--confirm" option at all.
>
> So I am not sure that would get us closer to a satisfactory solution
> to your original problem.
>
> Retroactively adding an end-user safety is hard.
>
>> Have a great week-end!
>
> You too.
