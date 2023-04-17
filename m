Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24323C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDQJfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDQJfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:35:33 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B993AA1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:34:50 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724030; x=1681983230;
        bh=CvZmQDe/1jgZsnUPyv9kSZCw8AoISXvuQ7Mfsh4OMa0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QQbFzfPH/Oi1We/bRud0eYk6wPkK+QUUqdD22gusNWBNeVKr6r7ZJCDs1DjwpcO0f
         xo6sztuwnyOVp7NoT1CtOV4RuMdM+JAnQYlvtDb2ekligqjcSAAqftK1BpgSVHw/Mc
         ky7wbgMtILgEyr82Tb4GxLv4BV3pik4vZ2pk4Rwscob7pMfTHUEr8H0uf1shGZpVPL
         0NaVmNPmTwEXvUcRbD/2xiwrktYo+NT3YIbHjeFFRuW6a1Dx7vZxSvjIZ37FUnLSTu
         oIgICLRfwHozz2EtRMjm1WZfylKdaYBJC8o77rgdo3+OvOsGVJrxCs7cqW4m+ae6Gi
         BvqmsBEiSEVPQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 1/8] worktree add: include -B in usage docs
Message-ID: <20230417093255.31079-2-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
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
2.39.2


