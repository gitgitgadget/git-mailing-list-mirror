Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDAEFA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKACZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKACZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:25:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08032165A6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:25:50 -0700 (PDT)
Received: (qmail 3944 invoked by uid 109); 1 Nov 2022 02:25:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18111 invoked by uid 111); 1 Nov 2022 02:25:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:25:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:25:49 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Message-ID: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
 <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
 <Y2B+jn4goN4OIcwL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2B+jn4goN4OIcwL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 10:03:58PM -0400, Jeff King wrote:

> I do think moving these tests to use a real http server is a better
> solution, though. I'll provide a patch in a moment.

Here that is. I hope this isn't co-opting your series; my goal was to do
the work so that you wouldn't have to, but I admit it is assuming you
agree with my approach. ;)

The first patch is the interesting one. The second one is just your 2/2
rebased onto the new location.

  [1/2]: t5516: move plaintext-password tests from t5601 and t5516
  [2/2]: t5516/t5601: be less strict about the number of credential warnings

 t/t5516-fetch-push.sh       | 31 ---------------
 t/t5551-http-fetch-smart.sh | 77 +++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh            | 23 -----------
 3 files changed, 77 insertions(+), 54 deletions(-)

-Peff
