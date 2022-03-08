Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A6C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiCHOks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347558AbiCHOkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823F39159
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h15so4536067wrc.6
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XwVYkuxuOeTBby06SZbqGTmC3SIt7fObUONs40r0wX4=;
        b=ecIazw4psoxDINr/G1GXjTxEusKFTdkqX333Gc6Kh01ULHqjF5w1boCU2l+Ev4SHGL
         oAuCY9daLorB+czbbySJVlkBjCMCmNKlI+6+XDcsIzKdDZ76ntcXIBeweW7KeAjt/hp6
         ambotf6OtgRdMFhiC56Nzl493kPipBnZ7gZLRLoOWYy0rDOaDvHGMHBwnKzpSYLsvrr9
         imsemdeMU9NGi4plc2Mh+4GXjVXFJsmfrv0aOfX4YxmtyP7TFUvbD1kTA02aqI0QyioQ
         U0mg0z6iqpb+Bgq0i+Asw5+UtC2YMpnoSqyblA9lKjOyo3VDb93q4AUeeBiE2NdZQueT
         bTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XwVYkuxuOeTBby06SZbqGTmC3SIt7fObUONs40r0wX4=;
        b=xw1iqq4yWYqgzjE0X2LCSdwLjHZZsaVCRm8s7cxFGxFpyXI4FsPIhaPA6MApb4aJ16
         pSYj/YDpT3/27hUYlQmbk2NVVXVIXgyrCD633AcCuIlHTRT75OfuZ1Ci8eiVSwJURF5N
         aLsrJrlGPzdIJ0BaM+SQSqHVvJQ26lbZpkPlb76esF4fizH+O7yyCKzTOVcC0zgxmCV7
         HzIDM/RmCt4f3Jlo/zgdKFpa5884t7tKHRqq7pnWDLFU9bVH+DEO6o6aR7YTGh563BtA
         A9ujbGZYERhrviTLyUBsOk3NgF6YBkOlvX5k5ze8Fl7G6+JLltz44wxSOYGF3Qvc2tpc
         nYSg==
X-Gm-Message-State: AOAM531pfczHfYazp+gbnOZUNpKdFYv9vHwOHtpTr5S/aZaxfSgb/ohX
        Pp+lJDXciwaVci7bDOIpH8KVEny9oLI=
X-Google-Smtp-Source: ABdhPJyQlJdzxWhA+47GJVboJHWykcC5M0tELgwfcMbphqz1ryYfSYbHeNSRr3lVRjcnlQL6Psm+Cw==
X-Received: by 2002:a5d:4aca:0:b0:1f0:7a8c:3505 with SMTP id y10-20020a5d4aca000000b001f07a8c3505mr12706195wrs.337.1646750370820;
        Tue, 08 Mar 2022 06:39:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020adfc548000000b001f07639a704sm11326971wrf.7.2022.03.08.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:30 -0800 (PST)
Message-Id: <e85ca2770a362cfd5ac37eb35caf3e28f388d0f7.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:18 +0000
Subject: [PATCH v3 11/12] bundle: unbundle promisor packs
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
index 393216c6246..322810dc1d6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -622,6 +622,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
+	/* If there is a filter, then we need to create the promisor pack. */
+	if (header->filter.choice != LOFC_DISABLED)
+		strvec_push(&ip.args, "--promisor=from-bundle");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index f10cf011519..42e8cf2eb29 100755
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

