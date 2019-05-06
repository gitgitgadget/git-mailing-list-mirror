Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3ED21F45F
	for <e@80x24.org>; Mon,  6 May 2019 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEFOSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 10:18:30 -0400
Received: from continuum.iocl.org ([217.140.74.2]:48501 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFOSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 10:18:30 -0400
X-Greylist: delayed 1868 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 10:18:29 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id x46DlIc12920;
        Mon, 6 May 2019 15:47:18 +0200
Date:   Mon, 6 May 2019 15:47:18 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: GIT/SSH_ASKPASS used for username input in https:// URLs
Message-ID: <20190506134718.GA12803@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

there is an interesting wart around prompt.c -
PROMPT_ECHO isn't used in invoking an external helper program.

Thus, if I clone something on https (which requires auth for that),
and have SSH_ASKPASS set, I will get two GUI *password* prompts,
even though the first one will indicate in the title that it *is*
asking for the username.

But basically, given the trivial protocol of SSH_ASKPASS, there
doesn't seem to be any way to properly fix this without support
from any desktop environment that sets SSH_ASKPASS. :-(

The best I can currently tell my users is to use the
   [credentials "https:/..."]
configuration to fix the username.

But if we can't fix this, maybe we can at least point this out in the docs?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
