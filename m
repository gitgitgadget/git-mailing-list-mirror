Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0D51F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEHKJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:09:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35451 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEHKJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:09:32 -0400
Received: by mail-io1-f68.google.com with SMTP id p2so5428708iol.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYX/DYznliDqnpkBrswV6zhUlEbFlFXCdi4IpP/4wi4=;
        b=fHPrA0H3RWaWSRxOADl+RvP5vaj427Y6NmexAeladtgy4LNY2o2gcKxSrVl4fyC4n6
         OAB5PNfyWjMzOTdNWNlnPZqopLOQfhsqVPk/oTy2Rj2K4PdmAYToJWWN6ri32DExCyIO
         y7vfJ4W5Hd0gcm03R+2w21XJldcSBuYT9ze4EeTDa5bCFk+bjSvfaeruLFFIr5Dr3Qiq
         LTngaUmaPfGRgZwUvDX6JJiXfqQVEk8lW0Sl9aeEG7VJp9RGa8p4GuuXBu0vohu6A2oJ
         becy3R7POKPYqfzmU+Gh7MeInki6Y8Xg05Ir+7VHTDlGMM9k0fsLFbVKHX2GZs4RgjW0
         5bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYX/DYznliDqnpkBrswV6zhUlEbFlFXCdi4IpP/4wi4=;
        b=beEeZ/IaMnKi1OQx1AXqZOAuHIc4pXdGyANQcZ2UU+vNMF7FQyn0u7jGUNID3iI4nz
         j/JpbYSFyh+rfwN2y6qIk4lB3nbnHKOkPgZPamnOBCp+0+AG2o7JctCNAA+dVyZAoMsC
         gkxWm3PWkMt5+7A0gLHF0K4RvePZML1TkdxgogiiY/EVGmqxSxAi+fqsNbbCsykbe2oQ
         RKfxDPG8Vcj6zvBvbpy8j3Qp77ZdvK13M1knXuNF+Btfr22FJRar2bPNz95cSRjg26pL
         Lz8owb2qjRT2kyMlO4fbSsrcvSGNHutduZiigekaEZBfBZIFgr3kftek1NRHHqtL3uEv
         LH7g==
X-Gm-Message-State: APjAAAVBUWUsV+PoWPrT/h8aGk3QelgROwuPiCdLNuw9Ovxy870A/bZ3
        AWwW3wZrBPYbtoFOK/QCDcqaqy8nfzOQyYEGUlw=
X-Google-Smtp-Source: APXvYqyxDrqf0blKTDmHE5Ugre5j9ziy5jLjoBG5jaVxQXpB1Zn9HMYGHL+0E2YUKBN+sHl4E790d0KOHZa0iI/SJPE=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr111720ioz.118.1557310171895;
 Wed, 08 May 2019 03:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190201193004.88736-1-dan.mcgregor@usask.ca> <20190209023621.75255-1-dan.mcgregor@usask.ca>
 <20190212134537.GA26137@ash> <D8E7C7D0-04E5-4802-80FA-2477F2C0D240@usask.ca> <xmqqk1f1gzgs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1f1gzgs.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 May 2019 17:09:05 +0700
Message-ID: <CACsJy8BcyD199L4qGv6-TP-8HD+GS+ZDNN5jspkh5uVaWekkoQ@mail.gmail.com>
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dan McGregor <dkm560@usask.ca>,
        "McGregor, Dan" <dan.mcgregor@usask.ca>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 2:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Dan McGregor <dkm560@usask.ca> writes:
>
> >>I don't think this is enough. At least fbsd defines this
> >>
> >>#define    fileno(p)    (!__isthreaded ? __sfileno(p) : (fileno)(p))
> >>
> >>so one of the two functions will be used depending on __isthreaded
> >>flag. Your forcing to use fileno, ignoring __sfileno, is technically
> >>not correct.
> >>
> >>For the record, at least fbsd also defines feof, ferror, clearerr,
> >>getc and putc in the same way. But at least I don't see how something
> >>like feof(fp++) could cause bad side effects.
> >>
> >>So, how about something like this? A teeny bit longer than your
> >>version, but I think it's easier to control long term.
> >
> > Yes, this looks pretty reasonable to me too.
>
> Sorry for pinging this ancient thread, but while reviewing the
> stalled topics, this one caught my attention.  The very original
> <20190201193004.88736-1-dan.mcgregor@usask.ca> said that the problem
> it wants to solve was that the code that passes (void*) parameter to
> fileno(), fflush() and rewind() misbehaved, as these are all macros
> on your system.
>
> We solved the problem for fileno() being a macro eventually with
> 18a4f6be ("git-compat-util: work around fileno(fp) that is a macro",
> 2019-02-12), but what about the other two?

I don't think the other two were the problem. Even in the mail you
pointed to, only fileno() is acknowledged the problem in the commit
message.

At least for BSDs fflush() and rewind() are not macros. BSDs optimize
a couple functions for the no-pthread case by inlining some short
expressions directly [1]. This works well for read-only functions such
as fileno(), feof(), ferror().. and pushing the limits a bit with
fputc() and fgetc(), but fflush() and rewind() are (I think) just too
complicated to do it this way.

[1] https://github.com/freebsd/freebsd/blob/master/include/stdio.h#L451-L519
[2] https://public-inbox.org/git/20190209023621.75255-1-dan.mcgregor@usask.ca/

> Here comes a weather-balloon to see if we should pursue tying this
> loose end.

Let's see if there are still problems with more exotic platforms. I'm
reluctant of adding unused compat/ code because to me compat/ is
scary. I often don't have the right systems to test whenever I need to
make changes in compat/
-- 
Duy
