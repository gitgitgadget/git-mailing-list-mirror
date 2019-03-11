Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB3420248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCKUYn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:24:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:46342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727548AbfCKUYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:43 -0400
Received: (qmail 16052 invoked by uid 109); 11 Mar 2019 20:24:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 20:24:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26552 invoked by uid 111); 11 Mar 2019 20:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Mar 2019 16:25:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2019 16:24:41 -0400
Date:   Mon, 11 Mar 2019 16:24:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Drop last MakeMaker reference
Message-ID: <20190311202441.GB18263@sigill.intra.peff.net>
References: <pull.146.git.gitgitgadget@gmail.com>
 <xmqqfts469h5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1903071109020.41@tvgsbejvaqbjf.bet>
 <xmqq1s3ikurh.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1903081718330.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903081718330.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 05:27:36PM +0100, Johannes Schindelin wrote:

> > Or perhaps GGG can learn to avoid 0/1 for a single-patch topic ;-)
> 
> It is easier, and more consistent, to have a cover letter even then, for
> things like the broader explanation of the context, the changes since the
> previous iteration, and the range-diff (which would make v2, v3, v4, etc
> utterly unreadable from my point of view if they were integrated into the
> single patches, as I used to do with interdiffs).

Just my two cents:

As a reviewer, I generally prefer not to see a separate cover letter for
a single patch. At least for the first version (I agree it gets unwieldy
showing a range-diff after the "---" for subsequent versions, unless it
happens to be pretty short).

My reasoning is that I've noticed that many of the GGG-sent patches
often end up duplicating quite a bit of content between the cover letter
and the commit message of the patch (or worse, putting things only in
the cover letter that really could go into the commit message). That
doubles the time I spend reading and understanding the patch's rationale
(and I'm speaking subjectively here, of course; I didn't measure it).

I don't think it's an _inherent_ problem with a separate cover letter.
But something about the workflow causes people to write up over-long
cover letters. Which presumably is the fact that they're presented with
a PR textbox to write the rationale separately from when they wrote the
commit message. So they err on the side of repeating themselves, and
never see the two pieces "together" (like the reader will), which makes
the redundancy more obvious.

I'd say 99% of the time a single-patch doesn't need any cover letter
material at all. And even a multi-patch series really just needs a tl;dr
of the problem and a sketch of the solution. In both cases, the commit
messages should carry the meat.

(That's all specific to our project, of course; I know many projects
don't care about commit messages at all and expect PR descriptions to be
the first-class explanations).

-Peff
