Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E861F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGBTLg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:11:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36781 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTLf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:11:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so9800720edq.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ldK40NYbzeFC61/W4FyEs02UK+kF0/qtabQ3M8E7zVI=;
        b=u4Rx3I7tgtgTdJm0sPMD2bI20oczH55LeraCNWfCnT6udg6wQIbNqRRWsPJCZ5U0pM
         tqdKFIgGtYskdoWiyrqwmDcW6gcB/HCOqkCXb1Lni/Z6BrZN+D1SbPEHvNbz1JIAsjWE
         No1YOqDiTPG5h4z9yyMMl4vZGdSFDSRxdKUQWgf/qXq+uSnR/hJmL0hXp0H912R8k2zI
         QXP8dgwktbkASF18HfSLO0gDntkRMfFlf29Bw0AkCz3xC0WQB81UDsG5DV/xVvN10eFn
         aR+X9ELI6CKHG+zCjsltDnXlppFbK7deglC2+nzmpjc3klPDfI2+HF7zixzltITC9kt1
         rbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ldK40NYbzeFC61/W4FyEs02UK+kF0/qtabQ3M8E7zVI=;
        b=qdku9AqbJjc4Muy6q+f/tkx7hjblCwBmWAWCgc49hgkJdQdsUh8xmnLptvt/Jgz9P1
         EJf4CFQ3wMK2vwKfPHrqef81HDXgT6qg/Npytt1BNZRJjZiwz96u8Iu7ER5sKOlBgIBg
         fXd5xJCJBbQcmT3koriaxWyNLB2V70CmX5oq5SzKUhpjgKbKpzTm+Uo+1Bh5IAoCOE/T
         S8H+yFLc2NbAH8jpu1p6+ZfXSIxzRZJ3xl/KKRbeXPk750qVoABCdKwsjXfwL+66n0+p
         eL7zSAm5TRXOGiQOL3wZt8FdLwGOKQYEjpszkZuHNiPSPR3fyVPfMfefJorvv+NxcsK/
         l7OQ==
X-Gm-Message-State: APjAAAVKebiW7zPkD1zAClKkibtCW/uuulBhiZU+6Q01KfBwKVDC9WTl
        VLfeYnv6Q1BMqS+nB3taxYgxA+shq1Uen3usof1s+VzlUyRJBQ==
X-Google-Smtp-Source: APXvYqwReEViTo4kQiIM2xCKJd3H4DCDFd/nL3MPn0+ufxKW1MCzu5FXvBuf9w6DQNOCm79BcSCIblrDmeAHKoVv4hM=
X-Received: by 2002:a50:94b1:: with SMTP id s46mr37736396eda.188.1562094694056;
 Tue, 02 Jul 2019 12:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABUeae90FQnxS1FCZLo+5LgMPD9xWQv6w7p7ymCtLdBoOijcRw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907011433531.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907011433531.44@tvgsbejvaqbjf.bet>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 2 Jul 2019 21:11:07 +0200
Message-ID: <CABUeae_NR43F+2-n9NPKUX_h2D+4nhbFT4UAaiBYFBrB5RyP7Q@mail.gmail.com>
Subject: Re: [Git 2.22.0] git submodule foreach now requires quoted command?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 1 Jul 2019 at 14:33, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 29 Jun 2019, Mateusz Loskot wrote:
>
> > I have a script which I have used for long time, with numerous
> > git commands and one of commands is this trivial:
> >
> > git submodule foreach --recursive git clean -ffd
> >
> > I updated to Git 2.22.0 and noticed Git started to complain:
> >
> > ```
> > $ cd /d/boost
> > $ git submodule foreach --recursive git clean -ffd
> > Entering 'libs/accumulators'
> > error: unknown switch `f'
> > usage: git submodule--helper foreach [--quiet] [--recursive] [--] <command>
> >
> >     -q, --quiet           Suppress output of entering each submodule command
> >     --recursive           Recurse into nested submodules
> >
> > fatal: run_command returned non-zero status while recursing in the
> > nested submodules of libs/accumulators
> > ```
> >
> > Apparently, I have to quote the command to avoid the error
> >
> > git submodule foreach --recursive 'git clean -ffd'
> >
> > Is this expected behaviour?
> > Could anyone help me to understand what has changed?
> > I can't find any related changes in the release notes.
>
> Probably fixed in https://github.com/gitgitgadget/git/pull/263


Johannes,

Thank you for the pointer.
It does seem related indeed.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
