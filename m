Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775D51F45F
	for <e@80x24.org>; Wed,  8 May 2019 20:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfEHURh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 16:17:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35925 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHURh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 16:17:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so28882563wra.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qYOFk6wNv3lozldHoJ07szcbuOREZTKbg87ILnlEEGo=;
        b=KOUeL5dxPsWNSJVrm2r8K6gVIBZmXi8gX5Es4mhAwTTvXR2/GiMMGvHmAoP5vqHeZH
         MfsUoekPx5Mg/LZ8nsU5C7pjcoV3dQuMd7FAwEMqnBF29452tuHI2Pd/GScOdKq0hWos
         XokZnCgmQe9tgBpb0+bKaM1mQDnQyWW/p75zDOTTXMfwfmr8/59ZfLlv5pxRlmgYWGt8
         a4Wbf9+CIdmwcfNWCeLN1Baf/lBm+8nAT9zjd6gOSxPLD+QR/3mbgMADPWuzinnD3ZQc
         wBQCXOD0vPwKQjuodl9q0Vuyg7VEK2KLuMs3yzKQhdG3Q4r0QpFQJeM/9uehiFEC+G8y
         BjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qYOFk6wNv3lozldHoJ07szcbuOREZTKbg87ILnlEEGo=;
        b=Tr2xOy+NR82o4NdIklkS5y3A4yMLiD1VBEtezpp6L5u1dlrKERQeW0P5COatfqGa5m
         6tYvkW/1p93nYFQomnFCMsd7Ghsc/7fCRDjAxodn+2bWvEjMul+NR9IlykMg4aJ/sgBn
         wQ4n8DVLXnAt0uZ3q4+HEu/H+J0YUyVmgF9pURU61l0rdP42MmokcA+QRdZwZtIo8vGH
         XxGCEPPVN6KhJAlPNIRY8kiS6c8aG4bp7OX4ljzw+XFvVVyUlwJIvst+bXXBKSCpHXcH
         ShBnm6zRzyHan/LKNL18LGpXKgIxUSv233Gky3ofnpmnzXm0k0EUwzwuTmkJYcqSQkq3
         CaeQ==
X-Gm-Message-State: APjAAAXz6BUF1dSWAZi4gRGg5w7yAAAnNDAdSr8BEiKjfkBEccX9LWgf
        5L3MpssXl/7wRAa3LTPS9cM=
X-Google-Smtp-Source: APXvYqyMUURzsO6WOElvQfK/RHg+KZPFA+EzRkG4xMoMLblSWu97LxoMJ60XTa8op8N0YbUTXZ7eqg==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr27765760wrr.214.1557346655188;
        Wed, 08 May 2019 13:17:35 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k206sm9943417wmk.16.2019.05.08.13.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:17:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190312031303.5tutut7zzvxne5dw@dcvr>
        <20190312104954.GA2023@sigill.intra.peff.net>
        <20190313015133.n7f7lyujnlwfytre@dcvr>
        <20190313145417.GA24101@sigill.intra.peff.net>
        <20190314091254.nescpfp3n6mbjpmh@dcvr>
        <87zhoz8b9o.fsf@evledraar.gmail.com>
        <20190410225721.GA32262@sigill.intra.peff.net>
        <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
        <20190504013713.GC17551@sigill.intra.peff.net>
        <87a7g2iuem.fsf@evledraar.gmail.com>
        <20190504132346.GK14763@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190504132346.GK14763@szeder.dev>
Date:   Wed, 08 May 2019 22:17:33 +0200
Message-ID: <87o94chfaa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 04 2019, SZEDER G=C3=A1bor wrote:

> On Sat, May 04, 2019 at 08:52:01AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As an aside this is the Nth time I notice how crappy that "Enumerating
>> objects" progress bar is.
>
> And don't forget that the commit-graph progress bar still prints
> nonsense :)
>
>   https://public-inbox.org/git/87ef6ydds8.fsf@evledraar.gmail.com/

I forgot for a bit, but then figured I'd get out of Derrick's way with
his more significant commit-graph work (which would have inevitably had
merge conflicts with this patch), and look at the time. Here we are
coming up on rc0.

I'm inclined to just wait until Derrick's refactorings land post-2.22.0
unless a) we need it enough before 2.22.0 to cause him trouble b) Junio
agrees with "a" and would take such a patch to fix this part of the
progress output before 2.22.0.

If people (just you would do) tell me "yes I/we want it" and Junio says
"yeah I'll do that" I'll write this patch in the next couple of days,
otherwise I'll do other stuff.

Junio?
