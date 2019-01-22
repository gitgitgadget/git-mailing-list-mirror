Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BA01F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfAVUhY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:37:24 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42601 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVUhY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:37:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so15538989vsd.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4iJ5Ri3w/TTzsKP8gZoLcZ4KALuGOgQJ3VDmAgWXyY=;
        b=imKR2Qegl+waKesT4kteOaYOclP//DYONLpHgSEJvCj1yax4CfePbMo0wgfUymknNR
         rUpBucsHoEoElxKMIo12tlJ4CcFCgzPfCN+0oNzQ0NSGtv8R6q5nglOogeYpckd/4vhO
         04PlAcUHrYkC1cLk7Y+GW7pxk19xvdTbDxA/0hzNl2lyr2Q3QUI72iXQBNrU+6gDkWGd
         hfAdsudpUO7c/SMEBly6j+hQEKbba+NjbMRx6C9F0YsLBkxeEjtrdLIXcyIvFm6NsPRA
         VgLelngpZH4OS8xQ24OUD+CUPidPNzv7LeRuc08xCxwS3UTo6/QDNAYhm9F3Kxk7RY+C
         rYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4iJ5Ri3w/TTzsKP8gZoLcZ4KALuGOgQJ3VDmAgWXyY=;
        b=OiuD9m4gS3wZNI5nT4uy6ZEYcVZvFqAXz5DlizqFNEw0jSVoH8+U4fCn2p/ITuxEqi
         MEfIgbKLnfJM3KGo0/uFrQ7YKEfXpNfn4Jnc+wprDbF8GcmX3Zulwc7BJekvtR3ObWW9
         9jTm8KrxvhilTnJujWwP1nC3oKc2KjLqjLNse9aC7BFkGPCIjwhXv5rQ7vRDFVy3sQek
         Ft1PeiaiJ24759FzBAr3R6CHFIjqBu8wfdolQSeDCtOX5GpZVdXXrSetZW8zN6fSlHA1
         pjropJOR4CVIq/5JtF7hDFhh7+RIHQO28VvzYINfFh1E4zA9PcDPt9i4bQn8ryCMtdGR
         upGw==
X-Gm-Message-State: AJcUukf6//PZN4L+rETmo1V6NXqX8NVNpMGWuQYyxj7uAge7v8hPvXYn
        mhEoWKejL05RuLsoClp+lBtPJEW5j8URQb6ixDpAAgNf
X-Google-Smtp-Source: ALg8bN5EFXAmH7U4sHERoNo2LNP3E616BVSoibiqurq0SEAn2FUirhk0X1us05AI4e6tBR2V32kE4palswVg357kfZ4=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr14221323vsi.136.1548189442822;
 Tue, 22 Jan 2019 12:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net> <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
 <CABPp-BFmHkf3ftgKxEA5tx_fngPu7WypP_aYyYUvNVmrAibqtw@mail.gmail.com>
In-Reply-To: <CABPp-BFmHkf3ftgKxEA5tx_fngPu7WypP_aYyYUvNVmrAibqtw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jan 2019 12:37:11 -0800
Message-ID: <CABPp-BHG24Xv=5hNoBJeYCaJKuUS98bymfCMQVUz+hXnZKGMHA@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Patrick Hogg <phogg@novamoon.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy, Patrick,

On Tue, Jan 22, 2019 at 9:52 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jan 21, 2019 at 2:02 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sat, Jan 19, 2019 at 10:45 PM Patrick Hogg <phogg@novamoon.net> wrote:
> > >
> > > ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> > > 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> > > introduced oe_get_size_slow for thread safety in parallel calls to
> > > try_delta(). Unfortunately oe_get_size_slow is also used in serial
> > > code, some of which is called before the first invocation of
> > > ll_find_deltas. As such the read mutex is not guaranteed to be
> > > initialized.
> > >
> > > Resolve this by using the existing lock in packing_data which is
> > > initialized early in cmd_pack_objects instead of read_mutex.
> > > Additionally, upgrade the packing_data lock to a recursive mutex to
> > > make it a suitable replacement for read_mutex.
> > >
> > > Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> > > ---
> > >
> > > As I mentioned in the prior thread I think that it will be simpler
> > > to simply use the existing lock in packing_data instead of moving
> > > read_mutex. I can go back to simply moving read_mutex to the
> > > packing_data struct if that that is preferable, though.
> >
> > In early iterations of these changes, I think we hit high contention
> > when sharing the mutex [1]. I don't know if we will hit the same
> > performance problem again with this patch. It would be great if Elijah
> > with his zillion core machine could test this out. Otherwise it may be
> > just safer to keep the two mutexes separate.
>

Before this patch, repacking an old clone of linux.git on a 40-core
box (an m4.10xlarge) using the command
   /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
based on commit 16a465bc01 ("Third batch after 2.20", 2019-01-18), resulted in:

MaxRSS:10959072 Time:650.63

Since that was a cold cache, might have had loose objects and what
not, I threw that one out and ran three more times:

MaxRSS: 9886284 Time:571.40
MaxRSS:10441716 Time:566.47
MaxRSS:10157536 Time:569.79

Then I applied this patch and ran three more times:

MaxRSS:10611444 Time:574.60
MaxRSS:10429732 Time:571.48
MaxRSS:10657160 Time:575.58

(Yeah, we talked about MaxRSS not being the most useful last time, but
I'm just copying the command I used last time for consistency; I'm
only really paying attention to Time.)

So, it's within 1% of the timing of the current version.  Seems fine to me.


Hope that helps,
Elijah
