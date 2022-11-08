Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771AC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKHTuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHTt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:49:59 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB1657FB
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:49:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1667936995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aqEBD97B5plsnBmKOwG20IbomZbvKNf8AXOIOAWcgiY=;
        b=cdkajCCFvOiPodLE7XLTgqlCWIZBpk2/70jW6CuUMM1G9R9deN3QJAJbx0hiNeOoQd5Nyx
        9WhZYAUYWH0t7kffty2KS2GPuttGivVl0YagGW/QYr0XVUnFmPCIPnab/jy+uVpWjkMKq+
        8JI8YvC+QgNyllmXdy54dNoIrG50Y5Y=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
Subject: [PATCH v2 0/2] git-maintenance quality-of-life improvements
Date:   Tue,  8 Nov 2022 12:49:28 -0700
Message-Id: <20221108194930.25805-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pair of quality-of-life patches for git-maintenance that have
helped me in my workflow. PTAL.

Changes from v1:
 - Added a test case for path interpolation in for-each-repo
 - Changed [--config <file>] to [--config-file <path>] in
   register/unregister
 - Dropped the short-name option, -c
 - Avoid finding the global config when the user has supplied the config
   on the command line

Ronan Pigott (2):
  for-each-repo: interpolate repo path arguments
  maintenance: add option to register in a specific config

 Documentation/git-maintenance.txt | 14 ++++-----
 builtin/for-each-repo.c           |  5 ++-
 builtin/gc.c                      | 51 +++++++++++++++++++------------
 t/t0068-for-each-repo.sh          |  6 ++++
 t/t7900-maintenance.sh            | 15 +++++++++
 5 files changed, 64 insertions(+), 27 deletions(-)

-- 
2.38.1

