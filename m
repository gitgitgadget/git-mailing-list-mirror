Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FA21FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbdJXNTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 09:19:52 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:39528 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932750AbdJXNTt (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 09:19:49 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=localhost.localdomain); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1e6z7S-0003Md-SU; Tue, 24 Oct 2017 15:19:46 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, j6t@kdbg.org,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 1/1] completion: add remaining flags to checkout
Date:   Tue, 24 Oct 2017 15:19:31 +0200
Message-Id: <20171024131931.18221-1-thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.15.0.rc0.245.g6d586db062
In-Reply-To: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1508851189;fed39a54;
X-HE-SMSGID: 1e6z7S-0003Md-SU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commits 1fc458d9 (builtin/checkout: add --recurse-submodules
switch, 2017-03-14), 08d595dc (checkout: add --ignore-skip-worktree-bits
in sparse checkout mode, 2013-04-13) and 32669671 (checkout: introduce
--detach synonym for "git checkout foo^{commit}", 2011-02-08) checkout
gained new flags but the completion was not updated, although these flags
are useful completions. Add them.

The flags --force and --ignore-other-worktrees are not added as they are
potentially dangerous.

The flags --progress and --no-progress are only useful for scripting and are
therefore also not included.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d934417475..eb6ade6974 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1250,7 +1250,8 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch
+			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
+			--recurse-submodules --no-recurse-submodules
 			"
 		;;
 	*)
-- 
2.15.0.rc0.245.g6d586db062

