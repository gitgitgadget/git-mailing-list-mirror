Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D5CC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383737AbiFRAVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383705AbiFRAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E75A2C2
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q15so3001392wmj.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hiORs4e9DkzNUZHgsiWSwsPhsPUCvMsvR9nowMjv0Z8=;
        b=R28rqkEwDTi5dJTfN9CozNA25LVl7R0XzbWjNEKkrbLMbNol6IPrUv9xFcbThapdqV
         5WbkHQ35XfXynxV1zrT1AclKY2gFbV/Upg9vF6lV0jNlguUFgCm7ie1Wu4368t7cDE8s
         Oo8Nn0gBISAVIgXdYW9ylYlYL3U3UHYKlfcSz9tOivV2ZRGU5gHljAjDpTYigDLuBDXp
         d0ssTZ2VAq3h2zX58Nx4fDTsl1piDwGGqB+yBmrJeCf/TtdSqjArnP6ckW2uCoC6DLt+
         j6VD9kdd7RppWmyHJB79vxv+LVEpXddePACzlC4TW9ux1Q4ijeEtw4qHX4bCvPLoK85N
         1tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hiORs4e9DkzNUZHgsiWSwsPhsPUCvMsvR9nowMjv0Z8=;
        b=GQF88RwUdcc7PobK3ajf0kjIbD6enIeyTDXUvaIkCJHdXj9xHbZMvBxghyfKOayvrG
         iMVvneC/4Us2eCBFaJEFI70WKn8l2SiHj79sW0eNbbVfSezTvNxAgZzG5ZEzqqrwSu+m
         rGE64JPTRfZLAvy/lRlFuEJy7fbJ05UukGWqVitgrTS96BIGtzHT9bpYHN8O3HDaEtiX
         BBnfFSlfu51CnnDZxnF4zo9M6A+vhSOKez9H0YO3YSjFsIRoxdZrPOmPWjH6XfpG7OR9
         1AMutQ1EI6UPfBsY3F02yoKY9Y7J5VCU7/Ceh0PQSdGaxCFSYUMKb86Awwua0UabcjkW
         rSZw==
X-Gm-Message-State: AOAM530z8BWedxsPHWPoP1tr2TXmn0GycNr9WZ3X/BwqXjKjRGe65lz9
        UaR+35fC7lqA031MyE744Rkj7C1xkS4dFA==
X-Google-Smtp-Source: ABdhPJzncmqMLQ5bIXbUR1n0YUdAFOj1AP4OIy8M17kQSDc4nBwKtyBHvsOoYUIQj+Hz4zPRwhIHPA==
X-Received: by 2002:a05:600c:1547:b0:39c:7fc6:3082 with SMTP id f7-20020a05600c154700b0039c7fc63082mr23253466wmg.189.1655511672319;
        Fri, 17 Jun 2022 17:21:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b0021a3d94c7bdsm3837374wra.28.2022.06.17.17.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:11 -0700 (PDT)
Message-Id: <6419487e26bdaa3fdad357c993f5dd25efe1c70b.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:51 +0000
Subject: [PATCH v7 08/17] merge-ort: remove command-line-centric submodule
 message from merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There was one case in merge-ort that would call path_msg() multiple
times for the same logical conflict, and it was in order to give advice
about how to resolve a conflict.  This advice does not make as much
sense with remerge-diff, or with merge-tree being invoked by a GitHub
GUI for resolution of messages, and is making it hard to provide
which-logical-conflict-affects-which-paths information in a machine
parseable way to a higher level caller of merge-tree.  Let's simply
remove this informational message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                | 9 +--------
 t/t6437-submodule-merge.sh | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1635d215c0b..7e8b9cd6ea7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1693,15 +1693,8 @@ static int merge_submodule(struct merge_options *opt,
 			      (struct commit *)merges.objects[0].item);
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s, but a possible merge "
-			   "resolution exists:\n%s\n"),
+			   "resolution exists: %s"),
 			 path, sb.buf);
-		path_msg(opt, path, 1,
-			 _("If this is correct simply add it to the index "
-			   "for example\n"
-			   "by using:\n\n"
-			   "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			   "which will accept this suggestion.\n"),
-			 oid_to_hex(&merges.objects[0].item->oid), path);
 		strbuf_release(&sb);
 		break;
 	default:
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 178413c22f0..c253bf759ab 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -133,7 +133,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	(cd merge-search &&
 	 git checkout -b test-nonforward b &&
 	 (cd sub &&
-	  git rev-parse sub-d > ../expect) &&
+	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
 		test_must_fail git merge c >actual
-- 
gitgitgadget

