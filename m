Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65DC41F453
	for <e@80x24.org>; Sat,  3 Nov 2018 01:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeKCK1R (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 06:27:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeKCK1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 06:27:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2-v6so3388433wmb.0
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=16E8uvj17wXIXrFuoF/PHvWmqine5Lv1fGnX9RUwmVU=;
        b=C4TbwFjgrOx03Ffumuh9wWeonGesAduopTFUJUuYnDBniI0NZ9ZJidmkKBxTFGnwgb
         oCjpxLuVnkdVBi1AwEvVrNYJfztGZBlYQSY6ehDkVUqHeVNn/7vU9NKWEyHlSXFphw/A
         99vpLF3CzGIIwreRh6s5maBJNjxLUrg6Yp1x4rwwYrFAvmVMn3tkACgQO+ysRvgI2ASJ
         /6nQeRN0nZHAa+ttF7cUxvVu4Eez6S/7/bpKHheUCWUhNo4Ja3W6saODu/bbOjHw27bR
         yz+q68T6Gr0cFe3kHFUaXS1DM8OHLCN0Ir+sxe4yZJXZV3X1KC0cq0qkQrZZRpXbOxIw
         3qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=16E8uvj17wXIXrFuoF/PHvWmqine5Lv1fGnX9RUwmVU=;
        b=Nt0NFhj/tSBlFb23JhamiwwYpM2/IRANnBFQX9f/RadKhI6PR6pXPGUK1dLObZ6VV0
         +7yTZmuWC0L9rnR+iJATiXs9s1jfiv6QHsVl8mwbNNhNGAsN4cW39DNLldM0FgLC4HUq
         hAUC0wb2HshPY15uFzRfUNUJxbCWVhxpUIHFpXNAtELErCgS84FrAwLBYuZS4af4kCQd
         quas3JLDokc4gVI3urP6PAydWYroHhf6xGbfKV4Iiu1JCuwoymiwkEQPxhVE1X5ioNyV
         8QjIpAZEd+C2/vHI0p5ndUCPFrTMOSQ83OdP6K1MHJ+/oz1sBGUIKsOT7M7Xze3NMyVp
         L35g==
X-Gm-Message-State: AGRZ1gLZ6GG5uM377SNkRAXr4zapSxYcO0a32fDseQLrbDDdR4H0FVEy
        ZJSGdB+QYTvrpiqeXxqSGyM=
X-Google-Smtp-Source: AJdET5fZdhhpD3URJznvcj72kvCJCfJiY6bjpcztsB0kf0u0jquUVYwxVdZXBj7Mvanibo+gbPGdUg==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr149373wmd.63.1541207866123;
        Fri, 02 Nov 2018 18:17:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v25-v6sm4770374wmh.16.2018.11.02.18.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 18:17:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
References: <87efkkdwcv.fsf@evledraar.gmail.com>
        <20181102223743.4331-1-avarab@gmail.com>
Date:   Sat, 03 Nov 2018 10:17:41 +0900
In-Reply-To: <20181102223743.4331-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 2 Nov 2018 22:37:38 +0000")
Message-ID: <xmqq4lcznemi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Although I'm on the fence with the approach in 1/5. Should this be a
> giant getopt switch statement like that in a helper script?
>
> An alternative would be to write out a shell file similar to
> GIT-BUILD-OPTIONS and source that from this thing. I don't know,
> what do you all think?

Not really.  Why do we iterate over these in a shell loop, rather
than having make to figure them out, just like we do when we "loop
over the source files and turn them into object files" without using
a shell loop?  What's so special about enumerating the installation
targets and iterating over the enumeration to perform an action on
each of them?  I think that is the first question we should be
asking before patch 1/5, which already assumes that it has been
decided that it must be done with a shell loop.

	I think "first install 'git' itself, and then make these
	other things derived from it" should let $(MAKE) install
	things in parallel just like it can naturally do many things
	in parallel, and the dependency rule to do so should not be
	so bad, I suspect.

This is a tangent, but I have long been wishing that somebody would
notice that output during install and (dist)clean without V=1 is so
different from the normal targets and do something about it, and
hoped that that somebody finally turned out to be you doing so in
this series X-<.

> I'd like to say it's ready, but I've spotted some fallout:

I still have not recovered from the trauma I suffered post 1.6.0
era, so I would rather *not* engage in a long discussion like this
one (it is a long thread; reserve a solid hour to read it through if
you are interested),

https://public-inbox.org/git/alpine.LFD.1.10.0808261435470.3363@nehalem.linux-foundation.org/

which would be needed to defend the choice, if we decide to omit
installing the git-foo on disk in a released version.

I personally have no objection to offer a knob that can e used to
force installation of symlinks without falling back to other
methods.  I think it would be ideal to do so without special casing
symbolic links---rather, it would be ideal if it were a single knob
INSTALL_GIT_FOO_METHOD=(symlinks|hardlinks|copies) that says "I want
them to be installed as (symlinks|hardlinks|copies), no fallbacks".

> Ævar Arnfjörð Bjarmason (5):
>   Makefile: move long inline shell loops in "install" into helper
>   Makefile: conform some of the code to our coding standards
>   Makefile: stop hiding failures during "install"
>   Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
>   Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES flag
>
>  Makefile         |  65 +++++++++++--------------
>  install_programs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 38 deletions(-)
>  create mode 100755 install_programs
