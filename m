Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689EC203C1
	for <e@80x24.org>; Sun, 24 Jul 2016 03:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbcGXDOL (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 23:14:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33782 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbcGXDOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 23:14:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67270203C1;
	Sun, 24 Jul 2016 03:14:09 +0000 (UTC)
Date:	Sun, 24 Jul 2016 03:14:09 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160724031409.GA32480@starla>
References: <20160722224739.GA22961@whir>
 <alpine.DEB.2.20.1607231056150.14111@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607231056150.14111@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I think that this change:

<snip>

> deserves to live in a separate patch... It would make the real change
> stick out better.

Good point, I actually wrote a looser check based on
is_mboxrd_from before realizing the stricter check from
mailsplit would probably be more appropriate to use by default.


The following changes since commit 08bb3500a2a718c3c78b0547c68601cafa7a8fd9:

  Sixth batch of topics for 2.10 (2016-07-19 13:26:16 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git mboxo

for you to fetch changes up to 4f769f1799db11f135948bf517f2d8d864fa778f:

  format-patch: escape "From " lines recognized by mailsplit (2016-07-23 21:38:40 +0000)

----------------------------------------------------------------
Eric Wong (2):
      mailinfo: extract is_from_line from mailsplit
      format-patch: escape "From " lines recognized by mailsplit

 builtin/mailsplit.c     | 32 +-------------------------------
 mailinfo.c              | 31 +++++++++++++++++++++++++++++++
 mailinfo.h              |  1 +
 pretty.c                | 16 +++++++++++++---
 t/t4014-format-patch.sh | 14 ++++++++++++++
 5 files changed, 60 insertions(+), 34 deletions(-)
