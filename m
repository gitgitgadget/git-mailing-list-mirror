Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8C21F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfDYPZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:25:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34698 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfDYPZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:25:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id a6so280376edv.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9USTf6UrY9iuxKxPA7O2b9Nv2kfCpcQmlUT+EiGE/wQ=;
        b=fjwOymfkAEzC8wYg9di9Xcc9tyZK9xSnUIadii0+jYzy8a/Rx8rgXR5iPCmJFzqjpY
         OnDgTDXJgktZ2hsJAQQm8rdSQ4NOZaCvQU/vEIbEMOClHiRFrULJD0JhyTjh5coL2xTp
         n9+R7cvrltjxjy1ahQdsuiBjOyEGDcFbtQiLLp0nmKMYnQj7VhxTy7kUX4KOWUItrx9V
         +4p+2o03cjzc2k+3OpitEO7Q/b/M7Kj9NnUGEb0J0HTKmwTG8URG4bR4cjdj6w302+Fb
         f9v/hCkYCdPFJIGVbGK6/u3qEnBscNcaSYLtIjAnzBy7cuyhuq6CRlkK37u+ipfjsreT
         sgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9USTf6UrY9iuxKxPA7O2b9Nv2kfCpcQmlUT+EiGE/wQ=;
        b=lIWg1gjwZZeHknftEk+4l/uwVc7kSO5e593sRu0vgjaOF+UxJmdZZZctDW+heNx4LO
         bI2GPedHFKqaEUf8PPTNV9q0Ww1JTk1oYCKeapI8E+/47/uiufu5iHnNUBQsTgYdiRk6
         pab0rxaFvkmiGLWuboBUyezFMvcbSr54VNExpgljawpVn2sQ0QVi0Vr5srx5dyeD+MwP
         gskeZzpcXnQ9BSKnm2nD/mvuiGAb6cwv1dND/7l2wWMNx5+PmGjjDU895dRr28G5c9Wg
         djAOJWG4uqvVjOKAi4m90fm6Y2TcXuSd/ku/dLA6UXFfcSBGtdZdBMyd7cfdHRtw2FjX
         fkmg==
X-Gm-Message-State: APjAAAXP0CR+FwyqJ32gMhir2DjgMYkURFsvjsA8LFUCs0ssRJJeovwL
        DUrUmlUxLO9sY71ybEQF2VIoUKd2
X-Google-Smtp-Source: APXvYqw35xvpxlrg00yFmCZ7xj1GPNUwmZqy1OD9b3VHk0Lc1tK9JDP0ATCOx/XBBz8/uTVIA4whww==
X-Received: by 2002:a17:906:724c:: with SMTP id n12mr7673493ejk.192.1556205916374;
        Thu, 25 Apr 2019 08:25:16 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id s11sm4071455ejq.59.2019.04.25.08.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:25:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net> <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190425143614.GA91608@google.com>
Date:   Thu, 25 Apr 2019 17:25:11 +0200
Message-ID: <87ef5qrtt4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Jonathan Nieder wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Because we don't have some general config facility for this it keeps
>> coming up, and various existing/proposed options have their own little
>> custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blame
>> skip commits" feature
>> https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
>> (b.t.w. I *meant* /dev/null in that E-Mail, but due to PEBCAK wrote
>> /dev/zero).
>
> I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
> That is, I thought the intended behavior is always
>
>  1. For single-valued options, last value wins.
>  2. For multi-valued options, empty clears the list.
>  3. When there is a special behavior triggered by not supplying the
>     option at all, offer an explicit value like "default" that triggers
>     the same behavior, too.
>
> and that any instance of a command that isn't following that is a bug.
>
> Which of course leaves room for improvement in documentation and how
> we organize the implementation (as Peff discussed in [1]), but isn't
> it nice to already have something in place that doesn't require
> inventing a new syntax?

We can quibble over the wording, but I'd say that's a "hack". Yeah for
*some* options setting it to an empty value clears whether it's a
single-value or multi-value.

But it's entirely dependent on the specific callback implemented for
that option, sometimes there's no way to "reset" something, and in the
best case you'd need to exhaustively enumerate everything (e.g. for the
sendemail.* stuff) and hope nobody adds a new option tomorrow, you can't
say "clear this wildard" or "no config from system-wide".

So I think it makes sense to think about how we could promote this to
the config syntax itself so that what somewhat-mostly-but-not-quite
works now by convention would be guaranteed to work, and things that you
can't do at all today (e.g. ignore system config, or selectively ignore
something) would be supported.
