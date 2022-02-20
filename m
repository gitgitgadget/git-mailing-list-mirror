Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5259EC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiBTGzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiBTGzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004B35871
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so9233352wmb.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=DZm8mjy4wkMVRBpV6rnfaRnlC4B58bYBX7C/n9FyUKpDDTtHSMbVob2yoyctnAhWQ+
         h+wmnJQ31rPakCg+MpfhJ5eFWhjoszTtcraOboVB6Ywx2HCIjld1XoYocln3FH7RyB4P
         jKy/Lax+956o5WLHO2AHRtEKZ+pgDmxrDLJatE7VaJ383FAD48wEnxgQoMHLsd8NlXj3
         +lglOWypYcwCh8DPk7noLFLjDu5rdFodVWGr2LWj/sp1y2mI1/jOfmPdHJdRjdY9gDAk
         LA6iLwXKbCgY8lC6tO5UDAMJJnJCyDSq+eLmEAhmO0JGxU1+NAy3tFuJBGnjH04NpRqG
         2Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=Ioi+XyrOSIvf7t/GtB4gtfeYtoe8WYRDOhYSSq8G5rQnp56J2YZEvA7EcdmT52/RUe
         FMwaMAdfw7TG/5oVjaBNIpkoqKoPZxKhukRtlUbGb4uzWO1YGCQ/qYLgW8c0WXPHEf+j
         QZwteRyY5JhXNLNFLYIhVGuy02QkecqdTu4LBuWjhYCszVFD3Pm6VR3jXe1OV11w4GRp
         GS9pz7crVpmRoPdA9KljQuUuSrUE7RjdRkt+6AjYRqrv//eS7IUy2qpmAjX07DuOGWkF
         tTe/tf395mo1ILyJTYJSqsfbiRmo2pm2q7DELBGALcCM0JSkejQQ2iEEynJwynv58wTQ
         4MNQ==
X-Gm-Message-State: AOAM5307OTSIBLk/P8ZltKh7HBtOlusANi6toHKTYgm4GYoGT4OgiR+O
        OIvigRECSUq6PffngpqpPxqNzed7ZNc=
X-Google-Smtp-Source: ABdhPJyQT+ZL1B0M6SO5WznI4OUlJ83AZPY/xtxqkLqpzdgf2BOY4oSQe2059dlTh9QDgDuhX5ZL4Q==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr17051216wmh.54.1645340084344;
        Sat, 19 Feb 2022 22:54:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm37927827wrq.112.2022.02.19.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:43 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:31 +0000
Subject: [PATCH v5 01/12] merge-tree: rename merge_trees() to
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

