Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5415C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945E120731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD3RdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:33:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57718 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3RdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 13:33:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 683DC1F9E0;
        Thu, 30 Apr 2020 17:33:02 +0000 (UTC)
Date:   Thu, 30 Apr 2020 17:33:02 +0000
From:   Eric Wong <e@yhbt.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Guess the base-commit of a series
Message-ID: <20200430173302.GA18877@dcvr>
References: <20200430172147.3fblnrvi73asnkp5@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430172147.3fblnrvi73asnkp5@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> Hello:
> 
> Given a/ b/ filenames and blob index information, is there a relatively 
> easy way to find the latest branch commit where a patch series would 
> apply cleanly (i.e. guess the base-commit)?

Not as far as I know...

Indexing git repos to store a reverse mapping of
blobs => commits/trees/tags is something I've been planning
as part of public-inbox (for the "solver" subcomponent which
recreates blobs from patch mails, I want it to recreate trees).

I'm not sure if/when I'll get around to it; and it's
space-intensive with Xapian, too.
