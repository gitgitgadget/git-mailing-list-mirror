Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE04E2021E
	for <e@80x24.org>; Sat, 12 Nov 2016 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966843AbcKLUNH (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 15:13:07 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35405 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756789AbcKLUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 15:13:06 -0500
Received: by mail-yw0-f169.google.com with SMTP id i145so36701220ywg.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 12:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aqJ4sPLq/9BE1sXOlrlDaTbXeg+DD6KrRvcmLvWV1EQ=;
        b=Bg4o1LlnjPLIHiPK849PdPHk0/jf9qTolhfSNBVJ6Iwh+O6RfvUe3E38xRxdaJd2yU
         hm7sUPGg4Ar9lkXIYdj+0/Q2nzixqGcHS7AVWcbtXsyoB9muNaUEls5XxbGsZ+wu+gNR
         6hrGgpzarN8WRHxMDFGfbF/hFAlN1mhgVE7C0wpCBrHHB0XJ2jC7H5ID7/wARXsWtUoA
         UGb4cogx98fA/ebbySf8yUk0ewrVxVIB+weU4BDfTdAR6AsbSRIGPBeJcrEy/VuBchpo
         PN/y87Se4PGKq8jzpXmYR9L5r6cHQTZGLUFT6ENAEgqdHBKuRen5IFO1Q9zfle6zAuOx
         TsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aqJ4sPLq/9BE1sXOlrlDaTbXeg+DD6KrRvcmLvWV1EQ=;
        b=LwE2oN3KsvO7m5HAfgQ9rK5tSC2ax/HaqU8zuR3IXYy1oPCjYJmY8tHQOIeuideE5N
         697p+MA1eyoznhrM4YuvuSpjQE6j0ONA7szsEjjg0d3JM+NiGJfGili3KVsR0hvS8tlN
         2hvDsJFRGUonr5gipNUTMzlu9M5RDdToB249Zn37SyJH906JZiwi9vAwLJT2H0f5MPHx
         NSNIiOkmHqCZg+NRFyYP/M3HInBamx87Tx0MeCFxYU5afLrwQSIzloKKsBvRq3q0wMeq
         yI8MM6+ntEr4SJPeKZ5YmE54Lj+b4Ma8oVQGerPrMQZWhFWCBvVfBLueA7kv1Uka1Uh6
         vVBw==
X-Gm-Message-State: ABUngvcOh9mFBCnz2hvvB1R14GZvi48NRulsBqZ7H6Pt9/37gxYk5fanzbtjKdMw5Dx+kIZvydc382bHbRmwQQ==
X-Received: by 10.13.200.134 with SMTP id k128mr8552749ywd.72.1478981585612;
 Sat, 12 Nov 2016 12:13:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 12 Nov 2016 12:12:35 -0800 (PST)
In-Reply-To: <CA+P7+xrHRMZemNfo3gjJryBRR5b4T8VT3t9_CBE5hJJfv+D3PQ@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-12-Karthik.188@gmail.com>
 <CA+P7+xrHRMZemNfo3gjJryBRR5b4T8VT3t9_CBE5hJJfv+D3PQ@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 13 Nov 2016 01:42:35 +0530
Message-ID: <CAOLa=ZTcBf4MGATxXshzFOMa-M_aEm1zf_bpNnFydbfgdRcEHw@mail.gmail.com>
Subject: Re: [PATCH v7 11/17] ref-filter: introduce symref_atom_parser() and refname_atom_parser()
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 5:22 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>
> What's the reasoning for using separate functions here if they are
> exactly identical except for name? Do we intend to add separate
> options for this? I don't really have a problem with separate
> functions here since it helps avoid confusion but they are identical
> otherwise...
>

I see no need to have separate functions. Maybe in the future when we
plan on adding
specific options we could split them. I'll drop the
symref_atom_parser() function and use
refname_atom_parser() both places.

-- 
Regards,
Karthik Nayak
