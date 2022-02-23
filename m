Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiBWHr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiBWHrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB9E35849
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x15so3740953wrg.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=Dk34WnViRnL2EfZYzXgsn2R11NnoVWmUkem+nri68CAo5jMUuwXRVIPQ/jBDYSndbB
         OybL00yZILI+wWaEYish+a4TyA5dCH+TqE+afCEulFodoJSDZPd+17iJ90dXohKm6K0p
         VHZZMQipv4kdhCgb+sbpYbfOCF+OUso9rLYCb8uUnuAESIQsMUWBAlNa/cHtU82y5Kpk
         eibV2O5J+6JMNG+TzJOogF+6+M5+Rh/BSFlOKlcImfb/C0JDzZMZbHVUTS0pcHu3xdG0
         A36HavA3QIGvLikcVI+EjAkewnhVEuKB2saRa8ayp6Pce85SMVpieKGPtCDQHEQ2IrPk
         V2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=TTXjK+Zur8zfui67EP1uP3jCYNK15MHIvL6CgMYEq4OGzxIBDfeybwidFqQ294zoZj
         FSjiiiqZBBg0cZhxu6WZmUUbYvyrnxQTm7jyrX/Qyq/60FCYQptRRDtN5GU7hMwjj1t/
         F4Dzb9JFXERM796PgB06HgtuyQNXGYl8vS8WwmZH+oyGkuJqaL9YdNc8bR3eZ4B0A5+/
         LDLwxBC+0bQxp5XDWHFdfCaNhHkiTw93ivNeCX75vfaARSB1CmLxcYH6uDLGEK5EsJD6
         T0IZDX/UiO9Xe5n/LlR47n9jt/AuQi27GRFGOXU77LFyUIFjm+Ik9cVP9hdqtqwp5xOQ
         MSWA==
X-Gm-Message-State: AOAM530Mmjq0zzEjhuXwhtJJPfZZjd6T4uyKhFRwGauhulyP/I5AdUtP
        gOxxplaSIsPlbzCiFKiOhjSrI7Oe7mw=
X-Google-Smtp-Source: ABdhPJw5k9U+0dJnPB7/cFJTTOiBcXia3QMYzyzvysSIkhUZHnNr3a+yHtX1P1oi7xKrgeG6wmpHcQ==
X-Received: by 2002:a05:6000:1141:b0:1e4:b28e:461d with SMTP id d1-20020a056000114100b001e4b28e461dmr21290802wrx.320.1645602416653;
        Tue, 22 Feb 2022 23:46:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm48840273wrz.40.2022.02.22.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:46:56 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:43 +0000
Subject: [PATCH v6 02/12] merge-tree: move logic for existing merge into new
 function
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

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

