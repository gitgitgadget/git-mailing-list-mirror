Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2041F97E
	for <e@80x24.org>; Sat, 17 Nov 2018 06:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeKQRIY (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 12:08:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53453 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQRIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 12:08:24 -0500
Received: by mail-it1-f195.google.com with SMTP id r12-v6so1184146ita.3
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 22:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QnvNajSzFP8hnIifn9loiJdcQR1DPOIYT2QFX/DelLs=;
        b=VSCSjGP0QMXKxmJHX3qA+s7hw0qXhQeHGQYK6lTHlQoi4hhyWk5lrysLyk8T/ooWLt
         hGiF0c/6ZjPes9faihi0FglXl5K+07S1k1YXy6wjEkj3LJsG58fNIFbOkVh++rGZ5wQm
         xxRgI0kMElP2W2/e5pDKVBKokDxV4nsK3ieFZaPBDjB+/mJAtJnO+dyJhTcnGX2cBIBz
         F8I9CM7GzcuvOC6W+gkHqpt416VBLb6ekhK3cK6NTZBTz01SPP29Y7gcVOyaqSWiFfFt
         oZC/B9zf7xAkoS3g0aXoPqhklP5psD7XGXByIGhOeJ3rCLUb8G888d05CXkcEKIkYAkY
         K38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QnvNajSzFP8hnIifn9loiJdcQR1DPOIYT2QFX/DelLs=;
        b=H2PrEfutNSDZmCP5+8wq/+ObiW0J3L+SI6fZBVST7x+BgHS1k7fcVgWfkBtK88SlfC
         97Niq/a898St/Ih+IT4pDn9buSEgAHM5jtzAb1SJYAAjW6syW+2Ftm3rCAtBRuc1GiSy
         AAV7dLqqV4oh9C8JW+1C3z+3SGRy8wTJYkkBIALMjM0eJNIMbkfeJYSn+47UfAuxnHNn
         0ZLJvecTFjWAUsOrchonJRJeFc7xJKNICfKzVswt7k7GqhxN+kvWL/hd+xNE5Tqj+mE0
         +OB9xKlC1sTLthdKNyiyB4k/MyVdirbN38kQ3WFLBvwgJzna5ShDwdAa+O2l3kyyx78w
         aZ3g==
X-Gm-Message-State: AGRZ1gIHL8uhJjzjEwBjAJi5hYXU5z4ptYnrppfVDgzZh6WOS3UeYRh8
        NpAYmIoQvqWETFOMu/0UNFuBdMMwTgf/HY4PVWI=
X-Google-Smtp-Source: AFSGD/V25ilVRhJVrZ8/xMwjWsEt3G9jDmPpe2myXMt+WGjAvuKnt3Cq48yOTdRODMOwDEqUicpKjNl6p717TEK4ea0=
X-Received: by 2002:a24:dd3:: with SMTP id 202-v6mr1229566itx.54.1542437562888;
 Fri, 16 Nov 2018 22:52:42 -0800 (PST)
MIME-Version: 1.0
References: <874lcl2e9t.fsf@evledraar.gmail.com> <20181113153235.25402-1-avarab@gmail.com>
 <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
 <8736s43mps.fsf@evledraar.gmail.com> <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
 <20181116190716.GO30222@szeder.dev> <CACsJy8DS1JyuRFyKhVRnVt+ax40+yyv-OVknfQ82OO9jtMeK8g@mail.gmail.com>
In-Reply-To: <CACsJy8DS1JyuRFyKhVRnVt+ax40+yyv-OVknfQ82OO9jtMeK8g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Nov 2018 07:52:30 +0100
Message-ID: <CAP8UFD3sX4YPmyXtxbcL3-TZEyd_fq7MuSZkYeNGvqswuF4Ncw@mail.gmail.com>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same permissions
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 8:20 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 8:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>
> > With the default 20% threshold a new shared index is written rather
> > frequently with our usual small test-repos:
>
> Side note. Split index is definitely not meant for small repos.

I very much agree with that. It makes sense to use them only for big
repos and big repos usually don't pass a 20% threshold very often.

> But
> maybe we should have a lower limit (in terms of absolute number of
> entries) that prevent splitting. This splitting seems excessive.

I would agree if split index was the default mode or if our goal was
to eventually make it the default mode.

Or it could be a new "mixed" mode for core.splitIndex (which might
eventually become the default mode) to have no split-index as long as
the repo stays under a lower limit and to automatically use
split-index when the repo gets over the limit.
