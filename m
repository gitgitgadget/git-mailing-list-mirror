Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BD01F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeFDOMe (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:12:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753296AbeFDOMc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:12:32 -0400
Received: (qmail 24940 invoked by uid 109); 4 Jun 2018 14:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 14:12:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13969 invoked by uid 111); 4 Jun 2018 14:12:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 10:12:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 10:12:30 -0400
Date:   Mon, 4 Jun 2018 10:12:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
Message-ID: <20180604141230.GA26961@sigill.intra.peff.net>
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 10:57:30PM +0900, Junio C Hamano wrote:

> * jk/index-pack-maint (2018-06-01) 2 commits
>   (merged to 'next' on 2018-06-04 at c553a485e8)
>  + index-pack: handle --strict checks of non-repo packs
>  + prepare_commit_graft: treat non-repository as a noop
> 
>  "index-pack --strict" has been taught to make sure that it runs the
>  final object integrity checks after making the freshly indexed
>  packfile available to itself.
> 
>  Will cook in 'next'.

This second patch fixes a regression in v2.18.0-rc1 and in v2.17.1. I
don't know if we'd want to consider it for v2.18 or not (it should be
able to be applied independently from the first).

> * jk/branch-l-0-deprecation (2018-05-25) 5 commits
>   (merged to 'next' on 2018-05-30 at a94574dfd5)
>  + branch: customize "-l" warning in list mode
>  + branch: issue "-l" deprecation warning after pager starts
>   (merged to 'next' on 2018-04-11 at 9b2b0305dd)
>  + branch: deprecate "-l" option
>  + t: switch "branch -l" to "branch --create-reflog"
>  + t3200: unset core.logallrefupdates when testing reflog creation
>  (this branch is used by jk/branch-l-1-removal and jk/branch-l-2-reincarnation.)
> 
>  The "-l" option in "git branch -l" is an unfortunate short-hand for
>  "--create-reflog", but many users, both old and new, somehow expect
>  it to be something else, perhaps "--list".  This step deprecates
>  the short-hand and warns about the future removal of the it when it
>  is used.
> 
>  Will cook in 'next'.
>  Perhaps merge to 'master' immediately after 2.18 release?

FWIW, I plan to re-roll this according to the discussion (with the
intent that this would just get ejected when 'next' is rewound). But
there is no rush, since that is all post-release. So you can see if I
get around to it or not by then. ;)

-Peff
