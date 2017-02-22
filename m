Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792F4201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbdBVTOU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 14:14:20 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35835 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbdBVTLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 14:11:14 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so147321308ith.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v8kT79JMW4YIJiku+hCevV+hNa+IGRu7arpPKwHTfKo=;
        b=el5rOUmz9Covndai5jUtYnKakSP/T6eD6QNBZARoYCN8umWsIoyYHEJxtIohFpxnVO
         ILNZxgw0IwOswgFqSLFNL/r5i0X8VMWvaOsZ/NKc+LKTqYW7wm7WkEaUO411zA5Qgt5+
         xQoOUUYkz9jTj+8zqOdB2xSgqpYdksN7HHa15e2FoHh1pF3rbQiHPuf3kTdTqgatqzVO
         gCN64A+W6Js+Z9u+NdMhTyyafDDuCGhdJ9oWvDmxuKwFaQfzVjPKGgGWqID25WyTnKib
         fYlHEV8abFTENUyIUHiOioXAWYijR6+awKQQQ5Xthqb1ln9n3Grk42qArJpKhFYJSWAk
         mdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v8kT79JMW4YIJiku+hCevV+hNa+IGRu7arpPKwHTfKo=;
        b=IItDMpPdamOvQqbxC307X16oMDgj3vKYMpEBTnY8AekVocq7ZonLed7yM1bDuADktm
         Xe/E8xk2j6JDEIdELpC9Ng27ww1pAsbmfOcIrx5oln1U/Om+adLN0vVxM3ap+9Pp71XC
         Ia0PDoUgsuXWKRQhCoVVxMRKChWjfSQ5g5Lxh1xLYydHgAGcyu7cL4F/QdagtL+JFuxE
         tDlU23BcFzRIxcenPK1J0M97WSCiWFIEXtW4bWZT/XCXmVb/sZ+ESFvoM/zFioDLnZ7h
         UNogO3SrTXYIb8ISIG0j8Lh6i2W0n2nbbyjWVShr9khZLPE6z5xgWmmSM9Y/ldRDegwa
         P31Q==
X-Gm-Message-State: AMke39kjDiGY/6JVnL8x0wwSfgssIUUofz0Kys5Y8CpZ4GzRs62qFQwE6NXE1xphG4zPWAbeiGTLa3/BXs9DFGBE
X-Received: by 10.107.47.162 with SMTP id v34mr20989429iov.52.1487790673215;
 Wed, 22 Feb 2017 11:11:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 22 Feb 2017 11:11:12 -0800 (PST)
In-Reply-To: <20170222185711.2kpzeypptg6deytc@sigill.intra.peff.net>
References: <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net> <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net> <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
 <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com> <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
 <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com> <E1cgXSe-0007jp-QI@mylo.jdl.com>
 <xmqqh93mcelv.fsf@gitster.mtv.corp.google.com> <20170222185711.2kpzeypptg6deytc@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Feb 2017 11:11:12 -0800
Message-ID: <CAGZ79kYrYtxGyEji0BRoPjBhZK25vvOT5JaS_jhj1_vAre17Yw@mail.gmail.com>
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jon Loeliger <jdl@jdl.com>,
        Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 10:57 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 22, 2017 at 09:36:12AM -0800, Junio C Hamano wrote:
>
>> >> My gut feeling is that we should do the selective/filtered include
>> >> Peff mentioned when a repository is known to be used as a submodule
>> >> of somebody else.
>> >
>> > Does the management of these submodue-related config values
>> > become easier if, instead of placing them in .config, we
>> > place them in a git/.context file?
>>
>> Do you mean that Git users that use submodules adopt a convention
>> where a separate file in $GIT_DIR of the toplevel superproject holds
>> pieces of configuration that are meant to be shared between the
>> superproject and across all its submodules, and the $GIT_DIR/config
>> file in submodules and the superproject all include that shared one
>> via include.path mechanism?
>>
>> That may allow us to do without being responsible for sifting of
>> configuration variables into safe and unsafe bins.
>>
>> I dunno.
>
> Hmm. I certainly like that we punt on having to decide on the "should
> this be shared with submodules" decision. That makes the end result more
> flexible, and we don't have to get into a never-ending stream of
> "whitelist this config option" patches.
>
> My only concern is that it's not as discoverable. In the situation that
> kicked off this thread, somebody put url.X.insteadOf into their
> super-project .git/config, expecting it to work in the submodules. That
> _still_ wouldn't work with this proposal. They'd have to:
>
>   1. Put it in .git/context (or whatever we call it)
>
>   2. Maybe add include.path=context in .git/config if they want the
>      config shared with the super-project (or this could be automatic?)
>
> I guess it gives _a_ solution, which is more than we have now, but it
> doesn't feel very ergonomic.

Well, currently ".git/config" is the one and only blessed way to configure
a single repo and our documentation and user expectations reflect that.
Once git-worktree takes off (which has per working tree configuration files)
it doesn't feel as obscure anymore to have multiple config files.

The working trees will share the $GIT_COMMON_DIR/config file for
all working trees and have its own config file at $GIT_DIR/config.worktree
in its respective git directories. C.f.
https://public-inbox.org/git/20170110112524.12870-2-pclouds@gmail.com/

So I could imagine that we just introduce another config file
config.submodules which is source'd by the submodules.
Then the hard part becomes to decide which config value to put
in which config file. (We'd still be left to guess where to put some initial
new configuration value. config or config.submodules. Any update of a
value can just stay in its respective file. And I don't think we'd want
to invent a config option that tells us which policy we use where to
put config options. That sounds just scary.)
