Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7031F1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeCEVyK (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:54:10 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36070 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeCEVyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:54:09 -0500
Received: by mail-pf0-f179.google.com with SMTP id 68so7831320pfx.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AiUkV+MDWZlvdT1ctk7VU6ukCzvzaTn/VQsNfcmkDnU=;
        b=c/8glBJn+Af0u8000c8HB2p+cP7xA4J8n/EPYUCSHlZ58595b+8d/vRALwMasx/3L8
         0o4X3YmjFp5vUvgacMZbA7NXpkD0fFt2XypI9LW7nlFgxb6aaRrq3MwEWwXf4uL5iCjm
         nteOHhZ0sXRhlSAA5+jHI7AZQgx324xRYuaFJ2xQ5FcpfoAuaLXTLH65aasmNhUZsMdz
         1iVLTM1Zcq16WokEjS5XXJFmH/UIUsPuWG2DE3t+GVKwXTTFLvcvSQsYGy12B8oivnTB
         oznCwWQd70/XwoWEOQQKpi4YUoDLHthFqbnzMQ7v+BCA+0IfRDX+fBecwso0qNAphY/0
         Bwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AiUkV+MDWZlvdT1ctk7VU6ukCzvzaTn/VQsNfcmkDnU=;
        b=ObwAn4oQ7I5LzQXTCBlls82BsbapWw+pIfhOVc8TTc+z/rQ282CfleGap/Ow7Wdxeh
         GrHV+CLqUyhtPH3FLn4p2T8JjnrLve7kaaPdmtByFU6kdJjflalosEJna1xzTUi9Z9Kn
         uZnywM1ex06rPAr5zVBk3P5VvZmfqsac9VkvLMjjTgzVxWINN366atFpmUEsrek1CnIN
         DI7P52PZvArJ+rl4PbZqnMyjHA3H1IBwPdQhr5dMkM+ZZrQgOQItwX71p+/FujMIP2Da
         hSKQFZuz1q//7WhpUTD+q6Kit8DxLMmSH94W/vXH20cN9ckqrPRAl7wwO/ntk5BOuiiB
         CfmQ==
X-Gm-Message-State: APf1xPD8nIZkCoU7S8NGwnrD4mB4LlSihRhehMGMo58p8k64nIm7MBkm
        bXiy6/4OWzcMG91SJaOsJpoMdLde
X-Google-Smtp-Source: AG47ELsPu/X6rRW3LV4kbIp2ZBcT/ictcel0VE0eiMGL4ZWi42kOCtPvty7FzDgGb5MzzmPssmFwyg==
X-Received: by 10.98.147.27 with SMTP id b27mr16739168pfe.145.1520286848584;
        Mon, 05 Mar 2018 13:54:08 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m68sm18027030pfk.107.2018.03.05.13.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:54:07 -0800 (PST)
Date:   Mon, 5 Mar 2018 13:54:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180305215405.GG28067@aiede.svl.corp.google.com>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302070434.GG238112@aiede.svl.corp.google.com>
 <20180302104608.GB11074@sigill.intra.peff.net>
 <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
 <20180302165543.GA4616@sigill.intra.peff.net>
 <xmqqo9k6csan.fsf@gitster-ct.c.googlers.com>
 <20180303055715.GH27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303055715.GH27689@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Mar 02, 2018 at 09:15:44AM -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:

>>> That's probably a reasonable sanity check, but I think we need to abort
>>> and not just have a too-small DISPLAY array. Because later code like the
>>> hunk-splitting is going to assume that there's a 1:1 line
>>> correspondence. We definitely don't want to end up in a situation where
>>> we show one thing but apply another.
>>
>> Yes, agreed completely.
>
> Let's add this sanity check while we're thinking about it. Here's a
> series.
>
>   [1/2]: t3701: add a test for interactive.diffFilter
>   [2/2]: add--interactive: detect bogus diffFilter output
>
>  git-add--interactive.perl  |  8 ++++++++
>  t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)

With or without the tweak Ævar Arnfjörð Bjarmason suggested,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  It's probably also worth adding Sam's reported-by to patch 2/2:
Reported-by: Sam Kuper <sam.kuper@uclmail.net>
