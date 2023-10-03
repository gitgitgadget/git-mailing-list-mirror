Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DEE8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjJCUb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjJCUb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:31:28 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD46B7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:31:24 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A132D1F55F;
        Tue,  3 Oct 2023 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1696365084;
        bh=34eBHHUFsR0fWILt8P+4Z4dxzs92eVp73uCgXAXwmoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFuoCdARnhRVhzfOcmbocaXHqWBi7XzoXi/gBGQ0NgiRnSEuCqthmMn60awUgkG7X
         ExAY8XRnoeQBTb34pPbNZx0htrmVffdjImlNla2X1I0Y0Gx5fTWA5OSFmHyovLASrX
         pBeBlO/f6jCfYxvIIqTscIGX7k3+bBR+VsVPlDjY=
Date:   Tue, 3 Oct 2023 20:31:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: batch-command wishlist [was: [TOPIC 02/12] Libification Goals
 and Progress]
Message-ID: <20231003203124.M560967@dcvr>
References: <20231003005251.M353509@dcvr>
 <20231003201048.GD1562@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003201048.GD1562@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I know that you asked for a persistent process, but just for reference,
> you can hackily access approxidate with:
> 
>   git config --type=expiry-date --default='15 days ago' does.not.exist

--type is too new (trying to support 1.8.x :<).  But yeah, using
`git rev-parse --since=15.days.ago` and extracting the integers
