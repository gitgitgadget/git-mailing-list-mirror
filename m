Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10971F45F
	for <e@80x24.org>; Mon,  6 May 2019 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEFJeg (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 05:34:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37552 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 05:34:36 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so7066797ioc.4
        for <git@vger.kernel.org>; Mon, 06 May 2019 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmDXPltilkp1JxvTvK9i6gBCkmlwSfXaR/j2bQg1Vps=;
        b=ZzuqcUO0nJ37kSCQ7Xp6yLfCuzt2mh1q+nXn10pbjoSaXsT4LHEF5lSpJMGI5OIr7Y
         ZiMyJGWAf8tMk/CcM45jKX5KcEXpCaWD2nrhcr1nXz1tTZ0iaJEg+yaqfcnW0IJuyVQq
         btG4besdjk7/cwSCvCKmkhuRXwwmz78HMtsC/MNTPOTnY6n1q1kXhVCfoBw6oZ4jDnk1
         hI0KGmjodwSXFheTjrUKeUuBAt9dtfo1KlE6f4hhxIUsc8DPMmxUNUem/7tUU9t5CUD0
         4IJrhg6TcJkssFpVNiiubg0tlW7FHff7TEiNs9LW70isBjcWDXorWv69zAE95CqpId3J
         FF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmDXPltilkp1JxvTvK9i6gBCkmlwSfXaR/j2bQg1Vps=;
        b=hagUXEmXt9Ij0pMNO5rH9zzUtwerGPpCAJG7yeFWIrKG/nyb5Fzgzf/UClqM9vpciq
         1a6652gNdOxStIZE2Up+cVxQur8qHANyl6d2uMsxP4smIMGESFDnTTrYF9/8QtSnNVF0
         8nz26elFswJ5pQJCLCRyCxW+i+nnLHxETc2AjXGohbPavHFiUZX8lPZ+dWBIBt5jFkm8
         E34xxyW3oRIl7PPYcibhxIFjvl+jkLua5GZWdzlVeK+DJimjFnUO28rEhtUXlzM30apO
         NdOPIj2qHiunPgeq2f2UpdluWtEmyhIpEXhc8g4FY3zayy8qlD7ynaC5m3UATnhF+Iyf
         PKJQ==
X-Gm-Message-State: APjAAAXpw44gdSDUupoFtmfQjwc0aHLEMrgq/wy+nu+wsMuAhdFc+PAj
        TXyldx6FcOH6QVW+9f99DyZRgHiiPlpiozOpWvs=
X-Google-Smtp-Source: APXvYqxailEmGfaqXbkjdZWXev4Q8tKsCZoJBnnJPLZBF6ZaogM4E9d7/ig8pcCQFOp2uase+0NnLcNkHD5SN+Wt12A=
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr7164811ioh.236.1557135275516;
 Mon, 06 May 2019 02:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555487380.git.liu.denton@gmail.com> <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev> <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain> <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet> <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net> <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
In-Reply-To: <20190506051148.GB30003@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 May 2019 16:34:09 +0700
Message-ID: <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: optionally process every source file at once
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 12:13 PM Jeff King <peff@peff.net> wrote:
> This reduces the time required to run make coccicheck by a significant
> amount of time:
>
> Prior timing of make coccicheck
>   real    6m14.090s
>   user    25m2.606s
>   sys     1m22.919s
>
> New timing of make coccicheck
>   real    1m36.580s
>   user    7m55.933s
>   sys     0m18.219s
>
> This is nearly a 4x decrease in the time required to run make

Whoa.

> coccicheck. This is due to the overhead of restarting spatch for every
> file. By processing all files at once, we can amortize this startup cost
> across the total number of files, rather than paying it once per file.
>
> However, it comes at a cost. The RSS of each spatch process goes from
> ~50MB to ~1500MB (and peak memory usage may be even higher if make runs

1.5G should be fine. Trying...

Even with no -j, my htop's RES column goes up 6GB and put my laptop in
"swap every bit of memory out, including the bits handling the screen"
mode :( I don't think it was even the peak.

It's probably a bit too much to ask, but is it possible to handle N
files at a time (instead of all files), which consumes less memory and
runs a bit slower, but still better than the default mode? I can see
it already gets tricky doing complicated stuff in Makefile so "no" is
perfectly ok.

> multiple rule files in parallel due to "-j"). That's enough to make some
> systems (like our Travis build!) fail the whole process, or could make
> things slower due to swapping. So let's make the new behavior optional,
> and people with a lot of memory can choose to use it.
>
> [peff: modified Jacob's patch to make the behavior optional, since
>  people reported complications due to the memory use]
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
-- 
Duy
