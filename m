Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2D51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeKFENB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:13:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38979 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFENB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:13:01 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so14149772itl.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZMPGb828XqkkuqYdQbPgod5LblntAetQEFzY72B65s=;
        b=HjwX/e8TebEaVpYorqYOkecoEyNclZiHDwK5tYZK56wkhgiQw4YlDoblQL5bbYtB/R
         LYIji6w41eNOWCw26+BYZzm9QFavhTSjvURHY9o1IyY9/9Ywm6KIE9qQ1AW7JK3VksQF
         MR6UeijppaQRF56pcskp6iFN/mgqXosYl2jqIBw5fI+8S0nYdFZmytB6EbUETJVIA7p1
         tI5Lc6JK9xdGxmmepAX7LqQaL33vM0HYxpoxjD/XSydoRr8Pt0GSS1lZGS9M80zmb/vn
         EyKSFmqCh6ucxvInqPM1qVO3WgUUCQeVZVeEVJWRJVinFfuCSPse2iZp0gXKZf8Q5pAX
         uz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZMPGb828XqkkuqYdQbPgod5LblntAetQEFzY72B65s=;
        b=d2Ts86OtW7wF0YcnTOiAJ15eHpimGJ+1jgTPzs7U/j4wxILEeGSxEyBWWHeoFXJU4w
         xJ8Mw4kvD+vLS5Zcya4Kv0zoieSqU5tzS7WKeiVPeqFEAEAWb6KWBboTmaZwO/W8ZuTV
         F3yrTQ4DPgxaVK24OumoHb0uWpcWRSZy8b1vsjW3aieKG/yrLQlAelVYgBV2/D+/Mw9u
         8/Y6vzWbAKpPt65MH0JayonRS5LKlydUhHx9tq2kXzmYjFyItTT06T85ZVS1zdy2zbHE
         M6LD3B6vk8TYQeBmHNvxKihltmZpJFbnzjypvim83+oPPS2ZFsnYz6Y10LMhTyMDP28n
         mjVw==
X-Gm-Message-State: AGRZ1gKuivjNCTQMZJqvSwgtv6hN/kQ1QsG4sBtqs/tXJ43bNdsxPizC
        gEoDTSbJG22Y46Kx+2VYfVZkZKxtYd1GpvLWmxn8og==
X-Google-Smtp-Source: AJdET5dV0cjtBxVo9AtJQ83p0svlYGsK4qh3EHoNRGH0k2U7tDzDUC8m51g3k1HeObk5VReFERZXWqXm9HFtHh8Ezgs=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr7779207itg.70.1541443919871;
 Mon, 05 Nov 2018 10:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20181105063718.GA24877@sigill.intra.peff.net> <CACsJy8Dz5Meu2fnNOiFXcw4LTROxBAn05OSZhYBih7ac0jQFzA@mail.gmail.com>
 <20181105184900.GA30690@sigill.intra.peff.net>
In-Reply-To: <20181105184900.GA30690@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 19:51:32 +0100
Message-ID: <CACsJy8A3JTY8+3s4nWYGU6Y=Gq5QEUk1ZCLpbrmr8oV1c0jO4g@mail.gmail.com>
Subject: Re: [PATCH 0/13] parseopt fixes from -Wunused-parameters
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 7:49 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 05, 2018 at 05:51:07PM +0100, Duy Nguyen wrote:
>
> > On Mon, Nov 5, 2018 at 7:39 AM Jeff King <peff@peff.net> wrote:
> > >
> > > Continuing my exploration of what -Wunused-parameters can show us, here
> > > are some bug-fixes related to parse-options callbacks.
> > >
> > > This is the last of the actual bug-fixes I've found. After this, I have
> > > about 60 patches worth of cleanups (i.e., dropping the unused
> > > parameters), and then I have a series to annotate parameters that must
> > > be unused (e.g., for functions that must conform to callback
> > > interfaces). After we can start compiling with -Wunused-parameters,
> > > assuming we don't find the annotations too cumbersome.
> >
> > Another good thing from this series is there are fewer --no-options to complete.
> >
> > About the annotating unused parameters related to segfault bug fixes
> > in this series. Should we just add something like
> >
> >  if (unset)
> >     BUG("This code does not support --no-stuff");
> >
> > which could be done in the same patches that fix the segfault, and it
> > extends the diff context a bit to see what these callbacks do without
> > opening up the editor, and also serves as a kind of annotation?
>
> That's done in the final patch. I did originally do it alongside the
> actual segfault fixes, but since it needs doing in so many other
> callbacks, too, it made sense to me to do it all together.

Oops. I guess I stopped reading the series too early. Sorry for the noise.
-- 
Duy
