Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A78C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiGLNH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGLNHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CECB4BE8
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so11093174wrq.7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/S97OiEFXarglFDMVfj7C2C4GX6gC5Ld/BwXnH8Ga8I=;
        b=PgJxcjafEVQA2eGRp99cacykjn5GvrXg8LJK6elUQDjp6Ep72mfPNvC3kJHIy/BN5G
         FNWfi2zVZgRSPHefNbUVJROLZ+6bGyCedc/OGGWb3s8lAILY3olyrwdKq5RQ26FZhpdu
         ZIoggy+aZ5g3C56TLVpQcs97Y5gwxdfBpfMa+eK3lL2x4JuxalkVuXo1vR7IHlrkbrPk
         MhDCqTW93xeSReb3VcxgQhyMP4Aoe3/w5MiuJgiwvOhuz81r7gv39eN8ErO4LTVuhB2Q
         JG/D1G9+R8Fjvo/8aVEAYIfFnDy3cIS4Gzk2CXz6ziTRZL0N8KXCoiT6aEdo5p+Uej2y
         +A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/S97OiEFXarglFDMVfj7C2C4GX6gC5Ld/BwXnH8Ga8I=;
        b=oQQdYZerjZQMXPD52hsR+dDyY7dq5Xp47r4KolnHz9p4K6yNd1Bsu8AUtlDyjuHphU
         Xly+uioMxWJn008+5uUDQU1iOJeuVL7PFXxLXwYhL5Tw08E+gBvpzdsU+2WNw4mRPAfD
         2zbnuViiGjFGk0fOt13rLP7s2w18GF1IiDtR7lumg4B4fbSSkzBnI1fB27ebxfcgrg8r
         V/nN3gHeVaTtxY8u+3R0uM7BFssj5yMf7ArtR7RyREpdLRW5iNDXSXEHnKsdji0xY6cs
         OA5QINPDliA3eGAf0XlnKY/SK0QgPfZ4xAchoXqWvirQ96ieky3uqseZba8oLHS5WsqG
         ID9w==
X-Gm-Message-State: AJIora8ZCR5O9zNl+PVS+WOZ44BI7GW799io4qO1ZXf/W0cSLxN5Rv8G
        VRGGSL4UzmidqtITTLgEc5b3NgVDAR4=
X-Google-Smtp-Source: AGRyM1uqSpJnOAirsNO11xwQ5dXU1Nwpl8dvr858UNjpNEV7IGUsn9kKuUK+DhfolaFYTlgaaftJHg==
X-Received: by 2002:a5d:428d:0:b0:21d:7ee2:8f9e with SMTP id k13-20020a5d428d000000b0021d7ee28f9emr21198672wrq.145.1657631245342;
        Tue, 12 Jul 2022 06:07:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c41c300b0039c362311d2sm14928145wmh.9.2022.07.12.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:24 -0700 (PDT)
Message-Id: <d53b4ff2cee0ca518ab4958a29e22602511f3691.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:07:04 +0000
Subject: [PATCH v4 11/12] sequencer: ignore HEAD ref under --update-refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When using the 'git rebase -i --update-refs' option, the todo list is
populated with 'update-ref' commands for all tip refs in the history
that is being rebased. Refs that are checked out by some worktree are
instead added as a comment to warn the user that they will not be
updated.

Until now, this included the HEAD ref, which is being updated by the
rebase process itself, regardless of the --update-refs option. Remove
the comment in this case by ignoring any decorations that match the HEAD
ref.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 2808c027d68..82ef062d497 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5855,12 +5855,25 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
+	const char *head_ref = resolve_ref_unsafe("HEAD",
+						  RESOLVE_REF_READING,
+						  NULL,
+						  NULL);
 
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
 		size_t base_offset = ctx->buf->len;
 
+		/*
+		 * If the branch is the current HEAD, then it will be
+		 * updated by the default rebase behavior.
+		 */
+		if (head_ref && !strcmp(head_ref, decoration->name)) {
+			decoration = decoration->next;
+			continue;
+		}
+
 		ALLOC_GROW(ctx->items,
 			ctx->items_nr + 1,
 			ctx->items_alloc);
-- 
gitgitgadget

