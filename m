Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE5C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGLHX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLHXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:23:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABDD54
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:23:50 -0700 (PDT)
Received: (qmail 10588 invoked by uid 109); 12 Jul 2022 07:23:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 07:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27974 invoked by uid 111); 12 Jul 2022 07:23:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 03:23:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 03:23:49 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
Message-ID: <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g>
 <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
 <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 03:13:50AM -0400, Eric Sunshine wrote:

> > Since this is only a warning, and only a practical issue with -Werror I
> > wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
> > -Wno-missing-braces for this older clang version.
> 
> I'm in favor of this. It would, of course, require extra
> special-casing for Apple's clang for which the version number bears no
> resemblance to reality since Apple invents their own version numbers.

I got PTSD reading that thread again, but in case anybody wants to dig
into this, I think there are some hints from the last time we discussed
this (starting at the end of this message and the subthread):

  https://lore.kernel.org/git/YQ2LdvwEnZN9LUQn@coredump.intra.peff.net/

-Peff
