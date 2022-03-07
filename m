Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBB7C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiCGVwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79A75C2A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h15so1107520wrc.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6WerlHwiy/gl4F2HuBT7eEaXO5DpXYp0OPizpV8w6Vc=;
        b=csVBCtz1rqAwP1UbdemsmH8qpw2uKdA1FxMuGA9XR0YGC6pRs4JnJgHCy3UvtzaKV5
         XGBWRWDGdTw4pdspUXfCfHNXRaSoaHFoHVo6upsTiNlpbif9/1eZxLxUaGJw9U86+9Kr
         99hLXiBauzyYDMX0PoMQ5tMf8DU7hHcimvqbmzthXBTLURTNqmxdLXqfgWMtwGAL41i5
         yv9oPwVHXlrbQOfupMf1OP3fPnBibmBqdBGczw0Rwkg1Ot2K20aJV09Lju8ZFyhgX/AX
         XR9UEJ1sj9lIFgRNYeVg6m0l5hgN06ye6fBwE5Dl//aWz1XWf0nHutwHUa85LwRkqQJT
         EfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6WerlHwiy/gl4F2HuBT7eEaXO5DpXYp0OPizpV8w6Vc=;
        b=34aqCZKpgaveyU05EcE0nsVex+N7gYjeL/3cdLMj87JEuqjmusEnP+4CDCIGciRVJM
         ODlqF1Noa/300tzLDniQWLWKYrOFmizlGzuhJx/qOFJYzGMdSZpouW/6Dcg5ItVI2Kr8
         LH2pPoO72QOiK4dNKn7GDz55JcFZBSEyo5rknp++HSg+HCOPPW3o2oBbURR0auwuLnyk
         RogW775s+851e9YY4Aj5pJvvOLp7mqw5sQmZV2PHN3vvRyv3MRCSVUWvIzryNYwUwQyw
         /1Eoha0PEYK7xUtlHv3lhovx8j3CkbR+6m4FjNrjD/TENqfZ6aqyJ4/jPM1Qavegay0l
         QwGQ==
X-Gm-Message-State: AOAM5328FVejkRs2ZSiTSYKI7VYZvVclQrMHbwjIGIHaiFJsv4e5oroE
        BQQtk8evqecznKWQOPWWULqlwtAOcjA=
X-Google-Smtp-Source: ABdhPJxsBAtW1qUHsesdjVsUhSFJ2V42NDi2NPLO1YEpC7U/SpOQIH0jwQnOBzOuG4P++kYOzDbL5g==
X-Received: by 2002:a5d:59a5:0:b0:1f0:bf:64c9 with SMTP id p5-20020a5d59a5000000b001f000bf64c9mr9785161wrr.352.1646689852077;
        Mon, 07 Mar 2022 13:50:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003899d242c3asm439381wms.44.2022.03.07.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:51 -0800 (PST)
Message-Id: <ef17691a6b7f445e753ea27cf7ae23dedd04c317.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:39 +0000
Subject: [PATCH v2 11/12] bundle: unbundle promisor packs
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
index 0016d70310c..9ca6a7eb1c2 100644
--- a/bundle.c
+++ b/bundle.c
@@ -630,6 +630,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
+	/* If there is a filter, then we need to create the promisor pack. */
+	if (header->filter)
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

