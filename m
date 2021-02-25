Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEEC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D36C64EBA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhBYFdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 00:33:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48054 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233192AbhBYFdX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 00:33:23 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 863F81F9FD;
        Thu, 25 Feb 2021 05:32:40 +0000 (UTC)
Date:   Thu, 25 Feb 2021 05:32:40 +0000
From:   Eric Wong <e@80x24.org>
To:     Stef Bon <stefbon@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: FUSE fs for git.
Message-ID: <20210225053240.GA10230@dcvr>
References: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stef Bon <stefbon@gmail.com> wrote:
> - is there an api I can use (lowlevel and/or highlevel or whatever is
> available)?

I've used "git cat-file --batch" in many places via pipes.
Git.pm provides a convenient interface for it.
It handles requests like "$REFNAME:$PATHNAME" so it'd be
pretty easy to map FS-like paths to it.

"git fast-import" is also nice if you need write access and
nowadays has "cat-blob" functionality similar to the
aforementioned --batch.
