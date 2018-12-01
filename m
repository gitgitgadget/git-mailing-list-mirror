Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E71211B4
	for <e@80x24.org>; Sat,  1 Dec 2018 06:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLARdu (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 12:33:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40067 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLARdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 12:33:49 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so1696381ita.5
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 22:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ty+MpuKV7/6i3BSgr1WHQmm5jnpji/XQWl0q2Hc7w+E=;
        b=RyR958XvuOFSww/rJabbuoYqBpxTTzHOPgV1vmH991n8qy+BnzaKGEl8txPUX6+WX+
         Xf1o1cp2u8OVL9FxVm2Wpi/xH/sjugYITD9XmUW9vwzbOZ4NkNLJy80ChanTetQ4vIZH
         mvkH9mIZd0QTDz+hrgwdX/rvtFkMHLmgvLcoKRsKZPvhQu0kKAPZXWOROZuzgBxhlwiQ
         Sb6o/e4FtYNPkRrZ0hWYrFVrw23p7PGmOukquzkFlypFiYJerWeBP263K7Lr8Boup/6n
         4RNG0QwzW5wApwANefn8wyl+cEXKprWKH+HbTEUsMIBGB6Kz1jH8Sq/xn8YaMbGyjpV+
         WyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ty+MpuKV7/6i3BSgr1WHQmm5jnpji/XQWl0q2Hc7w+E=;
        b=HJeU9BzW3KP8cuvHAUKIOBzs6Ozyfa0bBPXvkysVUOt6kY4oJLNWpOq3ZG1jkjqDiR
         GX4qosZtFFpq+sSS9IxlAof8x0kE2LhklaoZCl4RrpUJUnH616EYE4dBVAF612Fz0kGG
         x1Vurz9GvR2sJ9Og0t6UFEzw32+geJyUwxNhZqrXqzHpjJ9TaZfrRF7S1kdt8OiR4Zkn
         zjibu9ZAo6Qq3UdkqqS9hAOPfpa26rk4AAb94GFogFXGXdf++FNhVB4whz2gWKa1zFnt
         40rA4r2l8autyYktq0d2dlZrYikI5FAFPYOvZEo9uoSyw6OEF1ybE8BRSVdRg7Rdk8/7
         neTw==
X-Gm-Message-State: AA+aEWZUjsD7+NOyA2ntQe6Xe9lK1AxZeF9ruvqk+IPiR2s0yQgtXXI8
        HZ/XooFFBPfZ4Xp9wPkqsdPA76XLffV5PqvCZd0=
X-Google-Smtp-Source: AFSGD/U+BWHu9bWoTgJogQt7nSMxNeEOsIgDIIxyLvHXLukREYD8E3uGAKsOZXO6wFFLO8HWhKnORXB169NoqDCbwOk=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr1398731ith.123.1543645322440;
 Fri, 30 Nov 2018 22:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
 <87mupuzhfx.fsf@evledraar.gmail.com> <xmqqa7ltua2s.fsf@gitster-ct.c.googlers.com>
 <875zwgzx4v.fsf@evledraar.gmail.com>
In-Reply-To: <875zwgzx4v.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 1 Dec 2018 07:21:36 +0100
Message-ID: <CACsJy8D7rypM-0gYx3Xtx0jDQ=xMO2GxEmf6Mvc84Ch3AnSkug@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, per.lundberg@hibox.tv,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 10:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> But we must have some viable way to repair warts in the tools, and
> losing user data is a *big* wart.
>
> I don't think something like the endgame you've described in
> https://public-inbox.org/git/xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com/
> is ever going to work. Novice git users (the vast majority) are not
> going to diligently update both .gitignore and some .gitattribute
> mechanism in lockstep. I'd bet most git users haven't read more than a
> few paragraphs of our entire documentation at best.
>
> So what's the way forward? I think ultimately we must move to something
> where we effectively version the entire CLI UI similar to stable API
> versions. I.e. for things like this that would break some things (or
> Duy's new "split checkout") introduce them as flags first, then bundle
> up all such flags and cut a major release "Git 3, 4, ...", and
> eventually remove old functionality.

Related to Duy's new "split chekckout", I just realized that I added
--overwrite-ignore (enabled by default) [1] years ago to allow to out
out of this behavior. We could turn --no-overwrite-ignore by default
on the new command "git switch-branch" to err on the safe side. Then
the user could switch to --overwrite-ignore once they learn more about
gitignore and gitattributes (or the coming "backup log"). I'm not sure
if I really like this, but at least it's one of the options.

[1] https://public-inbox.org/git/1322388933-6284-2-git-send-email-pclouds@g=
mail.com/
--=20
Duy
