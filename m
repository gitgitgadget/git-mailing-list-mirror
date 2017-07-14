Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC3320357
	for <e@80x24.org>; Fri, 14 Jul 2017 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdGNT2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 15:28:43 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36328 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdGNT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 15:28:42 -0400
Received: by mail-wr0-f169.google.com with SMTP id v60so5362127wrc.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bWBEBbMgQ4ZgjzbcRlAIwqDJqK30ux8BisawukIjGMM=;
        b=aIdAyw9GGbFD9zmTle7pXlYOPGeWaBqtRYjqMRHvEMDsILTtb8Vgp0fNEy2rWp6GVO
         WTLlsr8+nYoXI/V3EmTRm/SukOwGGsoIrr/rdiO+XKtpt77Gk2Y8jv5Y+qwxvXlP7nuP
         xz6SLSB9beQ+s7yiTzaBxttf5A1Mq5NSZAh3oJ/CmjHAmKjaJB86JDNP/URe8Ny4cURz
         h+IW+4P7WJft1eZiirXpHUI1xTekcjZonXcXEdeJsxfT/jBAVFxcU2uhrmx1mvmx/9T1
         k+Bf9pMl60/1A2GpfMWO+LMZK5zxcnIZj73rYoJ1NXpD3PtdaVF5mc4PUxMNbuKvkdRv
         ZZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bWBEBbMgQ4ZgjzbcRlAIwqDJqK30ux8BisawukIjGMM=;
        b=H+jJSXnVaCpW51m6o6i0Du4pzIbCXQnHbKyJIfOfdAANjcZDWhCli3m7SkiZwntYHy
         VIkPiHc7+vGgDqqye73jY5ZC1mlzw2u5UgT8N5v2FVjGfeWbPQNPkHIk1jGfyMoJfkYl
         cu3NbYTiUZ6zDPgMXVuj27TQlfhS5r2HLYY98roZAhO+K6bOhZTEm8SLi07lspgDuaFk
         LLdiRjp01uGiCtdEAYNgsbwsNCGFmqeoh5cHcUK+acS+Bh3jHGd+llRwd9t1jeZHsFSJ
         1/VWtj2uQIqXDA+e6mfh1WA2pAKsHDvztaKGjpe5Lcpdy5YAjNfLH1TzrM1D5O4L7/ut
         mecg==
X-Gm-Message-State: AIVw113Nt8cfIQYA52aQXrmYWK2qJoxCZHBXzQG2A5K1IMOCTDMOnP6I
        Z7u58WJd/Qx2tKlBIx4=
X-Received: by 10.223.177.142 with SMTP id q14mr5023287wra.200.1500060520746;
        Fri, 14 Jul 2017 12:28:40 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id n71sm8324406wrb.62.2017.07.14.12.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2017 12:28:39 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dW6GU-0007RK-Lu; Fri, 14 Jul 2017 21:28:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?R?= =?utf-8?Q?en=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net> <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org> <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com> <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org> <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com> <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 14 Jul 2017 21:28:38 +0200
Message-ID: <87pod23jix.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 14 2017, Junio C. Hamano jotted:

> Junio C Hamano <gitster@pobox.com> writes:
>
>  - This may be showing I am not just old fashioned but also am
>    ignorant, but I do not see much point in using the following in
>    our codebase (iow, I am not aware of places in the existing code
>    that they can be improved by employing these features):
>
>    . // comments

[Feel free to ignore this E-Mail and my fascination with C syntax
trivia]

I wouldn't advocate switching to them on this basis, but since you asked
for cases where things could be improved with // comments:

The other day I submitted a patch that included this line in a comment:

    +        * "t/**.sh" and then conclude that there's a directory "t",

Which you fixed up to, before integrating it:

    +        * "t/" + "**.sh" and then conclude that there's a directory "t",

That was only necessary due to limitations in one of two comment
syntaxes modern C supports.

Well, it wasn't *necessary*, but a compiler warned about the /* there as
a possibly confusing construct, and any compiler would have ended the
comment right there + errored out if it contained "t/**/*.sh".
