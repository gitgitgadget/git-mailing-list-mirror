Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E9BC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E73206D8
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfLRTbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:31:37 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50935 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRTbh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:31:37 -0500
X-Originating-IP: 157.36.178.182
Received: from localhost (unknown [157.36.178.182])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CEF21FF802
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 19:31:34 +0000 (UTC)
Date:   Thu, 19 Dec 2019 01:01:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree
 add'
Message-ID: <20191218193129.hnvaetebih4y2slt@yadavpratyush.com>
References: <20191214161438.16157-1-me@yadavpratyush.com>
 <20191214161438.16157-2-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214161438.16157-2-me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/19 09:44PM, Pratyush Yadav wrote:
> When no branch name is supplied to 'worktree add', it creates a new
> branch based on the name of the directory the new worktree is located
> in. But when the worktree is later removed, that created branch is left
> over.
> 
> Remove that branch when removing the worktree. To make sure no commits
> are lost, the branch won't be deleted if it has moved.
> 
> An example use case of when something like this is useful is when the
> user wants to check out a separate worktree to run and test on an older
> version, but don't want to touch the current worktree. So, they create a
> worktree, run some tests, and then remove it. But this leaves behind a
> branch the user never created in the first place.
> 
> So, remove the branch if nothing was done on it.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Ping?

-- 
Regards,
Pratyush Yadav
