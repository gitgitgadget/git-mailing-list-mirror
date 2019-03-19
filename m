Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6CA20248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCSHNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:13:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSHNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:13:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so10317501pfn.9
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WY+M4nH7KNcW/sFsQIkxzVU/7EozJGpkphrs5uzRFxs=;
        b=TwM2ubY+K2Sg0YPJZnVPAKuw6Kx8KDw4y+7bvezcWyLAyG/tUjuX5xRYgsAKkLzzTC
         yxTw8I/ktzoEgjv6V+HcizlXQwVp6dVyyVjwroEG0jGBtuRc5uHKvyJtSom/i7F8+6ip
         9bAPBHG0hwsiCFewITH0l48s5kAlNW6l8z4dIJz5DONToEH+y9loC380Lzf+S7oJ1fNT
         AmVLIzIp4bTANiFSwkWr9XBaZyjj83asje3JyRA+o1X8vkHSZ0wf9Iz8JjnbzctMtRz2
         cLUPLVA1yvkITuIPjZxZ1DqgWMD+q3Iqq4s8GACTBPnpQqgYI3SozmtxG30gFbnGxO6z
         PNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WY+M4nH7KNcW/sFsQIkxzVU/7EozJGpkphrs5uzRFxs=;
        b=K0JWt3Hb+Hr0d+2EpsaE0cblBVbJ+jMmwnprObPtf/f62I1Nnf7DKhamvYYc0Cn6tt
         pO9cD+jHocYmCaZJ+8mzVGetE/BipXSIAKiTM676R4HrRI5NiRG+ySWZ//VsdOVWzYgx
         KiXdZpo2QgCsCmmF/z830uxCmKkOwkMMUhY5tJTLMmHjGSSOyx9s2PuM4y881uo4XQ+y
         ApFdHq8swrCT5t7saY9KvTlNR7e3ttPXkZhHnBXjg8GTrbrpu2wDgyEHskXLFGrEDViH
         nDqZOD+fLC85oNYgXqHmZDvEsMHwKcmZGTu/k8Ao5+1+7jvUR6nZyBperDD5WKjBaEv+
         p+iw==
X-Gm-Message-State: APjAAAX6mFh2GLaHXqfdb8HMB5u1kds27SNMLD3f/VcNyekHmVpBst5V
        NSN+Zr4R5l/Y6UZVmu9UuuAd+hi91DHdKuRMzy8=
X-Google-Smtp-Source: APXvYqxq4+c3tTHOVjMMdNotbXA112RZ1/b49CcfZsNdr0kC+vHKQfqEGCjxi4wpvHbuGUvHhLd06h6sm0qVI5Eq008=
X-Received: by 2002:a63:2403:: with SMTP id k3mr649541pgk.200.1552979587158;
 Tue, 19 Mar 2019 00:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net> <20190319033023.GA25772@sigill.intra.peff.net>
In-Reply-To: <20190319033023.GA25772@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Mar 2019 08:12:54 +0100
Message-ID: <CAN0heSo92kS6mhYH0HM-z9jOKNR0wzDynu3bnq=FtBc4_+zCpQ@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Mar 2019 at 04:30, Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 18, 2019 at 10:46:45PM -0400, Jeff King wrote:
>
> > It does seem like "mansource" is the way asciidoctor expects us to do
> > this. Why doesn't it work from the command line? Is it a bug in
> > asciidoctor, or is there something more subtle going on?
> >
> > I think even if it is a bug and gets fixed, though, it still wouldn't
> > have the version field (though that seems like something we could
> > contribute to asciidoctor).
>
> I just tried with asciidoc 2.0.0.rc.2, which came out last week. It does
> seem to work from the command line:
>
>   $ make USE_ASCIIDOCTOR=Yes \
>          ASCIIDOC_DOCBOOK=docbook5 \
>          ASCIIDOC='asciidoctor -amansource=Git -amanmanual="Git Manual"' \
>          git-add.xml
>   $ sed -n '/refmeta/,/refmeta/p' git-add.xml
>   <refmeta>
>   <refentrytitle>git-add</refentrytitle>
>   <manvolnum>1</manvolnum>
>   <refmiscinfo class="source">Git</refmiscinfo>
>   <refmiscinfo class="manual">Git Manual</refmiscinfo>
>   </refmeta>

No such luck with asciidoctor 1.5.5. Seems like it really wants
"manpage" before it considers these attributes.

(That's still me holding the tool, so factor that into it.)

Martin
