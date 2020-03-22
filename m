Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C06C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C0B20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVGFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:05:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:46826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726502AbgCVGFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 02:05:22 -0400
Received: (qmail 23759 invoked by uid 109); 22 Mar 2020 06:05:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 06:05:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29843 invoked by uid 111); 22 Mar 2020 06:15:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 02:15:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 02:05:21 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Ed Maste <emaste@freebsd.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200322060521.GD578498@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
 <20200319161200.GF3513282@coredump.intra.peff.net>
 <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
 <20200320014142.GF1858@danh.dev>
 <20200320053730.GE499858@coredump.intra.peff.net>
 <20200322003703.GA11801@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322003703.GA11801@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 07:37:03AM +0700, Danh Doan wrote:

> >  sync_mtime () {
> > -	find . -type d -ls >/dev/null
> > +	find . -type d >/dev/null
> >  }
> >  
> >  avoid_racy() {
> > 
> > lets t7063 consistently pass on FreeBSD.
> 
> I've tried myself with a FreeBSD VM which stays on top of an HDD,
> t7063 consistently pass for 1000 run.
> 
> I guess it should be fine
> 
> I'll resend with this while waiting for Ed's response.

Thanks, that's good enough for me. I just didn't want us committing
something without _somebody_ trying it on FreeBSD (and I was too lazy to
install a VM myself).

-Peff
