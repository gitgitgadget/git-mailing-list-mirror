Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C72AC7EE2E
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjB0P2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjB0P2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B79779
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k37so4530960wms.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G9UY5G/xhpuixYbrSG4zCsVzN5tLvEplL1kmmNUZe8=;
        b=YuJ2ulZubmFJStn0o7Fi208tDv4a74JablZ1OcOq9ihsWhVjrzAiNQiFHOFc8AwKDf
         LqH62Q+iYKBwj71dZtDWew/wxVpIEArQ0mLP8r1bVvj6tv70HkwxvtSKBzhUZ28AAPO2
         pn6xPs5uX0nS1xMbRuRJ97Pd+qKTaFSPFBR9lUQv9jmW2/ZkQ1I9coFSb1OL7163Bx1I
         ZPDd7zDgSW8gGnbUx3lXy+lsEqNxKk1ZNCcXZqIY1sTQY/CudJWXuYhMdrCKEoGcTb0+
         laBfh1FTbid4KUB1Re8S1zKBESDVX6XJGdRC8y6xTxA17H3trcJX64q+JDk7dZuozp/1
         A6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G9UY5G/xhpuixYbrSG4zCsVzN5tLvEplL1kmmNUZe8=;
        b=gowiKEzkOw8fH/dI9hLdx6LkCah/oqQX5epSESMhaMlT/5+HPeL4N0BGbj3nySiS+k
         zoBDGmt5TGOVLlPA8XF9dlm6czu/FS31+PXzBvviwXP+sNmHaXSmfhy2L5+PFMfmoBW+
         fx85PGQu57w50HVEbYM2GrtopfUgA0v2U95XlaxZ+eSy1Z2W1Wz4u5+aQdlnbpb67j7/
         d6p/r/734mHEu02dwsfslXfyGwXHaYbHVb+1lxw7bOgaD5R7p3fapD6YAQ+0y8ugrW1i
         OJgsBagxAzmF6RNNOcNNAU/b2ZMCVNiIk35BaFhmlCuD7HXqoA8TAUrvRUbRZHQEWZ6p
         g25A==
X-Gm-Message-State: AO0yUKU1XLldpZE2tWr7eBRP9ux0ruBPNWVsfg7KpdGFliyGz9GbCT4C
        rNHw82QeMegQQcbpizUJlWzSObu02iQ=
X-Google-Smtp-Source: AK7set97CGcmcUbu9kEwY9rTKPNzofoZLDhhr92sGr42CEixU03PrsnMaRGRzG3bIF6HpopfeVQ0KA==
X-Received: by 2002:a05:600c:600d:b0:3ea:f883:53ea with SMTP id az13-20020a05600c600d00b003eaf88353eamr9242668wmb.7.1677511705130;
        Mon, 27 Feb 2023 07:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6-20020adff646000000b002c56046a3b5sm7219049wrp.53.2023.02.27.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:24 -0800 (PST)
Message-Id: <4ce9fae5e7f47e71d32d71cdbb9bc07b990e86c6.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:11 +0000
Subject: [PATCH v3 04/13] dir: add a usage note to exclude_per_dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As evidenced by the fix a couple commits ago, places in the code using
exclude_per_dir are likely buggy and should be adapted to call
setup_standard_excludes() instead.  Unfortunately, the usage of
exclude_per_dir has been hardcoded into the arguments ls-files accepts,
so we cannot actually remove it.  Add a note that it is deprecated and
no other callers should use it directly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dir.h b/dir.h
index 33fd848fc8d..2196e12630c 100644
--- a/dir.h
+++ b/dir.h
@@ -295,8 +295,12 @@ struct dir_struct {
 	struct untracked_cache *untracked;
 
 	/**
-	 * The name of the file to be read in each directory for excluded files
-	 * (typically `.gitignore`).
+	 * Deprecated: ls-files is the only allowed caller; all other callers
+	 * should leave this as NULL; it pre-dated the
+	 * setup_standard_excludes() mechanism that replaces this.
+	 *
+	 * This field tracks the name of the file to be read in each directory
+	 * for excluded files (typically `.gitignore`).
 	 */
 	const char *exclude_per_dir;
 
-- 
gitgitgadget

