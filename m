Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C511F461
	for <e@80x24.org>; Thu, 11 Jul 2019 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfGKPY7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 11:24:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46698 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfGKPY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 11:24:59 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so13326059iol.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY7D6Kgcu5bB+7C2Y653ZFcNUcyrArTsFBx63dsw26g=;
        b=aMpcGDVRFVZABQvVT3jBytLbaf6cCus+vdkVGitXVDE5cqZqREPjpZMVLXj6WfuLDk
         cm3S35mKwESgxsYw+Op+KAg2yOnofiffOyLtYIOhGIjA8nH098URsMQjhb7TiMcDGtqg
         McPVYaYc0WzZ+rYZZRDsdtDDNCAGPUhBpK7q7SnySQGwzFLkQ0sobxHfV17+tIBkHvfT
         /EPHY/EpoH1KrnOalJWWAsTUyBq+fMsxbrNYgJXX2dI4YDfkhLawWhPO12HirhWKyAVM
         4s6Q4XNbKN5ZcoMA+racZ7skDULYcSQ7YywQgf7KQcCUGp9qYH5LxAAWI2gTsA6lDYk+
         98gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY7D6Kgcu5bB+7C2Y653ZFcNUcyrArTsFBx63dsw26g=;
        b=HCNA62GZdJA7359a65tveYCcYjPQeNb3O6T4brGS7g2ZjYuT86Nw6XmIGzWyvt61WS
         N6Sj/oPkRYB3y3VBrnwKjbi5bL6u8Soom4h7L36I/x/aai7wViZrZVjb06Vqfrqc/slh
         BikaieAa60rgwRgWSRAlZOYrOmJT1/uOHg7o9lpZUv2EGQk5PeJRxpkKJYJ2kV7Dgqsf
         c26NqQgI0jVq1UzCell7ovLHsLCUpbq9e0Hk/3kdUiXju3pz5tTFPqlfA4iv3hUcpcKF
         gk4erdgeVy7YGeAvCE7U4sln6QFMB0P4GKzfq7W57gcjsiUTdXxqtwGXAfj8pxDR7Aka
         gaAg==
X-Gm-Message-State: APjAAAVsdvOWQL6wS8gmcvJJt1XpECip+R15GxEKGHoB5A42HEHRDEGM
        JIDlgfOO6edUCt/uWA3Y7sC3SMeWsk7UAC1/ESvSpg==
X-Google-Smtp-Source: APXvYqzcWEoAoWd0GHB0UEQOjDQBI4nFWikwnAokfVbDmAxak+oJ8HLCDIk8xCvu884Ch/xsF4qXcVZlzzT1TsJOdAE=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr5009141iol.140.1562858698148;
 Thu, 11 Jul 2019 08:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <cover.1562801254.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.1907111355360.47@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907111355360.47@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 11 Jul 2019 12:24:46 -0300
Message-ID: <CAHd-oW7jwkHXjpExZOsP3OfJN4HP2ZmLR5h+NphovYoShC2OVQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v8 00/10] clone: dir-iterator refactoring with tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 11, 2019 at 8:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Wed, 10 Jul 2019, Matheus Tavares wrote:
>
> > - a replacement of explicit recursive dir iteration at
> >   copy_or_link_directory for the dir-iterator API;
>
> As far as I can see, it was not replaced, but just dropped. Which is
> good, as it will most likely address the CI failures.

You mean the circular symlink checker, right? Yes, it was dropped. At
this item I was referring to a dir iteration code at builtin/clone.c
(using opendir/readdir) which was replaced by the dir-iterator API.

> Thanks,
> Dscho
