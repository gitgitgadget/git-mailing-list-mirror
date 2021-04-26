Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21410C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D117061166
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhDZQOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:35456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:14:50 -0400
Received: (qmail 30069 invoked by uid 109); 26 Apr 2021 16:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Apr 2021 16:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8111 invoked by uid 111); 26 Apr 2021 16:14:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Apr 2021 12:14:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Apr 2021 12:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Improve stash descriptions
Message-ID: <YIbmz2BUKV0/pcIB@coredump.intra.peff.net>
References: <ff84d047-c0ae-86d1-c210-b2b777fd8184@rawbw.com>
 <YIWkHBfb4g68Oxr3@camp.crustytoothpaste.net>
 <87r1ix4dsc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1ix4dsc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 11:00:57AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> In case many directories are affected it could say "changes are in
> >> path1/dir1, path2/dir2, etc."
> >
> > This is unfortunately not going to be very efficient to compute in
> > certain cases, such as with large working trees where there are many
> > changes.  So while it would improve the automated stash message, it
> > might also make stashing much slower on large repositories.
> 
> Just to add to this, there's already:
> 
>     git stash list [--stat|--numstat|--shortstat]
> 
> It seems to me that what's being requested here is not so much a
> stash-specific feature, but some abbreviated "human readable" stat
> format that could be used with any log-like command.

There's also --dirstat, which will summarize the impacted directories
(though it does not say much useful if the entries are all in the root,
as they typically are for git.git).

-Peff
