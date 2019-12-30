Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B1C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E111320730
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="Xur3p4Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfL3Pk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:40:26 -0500
Received: from gateway36.websitewelcome.com ([192.185.198.13]:25472 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbfL3Pk0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Dec 2019 10:40:26 -0500
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 10:40:26 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E9065401A48ED
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:27:31 -0600 (CST)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id lwlxiJp9u4kpjlwlxipDKX; Mon, 30 Dec 2019 09:15:57 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hUqsIQGEfKUYocSHTS2xBkEqdVWVDadAM7khj4GF+fE=; b=Xur3p4PkmpenpaJhcJZ2Z0NL76
        eOy7AQUeVbkuuB/bR9C7z6udAXiNzmcG/OuW+gNnRExV4PO1oyHqelAFqRPgcVlul2dZtQk0cGILI
        Plmj/NFfm+4zsocRah2EnqjCj;
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:39376 helo=homebase.home)
        by box5922.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1ilwlx-003YUg-F3; Mon, 30 Dec 2019 08:15:57 -0700
Message-ID: <85e17e0628e05279d1dbbe62b877caa90a43ec38.camel@mad-scientist.net>
Subject: Re: Feature request: add a metadata in the commit: the "commited in
 branch" information
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Arnaud Bertrand <xda@abalgo.com>
Cc:     git@vger.kernel.org
Date:   Mon, 30 Dec 2019 10:15:56 -0500
In-Reply-To: <CAEW0o+gtya5tm6Wb474Srmb2j4E9ocm9p75=aZWjTASbApsb1A@mail.gmail.com>
References: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
         <xmqqd0c6iuw0.fsf@gitster-ct.c.googlers.com>
         <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
         <20191230041517.GA84036@mit.edu>
         <CAEW0o+gtya5tm6Wb474Srmb2j4E9ocm9p75=aZWjTASbApsb1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 98.118.0.140
X-Source-L: No
X-Exim-ID: 1ilwlx-003YUg-F3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-98-118-0-140.bstnma.fios.verizon.net (homebase.home) [98.118.0.140]:39376
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2019-12-30 at 12:59 +0100, Arnaud Bertrand wrote:
> > Why does it need to be the branch name?  You can add your own extra
> > metadata to the git description.
> 
> That's typically my problem.  It is not possible "by default", I mean
> - It is only possible if the developer configure something
> - or if there is an upper layer that guarantee this
> By default, there is no hook embedded with the clone. So, as far as I
> know (and I hope I'm wrong!), you have to use upper layer tools or to
> change environment variables to activate this feature.

In general I have found that trying to mandate what users do in their own
repositories on their own systems is a losing proposition.

Instead, we put requirements on what content is pushed to the central
repository.  Because the central repository is managed by the SCM admin
team we always know only properly-constructed commits can appear there,
without having to assume that every individual developer's local
environment has been set up in a specific way.

This can be done with hooks in the central repository: there are Git hooks
that are run before any push is accepted, which can cause the push to be
rejected, and hooks that are run after a push is accepted, which can be
used for triggering other operations.

So if you have a requirement about contents of Git commit message format,
for example, you can enforce that via these hooks.  If someone attempts to
push commits to the central repository and the commit message has an
incorrect format then the push is rejected and they'll have to fix it
before they can proceed to push.

In the environments I've been associated with we don't care about branch
names; instead everything is based on bug tracker identifiers.  Every
commit needs to be associated with a valid bug ID (added to the commit
message) and the pre-push hook verifies this and rejects the commit if not.
Then after the push is accepted, post-push hooks will update the bug
tracker with information about the push (SHA, software version, etc.)  This
ensures that development and management can use the bug tracker as their
primary planning tool to know what has been accomplished and what is left
to accomplish.  Since the commit message is persisted through cherry-picks, 
etc. it allows us to know which bugs were fixed in which different patch
release branches as well.

