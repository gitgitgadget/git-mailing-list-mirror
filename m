Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E3420756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdAQXfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:35:10 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34048 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdAQXfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:35:09 -0500
Received: by mail-pf0-f180.google.com with SMTP id e4so27050597pfg.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NDVXX7FNLerYN6wYTg1Thh9T2Td0SAVC4fXLM/fB5xI=;
        b=at23G9EjkW3I+sTmC2HIR3UsvPINmQa7ug1ZwlyuvsAEHAupzNhv1MdH7x3rX5H024
         YyK+st0zNfTw1y2ESgXifdR+qZC/ExTCBOpMATEfos6fmAA8LfZAk4pkwCUmsOifwn+P
         O8UJl/2EEnzPQ3eWqpn9SGK3RARgmtxS/1rYJbJWFcGN4DAmauAKsGRzfPasPvrjytpo
         7Mr1NTm9ozt3Cd9AV+ZSJXji4wN8WIQrsDZmWxfh6+glie34wHx2AfvtCtSXCGts7tcC
         nxgZKK5IDRboickCH2FP2/ZbOwc5Se2VTS0ZlSRy/hyiOpsFFIufqoqy3onlWhGz8byP
         TfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NDVXX7FNLerYN6wYTg1Thh9T2Td0SAVC4fXLM/fB5xI=;
        b=Uv9Q8Q+vtIpGLjROkbGKgJS6IprVLIZ4gLvcZyQfhHhS7XkoA/3VFGs21/wPZq5Pvb
         hZRNkTP0wcmbGc087hAuaJjyBw/jC6wHP2J7lWF2rCn8vhQ2+VUD2FfuxnoOelSffoZ/
         W9d1p7dGAly0a9TXiGxCcO067MgcVGfHMfeN8vdLyxzZ8ANGuH18RqsqxTgesQMy/+FY
         feIqEOSM3WOhYCbGBRdor4jnbPEZXEaze1wAyDkqyd4iP2HklNICm3J3DUy6e476jg3d
         k1nqg1GStVBQESLTN5jzc3Dy8W5VJHBeJWwHxexoVy0NEizVoLrRBo9dzw7wetePUEpA
         nFBw==
X-Gm-Message-State: AIkVDXI83x9W44gtkl4ephfRdkRx/gUOWHyO14GSMYH7RYBsj1mo38xp7/zmeTp4YDH82jF4
X-Received: by 10.98.153.155 with SMTP id t27mr303125pfk.48.1484696108482;
        Tue, 17 Jan 2017 15:35:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id 66sm16983120pgg.47.2017.01.17.15.35.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 15:35:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] remove_index_entry_at: move documentation to cache.h
Date:   Tue, 17 Jan 2017 15:35:01 -0800
Message-Id: <20170117233503.27137-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170117233503.27137-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h      | 3 +++
 read-cache.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 270a0d0ea7..26632065a5 100644
--- a/cache.h
+++ b/cache.h
@@ -599,7 +599,10 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
+
+/* Remove entry, return 1 if there are more entries after pos. */
 extern int remove_index_entry_at(struct index_state *, int pos);
+
 extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
diff --git a/read-cache.c b/read-cache.c
index 2eca639cce..63a414cdb5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -503,7 +503,6 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	return index_name_stage_pos(istate, name, namelen, 0);
 }
 
-/* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
-- 
2.11.0.299.g762782ba8a

