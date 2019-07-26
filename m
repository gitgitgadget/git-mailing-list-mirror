Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC221F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGZPyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:54:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35355 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGZPyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:54:02 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so105811683ioo.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I0BaHkaNnTdba4z5vWgtRvggMpkumNd9TvNnWDGFz1o=;
        b=eW6o0TtVLNQI4w3byHjEutAr5+gguwKwZu7EKND71a9/ft+hkzliaHJsWr/sn1nMuX
         8X31O1O3Bq91VOzikLkjKfEPKnxzhQU2SC8PmQUp+tJvo3GB3w9jZ8SRj/WiGE1Lq4bx
         0J3VPuP2KFuZOiMC/XXQjT8IwAuaFWufJp/09vDI9HzB/VxgvXv2D7YNehR1HVeX+pMe
         K7PxiH1vGuP78Gyw0vHzM75ORDtYYQ5JoVCXLtUdsw6xV/aANT5lwmzUsLt9MDXWWKnj
         RJIsZU1gEXzwcitUWUGd2Za+iAByCctXxyJSVt8y3BlApRdXDyaXBTsMA3FziEQaoVbB
         6/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0BaHkaNnTdba4z5vWgtRvggMpkumNd9TvNnWDGFz1o=;
        b=JkQEaO4a3F7C9LNtKRmyKeCs47wOw+IMSmGeABJgN+Tx+bIdqybNwygVCg44trQw8b
         sja2IE5CRs0qrEYKgdVOs7uXnJEivNai5iyUh/skmcCtr9wsoj+f37pSW94YAQRn3mGo
         w+COXdV8srWdV8JVi+tUZ+RrtQQiOYj/n1m5YJXxXsevjcGaCZoDirB+wcIJAfA9Ypqi
         2zPb2ojqAq/9zBRGs+K2gKMqJbcbOO24dv7a10U1N2okmWVLYDkbY3QKYJuUbaokNwEA
         a9rUGpnxwFanJgMW0vw/anD+8blXUE8mFYhr2kKvcUUs7mJg4ikzsc1anr1s5yUHUDoI
         jxpw==
X-Gm-Message-State: APjAAAUs7tVk3AG7juV1tWZ0yNsr4GMQhit8eRPTSCJTnE+KtdpBTZT8
        PrVDuYlsAOhNK7yqJCC9akpzUe30jSxpXoo1dkQ=
X-Google-Smtp-Source: APXvYqzSK7epSThcuMrtcvCyus6EDcJ9aZoESRpMDqG3zJNPAW0Q32LAkUbdlb9xOqrYfQuz/B6xESTGOm3WCy6gRIM=
X-Received: by 2002:a02:b016:: with SMTP id p22mr12525032jah.121.1564156441426;
 Fri, 26 Jul 2019 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
 <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet> <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com>
 <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
 <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet>
 <87ef2c7roy.fsf@evledraar.gmail.com>
In-Reply-To: <87ef2c7roy.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 26 Jul 2019 08:53:49 -0700
Message-ID: <CAPUEspgseYvKTNN6EkqjKo1zQXRjUzyiLMe0kJwnNu=F3ATmOA@mail.gmail.com>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 8:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I'm not sure what a real fix for that is. Part of it is probably 8/8 in
> the series I mention below, but more generally we'd need to be more
> encoding aware at a much higher callsite than "grep". So e.g. we'd know
> that we match "binary" data as not-UTF-8. Now we just throw arbitrary
> bytes around and hope something sticks.

I haven't look yet at your proposed changes, but my gut feeling is that
the work to support invalid UTF in the yet unreleased PCRE version would
be needed as part of it, and therefore it might be better to keep PCRE
out of the main path until that gets released and can be relied upon.

kwset is not going away with this series anyway, regardless of the no-kwset
name on the branch.

> > If we're already deciding to paper over things, I'd much rather prefer
> > the simpler patch, i.e. Carlo's.
>
> As I noted upthread PCRE's own docs promise undefined behavior and fire
> and brimstone if that patch is applied. Those last two not
> guaranteed. So we need another solution.

in my original reply I mentioned I explicitly didn't do a test because of t=
his
"undefined behavior", but I think it should be fair to mention that we are
already affected by that because using the JIT fast path does skip any
UTF-8 validations and is currently possible to get git into an infinite loo=
p
or make it segfault when using PCRE.

in that line, I am not sure I understand the pushback against making that
explicit since it only makes both codepaths behave the same (bugs and
risks of burning alike)

Carlo
