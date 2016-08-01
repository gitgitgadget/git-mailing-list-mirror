Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2201F955
	for <e@80x24.org>; Mon,  1 Aug 2016 01:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcHABGJ (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 21:06:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45824 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcHABGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 21:06:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C101F858;
	Mon,  1 Aug 2016 01:06:05 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: [PATCH 0/2] add PAGER_ENV to build and core.pagerEnv to config
Date:	Mon,  1 Aug 2016 01:05:55 +0000
Message-Id: <20160801010557.22191-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This series allows us to more easily configure platform-specific
defaults at build-time and also allow users to override them
at runtime via config.

Previous discussion in this thread:

	https://public-inbox.org/git/52D87A79.6060600@rawbw.com/T/

The following changes since commit f8f7adce9fc50a11a764d57815602dcb818d1816:

  Sync with maint (2016-07-28 14:21:18 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git pager-env

for you to fetch changes up to 1563ef177f9c1ee990bb3547f16bd7568a17379a:

  pager: implement core.pagerEnv in config (2016-08-01 00:51:42 +0000)

----------------------------------------------------------------
Eric Wong (1):
      pager: implement core.pagerEnv in config

Junio C Hamano (1):
      pager: move pager-specific setup into the build

 Documentation/config.txt |  7 +++++++
 Makefile                 | 19 +++++++++++++++++--
 config.mak.uname         |  1 +
 git-sh-setup.sh          |  8 +++++---
 pager.c                  | 35 +++++++++++++++++++++++++++++++----
 t/t7006-pager.sh         | 14 ++++++++++++++
 6 files changed, 75 insertions(+), 9 deletions(-)
