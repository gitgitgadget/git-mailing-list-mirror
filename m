Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8AC4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKXJQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKXJQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:16:04 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B05F114493
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:16:03 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12c8312131fso1354396fac.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLu/m6Y8BOl+DRvEgh8qafBxdGNvRwB677z5A39tgOg=;
        b=X3gRUvO03tZNuDWNXTSEZ5viq3w0EPG6w/SKZtVUqvUjqlcXW+leD5FUtuvdUPcO6g
         DmjH2xAPheGQQ6PGZi0dXBPSZLqXUoUYNoKTJX1fNq8Uo9NNTmvCsqUyrTuyl5DS4xWA
         N9bC3yHA1/1dNiS9xLLDwKmiIRwaDzIMaU2xmLPoK/DH5ZUJmjXTyJvy+A1XH3ztMK2h
         ZEQo+EY2ZlDLvGzaJjFr4ePqZq4HjNBNryL2C58KlCypnUnvsb/Llbg/ZL75pZapKi1b
         tLgYUs65QplUNdGg7jpsCRKAGt+vKjAtp2JqFX/f6tYguSVXqFcz7lvmnzpG2cXP6ubG
         6ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLu/m6Y8BOl+DRvEgh8qafBxdGNvRwB677z5A39tgOg=;
        b=c9zSysvuhuiT61q9yTfP9CN+N93K2PhNT7XKOCYc4Xm+H8hWJEYIa6C0LsCHmCFBjY
         Ja72fwfP5bVriS4OrTv7qn4n7RNq/xVybhHIJMNAvpBbCRTXo+vVZjQQSR2h1ELkEAnH
         YODCd9by7NPleFwXVpdeLI3jVqcHCDZpHCVdbcar1WJaaH4sB3r6dmRxeOHauvTmfGJV
         RSDqnyZGBdTDRbVccs0hYRurEk9yyk71yMtYmCXsB7VJ6UKZzbOuu2h+imBGKatPQ0xP
         zwz1YF/jOlE/rePrL5B1xi3BOfxH8mWKY5pZF8liUrRCbRkdZ+3hYpI0nk0osuiaC8Ks
         GNFg==
X-Gm-Message-State: ANoB5pn8244s6r0+vz10CCkv02kFGdNr0ojR96f3vRZ7bZMpGobYLwGN
        nUhcF5k/+UTpNAfT4BUVS4rWlgWf/2RYZ+BFEIo=
X-Google-Smtp-Source: AA0mqf4rvj9wyLOACm6xc1rZ1+SQWgLrLng2nlrzWB/0a3WGo0X6niTAwmwT1nRRHihYBjKSlrX1MeUJqGub6kicVnY=
X-Received: by 2002:a05:6870:d994:b0:13d:9ace:3376 with SMTP id
 gn20-20020a056870d99400b0013d9ace3376mr20602209oab.251.1669281362887; Thu, 24
 Nov 2022 01:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221123150233.13039-3-worldhello.net@gmail.com> <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
In-Reply-To: <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 24 Nov 2022 17:15:51 +0800
Message-ID: <CANYiYbEoar_5kN4jMKuy9Fucpajj5g8TJZrdo3=K1FYDz-2_bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 4:16 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > There would be a segmentation fault when running p4 v16.2 on ubuntu
> > 22.04 which is the latest version of ubuntu runner image for github
> > actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.
>
> I was about to embark on a debugging session when I had the splendid idea
> to look at the Git mailing list archives to see whether anybody else had
> encountered that particular problem.
>
> However, when I pushed a branch with this fix, it still segfaulted even
> when downloading version 19.2 (link:
> https://github.com/dscho/git/actions/runs/3538788474/jobs/5939977231#step:3:387):

Yes, p4d 19.2 also has segfault errors, and p4 version 21.x and above
is OK.  Maybe yesterday I only check p4, and forgot to check p4d by
hands.

It is fixed in v2 by upgrade p4 to 21.2.

--
Jiang Xin
