Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC3A1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbfIERql (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:46:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44617 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfIERqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:46:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so2178830vsw.11
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lL3BmiT7QZQFrNuEYsGsobGTshd2MreF3nz5QITxus=;
        b=CQ455kxbxyw+qgRr8gI247D+3aj++njOMPcV/PEpQOK9vR5ld7nWQv7K+BBOQ0DhtU
         zK25ZtEAEHdhu85jgbvCYj7RWyFSs8UHRfdZuibxgNE7QD705zlJSoN9KCKFP72GJA9f
         U1tYwywAJnRx4E3llV+uKWCTqEnqECwHH+p8NYRcAon6foUJdorbpZtk4Ir4jGCA5BFJ
         ord0UDGgHihOgdfSIjyNSSUoOWdgf4A6l411CdXO/uz2w0G8CNl+lqx83gwvMjjzQl+A
         Rk9cmq16bgMbvJsLHKtqa9Lmo5WLbAmvY7ZMt8T8FAZ39kt99bTDU8x/BD8sdNYhk5sE
         ZaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lL3BmiT7QZQFrNuEYsGsobGTshd2MreF3nz5QITxus=;
        b=UGTDxQh4uitF/hJN2lbNCeNjCbsgKh5wDWgnvz7KV6nbC6WoJxM8SOUiqXhN3Zqvkh
         Mm9N6lc19i9bzNRYWhQ4vjpUvh8HgvLnIQBgquct7tRdDxjWTFUoq2CsqmnDAcTCGi8r
         C00wwosViiGj4sKchQdhpAjuQx456C97M0UYi0dhyoqQ4PaXvHTH74+ZcmLtlT0umf74
         0NyeqlOLVS9d8xft5ptAFnDi0e6YGLbdNp45A/ufTv9dpI9Tr7yJRyCG6qqE9VBZRBWA
         oNRl72m+6n+Ue0aB3pIVMtbHKoXccZ2dORVy2PxH8sJ4/WU14j0ZR9N6e/irGGClCefb
         c4dg==
X-Gm-Message-State: APjAAAXHwsVcfknhUSubO7zl0eHdkvSgVYlrA6qigZqbdsrMAbiwA5tN
        XMG+1M3c3oDyW86u4ZwPq+P2Pm2rAlGvb98MQeThQgiR
X-Google-Smtp-Source: APXvYqwgYx9EDlJ7TQRaQz3PXC+nxLU8/CcbK8RrwkDYfDE/xDpzeSKR4F54jezWfSpE+yl8n/zWEL4gca6NpPe+KoE=
X-Received: by 2002:a05:6102:143:: with SMTP id a3mr2356850vsr.63.1567705599875;
 Thu, 05 Sep 2019 10:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
 <20190904224821.mgh4srhc22grkraz@yadavpratyush.com> <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
In-Reply-To: <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 5 Sep 2019 19:46:29 +0200
Message-ID: <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 5, 2019 at 8:50 AM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> On Thu, Sep 5, 2019 at 12:48 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > I'll chime in with what I think would be a great solution: auto word
> > wrapping. This way, the users can set the text width, and not have to
> > worry about manually formatting it. Long "words" like URLs would still
> > get to be on one line, and we avoid showing annoying dialogs.
>
> +1. IMO git-gui really needs automatic word wrapping for the commit messages.

Please exclude the first line, i.e., the subject. This should not be
wrapped at all.

I also imagine, that we should make it configurable, I'm unsure if I
would use this feature for my self.

Bert

>
> Birger
