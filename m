Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251901F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeFDOFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:05:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41345 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFDOFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:05:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so4121597pgl.8
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sMjQX2w9fL35+Alyiw6lPWHkWG3D206U2DUVONSy6ck=;
        b=FF5Q3XDvi4QC6kluVdPOD7rjLQ1jGeRfDKCH7wPJ0PSjYl2b+lwPSt2kgBBqUYGXSS
         At2yYQq0sdu5hgb5VPtqXabuVzG1ZyPHcHoaVwFHufOmNrEGsrCcltSg3U6otBUPJ/jI
         1Ku9Calo27j3v+rRJXgxTpjwllFspVsS8CuLONQkUPVVvgeIjOZ1Cn/PplS3aJ90yqv0
         jsuWeNdvcUs57UjYHmsZucZB984LngHYNzeVfCxPp5kmY6zDfVgY5BXDKA71VgtkhdWG
         fHTbPH9jwmdcoZ0dgtSXd7rSZHJ8my/+S/f4de4fReGkz2sZ3mOOndVkmK4dgFfBXWvY
         rA6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wol.ph; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sMjQX2w9fL35+Alyiw6lPWHkWG3D206U2DUVONSy6ck=;
        b=R4Q3eExhosfmcCCkiktJSEPnOPgSm3aDxvQ96+KKFRKAJtrQ7t7MhXZro+urg44Up/
         rBqnrtewF1uSsKynO9U9xQLSdAxzEwqCxLHtK2fOLYxLQPP+dz7aFgMpWFQS7EoloGkw
         Rb7dX2hUszNzME/AE1MJDLiFKjIUr8N+6lkdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sMjQX2w9fL35+Alyiw6lPWHkWG3D206U2DUVONSy6ck=;
        b=PRBkzX774inIN5q1fp6lGWRpNPpNWxwBdWWT8ckIFXL8LIe+k1wyA8TS++BdV+kFJR
         XMQMbiB2+ptpRan3ojZFV1wrqDr2MafZ2GoPUQhPupAqDSGt+XcWheRMXwggiggB7S3y
         zGYfY6rWzj/rCcunaIdwTwTuthZ6qteUwP7fhpOWCZLU7A4bmub7niPcIfUtEowndLA9
         oRL5vUhcwEtowVHfBEe0PFYi8qusG+qoOT1CGjFdAmrWizMDbVatq/QqiiKdVffU3qCL
         QVO49wyplHQvbw8qfYZu+YusiTILXh4YP/VXlp8Sca9FHTuWuPs6Q2ZunQ3gxz5m+kY/
         NWgQ==
X-Gm-Message-State: ALKqPwc7V/hnSHpxv/3j5lgtoBZvVW9PzMvjoCPrxoJxPbPgetmpwshB
        08nkNU+9nFn2f+bY96HiZJd/LMI7k41+oTkszZv0Bzs8
X-Google-Smtp-Source: ADUXVKJNp3B9go+apInk+QSXgSNaFehOGfw7/guYRnZCja0iedkbK56C3TVXDbD5IUSea7xf65N1xEqcFt8LHWPh7M0=
X-Received: by 2002:a63:7b07:: with SMTP id w7-v6mr16714978pgc.199.1528121113169;
 Mon, 04 Jun 2018 07:05:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2ec9:0:0:0:0 with HTTP; Mon, 4 Jun 2018 07:04:52
 -0700 (PDT)
In-Reply-To: <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com>
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
 <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com>
From:   Rick van Hattem <wolph@wol.ph>
Date:   Mon, 4 Jun 2018 16:04:52 +0200
X-Google-Sender-Auth: S_-2HHBXS6taOh6uB3w1tx-hN8o
Message-ID: <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's
 redefined by git-completion.zsh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 June 2018 at 05:40, Junio C Hamano <gitster@pobox.com> wrote:
Rick van Hattem <wolph@wol.ph> writes:

> > The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
> > ---
>
> Overlong line, lack of sign-off.

Apologies for the long lines, I wrote the message on Github where this
message is properly formatted, apparently the submitgit script can be
considered broken as it truncates the message when converting to email.

The original message can be found here: https://github.com/git/git/pull/500

Below is the original message with proper formatting:

> A recent change (94408dc) broke zsh for me (actually segfault zsh when
> trying to use git completion)
>
> The reason is that the `git-completion.zsh` sets the `ZSH_VERSION`
> variable to an empty string:
>     ...
>     ZSH_VERSION='' . "$script"
>     ...
>
> I'm not sure if @szeder or @gitster used a different zsh version for
> testing commit 94408dc but it segfaults zsh 5.5.1
> (x86_64-apple-darwin15.6.0) on my OS X 10.11.6 machine.
>
> The proposed fix is quite simple and shouldn't break any backwards
> compatibility.

Hopefully that clears a little bit of the confusion.

> >  # Clear the variables caching builtins' options when (re-)sourcing
> >  # the completion script.
> > -if [[ -n ${ZSH_VERSION-} ]]; then
> > +if [[ -n ${ZSH_NAME-} ]]; then
>
> I am not a zsh user, and I do not know how reliable $ZSH_NAME can be
> taken as an indication that we are running zsh and have already
> found a usable git-completion-.bash script.

From what I gathered this variable has been available since 1995. But
I'm not ZSH expert...

You can search for ZSH_NAME in the 3.0 changelog:
http://zsh.sourceforge.net/Etc/changelog-3.0.html

> I think what the proposed log message refers to as "unsets" is this
> part of the script:

As mentioned above, I was referring to commit 94408dc which changed the
behaviour of the bash completion script.

Specifically:

    ...
    if [[ -n ${ZSH_VERSION-} ]]; then
        unset $(set |sed -ne
's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p')
2>/dev/null
    else
        unset $(compgen -v __gitcomp_builtin_)
    fi
    ...

Because the ZSH script unsets the ZSH_VERSION variable (which is needed
because the bash script checks for that later in the script) it defaults
to the bash behaviour resulting in a segfault.

> If your ZSH_VERSION is empty, doesn't it indicate that the script
> did not find a usable git-completion.bash script (to which it
> outsources the bulk of the completion work)?  I do agree segfaulting
> is not a friendly way to tell you that your setup is lacking to make
> it work, but I have a feeling that what you are seeing is an
> indication of a bigger problem, which will be sweeped under the rug
> with this patch but without getting fixed...

The git-completion.zsh script purposefully unsets the ZSH_VERSION
before including the git-completion.bash script like this:

    ...
    ZSH_VERSION='' . "$script"
    ...

The reason for that is (presumably) the check that's used within the
git-completion.bash script to warn ZSH users:

    ...
    if [[ -n ${ZSH_VERSION-} ]]; then
    echo "WARNING: this script is deprecated, please see
git-completion.zsh" 1>&2
    ...


~rick

On 4 June 2018 at 05:40, Junio C Hamano <gitster@pobox.com> wrote:
> Rick van Hattem <wolph@wol.ph> writes:
>
>> The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this check moot. The result (at least for me) is that zsh segfaults because of all the variables it's unsetting.
>> ---
>
> Overlong line, lack of sign-off.
>
>>  # Clear the variables caching builtins' options when (re-)sourcing
>>  # the completion script.
>> -if [[ -n ${ZSH_VERSION-} ]]; then
>> +if [[ -n ${ZSH_NAME-} ]]; then
>
> I am not a zsh user, and I do not know how reliable $ZSH_NAME can be
> taken as an indication that we are running zsh and have already
> found a usable git-completion-.bash script.
>
> I think what the proposed log message refers to as "unsets" is this
> part of the script:
>
>         ...
>         zstyle -s ":completion:*:*:git:*" script script
>         if [ -z "$script" ]; then
>                 local -a locations
>                 local e
>                 locations=(
>                         $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>                         ...
>                         )
>                 for e in $locations; do
>                         test -f $e && script="$e" && break
>                 done
>         fi
>         ZSH_VERSION='' . "$script"
>         ...
>
> If your ZSH_VERSION is empty, doesn't it indicate that the script
> did not find a usable git-completion.bash script (to which it
> outsources the bulk of the completion work)?  I do agree segfaulting
> is not a friendly way to tell you that your setup is lacking to make
> it work, but I have a feeling that what you are seeing is an
> indication of a bigger problem, which will be sweeped under the rug
> with this patch but without getting fixed...
