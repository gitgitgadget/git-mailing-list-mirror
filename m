Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9058F1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdEPU1p (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:27:45 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37010 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdEPU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:27:43 -0400
Received: by mail-it0-f54.google.com with SMTP id g126so95223294ith.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MzZcI9B7pkXFVcg9LGqwcPPKub3F/hXoAA7lDP7Ljx8=;
        b=r6DJXK6L2FVqrYsOgYywGZdOXqtZ1DGvUNPIywdxEsLE5ND2wT4Cag3AYzTf2sRaZr
         ITKHIt/V0yL55EeWY3L82E0DOpT3dxe37l9iscdSYbTwxnfB6p9oXmn5suJFYtK0PxeP
         d75TzIpVxk8bci82eX2/rWPeRc/7rTOHgkH5UZ2Qwt0d7dU1+5Ym85hCMVGeQiYtzVoV
         7D4lpOpYacdOJNLVeo7XD1PE9tUig/hgVeMVw87I69ozvsyRaHHYTSqpAfXM0xQCUJqI
         3DQjM4xK6SP3JzxPgTcQaEGtVCu47WFu1gv7cGCBba1ZwOk05EV8yK5rk/rb6PnRFsSk
         C2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MzZcI9B7pkXFVcg9LGqwcPPKub3F/hXoAA7lDP7Ljx8=;
        b=Hgk7h1FO5meiansWQ6FPnyQ5KfWtrvYqascobMBmPI2irgoyYzne4NGfTWrQj0w4h2
         7ErREFFw2wmWFCvk4nikpGLeUm2b6obmiT4PBkUQFhkqrxKVK+3xU6qOKEASnwAfg2GD
         pWgFgiyVDbjIMaFfRYj5/USMqtBFnLJwcpl1qGuRtePSqejT1UoDFkb0zxjQFCNHYIxW
         Iq3pBwiZzUfLyPGvEC7Gn7j1fZWZzdIi9AQUlOOUq0Xvk+D6Cv2cMlf66KffLrcYboUC
         HWGDG9TkhBZu//mnmXVX7+VCy89WIii8Aj+LNk8SN1x+FD4NQV8CQlnpMgaXvODFgCW1
         4yJg==
X-Gm-Message-State: AODbwcCtBbhvPfMoVdu1wsjxw+lni+ZrmyZXG/yEAG9XfmY5UQJq8fTP
        pqSB9ZZ6gEZBxqqzKwfg8360Vac7cw==
X-Received: by 10.36.74.82 with SMTP id k79mr12456556itb.58.1494966463105;
 Tue, 16 May 2017 13:27:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.204.3 with HTTP; Tue, 16 May 2017 13:27:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705162211320.3610@virtualbox>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com> <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com> <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
 <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com> <alpine.DEB.2.21.1.1705162211320.3610@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2017 13:27:42 -0700
X-Google-Sender-Auth: tZQqxQ6C2VW4jjvqap9PxQs1qQg
Message-ID: <CA+55aFwX2RDwT=g4w55bbLV38ggaVpdcLpMcCvqMcKRziUSesQ@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 1:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>>
>> I think it would be better to just
>>
>>  (a) get rid of the magic strcspn() entirely
>>
>>  (b) make the 'can we optimize this' test be simply just looking up
>> 'argv[0]' in $PATH
>
> What about
>
>         ABC=1 my-executable my-arg

What about it?

Do you have a binary like

    '/usr/bin/ABC=1 my-executable my-arg'

or something? If so, it gets executed. If not, it would get passed off
to "/bin/sh".

That sounds a lot more obvious than "some random set of characters are magical".

                  Linus
