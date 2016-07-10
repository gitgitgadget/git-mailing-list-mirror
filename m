Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8C41FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 03:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886AbcGJDrx (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 23:47:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50384 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858AbcGJDrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 23:47:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F071FE4E;
	Sun, 10 Jul 2016 03:47:45 +0000 (UTC)
Date:	Sun, 10 Jul 2016 03:47:45 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160710034745.GA20270@dcvr.yhbt.net>
References: <20160710004813.GA20210@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710004813.GA20210@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> 	https://public-inbox.org/.temp/git.vger.kernel.org-6c38c917e55c.gz
> 	(362M)
> 
> 	git init --bare mirror.git
> 	curl $FAST_EXPORT_GZ_URL | git --git-dir=mirror.git fast-import

Oops, that is missing zcat:

	curl $FAST_EXPORT_GZ_URL | zcat | git --git-dir=mirror.git fast-import

> 	git --git-dir=mirror.git remote add --mirror=fetch origin $URL

And I forgot to set a branch for fast-export and just exported
a ref, so importers will need to create master explicitly:

	git update-ref refs/heads/master 6c38c917e55c
