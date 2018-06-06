Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E101F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFFLl7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:41:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52911 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeFFLl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:41:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so10939370wmb.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yl0otF/KXSQxt1xjYZstPuVK9/h3syCqOGXOBZZmk/I=;
        b=Cilz40S9jvvuHEaOtAh4bK6/rIBWNkzq+Tbrt5/VXXlQ4oMOLWVJpkOAZH2O/6gUWr
         PJuHPfANbx8IojJ7Q2hOoPieJMz0JKdDKM0AnAROXRj4aX3aXAXnMZVzf716v3qtdeR/
         glOP7KrWt2WckHOtRZ5Qi53KuOxpaXgv1ZpxmU2yRChNEeX8KFKtTNCh1GhLEBNgGzJj
         mOsAIHmboKCyjnqpt5tVKV9JSlBBuRrinrUpGGJnrh85EPhogBmTdJMFRoyvtg0aDxb4
         vsPPGN+iYZPJ/dKiZH7Bz9S8rckl34YYZuyemErVJwlxO+eq6HR447NrNN8daIiIgIqI
         y4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yl0otF/KXSQxt1xjYZstPuVK9/h3syCqOGXOBZZmk/I=;
        b=dcEKP0xOjcS71PGx95JcOsI86HKR/u2r+SsWLxBQgjO/2gBZSX6dh8p073RO2X1cfV
         4xudHxeXhUSvjMn4VkuHFXg5y0zZXoLLXMKn50I48T6NKNodJX/9MChSALLCCyckZqLX
         4RF/++D61GGuvVKi8NOOGxczeCSBG6uchCJ1FP0XIlMeLSZLIkSZ0xExKHPsaBOuPq85
         c347rc7tb33zVeo5OLIl6a5PaLNTVm+RnarMcJDuU4BqySYzdIb5TxoPnf/uRUbSlnsf
         QZYsH3dUmH5Seruh8aKCxhee/zFng3kb4IyYZOa1dChEOTyeNxVNi43FMDCvpAfs9Ibz
         NY3Q==
X-Gm-Message-State: APt69E3gn6MH0ZImay+4iXwBm4p4+69qRGNTScx/5uQTFNLnzBmKyDaI
        FXtxBEHTvIf7XYhXOLTnr+s=
X-Google-Smtp-Source: ADUXVKKxU4LVC0iShN9ZN17odH0JVWfLksHWC20n27suD/2WR+OQtQIX+4iaym5qRJXqwcMMJdFFJQ==
X-Received: by 2002:a1c:540c:: with SMTP id i12-v6mr1574854wmb.131.1528285312943;
        Wed, 06 Jun 2018 04:41:52 -0700 (PDT)
Received: from localhost.localdomain (x590e531a.dyn.telefonica.de. [89.14.83.26])
        by smtp.gmail.com with ESMTPSA id b80-v6sm6241533wmf.2.2018.06.06.04.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jun 2018 04:41:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Rick van Hattem <wolph@wol.ph>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's redefined by git-completion.zsh
Date:   Wed,  6 Jun 2018 13:41:47 +0200
Message-Id: <20180606114147.7753-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com> <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com> <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 4 June 2018 at 05:40, Junio C Hamano <gitster@pobox.com> wrote:
> Rick van Hattem <wolph@wol.ph> writes:
> 
> > > The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
> > > ---
> >
> > Overlong line, lack of sign-off.
> 
> Apologies for the long lines, I wrote the message on Github where this
> message is properly formatted, apparently the submitgit script can be
> considered broken as it truncates the message when converting to email.
> 
> The original message can be found here: https://github.com/git/git/pull/500

That link points to the pull request.  The important thing is the
actual commit message, which can be found here:

  https://github.com/git/git/pull/500/commits/b740bc3fedf419c7ee12364279cad84e1f2f7bb7

So submitgit neither truncated the commit message nor changed its
formatting.

> Below is the original message with proper formatting:
> 
> > A recent change (94408dc) broke zsh for me (actually segfault zsh when
> > trying to use git completion)
> >
> > The reason is that the `git-completion.zsh` sets the `ZSH_VERSION`
> > variable to an empty string:
> >     ...
> >     ZSH_VERSION='' . "$script"
> >     ...
> >
> > I'm not sure if @szeder or @gitster used a different zsh version for
> > testing commit 94408dc but it segfaults zsh 5.5.1
> > (x86_64-apple-darwin15.6.0) on my OS X 10.11.6 machine.

I used "zsh 5.1.1 (x86_64-ubuntu-linux-gnu)", the one shipped in this
LTS of a Debian derivative's derivative, for superficial testing:
started zsh, dot-sourced 'git-completion.bash' (yes, .bash), it
appeared to be doing what I thought it should be doing, great, done.

I don't test 'git-completion.zsh': merely sourcing it doesn't seem to
work at all for me, I still get ZSH's git completion.

> > The proposed fix is quite simple and shouldn't break any backwards
> > compatibility.
> 
> Hopefully that clears a little bit of the confusion.
> 
> > >  # Clear the variables caching builtins' options when (re-)sourcing
> > >  # the completion script.
> > > -if [[ -n ${ZSH_VERSION-} ]]; then
> > > +if [[ -n ${ZSH_NAME-} ]]; then
> >
> > I am not a zsh user, and I do not know how reliable $ZSH_NAME can be
> > taken as an indication that we are running zsh and have already
> > found a usable git-completion-.bash script.
> 
> >From what I gathered this variable has been available since 1995. But
> I'm not ZSH expert...
> 
> You can search for ZSH_NAME in the 3.0 changelog:
> http://zsh.sourceforge.net/Etc/changelog-3.0.html
> 
> > I think what the proposed log message refers to as "unsets" is this
> > part of the script:
> 
> As mentioned above, I was referring to commit 94408dc which changed the
> behaviour of the bash completion script.
> 
> Specifically:
> 
>     ...
>     if [[ -n ${ZSH_VERSION-} ]]; then
>         unset $(set |sed -ne
> 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p')
> 2>/dev/null
>     else
>         unset $(compgen -v __gitcomp_builtin_)
>     fi
>     ...
> 
> Because the ZSH script unsets the ZSH_VERSION variable (which is needed
> because the bash script checks for that later in the script) it defaults
> to the bash behaviour resulting in a segfault.

I think this segfault issue should definitely be addressed in ZSH.  No
matter what foolish or downright wrong thing a script does, the shell
should not segfault.

> > If your ZSH_VERSION is empty, doesn't it indicate that the script
> > did not find a usable git-completion.bash script (to which it
> > outsources the bulk of the completion work)?  I do agree segfaulting
> > is not a friendly way to tell you that your setup is lacking to make
> > it work, but I have a feeling that what you are seeing is an
> > indication of a bigger problem, which will be sweeped under the rug
> > with this patch but without getting fixed...
> 
> The git-completion.zsh script purposefully unsets the ZSH_VERSION
> before including the git-completion.bash script like this:
> 
>     ...
>     ZSH_VERSION='' . "$script"
>     ...

Oh, I was not aware of this.  It does feel a bit hackish, doesn't it.

> The reason for that is (presumably) the check that's used within the
> git-completion.bash script to warn ZSH users:
> 
>     ...
>     if [[ -n ${ZSH_VERSION-} ]]; then
>     echo "WARNING: this script is deprecated, please see
> git-completion.zsh" 1>&2
>     ...

And, perhaps more importantly, to not load a bunch of shell functions
that follow that warning.

> >>  # Clear the variables caching builtins' options when (re-)sourcing
> >>  # the completion script.
> >> -if [[ -n ${ZSH_VERSION-} ]]; then
> >> +if [[ -n ${ZSH_NAME-} ]]; then

Looking at $ZSH_VERSION is our standard check both in the completion
and prompt scripts.  Changing only one of those checks to look at
$ZSH_NAME instead brings inconcistency and confusion.

I think it would be better to eliminate that "let's pretend it's not
ZSH" hack and make 'git-completion.zsh' more explicit by sourcing
'git-completion.bash' something like this:

  DOT_SOURCING_FROM_GIT_COMPLETION_ZSH=PleaseSkipDeprecatedFunctions . "$script"

(with a more sensible variable name, of course :), and
'git-completion.bash' should additionally check this variable as well.


