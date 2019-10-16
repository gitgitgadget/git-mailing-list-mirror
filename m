Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3712A1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfJPR0h (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33736 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbfJPR0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so15162361pfl.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8A9qudQ1oIBNUUDRSP5hm+so4OZ3iATI8W1lr5yAcuI=;
        b=and5sIimPsscgwjjG5KVy+gu4hqCXqG5GSR5gGDlpGxUENL4nJofBZ55i5WUoxNF35
         LOqKuzqS/B91wayDXdAeAJfs8rn61a5eAD03+ZU81dRt5eTAvSU+vMcbxZIsF9nduD/3
         yujGwvlUAAkpqtY+vrCaq8GCovh6JJFMe0IXDvVqR0xFNYtGZp199FLxHKVgc43XMGd9
         uqxFI5iPv85e3Cich0uaxOVaCAnleq/dp/2MP7gdOG67IUY0ZM18wfJzhiLFJkbFqwvK
         0/exvY27+qmjJjibygrGx7X4xXC3ebeCsKvRKBBg0pyDa5rnWXMRLh9/laYpbps1YNKw
         XW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A9qudQ1oIBNUUDRSP5hm+so4OZ3iATI8W1lr5yAcuI=;
        b=GxYgc45fEjEvZeGt/qudQ0eStcwOXXdzi5cR7QKBEhNXDIYMQWDW5XSuWKqboY89UM
         bN5MlMz6r+eeEdvDC15wqfBH/tlcBHCEOGsBv15zMGTe5QBfWpAQlvS7B0vsptsOLblG
         0s4U/X3CoiW7XsDmnSB+0B2eMKyxgtBXX98gDMlrC7yWBBTSyqT9/9/pBnV/KRzBXoXh
         /f/UsqDBtQRi0MgtbngSpnKi7hs4kHoRkUk8RJ96mpk5BiXu+my8lrNzcQsm3qdiwqV8
         FsZNE7bkfgS/ZYCJIbpVpubrJSpnPeBo+iZM1koBHwayw4KFe5MOji6iYbBepcaRWyC1
         H/Ng==
X-Gm-Message-State: APjAAAX1LzDjbc6BfujODqCd8HXYmTnnHEwqBeaFro6c8noHjzB4UMKh
        N5N3YKZT26Wi/VjvwzlzPxAFj18H
X-Google-Smtp-Source: APXvYqx0frcEIVkpn/pQlYBQ7EBU68bSHyP1q/PMOKZM3dxhIIrMSKZ3MiQZTMyrCkkSIGqcqKkI+w==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr6522721pjb.2.1571246794498;
        Wed, 16 Oct 2019 10:26:34 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b9sm23392934pfo.105.2019.10.16.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:34 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 6/7] autostash.c: undefine
 USE_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <73607c2e00a87b05da0e374734eb5c4d7d377d84.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since autostash.c was recently introduced, we should avoid
USE_THE_INDEX_COMPATIBILITY_MACROS since we are trying to move away from
this in the rest of the codebase. Rewrite the autostash code to not need
it and remove its definition.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 autostash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/autostash.c b/autostash.c
index 722cf78b12..0a1f00d2e5 100644
--- a/autostash.c
+++ b/autostash.c
@@ -1,5 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
-
 #include "git-compat-util.h"
 #include "autostash.h"
 #include "cache-tree.h"
@@ -46,7 +44,7 @@ int reset_head(struct object_id *oid, const char *action,
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
-	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && repo_hold_locked_index(the_repository, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -157,8 +155,8 @@ void perform_autostash(const char *path)
 	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
-	fd = hold_locked_index(&lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		repo_update_index_if_able(the_repository, &lock_file);
 	rollback_lock_file(&lock_file);
-- 
2.23.0.897.g0a19638b1e

