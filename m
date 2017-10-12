Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D7520437
	for <e@80x24.org>; Thu, 12 Oct 2017 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbdJLJeq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:34:46 -0400
Received: from continuum.iocl.org ([217.140.74.2]:36145 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbdJLJep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 05:34:45 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v9C9Yd312904;
        Thu, 12 Oct 2017 11:34:39 +0200
Date:   Thu, 12 Oct 2017 11:34:39 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git repack leaks disk space on ENOSPC
Message-ID: <20171012093439.GD32090@inner.h.apk.li>
References: <20171011150546.GC32090@inner.h.apk.li> <20171012031702.GB155740@aiede.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012031702.GB155740@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Oct 2017 20:17:03 +0000, Jonathan Nieder wrote:
> Hi Andreas,
> 
> Andreas Krey wrote:
> 
> > I observed (again) an annoying behavior of 'git repack':
> 
> Do you have context for this 'again'?  E.g. was this discussed
> previously on-list?

I think I posted about it, but no discussion. I poked a bit
at the code, with not much luck back then.

...
> Does using create_tempfile there seem like a good path forward to you?
> Would you be interested in working on it (either writing a patch with
> such a fix or a test in t/ to make sure it keeps working)?

I will look into creating a patch (thanks for the pointers),
but I don't see how to make a testcase for this - pre-filling the
disk doesn't sound like a good idea. Most people probably won't run in
this situation, and then won't have tmp_packs with a dozen GBytes each
lying around.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
