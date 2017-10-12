Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643E920372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdJLMVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:21:31 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:43980 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751004AbdJLMV3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 08:21:29 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=localhost.localdomain); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1e2cUQ-00057r-LG; Thu, 12 Oct 2017 14:21:26 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v1 1/1] completion: add remaining flags to checkout
Date:   Thu, 12 Oct 2017 14:20:59 +0200
Message-Id: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.15.0.rc0.245.g6d586db062
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507810889;e905576d;
X-HE-SMSGID: 1e2cUQ-00057r-LG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commits 1d0fa898 (checkout: add --ignore-other-wortrees,
2015-01-03), 1fc458d9 (builtin/checkout: add --recurse-submodules switch,
2017-03-14), 870ebdb9 (checkout: add --progress option, 2015-11-01),
08d595dc (checkout: add --ignore-skip-worktree-bits in sparse checkout
mode, 2013-04-13), 1d0fa898 (checkout: add --ignore-other-wortrees,
2015-01-03), 32669671 (checkout: introduce --detach synonym for "git
checkout foo^{commit}", 2011-02-08) and db941099 (checkout -f: allow
ignoring unmerged paths when checking out of the index, 2008-08-30)
checkout gained new flags but the completion was not updated, although
these flags are useful completions. Add them.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d934417475..393d4ae230 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1250,7 +1250,9 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch
+			--conflict= --orphan --patch --detach --progress --no-progress
+			--force --ignore-skip-worktree-bits --ignore-other-worktrees
+			--recurse-submodules --no-recurse-submodules
 			"
 		;;
 	*)
-- 
2.15.0.rc0.245.g6d586db062

