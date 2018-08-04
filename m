Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBB7208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 05:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeHDH4C (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:56:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37541 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDH4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:56:02 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so11444304itf.2
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QTW37It23G48Z/tne5E0xn8lwo2ndecN6IS2BjHM5x0=;
        b=Dya2/NGQ1cNO3F7vny/CewYhL0jYGeVsuR2Ptqab6gzBTz5v6W+bAK/CrNBzOsWoSb
         vXFEWwhukU0LuZYR4gzTldW2ERQ0Z/oMN+Esju5/T7fDPe0qFPppy1BEMpz3QsszeRdQ
         zxdSqdYv8zGMs+py8Bzr/tTOsSIKuxuJOrq7l7FFGKEudUEns2AvvjgXiBAwbAAWwN8g
         M7O8EOHRCS/9ooyNXqi64I45g0zF1pLQJ0khAKFAZXZ/ie1peGL+7uq0XjCnfXyHiLrG
         ZyqY/U688F8cdF0gDnCWt54xElaDIlALRIQykgf3Nuz8F55t7jp10VmdE/4Q1iHy/XP8
         njXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QTW37It23G48Z/tne5E0xn8lwo2ndecN6IS2BjHM5x0=;
        b=QrBXh0L7VTf6HnHzQuea2axiYtRPKG8CMtz3WZ2yBKcGqzr3q1EJQ2YxVbmgylm1uQ
         F5hOhOEO7VlJ8ie6lXvhOmZ9SliF3vYHsQcv2b5ANF0bHdhdt/kWSGmyM9y4FajLj4Lt
         U46gXcEQ8dtfzU2XZvGgru/ndpH++KEYPE7eXccVrRZYiy758vpX3nFvW5tGTSQkFPLw
         GnBACRuuo93+2RBqqGPKmPD69NAQxFXhMVCWo6rsxe6s7uFMzfP5xojpfWj8QNU5MNAn
         dZBnrbxq1TyDXAQ80bKBNvP9/MoWyfTpxRlTrxb8tMTWMcRNFwncyJ81AlJOmpXlvf9f
         b4gQ==
X-Gm-Message-State: AOUpUlHunxOk2qadXTucWLKQjkJgy/O8wSLS6KpMNa4EDSSYEqfa0R+f
        0yTHtcu25Mc6p6JAAkmHuc8/4hQgOy+rP7EoftE=
X-Google-Smtp-Source: AAOMgpeLSJbk4Oy9W1iE8IVkBfqYWLhQA/02nCPpcz0R2Ziqwy8Ajcj/wuTvqmYgwmwj3ts8BJr4NdUgEgcEtdUOch4=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr8418836itf.121.1533362195754;
 Fri, 03 Aug 2018 22:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180729153605.27298-1-pclouds@gmail.com> <CACsJy8AKHo4g5607GdiuLVBy1746gEEFbsYjB2RLwvQvE24Sgg@mail.gmail.com>
 <20180802193912.GB29084@sigill.intra.peff.net>
In-Reply-To: <20180802193912.GB29084@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Aug 2018 07:56:09 +0200
Message-ID: <CACsJy8DRQqTTV_vqxxV5dG_+UnONWNit76VMqb0=MdXsvH+2-Q@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: document about thread synchronization
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 9:39 PM Jeff King <peff@peff.net> wrote:
>
> On Sun, Jul 29, 2018 at 05:46:17PM +0200, Duy Nguyen wrote:
>
> > tOn Sun, Jul 29, 2018 at 5:36 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> > >
> > > These extra comments should be make it easier to understand how to us=
e
> > > locks in pack-objects delta search code. For reference, see
> >
> > Side note. I wonder if we could take progress_lock() less often in
> > find_deltas() to reduce contention. Right now we take the lock every
> > time we check out one object_entry but we could pull like 16 items out
> > of the list per lock. I don't know how much actual contention on this
> > lock though so maybe not worth doing.
>
> I doubt it really matters that much, since we hold it for such a small
> amount of time (basically just a few pointer/integer tweaks). Compared
> to the heavy lifting of actually loading objects, you're not likely to
> see a huge amount of contention, since at any given moment most threads
> will be doing that work (or actually computing deltas).

That was also my assumption when I added the lock to that
oe_get_delta_size() but it seemed to slow lots-of-core system
significantly. My theory is when we do small deltas, turnaround time
could be very quick so if you have lots of threads we'll end up racing
to hold the lock.

What I missed here though, is that we do try_delta() on the whole
window in a thread before we would need progress_lock again, so it's a
lot more work than a single try_delta() and likely less contention.

>
> Of course I could be wrong. If you hit a point where many threads are
> skipping work (e.g., because they are considering deltas from objects in
> the same pack, and skip forward without actually doing any work), then
> they'd be ripping through the find_deltas() loop pretty quickly.
>
> OTOH, in cases like that (and the ultimate case would just be running
> "git repack -ad" twice in a row), the compression phase seems to go
> quite quickly, implying we're not spending a lot of time there.
>
> -Peff
--=20
Duy
