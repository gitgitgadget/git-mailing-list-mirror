Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E393203E5
	for <e@80x24.org>; Sat, 23 Jul 2016 04:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbcGWE0S (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 00:26:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37132 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbcGWE0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 00:26:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C907203E2;
	Sat, 23 Jul 2016 04:26:17 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>, Clemens Buchacher <drizzd@aon.at>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] fix git-svn HTTP tests under Apache 2.4
Date:	Sat, 23 Jul 2016 04:26:06 +0000
Message-Id: <20160723042608.27489-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This resurrects the series started by Michael in April 2015 at:

  https://public-inbox.org/git/cover.1428505184.git.git@drmicha.warpmail.net/T/

But only keeps only his first patch.  PATCH 2/2 reuses the
work Clemens introduced in t/lib-httpd.sh back in 2008 to
enable mod_dav_svn.

The following changes since commit 08bb3500a2a718c3c78b0547c68601cafa7a8fd9:

  Sixth batch of topics for 2.10 (2016-07-19 13:26:16 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-httpd

for you to fetch changes up to cbc1a1fbd2911b851467862b7163c303a14b17ab:

  git svn: migrate tests to use lib-httpd (2016-07-23 03:31:21 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git svn: migrate tests to use lib-httpd

Michael J Gruber (1):
      t/t91*: do not say how to avoid the tests

 t/lib-git-svn.sh                              | 91 +++++----------------------
 t/lib-httpd.sh                                |  8 ++-
 t/lib-httpd/apache.conf                       |  4 +-
 t/t9100-git-svn-basic.sh                      |  2 -
 t/t9115-git-svn-dcommit-funky-renames.sh      |  7 ++-
 t/t9118-git-svn-funky-branch-names.sh         |  2 +-
 t/t9120-git-svn-clone-with-percent-escapes.sh |  2 +-
 t/t9142-git-svn-shallow-clone.sh              |  2 +-
 t/t9158-git-svn-mergeinfo.sh                  |  2 -
 t/t9160-git-svn-preserve-empty-dirs.sh        |  1 -
 10 files changed, 30 insertions(+), 91 deletions(-)

