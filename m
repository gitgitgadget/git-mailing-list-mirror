Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B26C1FF76
	for <e@80x24.org>; Fri, 16 Dec 2016 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161026AbcLPQr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 11:47:58 -0500
Received: from continuum.iocl.org ([217.140.74.2]:56555 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934828AbcLPQr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 11:47:57 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uBGGlpE12382;
        Fri, 16 Dec 2016 17:47:51 +0100
Date:   Fri, 16 Dec 2016 17:47:51 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: Races on ref .lock files?
Message-ID: <20161216164751.GA12174@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We're occasionally seeing a lot of 

  error: cannot lock ref 'stash-refs/pull-requests/18978/to': Unable to create '/opt/apps/..../repositories/68/stash-refs/pull-requests/18978/to.lock': File exists.

from the server side with fetches as well as pushes. (Bitbucket server.)

What I find strange is that neither the fetches nor the pushes even
touch these refs (but the bitbucket triggers underneath might).

But my question is whether there are race conditions that can cause
such messages in regular operation - they continue with 'If no other git
process is currently running, this probably means a git process crashed
in this repository earlier.' which indicates some level of anticipation.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
