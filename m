Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FF21F406
	for <e@80x24.org>; Mon, 25 Dec 2017 15:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbdLYPkQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 10:40:16 -0500
Received: from mail-yb0-f180.google.com ([209.85.213.180]:35348 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbdLYPkP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 10:40:15 -0500
Received: by mail-yb0-f180.google.com with SMTP id u107so913649ybi.2
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NDa8AsW3eLw6vN1J4PgXwfhC4Hm0xD9w1lqCDSD1ySc=;
        b=SZj/QD0OBJYghsvQCG/MF0QTqgwflh3JzkBPrjFhK5Xf4DHkjXuvjY2t05N9IWsvUr
         n0t6LoMNCq8hOvXRNUYQWwD4SuVTfTVqIcpEtEu2tbuaQuETLbQ76+4XKSZhsaaLySJb
         tIXPqtWbrUcm5Ztr+x8vGvH0FV+6XlnIuWnAUAckABnuGeV0yS1tvOefSiOCWNENs63Q
         hsy0n57t48sDahmTXdG9QEK9PXMQebYJaJQBPaDPUPUeVXW2T2ffZRyZtEufzuCS477d
         5XFqsxct2CyI9p6hHaxUbtkLheuRU2/pfptz8l99tMV6HfxEG4XTqcybKZ+djV8iyXz/
         b9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NDa8AsW3eLw6vN1J4PgXwfhC4Hm0xD9w1lqCDSD1ySc=;
        b=sDgzZ1bdfYI0DwZt1RVyLqEuh6mLURSbxXuYaS4nuU8i54+uzVZrIBE2z72cCHj+9v
         Ts28mg31mF7PWQq7LPhFRnyQ6RXgPwC48lA7CJ1zkQyXGkoJzVFb+eLtmQ9fRgXs59sk
         iPKVO8OBHh+gxWNY7aHtsb1+a2YTKYFUERe9W0D8XGQBQqYHrWlYg/3ZUu2IJ24UZNWb
         uIhNL5RrFNpZXWv5r8Hk1ehJDaAtg92G9k7eI2O5nCZZXS2Oa8zMOyhUJ278O9m4qPpc
         R0Sl3i5MLNRu1dpUqG/eAGF4jianZtJUm8sB8uURNqdq8etT2JqROjoD7J+HBL0Z03Qg
         avoQ==
X-Gm-Message-State: AKGB3mK9neqcyegkNwKG7CwnbaCphWckbNFsu1aAN8ONZHtAArE60rHE
        W/Fz8epRJaW4e68XoYOUeV+W0logsfelcxZmqcs=
X-Google-Smtp-Source: ACJfBovcGomhZ6oa2DX73tGy7mtoz2UG062M9uM0yOmjh30PFQ+aPijQPRugluNWqUJW71wCSUtyEMDBqIX4VfTzYGU=
X-Received: by 10.37.109.66 with SMTP id i63mr17036548ybc.270.1514216415139;
 Mon, 25 Dec 2017 07:40:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.172.93 with HTTP; Mon, 25 Dec 2017 07:39:54 -0800 (PST)
In-Reply-To: <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-9-liambeguin@gmail.com> <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Mon, 25 Dec 2017 10:39:54 -0500
Message-ID: <CAKm4OoWgB7tz0HJorDzL9Xy+fX0LVE1eOVngrfMTMDQQUTDk4Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 25 Dec 2017 at 07:48 Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Dec 4, 2017 at 5:17 AM, Liam Beguin <liambeguin@gmail.com> wrote:
> > +static const char command_to_char(const enum todo_command command)
> > +{
> > +       if (command < TODO_COMMENT && todo_command_info[command].c)
> > +               return todo_command_info[command].c;
> > +       return comment_line_char;
> > +}
>
>     CC sequencer.o
> sequencer.c:798:19: error: type qualifiers ignored on function return
> type [-Werror=ignored-qualifiers]
>  static const char command_to_char(const enum todo_command command)
>                    ^
>
> Maybe drop the first const.

Sorry, that's another copy-edit error I made that slipped through...
I'm curious, how did you build to get this error to show?
I tried with the DEVELOPER 'flag' but nothing showed and -Wextra gave
way too much messages...
Did you just add -Wignored-qualifiers to CFLAGS?

> --
> Duy

Thanks,
Liam
