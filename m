Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF4D287
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enPqPQhJ"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDBB3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so75841721fa.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698728965; x=1699333765; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQmnabptSyCtnxCk9BQUWCngqvfiF0UnPMkjwgq/w4=;
        b=enPqPQhJI3HhqzRuYnVGHrXWQexOJf1FAmZhtLWravjXvKm18NQfgo/ClK1sA1qkZU
         L4pMSvyr7XdHJdr34erkt7Z8inqgvVRuaJnuY772ooXBCjESCKGY0AGHwesZIi3BISea
         K4zWnhxczjEvqbpNxspi0GcU2H7cdx8Ix4wZroaC0qB1Q9+npseMStQUR8OxwWv8YPMX
         phOwpY9kZt68NlxJnNCQjUML4ycygLRMnzmqPg8jgVQKingcepkTVRsLYIlzkUdTz1K8
         FzdAGIzr300nhQavDX2Z+UN/6Wbh9qcG6fH2pMLtbbmjbB0N1emXnLmjW1VqnT5jsdzU
         BEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728965; x=1699333765;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LQmnabptSyCtnxCk9BQUWCngqvfiF0UnPMkjwgq/w4=;
        b=rSypXWxCDFRk246X/E+KkCcGVjyQuiD/PXMkUg0PSFltjgBNs5GVvb6G9lGCPvpytp
         DNl/WpswHYFe00eqqLb3nxytS93JNn8x09TQKFlCdhIYiQc3X6JVy7um1AtC8TDzTL3m
         rrxFdEbCDBcD4PXrl3U+tLs1yJy6458bzDTMmqmVeN5lBrwAzfMc6b1tLOpEhUqKRizV
         AbZ/776Ates5iwUdg33ZwEn1vp8W1M+WXIlSKFn3BBLCUfO3+iSmfaw0mmqgKUJ524JE
         oiV6h/LQMfNhrG5cK5Z8RBH9Uwndhofa4QqrKXkd3wpidGpppxwJcbFnLiUB/qRglXpY
         YTag==
X-Gm-Message-State: AOJu0Yy4DUAxt2zCtuH8sHWGuELiDM8qDoIsh/FjDZL85+6SmUhitbi4
	0+ZnUrTLpyuhNzsQHJqhqPpVm8HHY0k=
X-Google-Smtp-Source: AGHT+IFWbSJaZbxw/AwMvRHxvKRqNxTQwQ3EY423A5NZfQXIZt0f8nVQ3IqfVEGolTC92uogXF5i1g==
X-Received: by 2002:a05:651c:c8f:b0:2c2:9872:dfc1 with SMTP id bz15-20020a05651c0c8f00b002c29872dfc1mr10443048ljb.42.1698728964619;
        Mon, 30 Oct 2023 22:09:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b0040775fd5bf9sm671154wmd.0.2023.10.30.22.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:09:22 -0700 (PDT)
Message-ID: <c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
From: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Oct 2023 05:09:12 +0000
Subject: [PATCH v2 2/2] sequencer: fix remaining hardcoded comment char
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>

From: Tony Tung <tonytung@merly.org>

Signed-off-by: Tony Tung <tonytung@merly.org>
---
 sequencer.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8c6666d5e43..bbadc3fb710 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1893,8 +1893,14 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 	size_t orig_msg_len;
 	int i = 1;
 
-	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
-	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
+	strbuf_commented_addf(&buf1,
+			      comment_line_char,
+			      "%s\n",
+			      _(first_commit_msg_str));
+	strbuf_commented_addf(&buf2,
+			      comment_line_char,
+			      "%s\n",
+			      _(skip_first_commit_msg_str));
 	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
 	while (s) {
 		const char *next;
@@ -2269,8 +2275,9 @@ static int do_pick_commit(struct repository *r,
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
-			strbuf_addstr(&msgbuf,
-				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+			strbuf_commented_addf(&msgbuf,
+					      "%s",
+					      "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
 			   /*
 			    * We don't touch pre-existing repeated reverts, because
@@ -6082,7 +6089,8 @@ static int add_decorations_to_list(const struct commit *commit,
 		/* If the branch is checked out, then leave a comment instead. */
 		if ((path = branch_checked_out(decoration->name))) {
 			item->command = TODO_COMMENT;
-			strbuf_commented_addf(ctx->buf, comment_line_char,
+			strbuf_commented_addf(ctx->buf,
+					      comment_line_char,
 					      "Ref %s checked out at '%s'\n",
 					      decoration->name, path);
 		} else {
-- 
gitgitgadget
