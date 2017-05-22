Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789F82023D
	for <e@80x24.org>; Mon, 22 May 2017 22:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758552AbdEVWwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 18:52:46 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36528 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdEVWwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 18:52:45 -0400
Received: by mail-lf0-f50.google.com with SMTP id h4so39082886lfj.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C8Lp2BmiX0DDfJgX71x6IbUVC1hUJAcSDAfh8IUsKso=;
        b=nGrqD1XFCfA+No5eBCT8lBwtATNQJlTO6rlKpuqPBqgLNVFajX75aqMyS8QCpHWicq
         O4kBS5+HQ6yiqkwgoBkifn5vOl+2o+/Su105mhKo9Ral/ZdtIfvGqBhWQbbugoUMDnmh
         qRYbQuvamIuQVngFfAN2W8jbo0IP7ohwidTYKyj63UCVpt365Be/oSqVB/B/J7yS4qRy
         K6l1mqejwp6CWsW3LubtWFEawu4NYdAFxs9kZ1SqjWzTilW71DChaNe4JMhpoAn9K4ML
         a+NuvtFzEApDxFEgqR0FLjWQWe01Uj2dy1rbairS5aZ3RtOaMafJ5LYS6t6PEfpAxlcc
         x88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C8Lp2BmiX0DDfJgX71x6IbUVC1hUJAcSDAfh8IUsKso=;
        b=O39uaOzqa9eisYuxdKki2dF61RD9y0r/TwRbtv9knqShaPa2CcPfceDzgg3hRR7P2/
         dvGmxN6CAewo4wbmGh/HufnfHoX0HPr7mVAoi08s2PdSTyjynvXrwzDXgzTbnkNz64Au
         1DYK7ciIRZeBvG9RrVG48yIdykAGDrPjOLyOIXSVfw1Rtk0RXFZRUPjx8cXjH7YvN471
         q9KK+OFVWLj0seqWdgOYaNCzRCB3im4wpGoBSfmrc4a90UZEZe0sX/1IeHq0/moGBaCa
         TomIla8R2fa5KTXu1thzq7Qy8p2/muJBShvleP9JQfdMx/6TzY2cOO+PQZrKo5YRT0cc
         kpAg==
X-Gm-Message-State: AODbwcB7sOphIPz+8ecYJH1OiYGq2ghcc/wsYA7C3mVaBGyfPRp91bxb
        0Qj8fa1tAbtTq0FQRMY3Y514KU35wQ==
X-Received: by 10.46.0.65 with SMTP id 62mr8016513lja.83.1495493563735; Mon,
 22 May 2017 15:52:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Mon, 22 May 2017 15:52:23 -0700 (PDT)
In-Reply-To: <CACsJy8CN0ZvWD6v2vkK3Lbt7xgrMwCjFKT6Nx7HtwZiEzmowpw@mail.gmail.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com> <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CN0ZvWD6v2vkK3Lbt7xgrMwCjFKT6Nx7HtwZiEzmowpw@mail.gmail.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Mon, 22 May 2017 15:52:23 -0700
X-Google-Sender-Auth: 57iVtopoczXj1AGXqh6TZ1x9eHA
Message-ID: <CACpkpxk4X+hvmWR_ohHaKpJiiJe5pdZYcdRYjZqk=Ae0416w2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishearth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What work is remaining for prune-in-worktree? Link to the relevant discussions?

I might be able to take it over the finish line. (No guarantees)
-Manish Goregaokar


On Mon, May 22, 2017 at 4:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, May 20, 2017 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> By the way, doesn't nd/prune-in-worktree topic that has been cooking
>> in 'pu' supersede this change?  It not just protects the commit at
>> the tip of HEAD in each worktree, it also makes sure the ones in
>> HEAD's reflog are not prematurely pruned.
>
> You have probably noticed I have stayed silent for a long time (and
> probably will continue). But yes nd/prune-in-worktree should fix this.
> Unfortunately I will not be able to fix it up (I think Michael
> responded on my last question about the proper way to fix
> files_for_each_ref). So anyone feel free to pick that series up and
> fix it (or drop it). For now, pretend that I'm kidnapped by aliens.
> --
> Duy
