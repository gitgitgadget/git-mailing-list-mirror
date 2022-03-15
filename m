Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F951C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiCOBvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbiCOBu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF790140CE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h15so26725972wrc.6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=dJZnmcN/JyWnwN5p8XQrJjd+j2ZD8Ufv+Fqc3QXUfHFtsK02dEJuK1issi11vuDBao
         UbfYY/BhGvvVwGfWi+9rgrACbrbeKS6tKabk4c71lhtoUjLfPbqrhsmE8LaRviAaQY9P
         7FFXTnLMP0fU+832FhmvIZUsF4fjM3rdMSXK1k+80ZOfwmnbKaBQzb9jjsZXUlrK+lFq
         +Q7U5gYOMg/K02LtohbLUurQKbgAIS70J9n+yuAkO5YePkCg7oz+9RzbCGQkphVIx8Gz
         bjrvVd9hBLUQy7mB5OIsQjZmT/Bn94RaNvsG6feKM+EzlZPB+MSitZ9PZbtZxdshm0zk
         XJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=tKnbidQsr1Z0yA9j+fOWJME+NbxdADTPVT3Mq/8uJxDCFK4ZFLiXY0L5D1vChAEdpz
         cey+0mtiK7n+eNcklBJuN9aeYKiAHKMHGkw3bKHH6zMXiwfz+dGQq/dGjXYqr+1/fIfw
         A4AC9UW+F+bS9gfaGePRnNtrPoqxUeW2gPw8pSE/Gdiq1uOVWyF+UTRv0fmHEFEPBBIG
         9uk/4SZYsrvIS+iArMyrxrIwXz1DlEiK6LGawG7nkCijipSs+OB2wWKm9yoIN92htIMO
         Le1wapXAq7CJGDFjN2T0EonkvR61kE9KhVf6ysO3thtmRmmeXR+wNBTP62IaRahtmnC5
         8m2w==
X-Gm-Message-State: AOAM532XYbCxKTunOr2S5GOg3N+Fiq74IaNkVMu3jn83i1zEYf3VZwjC
        Mk8RMzmc3asfmKcpiIcH4MzCMFSk4yI=
X-Google-Smtp-Source: ABdhPJzL9EsGN4JRYNa1XiQqjXn5xZ2yj7NPgW4lehS0h/onOpSXWMszurxD0zuKONNJsTTy86kFCw==
X-Received: by 2002:a5d:6782:0:b0:203:d6af:5869 with SMTP id v2-20020a5d6782000000b00203d6af5869mr285869wru.213.1647308984171;
        Mon, 14 Mar 2022 18:49:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b001f04b96f9a9sm14339000wrd.42.2022.03.14.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:43 -0700 (PDT)
Message-Id: <7206ef8dd8ab088feab841c5574d486b6f19af5e.1647308982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:38 +0000
Subject: [PATCH v3 1/5] reset: revise index refresh advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the advice describing index refresh from "enumerate unstaged changes"
to "refresh the index." Describing 'refresh_index(...)' as "enumerating
unstaged changes" is not fully representative of what an index refresh is
doing; more generally, it updates the properties of index entries that are
affected by outside-of-index state, e.g. CE_UPTODATE, which is affected by
the file contents on-disk. This distinction is relevant to operations that
read the index but do not refresh first - e.g., 'git read-tree' - where a
stale index may cause incorrect behavior.

In addition to changing the advice message, use the "advise" function to
print advice.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config/advice.txt | 4 ++--
 builtin/reset.c                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..971aad2f237 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -69,8 +69,8 @@ advice.*::
 		merge to avoid overwriting local changes.
 	resetQuiet::
 		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to enumerate unstaged
-		changes after reset.
+		when the command takes more than 2 seconds to refresh the index
+		after reset.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/builtin/reset.c b/builtin/reset.c
index 6e65e90c5db..a420497a14f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -525,9 +525,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 				if (advice_enabled(ADVICE_RESET_QUIET_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
-					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+					advise(_("It took %.2f seconds to refresh the index after reset.  You can\n"
 						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
-						"to make this the default.\n"), t_delta_in_ms / 1000.0);
+						"to make this the default."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
-- 
gitgitgadget

