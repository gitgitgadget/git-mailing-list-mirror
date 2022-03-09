Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB1C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiCIQDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiCIQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8741179A28
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:02:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k24so3774549wrd.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=guBdmIvrxmYIKLajG644S8L8MvB8iHuPF96zFc6SXQc=;
        b=UWJ2K17smdcCtEOY+yovbiqCPTYUZl+t+lmGE733VRi3/Np/F/T+vPpFaoCqXLs4DC
         xoF+bRSuEcm0rhjCEgX3JoqBP6pnlgqNB9geybiYGqYS1YI+78OlwpCWhGJxXq/U40Ga
         Gi8XZZOnMAZw5sJDLjcApLJiOL3KG3QIPCR/A/yq13NVGbwJaKw7EkiSPIB6OGMRkZEa
         zxktx91jUJxFTRiyMPkEvQHcGFJDBKfc+tH4UjfzvcR8gN3a0rIBB1XJMoouvme+E+Aj
         uBrrNGxnfSHCjs/7J5JaRQS9Fxfir7/qKqELJhoSVBoOorGAmJ/+nywliVDp6qsqDhhV
         R2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=guBdmIvrxmYIKLajG644S8L8MvB8iHuPF96zFc6SXQc=;
        b=OsDlTgbH3HJrBmazuWAPDidFXYExM/8nIuesd84zwNZk0rPSHnJ3sipvQkj3vBzlEw
         NOXB8QqfXt8o88QYTPX8+iXGgtRiU21GDCz5qXfwOW2en8QiLw2t50ozs583XIWWf7bv
         6ln6hZjN758vZKd15ZqYvQ9y4AarZa1fgOKd2UN35+LuEPRYHuoOg5NHrXatkawLg8kO
         6mx/exPRYACvhJmLWqA/TPshXWATByshCW+M3b7Yxdp8fTT4d5kr0wriAbOulKm0CFkW
         jvFoKtZp0mDIDIJcjaFX1ptlXiivVdfog/RU0yVBjl5BCRKV/XG22yzijy5fp9S+e/eA
         ubBA==
X-Gm-Message-State: AOAM5333nUJoYYTzfhJz0j7qsFZnGfuPhP1UzmF2MnuXu0jocaZdKu23
        ut2sZu2KY0iX847lxBRrU96TXu7VA9c=
X-Google-Smtp-Source: ABdhPJyaKzmtLvqQRHcc2yCqXp61+SOh8cux4SlYIia6qkf5JSc/nkW5/JYzPyu7ScO/cKcdt6hW4g==
X-Received: by 2002:a5d:64cc:0:b0:203:781b:6a1 with SMTP id f12-20020a5d64cc000000b00203781b06a1mr231309wri.205.1646841718696;
        Wed, 09 Mar 2022 08:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm2035697wra.97.2022.03.09.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:58 -0800 (PST)
Message-Id: <77a62156332160cd3346d604d342cfab5b9001d4.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:42 +0000
Subject: [PATCH v4 12/13] bundle: unbundle promisor packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In order to have a valid pack-file after unbundling a bundle that has
the 'filter' capability, we need to generate a .promisor file. The
bundle does not promise _where_ the objects can be found, but we can
expect that these bundles will be unbundled in repositories with
appropriate promisor remotes that can find those missing objects.

Use the 'git index-pack --promisor=<message>' option to create this
.promisor file. Add "from-bundle" as the message to help anyone diagnose
issues with these promisor packs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 4 ++++
 t/t6020-bundle-misc.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/bundle.c b/bundle.c
index 9370a6e307c..56681c21131 100644
--- a/bundle.c
+++ b/bundle.c
@@ -620,6 +620,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
+	/* If there is a filter, then we need to create the promisor pack. */
+	if (header->filter.choice)
+		strvec_push(&ip.args, "--promisor=from-bundle");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6e97c044ee7..7c6db670221 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -521,6 +521,8 @@ do
 
 		git init unbundled &&
 		git -C unbundled bundle unbundle ../partial.bdl >ref-list.txt &&
+		ls unbundled/.git/objects/pack/pack-*.promisor >promisor &&
+		test_line_count = 1 promisor &&
 
 		# Count the same number of reachable objects.
 		reflist=$(git for-each-ref --format="%(objectname)") &&
-- 
gitgitgadget

