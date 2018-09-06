Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A7A1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 09:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeIFOdA (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 10:33:00 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34449 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFOc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 10:32:59 -0400
Received: by mail-it0-f41.google.com with SMTP id x79-v6so19309792ita.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WJtT8vUWsZJ5Y/Our6Ze8qIr3WYfPZUZUR5kPFRj6VQ=;
        b=B9CufZj2iov2JyoRhARvHNHcAQoVz5sEPLXFoV/xASyL1SKSlpS5Hp0Do18Ym+j0Br
         Rsc0n0aw5Oii1UElZbL5N/nfqAD902wA4O8KjwKxFrvhojgBd97AGSDRnMqNGw+/6fRe
         09DZkWLBjt7LECssJ7WD0OzQoDwq930drM5fzc+0jujzjrgQr+zOFSQ6/Sykg4/KdHDC
         e6hjy2CFjIsMcvn6okuhmDUEj2DVafenaZzM3oWDRCWEzu21CQelMMWyVrzYFBlMCNgA
         pdBBdxKI6NXUmFfBHvy7OAfPhq+GRkJZkFXtxIUHWKgcTzpOXUcu0KAZiueaXojIdn0b
         TMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WJtT8vUWsZJ5Y/Our6Ze8qIr3WYfPZUZUR5kPFRj6VQ=;
        b=qStfJnACWwtcBDFBdR0QunntBJDdLyGQJo2ulkDxsMp4TEk/Gx7G/xpNUE+0hAgj2R
         GOfy6NLDEOROrY/ItVj4EO3SxpsAYYhqfeFRKTZY41YURYq9ASI6CZ83A6p3m8X4JjtG
         qEdb0URt/QgPrsa21cFTf7M+r0oUUk3hhqiNB0an2nm1yR5zDSNJeTovb65o+2Mrc9y0
         q6oR+R90+UOBRiEJr3HGWSfJRMuLqcgx+lcaJ+Q0KbROPx/8fMN1OrvNu00XB3vY0AB4
         K+PGyJ0iP+RaTUsLvPzibvNp26TA5JiBbEt3wg/INBEve0TeuiMoSk8YBc5M0LCQg7Vj
         4veg==
X-Gm-Message-State: APzg51DPswx8As8xvLzbyrpLhnHwVfE1AvhnQYG7bp3PUah6Wwgzx70k
        aOlaIzIa8h29vhKZwsvOOANZAxrgG0ir0odcysJgLQ==
X-Google-Smtp-Source: ANB0VdY6NWqLFYa9YHQgzse/3d2yJswJF9kiPcYrqKlrjaRPQ/6rfB8B5THWbMZAO9tVmBu0AHRUtT4qNS8L8iHcKTY=
X-Received: by 2002:a02:a70a:: with SMTP id k10-v6mr1351003jam.47.1536227897991;
 Thu, 06 Sep 2018 02:58:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 02:58:16 -0700 (PDT)
In-Reply-To: <20180906011428.GA5024@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net> <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com> <20180906011428.GA5024@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 6 Sep 2018 11:58:16 +0200
Message-ID: <CAP8UFD3-djatPqoVGNGWNQkuJ84BboFMYrGSAEOQDygjJVcqeg@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 3:14 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 05, 2018 at 09:20:23AM +0200, Christian Couder wrote:
>
>> >> Thanks. I think sooner is better for this (for you or anybody else who's
>> >> interested in mentoring). The application period opens on September
>> >> 10th, but I think the (still growing) list of projects is already being
>> >> looked at by potential candidates.
>>
>> Do you know where is this list? On
>> https://www.outreachy.org/apply/project-selection/ they say
>> "Information about projects are unavailable until applications open".
>
> This was the list I was looking at (scroll down below the timeline):
>
>   https://www.outreachy.org/communities/cfp/

Ok, so it's the list of "communities" not "projects" in Outreachy terms.

> But yeah, most of the "current projects" lists just say "not available
> yet", so I think we're actually OK until the 10th.

Yeah, I think so too.

>> > So here is a landing page for the next Outreachy round:
>> >
>> > https://git.github.io/Outreachy-17/
>> >
>> > about the microprojects I am not sure which page I should create or improve.
>>
>> Any idea about this? Also any idea about new microprojects would be nice.
>
> I think #leftoverbits is your best bet for micro-projects. Last year I
> think we had interns actually hunt for them via the list archive. That's
> a little unfriendly for total newcomers, I think, but it also does give
> a chance to demonstrate some skills. Perhaps it would be help to create
> a curated list of such bits.

Ok, I will see if I have time to create such a list.
