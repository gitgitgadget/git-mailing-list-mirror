Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BC81F454
	for <e@80x24.org>; Fri, 18 Jan 2019 22:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfARWkz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:40:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45830 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfARWkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:40:55 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 61D231F453;
        Fri, 18 Jan 2019 22:40:55 +0000 (UTC)
Date:   Fri, 18 Jan 2019 22:40:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Steve Keller <keller.steve@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: How do I get rid of unneeded objects?
Message-ID: <20190118224055.zpsz63b3gaxtwscu@dcvr>
References: <trinity-02f2f7de-850d-4ad6-b709-86b7914cd81f-1547818792471@3c-app-gmx-bs22>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-02f2f7de-850d-4ad6-b709-86b7914cd81f-1547818792471@3c-app-gmx-bs22>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steve Keller <keller.steve@gmx.de> wrote:
>     $ git reflog expire --all

I've never used "git reflog" directly, but I think you need to
add "--expire=all" to cover all time.  "--all" is only for all
branches, so you need "--expire=<time>" is for a time range.

Fwiw, I use a single command:

	git -c gc.reflogExpire=now gc --prune=all
