Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6286B20986
	for <e@80x24.org>; Fri,  7 Oct 2016 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbcJGRu5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 13:50:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754770AbcJGRuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 13:50:55 -0400
Received: (qmail 8614 invoked by uid 109); 7 Oct 2016 17:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 17:50:55 +0000
Received: (qmail 8722 invoked by uid 111); 7 Oct 2016 17:51:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 13:51:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2016 13:50:52 -0400
Date:   Fri, 7 Oct 2016 13:50:52 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 07:42:35PM +0200, Johannes Sixt wrote:

> Maybe it's time to aim for
> 
>   git config alias.d2u.shell \
>        'f() { git ls-files "$@" | xargs dos2unix; }; f'
>   git config alias.d2u.cdup false
>   git d2u *.c   # yada!

That would be nice. It would also allow "alias.foo_bar.shell"; right now
"alias.foo_bar" is forbidden because of the config syntax, which does
not allow underscores outside of the "subsection" name.

-Peff
