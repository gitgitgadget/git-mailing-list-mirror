Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFC61F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfKNGk3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:40:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33926 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNGk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:40:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so3484290pff.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 22:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s9h+aix018qrtLiXiInfJdIKaiQuWK8pIFUAJYiq8hk=;
        b=YT1ab8BPXpCGSBDlboPPv7d1GV5VUC4sWOKcOOd274fVo02kga8Ppgi5NJrLZseGMK
         +5pMyXYCP5iyvnzcK5EaHz2tt1V5IjcSOj+3TnluZHv4a7XProakfq9vNP6fon4iRZnJ
         uE4/Cdtn4uedXuJXFmFklJ7H1FKWCWXX1Mzyw0hskc9cgnx796ByDVO/ZieApiZCljZe
         iuqQQ56bIDfrqM+dad0drNlHyadGjLT8oxuJZ9WSuXQ1AaeGKgkYBHzHTNPb7yXr89Mv
         lG+d9PKpTb+mirUx2h3vvnkEBiH1iURoIwRZbG+44BasJpefH1YVlKZhJuqqzeLQCTji
         jwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s9h+aix018qrtLiXiInfJdIKaiQuWK8pIFUAJYiq8hk=;
        b=S+jT/qyIqoK2o9Y3aP9djFEFZ+eTPvrX5jpwXn6XAqkAHqlahIl0RbeeqwJxnGBRPi
         spLb3ROuTIn+m7JUvhk/tNxpbOK2GT9xjER2yKniknfQ92OSBW9sTMrSZRXyUEYaz3cR
         zYk38EuikpC4HWMNI05RoYbBlr5qqmd+7IZbRgfSrrKhHBUY0caZMB72aEXAJk8MA03W
         I63v0DQi/aoBvjhuepKZ5mzQNOW0E9tS2tcTEBUNZuUcjLmw2y1wbqnuwOKg7GTP7h8t
         MAcH0pHPfSHpayAey9Vz8kMQToefEVKJCB5RQu4VS3UyTz/q28kgT/haF0Ryp/QHm69A
         dK3A==
X-Gm-Message-State: APjAAAUbgzUKC50Iqe9XoUPzDmK29kocqAyTEhzSgpjvOMyYlmhty/IQ
        /pm2fVw+1GzGA4hos6fOcD+0lgI4Hr9dMwkhRcg=
X-Google-Smtp-Source: APXvYqz7ifRVnVq/Txcpx/mYN7e6NDojm8Bc+k/aInPM5QHgAzWqNmT+NRbcGh/Hte9WohPiJp+Drw9rfn7qUEAey+8=
X-Received: by 2002:aa7:918e:: with SMTP id x14mr8768837pfa.12.1573713628567;
 Wed, 13 Nov 2019 22:40:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573670565.git.martin.agren@gmail.com> <xmqqeeyb9p4i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeeyb9p4i.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 14 Nov 2019 07:40:16 +0100
Message-ID: <CAN0heSrTtEHM7bEGMbokf1RJDGPobD=C73Wq1Ry5fgE69+QV-g@mail.gmail.com>
Subject: Re: [PATCH 0/8] builtin/config: canonicalize "value_regex" with `--type=bool[-or-int]`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Thu, 14 Nov 2019 at 03:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > `--type=3Dbool-or-int` gets the same treatment, except we need to to be
> > able to handle the ints and regexes matching particular ints that we
> > must expect.
>
> Hmm, so I can say 1024k or 1m and that would match 1048576?
>
> Doubly nice.
>
> Looking forward to reading it thru.

Maybe you already noticed, but no, I didn't get to canonicalizing
integers like that. What I meant was, type=3Dbool-or-int learns to handle
booleans similar to what I did to type=3Dbool.

I don't feel entirely satisfied by some of my commit message oneliners.
They could make that a bit clearer, I think.

Not directly related to your question, but I realize now that with
type=3Dbool-or-int, I only added the first of these example usages below
as a test. The second one is perhaps just as interesting.

$ ./git -c an.int=3D1 config --get --type=3Dbool-or-int an.int 1
1
$ ./git -c an.int=3D1 config --get --type=3Dbool-or-int an.int on
1

This last one emits "1". That's because by the time we've decided to
output the value, `format_config()` has some logic around
type=3Dbool-or-int, but doesn't know about why exactly we selected this
an.int=3D1 in the first place
  (git_parse_maybe_bool("1") =3D=3D git_parse_maybe_bool_TEXT("on")).

Just after thinking about this for a short while, I can't immediately
say whether this second one should emit "1" or "true". My added
documentation is actually vague enough to allow both of these to
happen... I'll ponder this.


Martin
