Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384F81F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeK1CSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 21:18:25 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36516 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeK1CSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 21:18:24 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so17251636ioh.3
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=deuljo9ZZjCoDCIlGY+UB37m1SwjKUd3Jh9CAR8D2S0=;
        b=qt0BQVAurN+IlcLP3i0hCRTk7AnbsmFQ1ClOr/o2QyUkv0NgCv0AWXeimA+joZAIT3
         Ho2owkNVMiarTwy6qQZClInjc/Aqs6/XLCkVshutKTzP1iuqjsC2Jmx/S5G1lWeBYnSk
         Q/9mFjdsQ5q+EpgoI41fI6QvsBh3jEEwEjg8XmhuzwkEQdNIheH9toCqRacFtlUXTenk
         AyzYzUnZCn1HFq0Xb8rJR1cQp7+JqcutbSRlhTbAZBI2WJ7CybDSHbI/eYIYsyCDG+yv
         6GS6/WNzcAeKB6BbogcLlHvrzIl26ULw9W6cBf7yvZAelmKlmdMt63GVN7ZzT2hrw/ex
         eosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=deuljo9ZZjCoDCIlGY+UB37m1SwjKUd3Jh9CAR8D2S0=;
        b=XF51m1eemc+NOqxhNgAFfiEc76XFV9N8jOl+i3AjYVCaGpZlnbZkHzpCK3Yb98WiLr
         hraT1FBvj7nX/dJX3c1IoXW3iIfBcIAhJX9/YHhlsyuxa/ZDGPp1yEKJGjKtqxh3CzTt
         kP0V3rDBgb52hP2boivmTGjarRRRqyEE7gHRxQkwQxmvJFeHuX3gw4nObnA+VKPtg5IW
         PrSrBUnhwEnheyPvJgyiZ2WXMjk6BuMWEdbzLQbW1rJEgmdQ+m+pL5bdUnh4nMo02C4E
         c+i78DgivSJT1x+0aAsXfUAclo7BFXsscgwOPhcoP64JJGde8dXz8gAYG/+qBvyJWyjx
         TS0A==
X-Gm-Message-State: AA+aEWYnB42EYB5KuELWtkOpuFvS+mwQtTWyl8uoxXHFiqIzyhGThx2F
        Okz69G5Lxg+vyy24prrdDTex7/cJx0kjUzm4ZWpW7g==
X-Google-Smtp-Source: AFSGD/VPWPwAWF9lgquY/Me5JX/rdaVDaut9vzAM1AAhAGjC0SV3yLoVwMlMYP9nIVzC+gcr2QnmmPX03TANEWknNLM=
X-Received: by 2002:a5d:9455:: with SMTP id x21mr7081920ior.282.1543332009173;
 Tue, 27 Nov 2018 07:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com> <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com> <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv> <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
In-Reply-To: <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Nov 2018 16:19:42 +0100
Message-ID: <CACsJy8AtM4uar1TB=bevC4dnctN9h+V3P4OsSnCk9fGseXDrog@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     per.lundberg@hibox.tv,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 1:56 PM Jacob Keller <jacob.keller@gmail.com> wrote=
:
>
> On Tue, Nov 27, 2018 at 1:45 AM Per Lundberg <per.lundberg@hibox.tv> wrot=
e:
> >
> > On 11/26/18 5:55 PM, Duy Nguyen wrote:
> > > On Mon, Nov 26, 2018 at 4:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > >> Some of the solutions overlap with this thing you want, but I think =
it's
> > >> worth keeping the distinction between the two in mind.
> > >
> > > On the other hand all use cases should be considered. It's going to b=
e
> > > a mess to have "trashable" attribute that applies to some commands
> > > while "precious" to some others (and even worse when they overlap,
> > > imagine having to define both in .gitattributes)
> >
> > Agree - I think it would be a very bad idea to have a "mix" of both
> > trashable and precious. IMO, we should try to find which one of these
> > concepts suits most general use cases best and causes less churn for
> > existing scripts/users' existing "semantic expectations", and pick that=
 one.
> > --
> > Per Lundberg
>
> Personally, I would rather err on the side which requires the least
> interaction from users to avoid silently clobbering an ignored file.
>
> Either Duy's solution with a sort of "untracked" reflog, or the
> garbage/trashable notion.
>
> I don't like the idea of precious because it means people have to know
> and remember to opt in, and it's quite possible they will not do so
> until after they've lost real data.
>
> I'd only have trashable apply in the case where it was implicit. i.e.
> git clean -fdx would still delete them, as this is an explicit
> operation that (hopefully?) users know will delete data.

Yes I know it will delete ignored files. But I don't want it to delete
some files. There is no way I can tell Git to do that.

It's the same with merge/checkout's overwriting problem. Once the
initial surprise is over, I want control over what files I want Git to
just delete and not annoy me, what Git should not delete.
--=20
Duy
