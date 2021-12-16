Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA7C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhLPPb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:31:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:53294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238612AbhLPPbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 10:31:55 -0500
Received: (qmail 21683 invoked by uid 109); 16 Dec 2021 15:31:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Dec 2021 15:31:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18252 invoked by uid 111); 16 Dec 2021 15:31:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Dec 2021 10:31:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Dec 2021 10:31:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/run-command (was: What's cooking in git.git (Dec 2021, #04;
 Wed, 15))
Message-ID: <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
References: <xmqq8rwlz3cq.fsf@gitster.g>
 <211216.868rwkbv1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211216.868rwkbv1b.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 12:51:55PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Or maybe you're not interested in either case, which is also fine. It's
> really not needed for anything other than to resolve the minor oddity
> that we have two "struct strvec"'s, "args" and "env_array". It's just a
> bit odd to have one with "_array" in the name, which is only because the
> now-removed "env" was taken at the time.

Yeah, FWIW I absolutely hated "env_array" when I added it, but didn't
want to do the transition all at once, so needed another name. So I
would be happy to see it become "env" now. ;)

Turning "args" into "argv" is less important, just because the name is
less long and ugly. And since "argv" is both the concept of the arg list
and also the well-known main() parameter with a different type, arguably
using it for a type besides "const char **" could be confusing (though I
don't find it so personally).

-Peff
