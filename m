Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6FC77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 12:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEGMGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjEGMGV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 08:06:21 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D859E3
        for <git@vger.kernel.org>; Sun,  7 May 2023 05:06:16 -0700 (PDT)
Date:   Sun, 07 May 2023 12:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683461175; x=1683720375;
        bh=WiaPI7sx4T4N89L5oVeZ+tQyGGHxYTJXj6TK+LE8Btw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MAL80UGJd/gkEqsuTAy3S4dJoTfpQz5/Cf333WXnGHZtqSKBT0NkaO3iOyqCdb7gS
         cKCURMba5iLoC6hJNoauy9JfX0qQr6uomwz7GZs8lO+JSCimuY0AB+fh+HdOOZc7OL
         eSZjcqow6aEFyd97EXBXaaUFJWiomHG8oaV5FDkHkGbQCEMY9uRUMgxwOFeJ62oBcN
         fj/WfON2mfdU2vQ5AAhqXlfj3AHmExNMRU68rEii56XkoTLxtqDU8fJ4kxjHSEbF1r
         kAZFdtdt99modwsjUagdHzoJzJ9Ynadntr18jw3iz4G/lPLKJjy/cTTh9Mjev9cJK2
         0jQ6/MCcHqaTQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v10 1/8] worktree add: include -B in usage docs
Message-ID: <20230507120530.14669-2-jacobabel@nullpo.dev>
In-Reply-To: <20230507120530.14669-1-jacobabel@nullpo.dev>
References: <20230507120530.14669-1-jacobabel@nullpo.dev>
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

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
+=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
--
2.39.3


