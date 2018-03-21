Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C521F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeCUTLk (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:11:40 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56190 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeCUTLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:11:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id t7so11717956wmh.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fB171DyYQLW/J1atbphkZoWTmn1MulhanhpW9ZVuW6E=;
        b=LGlb4sqK1IL5otPgif+g5V50MCSLZQavwGv/RZ9tA2A9z03VWvfnsTbr8bfP/iZcFO
         /fCzbmCuKhD1a7H3fu3eHnQYn+7oz6Z26fg/1Y1F47hknoco6Zo3KjLc23u7yZbke7jR
         Q90tX94yPAl2nKBYwqpvxxQjSBUEC7MyfQrCajoXfDgUpQar0uKzQgZTkjooQXRyHFzA
         gbP3Q414nEEIUYoIasszSXtW2BX6FX9Z7bXwRlVvADtSZEaN4e+47/ILnSuCW7oksoMQ
         F/3K8ersAclVZX3VOVuMFGWt+q4NCPNhByQXgrH3Qnf/f0Mgwvel8PBVfjS8UrEcZ9oS
         cG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fB171DyYQLW/J1atbphkZoWTmn1MulhanhpW9ZVuW6E=;
        b=XRINkr6NSsRsv84whxHplYH1f+oHSzx4LeZXB53pNYvyIu3WTO4xQRArENkYVZqJM2
         XASqudZnWibWq7kUpbChwg9OwG/yZh3Y9kWcLaMyyHRGgV2c7Xog3odzhXs9GZz/dCrp
         QrJKq3MRtuTxWpvVDhn9hnRKpYzBhyKrnuRjw8SzrA44fOM2ZVa5JdFebZupvXiw/y23
         Twb6Z5TSCiuJy+kiKFBu2Kq40ypRYP8d8c9r/8A0pxrGSK47gJCCPbDUTCnEUw8tKYmB
         ZIsxRlGRB/vPenEBx8bVkNqLLrM35bQjC9NQDkZw21E+3rRD/xaMupLBroRvpKAypjRF
         Q76A==
X-Gm-Message-State: AElRT7EgI6jeR227uHW6oaKHhZl4GjsngvSlVbxbtmVILw5CgEY04+lO
        NTF0R4A/hW6T7qQyBZgKft0=
X-Google-Smtp-Source: AG47ELtybaok6D7NF9YSOZ7TDPpWR9oAtAH9zh7GXpD8aFDwxPyHfW7DIckVR5eyDzZzIHGjTwkfyw==
X-Received: by 10.28.145.76 with SMTP id t73mr3818111wmd.77.1521659498408;
        Wed, 21 Mar 2018 12:11:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7sm5044550wrg.20.2018.03.21.12.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 12:11:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180321082441.GB25537@sigill.intra.peff.net>
        <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
        <20180321164629.GA27584@duynguyen>
Date:   Wed, 21 Mar 2018 12:11:36 -0700
In-Reply-To: <20180321164629.GA27584@duynguyen> (Duy Nguyen's message of "Wed,
        21 Mar 2018 17:46:29 +0100")
Message-ID: <xmqqd0zxp7kn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> And we could even do something like this to make custom builds
> easier. Some more gluing is needed so you can set this from config.mak
> but you get the idea. This removes all limits set by this
> series.

Yes, we _could_, but it would mean we would have many variants of
the codepath that is pretty crucial to the integrity of the data we
keep in the repository, all of which must pretty much be bug-free.

> Readability in pack-objects.c and object_entry struct declaration
> is still a concern though.

Yup, a change like this does not change the readability; personally,
I do not think the original is _too_ bad, though.

