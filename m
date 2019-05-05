Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEC81F45F
	for <e@80x24.org>; Sun,  5 May 2019 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEESIq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 14:08:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36171 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEESIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 14:08:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so12717131edx.3
        for <git@vger.kernel.org>; Sun, 05 May 2019 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WMJoCdjtBEBL1NChrtGRz1/+RbNSKnHuuxhtLVIEBwo=;
        b=tx1s2hqnltz7Qj4WhsCu6ihrH9o1oz87o1/sNKMVoF9rM1pPxmFPpbRR3rhpSub24p
         ij7/eymPf4fP9TT8c2luyBJHntTYORfX7YE3/8Q9e4mijfIVl/y1g3zavwkI53KOIf2G
         DOkfoYVa8HJrODi/wKWtGGhtdUOj5UW09rOICOV6Xjpa/K1bYdtRmnz96p02bZZFTTWE
         su51rYMVfEPHcpbSjh5a9tIeBr9TWPCinAnuwizm25VL5kt8VjkR7FvZu8fdjBhxP3ss
         dHlljZG69/RZ3X8ClpDTcP7iTLoKH5Pp2vupMrKgyIT3XPSvhBuCoMli5+Z/itgipiC4
         6uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WMJoCdjtBEBL1NChrtGRz1/+RbNSKnHuuxhtLVIEBwo=;
        b=CSMJuOhxfqDta5Y840qGUanUZoBj31gXDsWW43JqlSahxyCJd64towAc0LeZwRClhD
         To2+AjJQDaqtE7J1PpFtZw0UuhqtT6ytjmchrCTRCHDpFH1vJ/lxu62T2w2v4UxbiJHT
         PYIZeJrEIvt5XYRHFeJChUFzvzAc7q146+rt4mO45QwsAp6ogP7MvQfKI/ac19mtQp8I
         uLoYtH3ofHOvkTh1ltfDxbamv39OnZDQL10/JQCpkEo2BfRX4M2U5TkjB1SqJCXts/+x
         KGAj0ngjoVWl1QNeQj036icltA5aBIUjRXUK5EyOL9gsHkbBzMVHgfbI2JQOqSN8+t52
         dmfw==
X-Gm-Message-State: APjAAAVbGLomei1AOiu1iwiS5rbKx2QfMCZ8rP0XqLPPxrCzL8gNszlx
        XwRyjnr//i3J6zQKJnBti4/ySS7Sx//QwOHObvY=
X-Google-Smtp-Source: APXvYqyElYr1+VS01QCqkCIHlkZ/Vpz0DtnsVHgM4qB5UVjsYEA2VQSs/nzKgf+8wG1GgIVk0ZlnO28GaNm7SUNrgz0=
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr21741901edv.242.1557079724346;
 Sun, 05 May 2019 11:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555352526.git.liu.denton@gmail.com> <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net> <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet> <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev> <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev> <20190503174503.GA8242@sigill.intra.peff.net>
In-Reply-To: <20190503174503.GA8242@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 5 May 2019 11:08:35 -0700
Message-ID: <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 3, 2019 at 11:09 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 03, 2019 at 04:42:11PM +0200, SZEDER G=C3=A1bor wrote:
>
> > > Since you *could* include it, I now assume that Coccinelle does not n=
eed
> > > to follow the `#include`s (otherwise, it would have complained about =
not
> > > finding the `windows.h` header in your setup).
> >
> > We invoke Coccinelle/spatch with the '--all-includes' option, see the
> > SPATCH_FLAGS make variable.  And it does indeed include header files:
> > I've seen it find something to transform in 'cache.h', and then the
> > resulting 'contrib/coccinelle/<whatever>.cocci.patch' included the
> > exact same transformation as many times as the number of files
> > including 'cache.h'... which is a lot :)
>
> I think spatch is smart enough not to hit the same header multiple
> times. But the problem is that we invoke it once per file, so it
> actually processes cache.h many times. That's slow, but also produces
> bogus patches.
>
> Jacob Keller's patches to collapse this to a single invocation do fix it
> (and I've used them selectively in the past rather than cleaning up the
> resulting patch manually ;) ).
>
> Sort of tangential to your point, I guess, but it might be a topic to
> revisit.
>
> -Peff


Yea, my patches are much faster. However, they trade off a huge
increase in memory consumption, and from what I remember, the failure
if you don't have enough RAM was not a good experience.

Thanks,
Jake
