Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1981F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965929AbeF0Sjr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:39:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40671 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965874AbeF0Sjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:39:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id l2-v6so2433514wro.7
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=22Yaif8DI5ays1Fv9rYcKbR7LOnkcDYs8x9EBQz5IEA=;
        b=G5hoogonKzGoBVjAGe6ZhabB0ajHXcAmUkqx3/Jk9OR7TgBeFS57MQ4kOUhT6R1GR/
         SMFtKXWN2dOl0XHWVS8kKB+W1g4jSTaqY+FNJDdLXqLBFDQRRs8xMXYP1BOYeN07L4FJ
         kceNum37ejy0hOQH79WpRgrGUYV4ahCGxw/3Tg94dIdL5ReDxQ5M3xEsS4fc3BwJjdrm
         shehupmoxPUIcS0FXw/QDYmQT1X5a3oHSJB0lFEEvdU2JrgzUMItYPWYyoOh1bna3Ffm
         pO+MIXk43pG1RjuLO1gs6HM3lx6xarpiNph02E9P4WtB/TJwXl2u7hlMIvYdmzKGr8tm
         O8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=22Yaif8DI5ays1Fv9rYcKbR7LOnkcDYs8x9EBQz5IEA=;
        b=bUQyJ3E+1j0R99HUtAXm7YESeTebaKcNrpwF3y1op65FCZjv47pxZxw8w+EPNhFQ2C
         nNroVVmze1o3wmj1szDRvCXivLe0TKRUHX5KGT9550LHj4wav1BY3L0YoMj1DVZPU+yf
         6LZMfbZbfLFt70t3ViTsrwu0qmu3YTZQgxS97Ggk62pc6m4OJmsH6o8kbgD+CwCVIryP
         uPZ87UXKUwzk8eIzwLuuVqCrirWqENNseXGqLLCB4lCNBrRcTB9EP5tkRnfFO5NhsUjs
         TCGROgbS75B+QmRsaFyLXB2AwPfYxiKEdGZvsPpvQE9fQQC9yEF4vqpnFXJz7Msl2O2W
         j9Ug==
X-Gm-Message-State: APt69E3ZkktAM1hR8z2GzpQy6aftNeNsx/BgtYfaI8lI/Lz9ErApC0FX
        9yPNVTRBPYaCiQzx9vX7SJk=
X-Google-Smtp-Source: AAOMgpcDwfm/SEXfnkuZziMpHubCh2RrMCtXC+1PXnbMKkq+iZQIgGsKGA9LVrvGWAE4rDUsmnJNRg==
X-Received: by 2002:adf:ab95:: with SMTP id s21-v6mr6403538wrc.90.1530124785465;
        Wed, 27 Jun 2018 11:39:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 203-v6sm9102513wmp.23.2018.06.27.11.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:39:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, joel@teichroeb.net
Subject: Re: [PATCH v6 3/4] stash: convert branch to builtin
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
        <ac0a24da8a583a137176d1d215df65bb1a3ada0e.1529943789.git.ungureanupaulsebastian@gmail.com>
        <nycvar.QRO.7.76.6.1806270018580.21419@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Jun 2018 11:39:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806270018580.21419@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 27 Jun 2018 00:23:53 +0200
        (DST)")
Message-ID: <xmqqfu18f4zz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	ret = cmd_checkout(args.argc, args.argv, prefix);
>
> I guess it is okay to run that, but the cmd_() functions are not *really*
> meant to be called this way... Personally, I would be more comfortable
> with a `run_command()` here, i.e. with a spawned process, until the time
> when checkout.c/checkout.h have learned enough API for a direct call.

Thanks for pointing it out.  I'll add a bit more for those who are
reading from sideline (iow, if you are Dscho, you do not have to
read the remainder, as I know Dscho knows all of this).

It is not OK to use cmd_$foo() as subroutine; depending on the value
of $foo, where the call is made and the number of times the call is
made, it may happen to work OK in the current code, but that is a
ticking timebomb waiting to go off.

This is primarily because cmd_$foo() is designed to be replacement
of "main()" in usual programs---it is allowed to assume the global
variables it uses have their initial values and nobody cares the
state it leaves behind when it returns.  Argument parser may flip
bits in file-scope static variables to record which options are
seen, assuming that these variables are initialized to all-zero, and
that assumption would not hold for the second call to cmd_$foo(),
etc.  cmd_$foo() also is allowed to call die() when there is an
unrecoverable error condition in the context of carrying out $foo; a
scripted Porcelain that used $foo as a building block to implement a
larger operation (e.g. "stash" that used "checkout" to switch to a
different branch) may want to react to the failure and do something
extra (i.e. "git checkout || do something more").  

Using run_command() interface would not cause any of these problems;
the subcommand will run in a clean environment, and the caller can
react to its failure.
