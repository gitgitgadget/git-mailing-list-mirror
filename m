Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE861F404
	for <e@80x24.org>; Wed, 15 Aug 2018 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeHOHse (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 03:48:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43416 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeHOHsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 03:48:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so37309plv.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SxC6XwY1SPwfYjSg0QFA/doUEbmDn0nLVNJiR10VazQ=;
        b=CNI/mtt1zEbetE9JZcqoCn5o8U9lHm8p9WOkyGN2G8c+8JlGM1JdDKE3oTzWkPrsy4
         JVSfm/1ugEsECf/J5KgVhSYfehc33uPI1x1b2bcQq6HsES3qi7gY+mcOH2odrmDy1ycB
         IhJPWO1Ys8teaLDIqZPWVblSHMe30thHFdQpvMpZh+jbSeWa1ndpIfBfVIom/e2sH4Y+
         jW68d/uZRq4McLk/ixp9MbFLg9J9kyCiRBnVwjcDZYqMtiADZMghHi4roQnlfa716tk0
         AjHcuGOqjsiq/e1193l6tkjKom17RFwwjJ9Q/ED0VlutUYibvNTIECUDIOm3lT/khjbI
         5Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxC6XwY1SPwfYjSg0QFA/doUEbmDn0nLVNJiR10VazQ=;
        b=lO/IfLU+l9iqlUEypPC6xN+EX64jCk9p4nf9w+osZGdLMBvoaHuLHv4lGwqjhkrClw
         RrlIl9+A3JIAMWTCyeCFuKx5Qoa6sgDWKRjncJdK2UKwprRC94qINmv/vG6VID/LcVOc
         ZLKlg8dtB8LRFa+QKcsXXSmlDLrpND4a+bRJG9pgHi4Sao7ReiwZBy6DBlKt1J3QQ0SM
         YmZxJqYUHRj1T9DTdOMNjKauJIpfglhfqV9CE0g1h3EzKbALrddtC8FSxiPlHiFT/mzf
         8Qs5OAp76oMYSV1LXxxSZ6zZXTK8+aotEEy55eJ7HkwJgtZpEjTPNFxm25zCW2Foq0w3
         eW9A==
X-Gm-Message-State: AOUpUlEBZWb8Y15xLVtDRqwmoJ5VOvGRVo/oh1c5PIiJbcHWjUUgPZtS
        sRjLLzVrpVlVkO0USOAAsMY=
X-Google-Smtp-Source: AA+uWPz/phHybUKeqv2BG+HDW07OQtMJHZFujZXEq294XPQt9PnVWyOyEcm36IGHm0xgt77md4Nkog==
X-Received: by 2002:a17:902:8494:: with SMTP id c20-v6mr22772314plo.336.1534309082135;
        Tue, 14 Aug 2018 21:58:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d13-v6sm20724063pgq.42.2018.08.14.21.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 21:58:01 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:57:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
Message-ID: <20180815045759.GB32543@aiede.svl.corp.google.com>
References: <20180811043218.31456-1-newren@gmail.com>
 <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net>
 <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
 <20180815013825.GA12178@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815013825.GA12178@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: [PATCH] test-tool.h: include git-compat-util.h
>
> The test-tool programs include "test-tool.h" as their first
> include, which breaks our CodingGuideline of "the first
> include must be git-compat-util.h or an equivalent". This
> isn't actually a problem, as test-tool.h doesn't define
> anything tricky, but we should probably follow our own rule.
>
> Rather than change them all, let's instead make test-tool.h
> one of those equivalents, just like we do for builtin.h
> (which many of the actual git builtins include first).

I wonder if it would not be simpler to change them all.  It would be
one less special case.

That said,

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/helper/test-tool.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
