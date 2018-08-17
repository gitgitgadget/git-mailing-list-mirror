Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29291F954
	for <e@80x24.org>; Fri, 17 Aug 2018 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHQUna (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 16:43:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39522 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeHQUna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 16:43:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so6966535lji.6
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KmV7Pf+6ZZ4kgQr4zWJw7WANGwuzvF7FYNrwT3wS2Q4=;
        b=J4U1CVy/3Wsu4uiOZKvLKLtbMzoxMku1q1vCBME7gT37JCshtPmN9wcJSXCLqD8wBh
         9VlESKBQivFSDeq/YHxlpXTWXRl6yzsXpucEns+WPSZklJLCsDcn5pWgkj1gWxvEaE7F
         lRmFi+1jBQ1Anf6AXY9wWZFZc4jco6LDQclY0Gjj/yhV6l340kUF6nZIv8ZWQyh4SKfF
         CQWHvjATFS+lkkoiJlijvcN1c/4QDCX3ULc50pQ4J9ebCIZYfAwEzFSi19ZaWR8pSnHS
         KzNEfmKx4N0EvfOgQGiKrnuFr8QJVG00bPbz9AaF2h72jUMkRufw4XP538v2C+TaDs+r
         eM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KmV7Pf+6ZZ4kgQr4zWJw7WANGwuzvF7FYNrwT3wS2Q4=;
        b=iBtUjniXJHcwinowd9pUJQkdlL0zx0D5C0SVUhNO44EQ4zN+TKBG7arEonZ3BiKdw4
         MAJ1Mz2RzZfJUCmUtBHs1be/tpnqyBETyLsSbjFqtvSCwPjKgALIT1xZaN83zTxH4aTQ
         78ERzu6ZS90536mrxtUArYY5l9g4jD/OnV4m5vZK/VrWOUyNN/+7dK1B6rFpXwHorzrq
         /9y2YXh6SIpaF7aYC7V01nQu/kdkG7wbVVwsKkzbd468kHgye3Rx+kGSvIxE+0yVLH28
         CZsy8KNfFElkQs+PWruRAj6txLD4lmVCBXujjWHd4V49nsi+hY+17BW2zFFRpUKdHiIL
         0brg==
X-Gm-Message-State: AOUpUlHkrjSHSYlDZXY/AoHq11DP7uUIf+HcD+SJYgrRk/ApePVV01bp
        mLUS8cyFnxZDHX6SZ+9s8tutN0MlFB9HLh2+Xss=
X-Google-Smtp-Source: AA+uWPwXI4hzEnIjA/GxiVD0cJPw6dISg6wINpIrbX1852WETrp6Jf8Ibs7Pfi61UeRzqQ+JfFIF11P8KNGAJ/m6H40=
X-Received: by 2002:a2e:8617:: with SMTP id a23-v6mr26561851lji.43.1534527553323;
 Fri, 17 Aug 2018 10:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180814114721.25577-1-szeder.dev@gmail.com> <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 17 Aug 2018 19:39:01 +0200
Message-ID: <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rybak.a.v@gmail.com, Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 12:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>
> > On 14/08/18 13:47, SZEDER G=C3=A1bor wrote:
> >> ... both
> >> invocations produce empty 'pack{a,b}.objects' files, and the
> >> subsequent 'test_cmp' happily finds those two empty files identical.
> >
> > Is test_cmp ever used for empty files? Would it make sense for
> > test_cmp to issue warning when an empty file is being compared?
>
> Typically test_cmp is used to compare the actual output from a
> dubious command being tested with the expected output from a
> procedure that is known not to be broken (e.g. a run of 'echo', or a
> 'cat' of here-doc), so at least one side would not be empty.
>
> The test done here is an odd case---it compares output from two
> equally dubious processes that are being tested and sees if their
> results match.
>
> That said, since we have test_must_be_empty, we could forbid feeding
> empty files to test_cmp, after telling everybody that a test that
> expects an empty output must use test_must_be_empty.  I do not think
> it is a terrible idea.

I thought so as well, and I've looked into it; in fact this patch was
one of the skeletons that fell out of our test suite "while at it".
However, I had to change my mind about it, and now I don't think we
should go all the way and forbid that.

See, we have quite a few tests that extract repetitive common tasks
into helper functions, which sometimes includes preparing the expected
results and running 'test_cmp', e.g. something like this
(oversimplified) example:

  check_cmd () {
        git cmd $1 >actual &&
        echo "$2" >expect &&
        test_cmp expect actual
  }

  check_cmd --foo    FOO
  check_cmd --no-foo ""

Completely forbidding feeding empty files to 'test_cmp' would require
us to add a bit of logic to cases like this to call 'test_cmp' or
'test_must_be_empty' based on the content of the second parameter.
Arguably it's only a tiny bit of logic, as only a single if statement
is needed, but following our coding style it would take 7 lines
instead of only 2:

  if test -n "$2"
  then
        echo "$2" >expect &&
        test_cmp expect actual
  else
        test_must_be_empty actual
  fi

I don't think it's worth it in cases like this.
