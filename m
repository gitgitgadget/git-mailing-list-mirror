Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A408C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiBLUfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBLUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B1606E5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so7763343wmq.3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=AJy5Hf7MNeXX1+PKGDxKUWgB1mvD/x00HlWELiq3kfRdk444k5PIBhMeDdQ3jzvxLN
         DZmRTNWSEIKtDoOpWDxxyF7P6Bbh+DnhCQ647VQVrlgu6gKR9z37HpptTyUdymwlSsps
         ZO3HownZG3RAWWUW0aivwuT6PK7FU2XxDGE/lxoNDWv38dKaLgPI4hF7wcHnRqzurR59
         q4eTT+K3JVadhMqzPj5aEEmQsW7jcOcFVCEJp0wltEpmwlpYQ6MIHGYjHN5v1tqBa3jp
         fgNfPTf2EH3ssdlqkngAo3VTM8rcKv2008lng+BaO3BJK49++mH+bbCTs04nDgRqrQ/z
         RWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=M3jEywMTExAbD4Sru/836Qzr7/BZgZWBuHx4de4eVNxjE4czQSbjCEC1H++6neX/eQ
         xIU6ZEKh2+HxWKdAHIkwA/8y3dd213oU3EiREoHfwAJoKRjaMGM6ZQ/Z2TU2nqbG1WAs
         FeY8lyfT1ibR+jqt8fQbAwvZ459JagCOaQCipv13us4pc2vO2ZNYUcNbw6JX4vVpKkw4
         VvJnW0XslG8cz2ciJckzNaKFxGWNgNsk+1GwAj9/nJQpRlHOoe1/SyaYW3xfX3SAGm92
         EVR+GVjCgTr7O2v778ZZcVFZnFxyntk6A9JIAPy9ZXDFAIiHyPySjkADK71n4i93tbsu
         J5tQ==
X-Gm-Message-State: AOAM531KVj4isRnAq7277lFH7TQYsb3jL7GjQKjRwua6UOivj8+M8SAE
        Mr2AgiJupEMByQOnmTBpxP1LqTTzQmc=
X-Google-Smtp-Source: ABdhPJwMsgulaUFKl17jkU/i1Nq/S3ay+2jiJk5TDwzMJB15ZKl1Fua2jk3CA+z8tbuNDWbFnTiU4g==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr5210607wmq.44.1644698096270;
        Sat, 12 Feb 2022 12:34:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm8309103wrw.71.2022.02.12.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:55 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:43 +0000
Subject: [PATCH v4 02/12] merge-tree: move logic for existing merge into new
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

