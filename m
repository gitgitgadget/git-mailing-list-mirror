Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B07C41513
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHKXkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbjHKXkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:10 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA610F6
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 16:40:09 -0700 (PDT)
Date:   Fri, 11 Aug 2023 23:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1691797206; x=1692056406;
        bh=ciWAnYIco26ops+WzSug1vNHrLamwn++02fCY05evuI=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=anNRzv07SppwQa2ZWPB92qsEgGXHOfqBgA9hBSOAGrdTykxaKTyXtAvLkZmjhD2k4
         pupnPOYcu0tB9Yr9ZYPAMc3qTUi1r34zV2Ln/30oxbK/R0xrAHL0AmqoxDfJhvcv0b
         sWCDrrdrG+GIPLvs9j1CjWFUkz15KdxKofkQNXCwoN7qvNJ89TbS0scHUOZy1oLhRU
         nG3xSHEl86DTpyw77JqRltv9loNZPlZfUX74+JZQWkcNMSSmNzEVewP0XKkz3KvLnn
         SKT4PzwvEm1qqLc7vzxWK58+eLofREDqbx3xRSHf/KcIytQ5iDtjZF35zIaswGvuN1
         SlTAfUsaOYBfQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] builtin/worktree.c: Fix typo in "forgot fetch" msg
Message-ID: <20230811233940.30264-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace misspelled word "overide" with correctly spelled "override".

Reported-By: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
This patch fixes a typo identified in [1].=20

Luckily the text that contained this typo didn't interact with any other
behavior and the change didn't require any modifications to the test
code so it was a very quick, easy fix.

1. https://lore.kernel.org/git/20230809064724.13032-1-tenglong.tl@alibaba-i=
nc.com/

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4cd01842de..10db70b7ec 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -696,7 +696,7 @@ static int can_use_remote_refs(const struct add_opts *o=
pts)
 =09=09return 1;
 =09} else if (!opts->force && remote_get(NULL)) {
 =09=09die(_("No local or remote refs exist despite at least one remote\n"
-=09=09      "present, stopping; use 'add -f' to overide or fetch a remote =
first"));
+=09=09      "present, stopping; use 'add -f' to override or fetch a remote=
 first"));
 =09}
 =09return 0;
 }

base-commit: fac96dfbb1c24369ba7d37a5affd8adfe6c650fd
--=20
2.41.0


