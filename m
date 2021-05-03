Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8292DC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C66611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhECUdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:33:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:43484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:33:13 -0400
Received: (qmail 7449 invoked by uid 109); 3 May 2021 20:32:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:32:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7241 invoked by uid 111); 3 May 2021 20:32:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:32:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:32:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/9] t7450: test verify_path() handling of gitmodules
Message-ID: <YJBd0rd9DJSKQoL7@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI124aZ1dbY5O67J@coredump.intra.peff.net>
 <871raoxh09.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871raoxh09.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 12:12:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Sat, May 01 2021, Jeff King wrote:
> 
> > +test_expect_success 'refuse to load symlinked .gitmodules into index' '
> > +	test_must_fail git -C symlink read-tree $tree 2>err &&
> > +	test_i18ngrep "invalid path.*gitmodules" err &&
> > +	git -C symlink ls-files >out &&
> > +	test_must_be_empty out
> > +'
> > +
> 
> In 1/9 a test_i18ngrep is removed, but here's a new one.

Thanks. Most of these patches were written either in 2018 or 2020 and
pulled forward (and back then, this call would have been necessary). I
fixed up a few cases as I was rebasing, but obviously missed this one.

-Peff
