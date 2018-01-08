Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A0F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeAHUAQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:00:16 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38087 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeAHUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:00:15 -0500
Received: by mail-wr0-f176.google.com with SMTP id 60so2926889wrl.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rwnQd0iLPWpkO5YQ0duaUHpPpI7gVQ0F4Nei6dHnj9s=;
        b=eURAJI18HZbSyQy6FrMTk0OtE6KRvGXCHQdWZ+zdlScUnmb+oFRN3u3vRbTCFlPFII
         6ZE0ZPGPos9SOt1GygBF2lYWPMECFN3ZhRpaEFpTRW4Yps3sROVD1Yw22dMFzcrj1JOm
         p+ViNH6azbjyKx2HROQULnOE0OYD2ccZ1uqQJr4n3b+iNnQTODjyp2J9O1EH9Z+OjXaH
         TQSKxgb+Uu1Aj/oQYUltQHP/fdJPG1WsfEQ3/HJodpt+jgiq/MRMRbt5oWPLYats0ZYO
         BTuIBhZqQtdNsJZ46G0dfLZJun6syoBs5L4szMFVasIbCkoxr+D2rKhdF/gZC0u22r8M
         2kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rwnQd0iLPWpkO5YQ0duaUHpPpI7gVQ0F4Nei6dHnj9s=;
        b=NOUGEaOsKPQtMq82PHZBgP6fqQX89oBagXd/M91znhNBXU6epfHQ8oYkDLWEl4UJPN
         EIcFlocahUxW6jI4nzptX9D+oI8tHOVRI5jKAavWgmhH30WqjXcBvMud+aHXodJa9/ax
         CLIz1cSr04aTg8POjEa1KW7lyf+O6TpBkoyWZ0XadBxZ0J2yatIR3m0YICycL/PjAZ6N
         2fqIbU3NpilrGzd62V7iMzrs5l/BnT7LUERuOaN5byghtx7uCtpNrScxdYCT39LhVXhi
         gyh6aQndMKKhPGedSAlpkNB0IFlMkalJUFC1dpa099cSK5RfIWEtbNdPRCb3dbWxZS1I
         HvFw==
X-Gm-Message-State: AKGB3mK22GXMXsUoIC+hKTp9c8loVlBS2mx1N3S2yb2FXV8UYMtH0jbW
        yCcJBwHc4NlzH4oVYjWiiWo=
X-Google-Smtp-Source: ACJfBouwnTMCDcIsZbEH9L8mKhRLdUWgxq5c8OPlVVeoZjtjOxm+vmYJuIBM1PV3zGh/NVBA4f/ouQ==
X-Received: by 10.223.155.141 with SMTP id d13mr11902314wrc.174.1515441614228;
        Mon, 08 Jan 2018 12:00:14 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o16sm13576211wmi.29.2018.01.08.12.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 12:00:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
References: <87inccbscj.fsf@evledraar.gmail.com> <20180108191812.52565-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180108191812.52565-1-dnj@google.com>
Date:   Mon, 08 Jan 2018 21:00:10 +0100
Message-ID: <878td8azp1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 08 2018, Dan Jacques jotted:

> On Mon, 08 Jan 2018, Ævar Arnfjörð Bjarmason replied:
>>>+# it. This is intentionally separate from RUNTIME_PREFIX so that notably Windows
>>>+# can hard-code Perl library paths while still enabling RUNTIME_PREFIX
>>>+# resolution.
>>
>> Maybe we covered this in previous submissions, but refresh my memory,
>> why is the *_PERL define still needed? Reading this explanation doesn't
>> make sense to me, but I'm probably missing something.
>>
>> If we have a system where we have some perl library paths on the system
>> we want to use, then they'll still be in @INC after our 'use lib'-ing,
>> so we'll find libraries there.
>>
>> The only reason I can think of for doing this for C and not for Perl
>> would be if you for some reason want to have a git in /tmp/git but then
>> use a different version of the Git.pm from some system install, but I
>> can't imagine why.
>
> The reason is entirely due to the way Git-for-Windows is structured. In
> Git-for-Windows, Git binaries are run directly from Windows, meaning that
> they require RUNTIME_PREFIX resolution. However, Perl scripts are run from
> a MinGW universe, within which filesystem paths are fixed. Therefore,
> Windows Perl scripts don't require a runtime prefix resolution.
>
> This makes sense because they are clearly functional right now without this
> patch enabled :) However, we don't have the luxury of running Perl in a
> separate universe on other OSes, so this patch is necessary for them.
>
> I created a separate option because I wanted to ensure that I don't change
> anything fundamental in Windows, which currently relies on runtime prefix
> resoultion. On all other operating systems, Perl and binary runtime prefix
> resolution is disabled by default, so if this patch set does end up having
> bugs or edge cases in the Perl runtime prefix code, it won't inpact anybody's
> current builds.
>
> I can foresee a future where Windows maintainers decide that
> PERL_RUNTIME_PREFIX is fine for Windows and merge the two options; however,
> I didn't want to force that decision in the initial implementation.

Makes sense, well not really, But that's not your fault, but Windows's.

I do think you're being overly conservative here, the perl change is no
more invasive than the C changes (less so actually), and from anyone
who's not on Windows it makes sense to be able to enable this with just
RUNTIME_PREFIX=YesPlease, and have NO_RUNTIME_PREFIX_PERL=NotNeededHere
for Windows, if someone ends up needing it.

We usually hide stuff you might want in general, but isn't needed on one
special snowflake platform behind NO_*, not the other way around.

Maybe others disagre... 

>> > +	# GIT_EXEC_PATH is supplied by `git` or the test suite. Otherwise, resolve
>> > +	# against the runtime path of this script.
>> > +	require FindBin;
>> > +	require File::Spec;
>> > +	(my $prefix = $ENV{GIT_EXEC_PATH} || $FindBin::Bin) =~ s=${gitexecdir_relative}$==;
>>
>> So why are we falling back on $FindBin::Bin? Just so you can do
>> e.g. /tmp/git2/libexec/git-core/git-svn like you can do
>> /tmp/git2/libexec/git-core/git-status, i.e. will this never be false if
>> invoked via "git"?
>>
>> I don't mind it, just wondering if I'm missing something and we need to
>> use the fallback path in some "normal" codepath.
>
> Yep, exactly. The ability to directly invoke Perl scripts is currently
> functional in non-runtime-prefix builds, so enabling it in runtime-prefix
> builds seemed appropriate. I have found this useful for testing.
>
> However, since GIT_EXEC_PATH is probably going to be the common path,
> I'll scoop the FindBin code (including the "require" statement) into a
> conditional in v6 and use it only when GIT_EXEC_PATH is empty.

Both make sense.

>> > +	return File::Spec->catdir($prefix, $relpath);
>>
>> I think you initially got some version of this from me (or not), so this
>> is probably my fault, but reading this again I think this would be
>> better as just:
>>
>>     return $prefix . '@@PATHSEP@@' . $relpath;
>>
>> I.e. right after this we split on @@PATHSEP@@, and that clearly works
>> (as opposed to using File::Spec->splitpath) since we've used it
>> forever.
>>
>> Better just to use the same idiom on both ends to not leave the reader
>> wondering why we can split paths one way, but need to join them another
>> way.
>
> PATHSEP is the path separator (":"), as opposed to the filesystem separator
> ("/"). We split on PATHSEP below b/c we need to "use lib" as an array, but
> it may be a ":"-delimited string.

Yes, silly me. Nevermind.
