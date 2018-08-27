Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7211F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeH0VQ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:16:56 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43394 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0VQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:16:56 -0400
Received: by mail-lf1-f48.google.com with SMTP id h64-v6so11106106lfi.10
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=itqpnrluyzGqar+/KDqVsDBlEZj+ImwQsQU8Y2smG7k=;
        b=Jq1r6Lpz+B7Y/XucKRbGBX6FHGO7/ww7vnGkAXejdN9J+f3O1BTQRNKx4PMQzfgoUf
         nJxf1Va7/qjXKbJQwtx0GbzCVNbaZsvYjf/9I3ZRVYYoeaYX0vqzNn/Q5yePraUBveAQ
         /P45Nvg8IoCRfeGlx1vkfnplhIE3MLK1rAisNE0WZzemlO0nQq36Ppo1WsG79HKbre7/
         2qbyddIdJWg3z/Q2nFbWVtvqleZpphKR4jcjoVtJL2KsdRM8vDo0mTNPCidw0ZKAYCks
         q0/hxXvNVP0l5qVWoFpQnVRkuc+GBcqLBxU76EVKJzJJJFgp9jAEB2VM+7H1AcwZW7UG
         MnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=itqpnrluyzGqar+/KDqVsDBlEZj+ImwQsQU8Y2smG7k=;
        b=qMNUaGYTYxt2adxQDM+9txoqORVrVsjOz3NfHq5dSZoDN3h7SF7+kWY8JxMGFJJTfc
         R3g932n9HiPCxzgo5FpZyfIEx1RrxzMgM+FKGhaanx0xozaVEdtsRu1HzbTrLrI8R2rc
         ut9gwe1PzSSFjQWp0AFQ5VrEIuCa5Dpz7DhUQ28mmOQR7+N/meAjOBNMaKFcXIykU8K0
         wC6x20olM4XvFDDTWgQYa4Elm8+9br7LRNmb8/mst0kC5bd7eGkBaRY3u9CoRH2eXi3u
         XvAkb3a4ZY4vh9XCeUPKmilrHYwsSaDQA0iAz795IE8Z0ZBUHNe3QAtwvuykzpfEUONw
         +7dA==
X-Gm-Message-State: APzg51C4FSK7BK+i2ly7XxKG1EVWXsj+zbGslXQZ/iZEY2NAMn564LZK
        K/iPnraDY/PxtTsq5bNVOXr2gEJp7QcTWuswCCY=
X-Google-Smtp-Source: ANB0Vda8GImSwCbENZ7TIIqWTKL5WMy/nBwD7kjnmcBTwwvAebmojdNy2S+DwBo0S48ETsveXL9ZFnJa9+ASn+2Ci4U=
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr9478436lfb.9.1535390964346;
 Mon, 27 Aug 2018 10:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan> <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
In-Reply-To: <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 27 Aug 2018 12:29:12 -0500
X-Google-Sender-Auth: gvogh6TKN0bPr7WxXXWboEpTRok
Message-ID: <CAHd499AFUtW3=JNrmevdHRLgfK+QSdpkkSj0wsbRkhE8tqu-rA@mail.gmail.com>
Subject: Re: Automatic core.autocrlf?
To:     pclouds@gmail.com
Cc:     tboegi@web.de, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 10:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Aug 27, 2018 at 5:37 PM Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> > > In those cases, when it falls back to
> > > configuration for line ending management, I want it to be
> > > automatically configured based on the host platform.
> >
> > There is
> > git config core.eol native
>
> An alternative is supporting conditional config includes based on
> platform or host name, but I don't know if there are more use cases
> like this to justify it.

To Torsten's comment: Yes, I've looked at git-config. it doesn't have
the answer to my question there, hence I posted on the mailing list.
To your point, eol being native doesn't matter if text=3Dauto can't be
simulated. If there was a version of `autocrlf` that set `eol=3Dnative`
and `text=3Dauto`, that would work as well. But the `true` setting sets
`text=3Dauto` and `eol=3Dcrlf`.

Duy: There are more use cases I've run into, but they are not related to th=
e OP:

* Different user email between machines (work vs personal)
* Different tooling on platform (e.g. `nano` on Ubuntu, Notepad++ on Window=
s)

Centralizing .gitconfig, especially when you have tons of aliases,
becomes more important. 95% of my .gitconfig is platform-agnostic, if
there was an `#ifdef` mechanism, per your suggestion, this would allow
a lot more flexibility. Maybe I should have worded my OP more in terms
of platform-specific configuration sections, instead of specifically
about autocrlf, since that's just one symptom of the real problem.
