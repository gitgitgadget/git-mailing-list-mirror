Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8721FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935698AbeCHJWL (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 04:22:11 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37433 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935629AbeCHJWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 04:22:10 -0500
Received: by mail-wm0-f46.google.com with SMTP id 139so9725256wmn.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TE+x56N/V0MkG6sYTCk7FXaMmY/BpxvCfhtLCRl1Gyc=;
        b=Ru8eHhRC/vEOGoijamz5KFAA8P5rTfuKF1vcW/vdLYH+5aWXzaFeLs6MOvsTUy2HuM
         WCq1smicUjan9/JZKY4UetCFyobubrqE6lgLo3gZrWX5KKdfJtIQwiSbCVkdO5BnIdq/
         MT81wSwAR9jm3lhDTD+mtAkd/QtMcME6JPIog9HIL7p9LA39FemDUTI+hLqXO0hWUYNq
         32nIV++aTergC5UEajB4NKwOh778RSIyxtXJKVzgGgGLeEIaK/rT4EMwsD1aCsNNITl9
         dr3qg8TlB/Q24AEfFtyI9TCAwFxXi5sNO9pmB8fIaYBlp214EwgvidtiVMI+FoqlSeFX
         LOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TE+x56N/V0MkG6sYTCk7FXaMmY/BpxvCfhtLCRl1Gyc=;
        b=NjZgdRQyD2rA6X+lupVXhsvDzuHMxEixq4/HWdgWNzz4a7Cmw1US++X/fs2nXF3Bcy
         X4t+q6yuzfuKaHemD5r3h6az1FeYehMBLau+vBpjn4NEF1lAuH+wk++/pKnBCwYtokA0
         l3EMCE7yhvXhmPDgiuoUXbL7kCt3UwYBOGfwSSTR0svkwyzfGv0jJPZG2nmjVkssApg+
         F8SECHSjOtwNqhJIMMFSSty28sNwzj32f3gBNEhO5NMssW2kWCMw2/zla9i3mcCMtVY0
         oosSCCkuvnGxsujCab491RFGo6Tq1/f7pP7WPiXoRj6dPNA34H2fiGkZVJkTz1TqPGuZ
         jBSg==
X-Gm-Message-State: AElRT7FZVMP32wx8TXw3n2GlIU8qs8seg7oJMokwY7wSybvXBEMVOrGq
        CN3vxmRyDLL0RcgRjYAdulA=
X-Google-Smtp-Source: AG47ELst9/T5vuFdz2zPLVXTTfIdz/cAL3e5c1WX7WP26tW7UKrtOC0ShfWbUvhC/g5V2Zb63Ps9FQ==
X-Received: by 10.28.26.202 with SMTP id a193mr17572795wma.138.1520500928861;
        Thu, 08 Mar 2018 01:22:08 -0800 (PST)
Received: from evledraar ([84.88.84.116])
        by smtp.gmail.com with ESMTPSA id y75sm15994443wme.13.2018.03.08.01.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 01:22:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 08 Mar 2018 10:22:06 +0100
Message-ID: <871sguorb5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 07 2018, Johannes Schindelin jotted:

> Hi Dan,
>
> On Tue, 6 Mar 2018, Junio C Hamano wrote:
>
>> * dj/runtime-prefix (2017-12-05) 4 commits
>>  . exec_cmd: RUNTIME_PREFIX on some POSIX systems
>>  . Makefile: add Perl runtime prefix support
>>  . Makefile: add support for "perllibdir"
>>  . Makefile: generate Perl header from template file
>>
>>  A build-time option has been added to allow Git to be told to refer
>>  to its associated files relative to the main binary, in the same
>>  way that has been possible on Windows for quite some time, for
>>  Linux, BSDs and Darwin.
>>
>>  Perhaps it is about time to reboot the effort?
>
> You probably missed this in the huge "What's cooking" mail. Are you game?

It would be great to have this rebooted now that my perl cleanup efforts
have un-blocked this. Will be happy to help review & test the next
iteration.
