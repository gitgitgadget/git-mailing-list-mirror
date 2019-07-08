Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476441F461
	for <e@80x24.org>; Mon,  8 Jul 2019 22:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGHWaf (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 18:30:35 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:40960 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfGHWaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 18:30:35 -0400
Received: by mail-io1-f53.google.com with SMTP id j5so19556955ioj.8
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWcavhb85PYdg3CyEtQWMJdMpRe9bJXybjexc1rysV0=;
        b=KpvBRaGYv5e1adOfuzUMTAr7CMu88akS1wcidcQBIdMWUI2aTl/P4S3znhN9U+coHV
         QbrmI1dAZQwCcW+3yHtO04DvE1fj+4SUPPfRTkPUznjPaBEvXa8Xa5z6iWbeJUwljaYs
         CrKEy1WXzizuYpS4/lPmgsDRysayiotLugUzJZiEWHjXQIiwmwpwwAIwo49IsOW6Sk61
         3hA5YFZe4LxZ9UuIm73Btq1xWsToKkBRc25IQAfwhcZ42Y1nUssedyEPmooTYk5ZWKt3
         BcW9ASeVjom/N/nAZ3APHXxZB63ejm7YBvlHKAcPI64yeUgrvW/WfWxgPB2DSXY5Vku5
         qzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWcavhb85PYdg3CyEtQWMJdMpRe9bJXybjexc1rysV0=;
        b=ltKqbRGvVM3dEUguNG/1Q263KVdch52KsJKQIoBxxBmbr1805IhEmS3d/E29KdOE+s
         0I98NCr9qDlHVT35oe5zkfWEqfx+23WerFT8qQXrp+ZQTm1r4/nLa0d6QSvKCbCSLVUh
         lZGfGE3p6J9N4L0G4yyts0v7YvY0loFUVa/yqHPnqtD/94WqNJv88wf7IsPEuW2fkcS1
         hKNR88suO9d9FMdMNdDSN0uqmqSOSPvNzM4DDMv1Lg1ycC/oRM8yx/ptNi5jzMfoS11X
         g+iFwMvpnBZpEBLFODxOIhlZLVeZCJ47gEtTq0ci7llErtnR2Nbg3OLLEHOdFIsX+jVD
         /qnQ==
X-Gm-Message-State: APjAAAXPtQPyqTSkoEZD4wp9XhWkFA1ek2eORYgsVJ5V9WY7KJnCHAYL
        OgXPvxzgcHpKncOOv25cVBZtg7VETSnBSfYpd8c8lQ==
X-Google-Smtp-Source: APXvYqzBORL+gLxR0Sv88HJnujreOsBZrx3BeyaM1mLHMd5gPW+0RUJigOOsQn2gAYJHf8ZAaJ7GvVGqVDZ6JQDdGqg=
X-Received: by 2002:a02:c646:: with SMTP id k6mr14160301jan.134.1562625033170;
 Mon, 08 Jul 2019 15:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet>
 <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907042308200.44@tvgsbejvaqbjf.bet> <CAHd-oW6PTFY=_j1RDh8_MdeBmMX77kF+=kOpd-GUnbegMC89yQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907052009590.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907052009590.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Jul 2019 19:30:22 -0300
Message-ID: <CAHd-oW4AMn4UABfzeVcJSNM8AxxDTw5d8=HUTZnXRMwSxgqREQ@mail.gmail.com>
Subject: Re: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 5, 2019 at 3:17 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Fri, 5 Jul 2019, Matheus Tavares Bernardino wrote:
> >
> > So, should I send a fixup patch removing find_recursive_symlinks() or
> > reroll the series? There's also the option to use stat()+lstat() to
> > reduce calls to this function, but it doesn't solve the problem on
> > Windows, anyway.
>
> I would suggest to send another iteration that removes
> `find_recursive_symlinks()`. Junio most likely interpreted my objections
> as a veto against advancing the current iteration to `next`, meaning that
> you're good to even rewrite completely in the next iteration, should you
> feel the need to. No need for "Oops, fix that" follow-up commits at this
> stage.

OK, thanks! I'll send a v8, then, removing the circular symlink section, ASAP.

> Ciao,
> Dscho

Best,
Matheus
