Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40808C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiAMDmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAMDmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763CC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z3so7595711plg.8
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IriodHRimd7+PzU6tgt68KmEhLst1mOd7aJJ6mMOKVg=;
        b=hC9sOlm3xQyFPvtHlQ8M4Da8gGbhnlrNamHIbh0hR8ayj1TVulz7zc9MiHRbjFenE2
         I2fkV55SA//YnbQg+GGWRCVu2xaNoM94kAhPXZffLWywo0hTUKgXwlKw1akV3RM1RX+4
         PAB6VVCK4AlOaUs2lpuJG/uex2HBewQsv0W2aF2gSMTkfqPbbuYK93haJ8xI/bUo5fWS
         Tf4NTBQMaF4uDCyMsVq5zBycu5tMK4BWeLfCJDVZoU79c+R8Y42ZV40kgIiFRB421YlC
         6RYZZp4utPB/QtiWeNid8tFQyh5MKBAI7jzukMqJ20nrCAg02BN70k+ongU7NFIuLqXU
         2grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IriodHRimd7+PzU6tgt68KmEhLst1mOd7aJJ6mMOKVg=;
        b=HxU6fM2E6F10JBS/wvMS9N9kcW1p9xiqxbR8YmsqBXlBnJfYFQxJwnipk8bPAFJ82P
         I8m3z1yejrA5Yjb60W/59o6hbl7isDXhaV/23s7PtFftINe0GUlD+OVVYOWoG1gvYzMS
         glNYyB5PLmJRxI7BKIR9yMXJ25CUbGLSyJy5aFhTZ4mKUL7SuSa4qWfSJlK5VuwklavF
         HG45OO8OkSIZRAKIidM2yG26+X6x7uxJjci00cTT64wmiGB3BVMUdAJBvsMOYGRKloq+
         lVTwZXL59MVLUlap/t3W3TeT6LgOs9W4Cpn3G9x0+BvxpuEK9Zfk8w4klIsQBrCnab6W
         SgcQ==
X-Gm-Message-State: AOAM532infB0/WWnZ1HRheU4vg1OrQhhB3H16UdXfCT+KkOD+toL0gZl
        TbMSiWNXfPwA73XHbz7bFlI=
X-Google-Smtp-Source: ABdhPJzgKNa8935Z7v8L/AKEm18/NBDuZVa3ziUEjZ/3ehg/mVXXb8f3Fxgq7FUfeJQ87u5eIPgq1A==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr3115967pjt.10.1642045344118;
        Wed, 12 Jan 2022 19:42:24 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:23 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 2/9] ls-tree: add missing braces to "else" arms
Date:   Thu, 13 Jan 2022 11:42:05 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add missing {} to the "else" arms in show_tree() per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5f7c84950c..0a28f32ccb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -92,14 +92,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				else
 					xsnprintf(size_text, sizeof(size_text),
 						  "%"PRIuMAX, (uintmax_t)size);
-			} else
+			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
+			}
 			printf("%06o %s %s %7s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
-		} else
+		} else {
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev));
+		}
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
-- 
2.34.1.390.g2ae0a9cb82.dirty

