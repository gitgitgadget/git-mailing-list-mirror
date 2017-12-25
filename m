Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8A61F406
	for <e@80x24.org>; Tue, 26 Dec 2017 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbdLYX6g (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 18:58:36 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:41135 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdLYX6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 18:58:35 -0500
Received: by mail-oi0-f45.google.com with SMTP id t78so22975424oie.8
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 15:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iAeVg+teMOCmuDuYopmGX3z8GzjpnZgUBwXTjgY0tTw=;
        b=Q96aQJEbaVw7nCxrh0VYeWlNAaWO+3tRruaxA3JlT+0cWxX7WGK32JynhUOmR6jHq1
         bBGbw9V/NY7vfn1GCiVpiHLz3x/q/DJrXSiZZd0q1TJ/8ynP5iGpuXVbwEQhxD9ZIlgX
         oo6J4r3/+KVlGOsb0kdvzQJVszuRLItbODrNQodqbw3eavPqCvFSR9mwPGks3loEjN0T
         Zu5yaMTDzW9CPqaV5zb5WxfZDCUsOZ+5C2Y5+NBmLTLzI9RbQ51OR2hGEbTd/3l7NHod
         fcC7RQIgoSxW6HmF/HXpCg49tCjHNL/qW7X0JYFlirpVzacQBtsuCcDw3OounH+byUtU
         dLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iAeVg+teMOCmuDuYopmGX3z8GzjpnZgUBwXTjgY0tTw=;
        b=aRSHhVQTYF7DMGXv0XdbvAHTAnochuwd6iTTwSyZmXjWIjG2spp8h2CGC0ugv+0cfM
         gEOrZ3q2SxAkE0Yecy/N9mkgbrEegSfywBZLE7Guw3Y00OaqB8B4CVM4R/tJIsGZTxSW
         IgvZxSANQBmOHF5vI+WQxlMbWy+s0LjhKNHfBclhHJqsqfHWfRJaAUfD03enB2otW6T9
         Ia/necDsSRJ4J7vJuMXdLjKLD1rwzDcv3GDMyYQc2ZG7Ok6FNzDqKy+Ve5NQlv96Pry9
         djgUL8jT7yWM4TZHhRn5vo5beI8RG00kztReH8un3LfbGz5xMOFPMMLkGG9Mr2yFj2FQ
         rt+A==
X-Gm-Message-State: AKGB3mJB/8qsT2rX4vOenRuNy332SLbYMop2JpbtDO+ZVWT74iX5jBH0
        bfMWmFgJPe6k/eQ78FEWnw5j0sxGGV1cHn6u5C4=
X-Google-Smtp-Source: ACJfBovHbx3vq3zWwIrs5OkKp2YeABCpv/cleVtqV1oWkcJD8ckz6J3yzVQE1/FsLbXBN8JdmjD8VXqXAnzimb5brdA=
X-Received: by 10.202.208.147 with SMTP id j19mr18060228oiy.268.1514246314420;
 Mon, 25 Dec 2017 15:58:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 25 Dec 2017 15:58:03 -0800 (PST)
In-Reply-To: <CAKm4OoWgB7tz0HJorDzL9Xy+fX0LVE1eOVngrfMTMDQQUTDk4Q@mail.gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-9-liambeguin@gmail.com> <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
 <CAKm4OoWgB7tz0HJorDzL9Xy+fX0LVE1eOVngrfMTMDQQUTDk4Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Dec 2017 06:58:03 +0700
Message-ID: <CACsJy8CS8Zub=XyzU5VJtVZqcttN0v8TKShbH6cgWxN03y33ew@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 10:39 PM, Liam Beguin <liambeguin@gmail.com> wrote:
> I'm curious, how did you build to get this error to show?
> I tried with the DEVELOPER 'flag' but nothing showed and -Wextra gave
> way too much messages...
> Did you just add -Wignored-qualifiers to CFLAGS?

I have a custom CFLAGS, created before DEVELOPER flag was added, which
is -Wextra -Werror plus about 5  -Wno-xxx to shut gcc up.
-- 
Duy
