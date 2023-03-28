Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C4C76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 10:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjC1KU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1KU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 06:20:28 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38274EE8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 03:20:25 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 44C7C1F452;
        Tue, 28 Mar 2023 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1679998824;
        bh=PK4Ha2j7iHyAiGimOCkMG9FdvaeqQC9olLcgUzihrIY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=tB7ifdjO+L8XX/moCl1Z95P458dglEtdLdObO0zSVPvxqPZvVAlFs4ODvTDcmJiL2
         6+Gh8pRkOABrwD6lrDcJ0/3TH6F4hzyXyhiKLaAX+V4NkbES70bqwoXX+NQm4tppxB
         2D1C8DTR66XUhi9spQ4ImwnCirVdX7k3xZaXWdmY=
Date:   Tue, 28 Mar 2023 10:20:24 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: Re: public-inbox.org/git to be downgraded
Message-ID: <20230328102024.M217579@dcvr>
References: <20230313215704.M573757@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313215704.M573757@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Due to increasing costs and inflation, I'll be switching to a
> cheaper VPS and likely proxying via ssh tunnel like I do with
> <https://80x24.org/lore/>[1]

Done.  The HTTP/HTTPS endpoint is running via ssh tunnel because
Xapian requires a lot of disk space, but I managed to keep the
git@vger NNTP(S)/IMAP(S) endpoints on the VPS for now since
those only need the smaller SQLite DBs.

IMAP used to have search enabled, but I figure server-side IMAP
search is rarely useful; so the search index is gone on
imaps://public-inbox.org/inbox.comp.version-contro.git.*

IMAP search remains enabled on the Tor .onion endpoint:
  imap://ie5yzdi7fg72h7s4sdcztq5evakq23rdt33mfyfcddc5u3ndnw24ogqd.onion/
(which requires Tor to access, so it's pretty slow)

> Reaching me may become less reliable, too, since my MTA is
> on the same VPS that's being downgraded.

Actually, 1G is still a lot of RAM to me; 4x more than I had in 2008.
(32-bit userspace, 64-bit kernel)
