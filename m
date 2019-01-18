Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E878B1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfARSHT (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:07:19 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40701 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfARSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:07:18 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so4967575uao.7
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oX1lrIyAg+lL7ILltI1J96l9t187KevvXewlKiFCCM=;
        b=M5oFWxkwMJWIlPQdSuPY2DWqrNA1ASjD+B8P2GqaDES9K7wZQ2XbOZNyjfqZCHcTDo
         EFmaoWDa8/HsXTx/Xgw01c+gfq7QjjYV1KYp4D38vujApYf+5pce/mN3/vpQQcoKy5OE
         QM40HehKzDKIkSGUCccSoNN52pRxLIzIM4ekfzUwUm0jr6hm3oaGFpDmI3Go/Eyj2LXo
         sqO24uefB9k4+21fBoQhxUQLNLthWUN6qpJzEOL9a1t6o5yf2lNbeyBS4SRLWQpXEWeR
         pXxMSGMa30oXFmqRcER4FiKj+97/wZiPj7lIktWiQ68x0zmkAY/2l7qMG3zKD9tmmKNU
         +1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oX1lrIyAg+lL7ILltI1J96l9t187KevvXewlKiFCCM=;
        b=A9EqParwrK4U+iMyJ2ehGZ9ysmMhywutUn/ccfQ3WzeOrjMnU5kmm56YxaLQiafNm8
         BTb44MiZIUAH07F4ri51xznWOD+0RyTjyOmCTK5GTA8GYtElH+/9TQ17m34IiTKpTutk
         bHGJmhQT9ZYyJ1OtVhH9Lzqf4+bVoYhyBcTEtOHIa+wXuvX9AZ176mgRz6qHymuDsQP0
         G13ezVtQ7EVnN5G1ZfFxIi+wMexX79rqFFjU0KlAhZ0ObnDIgutSEWLYw/Wc2jnb8mks
         Gu4tRk6MPJuZfTQv4IJC85xh2n5TiO0Q9ngZ0wj9n1clceSfkpiKCapwssY3kKqnv/3+
         UcfQ==
X-Gm-Message-State: AJcUukefcT2yLAGCTJr8dT44QA2fqwq7TCPlOAnzaknTkwLuTLwMXDR/
        NsYp2/ty/adnYt3F+gvYAouaIYRhcPgoHxZ4Rlo=
X-Google-Smtp-Source: ALg8bN6qwUlBhONCGFyXEook4ljR2PlZQhwo7wbW89sSh6qi5GaXa4un0AABvBifhPQ2lLc5R0vq56DLcz528JshBDU=
X-Received: by 2002:ab0:2508:: with SMTP id j8mr7662142uan.130.1547834837280;
 Fri, 18 Jan 2019 10:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
 <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet>
 <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Jan 2019 10:07:04 -0800
Message-ID: <CABPp-BFRkg7HShJ-Noh=GKJUCh7TO7NpveX5Yy8Pv+1wZiH3qA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 9:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I am about to submit a new iteration of my patch series, would it be too
> > much trouble for you to rebase on top? If it would be, let me know, then I
> > will rebase on top of yours.
>
> Or both of you keep the topics as-is and self-consistent, and let
> the rerere machinery to squash it in when the two topics gets
> merged.

Yeah, I see that commit 8d808e12a2cc ("Merge branch 'js/rebase-am'
into jch", 2019-01-17) has my fix squashed in; thanks Junio.

I'm happy to do whatever is needed with en/rebase-merge-on-sequencer
that makes it easiest for everyone else.  I'm assuming right now that
there's nothing I should do to improve it, but if anyone wants me to
rebase it or fix something up, just let me know.
