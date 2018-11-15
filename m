Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110FC1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 14:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeKPAZL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 19:25:11 -0500
Received: from continuum.iocl.org ([217.140.74.2]:40245 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeKPAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 19:25:11 -0500
X-Greylist: delayed 1904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Nov 2018 19:25:10 EST
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id wAFDjSk21352;
        Thu, 15 Nov 2018 14:45:28 +0100
Date:   Thu, 15 Nov 2018 14:45:28 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: approxidate woes
Message-ID: <20181115134528.GA21242@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

I've now located why our backup repo shrinks every month:

  git gc --prune=2d

doesn't do what I expected, and differs a lot from --prune=48h.

The latter actually means 'older than two days', while the
former is 'since the second day of this month, same time as now'.

Even '2d ago' does not help - '2 days ago' does.

Mildly irritating, and worse, hard to find in the documentation.
I failed at the latter and fell back to the sources, finding
'./bin-wrappers/test-date approxidate' for trying.

Where would I look?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
