Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CDC31F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHaU6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:22 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:45699 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeHaU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:21 -0400
Received: by mail-pg1-f181.google.com with SMTP id m4-v6so5688458pgv.12
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=joH7vqG7kmqPl573SZm3GzbSox+MrkXauGYn6k6MkU4=;
        b=C7YT/yfgV70R70JTtVJn1t9tnOjaneOBrUgybYm9wTGFUI5p8/dkIjRzhLmAsDEc1S
         puMiWGUXsHCDqmyh6yMlUvgWqN2RHq6lyhLkKath2BS2Mg+f9e5xCxqlTjDoMh0e+w8n
         NhA89CQp+ZK9aIxxXYT/oX5A0Gt2El+ehPIgLED3bgYLS4QDwL4DfOGI3wbeXF290aCl
         hig26kzql5fz2xBCQL7Gdf2lw8r4qFjZJw8JCDjlKYfe31qQQgg+5k/hBHBhm9e02qiO
         1G1VJvPaaZIduo5ZeputZUlDUC2Y6hr/0W7uaTpp6HOaq4wcm84NgJCo4ORKFx9N07yj
         CDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=joH7vqG7kmqPl573SZm3GzbSox+MrkXauGYn6k6MkU4=;
        b=CZt5lSHBO9NYAjQGHLAizsmlr3ch8SKnCY20Xn11A3rTG0SGBjpLdka7Dh8LBWhRvI
         EGl3O6Gdd4gPxYPRTeoshdUSzG+JtLKDwQWW8iH4pLUxCroea+Ljh3q4Y5iJcY4BDOZX
         jOpVKbi+2BRhTwhD4A6z5vD8DvdO6S3JsYMIu1x91HDW6Unta+LukmSdPWSBy69xdrxF
         1cW6emhaYZ6EXPPjCSCQJqnTytaxJfC0ZjrH0H96Iu970jYBtejWhIdW3FbW0iPbQqtk
         GbBGddoA6ac4DH6Zhg17FxVxoEd2fxZYFy4d2dKIsQd4o5sH1d3WtbDQ080HSv4Jg2P0
         FOfg==
X-Gm-Message-State: APzg51CUyREcvnSE0d67132Jg/531qTS6JPiEB0tmpdKWtfkQApeHtYT
        Pp1VxFoyqh9svOkO5nVGEW0+AnBA
X-Google-Smtp-Source: ANB0VdbJEfSsDemfcfzI3XzQYh/+rniBK7o20ZlBw/pz40akAcLIJPTi7McbSdBBhBiGprNeCdPGPw==
X-Received: by 2002:a63:26c6:: with SMTP id m189-v6mr9769445pgm.70.1535734198868;
        Fri, 31 Aug 2018 09:49:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p66-v6sm21337594pfd.65.2018.08.31.09.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:49:58 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:49:58 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:46 GMT
Message-Id: <2db85146df849c2545e32ad32501c4fe5002bfa0.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/8] trace2: demonstrate trace2 regions in wt-status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_region_enter() and trace2_region_leave() calls around the
various phases of a status scan.  This gives elapsed time for each
phase in the GIT_TR2_PERFORMANCE trace target.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5ffab61015..9e37a73c73 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -726,13 +726,23 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	trace2_region_enter("status_worktrees");
 	wt_status_collect_changes_worktree(s);
+	trace2_region_leave("status_worktrees");
 
-	if (s->is_initial)
+	if (s->is_initial) {
+		trace2_region_enter("status_initial");
 		wt_status_collect_changes_initial(s);
-	else
+		trace2_region_leave("status_initial");
+	} else {
+		trace2_region_enter("status_index");
 		wt_status_collect_changes_index(s);
+		trace2_region_leave("status_index");
+	}
+
+	trace2_region_enter("status_untracked");
 	wt_status_collect_untracked(s);
+	trace2_region_leave("status_untracked");
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
-- 
gitgitgadget

