Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A081F461
	for <e@80x24.org>; Sat, 22 Jun 2019 02:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFVCzN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 22:55:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39395 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVCzN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 22:55:13 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so556918iod.6
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VZDgq17c87K4ODo5gV4MROuMEz/nYTsKsQptT//nCQA=;
        b=KS6UizTplly9Ug3LO0qQnyhMFW4AxhqHW6r/akKk1iOdWZC3K6S8A7yJquayR5d3F6
         rLVt5/uDZ1zUn7opTA59BI0+ax+q3qMdEhEsPuXDlXHYpZBYIAGezB4olloOUAfWFtsw
         +wS3Eralrr85jWkTCXVU47FV/xfSDKT56XlHsHNUmFh5eDYt282j41C7XwuwEex7K9bG
         kcIWnIpSvnfv1tl7h96qLgYd59Skt6AeuVo9BJq6IM2Se+RytAVE8okyrD70t1xE+RSu
         lC2opblp4JE2nNpICxJ6L8ZCs1Bjj1WeNAjBfd61qE7i4OTwT21SfO9FZIuzXj8R5L08
         IO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=VZDgq17c87K4ODo5gV4MROuMEz/nYTsKsQptT//nCQA=;
        b=hdg4EQoCKaf4FqAcoJR3hrxrLpm/bTc0XSSgGWocaTwEespzf7PwP81mmtvrZMLnkU
         5tSIBoC3CwVjYbTlmeBk/HthkT2Im8d9edhCabAfYgGQKHMWo32k0GfSIAAOTwif1b0N
         ZZeliJy09cEgF91rS/mRa5H4jDQIC/5Tbdo8sX6pJXSynDZaVUttEyYs5kTfym+cGD9M
         jc3URXuKhpoU1QkUoX7TeMMAiPJasoIN6q/Pg1oVE672Eb7/SuK0H+1gHuzQH7G94JDT
         3kdJMK7dV23HB2SiROYIjfnb25i1sR69ayUipyRQgrcJFfK1FbBLVJtawD1iOzn2a7p0
         1UfA==
X-Gm-Message-State: APjAAAVPkHN8gacG8xfJ9MbyNK+JuxxvCij7SqAfoBY8LnuGr//8E46M
        /B97L0N50Z6jtqMHRUOayL6W57bFAuH+Lpr3Kq8=
X-Google-Smtp-Source: APXvYqzlNO/6i1LXCCgxnFqQz+8cuRwoTDS0D50VnFEmZZ4H/Sd95cfqST/SFg7CGpSWHjHsg/o/FWD1Bnhru+oKc+Q=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr3369432jaa.130.1561172112300;
 Fri, 21 Jun 2019 19:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190621233055.GB965782@genre.crustytoothpaste.net>
In-Reply-To: <20190621233055.GB965782@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 22 Jun 2019 09:54:45 +0700
Message-ID: <CACsJy8DX9QtG+3=0_H4sVOdNArXWcTapb7dfY53kGtLABRYOYQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 22, 2019 at 6:31 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-06-19 at 09:58:50, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrot=
e:
> > This is probably just my itch. Every time I have to do something with
> > the index, I need to add a little bit code here, a little bit there to
> > get a better "view" of the index.
> >
> > This solves it for me. It allows me to see pretty much everything in th=
e
> > index (except really low detail stuff like pathname compression). It's
> > readable by human, but also easy to parse if you need to do statistics
> > and stuff. You could even do a "diff" between two indexes.
> >
> > I'm not really sure if anybody else finds this useful. Because if not,
> > I guess there's not much point trying to merge it to git.git just for a
> > single user. Maintaining off tree is still a pain for me, but I think
> > I can manage it.
>
> I'm generally in favor of this, but we need to document what this does
> when it encounters paths that are not valid UTF-8. (Ideally, the answer
> is, "die()", but I suspect the answer will be "silently produce invalid
> output".)

I think you're right, we don't assume anything when writing json
strings, so it's not going to be utf-8 (or die) if the path is also
not valid utf-8. The good thing is all this could be done in just one
place, append_quoted_string(), if someone needs too. I'll just go
document the fact that we may produce invalid UTF-8.
--=20
Duy
