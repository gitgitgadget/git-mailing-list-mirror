Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9521F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBAHYA (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:24:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43722 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfBAHX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:23:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so6350931qtj.10
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 23:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tLE3UNJBmitZJ/pY6a6p6+HCPmvLWBYTQ22CWmDqiDs=;
        b=Mm5OXyqU8AIJX2rWL48JitvgOz7xpqrkbrcTXOqmGI3ma1stmXqa0kn57xPV2o7evg
         JPxWxxk/U/iuAceafgJs09DDSJe7PULe5gpademA/7GY7E8p4ssT2KfJ9PpRfshWiZdf
         pukK6N33v0vYqcSPTTvwYAWNJ9OtADd1OeyX4PMIgOde32L2WJl9n5MHJjJmVvXA9dxv
         OyQQPO3XTf6K3jBi+5jdJ2GRdzOmdHFGVmtq7YKb/nNAXtMSgbltQoXD1U8b1wt3DiNK
         tQZ2vZ2dirP84eXuTlqVqBkHgmxFs6t4ioY9P1CDOopoT91OucQQG1rC4XfdKhonhw5P
         9dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tLE3UNJBmitZJ/pY6a6p6+HCPmvLWBYTQ22CWmDqiDs=;
        b=bijqlY70aDdV8mwuE9OOeapm7bdtgUnfVDM1tPnldakPVhVD6ycgsdqXbpRIeS2kOO
         ZjzAndpMMhf+RfoWjE11rOxtIBa8GZj8TWgjFrQeJ3wX3iXNqsQidmJQe0oXv/xUKTIo
         kKInAEkGU5oZDmLB73n5qFKVsMGRrxUyIcw7P6bGjQtG1qQIUYTbQW93Lpsc3eSqbt0K
         kcKVz02cfDWTAZ0GDKdB1aivI3tAIx0g1zp1LRbEl6Q3w08/JsD2Js+lEMy6Nu4R5HBp
         +GjTa84/9hhMPhJN5Mgt6qcYtAs6GJNJoZUEw1fv5t3dl7rueMy6kOCMNxPFSewUqqNs
         l/dQ==
X-Gm-Message-State: AJcUukdGNNpWkO71zWLinA4gcALe/2TXZL0f/iFGUOMNc5P9znRO8kI3
        jUHOCzBEHrt3OW/kI4nEr+gMJyqTv+S48tC2T08=
X-Google-Smtp-Source: ALg8bN4HgYh7JjW1ezINjdaxRh9eG1WpRI9L3aLeD03ib1TkYlPDro10Uwj42mNhoeR7xXurrKsOuO9ymieMP647/oE=
X-Received: by 2002:a0c:d80f:: with SMTP id h15mr36131145qvj.228.1549005838137;
 Thu, 31 Jan 2019 23:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-2-worldhello.net@gmail.com> <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
 <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com> <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com>
In-Reply-To: <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Feb 2019 15:23:46 +0800
Message-ID: <CANYiYbHK9Qozqzpnwu3y9Gq=ieMPUgXfZxr8Ofxwe6mJox9Ohg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:11=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Fri, Feb 1, 2019 at 12:44 AM Jiang Xin <worldhello.net@gmail.com> wrot=
e:
> >> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:44=E5=86=99=E9=81=93=EF=BC=
=9A
> > > Move this outside loop, not for efficiency but for clarity. This
> > > helper function creates a single empty tree and bunch of commits
> > > that hold the same empty tree, arranged as a single strand of
> > > pearls.
> >
> > Will rewrite as:
> >
> >     create_commits () {
> >             parent=3D
> >             T=3D$(git write-tree) &&
> >             for name in A B C D E F G H I J K L M N O P Q R
>
> Don't forget the && at the end of the 'parent=3D' line to protect
> against someone later adding code above that line. So:
>
>     create_commits () {
>         parent=3D &&
>         T=3D$(git write-tree) &&
>         ...

Will do.

> > Nice chart, will edit test_description as follows:
> >
> >     test_description=3D'git pack-redundant test
> >
> >     In order to test git-pack-redundant, we will create a number of
> > redundant
> >     packs in the repository `master.git`. The relationship between
> > packs (P1-P8)
> >     and objects (T,A-R) is show in the following chart:
> >
> >            | T A B C D E F G H I J K L M N O P Q R
> >         ---+--------------------------------------
> >         P1 | x x x x x x x                       x
> >         P2 |     x x x x   x x x
> >         P3 |             x     x x x x x
> >         P4 |                     x x x x     x
> >         P5 |               x x           x x
> >         P6 |                             x x   x
> >         P7 |                                 x x
> >         P8 |   x
>
> test_description should be a meaningful one-liner; it should not
> contain this other information, but this information should appear as
> comments in the test script.

In 't/t0000-basic.sh', there is also a very long test_description.
After read 't/test-lib.sh', the only usage of test_description
is showing it as help, when runing:

    sh ./t0000-basic.sh

So write a long test_description is ok, I think.

> >     Another repoisitory `shared.git` has unique objects (X-Z), while
> > share others
>
> s/repoisitory/repository/

Thanks, will fix.

> > > > +test_expect_success 'setup master.git' '
> > > > +     git init --bare master.git &&
> > > > +     cd master.git &&
> > > > +     create_commits
> > > > +'
> > >
> > > Everything below will be done inside master.git?  Avoid cd'ing
> > > around in random places in the test script, as a failure in any of
> > > the steps that does cd would start later tests in an unexpected
> > > place, if you can.
> >
> > The first 10 test cases will run inside master.git, and others will
> > run inside shared.git.  Only run cd inside the two `setup` test cases.
>
> That's not what Junio meant. It's okay for tests to 'cd', but each
> test which does so _must_ ensure that the 'cd' is undone at the end of
> the test, even if the test fails. The correct way to do this within
> each test is by using 'cd' in a subhsell, like this:
>
>     test_expect_success 'setup master.git' '
>         git init --bare master.git &&
>         (
>             cd master.git &&
>             create_commits
>         )
>     '
>
> Then, each test which needs to use "master.git" would 'cd' itself, like t=
his:
>
>     test_expect_success 'some test' '
>         (
>             cd master.git &&
>             ...
>         )
>     '

Nice explaination, will do.

> > > > +test_expect_success 'setup shared.git' '
> > > > +     cd "$TRASH_DIRECTORY" &&
> > > > +     git clone -q --mirror master.git shared.git &&
> > >
> > > Why "-q"?
> >
> > To make verbose output cleaner.
>
> What Junio really meant by asking that question was that you should
> not do this. When something goes wrong with a test, we want as much
> output as possible to help diagnose the problem, so suppressing output
> is undesirable. To summarize, don't use -q, --no-progress, or any
> other such option and don't redirect to /dev/null.

Thanks.
