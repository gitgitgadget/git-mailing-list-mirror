Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF460C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiFHCQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445757AbiFHCNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:13:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DFE1EEBB2
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so12345805wmh.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OL+BpklyPzYC8RRzM08ZZr7cjA/4yf1+N5iD1T17F74=;
        b=IV00le046o7iuhYIlrAL5W16wA5muBD1X1UTJjGX7TFvqnsa+Xcs7GOX/23sd+tPR2
         Ig7TC2xwuHIywMc0Bwb15YaJ0T/ZWcihrTB4zi1je/qChZ2slNSPHBvG23UMcw1ISIdp
         pOs6daCNjUykpwhQ4ANGnMoezL/uKAfruqFIiWaKGht1Hev8KBmt/lsoa9wKCPEimr6K
         KeSJZJm4Gb+zbpyaTzsStzuDHBV8PtJJuVADp4e9Xd+l1FnyDc8JGLMdqXygd8RyTn1r
         3sunlncLukOGKaOyTwM4S+9bwXcv9b2sTKCt2hZayar3Tz5q1ej1QznlXSxi34NEQiJj
         NfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OL+BpklyPzYC8RRzM08ZZr7cjA/4yf1+N5iD1T17F74=;
        b=ZGJQF/Rg3rLtK8as5jgF7+AAcaLRD4lIGab/1L0ne6f6lGK39lKYf7/by0YfIVIRKq
         FUqaOBgLmz5tRqC1H514jNbRDDeafLstSrFcOiDOZWhppVbvwqX6OhkvhEtCaadq8LWt
         9yEFdjZyASu9L6JlrW0QKFSq1R9gcTGO4MzQA/SUvyWf1+Uq9r0BJCbCxWqY1lTMKrMv
         ScP/SM82XtYuMClsqZCC1oDnkLkiqKRafacJCHBmpQfPX01vZ89OWdJPIqSOUOQgUHUP
         01ky1ySGaUQrFyAbPxv3J4O+ffxsAgtr/dixt3bAOcDAEKRyrk3sydLOy7y/amP3h861
         NDWw==
X-Gm-Message-State: AOAM532DqKYxsNs4SelQsgY7qaGqfjYlt/nZoMOI1RZ2mZrgl0M7D6CL
        7dnHltfReYQSzp65/mdLzRkagRFb1BUJ0TK2
X-Google-Smtp-Source: ABdhPJxEC383Z+dU2OutySDsJ8WP5WVD01/FyYZv7DScfwl8o22zpcMW+P+wL2pokSdCsB6z6z9rrA==
X-Received: by 2002:a05:600c:6020:b0:39c:5cec:da86 with SMTP id az32-20020a05600c602000b0039c5cecda86mr3596449wmb.75.1654634575942;
        Tue, 07 Jun 2022 13:42:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b003942a244f39sm660272wms.18.2022.06.07.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:55 -0700 (PDT)
Message-Id: <842b2186d250aca367e9680105d4d15f8cbb098e.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:46 +0000
Subject: [PATCH v2 4/7] sequencer: add update-refs command
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

Add the boilerplat for an "update-refs" command in the sequencer. This
connects to the current no-op do_update_refs() which will be filled in
after more connections are created.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 13 ++++++++++++-
 sequencer.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8e26c9a6261..68f7c76e896 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1696,6 +1696,7 @@ static struct {
 	[TODO_LABEL] = { 'l', "label" },
 	[TODO_RESET] = { 't', "reset" },
 	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_UPDATE_REFS] = { 'u', "update-refs" },
 	[TODO_NOOP] = { 0,   "noop" },
 	[TODO_DROP] = { 'd', "drop" },
 	[TODO_COMMENT] = { 0,   NULL },
@@ -2442,7 +2443,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	padding = strspn(bol, " \t");
 	bol += padding;
 
-	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
+	if (item->command == TODO_NOOP ||
+	    item->command == TODO_BREAK ||
+	    item->command == TODO_UPDATE_REFS) {
 		if (bol != eol)
 			return error(_("%s does not accept arguments: '%s'"),
 				     command_to_string(item->command), bol);
@@ -4056,6 +4059,11 @@ leave_merge:
 	return ret;
 }
 
+static int do_update_refs(struct repository *r)
+{
+	return 0;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -4431,6 +4439,9 @@ static int pick_commits(struct repository *r,
 				return error_with_patch(r, item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
+		} else if (item->command == TODO_UPDATE_REFS) {
+			if ((res = do_update_refs(r)))
+				reschedule = 1;
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
diff --git a/sequencer.h b/sequencer.h
index da64473636b..c2b4e148d8f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -95,6 +95,7 @@ enum todo_command {
 	TODO_LABEL,
 	TODO_RESET,
 	TODO_MERGE,
+	TODO_UPDATE_REFS,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
-- 
gitgitgadget

