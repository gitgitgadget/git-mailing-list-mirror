Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF9020248
	for <e@80x24.org>; Mon,  1 Apr 2019 12:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfDAM67 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 08:58:59 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38635 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDAM66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 08:58:58 -0400
Received: by mail-oi1-f173.google.com with SMTP id a6so3754260oie.5
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au4NbmUqS7NQKoNC7OISlthUVm2xAvufwqHGTfveV8o=;
        b=MRhnn9xGHJcJBywpnOKMk8dqoLOUEV4o9uac3NJWGn55p1ZbBGmvqpfnNLeQV4gGNX
         F1CgTqO6VFALP26EGquz9eFF9ytDdmGcCg4MkVajtQRwiF6xkIuOwFEvtiELDXRD65pk
         QkRIAxBZqM703INa0zDkmEjInCxY4ykC0uNu63oZSxg1aiPfmcvo8TRxE4oyWqEGG9/r
         64eZjjJYvcbedDP67Hdi9UY3+OgR2+h9UtJARZkcuTS+33FCTGvFnvoGSHiQK52Jf9G9
         WOq5LAH4JhFKqL4ZZc7DbOxdJxI+l32x2qTpaIf9jG28TPkAom/kjh9HL2bEihnlyEaL
         f1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au4NbmUqS7NQKoNC7OISlthUVm2xAvufwqHGTfveV8o=;
        b=lc1+IZyZj7u3/6ZAZNB2NfldJaPf3helcZpNGlGv6FvvMsN3SEEtxjogRHtFSfNWgm
         zlFU6jBHuYVcWJ5/njo738lDFlWsxy0a9BvdOiD/iQkYMWrFzWap8VWJwLEdGSNLzOMF
         t5f5Y3+vQudEPyFylJXz7NVM8Hj+guLApZnvQ0fjdIQJjsTT9H3058Tt1xaF5KQFiyOm
         PxCTq4N5s2PgaZDUsAJZpwix7juPwnOUHUOUGK/1sMx2J2mPEYHKF58NZISeK/X+gVPl
         Odfk6rZrM4iTtd6u+ya+zHlK+cquctlZh85IT0ojYVJGxrkhG+AmCNEgX4AshZbp/mi0
         ZiAQ==
X-Gm-Message-State: APjAAAVURmm1ZLV9nVpDtxeZcP9cND97TrCKzZT/WC3WtZy4KQjG2tSK
        GpIon29y2GBzFUG5T1cEhy9LPLKeFhOr1+UkVtk=
X-Google-Smtp-Source: APXvYqxLr36hqwMKODh3qzWDniOjPTuMYBfb9SatFqmJjJFuCZE6gelowfVkVqTxJSA7r3AmPcgNJgXz8OKViG9FdWM=
X-Received: by 2002:aca:e58b:: with SMTP id c133mr6594500oih.119.1554123537972;
 Mon, 01 Apr 2019 05:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
 <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
 <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
 <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com>
 <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com> <20190331184930.GV32487@hank.intra.tgummerer.com>
In-Reply-To: <20190331184930.GV32487@hank.intra.tgummerer.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Mon, 1 Apr 2019 18:28:46 +0530
Message-ID: <CAMknYENiA8sEm0vPk1nn45i_VomjeFpjy0bxPLixEa_Mg1eazw@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 12:19 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> If you look at what userformat_find_requirements() does, calls
> strbuf_expand(), which in turn calls userformat_want_item(), which
> fills the 'userformat_want' struct based on the strbuf that has been
> passed.
>
> Now if we look at the caller of userformat_find_requirements(), which
> is cmd_log_init_finish(), you can see where 'w.notes' and 'w.source'
> is used.
>

i actually got to userformat_find_requirements() by tracing from
cmd_log() itself. although i won't say i read the
cmd_log_init_finish() line by line.
will do.
