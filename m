Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6223920248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCMBVC (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:21:02 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:51409 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCMBVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:21:01 -0400
Received: by mail-it1-f180.google.com with SMTP id e24so334833itl.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XlgATQ2b0SxUgr1p/jd7ITTf/fdbqVwJ9nIJS31ARQ=;
        b=TK4HRbcQMbIwcyhgQJtmauELayP+dhTxN2Z4LvpVkT/pRMx8IvSls1N2co47DPptck
         xToDHKa2m7CR32uT2AHccGuByn+8BYgVSDg0UXGCAZx3arOW5qcC3xc5HsNekLIAbQ8Y
         i2/bBGGjI61GhxUEUrp/xRAwuyU3VsjSsyqr3n6LHAiwxheeFigevbSj/jgjrJK+VHZf
         xPsiEsWKERxGrdiGYFWxcRdgid+z6OA5gvoqj4rHSK6QX9tGtkOXpO+ZUBIVE52iZaj6
         ahRvLsWpd72d3OhURVRAd98+Oce9NX5+6sWrG60PAifmwMdGq3Q0GrrJsEKTUX4oWBec
         jvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XlgATQ2b0SxUgr1p/jd7ITTf/fdbqVwJ9nIJS31ARQ=;
        b=s/oiDpHcHRKgOL0qNeN8bAssBcr9yz5QAW6QaxUAmgPUoC0NV21Cixb0S6WHXE1aik
         LtYjD2YLAgNTWDudDZUtu3HMe7a9waiCl0gTOwQSV0Ts3rt3Nr97IdGZSMYpm1CNNKh2
         yHA9xpxDqeb8R3sy3bnq6Vb8pbvdwmMSOmKmHMefJkqX5rQbiCZayzzwuNaJCVX2QIVR
         pNSuvuPsVGXyfXAXmettIpN/TTmqnP4NHWk0OpZK4YLRGdw5gncJIo6b408Umm8WttQe
         gXMKHqwz6YuO7FmhlttJ4iHwpeGK26QT77b/dobv8PmakVKW4MYr7vfGBTdw7QR+VonM
         akCA==
X-Gm-Message-State: APjAAAXA4gjFyToY2qBfXmU93xtHzG1Z62Uan35XebwEEqqf5CUSPCk0
        GccvKGqDUEJw/5UFdjqIkq0MDJsASlW3WJYAzDk=
X-Google-Smtp-Source: APXvYqxpTTowUnT0fJ30hsvGPpNjCOJl2DZkR5DAj/7/Bd4dpEbyWsSxbdSKBpKFsNNcfH/UNrCBjlTTLxhVwKWoMoE=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr4528431jac.92.1552440060719;
 Tue, 12 Mar 2019 18:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093751.GA31092@archbookpro.localdomain>
 <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home>
In-Reply-To: <87va0orop4.fsf@igel.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Mar 2019 08:20:34 +0700
Message-ID: <CACsJy8DaTE3fbLZCbwW6XY4Z_2OjczOZROYiWsMPQrni_ybhZg@mail.gmail.com>
Subject: Re: Deprecating git diff ..; dealing with other ranges
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 12:26 AM Andreas Schwab <schwab@linux-m68k.org> wro=
te:
>
> On M=C3=A4r 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
>
> > I however think it may be worth making sure that our docs do not
> > encourage "diff A..B" and teach "diff A B" when comparing two
> > endpoints.  That can be done without changing anything in the code.
>
> The nice thing about "diff A..B" is that you can c&p the output from the
> fetch run without the need to edit it.

I do this copy&paste too though I think in this case we could improve
something to not copy&paste in the first place.

A..B from fetch is the same as branch@{1}..branch. If we have some
shortcut similar to ^! but for reflog, that would be perfect (the
branch part does not require much typing with tab completion).
--=20
Duy
