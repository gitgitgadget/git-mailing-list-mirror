Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77001F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbcHBOPi (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 10:15:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:59867 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694AbcHBOPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 10:15:25 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id F0F1A84640;
	Tue,  2 Aug 2016 10:15:03 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v4 0/8] status: V2 porcelain status
Date:	Tue,  2 Aug 2016 10:12:09 -0400
Message-Id: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series adds porcelain V2 format to status.
This provides detailed information about file changes
and about the current branch.

The new output is accessed via:
    git status --porcelain=v2 [--branch]

Relative to the V3 patch series, in this V4 patch series
I've updated Documentation/git-status.txt for clarity.

Jeff Hostetler (8):
  status: rename long-format print routines
  status: cleanup API to wt_status_print
  status: support --porcelain[=<version>]
  status: per-file data collection for --porcelain=v2
  status: print per-file porcelain v2 status data
  status: print branch info with --porcelain=v2 --branch
  git-status.txt: describe --porcelain=v2 format
  status: tests for --porcelain=v2

 Documentation/git-status.txt | 130 +++++++++-
 builtin/commit.c             |  78 +++---
 t/t7060-wtstatus.sh          |  21 ++
 t/t7064-wtstatus-pv2.sh      | 585 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 567 ++++++++++++++++++++++++++++++++++++-----
 wt-status.h                  |  19 +-
 6 files changed, 1289 insertions(+), 111 deletions(-)
 create mode 100755 t/t7064-wtstatus-pv2.sh

-- 
2.8.0.rc4.17.gac42084.dirty

