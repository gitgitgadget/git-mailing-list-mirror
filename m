Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BBC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiCDPFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiCDPFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BAB15C19B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so122730wrc.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eBFeyhJa1Ak/vERr0x00+QihR4ge9lNHluT1R3qiP3M=;
        b=qNlFcfrYymPfuThVo6d488pPDQXL4PRJAVu6zjj4UoZip+0s+oFHEZKf4qaGWeJb6x
         +zsXfwONJlW3yhn8EBTqOHCo3LzG+8Ir8iBfMeyS2qeNYjaqEQYVFahdvYB59QFuURnF
         sZTzOHwyrIO8g7I/g4GfbtB4mT2bqVocp7eutHzbY4DQmqfoMvNohZW4+H1JDKkYk/x2
         AG3mMANX1eL0BMM8reJXFiXqxD69eTe9N9fbzWCSF6X8C3PHhuNTuhXHwgBUYXoiSGSG
         BCXhusabJ4wdC2+lTbnX3VZ7IsqlqJux8+/hu9Es08akNZrorMv6RuXHg6udC7U+6/Hd
         KuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eBFeyhJa1Ak/vERr0x00+QihR4ge9lNHluT1R3qiP3M=;
        b=1lNaiPxlRsj3dPCUWlskrmVJqqbVz4AJxs4PybVCQcHIvl74ktCnj8cL1KRUBiH5+K
         NQPbcMNRQ9k6fGu0+iQBv2zzRJJgfJvQqk6JoLFj1joZJm+CEauhIUTwMUvRmXfzuKYZ
         fNr19LJvyRdXfr4Og23s3WYZNjM9j3yzjUUuP+sFx90hep+5D0We8sqhwZyIrNVon3z8
         wSEDAcQi4qPelpkeBvXMG1mgp8J7wpDNkkIAj7FVYS4pytK8Z8aDN66XxFJwl0B2FrOv
         x2y6gvrZ17ORilwuHj0B93Asfw41fERWWYGWlaMYVyt8BxYYN3i3lEb4wVmWjBxWz9tJ
         p87A==
X-Gm-Message-State: AOAM532LKct3IAsSjrlVcqVkgUdbgOhH7kK2iTpnwn4TuHXpQv/x76+O
        EHskJBN4Ggx8t8izo/HCQeXzvHIaffw=
X-Google-Smtp-Source: ABdhPJwszzGeHWS4hDzpnWGbmQw5Yypt9n+Vff2enguWEV9C/1+XrrKae7VaQfKgf6NNQ1q6iKtGKQ==
X-Received: by 2002:a5d:6d4e:0:b0:1e3:3636:b104 with SMTP id k14-20020a5d6d4e000000b001e33636b104mr30854981wri.605.1646406281558;
        Fri, 04 Mar 2022 07:04:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020adff144000000b001f022290737sm4668525wro.6.2022.03.04.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:41 -0800 (PST)
Message-Id: <310466259878bcd32e09092b8de1db0b3e500c2a.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:33 +0000
Subject: [PATCH v3 6/7] fetch: after refetch, encourage auto gc repacking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

After invoking `fetch --refetch`, the object db will likely contain many
duplicate objects. If auto-maintenance is enabled, invoke it with
appropriate settings to encourage repacking/consolidation.

* gc.autoPackLimit: unless this is set to 0 (disabled), override the
  value to 1 to force pack consolidation.
* maintenance.incremental-repack.auto: unless this is set to 0, override
  the value to -1 to force incremental repacking.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  3 ++-
 builtin/fetch.c                 | 19 ++++++++++++++++++-
 t/t5616-partial-clone.sh        | 29 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 21a247abfa4..49ae48dca32 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -169,7 +169,8 @@ ifndef::git-pull[]
 	associated objects that are already present locally, this option fetches
 	all objects as a fresh clone would. Use this to reapply a partial clone
 	filter from configuration or using `--filter=` when the filter
-	definition has changed.
+	definition has changed. Automatic post-fetch maintenance will perform
+	object database pack consolidation to remove any duplicate objects.
 endif::git-pull[]
 
 --refmap=<refspec>::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7bcf6fa64d..1557e8d57c5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2226,8 +2226,25 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					     NULL);
 	}
 
-	if (enable_auto_gc)
+	if (enable_auto_gc) {
+		if (refetch) {
+			/*
+			 * Hint auto-maintenance strongly to encourage repacking,
+			 * but respect config settings disabling it.
+			 */
+			int opt_val;
+			if (git_config_get_int("gc.autopacklimit", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				git_config_push_parameter("gc.autoPackLimit=1");
+
+			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				git_config_push_parameter("maintenance.incremental-repack.auto=-1");
+		}
 		run_auto_maintenance(verbosity < 0);
+	}
 
  cleanup:
 	string_list_clear(&list, 0);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 87ebf4b0b1c..4a3778d04a8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -216,6 +216,35 @@ test_expect_success 'fetch --refetch works with a shallow clone' '
 	test_line_count = 6 observed
 '
 
+test_expect_success 'fetch --refetch triggers repacking' '
+	GIT_TRACE2_CONFIG_PARAMS=gc.autoPackLimit,maintenance.incremental-repack.auto &&
+	export GIT_TRACE2_CONFIG_PARAMS &&
+
+	GIT_TRACE2_EVENT="$PWD/trace1.event" \
+	git -C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace1.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
+
+	GIT_TRACE2_EVENT="$PWD/trace2.event" \
+	git -c protocol.version=0 \
+		-c gc.autoPackLimit=0 \
+		-c maintenance.incremental-repack.auto=1234 \
+		-C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace2.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
+
+	GIT_TRACE2_EVENT="$PWD/trace3.event" \
+	git -c protocol.version=0 \
+		-c gc.autoPackLimit=1234 \
+		-c maintenance.incremental-repack.auto=0 \
+		-C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace3.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
 	test_create_repo submodule &&
 	test_commit -C submodule mycommit &&
-- 
gitgitgadget

