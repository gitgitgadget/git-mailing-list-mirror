Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E3C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiHGC53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHGC5T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:57:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A0E0F0
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:57:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so7293815wru.8
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=maZOsFc1adNGFOL7zMXtYbI5Uef7oOKBFPZA/0sIaBo=;
        b=dB3BDupvk94Xa0/9P2iVnIIJuti/K16XvrbztGm4Bz1faFGnCcFgp2mb7KzwX5RdTj
         HM/NmrgUmCGySWhkTxwiMAvEYE4tB7q0P+p1orzei+/4jyL5iMyyuZpXmt5YucrPoUtz
         PdyC0Go9TwVr37mLZ/i/aUJrgb2Tp1CT7/eOZQYVuobBPBWBwmOskQGfRAg0z09FJ1nw
         A0M3wPDF158qYa6udCh8kQwmP1CwnqLV0iDDR5yoauosg90ZQNqcGBlldWSa5gFisPNw
         mCwVoWLuiHXUOL5oSfqoAOSStnxCeuDYo88tYBth5Da6qWqaEMCRz5JTSeG6G/8QW25L
         a9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=maZOsFc1adNGFOL7zMXtYbI5Uef7oOKBFPZA/0sIaBo=;
        b=53VM5YrKb8a5eORKp5Zm8oerxxmkZQJmRT0rw+OrcAXzTzOaxu6WupF25mtRsXJCc3
         SElDkunh0cY1wPYMMyRO3oEsP3u83YZitko0TW3Y2U4lmz3yQdeMTbWY6tQfYlO7rgpE
         oNW+SHmYqCLRtm/5eJWl9eTfgDkm39OqY+PIf0JwwAdfSQXvL+6XM0ADQfM7kx5s+WM/
         5BkC0CKoyahVO7o6cB420q6UPqla5/Pk/s2p33IDBw/6TmAh1wcVBUF+9UsdE0fawPyZ
         s7O219Scb+94iASm+1r1k09unV4duo8RNhMPgYZGu3uSFDgthSbJ0U5mSn2n07YNYkgg
         xA5Q==
X-Gm-Message-State: ACgBeo29pvSLtuz/m8JW4VBGAnLhuDHN/EKUYCuQr4fiqBqI8Zv9gPMh
        t6zSYKxfQFwzB6rwc+hVuDpwP0QG/DA=
X-Google-Smtp-Source: AA6agR47MrlUH0Gf3DIbhqaNUTLqfUhlIFB/AiIydh06qknQ538ukxuXBIC2td2T9tJyQ7YXyGIw4g==
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id g2-20020adfd1e2000000b0021dd40bd816mr7713116wrd.682.1659841036836;
        Sat, 06 Aug 2022 19:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a305c0ab06sm17100597wmq.31.2022.08.06.19.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:57:16 -0700 (PDT)
Message-Id: <d0bdec63286e320a12cca3f0bb8a780ae451caf2.1659841030.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 02:57:08 +0000
Subject: [PATCH v2 3/4] cache.h: create 'index_name_pos_sparse()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add 'index_name_pos_sparse()', which behaves the same as 'index_name_pos()',
except that it does not expand a sparse index to search for an entry inside
a sparse directory.

'index_entry_exists()' was originally implemented in 20ec2d034c (reset: make
sparse-aware (except --mixed), 2021-11-29) as an alternative to
'index_name_pos()' to allow callers to search for an index entry without
expanding a sparse index. However, that particular use case only required
knowing whether the requested entry existed, so 'index_entry_exists()' does
not return the index positioning information provided by 'index_name_pos()'.

This patch implements 'index_name_pos_sparse()' to accommodate callers that
need the positioning information of 'index_name_pos()', but do not want to
expand the index.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 cache.h      | 9 +++++++++
 read-cache.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/cache.h b/cache.h
index 4aa1bd079d5..4fa3be26393 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,15 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
  */
 int index_name_pos(struct index_state *, const char *name, int namelen);
 
+/*
+ * Like index_name_pos, returns the position of an entry of the given name in
+ * the index if one exists, otherwise returns a negative value where the negated
+ * value minus 1 is the position where the index entry would be inserted. Unlike
+ * index_name_pos, however, a sparse index is not expanded to find an entry
+ * inside a sparse directory.
+ */
+int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
+
 /*
  * Determines whether an entry with the given name exists within the
  * given index. The return value is 1 if an exact match is found, otherwise
diff --git a/read-cache.c b/read-cache.c
index 4de207752dc..b09128b1884 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -620,6 +620,11 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
 	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
 }
 
+int index_name_pos_sparse(struct index_state *istate, const char *name, int namelen)
+{
+	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE);
+}
+
 int index_entry_exists(struct index_state *istate, const char *name, int namelen)
 {
 	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
-- 
gitgitgadget

