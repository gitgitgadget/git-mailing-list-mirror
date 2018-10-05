Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507221F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeJFCSD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:18:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45222 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJFCSD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:18:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so11494464edq.12
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjdfGXTuGr6RREVwTEbbuH7EmjUZxr982j74o8hBlq8=;
        b=EwrR9DoxSLFRYxVDaejJMIhWWp56bblHbh05CAifE92N3Dsh/pH+N8fzoHbAZGfStA
         022lmZd+49EsFZYhrniIcP9E0lhrnm4vTsR0izCEL5b3cNKOX3s3yINoZL7XbuIkpALl
         uw0lAM9/8AYRypCknWdqxSF8+gJa1aDDO5TAQOhtUho4su7nDvPETPtoB0WWLgJXgcrP
         gUQk5iKYbNg6qkTKlVVln6ddM8QJbvDrMcky4bB4MwGXLDtAwVsAz++JsHh8Q8cBR6sU
         O5QNRhti1QqpNQZkfjS4vnLGP/Rl2UZgP+Zmf2RhPFm6gecxn0lo1kD5EQAnYukt6qb4
         Yoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjdfGXTuGr6RREVwTEbbuH7EmjUZxr982j74o8hBlq8=;
        b=WyokcmhzzQQakFFcBI53tEx2uBLm5RGqKBGSbTOF2zSAsVA67FANoO+pDdV8fseSV6
         qbdXokjA1GUYqTVgLP6Hl3ye+aIBew0cp+caEUOpJIgM1HNMOSOEccuDUFh374m9MpnC
         fm613dycSurRb5GtgYLx1y75WFrM1ksunjTniMpmOCHyKILz2R+jLyMvKm+OD1Uy9lJR
         s81EG2Qwhqoz3fl9eFOEQbKJg7EUkB8U9FJf4uwyXbhho1EKJmiz6nkKD3rPcZzU3l0N
         qTzDSg52oebR4umrI6QPaRrnSt3/sJnpZJVrBtx11gsgzBFtUpMqjd/jNGo1eyNrfZrW
         2DgQ==
X-Gm-Message-State: ABuFfoiPmoyfXjq93gRiv/v87ZCfwnPhM2pIAxljDtv11Y0vZII4V+uy
        zwOckK4BoZNBK+UW8R9ElRLwtkJ2hxLBAn0z+TZC2xgmAVH8TQ==
X-Google-Smtp-Source: ACcGV625VA24nkZgT3jtXjkva3ibP9iilNoy1VSv3Y9yQpQTx/9/Jb8Igl9uKhJubdDBjZXcRsPyNv7X/kmQcUh9SMw=
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr16103556eda.154.1538767073651;
 Fri, 05 Oct 2018 12:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180929140132.GA31238@msg.df7cb.de> <20180929145527.23444-1-avarab@gmail.com>
 <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
 <xmqqftxkztzb.fsf@gitster-ct.c.googlers.com> <20181005130516.3qnhtjg7js53iomf@shiar.net>
In-Reply-To: <20181005130516.3qnhtjg7js53iomf@shiar.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 Oct 2018 12:17:42 -0700
Message-ID: <CAGZ79kbQMg0sQbwhnjV1eO-LmRifJs1jzAkZmHT0+OS4RxRJwA@mail.gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
To:     git@shiar.nl
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, myon@debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 5, 2018 at 6:05 AM Mischa POSLAWSKY <git@shiar.nl> wrote:
>
> Junio C Hamano wrote 2018-10-05 1:19 (-0700):
> > Stefan Beller <sbeller@google.com> writes:
> >
> > > git-grep is always file/tree recursive, but there is --recurse-submodules
> > > which is off by default. Instead of providing a short alias to a noop,
> > > we could use -r for submodules. (And if you happen to have no
> > > submodules, this is a noop for you)
> >
> > I am not sure if it is an overall win for those who do have and use
> > submodules to easily be able to go recursive with a short-and-sweet
> > 'r', or even they want to work inside one project at a time most of
> > the time.  If the latter, then using 'r' for recurse-submodules is
> > going to be a mistake (besides, other commands that have 'recursive'
> > typically use 'r' for its shorthand,and 'r' does not stand for
> > 'recurse-submodules' for them).
>
> Personally I would welcome a shorthand for --recurse-submodules,
> especially if --r^I no longer completes to this.

The new switch differs by one dash, so I'd think the double dashed
version would still autocomplete.

Unrelated to this, but more to submodules:
There is submodule.recurse which you may want to set.
Would you be interested in a more specific config option there?
(i.e. grep.recurseSubmodules to only apply to grep recursing into
submodules, just like fetch.recurseSubmodules only applies to fetch)

> It is also closer to the behaviour provided by grep -r as that recurses
> into submodules as well.

That sort of makes for the grep case, but not for other commands.
See the related discussion at
https://public-inbox.org/git/20180907064026.GB172953@aiede.svl.corp.google.com/
