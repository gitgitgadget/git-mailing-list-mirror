Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E7B20966
	for <e@80x24.org>; Mon, 27 Mar 2017 08:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbdC0IjF (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 04:39:05 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:50957 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdC0IjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 04:39:03 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 1B5F947F83B
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 10:30:46 +0200 (CEST)
Received: from [IPv6:2001:4b98:beef:a:be5f:f4ff:fe69:f6a] (locke.gandi.net [IPv6:2001:4b98:beef:a:be5f:f4ff:fe69:f6a])
        (Authenticated sender: romuald@chivil.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 847AFA8151;
        Mon, 27 Mar 2017 10:27:52 +0200 (CEST)
Message-ID: <1490603272.9788.7.camel@locke.gandi.net>
Subject: Re: [PATCH] push: allow atomic flag via configuration
From:   Romuald Brunet <romuald@chivil.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon, 27 Mar 2017 10:27:52 +0200
In-Reply-To: <xmqqmvca79sh.fsf@gitster.mtv.corp.google.com>
References: <1490375874.745.227.camel@locke.gandi.net>
         <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
         <xmqqmvca79sh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ven., 2017-03-24 at 12:29 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > My one question would be whether people would want this to actually be
> > specific to a particular remote, and not just on for a given repository
> > (your "site-specific" in the description made me think of that). In that
> > case it would be better as part of the remote.* config.
> 
> Yeah, I had the same reaction.  
> 
> Conceptually, this sits next to remote.*.push that defines which set
> of refs are sent by default, and remote.<name>.pushAtomic does make
> sense.  If (and only if) it turns out to be cumbersome for somebody
> to set the configuration for each and every remote, it is OK to also
> add push.atomic to serve as a fallback for remote.*.pushAtomic, I
> would think, but adding only push.atomic feels somewhat backwards.

Thanks for your feedback

I'm mostly using single remotes that's why I didn't even think of making
it configurable per remote. But you're right that makes more sense.

I'll try to make that modification to the patch.

As for my use case: I'd like to use default atomic pushes when pushing a
new tag among our stable branch, but inevitably forgetting to rebase
beforehand. Therefore pushing a "dangling" commit/tag


-- 
Romuald Brunet

