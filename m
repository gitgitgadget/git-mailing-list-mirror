Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28247C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0000C610F8
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhIJObv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:31:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhIJObs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:31:48 -0400
Received: (qmail 5866 invoked by uid 109); 10 Sep 2021 14:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:30:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25557 invoked by uid 111); 10 Sep 2021 14:30:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:30:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:30:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Message-ID: <YTtsDGs7j2lM+hh+@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
 <YTkNdGk28UJnSDVt@coredump.intra.peff.net>
 <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 10:19:04AM -0400, Jeff King wrote:

> But there is one thing that does get weird if we don't do this patch. If
> we later take the approach of checking:
> 
>   #ifdef CURLOPT_PINNEDPUBLICKEY
> 
> then that will subtly shift the cutoff point from 7.44 to 7.39 anyway.
> _If_ we are going to do that conversion in a later patch (as this series
> does), I think it makes sense to shift the version number explicitly in
> a commit with an explanation, as this commit does.

Ah, nevermind. I just saw Ævar's re-roll where that strategy turns out
to be a bad idea anyway. So that is no longer a compelling argument. :)

-Peff
