Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9884AC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752AA613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCJ1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:27:00 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:36814 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCJ1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 05:27:00 -0400
Received: by mail-ed1-f48.google.com with SMTP id w21so6196030edv.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KCURFkfGDyzNV6jpKIbfIscZOoohgvJS3caALQFUDt8=;
        b=C5brsC0evbR/wt0F/ytzqIWDb7M74QtXz6dvZwpDCbqKOkMa8wCz1JfKqt3HNLkz5o
         N/e5uaI4FCNXb8bBc0fqeoJIktyrj2CdHxSp3NJi2A261eADO3BQ8vl73Eul2PY1aokJ
         E6Sffq3gHwLd9OV0MXKKwIR2RMHyzRyYz4fYpYuYLXZZRcgVqWDF8ioRUnYpNSXal/Eg
         apBw8++8hEKYeYq5bgc/P296L6q0BF2MZP2/0MXTGyjREID1OatvCSz7JSFZt+b+wEWi
         VtRipeo8IP4WYYdo7EBayobicvANxqDxqwAtHrdnic88YiVyB5Hauvg8mTloB2jdkHBb
         iIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KCURFkfGDyzNV6jpKIbfIscZOoohgvJS3caALQFUDt8=;
        b=uDdof0m+R5KC6pkVK4vOoQWw7rhbVTa/OoLqb9Ph1Dc7uOeU6+742eiBhLj55jtNDT
         Ov9k+8LVfCQIikinNNhul2mqd2WwVl/q33rct6KEpBYeCoY1oACL0tyMEh15V8W0ucw+
         ktAhhh+fxGM3dfCJgf+Z/GWj4QE/aPhsYO9wXK+1Kp4j70bMIFnIFNlz7bROjQob+TLa
         Bfco/tRr0URfk+ghXx6R0YEXJcNL5f0f/8eUjKfYAvt1NLUn2B5VIFFwK+zPL+iaoEoX
         UhbEfpaJkcorp8tdRH5uOECcWTtnpLFj575/YuffyLd0iWyPiLtMPb3eVvdYOw4mVWBc
         6vqQ==
X-Gm-Message-State: AOAM531EH42Q1GLdJrwuU4//eAn4j83OOMus8YT/QR1M38sww0qbSyUn
        MtTDUQiULgWmtaZlUMsC0cs=
X-Google-Smtp-Source: ABdhPJzp+SOyujAJYu3+NKx6E6WYlyyXIXmMBJFLfaaMdmvqsSz+KyHucDhjYdvaXo9JHoug/9cxhw==
X-Received: by 2002:aa7:d857:: with SMTP id f23mr3111124eds.41.1622712250797;
        Thu, 03 Jun 2021 02:24:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lb23sm1294884ejb.73.2021.06.03.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:24:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 37/37] docs: link githooks and git-hook manpages
Date:   Thu, 03 Jun 2021 11:18:43 +0200
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-38-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-38-emilyshaffer@google.com>
Message-ID: <8735tz713a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> Since users may have an easier time finding 'man githooks' or 'git help
> githooks' through tab-completion or muscle memory, reference the 'git
> hook' commands. And in the 'git hook' manual, point users back to 'man
> githooks' for specifics about the hook events themselves.

Ok, there should be a cross-reference...

> +HOOKS
> +-----

But this should be a "SEE ALSO" section.

> +For a list of hooks which can be configured and how they work, see
> +linkgit:githooks[5].
> +
>  CONFIGURATION
>  -------------
>  include::config/hook.txt[]
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 42e66d4e2d..d780cb3b18 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -7,15 +7,16 @@ githooks - Hooks used by Git
>  
>  SYNOPSIS
>  --------
> +'git hook'

And ditto here, it makes no sense in a githooks(5) to put "git hook" in
the SYNOPSIS section (which is usually commands to be run), that'll just
spew out the --help output for "git hook" itself.

>  $GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
>  
>  
>  DESCRIPTION
>  -----------
>  
> -Hooks are programs you can place in a hooks directory to trigger
> -actions at certain points in git's execution. Hooks that don't have
> -the executable bit set are ignored.
> +Hooks are programs you can specify in your config (see linkgit:git-hook[1]) or

For most other things we link back to git-config[1] for such "see", even
though we have the included config in the specific command.

I can see how this makes more sense in a way, but would prefer to have
us be consistent.

> +place in a hooks directory to trigger actions at certain points in git's
> +execution. Hooks that don't have the executable bit set are ignored.
>  
>  By default the hooks directory is `$GIT_DIR/hooks`, but that can be
>  changed via the `core.hooksPath` configuration variable (see

Not a new issue, but is that "are ignored" not something that pre-dates
"advice.ignoredHook"? I.e. we don't ignore them anymore, we warn about
them, no?
