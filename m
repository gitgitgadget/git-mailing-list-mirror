Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29A41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJQHim (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:38:42 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:43156 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeJQHim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:38:42 -0400
Received: by mail-oi1-f201.google.com with SMTP id o204-v6so16886036oif.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lINBeYhQ2S7sN/UgrP7cgP7SFTke4BBc4QZO9c8QnII=;
        b=lH2J37Sl0wpqGUi8H9WJ+YiUux93MYh2aJM0E/8945N6nZFYjYZ2cliCt6mellO9Wl
         2hgqjU8NtU9m9QJ7uh3AqdkRPAGcz8pKwuLj6svWyULOISdGxgKOh+LMSfN0kZ7toMZd
         JmicDq4Y4V6H/JmFwydnKhB2OK1YdY1FYKGiSQLbqIxU2doEEYE7ke3j0CpdImvud7Mn
         ZwBxsqOs2sHVkdALWX3WgMpJnol3XSEYE3mvv8vmvT3q3QLUKMp1kq0m+jw6VgpA4+SW
         aLkr3M4Mnf1Ztx30LZf8x8STrUUTrlgZ42h4cm6bryrAgxV91jPrGbn83RPi+oaq7/l+
         GwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lINBeYhQ2S7sN/UgrP7cgP7SFTke4BBc4QZO9c8QnII=;
        b=GR5WMuXp9jHjLHhaJPc3rQjOA2d/+d8U5+duylitCbplFpzFx3pzij6APyApitDcjT
         Gkek3gB4V5m0WvDxXzgDVJgteAnrNJewntjZ6umDOeg+DK1tvQhhN+Cpkx8frJIgrjGV
         FWebPR+EetpRX3IcOPqJAH2e3ZCPlADA/j4RfeSZGEkEB7KEN5NGjZAz4TliUC8pLIV6
         YIdRJj2n9AofmqMb/e2ty4x0Vy9JVFqGJRbyGn7893AaS1P81dd5vPCrJn1qrZQKvMkZ
         VYsbeky0yj3RJb0RxtBMcGG9gn8GB7Wb1FqUo/rZMaEzC62UNeHf85KfTwyb8DF9PXAv
         bnkg==
X-Gm-Message-State: ABuFfohImk6Dgr3F3BeeDFF+SBWdUhxBxvh3zdZi6Xx9lAwlt3l+3jAt
        gz5nOB+OF8R1djTccx5te75J3qz4KGqZ
X-Google-Smtp-Source: ACcGV62sBJnPkoUMUnJ2zMZu8gRmLv114aKcsSPZT2uYWd8gcUMeoks/KpDn8QrO/youXQ3eEyjrCRWPWuHY
X-Received: by 2002:a9d:b9:: with SMTP id w54mr19587473oti.30.1539733555978;
 Tue, 16 Oct 2018 16:45:55 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:45:50 -0700
Message-Id: <20181016234550.216587-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] builtin/submodule--helper: remove debugging leftover tracing
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed 74d4731da1 (submodule--helper: replace connect-gitdir-workingtree
by ensure-core-worktree, 2018-08-13) had two leftover debugging statements
when reading The coverage report [1]. Remove them.

https://public-inbox.org/git/e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

To be applied on (or squashed into the tip of)
  sb/submodule-update-in-c

 builtin/submodule--helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5c9d1fb496..c7d3841ffc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1459,7 +1459,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
-		trace_printf("parsing update");
 		if (parse_submodule_update_strategy(update, out) < 0)
 			die(_("Invalid update mode '%s' for submodule path '%s'"),
 				update, path);
@@ -1468,7 +1467,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
 				val, path);
 	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
-		trace_printf("loaded thing");
 		out->type = sub->update_strategy.type;
 		out->command = sub->update_strategy.command;
 	} else
-- 
2.19.0

