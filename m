Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86821C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380A4206ED
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKJBTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:19:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:52346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbgKJBT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:19:26 -0500
Received: (qmail 5406 invoked by uid 109); 10 Nov 2020 01:19:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 01:19:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29781 invoked by uid 111); 10 Nov 2020 01:19:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 20:19:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 20:19:24 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
Message-ID: <20201110011924.GA1270103@coredump.intra.peff.net>
References: <20201109215248.461167-1-felipe.contreras@gmail.com>
 <20201109221939.GA670413@coredump.intra.peff.net>
 <CAMP44s2mZK2_aAepOQs-5fmrbYPJ74Jb4VaSgwMAEdzZXS+9ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s2mZK2_aAepOQs-5fmrbYPJ74Jb4VaSgwMAEdzZXS+9ZA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 07:06:56PM -0600, Felipe Contreras wrote:

> > We do have "git <cmd> --git-completion-helper" these days. I wonder if
> > something like "git --expand-alias-to-command" would be a useful
> > addition, as it would let us directly ask which Git command would be
> > executed (if any). And it would make both downsides go away.
> 
> Yes, but I don't think we need to wait in order to have a solution for
> both issues. I already sent an updated patch.

Agreed. The cycle-detection in your v2 looks fine to me.

> Additionally, it might not be what the user wants. For example the
> user might decide to have different completion for each one of the
> aliases (_git_l, _git_lg, etc.), and if so, we would want
> __git_aliased_command to exit once we find the correct completion
> function.

Good point.

-Peff
