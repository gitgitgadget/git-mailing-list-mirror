Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D4FC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjEQVse (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjEQVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:48:32 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555C5B84
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:28 -0700 (PDT)
Date:   Wed, 17 May 2023 21:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1684360106; x=1684619306;
        bh=bKL6UPIyzqA7CXf0X7uaoYDcn3BUGqslLIHe10kR/88=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=1MEqW7k7zUv83y6HXnXnLZA9G91ohzbmVX5DNvV/HpPzWbe0NvBBRH17TRPFQxcQK
         Px+q3mpx15wIHYXhrJtJDd0ZQ25tLDrN4d6EpYLkPkZM6ep/faVQ1RFbQj++y3f+0I
         qnYFFCrPCPJU9xw34YSCdsw3elnC3y+P+bPpT7StUBFT5AbsYNRMRN7nnWOIF5Juh3
         8dKRbf+ayVi+wXZS4bcgVciA6BzQQFJx8edeuFGqfw5r6C/6aZTBIgq5D7z2Kvbwxs
         GSjoK0wLLSgJkyZ6nCy51Ovb5bJGwccQcg+7k19x1O3jzguX5Aw6SjIdr18d0PLz78
         FzmAWuV5/nuTA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [RESEND PATCH v10 1/8] worktree add: include -B in usage docs
Message-ID: <20230517214711.12467-2-jacobabel@nullpo.dev>
In-Reply-To: <20230517214711.12467-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230517214711.12467-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document `-B` next to where `-b` is already documented to bring the
usage docs in line with other commands such as git checkout.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 2 +-
 builtin/worktree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 063d6eeb99..b9c12779f1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [-b <new-branch>] <path> [<commit-ish>]
+=09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 39e9e5c9ce..d1b4b53f2c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,7 +22,7 @@
=20
 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
+=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
--=20
2.39.3


