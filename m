Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C117020193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbcHKUz0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:55:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:21185 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcHKUzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:55:25 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id E6305845F5;
	Thu, 11 Aug 2016 16:55:23 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 0/9] status: V2 porcelain status
Date:	Thu, 11 Aug 2016 16:51:28 -0400
Message-Id: <1470948697-63787-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This patch series adds porcelain V2 format to status.
This provides detailed information about file changes
and about the current branch.

The new output is accessed via:
    git status --porcelain=v2 [--branch]

This v7 patch series address the most recent feedback
on the unit tests.

This series has been rebased onto a more current master
branch (to get the EMPTY_BLOB changes in the test suite).

Jeff Hostetler (9):
  status: rename long-format print routines
  status: cleanup API to wt_status_print
  status: support --porcelain[=<version>]
  status: collect per-file data for --porcelain=v2
  status: print per-file porcelain v2 status data
  status: print branch info with --porcelain=v2 --branch
  git-status.txt: describe --porcelain=v2 format
  test-lib-functions.sh: Add lf_to_nul
  status: unit tests for --porcelain=v2

 Documentation/git-status.txt | 133 +++++++++-
 builtin/commit.c             |  78 +++---
 t/t7060-wtstatus.sh          |  21 ++
 t/t7064-wtstatus-pv2.sh      | 592 +++++++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh      |   4 +
 wt-status.c                  | 570 ++++++++++++++++++++++++++++++++++++-----
 wt-status.h                  |  19 +-
 7 files changed, 1305 insertions(+), 112 deletions(-)
 create mode 100755 t/t7064-wtstatus-pv2.sh

-- 
2.8.0.rc4.17.gac42084.dirty

