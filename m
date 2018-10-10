Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29F01F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJUFD (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:05:03 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:34296 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJUFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:05:03 -0400
Received: by mail-qt1-f174.google.com with SMTP id o17-v6so5421969qtr.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S87/ubb9MwSqsZKl+AFNRq8ZOQLla4MK26u7ibS5mxo=;
        b=rbgiJSPi5yRYgJfhJddIoYI4WVaR9FeZPuIOTXx0gfQ8ab4ZjLcNMD6OyDModhQpuy
         23NPAKc3ZMLVqYehHYt4Bc4ee1oR08CJJzaDOOvQ5k7QGStAoDiJegovIjR+mtzsEAhS
         mMplDo42niati1PZzSwYGkEjch2Sk99MjQh1CMNXk9bBpPcGt4FTfYF3/Cne8XYgw5aG
         +SB6CcOV9rii9YscntfzOSpz9cxlqQH3EXZ8qsDEV0zwRE5HLZZcLaNQNwZgpzHEhjy6
         nsnH4wkq7/2Huf/roZIGUeEzwM+4R0H3gEXKHla5FbYU2D8py5VMA7P512r13qYKB7Pa
         nMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S87/ubb9MwSqsZKl+AFNRq8ZOQLla4MK26u7ibS5mxo=;
        b=PEEEWa1JVsSwex2XD4WmbVP4vyZ0Qq28ZDuqa3YCYpxw7Nke3kPyVCe8HNWNO1ZAXU
         N+bnHbBM84ZLRT3UwI91Cr7N6g5GbOFQX8VDF5NeWn4dCn0atVV69RKVu0JECLs+vtCW
         7/ewCJXzjJmqgbmFLg0xahoDKS7S+BiyfxJ1ka4wsqLsILWd8RpPwb45z+ZwSkrq+oPx
         c6xGqt7RFkuOt19JAtdlX9pCiUt5SVC5NOoJaIdpVhWlvIEZPqjLtjlKTMwJ/xE+ayHA
         ltseDMm9exrmGEAzPlKfRZcev6vyrocwf1k6UMgoRdFD5Dv8eSjwOAVAZ83PCH+zn9Co
         M6fA==
X-Gm-Message-State: ABuFfohDRy9dCR7Pl0Ls1uA3h5Sj49WUqsL0p1ngHH0hTnjTQLXNqBfe
        3Di0vE/+4uLpoPUaPaO7XMnsBFXFLnIDYNY/qKg=
X-Google-Smtp-Source: ACcGV60fbrcBpK69zs47ztv2WIKsinFn9GXr3SLI9uqyrYlToJQ265007N9+bo7twLMRq5djI9KDsiVgERhP3urcxiI=
X-Received: by 2002:a0c:f9ce:: with SMTP id j14-v6mr26541761qvo.177.1539175382459;
 Wed, 10 Oct 2018 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
 <87bm82fcmm.fsf@evledraar.gmail.com> <87a7nmf9zj.fsf@evledraar.gmail.com> <CAOO0rQ+3BPydQUaY67REd3-W9co-92DYa=TAUaGurN+QQUvSwg@mail.gmail.com>
In-Reply-To: <CAOO0rQ+3BPydQUaY67REd3-W9co-92DYa=TAUaGurN+QQUvSwg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 Oct 2018 14:42:50 +0200
Message-ID: <CACBZZX5OvhzYS9SteA-PAqDA_WCDy-hfJmXJG8w5+brQfa8RyQ@mail.gmail.com>
Subject: Re: Translation to Portuguese
To:     Thiago Saife <tsaiferodrigues@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 2:41 PM Thiago Saife <tsaiferodrigues@gmail.com> wr=
ote:
>
> Hi Avar.
>
> What it means? I should not continue the translation? Because
> Brazilian Portuguese states as Translations started for, but it's not
> finished yet.

I misunderstood and thought you meant the translation of the git program it=
self.

I don't know what book you mean or how it's translated, sorry.

> On Wed, Oct 10, 2018 at 6:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Wed, Oct 10 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > > On Mon, Oct 08 2018, Thiago Saife wrote:
> > >
> > >> Hello Git Team.
> > >>
> > >> I would like to help to continue the books' translation to Brazilian
> > >> Portuguese and I don't know how to proceed. Thanks in advance for yo=
ur
> > >> help.
> > >
> > > That would be great. Have you seen
> > > https://github.com/git/git/blob/master/po/README ? It describes how t=
o
> > > create a new language. Also CC-ing the l10n coordinator, Jiang.
> >
> > It has been pointed out to me off-list (thanks) that I missed the part
> > where you mention a 'book', and we already have a Portugese translation
> > of Git. Sorry!
>
>
>
> --
> Thiago Saife
> (11) 97236-8742
