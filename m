Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524301F424
	for <e@80x24.org>; Tue, 24 Apr 2018 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeDXTDa (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 15:03:30 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34898 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDXTD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 15:03:29 -0400
Received: by mail-yb0-f195.google.com with SMTP id i69-v6so4825684ybg.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zET42x2OIXt8+TspraVj33+97cbSeCop0YkQf1wIi6k=;
        b=iODO6AM4IGj2WpI3Pdcu3z46ELAzxIyyaoxpnlIY04Ws8+u5xM0gwYM6mrHMZ5xC6S
         26GS6hzwgAymDbp9P/YEayNllQXLYHOajIRSBq5I1IVXQISqOX6gRjmkTfPUvrNRYTBn
         SzF3+3jd8uI9CCuxY3P+GHAIaQfzHyiNqCbt9vqEIQg68o+hAUM7ZLUVBlMeMtAA+fIj
         MA++GG6sm+oSb3nyL1AcD7d2QrSWFQ2LsiG8x0NatZxIgUMFyMBnVRzmV535ZVI/w2kf
         W54+ycN96wlWFeqvuLqviTjAADSvB5FmKSrb6ENbJK+SFFmHieUEFRR9OrXef937s+uV
         wD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zET42x2OIXt8+TspraVj33+97cbSeCop0YkQf1wIi6k=;
        b=CpJY4i90oDWayg7nrNdkSzNF7K9HWXjbPg42DOJyBoqDU3bz/zAopkOU/g1UIZBTB1
         bVF9pfGjdVvdvC/DVbPTxOReg+frB6BXgEp4N5AVWlfxOOJwxLdBsBxtuGZC0UpXGRNe
         pnN276u9eqbseZNkN2BywC7w+dbeZQHf0sdORHGtU8NCp20PirucO84ar+GS3pv5y5vT
         UrNRwkCZgA4QynUshf16orVV+cu0jMHn6K0peQViUwln6IxpSjMvKLgaY2TZankLT78L
         66Aq38ALwnuFnlKeMeV0tD5J86ZmFmSnAfYKyhWKBn7sp0FY3noevoekOin/aQBqcd9N
         HQ5w==
X-Gm-Message-State: ALQs6tAmXmMMxT8wT6AFVwB0V1yS/NvqV49WJ+hN9ZinLOxqP1gfh1rt
        C5eQjlGzBGV2zFaw8CPgPvnDBVuVV2yQLSDzDKigIqlj
X-Google-Smtp-Source: AIpwx4/UBN7d/X06q+KVzBvKJHujZvXYQJoRoeSPkJ84I9GNTMgYklTF3r4aps5dcJWAXD1NR5v4bkQ6SjMZ1o5Ssgs=
X-Received: by 2002:a25:fc16:: with SMTP id v22-v6mr14735805ybd.247.1524596608195;
 Tue, 24 Apr 2018 12:03:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 12:03:27
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804242048360.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
 <cover.1524303776.git.johannes.schindelin@gmx.de> <f962f8043fb1125b47090a82c35e2d67d3d9d216.1524303776.git.johannes.schindelin@gmx.de>
 <CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804242048360.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 12:03:27 -0700
Message-ID: <CAGZ79kZgpvcAzpttwHyjnSDcfGYa0gfKRBG9zBqiXfBZetGLtg@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] replace: "libify" create_graft() and callees
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, Apr 24, 2018 at 11:51 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>
> Oy vey. How many more mistakes can I introduce in one commit...
>

I ask this myself all the time, but Software is hard when not having
computer assisted checks. The test suite doesn't quite count here,
as it doesn't yell loudly enough for leaks in corner cases.

Thanks for taking these seriously, I was unsure if the
first issues (close() clobbering the errno) were sever enough
to bother. It complicates the code, but the effect is theoretical)
(for EBADF) or a real niche corner case (EINTR).

Speaking of that, I wonder if we eventually want to have
a wrapper

int xclose(int fd)
{
    int err = errno;
    int ret = close(fd)
    if (errno == EINTR)
        /* on linux we don't care about this, other OSes? */
        ;
    errno = err;
    return ret;
}

Though not in this series.

Thanks,
Stefan
