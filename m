Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF574C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 00:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHBAqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHBAqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 20:46:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF91FCDB
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 17:46:11 -0700 (PDT)
Received: (qmail 1448 invoked by uid 109); 2 Aug 2022 00:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Aug 2022 00:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26947 invoked by uid 111); 2 Aug 2022 00:46:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 20:46:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 20:46:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <Yuhz0VAX77qv4P5Z@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
 <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
 <YugQqp4oN26OFOpt@coredump.intra.peff.net>
 <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
 <xmqqfsifyetv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsifyetv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 01, 2022 at 11:54:36AM -0700, Junio C Hamano wrote:

> > +test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
> > +	git symbolic-ref refs/heads/top-level FETCH_HEAD &&
> > +	git update-ref FETCH_HEAD HEAD &&
> > +	test_cmp_rev top-level HEAD
> > +'
> >  test_done
> 
> Strange, but OK.

I'd be OK to drop this if you hate it too much, btw. Mostly I wanted to
make sure that the various iterations behaved as I expected. But there
is a test in t3200 (the one Linus found earlier) that incidentally does
check that something like this works.

-Peff
