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
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BB420248
	for <e@80x24.org>; Fri, 29 Mar 2019 08:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfC2IiS (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 04:38:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38089 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfC2IiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 04:38:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so1300948edr.5
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p63Qbk5vY9h9e/l1E12+/oRi01erw+ylPzxplkXhuyM=;
        b=DgpSk8bIQ1nLa7KJwcx8GPZVQpE/wjP3P0e71KIeGVuMbbgf+AKlIuyiX+Bf6RLEf/
         m8n0espIviTd52AlOFuiJlG4Cr84sZmL3bxmSmHoNOVIl+N85fooLUR5FXuEC7HN8wzb
         fsnIfzvhj1L2YeFdQPc+94wJvRak2+37gxvYSK39pgzoXqUx+cD3gZDjHxPdEFDqXYy9
         iCPx6R0NeamvWiD0Y0Dwq1kyTfwVu8aghTkctDTn9+99Nx3A/kta73WWN/i+YN4Ugyky
         UlG00YvesS8Vm05mIVxNQd/6YKpSTxpLeZfoMYo5ls6b7EP1rkXqMNkgRU9Uo9HHUF8t
         uGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=p63Qbk5vY9h9e/l1E12+/oRi01erw+ylPzxplkXhuyM=;
        b=Y3se915Jx+83D9PSRRFjDavPWtJWSqB9E9nzFvyYQWzm2u4BGObCBv2LxYOAaFa1E5
         tgTF/NFgV1xKJz57o7YajN30O1c2DTDbnZaiHK3XThg5CIwJjgT7RKFm/T4sSus6o8Pl
         aUFaTvFTTwK6QLoxos9zsqsxYOOKNp8bqmT4qydroYCQRseXoEajokx5c5gzZBuL3NGq
         i6758rGb/4ZWgJ/caK68QlCN9oZg6wSvYOOAI66aZI+4zkplP8uGEijPNgWmJjV7oahK
         T0ogP2shVzBZ9oBzaObuLBPVQY5RZfZAYpMox3hI2h9hgiQLiGqa2wNHjD+5GJ4pxDt0
         ABQg==
X-Gm-Message-State: APjAAAXjTph8XXZL+qbQi6T0m0zRJacqopfXQ/cN3Mr4MaciBrXkIFjp
        GhNEdKFRP4tJWLGM6HVdsWc=
X-Google-Smtp-Source: APXvYqzgLwrbnsLoOHYs4yJDGtroFmu+5Dtwy+bfXWJ2MUTmoKaFRYw04YgSQQZoYcAHD7aTNS68AQ==
X-Received: by 2002:a17:906:11d2:: with SMTP id o18mr5615104eja.123.1553848696380;
        Fri, 29 Mar 2019 01:38:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x52sm484455edb.8.2019.03.29.01.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:38:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at .git/objects/
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br> <20190322232237.13293-3-matheus.bernardino@usp.br> <20190328221049.GK32487@hank.intra.tgummerer.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190328221049.GK32487@hank.intra.tgummerer.com>
Date:   Fri, 29 Mar 2019 09:38:14 +0100
Message-ID: <87sgv69itl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 28 2019, Thomas Gummerer wrote:

> On 03/22, Matheus Tavares wrote:
>> There is currently an odd behaviour when locally clonning a repository
>> with symlinks at .git/objects: using --no-hardlinks all symlinks are
>> dereferenced but without it Git will try to hardlink the files with the
>> link() function, which has an OS-specific behaviour on symlinks. On OSX
>> and NetBSD, it creates a hardlink to the file pointed by the symlink
>> whilst on GNU/Linux, it creates a hardlink to the symlink itself.
>>
>> On Manjaro GNU/Linux:
>>     $ touch a
>>     $ ln -s a b
>>     $ link b c
>>     $ ls -li a b c
>>     155 [...] a
>>     156 [...] b -> a
>>     156 [...] c -> a
>>
>> But on NetBSD:
>>     $ ls -li a b c
>>     2609160 [...] a
>>     2609164 [...] b -> a
>>     2609160 [...] c
>>
>> It's not good to have the result of a local clone to be OS-dependent and
>> since the behaviour on GNU/Linux may result in broken symlinks, let's
>> re-implement it with linkat() instead of link() using a flag to always
>> follow symlinks and make the hardlink be to the pointed file. With this,
>> besides standardizing the behaviour, no broken symlinks will be
>> produced. Also, add tests for symlinked files at .git/objects/.
>>
>> Note: Git won't create symlinks at .git/objects itself, but it's better
>> to handle this case and be friendly with users who manually create them.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/clone.c            |  2 +-
>>  t/t5604-clone-reference.sh | 26 +++++++++++++++++++-------
>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 50bde99618..b76f33c635 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *sr=
c, struct strbuf *dest,
>>  		if (unlink(dest->buf) && errno !=3D ENOENT)
>>  			die_errno(_("failed to unlink '%s'"), dest->buf);
>>  		if (!option_no_hardlinks) {
>> -			if (!link(src->buf, dest->buf))
>> +			if (!linkat(AT_FDCWD, src->buf, AT_FDCWD, dest->buf, AT_SYMLINK_FOLL=
OW))
>
> This line is starting to get a bit long, might be worth breaking it up
> to keep to 80 characters per line.
>
> I notice that we are currently not using 'linkat()' anywhere else in
> our codebase.  It looks like it has been introduced in POSIX.1-2008,
> which sounds fairly recent by git's standards.  So I wonder if this is
> really supported on all platforms that git is being built on.
>
> I also wonder what would need to be done on Windows if we were to
> introduce this.  I see we define the 'link()' function in
> 'compat/mingw.c' for that currently, so I guess something similar
> would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> expertise.

For better of worse this particular quest started because I pointed out
(with some WIP patches) that for understanding this change we should
test whatever we did now, to ensure that the refactoring didn't have
unintended side-effects.

But that's a separate question from whether or not we want to keep the
current behavior.

I think the current behavior is clearly insane, so I think we should
change it with some follow-up patches. In particular options like
--dissociate should clearly (in my mind at least) have behavior similar
to "cp -L", and --local should hardlink to the *target* of the symlink,
if anything, at least for objects/{??,pack,info}

I think that changes the portability story with linkat(), since it's not
something we should be planning to keep, just an intermediate step so we
don't have a gigantic patch that both adds tests, refactors and changes
the behavior.

> While I agree with the goal of consistency accross all platforms here,
> I don't know if it's actually worth going through the pain of doing
> that, especially for somewhat of an edge case in local clones.

Note that we explicitly clone everything under objects/, including
recursively cloning unknown directories and their files.

So this is not just say about how we handle symlinks that we don't
expect now (nothing uses them), but if we want to make the promise that
nothing in objects/ will ever use symlinks. Or more specifically, that
if a new version of git starts using it that something doing local
clones might produce a broken copy of such a repo.

Maybe we'll still say "we don't care". Just saying it's a slightly
different question...

> If the test in the previous patch passes on all platforms, I'd be okay
> with just calling the behaviour here undefined, especially as git
> would never actually create symlinks in the .git/objects directory.

