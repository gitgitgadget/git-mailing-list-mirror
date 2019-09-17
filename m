Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E355D1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfIQSkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 14:40:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40290 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQSkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 14:40:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so2460323pgj.7
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrFaFooP77Oeon8vwaVTqi5IbBI6gfBulkmU+FQD/4w=;
        b=oxT41gpnj+yVMA/F1G6Yo1oE/5O73iJEWyr66v6CTuOUOrfx/7Ss7aFeLZGDYKMVpq
         pZLmhqeC1kYlhH7NytgRFiQoKSbVsjfTcITZCcJiHd/VDjpzJ4AboQ2uxL4WjvPJUF6j
         ynqnofO4LjaDDjKUU0N5wisrUW0z60RPGICvKSTLkBSsTag+6W8Tj/vW5CRhQOa9iMJU
         q/6oAWwFPbLNSJ2xgu5MpFthqA/ONRRThU8Kan4s2dnptv8CNZcZyaCfMxnn6g7+4+bz
         5x9ThsKQ1vRwfEM774Q9B7LHwSTGBjcPlpnCXCn+WrXPeZ0w0nI2peERTSPgovPFZgQ1
         g1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrFaFooP77Oeon8vwaVTqi5IbBI6gfBulkmU+FQD/4w=;
        b=Tl2pRkz5wkN46/hWXqrM3wMBNGialE73kNDKu2qxhEGt1U/+MQzLhq10iQpV9/rXuD
         /gSWNPkQ4Ap5GPVOrsJ4qll4upBfv7RKMzBonfefx6kJuPTcvz1nzHQawloGOyLAiLXc
         P7gk29LQ5cuFaI51QUAaSGu5ImPNLDg0bQBuP613Ok7Njm21WvxQ/e74ynUtaZ3w3LHb
         MIpxWFiiZ2t1Ge6sVXrl2UXHzjLA0nD2qDTufdWGXUJdCSdcniUg1C1z1EwTVJOvC1De
         DJLFtSZtyZ8mjnJELoLmsxFthChRn95qK9EHhG+QrAk1d4Vn+kr3NXlBvU/RROwF+uQu
         C6yA==
X-Gm-Message-State: APjAAAWWq+OMDYaUkVsMxEAOrePNS3FZnxKMwW+WYCIpXPjIzruPnuVf
        AC+nxOK44vKLdbdFq7ioryD+YhyK6jcSCc6NQEg=
X-Google-Smtp-Source: APXvYqxlK+LJfAQxLFBP/imKcri4uME1QNT9uDyQrlDkmM+k/JxbNQ7gdkKVsDeieOFutZLVF+oFF9e6F0LCBYw+fPQ=
X-Received: by 2002:a65:430b:: with SMTP id j11mr207213pgq.383.1568745621311;
 Tue, 17 Sep 2019 11:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
 <CAN0heSoaYf0_2FhKQNnswLvFppu=dyBcKGYB_Jd=uF70yjNiCQ@mail.gmail.com>
 <xmqqv9ts9fox.fsf@gitster-ct.c.googlers.com> <76602d23-f2b2-4a15-21ad-7bd91a4b5e44@kdbg.org>
In-Reply-To: <76602d23-f2b2-4a15-21ad-7bd91a4b5e44@kdbg.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 17 Sep 2019 20:40:10 +0200
Message-ID: <CAN0heSriy3AQanFpdCNTeu0Gzc1cM0hj=Eaez=9RVRAqD26+mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] diff, log doc: say "patch text" instead of "patches"
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 16 Sep 2019 at 22:46, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 16.09.19 um 21:58 schrieb Junio C Hamano:
> > I wonder if the result becomes even clearer if we dropped "instead
> > of the usual output".  It is a given that presence of an option
> > would change the behaviour, so "instead of the usual" does not add
> > any value in the context of the explanation we are giving.
>
> Agreed.
>
> > Also I question the value of the "running git diff without --raw
> > option" sentence; "diff --stat" is also a way to suppress the patch
> > text and see only the overview; I know it is not a new problem this
> > patch introduces, but the objective of this patch is clarify about
> > the generation of output in patch format, so...
>
> You have a point here, too.
>
> Below is v2 of just patch 1/2. 2/2 remains unchanged. I've added
> git-show to the enumeration.

Yeah, this makes sense. Tested -- this renders fine.

Martin
