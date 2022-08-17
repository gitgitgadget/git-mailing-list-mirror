Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08981C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiHQA2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiHQA2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:28:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E02F3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bs25so14472649wrb.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zEsAWHGcuI0aG8cEtf7eQJ+8ovfPnFkB0Pkd2+8KSU8=;
        b=EazFa6CTIMactDbsvCQGYILMXVWs83wfursHSf0Eg4hPajDTnOhMnymbWTXMSKtWi1
         K84Ypu6YcO00NjZOyx5v9i9WO37/3JYzZv8DDJwCgAG/NWk4U/+GPvVHQkDB1HUBMs0o
         KlzYmJogor2qsSBpxMx70PcLBZzn/QvLpcx3B8pGSAhxdnYAo7ptH5XriH6CeAs4obLZ
         vtq5kb0BXT6x/P+Bj2AkbnLsv+0Z2TibnMQ/TEvu9a9etONWMDEa9Lfalg5w6ngiBot5
         QbtxlDd7UVHbTe6PAHomjTJOoidx0V2sC05Aj9cO3nge9QfJYVbSMlcPYdKWqzheI/ZG
         pkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zEsAWHGcuI0aG8cEtf7eQJ+8ovfPnFkB0Pkd2+8KSU8=;
        b=RlKE59Degcb6z2Dj9bIp63yEHgKt4vZLTEVJtiWDiyeox9OJrrF+/a5hrYy56EKn9K
         DTzuh32epQflC2fFl2vgMj0qrj4DJTbqGxH96pQb91e4OpNP3wTDfBHZP/qYc6QGS4Lr
         wgy2JlIshOtOcvn0+vP0ZcTN9X/xGqQ4Ja+98KPfAW7tHDetUck0fSxtFft5kfAaPTlC
         YuLJwNoelF9r44c8z7/2sNHYmXA03VxpNNLMS2fM6actVAhecx9a1V3Xui93ML47INPw
         GmLDXBcuijbm3hr66YgA6Ah9FJTwpQb4jgUugRLxsJedXe22cD1CPTvwxI3N4gJB9Z6h
         DyAA==
X-Gm-Message-State: ACgBeo3UrpWxxDDF6A6rRJZ9m/ywQv9IK9oEI8u4e4MQykX6pwMK+khY
        Q0jAKWlh5lKmxhbbGxKXsV74yDTM+yY=
X-Google-Smtp-Source: AA6agR6Oz3Y7NKC66RTkeoXDF4Mej8fH8aoDkY57vnDvD6iaVMEIRpFXK0F0+EjmoRKwQF+X6pPk+A==
X-Received: by 2002:adf:e9c8:0:b0:224:f896:94bc with SMTP id l8-20020adfe9c8000000b00224f89694bcmr8388255wrn.635.1660696084555;
        Tue, 16 Aug 2022 17:28:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q29-20020adfab1d000000b002206ba7430bsm10207181wrc.15.2022.08.16.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:28:04 -0700 (PDT)
Message-Id: <010cf4ff3442902031360ed87a6f86cc9486581a.1660696081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 00:28:01 +0000
Subject: [PATCH 3/3] merge-ort: provide helpful submodule update message when
 possible
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
