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
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EC21F461
	for <e@80x24.org>; Tue, 14 May 2019 09:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfENJn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:43:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43820 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENJn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:43:58 -0400
Received: by mail-io1-f66.google.com with SMTP id v7so12483079iob.10
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7+Nm6saba97/iaIgGHLXCmuwQKKDKiF2jXs+MWYOqU=;
        b=um2S3EX+Ypev/+O375s7Sy+hNmXrvEKmOyttKlf2dQrw60samez35Rj06LFLyTJ2bF
         MW8qoGinsTJ98Pk+h7SlRWA3QA6Qhhp4mj7j3A9oc0NNkML0OT6/P1gJkDhKZ5gAdsl/
         Zk2CqeE6H0yiOXdtjt+XdIaYENPBSnC7B5e6fotWcEY+Ey7HF7ms/N+HlMWUAOlB7dcs
         gJfrp1AVsumbvWP1YLDhL8cLNznMwBvviSmzDCKySy2n2ZuDORFwYiciDaVIKGCPR6/z
         86esu3S/9ngrFzsJu1hUlxNdrLwvQWP/Q6fmaCFUWWKp28dZPZYaL4KkMAbQwvRUZHe0
         ergg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7+Nm6saba97/iaIgGHLXCmuwQKKDKiF2jXs+MWYOqU=;
        b=NtWSlZ6Ur7J9sVC0/x3FdKre4H1AFCGE2OJlks+yWD9L2Zp1cgUMkPq16LrBdJZrZg
         5tejZmdwLCfbp6tpmgaeAA2vTzULY2Th4pngexVoy2OR/yit99WWgZxvpUpsfZ0fcsJk
         DH+0UlnvUqx4WPx9dMwtCcH7XUXRbEyB+RDH4AbpEGj0oCxnCSfd8dKiiIBHvk4XC4wl
         n55Y2j1PbSNYuLePnLMJtj+Dga4GbUIuapkfFrX84+mx3F1rcNJ3at6kb6Xvrfak2M5n
         AYQfUZ57CvzwUUK90QXG2OnQtVzhRXpFAl7fhHr96Fjv+BnEbBYoIrHz+uSo2ZnoLCnu
         +MXQ==
X-Gm-Message-State: APjAAAW+XJWJONk1+bIcXv97qjWLoZt4BqTk6uM+U5K0CdA87ZVaQae4
        pZwKAFfeoLm0+7FfqAk1KvjLddkbC5BaM3DqoLrCRr8aOY2lfg==
X-Google-Smtp-Source: APXvYqyF60t85nUQgaVgWU78t91Bwup7RgBK+9ryzVHyFOxHJMKBVKwEPCwTpoMG6nQKj4PRFPj/mOm3dJxG37PFmlY=
X-Received: by 2002:a6b:7b45:: with SMTP id m5mr3228382iop.126.1557827037469;
 Tue, 14 May 2019 02:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net> <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
 <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
 <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com> <20190514020416.GH7458@genre.crustytoothpaste.net>
 <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Tue, 14 May 2019 17:43:45 +0800
Message-ID: <CAKO26Msqj93hwKVduB0op=sMXs3egM2zvyfcJgpoqTWn4ywHHw@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On Mon, May 13, 2019 at 02:51:37PM +0900, Junio C Hamano wrote:
> >> If the difference between "status" and "commit" bothers you so much,
> >> i.e.
> >>
> >>     When typing "git status", there is an empty line between the
> >>     "Changes not staged for commit:" block and the list of changed
> >>     files. However, when typing "git commit" with no files added,
> >>     there are no empty lines between them.
> >>
> >> it may not be a bad idea to try making them consistent by removing
> >> the blank line that is given after the advice messages, perhaps?
> >
> > I personally think the extra blank line aids readability, especially on
> > screens with small text, but I'll defer to your decision on this.
>
> Heh, now we established that this is primarily of personal tastes,
> if you leave it up to me, my preference would be different from what
> was said in the thread so far.
>
>  - I do not mind having an extra blank line in the log message
>    editor session "git commit" gives me, primarily because at that
>    point I am in a full-screen editor that I can scroll up and down
>    at ease.

I was not talking about the messages in the editor session. I was
talking about "git commit" without "git add" anything.

For example:

```
$ touch newfile.txt
$ git commit
On branch master
Untracked files:
        newfile.txt

nothing added to commit but untracked files present
```

My current patch is trying to add an empty line between
"Untracked files:" and "newfile.txt".

>
>  - "git status" output, on the other hand, is shown in the context
>    where vertical screen real estate is more precious (I do not say
>    "git -p status"); I'd probably be happier without these empty
>    lines.
>
> But following the above two would mean that the result will still
> leave difference between the commands; the original justificaiton
> will not apply to such a change.

With my above clarification, I guess your two use cases will be the
same: the messages will appear on the console screen. That leads
to a conclusion: we should save vertical screen space. I am working
on a new patch to achieve that.

>
> At the same time, I think I've been happy enough with the current
> output from both commands, so if you let me bikeshed freely, I'd
> probably pick "let's not change anything then" ;-)

Best,
John Lin
