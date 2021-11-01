Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C085C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 04:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C82C600D4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 04:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhKAEHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 00:07:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:50632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhKAEHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 00:07:31 -0400
Received: (qmail 30415 invoked by uid 109); 1 Nov 2021 04:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Nov 2021 04:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15863 invoked by uid 111); 1 Nov 2021 04:05:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Nov 2021 00:05:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Nov 2021 00:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Message-ID: <YX9naXglQIDYa0jg@coredump.intra.peff.net>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <YXeRNkO8B4TP/cau@coredump.intra.peff.net>
 <1575aeb5-7aec-3d5c-6b2c-11b9866f3f4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575aeb5-7aec-3d5c-6b2c-11b9866f3f4c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 12:06:20AM +0530, Kaartic Sivaraam wrote:

> > This commit has an extra unused parameter in the helper function. I
> > think we'd want the patch below on top.
> > 
> 
> Sorry for the oversight and thanks for catching it (again)!
> 
> This reminded me to check my config.mak and enable DEVELOPER=1
> which I seem to have turned off for some reason. I did notice
> we explicitly add -Wno-unused-parameter to DEVELOPER_CFLAGS (likely
> with good reason). The rest of the flags should be helpful though :)

Yes, there are hundreds of false positives for -Wunused-parameter. I
have a series annotating all of them (which is indeed how I found the
problem fixed here), but I haven't quite gotten around to cleaning them
all up. (Plus I've been a little afraid to flood the list with them).

-Peff
