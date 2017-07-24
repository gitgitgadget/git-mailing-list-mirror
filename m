Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCF62047F
	for <e@80x24.org>; Mon, 24 Jul 2017 01:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdGXBiU (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 21:38:20 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37683 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdGXBiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 21:38:18 -0400
Received: by mail-qt0-f173.google.com with SMTP id r14so29624198qte.4
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 18:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fu/Wzqh9cYsIHEhNzxsGNDODU4BifgzvurU2eQVKiEs=;
        b=U4aHS4Uz+h6zRbKCN/OAaDHciPKeoEGY1+7A87B0A1ltmcwzdAxTLDDYE+jXxkeoLv
         A0PTvVH5wcVsi60LQtkP65jz/HsRrV281sAL3w99rdMrYfCKmxa8E4U3AHJJs8/h+zxf
         M7YwCEkxH4NxzUAXasYl6GTT1+svqQiitoO0XvFeSYnHJ8aqCqTqJUBQh5iGVCTDewOy
         j/wcm1jUBOgI9ZmwlMN4BzeQzVSf3b26sG5vJfikNlT/PYPXYNSx3NWz+1+CIyPd7bSG
         be93anLge9gPaknAuODuWKTNNi0PDg5ATAHPU6uHekHo3d1t2z4w5iCWA+1kYvBlA8eD
         tTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fu/Wzqh9cYsIHEhNzxsGNDODU4BifgzvurU2eQVKiEs=;
        b=kyeUMUHVhaaEyC9Ideo/8aysTn2oio5/hFAaoiAKj/BCTsLMzyuFiNJepyf4/Hr9ug
         y0QLxvAi8Jy7UPAtH7zVYH5KQ4coD/8+WcCL/0lpxKWdQmeEAzv9I+RHOKQK6DhZ18CZ
         OlGRnnQwnEBntH+vdXwFO9yrhX6BePipJEkl7DVLrS4Zo1+O1t0B8tF5yC+KaasKd7fw
         53GxTIGomowKZjjoG42yJHoWZlzfHXsDOpJMqhC7n3PIRyrnJ65ZsAETGQaasirqFMmP
         YjzPlC8fzGyPQVmVVKYAY1L9noy45yZwUqDA8mVjUOjs4WHyP0VZikIID+RFvK+hHcgH
         2pew==
X-Gm-Message-State: AIVw110WB4Qi1zlSNzjK17kGhridKE7HBZhAbPzV3qpXlvZHeb7CXPyl
        FB4KFDq4Ds/zbj0C4Nruzo6Jzu1/9Q==
X-Received: by 10.200.32.146 with SMTP id 18mr18292007qtd.146.1500860298213;
 Sun, 23 Jul 2017 18:38:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Sun, 23 Jul 2017 18:38:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
 <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com> <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 24 Jul 2017 09:38:17 +0800
Message-ID: <CANYiYbHMMJ1tubajHNZVsQ=ihmogtF4=FqrRWvPJg4+wuBapbg@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-22 19:28 GMT+08:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Sat, 22 Jul 2017, Jiang Xin wrote:
>
>> 2017-07-22 7:34 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> > Jiang Xin <worldhello.net@gmail.com> writes:
>> >
>> >> A very small hack on gettext.
>
> I am 100% opposed to this hack.

It's really very small, see:

*  https://github.com/jiangxin/gettext/commit/b0a72643
*  https://public-inbox.org/git/a87e7252bf9de8a87e5dc7712946f72459778d6c.1500684532.git.worldhello.net@gmail.com/

> It is already cumbersome enough to find
> out what is involved in i18n (it took *me* five minutes to find out that
> much of the information is in po/README, with a lot of information stored
> *on an external site*, and I still managed to miss the `make pot` target).
>
> If at all, we need to make things easier instead of harder.

If it is only the l10n coordinate's duty to generate po/git.pot, the
tweak is OK.  But if other guys need to recreate po/git.pot, it's
hard, especially for guys working on Mac or Windows.

>
> Requiring potential volunteers to waste their time to compile an
> unnecessary fork of gettext? Not so great an idea.
>
> Plus, each and every Git build would now have to compile their own
> gettext, too, as the vanilla one would not handle the .po files containing
> %<PRItime>!!!

No, only l10n coordinator and potential po/git.pot generator are involved.

>
> So let's go with Junio's patch.

I agree.  We just go with the sed-then-cleanup version until we meet
ambiguities (I mean some words other than PRItime need to be
replaced).

-- 
Jiang Xin
