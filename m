Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6625B1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeBZU5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:57:18 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34455 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeBZU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:57:16 -0500
Received: by mail-yw0-f172.google.com with SMTP id c193so5574046ywb.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 12:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DTwKR5OjiJG4aA+x+JOGnn4QRFexsXusvDAnhWTsVbQ=;
        b=pOkb8yH/wuUjsnvKhx0s+81DbcbCQSWHNUsqY1dpbGfFTBJRLdfFDCbcfznSn9R2oi
         7t/QnjXHaKAiopsS4vbeoWrCSp1n/cYUdQE7Cbn25LjFugb3IzXQV4IPhn33kfMrl8wm
         iQQK9IVm9nUW28B2Pn2PJGQaYqQLCpptYWluSQ5KrHC39QOeT1xQz2W5PFTpkuhJKgt3
         SOGmMtXzcwJjFko4pfGG4UfLQvDk1GeRGtT8WivWrVE2wo6FETBJRAPSyZE3gU3/fnun
         xQFYSGYgq4TyCd/OgK99r4TXl9YhDlTZXzHr63kWV/DdrXbahMGYACU2EsD2c7ZDccPc
         kcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DTwKR5OjiJG4aA+x+JOGnn4QRFexsXusvDAnhWTsVbQ=;
        b=nSCHGtv2nZjRzcISKuoNARiXLzN6bwAvXh+Hf4ixUDJsp61FM6GfZpVWPuY38h1nMO
         +uA43b6LKIDAOMCsqoT6WHJUZVJ6cP9s7/NTKMU+GDHXtc1I8Q0V3iypvH2SE4z7f/p+
         XelegwOLqhrXzL5jx1UrGuatjrCgOYJoc5ZUV/NoGqzfnrBiKUA8XE0Y1vtHZ8gIkd9p
         Qh3m1PGnMsF7uk1x32HQtVJ+Ff2qcqUHfFNrpiEM2aO1My/fMIwQkFWC0nnl6e1C13Ox
         McdFxMC1gu0kpR3njm8gq7t0Sv20Y2QjVSSbdq/FXtsS6KZgI8sTIQwEbScsVomj57Zp
         8wiw==
X-Gm-Message-State: APf1xPCBReTKQelv4rTs4sdzdmnxgf3e8FammEeHVrDYcBwM3TRim8cj
        p7igC2x9/8cf8618nDR8AZnzu1aZYB/j3QMrqGKdRw==
X-Google-Smtp-Source: AH8x225H1+4gfbufPpV39HPh63iEyzge61gLFpu0AQmsHh6q0tEL0j2yLHYqXH3vptZtQtGooVIwt+bn+aqWK3cbArk=
X-Received: by 10.129.73.80 with SMTP id w77mr8268132ywa.421.1519678635614;
 Mon, 26 Feb 2018 12:57:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 12:57:15
 -0800 (PST)
In-Reply-To: <20180226085508.GA30343@sigill.intra.peff.net>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-9-sbeller@google.com> <20180222004710.GF127348@google.com>
 <CAGZ79kahS_mk8gFONUAxBjw7iV=5q1ff-ZgjLnQ7rMw=kBKThw@mail.gmail.com> <20180226085508.GA30343@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 12:57:15 -0800
Message-ID: <CAGZ79kbuPUb6iHJo8B5YzB12oV79ujCR=zaSE=61xrKBRcuHjg@mail.gmail.com>
Subject: Re: [PATCH 08/27] pack: move approximate object count to object store
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 12:55 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 23, 2018 at 02:22:14PM -0800, Stefan Beller wrote:
>
>> >> +     /*
>> >> +      * A fast, rough count of the number of objects in the repository.
>> >> +      * These two fields are not meant for direct access. Use
>> >> +      * approximate_object_count() instead.
>> >> +      */
>> >> +     unsigned long approximate_object_count;
>> >> +     unsigned approximate_object_count_valid : 1;
>> >
>> > Patch looks fine and is effectively a no-op, though what is the need for
>> > both of these variables?  Maybe it can be simplified down to just use
>> > one?  Just musing as its out of the scope of this patch and we probably
>> > shouldn't try to change that in this series.
>>
>> I agree we should. It was introduced in e323de4ad7f (sha1_file:
>> allow sha1_loose_object_info to handle arbitrary repositories, 2017-08-30)
>> and I think it was seen as a clever optimization trick back then?
>
> I think you meant 8e3f52d778 (find_unique_abbrev: move logic out of
> get_short_sha1(), 2016-10-03)?

Yes, copy paste error.

>
> Yes, it was just to avoid the dual-meaning of "0" for "not set" and a
> repository with no packfiles.  It would probably be fine to get rid of
> it. If you have no packfiles then you probably don't have enough objects
> to worry about micro-optimizing. And anyway, the "wasted" case wouldn't
> even make any syscalls (it would do a noop prepare_packed_git() and then
> realize the packed_git list is empty).

Good point!

>
> -Peff
