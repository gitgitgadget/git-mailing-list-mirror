Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75201F453
	for <e@80x24.org>; Tue, 23 Oct 2018 23:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeJXH2I (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:28:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39826 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXH2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 03:28:08 -0400
Received: by mail-it1-f195.google.com with SMTP id m15so4273999itl.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pki0cJPJ45Q3P+4n0rZrWmvMaNuFKaFbUIwLwC+ewGA=;
        b=R7ZJuypXBw0PWwXvpXwJLkB9GeN6Y/XmeUnNNDU1S9UxycZB55Usrn/0JyD0LwT9/f
         Z6aeXYqwaHVdoek8s/QinksJdhY00TRN2kM4a9b0wf5M3zY8Hv2JFaYyVWuPTG7Pezwm
         XdPIBfKBA2jIRaoTN1dyo33ceSTs4Ran9CgJbuedrPGmf6I+9NxlxXfubi/XxpQFuE8l
         4hyVeWZlKW6AYFO09fkegqA5+YRRTX8NGE76MeYfWZ23kMUHPwmTABvGbhg5cBPMlXjv
         iT5MULzFr8G4wnPaTm506ojzibIzN9FtTea0L3rufqCBpizgvRk1Bb/8/JRpfhr9ZYh0
         r8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pki0cJPJ45Q3P+4n0rZrWmvMaNuFKaFbUIwLwC+ewGA=;
        b=GCKJ/DrkkNvy2XAQrXPpghZ9ASkSTC/O4qEsVT8JBOpQwtX5fWD/aiWgPBaOIGjO4c
         xplOlYNAaiX0wp5gtOqfKiBZgrPQR0P/VEoTA4+EmvYOMIRe8GjDR4+7JnSKj8vriM4t
         cwgAVfKSozJGwKtH7LEoL3cF5A4gJXN1z55drQiAq4brWd26pPMLEp6OVCtsOzflxB4V
         +gC21cgb5GA3WcJk7GG6aH+y+C76cEl2YD18MNR9+Q2fhP7s7rdIk1wM6PXjvB1BKw1z
         nh5YBAnul7PCLS1aKAaa/GDk4dOTT9jkHFzujpNISSCZRgZMWPbnSxywGhyovqron8KX
         bRWA==
X-Gm-Message-State: AGRZ1gL6Xv7Rt/qVINZlQxpNGVww/kCDoWOP/Wc9UId/OrnOTDYtAHTz
        c7EBFehZTUt0PfALwGxPiHSxwZFxM6V0lbTiRGU=
X-Google-Smtp-Source: AJdET5eD7AhcrERenumi1VQxF2IO/5Kpu35uHrUnGwJ9C/LWbKfTXRHGzaJH7QLeeDJOVrOWWNNWM3pB382HSgKYH5o=
X-Received: by 2002:a02:9a1a:: with SMTP id b26-v6mr231686jal.4.1540335757165;
 Tue, 23 Oct 2018 16:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
 <20181023215020.18550-1-carenas@gmail.com> <20181023215020.18550-2-carenas@gmail.com>
 <20181023220019.GA31613@sigill.intra.peff.net>
In-Reply-To: <20181023220019.GA31613@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Oct 2018 16:02:22 -0700
Message-ID: <CAPUEspiAhmJ5+qTUcA6x+eSPc9jmOLdF7QsSsSfwJSy5r=06PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] commit-slabs: move MAYBE_UNUSED out
To:     peff@peff.net
Cc:     git@vger.kernel.org, pclouds@gmail.com, chriscool@tuxfamily.org,
        l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 3:00 PM Jeff King <peff@peff.net> wrote:
> On Tue, Oct 23, 2018 at 02:50:19PM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> >  #define implement_static_commit_slab(slabname, elemtype) \
> > -     implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
> > +     implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
>
> Is this hunk necessary?

it works eitherway but the proposed syntax is IMHO better aligned
(when used in a function definition) as it matches better the syntax
from C++ attribute: maybe_unused (since C++17) [1]

__attribute__(unused) (the GCC extension) is meant to be applied to
function declarations, but we are not generating those.

Carlo

[1] https://en.cppreference.com/w/cpp/language/attributes/maybe_unused
