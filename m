Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7FC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiHQGeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiHQGdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:33:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319B25B052
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bs25so15085047wrb.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zEsAWHGcuI0aG8cEtf7eQJ+8ovfPnFkB0Pkd2+8KSU8=;
        b=U7FNYDRsbdS1euJh7rXBnkoJzRfVqRHGX0nX7PD9zaRqC6zoiY1PKJbOYcOeGdCwoH
         iyyL/O/jGkrZB1C4Qv9vUbB/q4dWTsNBNnQKAer06EHQwgb4V82+1/PLsfxUWpQcgbwD
         Y7LpE9DZ/uVlqMlpLV0EFDdMv4/hXcL8LrTE8TtQHNLbebaZmPciSjkjFaomFXzlxWN5
         276TLKRsURQzv4WrJ3CV5Y9NKW91QgqkxOMpOjRFqn6aA598lNCdHGXUg0iO56b8oM4B
         pc5ApovL/6JSOWDYOVo0bGPtY+amdyNeDdc5kv1wnxJ6AD2LyrFVJCrWGk/b+z3YsYNU
         JO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zEsAWHGcuI0aG8cEtf7eQJ+8ovfPnFkB0Pkd2+8KSU8=;
        b=dKzw8jf4D3+3O9qqS7niuKeH49USkaTr67OOa83MQIzn4TJvH21N8bgwuDaInF2YwG
         vXpiPNHxpy0jB1QWzn+YfFkW1O4rW142XNigA/4qYcGMzjITteizuuzZWg8V5t8NnsEN
         kg3hJblbNT3Vez4YxRehI3UFFZJUYqocQmBEwyFNWfAZHiSonxW1EXUPSkOquABBxCbB
         gWfdjhoxGgyR76mkCCrHfmAbRTe8XRN6WlkAg8jd0vfZ0tqmRzlGlTclrvTXA5tAxoOa
         be8tKSALWpLdKq6EbIDh9uM+WhtjDm2Ctkbd2iV3qlfBlZiRmWIfHSIc49/ImLcbHuWK
         o0cQ==
X-Gm-Message-State: ACgBeo2GOzhWz0Vj1QNRe+fcGTfok+HmASLJmz8XmY8UNffIynC73MVG
        Nca0PqXwk75A3vZdjyCmZiJPyVnvA2c=
X-Google-Smtp-Source: AA6agR5WlC8Ccdr8y5ZHFl80xAheTpzq+0MXHgq/4zFwzKyJGeRtQFtkGvAB3U1XVaoZUvVoV1Vm1A==
X-Received: by 2002:a05:6000:144e:b0:222:c602:1e57 with SMTP id v14-20020a056000144e00b00222c6021e57mr13167581wrx.60.1660718032336;
        Tue, 16 Aug 2022 23:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2-20020adffbc2000000b002206203ed3dsm11848135wrs.29.2022.08.16.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:33:51 -0700 (PDT)
Message-Id: <80207d183343e6f1397abdb70fee68bfb26f1756.1660718028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
        <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 06:33:48 +0000
Subject: [PATCH v2 3/3] merge-ort: provide helpful submodule update message
 when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04), a more detailed message was provided when submodules
conflict, in order to help users know how to resolve those conflicts.
There were a couple situations for which a different message would be
more appropriate, but that commit left handling those for future work.
Unfortunately, that commit would check if any submodules were of the
type that it didn't know how to explain, and, if so, would avoid
providing the more detailed explanation even for the submodules it did
know how to explain.

Change this to have the code print the helpful messages for the subset
of submodules it knows how to explain.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0a935a8135f..404f05e32d6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4490,21 +4490,17 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
 	if (!csub->nr)
 		return;
 
-	/*
-	 * NEEDSWORK: The steps to resolve these errors deserve a more
-	 * detailed explanation than what is currently printed below.
-	 */
+	strbuf_add_separated_string_list(&subs, " ", csub);
 	for_each_string_list_item(item, csub) {
 		struct conflicted_submodule_item *util = item->util;
 
+		/*
+		 * NEEDSWORK: The steps to resolve these errors deserve a more
+		 * detailed explanation than what is currently printed below.
+		 */
 		if (util->flag == CONFLICT_SUBMODULE_NOT_INITIALIZED ||
-			util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
-			return;
-	}
-
-	strbuf_add_separated_string_list(&subs, " ", csub);
-	for_each_string_list_item(item, csub) {
-		struct conflicted_submodule_item *util = item->util;
+		    util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
+			continue;
 
 		/*
 		 * TRANSLATORS: This is a line of advice to resolve a merge
-- 
gitgitgadget
