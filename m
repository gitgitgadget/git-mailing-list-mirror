Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C522036B
	for <e@80x24.org>; Wed,  4 Oct 2017 00:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdJDAPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 20:15:52 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:43270 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJDAPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 20:15:51 -0400
Received: by mail-it0-f41.google.com with SMTP id v62so9884001itd.0
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I5Cix9ZH/eyuJb4gr+UZsBSkjgaKNVQsLnpTnQrlaX8=;
        b=DnVcVvzmHd3JyGXxVUH9+qR2QQxUpUUlqQWIhQgldFmVELg6O+UPUsC4vkCjJkugnJ
         uoU9oQUYKRJ8DpOvUZqUDZNmfrm5ql+gW4uh9yBPcbGVI5FgLJAg/nP6G5tBgTs2gc1z
         h6GP86p/3P54LgGdp6cT1vkdK+6P7x4eM1NO4Z5iqeICxaT2epql+pcWpsmDvR1roWXU
         6pFEFZkdLxrbsYgE3DZcIS+Dwide8CPxyQQnZDVPiDzFARcqSN08iH+41elyWnZRDIq6
         i8nKyqMWRiyew8z6lJ3invEWpL0rfSEZyGymcvi8R5srmtSh5hpJh6CUVL+dr/i6B9my
         gDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I5Cix9ZH/eyuJb4gr+UZsBSkjgaKNVQsLnpTnQrlaX8=;
        b=KfO0kvpjYkISBBigyMw7O6/KcZLCTcoB1hSqfRYlMQ5aRf9IcVQNPn4VjJqEpKP+xb
         s14wbAEUx/zrFMqDT19IZpaLwAS7eP7baYOgx7Z5hDptWlHC4n2jvGR7ETN8flx/mOwG
         9KG11q5FQ26qN3e+KZhLI8RNZYdSbW2agJh2zR1U5ImlJITWFPI7f3Or7XWq6x3+xyvY
         8HpTXjxuuiJ+NzIEcoo3n8T1Yf06Ahnx4evD2jRHhb3M7h8tXhmOahny4/tpqY7g/u9k
         mKmRuSE6tWDmaSkqpEpkSP5tyeTRoat5/l2dd3ScVIFn9Np+4gnTdIP6y07qedHHEVSZ
         7etA==
X-Gm-Message-State: AMCzsaUjdcdw4I9xQvruizxuJu/WKUvAeh3eYVd3amf2zHuzySNHMItb
        zzbQ7KcFp9WItPAIvskKHeEJRTn5x+cBIx9dbPaJlTSh
X-Google-Smtp-Source: AOwi7QCpvafA/xvwcMjvl/45uyW9WB3jUt3tr9kKmqiJisrDq4yI6+RNLsTy9WTvTZGKAirryG6RA/F+qOBYB8E9Yqc=
X-Received: by 10.36.217.201 with SMTP id p192mr28724662itg.28.1507076149778;
 Tue, 03 Oct 2017 17:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.129.66 with HTTP; Tue, 3 Oct 2017 17:15:49 -0700 (PDT)
In-Reply-To: <CAP8UFD05QzCn53SjbbgaToVWyd=3N+HayDvR4OZNaP7YKbEBfg@mail.gmail.com>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
 <20170916080731.13925-10-chriscool@tuxfamily.org> <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
 <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com>
 <20170929133614.1c0cd68ad80139fafdf68b86@google.com> <CAP8UFD05QzCn53SjbbgaToVWyd=3N+HayDvR4OZNaP7YKbEBfg@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 3 Oct 2017 17:15:49 -0700
Message-ID: <CAGf8dgLD3JR4_oqEM09D6j+izrnXoj8YPr7JfBwKrx2qj=Vkkw@mail.gmail.com>
Subject: Re: [PATCH v6 09/40] Add initial external odb support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 2:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Yeah, some people need the faster solution, but my opinion is that
> many other people would prefer the single shot protocol.
> If all you want to do is a simple resumable clone using bundles for
> example, then the long running process solution is very much overkill.
>
> For example with filters there are people using them to do keyword
> expansion (maybe to emulate the way Subversion and CVS substitutes
> keywords like $Id$, $Author$ and so on). It would be really bad to
> deprecate the single shot filters and tell those people they now have
> to use long running processes because we don't want to maintain the
> small code that make single shot filters work.
>
> The Microsoft GVFS use case is just one use case that is very far from
> what most people need. And my opinion is that many more people could
> benefit from the single shot protocol. For example many people and
> admins could benefit from resumable clones using bundles and, if I
> remove the single shot protocol, this use case will be unnecessarily
> more difficult to implement in the same way as keyword expansion would
> be unnecessarily more difficult to implement if we removed the single
> shot filters.

The idea that some users will prefer writing to the single-shot
protocol is reasonable to me, but I think that providing a contrib/
Perl script that wraps something that speaks the single-shot protocol
is sufficient. This results in less C code, and a better separation of
concerns (I prefer 1 exit point and 1 adapter over 2 exit points).

> I agree that your patch set already includes some infrastructure that
> could be used by my work, and your patch sets are perhaps implementing
> some of this infrastructure better than in my work (I haven't taken a
> deep look). But I really think that the right approach is to focus
> first on designing a flexible protocol between Git and external
> stores. Then the infrastructure work should be related to improving or
> enabling the flexible protocol and the communication between Git and
> external stores.
>
> Doing infrastructure work first and improving things on top of this
> new infrastructure without relying first on a design of the protocol
> between Git and external stores is not the best approach as I think we
> might over engineer some infrastructure work or base some user
> interfaces on the infrastructure work and not on the end goal.
>
> For example if we improve the current protocol, which is not
> necessarily a bad thing in itself, we might forget that for resumable
> clone it is much better if we just let external stores and helpers
> handle the transfer.
>
> I am not saying that doing infrastructure work is bad or will not in
> the end let us reach our goals, but I see it as something that is
> potentially distracting, or misleading, from focusing first on the
> protocol between Git and external stores.

I think that the infrastructure really needs to be considered when
designing the protocol. In particular, we had to consider the needs of
the connectivity check in fsck and the repacking in GC when designing
what the promisor remote (or ODB, in this case) needs to tell us and
what, if any, postprocessing needs to be done. In the end, I settled
on tracking which objects came from the promisor remote and which did
not, which works in my design (which I have tried to ensure that it
fits in our and Microsoft's use case). But that design won't work in
what I understand to be the ODB case, at least from what I understand,
because (at least) (i) you can have multiple ODBs, and (ii) Git does
not have direct access to the objects stored within the ODBs. So some
more design needs to be done.
