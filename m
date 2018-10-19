Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D2F1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJTBEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:04:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38883 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeJTBEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:04:12 -0400
Received: by mail-io1-f67.google.com with SMTP id q18-v6so1359313iod.5
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97N03z9MnRdZtbPCCWxHAnTywnkhwSg0F28Kn6r+mec=;
        b=NGrbf+u8D9glvSZ44dGAaJD/W5Mf7GEG5bTujgIsBnl+E65GQqIENJXJdJoeBNBJ0o
         FysXlSHxFnxeURmSMNQZ61dEfC3PEJ9MVv33IE6nV8GwnCxHVMPcBmdcQRycgJtQAeqE
         GOjf7R8jwvutr5U80x77rAZWvW83Ntd+5Gb6AEPKRfLjtBPVJptH6/int/PawWFSyqjy
         qBeiMl2KNjjTtHH322xmJGRRF38IOKjrFoyCfG4i3yhE4pfB3a8qgk9HFahEPscxSuMX
         7a1478IyZgwQ5ruduFnP2+OaZHsjZwDIqYA/GQxxekV/HA9zL+buD/LBg8CfyxhL8heW
         bc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97N03z9MnRdZtbPCCWxHAnTywnkhwSg0F28Kn6r+mec=;
        b=ExXFcjwH7EXdNojAwyMhcBpKqm9iJtQf+JHS5/3fgULuS9ybu5ZWAf3rdOUUyXF8ZH
         mr+wgR846vIEOFAX6gPS3I8dMzIiWR0i2KtYlxpo56AsHxd0luRsoLhCNQzmZmSA0lcI
         iaahE8HwkNqwP4u2n4Rm8iI095Q1volAUki8aRGiTGxRQoDkloK5Dwmk9Tom94abQWIx
         0F/RxyEwZAKoWs4GCuhnNwd0HvwlN7NlchC01iwcwMbpviaVsF5LNOWvD8HL+NkU3oxI
         QvCZBrgQO6+I5i/NLUfeaVTTpphUB/Aivs3m9DoEWCrvNs6k1rHQA1+7OC6t1zZjWOa/
         OKTg==
X-Gm-Message-State: AGRZ1gKumk9K1nh0/I3fUIokJmicpTMcwrf9ZoZfk4vJ7ZS1/3+oRO1I
        VvxkqCrwIYCB7ESVSCSUPzeZSvGMOvbIiv8JPkFOOQ==
X-Google-Smtp-Source: AJdET5cSqIvBqq53NfltzTjViYafbczWchEyqeAmCwCwpEcHVXtJXuh02hwEnOKXYeOgqecTvl4NLaRJbMTRpER+YnQ=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr2129679ioc.118.1539968237217;
 Fri, 19 Oct 2018 09:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com> <20181019162021.GA14778@sigill.intra.peff.net>
 <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com> <20181019164237.GA24740@sigill.intra.peff.net>
In-Reply-To: <20181019164237.GA24740@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Oct 2018 18:56:50 +0200
Message-ID: <CACsJy8DBVBOYsOee5_EREwb6=VS9L+o2AT22zQZHbDMK7Hj_LA@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on the_index
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 6:42 PM Jeff King <peff@peff.net> wrote:
> > > I don't see anything in the "Kill the_index, final part" series that
> > > would need it.
> >
> > Yeah. Killing the_index is just the first small step (didn't look that
> > small when I started). Now it's all about the_repository ;-) and we
> > have like 400 references of it just in library code.
>
> I suspect it is much worse than that, even. There are many spots that
> likely are relying on global data that _should_ be in the repository
> struct but aren't yet. I don't think there's even an easy way to count
> those. ;)

One step at a time. I'm already in the process of killing some global
vars related to setup code and was feeling very risky. Don't scare me
away with all other potential global data!
-- 
Duy
