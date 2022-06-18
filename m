Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F1C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383643AbiFRAVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383506AbiFRAVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2B5931A
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e25so3651025wrc.13
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=jV7tQQo2XwEeBG1r3FhS8+42bwQpPz9rpoC7RrnJkErMhhhJZ2UD2eWtE7LlEsdx8y
         2cZIQMRKUE7wOvbegDl9qVwmAWWCgkMJvyBY9VaHjQRxZVSedCwPmqKxPhlWXlUW6q4v
         0qvYM8KuZZwSa843tC/P0+8x9+jtR2GcsMWvdBBrVkIRqQCTR8JEAbBFAfI1G3lmBQKd
         nfw4wAGKV1AywhnHJCVAPssp5IayBOz2Hht0AaIPM9BIbyOSHmWN+S02H4p0y1MmFGM9
         sFMc3ZNj6mEWbIDyE5pQCEfkbiDZ5nTSbjcB3DLqmc6waLfAOzAKloYrD0Xwc9zb20TN
         fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=jhUkkPitvoGYyVEogObWHYydhvgAEqYRASkOkQfEiMY/oKkshTwX06xdQg2Iz8VcIX
         gBHpZGEtxTbjtn3459rSP7mNyKsQeTwfu57zFUN2X/a0OHnw3AfgpiIHl22SdAiW+WQL
         WDXhsXObbdHvbZQlS3OREaWvMyrUU+S4mQCmFJ4CGN57l21wy5KE7P1TSS10njwVQQss
         1mI81tdKct3o88BbIvl1eoOZ2Ro4pbhpTwdYf36tGJ3vrAzg1aQIXCAD7e+LcfUxE3cZ
         60SsrOmh/pgXtzcZ4EBXyfgvdN6ZD5Keo0ADCvYmdvEbQ7916nsiWM2fqUOXPHGarnp4
         Yh0g==
X-Gm-Message-State: AJIora/e5GJX01Zq5XURbZU4yWP4/ZCF94Pge8Sz7DMzemZmxFW0ebqm
        AjW1n37TZAswjPQnoLrP+JIdwYL5/cS3tg==
X-Google-Smtp-Source: AGRyM1udfyJIFjHlvov5mhZCIPs5le5/crVI/IxeoI/cVlykbE8h2SQHXK7/0IgIuVSMGRPEYgTbww==
X-Received: by 2002:a05:6000:69d:b0:21a:395e:572c with SMTP id bo29-20020a056000069d00b0021a395e572cmr8820949wrb.559.1655511662977;
        Fri, 17 Jun 2022 17:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m62-20020a1ca341000000b0039c99f61e5bsm10713438wme.5.2022.06.17.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:02 -0700 (PDT)
Message-Id: <8fb51817ed4688cd8eadb30108f96f741405bb8e.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:44 +0000
Subject: [PATCH v7 01/17] merge-tree: rename merge_trees() to
 trivial_merge_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive.h defined its own merge_trees() function, different than
the one found in builtin/merge-tree.c.  That was okay in the past, but
we want merge-tree to be able to use the merge-ort functions, which will
end up including merge-recursive.h.  Rename the function found in
builtin/merge-tree.c to avoid the conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5dc94d6f880..06f9eee9f78 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -28,7 +28,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void trivial_merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -225,7 +225,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
-	merge_trees(t, newbase);
+	trivial_merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -342,7 +342,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void trivial_merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
@@ -378,7 +378,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
-	merge_trees(t, "");
+	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
 	free(buf3);
-- 
gitgitgadget

