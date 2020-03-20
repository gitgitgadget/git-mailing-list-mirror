Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A9C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F42072D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCTFcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:32:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725883AbgCTFcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:32:15 -0400
Received: (qmail 30973 invoked by uid 109); 20 Mar 2020 05:32:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:32:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2966 invoked by uid 111); 20 Mar 2020 05:41:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:41:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:32:14 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] t5003: skip conversion test if unzip -a is
 unavailable
Message-ID: <20200320053214.GD499858@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <27c7813c0fe81455b675611b9e11fee6ee2a79e9.1584625896.git.congdanhqx@gmail.com>
 <20200319160310.GD3513282@coredump.intra.peff.net>
 <20200320003921.GB1858@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320003921.GB1858@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 07:39:21AM +0700, Danh Doan wrote:

> > > +test_lazy_prereq UNZIP_CONVERT '
> > > +	(
> > > +		mkdir unzip-convert &&
> > > +		cd unzip-convert &&
> > > +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
> > > +	)
> > > +'
> > 
> > Lazy prereqs are already evaluated in a throw-away directory, so you can
> > drop the subshell and mkdir/cd.
> 
> I was trying to keep it consistent with UNZIP_SYMLINKS above it.
> Maybe, it's worth to clean it, too.

Ah, sorry, I should have looked at more context. I think it would be
worth cleaning up the existing one.

-Peff
