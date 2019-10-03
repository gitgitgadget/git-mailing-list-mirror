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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA591F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfJCLRy (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 07:17:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37747 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJCLRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 07:17:53 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so4585427iob.4
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeZOkmkYwLuHAks8RYnk7u1Ij0gsYr2zN3PaKw5BPvE=;
        b=gFiyjgEQrIrfgaN+QAbzmUCZHBzE25eC0jnjoljCmGmv94qlM9/6NhM37FjYs4K1LU
         clzVgd22iOkSeQCAslgjFXM6A4lNKPLHysGiEAhAXYc50Z3abMOjavNg4h05FecyYF7t
         vYcEzGOtvBJ2haOG5Eb1dg1XPvTp7QjWlIRBAwSM75ftE6TppBZv2Qpwv7fDmAn5S1Wr
         8O63LB8a1aCrYqMd32QKa4imiBZ9Zs6fyl2o4RaVweK5ynXCVEUK5NEgVsReTuLY5ONR
         wi8Q4l7F13Flnaf3/ivIbKxWDaslITaTiKPkXoRYrAu2MYYQlGjCx075B1ghxGLhnSx4
         AkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeZOkmkYwLuHAks8RYnk7u1Ij0gsYr2zN3PaKw5BPvE=;
        b=M+a2F2Oho6SLchFCBkHlxJ4Z1SIMNMxJRgFjZpT98JeU7eAy9WEDsgLCv+3ctUvvo/
         h0W6hpdPADJtzdDyyhrZcEFj6RwDhnZUquvb2SNEG/jZXJ0z2r4u214fz03vvgKsCd5H
         uqqa97hCHETNawxE02HZv6COknLYfgB/AJ/VYTGwq46DfKoslOKHdlNyghzIB+WGDhWY
         tfkXm2emm4RP0mNlWtIiw5gPNFkaj9HnjVPnvsw+cyYhIvEwomsRe5tFYQzwR6UW+QEA
         zjmnGdhjq8mSdB+FQR9WX1HPbODwVDQuQJGxga/zlMmxqBjl2Um0xZOlo5TM+Olm1RUT
         6tyA==
X-Gm-Message-State: APjAAAVrDw5e7kux0ceSAhUADcmL8DV92ik2mph4oWh/RgrWuZepH/fZ
        hhmlqqPJHKANzXXj/5e0JuAg8egCpN3msL11ba+Stw==
X-Google-Smtp-Source: APXvYqxQiJMBL+JMfclHOQ+Fx4mJFac3UlfJQrL6wucPV10wflvcvg7UfOs6G2qNJ4KZ/cB8xQOHnMUKb8GZBbW33PQ=
X-Received: by 2002:a92:b112:: with SMTP id t18mr9205328ilh.252.1570101472944;
 Thu, 03 Oct 2019 04:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com>
 <20190809030210.18353-3-carenas@gmail.com> <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
 <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
 <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910031007060.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910031007060.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 3 Oct 2019 04:17:42 -0700
Message-ID: <CAPUEspiMOn8h0+WEkpe0CRgOQohKL-07TacM6CmiZBZh7GBCnw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 3, 2019 at 1:09 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I still need
> https://github.com/git-for-windows/git/commit/719beb813e4f27f090696ce583df3e5f3c480545
> and
> https://github.com/git-for-windows/git/commit/3369c322bbd95820b971701fef7db44b26dd826f
> to fix that part in Git for Windows' `shears/pu` branch (i.e. the
> continuously rebased patch thicket).

or we could drop the current branch in pu and start again from scratch
now that all of the required dependencies had been merged.

apologize for the delays otherwise; $DAYJOB has taken a toll lately
and even my new shiny windows dev box hasn't seen much action.

will update here and in github shortly (which might mean up to this
weekend, being realistic), but should be better code (since it is
mostly Rene's) and better tested that way and hopefully won't cause
more breakage (specially in Windows, sorry Dscho)

Carlo
