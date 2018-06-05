Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01AFF1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFEPnz (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:55 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33657 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFEPnu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id y20-v6so4362509lfy.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQaYtMega9z16tixnazUw9IyVMqQX/sEb/1VT3Hhv8U=;
        b=jhUtH7x26CmgPK54IPuLXfLXj0NTgRjYzhsGWCwFUHMHj9OycBpVbT5KThZKkI8dPC
         d50NbajiJXNk8/W2aFgJdPv9avYwlxtVsKrKBQ+bZfs94OFlIDZ51Tb1mXUG320iJ0ss
         0nn8mdJwHH7KnSJpcU7GwlhXGR94gwECN/VpDqMKd91bEURPQDvMRiIsd1PCBnUgm2Ju
         HA75vm7LEnIOxmdCen61y9CJFjRyCyMCDhMeX5GicX6SvJpUJsHaGomY54r4U4i2a/8x
         Nk7t1687FiAqUbDU3VQIZoWDX0Nzfve8b9LIvecCH90n4HEWaaDJSQu2xIuk4CnkydDz
         9ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQaYtMega9z16tixnazUw9IyVMqQX/sEb/1VT3Hhv8U=;
        b=FeSHOLUzWrKwBXQQdch/eTXINEvL6raqROL/G0voSrSRISLsYJWj7hJX8qtIP0fyXK
         8jpwLVRqRYsMqKSQRuHw0UbUXRj6kI1BYZuFg6se8gqQOES2aipz/iIYOrfsTN2ZsLA2
         fSlgygZLH2I3rZB0fypHMJfxtISPyfLxpUTenDQDud6oKhfA0ahYNW4lJZS09UwZ9ILO
         ZAXCYz1d0Rx6OhpPLi4VywD56SXs5I/cOJbrrgdGVKEOZUNeWvwxe93Emr/V1VOD2qvQ
         2vuPntc+3RG+wuZB3RrM4aWMJc8mT8tlSFhZu4v79c/ug0r4OOrlJTe5AcR8vl8hoZj3
         aRRQ==
X-Gm-Message-State: APt69E0swqGHzK+mUwAPC5qvLYjn8bG2yegvw93RYQhzFzuqxEDUyuwb
        +5nMvqZ3Wf4DuBhyOpkbITsKIA==
X-Google-Smtp-Source: ADUXVKLfIdMKQAh4W+jtpigBdOQBXyoG1bfKLkneeyl74tTyS8ZJVu0yqjKZoWgpZt36L4yHfVu2oA==
X-Received: by 2002:a19:ce87:: with SMTP id e129-v6mr2074574lfg.57.1528213428893;
        Tue, 05 Jun 2018 08:43:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/6] Forbid "the_index" in dir.c and unpack-trees.c
Date:   Tue,  5 Jun 2018 17:43:34 +0200
Message-Id: <20180605154334.22613-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use of global variables like the_index makes it very hard to follow
the code flow, especially when it's buried deep in some minor helper
function.

We are gradually avoiding global variables, this hopefully will make
it one step closer. The end game is, the set of "library" source files
will have just one macro set: "LIB_CODE" (or something). This macro
will prevent access to most (if not all) global variables in those
files. We can't do that now, so we just prevent one thing at a time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Should I keep my trick of defining the_index to
 the_index_should_not_be_used_here? It may help somewhat when people
 accidentally use the_index.

 cache.h        | 2 ++
 dir.c          | 2 ++
 unpack-trees.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/cache.h b/cache.h
index 89a107a7f7..ecc96ccb0e 100644
--- a/cache.h
+++ b/cache.h
@@ -330,7 +330,9 @@ struct index_state {
 	struct ewah_bitmap *fsmonitor_dirty;
 };
 
+#ifndef NO_GLOBAL_INDEX
 extern struct index_state the_index;
+#endif
 
 /* Name hashing */
 extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
diff --git a/dir.c b/dir.c
index ccf8b4975e..74d848db5a 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,8 @@
  *		 Junio Hamano, 2005-2006
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
+/* Do not use the_index. You should have access to it via function arg */
+#define NO_GLOBAL_INDEX
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ace82ca27..9aebe9762b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
+/* Do not use the_index here, you probably want o->src_index */
+#define NO_GLOBAL_INDEX
 #include "cache.h"
 #include "argv-array.h"
 #include "repository.h"
-- 
2.18.0.rc0.333.g22e6ee6cdf

