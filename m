Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB8C25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiHHTIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiHHTIA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:08:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9E193DB
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:07:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so11989572wrp.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=maZOsFc1adNGFOL7zMXtYbI5Uef7oOKBFPZA/0sIaBo=;
        b=FpwOVfeSIpCJPloVSezJMz2tn3vZ2oFy8JMoAWbl+d2Qgwbca8ZBGr2JunM0Wfr0hN
         z75RsuDCpm875RMnJCspd0CyDhD6YEzvzOdTgMWQ5udU2klE9DUWcNmBwnrilhgH2aXA
         7SP3sPPHYPoa/QO8VBq91ycwwyBPA0KOT4GCSp5VTI2tAZ7NsInVjqM0BkSdUVIgxdBg
         wQNHtf/EPunF7xMYlYFY6XXXBh4zDB88cKg0Oea6fADEoeQnTB6zVngiC4dq6hXygMl6
         +9+pKbHtBAgmzUyHsz4zUw1x7hnfYERpN+HccMh4H7eV+zy4fRJTOiOij5ajG9qhAYfH
         S1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=maZOsFc1adNGFOL7zMXtYbI5Uef7oOKBFPZA/0sIaBo=;
        b=ieRdbWClWEWfm6M/PikWbFNmCW4EOu1bIp521N2kvj5p+4SJSWzGhfyqA+YX6dPpcn
         49X6KgnUut4oSau5kJKSgYNtTxNadMkrlo+W/Y6FkDTfM+j9WcMuEiaRyn4FVzI9TWRa
         +GBp2DzhuYg+TYP7cU1a7gjwueE7fydvaIVeDoX6J/BWvV8JvEeOohxNgImvaMd5WUZg
         864wOX4JTvuYEsfQu7HCSSDOC2CZYGpi7u+rvw/t6KAXLPqt/4ZFDkRXG/adXgn+NPvK
         qaLjdmiGXBFNbUUJXWDbEn4oKcPVyuve5d0m50GYxjHM+2A40gcWlTYm097WnryB01zY
         mkXA==
X-Gm-Message-State: ACgBeo3PQVlRHfPnLqyy5PQMSnBmMKLW2kVpYcSOjeasSefFHO1dSkez
        QPjD082Zj7cWZEIcFKYYEzPFwqzN4lM=
X-Google-Smtp-Source: AA6agR65kgEZ1D0FrOSDV0ihi6dSPnUu7PH8tYbBc4LaEV/8MZht5H8Z05FC7AWDws6GW9771TpOxg==
X-Received: by 2002:adf:db8e:0:b0:21e:3fff:6bae with SMTP id u14-20020adfdb8e000000b0021e3fff6baemr11652843wri.184.1659985677443;
        Mon, 08 Aug 2022 12:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d6088000000b002185631adf0sm11879261wrt.23.2022.08.08.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:07:56 -0700 (PDT)
Message-Id: <d0bdec63286e320a12cca3f0bb8a780ae451caf2.1659985672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
        <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 19:07:51 +0000
Subject: [PATCH v3 3/4] cache.h: create 'index_name_pos_sparse()'
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

