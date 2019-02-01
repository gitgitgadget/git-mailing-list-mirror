Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7071F453
	for <e@80x24.org>; Fri,  1 Feb 2019 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfBAFoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 00:44:30 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:34012 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfBAFoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 00:44:30 -0500
Received: by mail-qt1-f181.google.com with SMTP id r14so6278074qtp.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCBGan4fBo+oZqD0fbnZwKjUM1Su3XtHoLCYiORLhuo=;
        b=pZDwfsss16ferQ9SpF/Ct1wqA1VDNAQObcurd1CwePi4IWKjdzUIjR8lNXEIkVRTiv
         t0ElvVtaI4dic9/ueNE+Yrx2AnNNRTq+uanYmxiDYsnLiMr1u+lTe2mBoOBt1SGjz/Hn
         hXcFruOtVbmRJDKy2HVZH5UJVFoTHPlHASRt5o+xNbRcJmgEcaNpt1nkzjHbrfRBCA+f
         PILu7ebxddxEFU4owslLrxuhLAO/NiaTgP6ZqeSjT6ULLZMakqCG99IoiCieDhOUEuWS
         mQSWn4x7n3Mc4ijuUnZpDZ6HY4ZzX5pcjszGHlfYE9iZuG4huHhEoW4IP7H55VmcQd7Q
         I0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCBGan4fBo+oZqD0fbnZwKjUM1Su3XtHoLCYiORLhuo=;
        b=Icxd4dcXTnFAKNGl2CTkTHNATakbwTVaZU2FOH/D/vnvXowfyf4ckHpmbrPk/vQEju
         HU8WHqdKs4ZKLLUGB7iRn5hfvao/f7ucsp5+BDilkc4IHrUAIxoWu4nUyfGrCRtvsfzX
         PGIe3Igkzusa6ah1NtC/1PBz5oUqA7AQuj/5oVuOT6eMRrgvWA5KqEmcHTg0m/Y4rvu+
         QeVslZENqZhuvmFjo7/oMq4QXsNXw9DpIOO7t/oRR4etVhMczMSI5PfFehmnRTKGpvJW
         ojNkcQoNZeC660VJ4M8BIULsbVmAxnxGN0cxvbDnCuH+j6IRh/DXkBFiEF5CpDxKUrxB
         9w/A==
X-Gm-Message-State: AJcUukeeyWGLI/HTcBYO0/U9hSNkGD2KkhvqgrC9tIKDJEyxAzDvC3JV
        TEK2LuRYdZU7TLTo/36Mm5nMOQOxG1uD9ycA+kw=
X-Google-Smtp-Source: ALg8bN7yvj7XzfMFnjOLwAMhyQJ2OkPEJlYezLkiyLBoDHE0K5AuR08UTFl3jZRQEB2HtwhgzTTdB5B3NOkRnYgy3Vk=
X-Received: by 2002:aed:3746:: with SMTP id i64mr36407781qtb.307.1548999868388;
 Thu, 31 Jan 2019 21:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-2-worldhello.net@gmail.com> <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Feb 2019 13:44:16 +0800
Message-ID: <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:44=E5=86=99=E9=81=93=EF=BC=9A
> > +create_commits () {
> > +     parent=3D
> > +     for name in A B C D E F G H I J K L M N O P Q R
> > +     do
> > +             test_tick &&
> > +             T=3D$(git write-tree) &&
>
> Move this outside loop, not for efficiency but for clarity. This
> helper function creates a single empty tree and bunch of commits
> that hold the same empty tree, arranged as a single strand of
> pearls.

Will rewrite as:

    create_commits () {
            parent=3D
            T=3D$(git write-tree) &&
            for name in A B C D E F G H I J K L M N O P Q R

>
> By the way, I had to draw a table like this to figure out ...
>
>      T A B C D E F G H I J K L M N O P Q R
> 1    x x x x x x x                       x
> 2        x x x x   x x x
> 3                x     x x x x x
> 4                        x x x x     x
> 5                  x x           x x
> 6                                x x   x
> 7                                    x x
> 8      x
>
> ... what is going on.  Perhaps something like this would help other
> readers near the top of the file (or in test_description)?

Nice chart, will edit test_description as follows:

    test_description=3D'git pack-redundant test

    In order to test git-pack-redundant, we will create a number of
redundant
    packs in the repository `master.git`. The relationship between
packs (P1-P8)
    and objects (T,A-R) is show in the following chart:

           | T A B C D E F G H I J K L M N O P Q R
        ---+--------------------------------------
        P1 | x x x x x x x                       x
        P2 |     x x x x   x x x
        P3 |             x     x x x x x
        P4 |                     x x x x     x
        P5 |               x x           x x
        P6 |                             x x   x
        P7 |                                 x x
        P8 |   x

    Another repoisitory `shared.git` has unique objects (X-Z), while
share others
    objects through alt-odb (of `master.git`).  The relationship
between packs
    and objects is as follows:

           | T A B C D E F G H I J K L M N O P Q R   X Y Z
        ---+----------------------------------------------
        Px1|   x x x                                 x x x
        Px2|         x x x                           x x x
    '

>
>
> > +format_packfiles () {
> > +     sed \
> > +             -e "s#.*/pack-\(.*\)\.idx#\1#" \
> > +             -e "s#.*/pack-\(.*\)\.pack#\1#" |
> > +     sort -u |
> > +     while read p
> > +     do
> > +             if test -z "$(eval echo \${P$p})"
> > +             then
> > +                     echo $p
>
> All the "expected output" below will expect P$n:${P$n} prepared by
> various create_pack_$n helpers we saw earlier, so an unknown
> packfile would be detected as a line that this emits.  Is that the
> idea?

Right.  During the reroll, a typo makes an empty output, so I decide
to make this change.


> > +             else
> > +                     eval echo "\${P$p}"
> > +             fi
> > +     done |
> > +     sort
> > +}
> > +
> > +test_expect_success 'setup master.git' '
> > +     git init --bare master.git &&
> > +     cd master.git &&
> > +     create_commits
> > +'
>
> Everything below will be done inside master.git?  Avoid cd'ing
> around in random places in the test script, as a failure in any of
> the steps that does cd would start later tests in an unexpected
> place, if you can.

The first 10 test cases will run inside master.git, and others will
run inside shared.git.  Only run cd inside the two `setup` test cases.

> > +cat >expected <<EOF
> > +P2:$P2
> > +EOF
> > +
> > +test_expect_success 'one of pack-2/pack-3 is redundant' '
> > +     git pack-redundant --all >out &&
> > +     format_packfiles <out >actual &&
> > +     test_cmp expected actual
> > +'
>
> Do the preparation of file "expect" (most of the tests compare
> 'expect' vs 'actual', not 'expected') _inside_ the next test that
> uses it.  i.e.
>
>         test_expect_success 'with 1 4 and 5, either 2 or 3 can be omitted=
' '
>                 cat >expect <<-EOF &&
>                 P2:$P2
>                 EOF
>                 git pack-redundant --all >out &&
>                 format ... >actual &&
>                 test_cmp expect actual
>         '

Will do.

> > +test_expect_success 'setup shared.git' '
> > +     cd "$TRASH_DIRECTORY" &&
> > +     git clone -q --mirror master.git shared.git &&
>
> Why "-q"?

To make verbose output cleaner.

> > +     cd shared.git &&
> > +     printf "../../master.git/objects" >objects/info/alternates
> > +'
>
> Why not echo?  I recall designing the alternates file to be a plain
> text file.  Is it necessary to leave the line incomplete?

Forgot "\n", will append.

>
> > +test_expect_success 'remove redundant packs by alt-odb, no packs left'=
 '
> > +     git pack-redundant --all --alt-odb | xargs rm &&
> > +     git fsck --no-progress &&
>
> Why "--no-progress"?

To make verbose output cleaner.

>
> > +     test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
> > +     test_cmp expected actual
> > +'
> > +
> > +create_commits_others () {
> > +     parent=3D$(git rev-parse HEAD)

Will append "&&".
