Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FABA1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 10:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeCNKS5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 06:18:57 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:56278 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeCNKS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 06:18:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id q83so2952243wme.5
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=O45MxcSSDsFhVFqbrHrLfpAK7V73xGoy45KlBdIGZmg=;
        b=dkAod09SQyTZ+UIHx7NWPHbssI9saoNAIT0Ah3ziLXlljRhWYSDDdigmrV+VHfNdRB
         d4BLBz1/JsuG7GfdVyzaUtNQqyuaIwN9g7uTUK6i7qgIgcS1AhHQ+PZoWEb7hzj9nMuU
         WlQIWCQeFOugheuShPXinI7UGd6GvWBehbHw+LWdNgcl3n21AJ9Qep6BvzT4hFnHhvGj
         CWX6fZOLV2nD8v/47Ar1LDCqVw7inpxBwfdvRCmzwa1fokz8iLXyeh5WIa9y/gvm/RTR
         nENO2I1vMpkuwPJwtOcn50K4SvHcfMiFtFaVXVrp79I4n4+hjIajPbGD5rgh2E/txS+r
         Zigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=O45MxcSSDsFhVFqbrHrLfpAK7V73xGoy45KlBdIGZmg=;
        b=tbiawMMkKg6cMpY69HSoLXREU6Aa601fAyi7w1PHjcKx5iAzJThzEuNb4f8CRN4NN1
         H+BKDGe9p/6bqiZOYTsg61kd1ROxSeWtMrFTqeToHPK5e2qQTzM9nkvzH3zVbQ9ha5/g
         hxkRksNyOnGgwmidSmfX5kgQACAUpm8F+U/n9hW9p1Elr5Y+A1j3plow3uANjgs3CCUu
         lbR0HbrbKDer/teW/iOobwTyCY6txtH9SSYBGoFPRNiL0ummedyzsZvUk1Pckb2IkWgA
         XVEHlexLZmWuZovcKz6xh7f6BpLdcz63yq8F9nLBBoQcQVDiv8uJfl2GwYnqh5IwEkAM
         yjdA==
X-Gm-Message-State: AElRT7E+q5urQ2oUiXC5u6zA39qVG3aFsNMr9HH9KioguMgZEZsp37vm
        yzSvB3COuVtxNpBh8mVI4FRCgCDL
X-Google-Smtp-Source: AG47ELsC6bwTkMTjgE3/L3lqQQdG0jPPd/RRXKDZTiP/Hpe+nnGLaQANJxl+MryDpVl6aI7JZXkJBg==
X-Received: by 10.80.183.211 with SMTP id i19mr4107718ede.183.1521022735692;
        Wed, 14 Mar 2018 03:18:55 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c9sm1929560edl.23.2018.03.14.03.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 03:18:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sguorb5.fsf@evledraar.gmail.com> <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com> <87y3iwp2z0.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <87y3iwp2z0.fsf@evledraar.gmail.com>
Date:   Wed, 14 Mar 2018 11:18:53 +0100
Message-ID: <87woyfdkoi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Ævar Arnfjörð Bjarmason jotted:

> On Thu, Mar 08 2018, Daniel Jacques jotted:
>
>>> It would be great to have this rebooted now that my perl cleanup efforts
>>> have un-blocked this. Will be happy to help review & test the next
>>> iteration.
>>
>> Yes, I was just thinking the same thing. I wanted to make sure the Perl
>> changes had landed, and I'm pleased to see that they have. I should have
>> time in the next few days to rebase and put up a new version of the patch
>> series. I'll keep you in the loop, and thanks for pinging!
>
> Related to this, I came across this bug report
> https://gitlab.com/gitlab-org/omnibus-gitlab/issues/3265 which is
> wondering why we're installing N copies of the git binary, presumably
> they're building with NO_INSTALL_HARDLINKS.
>
> Just doing this:
>
>     diff --git a/Makefile b/Makefile
>     index de4b8f0c02..2222319a4f 100644
>     --- a/Makefile
>     +++ b/Makefile
>     @@ -2596,7 +2596,7 @@ endif
>               for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
>                     $(RM) "$$execdir/$$p" && \
>                     test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
>     -               ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
>     +               ln -s "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
>                     cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
>               done; \
>             } && \
>
> Seems to work for me, although obviously this would need to be optional,
> and it'll get in the way of Daniel's patch since it use the absolute
> path.
>
> But is there any reason anyone can think of for why we shouldn't be
> figuring out the relative path and symlinking the two?

Also, as another follow-up question. we have stuff like "git-add" in the
libexec/ directory, but when you run "git add" the bin/git binary just
handles that internally, it's not dispatching to libexec/git-add.

Is the only reason we're still installing these binaries like git-add in
libexec for compatibility with some old installation where that was
added to the $PATH, shouldn't we (and I can write this patch) also have
a toggle for "I want the modern install method" which would not install
any of these binaries like git-add at all?

Then the libexec/ dir would only contain things that we really do need
the bin/git to dispatch to, like git-svn, git-bisect etc.
