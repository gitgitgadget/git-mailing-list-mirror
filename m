Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B3CC43217
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKITH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKITHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:07:24 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93A1F2C1
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:07:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668020841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2uIRLtHGH/12tT9dncmk57RT+nDaze7ztwY8Id+FxJ4=;
        b=VN4LXRbpsWQWIBbLrE+2jFyOKduw6lkCOGAKv6oU8/1LXmaEOAUw6w7nIGhof7rdokOEdV
        EzR9cq67ibNRlwbtALIgzEnMV6e2KrtVBnSRCebcX4G52plAZNpxA54HrceFVdkBuJ2AWP
        PkeEmSPu2GX29gChE0Hha9YU9G6gZgc=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
Subject: [PATCH v3 0/2] git-maintenance quality-of-life improvements
Date:   Wed,  9 Nov 2022 12:07:06 -0700
Message-Id: <20221109190708.22725-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pair of quality-of-life patches for git-maintenance that have
helped me in my workflow. PTAL.

Changes in v2:
 - Added a test case for path interpolation in for-each-repo
 - Changed [--config <file>] to [--config-file <path>] in
   register/unregister
 - Dropped the short-name option, -c
 - Avoid finding the global config when the user has supplied the config
   on the command line

Changes in v3:
 - Report an error in unregister when the user specifies a config where
   the repo is not already registered
 - Add a test case for the above
 - Correct option description in the docs

Ronan Pigott (2):
  for-each-repo: interpolate repo path arguments
  maintenance: add option to register in a specific config

 Documentation/git-maintenance.txt | 14 +++++-----
 builtin/for-each-repo.c           |  5 +++-
 builtin/gc.c                      | 45 ++++++++++++++++++++++---------
 t/t0068-for-each-repo.sh          |  6 +++++
 t/t7900-maintenance.sh            | 21 ++++++++++++++-
 5 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.38.1

