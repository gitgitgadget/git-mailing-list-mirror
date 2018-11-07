Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6E91F453
	for <e@80x24.org>; Wed,  7 Nov 2018 04:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbeKGOHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 09:07:10 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:34617 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKGOHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 09:07:10 -0500
Received: by mail-it1-f172.google.com with SMTP id t189-v6so12140557itf.1
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 20:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LTtvcwZRySpoyQikJcGQ4y0u4xAyWs0mmTP8g4n/1DQ=;
        b=uP9DSj8L884AOIEg0VF5E9kbwEq24yXsp/53l+oo/XKV6RWhaPXQRQW+zjzX8uww8h
         LU+7ZxaApbmEqhKd9BkbQthEWrLA1pcJaHZ1doRFBHaiD/Jbq1GawZVWaYnAumdpQIkl
         C5VV3Hfola6mEJlcryeWfRyjIdo7SMGp5xlrui5Ez0uQpqQCzmr6XbgpkpoStgJeUyh4
         v8FJF2FvoCupiK5Zug2N57/dhLmG8aft4VJt4ykbvelqcU2GIAEh//OaEJ2cmkGX3Dv0
         eRYe1rtMpupnX8UYjMz9RXYS5h1x9lr5A2XTYzlZlUX0AGFAhc5PRQFSqox2bZpQB5Ro
         h4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LTtvcwZRySpoyQikJcGQ4y0u4xAyWs0mmTP8g4n/1DQ=;
        b=KVwwu/0o/ieUSi2KF4IyaWl6AG410TRxTqGh+z+KzwncFYqpOaG6FX/h94S/gUO0xu
         eQKqYrBLkJIAD2KcVe9goiX9OeIUGZA0ZnhsF/LQNu27Sgt532Gr1zim2Jk8Sw92G4Dd
         A1PN1b/wuduPtHdRSNhw1h9tMxuJDXXnCkIkqYv15ixwsa2vhzgvVYqakM1kCS3i9D43
         B+TTH/YEK7/QmT6BZ/amyVQJynOtdiz0BrLc8Q/Pmpxc3YT10Yc4Vz9vYncAGeBF0xbb
         syLTepQp/R9rtnUG+VMXftMZjng9CekDlXCtBf+8K0HjwKWq0+2fNyczGsDPEFMk+Vvz
         yKjg==
X-Gm-Message-State: AGRZ1gK9sBzD2DjStirAcTcqT+oLa4cTLvvHzRDcNfJNi2sl9r1ZyFxN
        1E24E2SU19lNc28hILOxYL2JWt6KxfvZ4kPkflYvJBaG
X-Google-Smtp-Source: AJdET5dNMGnL5/wAgWJY6LuqUywG6l+7UUr1X8To+O80CPT5ZuxueIxciJ/SuxvaAdwpIgJCUZD9VHvYpBfWq2TvZtA=
X-Received: by 2002:a24:cec6:: with SMTP id v189-v6mr656260itg.125.1541565509395;
 Tue, 06 Nov 2018 20:38:29 -0800 (PST)
MIME-Version: 1.0
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan> <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
 <20181105181014.GA30777@tor.lan> <20181106201618.GA30158@tor.lan>
In-Reply-To: <20181106201618.GA30158@tor.lan>
From:   =?UTF-8?Q?Adri=C3=A1n_Gimeno_Balaguer?= <adrigibal@gmail.com>
Date:   Wed, 7 Nov 2018 05:38:18 +0100
Message-ID: <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com>
Subject: Re: git-rebase is ignoring working-tree-encoding
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Torsten,

Thanks for answering.

Answering to your question, I removed the comments with "rebase" since
my reported encoding issue happens on more simpler operations
(described in the PR), and the problem is not directly related to
rebasing, so I considered it better in order to avoid unrelated
confusions.

Let's get back to the problem. Each system has a default endianness.
Also, in .gitattributes's working-tree-encoding, Git behaves
differently depending on the attribute's value and the contents of the
referenced entry file. When I put the value "UTF-16", then the file
must have a BOM, or Git complains. Otherwise, if I put the value
"UTF-16BE" or "UTF-16LE", then Git prohibites operations if file has a
BOM for that main encoding (UTF-16 here), which can be relate to any
endianness.

My very initial goal was, given a UTF-16LE file, to be able to view
human-readable diffs whenever I make a change on it (and yes, it must
be Little Endian). Plus, this file had a BOM. Now, what are the
options with Git currently (consider only working-tree-encoding)? If I
put working-tree-encoding=3DUTF-16, then I could view readable diffs and
commit the file, but here is the main problem: Git looses information
about what initial endianness the file had, therefore, after
staging/committing it re-encodes the file from UTF-8 (as stored
internally) to UTF-16 and the default system endianness. In my case it
did to Big Endian, thus affecting the project's requirement. That is
why I ended up writing a fixup script to change the encoding back to
UTF-16LE.

On the other hand, once I set working-tree-encoding=3DUTF-16LE, then Git
prohibited me from committing the file and even viewing human-readable
diffs (the output simply tells it's a binary file). In this sense, the
internal location of these  errors is within the function of utf8.c I
made changes to in the PR. I hope I was clearer!

Finally, Git behaviour around this is based on Unicode standards,
which is why I acknowledged that my changes violated them after
refering to a link which is present in the ut8.h file.
El mar., 6 nov. 2018 a las 21:16, Torsten B=C3=B6gershausen
(<tboegi@web.de>) escribi=C3=B3:
>
> On Mon, Nov 05, 2018 at 07:10:14PM +0100, Torsten B=C3=B6gershausen wrote=
:
> > On Mon, Nov 05, 2018 at 05:24:39AM +0100, Adri=C3=A1n Gimeno Balaguer w=
rote:
> >
> > []
> >
> > > https://github.com/git/git/pull/550
> >
> > []
> >
> > > This is covered in the mentioned PR above. Thanks for feedback.
> >
> > Thanks for the code,
> > I will have a look (the next days)
> >
> > >
> > > --
> > > Adri=C3=A1n
>
> Hej Adri=C3=A1n,
>
> I still didn't manage to fully understand your problem.
> I tried to convert your test into my understanding,
> It can be fetched here (or copied from this message, see below)
>
> https://github.com/tboegi/git/tree/tb.181106_UTF16LE_commit
>
> The commit of an empty file seems to work for me, in the initial
> report a "rebase" was mentioned, which is not in the TC ?
>
> Is the following what you intended to test ?
>
> #!/bin/sh
> test_description=3D'UTF-16 LE/BE file encoding using working-tree-encodin=
g'
>
>
> . ./test-lib.sh
>
> # We specify the UTF-16LE BOM manually, to not depend on programs such as=
 iconv.
> utf16leBOM=3D$(printf '\377\376')
>
> test_expect_success 'Stage empty UTF-16LE file as binary' '
>         >empty_0.txt &&
>         echo "empty_0.txt binary" >>.gitattributes &&
>         git add empty_0.txt
> '
>
>
> test_expect_success 'Stage empty file with enc=3DUTF.16BL' '
>         >utf16le_0.txt &&
>         echo "utf16le_0.txt text working-tree-encoding=3DUTF-16BE" >>.git=
attributes &&
>         git add utf16le_0.txt
> '
>
>
> test_expect_success 'Create and stage UTF-16LE file with only BOM' '
>         printf "$utf16leBOM" >utf16le_1.txt &&
>         echo "utf16le_1.txt text working-tree-encoding=3DUTF-16" >>.gitat=
tributes &&
>         git add utf16le_1.txt
> '
>
> test_expect_success 'Dont stage UTF-16LE file with only BOM with enc=3DUT=
F.16BE' '
>         printf "$utf16leBOM" >utf16le_2.txt &&
>         echo "utf16le_2.txt text working-tree-encoding=3DUTF-16BE" >>.git=
attributes &&
>         test_must_fail git add utf16le_2.txt
> '
>
> test_expect_success 'commit all files' '
>         test_tick &&
>         git commit -m "Commit all 3 files"
> '
>
> test_expect_success 'All commited files have the same sha' '
>         git ls-files -s --eol >tmp1 &&
>         sed -e "s!      i/none.*!!" <tmp1 | uniq -u >actual &&
>         >expect &&
>         test_cmp expect actual
> '
>
> test_done



--=20
Adri=C3=A1n
