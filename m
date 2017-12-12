Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7501F407
	for <e@80x24.org>; Tue, 12 Dec 2017 11:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbdLLLtu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 06:49:50 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:44683 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdLLLts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 06:49:48 -0500
Received: by mail-wm0-f46.google.com with SMTP id t8so20108855wmc.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 03:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Nw8pVG3+4LkVSRROrpsGWIk9NIQtBVVD/asxm0IVyfo=;
        b=rSexbpxA4ombSjM2/uJhqeOfR3Vl6XZObpjOmwATeM+lowWGTxRxzoYr23wq+nbPt5
         UyjdO1lBlMfNazOj07o1UaEllWDBMydCiRJXe5yMPwD53Q4Q1DP8BJNs2dSCSNthZhJ9
         qpE0/olbA34NECUXXd4b3lkMewBEy3cPy0MysMQrU8Tl7TWsoYM8cs90zAxOEgmRFMYS
         e+MnM2+Lc0gZkLyC5vJUai4LAYP69/YbtDaTqtPv7JgDaDOYPuMxLQ3Q3U6SylRxhYUA
         T76O+xZqnFCwKIkjKRv2UONR2ItGaQZC+Y7aYAEGks+CCYY07vsXalFgpyspP9gmf1pJ
         46KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Nw8pVG3+4LkVSRROrpsGWIk9NIQtBVVD/asxm0IVyfo=;
        b=KjjSXG76vObBEX9d4RuP/BGhZPQS2lRwfMevZfEpKA4eLNW8IwKpmJLF/j2CG0obWA
         I/DSkZVmV4I5ZE+VAG5zmPfXOKz48Yi4yLfkFd3deHjRL+J0Sr+iTWbvH05gW0vLnuvh
         v2UTxIMNdHII1MOE7j9VohhJlQxEJd2MR0ac2nwweJE4tBZulEGRu9SE0Pk1D0ny1ePh
         pfGeO75Y2SAwDpwR2K4LIhkNqbcGPX2CQo5IMAzc3+Uy5gJ4EPSXQzsZFmbq1vkWkm4u
         qoKxC/5ZoojA5xcqK+/J3NBlZZ/a7I7jyfSR/6HzlNgR7ZDElDxmUqJrAYoBBmBoF8sy
         I9GA==
X-Gm-Message-State: AKGB3mIWm3VIK7WysxeiMdWMbQJHXqMmaSSerjko+Pa7Bhket2M8PVjG
        Yre+EjXTCUYryTV8wiOzqKk=
X-Google-Smtp-Source: ACJfBostK2/fZhe6Bs8nB7zgXxQszuQchvrQrdBEg0z6Rjn0GNdiXgI2z5gBK6jtvrQhEout5ZSEYg==
X-Received: by 10.80.134.213 with SMTP id 21mr2616541edu.83.1513079387230;
        Tue, 12 Dec 2017 03:49:47 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id u21sm7545401edl.54.2017.12.12.03.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 03:49:46 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eOj4D-0006RK-Cf; Tue, 12 Dec 2017 12:49:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com> <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop> <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com> <20171212103040.jbgkyet5rapqxi44@laptop>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171212103040.jbgkyet5rapqxi44@laptop>
Date:   Tue, 12 Dec 2017 12:49:45 +0100
Message-ID: <87po7kcgiu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 12 2017, Thomas Adam jotted:

> Hi,
>
> On Mon, Dec 11, 2017 at 08:46:46PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> I.e. we'd just ship a copy of Email::Valid and Mail::Address in
>> perl/Git/FromCPAN/, use a wrapper to load them, and then we wouldn't
>> need to if/else this at the code level, just always use the module,
>> and it would work even on core perl.
>
> I disagree with the premise of this, Ævar.  As soon as you go down this route,
> it increases maintenance to ensure we keep up to date with what's on CPAN for
> a tiny edge-case which I don't believe exists.
>
> You may as well just use App::FatPacker.
>
> We're talking about package maintenance here -- and as I said before, there's
> plenty of it around.  For those distributions which ship Git (and hence also
> package git-send-email), the dependencies are already there, too.  I just
> cannot see this being a problem in relying on non-core perl modules.  Every
> perl program does this, and they don't go down this route of having copies of
> various CPAN modules just in case.  So why should we?  We're not a special
> snowflake.

Something like FatPacker wouldn't make sense in this case, we're not
packing stuff into an archive, but just dropping them during 'make
install', but yes, it's the same idea of shipping our dependencies with
us.

I wouldn't argue for doing this from first principles, in general I
think we're way too conservative about adding dependencies to git.git,
but the general consensus on-list is to do that carefully, that's why we
have all this stuff in contrib/, and why we're depending on perl core
only.

Users or packagers of git don't care what's normal for perl programs, to
them the fact that git-send-email is written in perl is an
implementation detail.

The maintenance burden of just shipping some CPAN module as a fallback
is trivial, for example we've shipped Error.pm since 2006-ish, and until
I sent a patch this month nobody had touched it since 2013.

It's certainly much easier than maintaining a bunch of if/else code
ourselves, or maintaining our own stuff purely because we don't want to
force people to package perl dependencies for git.
