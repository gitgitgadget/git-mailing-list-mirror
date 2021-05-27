Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971BC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0686613C0
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhE0QCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 12:02:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:38966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237051AbhE0QBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 12:01:53 -0400
Received: (qmail 5147 invoked by uid 109); 27 May 2021 16:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 16:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4154 invoked by uid 111); 27 May 2021 16:00:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 12:00:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 12:00:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] send-email: various optimizations to speed up
 by >2x
Message-ID: <YK/CEMd52k+cK0dz@coredump.intra.peff.net>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 09:52:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This v4 fixes an issue in v3 where 12/13 had a "diff --git" as part of
> the commit message (mistake during rebase/squash), which confused "git
> am" in trying to apply a diff twice. See <xmqqwnrplyns.fsf@gitster.g>.

I raised a probably-not-a-problem question in patch 12. Assuming it's
indeed not-a-problem, this all looks good to me.

Thanks for addressing my concerns about Git.pm stability.

-Peff

PS I hit some mild conflicts applying this on top of master because
   7cbc0455cc (send-email: move "hooks_path" invocation to
   git-send-email.perl, 2021-05-26) graduated in the meantime. I expect
   Junio prefers it as you have it here, since he tends to use the
   original base from previous rounds, but just a hint to any other
   reviewers.
