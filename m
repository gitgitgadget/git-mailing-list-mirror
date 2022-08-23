Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704CC32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 02:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiHWCma (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiHWCm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 22:42:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C85C365
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n4so15326011wrp.10
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=7AHPrNObOKNvMnRk95lfv75mX4ZBZdK/ZkBYCgz2Pqs=;
        b=l35hGR1XU9Pnw7PEqNADDj/2WrfnpyhYWQV5KnqQXp8swHmQV/NZUtyIzok6tE5iVo
         lAvzSj2n3MdJdRE8Ie/KoxptmuiUH3EpaJFNy1nWWfxg/36r34cBMAJvBbOjOMp8njdG
         phPEkgG+ylMlM4zc/Dk0vik4Xj+RIDmYi7oGKIySTFI+VfIr2ggNHhaIe7cv5iwOyKDk
         hGwd/vnXW1X2CsdY2vsSTTMXasilcVmbFEIlWzi1/udceC6bfeN9rZiNwt3hp96lkQxJ
         68eXdvQxNodBTCfaC7czDZROcZQto3XsuDhoi/obh7Ca816Ywf+a9yDBhnhsJgS00CWv
         cwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=7AHPrNObOKNvMnRk95lfv75mX4ZBZdK/ZkBYCgz2Pqs=;
        b=gKLodaf5xf9XQM93iQic9zPZ6o13DHCCCLR3a1abAZI0jjaLJq0N+8FRpQo30gCDVD
         QbOeOGUM79poPyl0/0jP8XXqy9U60pCQFgJhLETgoFRi4R4szmUyojycqy7KlOgkA4Na
         96OeHBJVNOTGFT8JgJY5qHmjcRIojx034yxHnWPjAODULXSePGxeS+kzh1Jx4BSwxbwv
         QJa3AeXfwinogfGWFuPwQ44XkGzjUHDrnyXvUD+nCPVrv71EBaeQz/ihH5pjQpMk/eiM
         a6QKolEaPpuYdlMbrXGjORzKziV/aosCFr0FrLqIbv1eUNaqwZ58/HKRcb+32VF6yul4
         nHPg==
X-Gm-Message-State: ACgBeo1SUX1u94lBGQiElYK9akG8o//5ILrwsXuLX5bqKUp/LOOHe8oT
        uxStVEf85nqUP+in8RW1KzKbitae2jA=
X-Google-Smtp-Source: AA6agR4htgiA2DDCC1aF9K6E1lxqTZ812jukKvCHy6JuA+A74tfEAmtn8cuBQDJVnIBh0GpinkQlfw==
X-Received: by 2002:a5d:60d2:0:b0:225:4a27:c319 with SMTP id x18-20020a5d60d2000000b002254a27c319mr6855238wrt.434.1661222545076;
        Mon, 22 Aug 2022 19:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b0021d80f53324sm13254439wrz.7.2022.08.22.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:42:24 -0700 (PDT)
Message-Id: <9817d4b19bc21e1b1581af24c7d89fe33b61638d.1661222541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 02:42:20 +0000
Subject: [PATCH v2 2/3] merge: cleanup confusing logic for handling successful
 merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

builtin/merge.c has a loop over the specified strategies, where if they
all fail with conflicts, it picks the one with the least number of
conflicts.

In the codepath that finds a successful merge, if an automatic commit
was wanted, the code breaks out of the above loop, which makes sense.
However, if the user requested there be no automatic commit, the loop
would continue.  That seems weird; --no-commit should not affect the
choice of merge strategy, but the code as written makes one think it
does.  However, since the loop itself embeds "!merge_was_ok" as a
condition on continuing to loop, it actually would also exit early if
--no-commit was specified, it just exited from a different location.

Restructure the code slightly to make it clear that the loop will
immediately exit whenever we find a merge strategy that is successful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b4253710d19..abf0567b20f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1693,7 +1693,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (save_state(&stash))
 		oidclr(&stash);
 
-	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
+	for (i = 0; i < use_strategies_nr; i++) {
 		int ret, cnt;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
@@ -1718,12 +1718,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		if (ret < 2) {
 			if (!ret) {
-				if (option_commit) {
-					/* Automerge succeeded. */
-					automerge_was_ok = 1;
-					break;
-				}
+				/*
+				 * This strategy worked; no point in trying
+				 * another.
+				 */
 				merge_was_ok = 1;
+				best_strategy = use_strategies[i]->name;
+				break;
 			}
 			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
 			if (best_cnt <= 0 || cnt <= best_cnt) {
@@ -1737,7 +1738,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * If we have a resulting tree, that means the strategy module
 	 * auto resolved the merge cleanly.
 	 */
-	if (automerge_was_ok) {
+	if (merge_was_ok && option_commit) {
+		automerge_was_ok = 1;
 		ret = finish_automerge(head_commit, head_subsumed,
 				       common, remoteheads,
 				       &result_tree, wt_strategy);
-- 
gitgitgadget

