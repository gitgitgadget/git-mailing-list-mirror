Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF5F1F461
	for <e@80x24.org>; Wed, 15 May 2019 03:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEODD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 23:03:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37483 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEODD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 23:03:28 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so1032342ioc.4
        for <git@vger.kernel.org>; Tue, 14 May 2019 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWpwIWZMzRE/EZ0hAyjMuIPex19U6OG9dTOqik3FnsY=;
        b=EsG7ddwjJOkhrsBvMzcoZslIOSXIlr4YMeX/PUHx4XQxVZBbCMwqqwWhfnMW/MKOjI
         rGeQOGi+4oMvIXJn4nUUkwZCLiQPikkH2D1pt/n6mkuzjmwj3wWi8UNWrzAJId65u14r
         rjTdKv9h2EtfwezCgbdJZYtD7nDeqDsphzwHRduCgzPU5Bj7jsAvHLBzRJ6m2VRMWfzf
         vtaDhs0ZI4NoMDm73OSpwTB4X0SorxJKJYGhiF81AWMKVDn/v+fLSAkBK/k3sPRbt7Uq
         rGmJd2OaHxz7TXiqGYaFi/TBMKQ30elDs5xTtErqmJMc94awg0JfvzAswXvlCNGnme0Z
         aWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWpwIWZMzRE/EZ0hAyjMuIPex19U6OG9dTOqik3FnsY=;
        b=U5DGndjO+GVCwRCUpdmQxICMBYPrdz2lcELFMA3GG7J5RUSNCIUrvSw0RclYhNe8iX
         sspAvODCyobTNO2+CA7dZtji/LKIkLHme/s6tfs5vP7bqcBDAaU+r71aZhveUblI4lbx
         u2lnypEL1QX/20WBm89QH/pLyp4U98S8Q7aNeioYQGdN22Y83e/hK3uWISb4stF6YrJj
         fcYPKe1W9rHl86DeR6GyjrhmF5Gby43+QKQCFjlEQp56Odlx+plceHo6WVR/Al/rqMwL
         Z0cq/xSVuDkbSYdh6Ms6dlsqL5I8jMmipqh74KBeGUo95uqrUNG+45bSfQa68gl+7v9A
         Ki6Q==
X-Gm-Message-State: APjAAAX0xLAbXyLK2xXCzeeS/iuYp4vuKa9yuO59ZTRzvkPTyXxIEG8Z
        DjwWeg9uGHb/lWyNOUGUuYTOonyDJf6kz8JuHn8=
X-Google-Smtp-Source: APXvYqzvrCy8i4UG4mtTxJ3YksRHdttR16TPwTKY2puDWQYHXwR4OvTaWd+C8QHbg+2YtbG9/OV6R10ql0+3gPz8jLM=
X-Received: by 2002:a5d:8795:: with SMTP id f21mr18810549ion.20.1557889407332;
 Tue, 14 May 2019 20:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net> <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
 <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
 <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com> <20190514020416.GH7458@genre.crustytoothpaste.net>
 <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com> <CAKO26Msqj93hwKVduB0op=sMXs3egM2zvyfcJgpoqTWn4ywHHw@mail.gmail.com>
 <xmqq4l5wa6fm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l5wa6fm.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Wed, 15 May 2019 11:02:59 +0800
Message-ID: <CAKO26MvNJ6q-GPvY8QSrc+9-HYKK=rBJuNUrMK8EgC9YEq2O5Q@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=888:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> =E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:
>
> > I was not talking about the messages in the editor session. I was
> > talking about "git commit" without "git add" anything.
> >
> > For example:
> >
> > ```
> > $ touch newfile.txt
> > $ git commit
> > On branch master
> > Untracked files:
> >         newfile.txt
> >
> > nothing added to commit but untracked files present
> > ```
> >
> > My current patch is trying to add an empty line between
> > "Untracked files:" and "newfile.txt".
>
> I do not think that one is paged, so if you ask me, I'd say we
> shouldn't add an extra blank there.  Is that message also reused in
> the editor session, or do two different codepaths produce a similar
> looking message, one for the above case direct to the terminal and
> the other for the editor session?

The messages produced in wt-status.c seem to be reused in
both terminal and editor session. When I tried to modify the
messages in terminal, the ones in editor session will also
be modified accordingly.

By the way, my new patch to remove extra blank line is here:
https://github.com/gitgitgadget/git/pull/196
I am still waiting for someone to comment "/allow johnlinp".

>
> But again...
>
> >> At the same time, I think I've been happy enough with the current
> >> output from both commands, so if you let me bikeshed freely, I'd
> >> probably pick "let's not change anything then" ;-)
>
