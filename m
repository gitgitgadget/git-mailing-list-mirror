Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5DE1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 11:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeKEUzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 15:55:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34486 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeKEUzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 15:55:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so7203708eds.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=d1R7l3YJ0qjfyqlI4WV7xffLVZrLB+q8nyFKWycy7xE=;
        b=EvLLR7G4PmScFOKBiQ4NveeRbGKAgYqWvNymseaOCwGX25nSRFt14XDhSq8XsDcx+G
         1hDLzTQWPcsQkMttAcbWkR/89lE7h7P44+78d87PNVMJ9xvprWPiWk4QWotkaQJiWurS
         d+YS7Ek8hLKMnMc+un+AHUTh3DjMNyP53oPFOCtitqXJ+Ls6d8QrCDIlzcCegC5a7RuJ
         scHr/vvc95GgdZl87xIvDoOiaDRopoFmEMG4qPZWUlhs0IHLjr63WNMH7cKqQMbZuUI1
         f7nTB2x0VwmZ+blAvqgl1Y4B/GeDpJj9ocrlHzn671zPYpiqPebxdbZMlouLTY95crdD
         MvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=d1R7l3YJ0qjfyqlI4WV7xffLVZrLB+q8nyFKWycy7xE=;
        b=r0RBuqjBc/NinKvNgjx7BljwlXS+hocE/hgSpm2LgJyQFg4SvM2Fdwj3hKUsDoLUlX
         Uhqu5Xuoy3owvIciLxcrHuQKy6/RnDSzwmVFBfzdFfajLIkRsgvLTzQl8GuG8zY4rgP1
         T9j3532pCb/5N3HLVLvtMFemKoYgtFyRo2P0EgSMAWByxGWdVEdD0mV5ETQt03xTElHi
         CcQng1cvWa5lINWa2U63R5g6BOrvU7h6vEicgnoNUDUpLuK1eY+C3EBVy1CupkKELEbz
         Dvjoo95ZhcUvwEZnXIYXhEVYrVfzGH+aLNN6pOg4EZvzbeRZHsiexEz56WTe32mWL9bE
         ahfA==
X-Gm-Message-State: AGRZ1gLDGlrGqhby1uTbo9A0hREJq5qS0W20QDbIo3q/UuLzeJsbRA77
        tT7yalkX+UuIZ4PUpy2G7Zs=
X-Google-Smtp-Source: AJdET5fxHaet9nqKkEhbTdutw2blIYkzpKXhrFm5AHeZl3znxAI9Hp1NMDymHuppXidPg9pLnPk8AA==
X-Received: by 2002:a17:906:eca:: with SMTP id u10-v6mr13926929eji.54.1541417763653;
        Mon, 05 Nov 2018 03:36:03 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b18-v6sm7077001eju.38.2018.11.05.03.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 03:36:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com> <xmqq4lcznemi.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq4lcznemi.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Nov 2018 12:36:01 +0100
Message-ID: <87in1b7o4e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 03 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Although I'm on the fence with the approach in 1/5. Should this be a
>> giant getopt switch statement like that in a helper script?
>>
>> An alternative would be to write out a shell file similar to
>> GIT-BUILD-OPTIONS and source that from this thing. I don't know,
>> what do you all think?
>
> Not really.  Why do we iterate over these in a shell loop, rather
> than having make to figure them out, just like we do when we "loop
> over the source files and turn them into object files" without using
> a shell loop?  What's so special about enumerating the installation
> targets and iterating over the enumeration to perform an action on
> each of them?  I think that is the first question we should be
> asking before patch 1/5, which already assumes that it has been
> decided that it must be done with a shell loop.
>
> 	I think "first install 'git' itself, and then make these
> 	other things derived from it" should let $(MAKE) install
> 	things in parallel just like it can naturally do many things
> 	in parallel, and the dependency rule to do so should not be
> 	so bad, I suspect.
>
> This is a tangent, but I have long been wishing that somebody would
> notice that output during install and (dist)clean without V=1 is so
> different from the normal targets and do something about it, and
> hoped that that somebody finally turned out to be you doing so in
> this series X-<.

I'm all for this, but don't have enough Make skills to make it
happen. Can you or someone else post a WIP patch showing how to do this?

What would the targets look like? Something that's a build target for
the target file in the installation directory, so e.g. if you ran "all
install" and had modified just one file (and no recursive rebuilds)
you'd install just that one file?

Early on in the "install" target we install many of these programs, and
then some of these for-loops re-install on top of them. Actually now
that I think of this this is one of the reasons for the 2>/dev/null
probably, i.e. run "install" twice and you don't want to get errors.

Anyway, regardless of how the for-loop looks like (shell or
make-powered) I split this up because it was getting really hard to
maintain the *inner* part of those loops. I.e. needing to specially
quote everything, end lines with \ etc.

But reading on...

>> I'd like to say it's ready, but I've spotted some fallout:
>
> I still have not recovered from the trauma I suffered post 1.6.0
> era, so I would rather *not* engage in a long discussion like this
> one (it is a long thread; reserve a solid hour to read it through if
> you are interested),
>
> https://public-inbox.org/git/alpine.LFD.1.10.0808261435470.3363@nehalem.linux-foundation.org/
>
> which would be needed to defend the choice, if we decide to omit
> installing the git-foo on disk in a released version.

Thanks. I'll read that later.

> I personally have no objection to offer a knob that can e used to
> force installation of symlinks without falling back to other
> methods.  I think it would be ideal to do so without special casing
> symbolic links---rather, it would be ideal if it were a single knob
> INSTALL_GIT_FOO_METHOD=(symlinks|hardlinks|copies) that says "I want
> them to be installed as (symlinks|hardlinks|copies), no fallbacks".

... If you're happy to accept a patch that rips out this whole
conditional fallback logic and just makes it an if/elsif/elsif for
symlink/hardlink/copy this makes things a lot easier.

>> Ævar Arnfjörð Bjarmason (5):
>>   Makefile: move long inline shell loops in "install" into helper
>>   Makefile: conform some of the code to our coding standards
>>   Makefile: stop hiding failures during "install"
>>   Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
>>   Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES flag
>>
>>  Makefile         |  65 +++++++++++--------------
>>  install_programs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 151 insertions(+), 38 deletions(-)
>>  create mode 100755 install_programs
