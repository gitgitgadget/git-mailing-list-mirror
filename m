Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E670F20195
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbcGSWN3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:20761 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbcGSWN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:27 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 6E11384637;
	Tue, 19 Jul 2016 18:13:26 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 0/6] Porcelain Status V2
Date:	Tue, 19 Jul 2016 18:10:52 -0400
Message-Id: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series adds porcelain V2 format to status.
This provides detailed information about file changes
and about the current branch.

The new output is accessed via:
    git status --porcelain=2 [--branch]

An earlier draft of this work was submitted under the
"Add very verbose porcelain output to status" title.
This new version addresses the concerns about using
(abusing) "-vv" and simplifies the some of the formatting.

This version does not include the state header from my
first draft.  I agree that if guarded by a "--state"
argument, that output could be added to both formats.


Jeff Hostetler (6):
  Allow --porcelain[=<n>] in status and commit commands
  Status and checkout unit tests for --porcelain[=<n>]
  Per-file output for Porcelain Status V2
  Expanded branch header for Porcelain Status V2
  Add porcelain V2 documentation to status manpage
  Unit tests for V2 porcelain status

 Documentation/git-commit.txt |   2 +-
 Documentation/git-status.txt |  69 +++++-
 builtin/commit.c             |  54 +++--
 t/t7060-wtstatus.sh          |  21 ++
 t/t7064-wtstatus-pv2.sh      | 461 ++++++++++++++++++++++++++++++++++++++++
 t/t7501-commit.sh            |  23 ++
 wt-status.c                  | 487 ++++++++++++++++++++++++++++++++++++++++++-
 wt-status.h                  |  25 +++
 8 files changed, 1122 insertions(+), 20 deletions(-)
 create mode 100755 t/t7064-wtstatus-pv2.sh

-- 
2.8.0.rc4.17.gac42084.dirty

