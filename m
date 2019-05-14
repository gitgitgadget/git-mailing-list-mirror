Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A606C1F461
	for <e@80x24.org>; Tue, 14 May 2019 00:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfENAa4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:30:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40562 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfENAa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 20:30:56 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so1999908ita.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lRNH7tgPYaiB7wyLJ/lPESpqusxUqrNWuPxHK81btiE=;
        b=TG1Cjjq2O+PfePAC8omyhtjl1Euf/2nOjdcEEp1uHrtngKTMUOsYVgPjRJvoWCqOuH
         vix8hDvDXMGc4LNJizMMDhsVeHAsVITKXtlkwFt8mqlv/mhof9fzn7ACDD93aawJyblx
         py7V6kSRW1HP/keUnHXZVGeaVaSOuIq5JGlxne8QSpVYu+j3u7vStkbb7eMSGXZF3p6f
         2fskk31tNGlY9dpbvwIxv82cTWBfSby/IWoUrA+ccwUB0xVCjqDoYPx0K9ZcQB+wziRD
         aBMsdaw5xDTKURSWPjrt0cj9haxse/zbK7KMjP4rE9c1+TZDIYXlVkDQz0YYT2N4VMhU
         r+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lRNH7tgPYaiB7wyLJ/lPESpqusxUqrNWuPxHK81btiE=;
        b=FIAh68Wepi9sPxi24MAVm+ouJ4/dNR8cz/xpNeInxxbx4/bn70XvDtV+dc73pI1Qbx
         vZtKQMT2a0DvbJe3343uIGaL9xwHH+uo8q20130aedZhqb2y29VkjwSUFUbnJVrTX0yu
         +18Rg+mc+1/rBNuHpXgE7AkM2eHgqI+kGXQNAKcFpPv427dO8QOyHB+OhccDGG2R+zlP
         5HrtX8YTbVKBicTpCSlPy+2HQNC4BsH4P/HoFcEsJ46bAcAwB9w34mmMvgEQUMlSjtV/
         Ovu6fKdMXkP+GB3oN+O1KWRGiTBMrV6z4AGXaHzPiT7lWAwfJ58aMrP7kqhPM66Ye6mo
         kWdg==
X-Gm-Message-State: APjAAAUm+14Q2ZOMu+VWOx2EOLZPeJl2t4K9N7RY4Do/UmCROkeIm1KE
        8xYrLTu65RcuZ0wuKUNh8gBaPtt7BGOB8NVSnk0ZUmbU
X-Google-Smtp-Source: APXvYqyUF8HmQX4s3LHsrPCLAdbb0XL5JL9FglJKzKDiJwRxaj+dVZ+Yx2YRpc9pCjnqSRbT0OIUMDBc59wMs8+8Kqg=
X-Received: by 2002:a02:1dc7:: with SMTP id 190mr19841211jaj.62.1557793855266;
 Mon, 13 May 2019 17:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net> <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
 <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com> <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Tue, 14 May 2019 08:30:44 +0800
Message-ID: <CAKO26MvkD6-ZuGLbc7EBrh8umiyg2KAhj1eTDPtMNu5Tg5wE+w@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> =E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:
>
> > Hi Junio,
> >> ...
> > Could you please give me some advice on my patch? Thank you.
>
> I tend to agree with what Phillip said in
> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>.
>
> If the difference between "status" and "commit" bothers you so much,
> i.e.
>
>     When typing "git status", there is an empty line between the
>     "Changes not staged for commit:" block and the list of changed
>     files. However, when typing "git commit" with no files added,
>     there are no empty lines between them.
>
> it may not be a bad idea to try making them consistent by removing
> the blank line that is given after the advice messages, perhaps?

Thank you for the review. I guess removing the blank line also work
for me. I'll submit another patch.

Best,
John Lin
