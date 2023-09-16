Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017FCD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 05:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjIPFwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbjIPFwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 01:52:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8411BE6
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 22:52:09 -0700 (PDT)
Received: (qmail 1455 invoked by uid 109); 16 Sep 2023 05:52:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 05:52:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9046 invoked by uid 111); 16 Sep 2023 05:52:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 01:52:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 01:52:07 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] merge-ort: drop unused "opt" parameter from
 merge_check_renames_reusable()
Message-ID: <20230916055207.GE13092@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
 <20230914094004.GD2254894@coredump.intra.peff.net>
 <CABPp-BEi1CSXEE=-dDi_bhtSsGeVWtivfT-jQP+hjWdv4agq=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEi1CSXEE=-dDi_bhtSsGeVWtivfT-jQP+hjWdv4agq=Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 08:09:00PM -0700, Elijah Newren wrote:

> On Thu, Sep 14, 2023 at 2:40 AM Jeff King <peff@peff.net> wrote:
> >
> > The merge_options parameter has never been used since the function was
> > introduced in 64aceb6d73 (merge-ort: add code to check for whether
> > cached renames can be reused, 2021-05-20). In theory some merge options
> > might impact our decisions here, but that has never been the case so
> > far.
> 
> Yeah, it was used in some preliminary versions of the code while I was
> developing the new algorithm, but there were lots of changes between
> when I started working on merge-ort and when it was finally ready to
> submit for review.  I must have just overlooked that this parameter
> was no longer needed.  Thanks for catching and cleaning up.

Yeah, that's what I figured. I actually queued quite a few of these
-Wunused-parameter fixups, because the initial iterations of merge-ort
had a lot of stub functions or unimplemented bits. I sat on them for a
year or so because I figured you'd eventually use those parameters. And
indeed, most of them fell out naturally, and what was left for this
series was all pretty easy to understand.

-Peff
