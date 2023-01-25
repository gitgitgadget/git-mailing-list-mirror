Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905DC54EAA
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjAYEEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYEEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63674997D
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n7so15773374wrx.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lRB6TfgwlHpAlpY1phqfYBxeXsom1nztOw6cHxhoxg=;
        b=PFFH69hDJuCvcobmtC0nxqaiVt3BjVJgKHpe6+m+jUObDS6Nl9lwRQDSzPEsguWPQc
         B3l5isWUwZG7D6Xr/usWeSvyd1dfEaXEd3rcUaIrJEAQey1YpQsL3YR1EMoZ2QGscUmp
         A+z0r76C9Phth2dx4AIIzwubbbTaRQ7xlCXZoA2mrPuUGP0vXVvzSD/6w+Xj78t/8HXv
         b615c0i5TSTlNTKIvvhQQwZXCAbOS0qc0KFQx7j0L9RNGzFIBst2hsRec2suoeRS3iul
         ZqYxuXnVtxElFXRd3CE3UlVAyYLEE6MleNNLG5pWR6+CQPCP63zN53GeTkweX1w+jdvW
         zOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lRB6TfgwlHpAlpY1phqfYBxeXsom1nztOw6cHxhoxg=;
        b=sgvqbqvcLw58aRvNPWa8IbGjhddBQZ+qAMbhx2ufsQ9wJCwjmnvBvuJ2C6HFy04T2E
         M6IHg16797jIJVcCG3NVeTOTgE8h28zgP5HB0yJIQL9rn6U2BQaEOlV2350m392+mudt
         xwQmFc3wvgC2b6F44b7aeA3ZJCl//9T3GriXqxW/rlJEO3RKZnu1JF2417lfrdbyhmUK
         46JgUBdU9yFENFuJfRgjTURnyUd7sJovmpZ1td7VCMb7FXD1bNQqTn4QXPoMyvH+oMpW
         z4pXy/f0EVkN5XQ9++aIg3dOV4eFlZiYuvtz9MK6PYR9+7dvAObYChdiCg5BEUyU8EIz
         RHnQ==
X-Gm-Message-State: AFqh2kqAL4CkaZXAGSyyiLGbR8TyJ0CCW1z7DOB2mCo1pG983Di6gc36
        leXA0x/nXb7/H1pBsxKfFZgpGgEPhXk=
X-Google-Smtp-Source: AMrXdXvi5eI+aW9g41NTK6E/CQ+qk83PvsaxFZYkE+6GA4/a7+x99gC2oSxTugqiMvYnYdrPR8IDLw==
X-Received: by 2002:a5d:620a:0:b0:2bb:6b92:d4cc with SMTP id y10-20020a5d620a000000b002bb6b92d4ccmr23776944wru.53.1674619445722;
        Tue, 24 Jan 2023 20:04:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4912000000b002be099f78c0sm3316985wrq.69.2023.01.24.20.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:04 -0800 (PST)
Message-Id: <f646abee52400c3bb6ca0b2c32f712547b3c9df3.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:53 +0000
Subject: [PATCH v5 09/10] rebase: put rebase_options initialization in single
 place
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d6b20a6a536..ad5ebecbbdb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -134,6 +134,8 @@ struct rebase_options {
 		.exec = STRING_LIST_INIT_NODUP,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
+		.reapply_cherry_picks = -1,             \
+		.allow_empty_message = 1,               \
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -1158,8 +1160,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	options.reapply_cherry_picks = -1;
-	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
 	gpg_sign = options.gpg_sign_opt ? "" : NULL;
-- 
gitgitgadget

