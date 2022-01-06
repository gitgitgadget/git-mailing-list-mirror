Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DCFC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiAFEbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiAFEbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:31:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2387AC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:31:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 196so1481862pfw.10
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0R5Veoz7R8vUjhE0PBh6JNtDLC9bhLmigsYwFhTYU3s=;
        b=qTldMbjZoHEhUCcdon+a3RhOKJfybpBUCY7cP1gfGhm3dJbL7bn0whnxkNQL65VL1V
         EdsWx+ojWzdUJXnp65cnwX60VtPUZYuXujlJkRBlnFTOw4d7YhPzjQ+DAbLYwtqLxLZU
         pW5rwOESD7RM21DQcMpyLJRGDO6904YIpgYzY9JtthUi5ycK6vgA9IutBcpJlw84eQnO
         Nv0nKpzVLFsygWdfMKLPBP3fVtZG3xS2ZMX/qUenZxXx8P9kxg32CCFv5ieWpQm0O7Bv
         z1So2a9uDBNBl/8HgJwvl1XPd9mRWyBDUkWZJJjwWe5L8lMbtyBfr+tz8e4CatGeXMqV
         ADlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0R5Veoz7R8vUjhE0PBh6JNtDLC9bhLmigsYwFhTYU3s=;
        b=VYaEo1DZiQU0qUfUrlbaamXpPT62fMLFU+aQqEtfqrzUahQx33bDi9U8qliqCWidYB
         EFHZtkR+uQSioNv8++ENyde4yFZoQ5mzlKuUJFPR7GIIg+JC0DlPhwSf6BA30XBexqav
         rUJVOWLrjQPekTQub31SOmMbmIM9L81PdeNwuGEA1xBkrKycAngfBO5SHFu01L9mp1Ao
         rTFaOcffhz7cDJSAIh++gJzxTmohrKpmExFStgvpcs0/eHjyDqhZta4M/XG/hvAeaxDl
         W0kFTFcikvp6sfKP/rRZHTaoF01Yo1T28V/jL+nKsaLRXmdDcK34mDsozLvQqvU/11qz
         DN+w==
X-Gm-Message-State: AOAM533KOpi2ec8ENlVwrBi4aBoPMduasy8iGtq6RTggKmGO6c8YvD7L
        PrFOdv1sWrtDQ1nQDsT0GXM=
X-Google-Smtp-Source: ABdhPJxeDakpwwcHvTCtveIW71T8CXRJu8rUwwBf+X4bfYxQzxN+ioveEN0BT7SkdEFvAryKYxoebA==
X-Received: by 2002:a63:7945:: with SMTP id u66mr38359361pgc.455.1641443514681;
        Wed, 05 Jan 2022 20:31:54 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.31.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:31:54 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 2/9] ls-tree: add missing braces to "else" arms
Date:   Thu,  6 Jan 2022 12:31:25 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
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
2.33.0.rc1.1794.g2ae0a9cb82

