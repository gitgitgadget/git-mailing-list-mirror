Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9761F453
	for <e@80x24.org>; Fri,  9 Nov 2018 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKJB6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 20:58:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36851 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJB6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 20:58:22 -0500
Received: by mail-io1-f66.google.com with SMTP id o19-v6so1645624iod.3
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oVzIBmqc+jpZKoZvkr6VLhzA/Nh4JFpdzzld9FL9ug=;
        b=jvs1KRAO1QpEhjMpY4Ymc+J/rRrCbm/EtA3hw09iXdqEnGODCCWvhJjEilsvnZHfKU
         6fjhuXPFU429aOMRNY5ju1L4X5bhRvaPhSwbhXXXR6ThbbrSwCjQua4ceJrtL7IIaPLK
         hlIdsINa3hFmXziAxqfPp3y0u0sm9+Na9HP5Bn+tac39fc51qGU5PjjnoBD4dNY/JC/D
         6U0UryniZ8MNg/dEcckWVtEf7DTxDcwyA5rWvmYv0Xtkgx3WdbQg0A0VlYdA3jCVJK9l
         itICpxOfeOKt0U8CtIYLNiFgXWOU/I3HrGdmNxQjGzZzWPgSobJPNdY4/WXyxzVFJ2xq
         TOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oVzIBmqc+jpZKoZvkr6VLhzA/Nh4JFpdzzld9FL9ug=;
        b=XcKwkDFl6UzOC1ijb2REvcMv8/Jan7Gs6x4O8Ef77309+03+5UCdMQS+bRjHZSvZF+
         0asTFFbBEU/w14/JXe4CQHN78DEUUsNuiGD5ySsyGDrVqfnIrF2Qq8F25sdmIkb3MFhH
         6CFyrrEewygSBFLBo8OVMMfPrvELX/oVg1dMZ5CIgS7653oWeiZGIqgdxOfkIgmUrlhH
         1CC704grRZ8ETs3YcTtcnkV72JkESRdJxGqISmXWSkxczPI8nfrz/xMN5983oUPREkKR
         nE5ZZWGy+4m18ylnQ2hWgex8CD9ZuqO96qrKtwvCtCQ7BJtip8dowJLrvmnX2TEDV8uS
         +nyA==
X-Gm-Message-State: AGRZ1gLqh5WVuFaFbEdEomOAuMjDVXAa+vuP/at7+f3BHHF9vYtkifad
        u+OBeYNHV/DVhk2L9NYpcYK7zMNPA4Ii9OXYxgTz6Q==
X-Google-Smtp-Source: AJdET5fR4ec6X9RgTyyaPVCR5GNYWp4m2JdbaSAiuytRaB/+zSA4CoC+PnRo0NxB8A20INPtvAzuiug3SXOWDX+izgc=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr7613673ioc.118.1541780227619;
 Fri, 09 Nov 2018 08:17:07 -0800 (PST)
MIME-Version: 1.0
References: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet> <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet> <20181109101918.GC7410@sigill.intra.peff.net>
In-Reply-To: <20181109101918.GC7410@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Nov 2018 17:16:41 +0100
Message-ID: <CACsJy8BzbEnXMRw6kB1rg+WMfu2wwJZWkAtVate98CZRSY_dLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 9, 2018 at 11:19 AM Jeff King <peff@peff.net> wrote:
> > The form `<RUNTIME_PREFIX>/abc/def` would not be confused with anything
> > that it is not, I would think. The only thing against this form (at least
> > that I can think of) is that some people use this way to talk about paths
> > that vary between different setups, with the implicit assumption that the
> > reader will "interpolate" this *before* applying. So for example, when I
> > tell a user to please edit their <GIT_DIR>/config, I implicitly assume
> > that they know to not type out, literally, <GIT_DIR> but instead fill in
> > the correct path.
>
> So yeah, some alternative syntax that is verbose but distinct makes
> sense to me. We use %-substitution elsewhere. Could we do something with
> that? "%RUNTIME_PREFIX%" gives me too many flashbacks, but something
> like "%(RUNTIME_PREFIX)" matches our formatting language.

FWIW I don't have any preference, as long as the variable can still
have a name (that is not a symbol).

A side question regardless of syntax. What do we do with
%(unrecognized name)/foo? I see three options

 - expand to empty, so "/foo"
 - keep it and try the literal path "%(unrecognized name)/foo"
 - somehow tell the caller that the path is invalid and treat it like
non-existing path, even if there is some real thing at "%(unrecognized
name)/foo"

The last option is more predictable. But we need to be more careful
about the syntax because if "%(some path like this)" actually exists
somewhere, then it will be broken. And I think it's also more work.
-- 
Duy
