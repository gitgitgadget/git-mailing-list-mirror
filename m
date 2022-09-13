Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E7C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIMAEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIMAE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:04:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB31B4
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:04:26 -0700 (PDT)
Received: (qmail 29348 invoked by uid 109); 13 Sep 2022 00:04:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 00:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19529 invoked by uid 111); 13 Sep 2022 00:04:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 20:04:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 20:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/18] make test "linting" more comprehensive
Message-ID: <Yx/JCAfSB4Bv7BPw@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <Yx1x5lme2SGBjfia@coredump.intra.peff.net>
 <CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com>
 <Yx4pg2t6JXR+lsd4@coredump.intra.peff.net>
 <CAPig+cTmosgapa=iUir3-J9k3138DvecHkmX+0QeHJROeTCeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTmosgapa=iUir3-J9k3138DvecHkmX+0QeHJROeTCeeA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 07:17:12PM -0400, Eric Sunshine wrote:

> > I think we can live with it as-is for now and see how people react. If
> > lots of people are getting confused by the output, then that motivates
> > finding a solution. If not, then it's probably not worth the time.
> 
> Well, you nerd-sniped me anyhow. The result is at [1]. Following the

It seems we've discovered my true talent. :)

> example of t/test-lib.sh, it uses `tput` if available to avoid
> hardcoding color codes, and `tput` is invoked lazily, only if it
> detects problems in the tests, so a normal (non-problematic) run
> doesn't incur the overhead of shelling out to `tput`.

Ah, of course. I didn't think about the fact that the regular tests
already had to deal with this problem. Following that lead makes perfect
sense.

-Peff
