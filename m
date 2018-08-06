Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2733C208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbeHFSEH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:04:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55878 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFSEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:04:07 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so18063336itj.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+k7W+HML4sBNCXPPw79OhzCZ/se2YGUirAu8US+7Mic=;
        b=QXNUq8vJ9E3dQbjf0lWyP/biaQiWXfG8paSGZfWGHbPLJ1fpYRM+Hx2miZUfzywHVO
         Ls1zWg3fcG489DQzlL7KHTQ8orQdNZVUILvZ/oYQTfjYiwZJiuDE2zWz3Y8GPUd8W1jh
         nwN0m4ypfssA1XQLQdye/iZ3tnDzNBjA/WD9YegaX6iqzv1eYNvkKv9WLJYfhHenmInc
         /0tKg914HPY50jb08Q/OhQWiP1V0Y5O+Ff0Z4rGRzFWa2VtmAr+8KbQZxcWG0fqz7Dsm
         IUt4FQP35SsqdasDPfqBIc6USx37tgArKCoA00TAYigiZe5uN0Owm32ltzpEeIuNvbmC
         HW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+k7W+HML4sBNCXPPw79OhzCZ/se2YGUirAu8US+7Mic=;
        b=Y+nFzeTpJ+fHDQn7HQq3W2A4vElF/grIRsN2Lh7UEM+9D/5qR3A4bD/69iFkpcR1r+
         QkH9qjxlPR6ARJZu/VuQ5yMGxhkiITffIsm/4EugWUdia/Vlcuynk6SeqsADL2QTaypU
         BxQf00FAEgT8PNqfrvrEfIE8mAEA6V2MFP0nzZfpcZE/3rVWJ/suZFVsDulR+AuXQW8y
         Fw+TrA6w7WMAk2BiMUugZkVyuZgRkKf47Bmp26AmYv4cizN1N1feO1CJ13Wfr5oeHFiY
         vj+G50h2+1hm6qpyiwBVJJu5K6wJ9i5OcAKhJ9nn634ejHQvD57BXYpd/urKSgbActAo
         yxMg==
X-Gm-Message-State: AOUpUlEgiSE1wyCf++a0HcQ5JpkNqrhxdo7htwSqVDe1cGwM/GcDMjzJ
        PdZjYH8Sd8tBDGScvnwBA6dKz4AOg+Zdtb+17vc=
X-Google-Smtp-Source: AAOMgpcDG0eVPUxfyd+huh44hOBdy4U+kEfT+I/ishBa0I1ltAgJowAki1/MXsUEvEhOj3HEoCfmTLehc2PMGga4GDM=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr15915603itc.68.1533570863514;
 Mon, 06 Aug 2018 08:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org> <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
 <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
In-Reply-To: <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Aug 2018 17:53:57 +0200
Message-ID: <CACsJy8Aa2xo+jVOPza_wt-EX8P4_M8XJD3jdLs=cr11M0ckUuA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 8:53 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Jul 22, 2018 at 10:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sun, Jul 22, 2018 at 7:51 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> >> diff --git a/pack-objects.h b/pack-objects.h
> >> index edf74dabdd..8eecd67991 100644
> >> --- a/pack-objects.h
> >> +++ b/pack-objects.h
> >> @@ -100,6 +100,10 @@ struct object_entry {
> >>         unsigned type_:TYPE_BITS;
> >>         unsigned no_try_delta:1;
> >>         unsigned in_pack_type:TYPE_BITS; /* could be delta */
> >> +
> >> +       unsigned int tree_depth; /* should be repositioned for packing? */
> >> +       unsigned char layer;
> >> +
> >
> > This looks very much like an optional feature. To avoid increasing
> > pack-objects memory usage for common case, please move this to struct
> > packing_data.
>
> As you can see the patch 6/6 (in the v2 of this patch series that I
> just sent) moves `unsigned int tree_depth` from 'struct object_entry'
> to 'struct packing_data'. I am not sure that I did it right and that
> it is worth it though as it is a bit more complex.

It is a bit more complex than I expected. But I think if you go with
Jeff's suggestion (i.e. think of the new tree_depth array an extension
of objects array) it's a bit simpler: you access both arrays using the
same index, both arrays should have the same size and be realloc'd at
the same time in packlist_alloc().

Is it worth it? The "pahole" comment in this file is up to date. We
use 80 bytes per object. This series makes the struct 88 bytes (I've
just rerun pahole). On linux repo with 12M objects, "git pack-objects
--all" needs extra 96MB memory even if this feature is not used. So
yes I still think it's worth moving these fields out of struct
object_entry.
-- 
Duy
