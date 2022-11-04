Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C737C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKDBDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDBDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:13 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D31E3FC
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:03:12 -0700 (PDT)
Date:   Fri, 04 Nov 2022 01:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667523790; x=1667782990;
        bh=11ySiXZgSuqaGTVC5I73fvMaZ8SRBWBbTXDpTVEo8D8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dHfuZGKElwGFzMce8n2E8IHjwqIY1dFGLhTAaG3LFPYTcNbpP2wIfM4FeLG/3BHOL
         +5PrKXLuNdroBAL7/EeT4hTmtR7Gi/IsIzaTMt4IwiCcrESF2KVqa2vs8BNzETxZqz
         3gly/zo+HPRDfbLPPhmbCUR5ZuxJaUwtExnazi9sPmnDmxb2k2m1MQRivy+KRDC50Q
         Kt4gSPeCizoBbiCOnXhq/WLb0CYlQd0QmV3lBngPK5wHaOD98Ar2q2LQyxZv75kX2N
         BKYCUDGTAb3k1nQzM/YmtfCBPPYZTodUmXdGC8Nx/eiea65edetbragX8uh/qNJsTo
         zkID9spPeOk1Q==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH 1/4] worktree add: Include -B in usage docs
Message-ID: <20221104010242.11555-2-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While -B behavior is already documented, it was not included in the
usage docs for either the man page or the help text. This change fixes
that and brings the usage docs in line with how the flags are documented
in other commands such as git checkout.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 2 +-
 builtin/worktree.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 063d6eeb99..4dd658012b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [-b <new-branch>] <path> [<commit-ish>]
+=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4a24d53be1..b3373fbbd6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -15,9 +15,9 @@
 #include "worktree.h"
 #include "quote.h"

-#define BUILTIN_WORKTREE_ADD_USAGE \
+#define BUILTIN_WORKTREE_ADD_USAGE                                        =
                \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
+=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
--
2.37.4


