Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699141F462
	for <e@80x24.org>; Wed, 22 May 2019 23:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEVXBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 19:01:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46783 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfEVXBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 19:01:23 -0400
Received: by mail-io1-f66.google.com with SMTP id q21so3244030iog.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tqd/PDy6EcJeMYMxFVciq3SU0GvOpWAwCKIc9DQn6vM=;
        b=TVjVwn2n3nxvufsH2HV+BqZqMstatQXTx+tw54LtdKEiuRZLj1qoeYo3oWI58Tjr+n
         NSis5c9mOOMHfRJLnYlkduDgiZIejhkNi0Xxe6Rx1vfm05bbLr7tBw5GFmI7JZsdrdY2
         r8LiEauHo4oX2tCSlvvSu4b7yMz3s8tn9eykwWpUTaOdKYBC/34Bz81sUdARPf3n/ECk
         Tn3aKuZ1M3nRlERKdY+GcyhlzlpSj00ThZ38xHlEu/JsyximzfX580xYKvyt02lcC3Z9
         aOOGNv5wAMVxSjQ7lmUIk2LRGKZyzrtPeV9471Mk/lfyyy7XKtVdxxCh00S2DXHkaS9L
         w6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqd/PDy6EcJeMYMxFVciq3SU0GvOpWAwCKIc9DQn6vM=;
        b=YRqG5hyxJufnivwIL2+tlJ1hIkr5igGzevMVQMtA3SpNWAo45CWMJbzdfDnewDwUpX
         l/P8vPiYI3eHjpTKuJcmvmbse4CxJpxhLiSg79qFF/KIM03A90HSjtLkqUv07cN6EO0k
         A0+OVddHn0Mcb8eYlWXJ3ACvWWw2wu3rk3ag99QhGMbS1pvO7kXV0KV3d+qQh+g4h4LE
         Tmr7TH4GtaLVD5p3PIpII0Vs06WdDmTttPQm6lVoO2tBnjEAV0xNFBteAV4gr88cViXN
         Im84mA4e4bndd1C0Sc7voXnj/Czez9dzcbY/vgxecQ7/OsWxINIIeinbRlU4ypU/cqay
         YbuA==
X-Gm-Message-State: APjAAAX7cbNaGTG/3JaPI5kz1fdrqU2f6kt+DDkHqN+Ph8Rd72Lwxo0m
        DmcRB29TLcqF+XO0Fu+m/Oi7UbAdLbKPRm7UGrQ=
X-Google-Smtp-Source: APXvYqxNRdRGzyvz01kCvo1iRsWuTFS0b2950ZIK7sMwI6xCBsnAzNx07YraDhGu2Hi5ygpq7+8M8ALZi3cUT1PYTIQ=
X-Received: by 2002:a5d:9f49:: with SMTP id u9mr17274756iot.36.1558566082641;
 Wed, 22 May 2019 16:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net> <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
 <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
 <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com> <20190514020416.GH7458@genre.crustytoothpaste.net>
 <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com> <CAKO26Msqj93hwKVduB0op=sMXs3egM2zvyfcJgpoqTWn4ywHHw@mail.gmail.com>
 <xmqq4l5wa6fm.fsf@gitster-ct.c.googlers.com> <CAKO26MvNJ6q-GPvY8QSrc+9-HYKK=rBJuNUrMK8EgC9YEq2O5Q@mail.gmail.com>
In-Reply-To: <CAKO26MvNJ6q-GPvY8QSrc+9-HYKK=rBJuNUrMK8EgC9YEq2O5Q@mail.gmail.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Thu, 23 May 2019 07:01:11 +0800
Message-ID: <CAKO26MuiYgaXm90idDbMxHxOKct2sy7i-qG-=AEtB24pQX22ug@mail.gmail.com>
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

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> =E6=96=BC 2019=E5=B9=B45=
=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:02=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi Junio,
>
> Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=888:48=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > =E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:
> >
> > > I was not talking about the messages in the editor session. I was
> > > talking about "git commit" without "git add" anything.
> > >
> > > For example:
> > >
> > > ```
> > > $ touch newfile.txt
> > > $ git commit
> > > On branch master
> > > Untracked files:
> > >         newfile.txt
> > >
> > > nothing added to commit but untracked files present
> > > ```
> > >
> > > My current patch is trying to add an empty line between
> > > "Untracked files:" and "newfile.txt".
> >
> > I do not think that one is paged, so if you ask me, I'd say we
> > shouldn't add an extra blank there.  Is that message also reused in
> > the editor session, or do two different codepaths produce a similar
> > looking message, one for the above case direct to the terminal and
> > the other for the editor session?
>
> The messages produced in wt-status.c seem to be reused in
> both terminal and editor session. When I tried to modify the
> messages in terminal, the ones in editor session will also
> be modified accordingly.
>
> By the way, my new patch to remove extra blank line is here:
> https://github.com/gitgitgadget/git/pull/196
> I am still waiting for someone to comment "/allow johnlinp".

I've submitted the patch with the title
[PATCH 1/1] status: remove the empty line after hints
Please review if you are available. Thank you.

Best,
John Lin

>
> >
> > But again...
> >
> > >> At the same time, I think I've been happy enough with the current
> > >> output from both commands, so if you let me bikeshed freely, I'd
> > >> probably pick "let's not change anything then" ;-)
> >
