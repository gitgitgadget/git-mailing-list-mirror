Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6350720988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758451AbcJQJoj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:44:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752123AbcJQJoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:44:37 -0400
Received: (qmail 18112 invoked by uid 109); 17 Oct 2016 09:37:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 09:37:55 +0000
Received: (qmail 28908 invoked by uid 111); 17 Oct 2016 09:38:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 05:38:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2016 05:37:54 -0400
Date:   Mon, 17 Oct 2016 05:37:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] convert: mark a file-local symbol static
Message-ID: <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610171058580.197091@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610171058580.197091@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 11:04:19AM +0200, Johannes Schindelin wrote:

> > Gross. I would not be opposed to a Makefile rule that outputs the
> > correct set of OBJECTS so this (or other) scripts could build on it.
> 
> You could also use the method I use in Git for Windows to "extend" the
> Makefile:
> 
> -- snipsnap --
> cat >dummy.mak <<EOF
> include Makefile
> 
> blub: $(OBJECTS)
> 	do-something-with $^
> EOF
> 
> make -f dummy.mak blub

Hacky but clever. I like it.

In the particular case of git, I think I've cheated similarly before by
putting things in config.mak, though of course an arbitrary script can't
assume it can overwrite that file.

-Peff
