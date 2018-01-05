Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C05F1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeAET5I (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:57:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:35430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751814AbeAET5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:57:07 -0500
Received: (qmail 26891 invoked by uid 109); 5 Jan 2018 19:55:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 19:55:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8510 invoked by uid 111); 5 Jan 2018 19:57:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 14:57:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 14:57:05 -0500
Date:   Fri, 5 Jan 2018 14:57:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180105195705.GA5217@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
 <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
 <20180104040124.GA11626@sigill.intra.peff.net>
 <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 11:53:50AM -0800, Junio C Hamano wrote:

> > They haven't even been reviewed yet. If they get good feedback, then the
> > maintainer will pick them up, then merge them to 'next', and then
> > eventually to 'master', after which they'd become part of the next
> > major release. For a pure bug-fix, it may instead go to 'maint' and
> > become part of the next minor release.
> 
> Even a pure bug-fix, unless it is something no longer needed on the
> 'master' front, goes thru 'pu'->'next'->'master' avenue first, and
> is recorded in the RelNotes with the notes like "(merge d45420c1c8
> jk/abort-clone-with-existing-dest later to maint)" when it happens.
> 
> 	side note: in fact "grep -e 'later to maint' RelNotes" is
> 	how I remind myself what to merge down to 'maint'; the
> 	actual procedure is a bit more involved (those interested in
> 	the details can find the 'ML' script on the 'todo' branch;
> 	its name stands for 'merge later')
> 
> Later, after not hearing from people that the "fix" breaks things,
> the topic is also mreged to 'maint' and becomes part of the next
> minor release.

Out of curiosity, did this change at some point? I thought the process
used to be to merge to maint, and then pick up topics in master by
merging maint to master.

-Peff
