Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E7C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiC3FHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiC3FH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220D6621D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so27596918wrg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0FZmb8xpqwGRKdPb/QtLOYQHy803cgaUCogAov31nBg=;
        b=odu0pFnB2zMMqIb6Ll98sDstvzgLsz7FI34OjFDE3O+t0QGwqgOq8xfFe9jcEQsU37
         wGtUIuLq9IXYj7N7vHC9TOkY1hL7Hsuny4YvsPWNQPauVTnA05zVDc+5dHgCJnE4kT6i
         gmGQOmvh3v7ihMCQglP/28HT5c/i9UBCcjVbmkBusXKVowbXnIpVim+hutjLGUJHKS4E
         MeyhdwDrOKc0ZfdLvJLLkkzcKm58F9bZQEGXTudBsGDi3Go/Tsa/kzX+ZwuaI6cR+Ihk
         HCqxc/w0JPBjleDeZq+rgcrItPvQfapZ1ojLGIe5qXtgFpVCcuZFx2qe1UEa6uxzOpO0
         EoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0FZmb8xpqwGRKdPb/QtLOYQHy803cgaUCogAov31nBg=;
        b=UWo8Mmg+Qx1ZnDNtXeOCK3+k8+bUeQshnMqmklVc59zfq2mQRS169q2WVIhZ/tcqRQ
         +pKTUAMQBAK8T8hs9HsgR8EkdAGwoaNyAHPBhhT1413Nok33cp4OszTsElNrqWwklF5p
         zBQXKVH+AgfLtrgkPC2LNct/bL7Fct5cd5+Ysee/JMQh1otuiTW7FxEFPWtpEDQoq3f5
         8tUjeV35giY1g0LE4Wm5FOBIYkQHYWlhEevcTU0e5vP6SOFI9SqqeM29TktmLGySY/1w
         aS+A7xHoXtR3JCLtnnlmBK0OWkV5cBwBfDotrIZDcahXuP0h7eCysrNAVTjylDQY7iAJ
         kyyg==
X-Gm-Message-State: AOAM532FoXr4x8326EO5VQSv9xWsdk/H+5sWaAXhr84UYpVX/o1q2e6Y
        b6nJkOMvzn7g5S7C0XFJoNRLqTeYcm4=
X-Google-Smtp-Source: ABdhPJzE6jTAIeor/HhpUsV356yXu4m8g2QYcfEttZ820n3IGT1PMzKYYs6fORzYsu/wxFO6A5WbHw==
X-Received: by 2002:a5d:47a1:0:b0:204:9f5:e72f with SMTP id 1-20020a5d47a1000000b0020409f5e72fmr36157650wrb.656.1648616740945;
        Tue, 29 Mar 2022 22:05:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d6d09000000b00203ecdca5b7sm17585773wrq.33.2022.03.29.22.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:40 -0700 (PDT)
Message-Id: <83fa4a5f3a5c79fa814932c0705867ff16a584c7.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:23 +0000
Subject: [PATCH v5 05/14] cache-tree: use ODB transaction around writing a
 tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Take advantage of the odb transaction infrastructure around writing the
cached tree to the object database.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..8c5e8822716 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "bulk-checkin.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
@@ -474,8 +475,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
+	begin_odb_transaction();
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
+	end_odb_transaction();
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
-- 
gitgitgadget

