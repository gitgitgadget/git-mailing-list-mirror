Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C5F1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLKij (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKLKij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so17882812wrs.13
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5mewiIbj/6DMKLd/iga1QO1cz2Xuabb0SmVqKZJhT4=;
        b=rWDTp+BJn2BDPO+YRudxKGiKxhTsySwcBMBG+wFX+28Zp+vkiySTokgU46gt9mTPUH
         RkXHheCM1FPsFPQZMOVHMxcpm7H5xHUGMPx65bt5xinj2rFncymqvXi/Nfr49aPaEFEJ
         NbwsLs74jNXHjHnXr4EoyMbAXTZ1+Ax2fXG0Zhx+jkV/pe/WtvS3ot3FrgByHU8vqWFP
         jd5EcD6cKQjiEO8gSMmr4C6j+9kkFTLBQik+KL8aYM10kedrVjy6h8RichDAy9IFN2+o
         e+88vkCpCwceJRNkdTR+soOyF8djVsLyjlM1RGfQpYjWkq6b5tKPwxqLFaoJvZKCQ/nC
         z9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5mewiIbj/6DMKLd/iga1QO1cz2Xuabb0SmVqKZJhT4=;
        b=aZDJqMGZiZOmkXuy+gb+/CTnnQwB8FWVd5+MFLSu+MhZzyUB5ZMZCyZcG6yzHhenNX
         YKakztsSdN3dhWsIZpzFcaJgY/aY007Zc74sm2IVbdu2zpftXv67PbopRcvVT5Hegqz5
         Tnab+yqOM0/tvmlLAIh6IgJp3rOF8gY+2d/o5IGNWkUlFDSJy6QjmxDamUKbKhUXW5zU
         LvhBEfCNXAaalwK8dDaT+9nJbtDSCSX+sxP/wy4g9og8gM75zPeejnT3IRS9ylXXQ+yS
         BStm+85l0shNK8NT1CPt7cG25rgHcD1VLznME3i7jEhf0Jq8K56kVMaGVKwZuEz56nLN
         MXfQ==
X-Gm-Message-State: APjAAAV8RPtugt0796Kk2ttwsxBbIBIoJO9vo8x8l3XwWhcJado9BEP+
        BZ1R9hH/74f/q5XLvPjschM=
X-Google-Smtp-Source: APXvYqyIpEvJgd/IiMOhR79mkPrKjm5c4PGDzMIEWzvpfYKPPOvkOg6tZnwOrJj+NtBUdARxmnwsCA==
X-Received: by 2002:a5d:61c6:: with SMTP id q6mr14433630wrv.13.1573555117749;
        Tue, 12 Nov 2019 02:38:37 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/13] name-rev: extract creating/updating a 'struct name_rev' into a helper
Date:   Tue, 12 Nov 2019 11:38:15 +0100
Message-Id: <20191112103821.30265-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch in this series we'll want to do this in two places.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7e003c2702..e43df19709 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -79,12 +79,36 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+static struct rev_name *create_or_update_name(struct commit *commit,
+					      const char *tip_name,
+					      timestamp_t taggerdate,
+					      int generation, int distance,
+					      int from_tag)
+{
+	struct rev_name *name = get_commit_rev_name(commit);
+
+	if (name == NULL) {
+		name = xmalloc(sizeof(*name));
+		set_commit_rev_name(commit, name);
+		goto copy_data;
+	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
+copy_data:
+		name->tip_name = tip_name;
+		name->taggerdate = taggerdate;
+		name->generation = generation;
+		name->distance = distance;
+		name->from_tag = from_tag;
+
+		return name;
+	} else
+		return NULL;
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
 		int deref)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
@@ -101,18 +125,8 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(*name));
-		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
-		name->generation = generation;
-		name->distance = distance;
-		name->from_tag = from_tag;
-	} else {
+	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
+				   distance, from_tag)) {
 		free(to_free);
 		return;
 	}
-- 
2.24.0.388.gde53c094ea

