Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF56C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 03:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379834AbiFQD73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiFQD70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 23:59:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3E866689
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 20:59:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so1784523wme.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZzBi/VReOsqhwitGsPVxfHklJyX/xYwIWl1oCmCTrHQ=;
        b=RoEhT1YBT/RvlUXFbHZN8ucYoKGgIqdC8TxXKmcv0f6POgZRHrDrPG0+a2karPI4vo
         3nFBUbyJU+IiJHx8jWaSVccmpgvRvMTfQI1zjnXl7Vs4zkfACeifj/r7ihhPJX5XRqNR
         k2pRQanUV3V27IryHBCyMAnOW7AfkoURwmxkxbFkTLdtGGtDhLXcqIRd5dMCsGg5o+Ud
         DGmZkiGaaAtX3tPLrCobMZQm/0GOlhKNNYs2+wlsKkPKMhlPJmPIqCXmfp15lMe/MoOU
         zVmeJxsTzSIDxW54EZ1vXYfpTMvz383h9hZGufYI4/W7smLjLfc0W8sdhjXe5Bid3v7m
         dogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZzBi/VReOsqhwitGsPVxfHklJyX/xYwIWl1oCmCTrHQ=;
        b=E1PcNiD/pOUytrY4NcafSxI4uHa1ic+HcRIZCc8d8GJcJG5U1hhElx6D0cgsoZZL1H
         zN8lXYBZOel8gFLMdWKkxeOicMtb4iXAQLhIJzb3fbbS+dNBsB3yz3GnenI3zb9Ajerr
         7G0E1Rgtv/7q7YA+GWYOSMfpMP8GjUVTcC0klNtR0wkzW8fwkLGjQJk7yuJC+V6Y5uwq
         LOR1Ijc1KCfcAfLTDoFyqej+eys3z2o2CKSdcyV6mlpCJu+5d91FXn7Z1WLNvl5Hs+Cd
         ymeMGZMN7qp003NqehY+SSP5WBM2TQlDsZbCOQCdbAuv+mLK2M2slMPN192hI0f2ZapG
         tKbA==
X-Gm-Message-State: AJIora/+xXIW/ZOHFXIX0EGaFN6nJdEv4oHdLovc8/oFl+Fm9Eo5dev8
        p2Fq1NgjJDF4ne7eRNsD1wQ+WRzCadIOsA==
X-Google-Smtp-Source: AGRyM1s2t4LtnL6dhgu92xELfEVAQzxb5T/+JAAWiIMZRs0Erpmpm9v9e7Dx6NPZvAcm+JsQg+u0Zw==
X-Received: by 2002:a05:600c:5112:b0:397:53f5:e15b with SMTP id o18-20020a05600c511200b0039753f5e15bmr8193882wms.93.1655438362982;
        Thu, 16 Jun 2022 20:59:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b0039db7f1a3f5sm3962790wmh.45.2022.06.16.20.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 20:59:22 -0700 (PDT)
Message-Id: <pull.1263.v3.git.1655438361228.gitgitgadget@gmail.com>
In-Reply-To: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
References: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jun 2022 03:59:20 +0000
Subject: [PATCH v3] send-pack.c: add config push.useBitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>,
        Jeff King <peff@peff.net>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This allows you to disable bitmaps for "git push". Default is true.

Reachability bitmaps are designed to speed up the "counting objects"
phase of generating a pack during a clone or fetch. They are not
optimized for Git clients sending a small topic branch via "git push".
In some cases (see [1]), using reachability bitmaps during "git push"
can cause significant performance regressions.

Add a new "push.useBitmaps" config option to disable reachability
bitmaps during "git push". This allows reachability bitmaps to still
be used in other areas, such as "git rev-list --use-bitmap-index".

[1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    send-pack.c: add config push.useBitmaps
    
    This patch add config push.useBitmaps to prevent git push using bitmap.
    
    The origin discussion is here:
    https://lore.kernel.org/git/b940e705fbe9454685757f2e3055e2ce@tencent.com/
    
    Thanks, -Kyle
    
    Changes since v1:
    
     * changed the commit message
     * modified and added missing \n to push.txt
     * used test_subcommand for test
     * modified "if" statement for "git_config_get_bool()" in send-pack.c
    
    Changes since v2:
    
     * enable 'push.useBitmaps" by default
     * fix nit in t/t5516-fetch-push.sh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1263%2Fkeyu98%2Fkz%2Fpush-usebitmps-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1263/keyu98/kz/push-usebitmps-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1263

Range-diff vs v2:

 1:  42e0b4845b2 ! 1:  a523cb52542 send-pack.c: add config push.useBitmaps
     @@ Metadata
       ## Commit message ##
          send-pack.c: add config push.useBitmaps
      
     -    This allows you to disable bitmaps for "git push". Default is false.
     +    This allows you to disable bitmaps for "git push". Default is true.
      
          Reachability bitmaps are designed to speed up the "counting objects"
          phase of generating a pack during a clone or fetch. They are not
     @@ Documentation/config/push.txt: push.negotiate::
       	in common.
      +
      +push.useBitmaps::
     -+    If this config and `pack.useBitmaps` are both `true`, then Git will
     -+    use reachability bitmaps during `git push`, if available (disabled
     -+    by default).
     ++	If this config and `pack.useBitmaps` are both `true`, then Git will
     ++	use reachability bitmaps during `git push`, if available. If set to
     ++	`false`, may improve push performance without affecting use of the
     ++	reachability bitmaps for other operations. Default is true.
      
       ## send-pack.c ##
      @@ send-pack.c: static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
       		strvec_push(&po.args, "--progress");
       	if (is_repository_shallow(the_repository))
       		strvec_push(&po.args, "--shallow");
     -+	if (!args->use_bitmaps)
     ++	if (args->no_use_bitmaps)
      +		strvec_push(&po.args, "--no-use-bitmap-index");
       	po.in = -1;
       	po.out = args->stateless_rpc ? -1 : fd;
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
       		get_commons_through_negotiation(args->url, remote_refs, &commons);
       
      +	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
     -+		args->use_bitmaps = use_bitmaps;
     ++		args->no_use_bitmaps = !use_bitmaps;
      +
       	git_config_get_bool("transfer.advertisesid", &advertise_sid);
       
     @@ send-pack.h: struct send_pack_args {
       		stateless_rpc:1,
      -		atomic:1;
      +		atomic:1,
     -+		use_bitmaps:1;
     ++		no_use_bitmaps:1;
       	const struct string_list *push_options;
       };
       
     @@ t/t5516-fetch-push.sh: test_expect_success 'push warns or fails when using usern
      +	GIT_TRACE2_EVENT="$PWD/default" \
      +	git push testrepo main:test &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     -+	--thin --delta-base-offset -q --no-use-bitmap-index <default &&
     ++		--thin --delta-base-offset -q <default &&
      +
      +	git config push.useBitmaps true &&
      +	GIT_TRACE2_EVENT="$PWD/true" \
      +	git push testrepo main:test2 &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     -+	--thin --delta-base-offset -q <true &&
     ++		--thin --delta-base-offset -q <true &&
      +
      +	git config push.useBitmaps false &&
      +	GIT_TRACE2_EVENT="$PWD/false" \
      +	git push testrepo main:test3 &&
      +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
     -+	--thin --delta-base-offset -q --no-use-bitmap-index <false
     ++		--thin --delta-base-offset -q --no-use-bitmap-index <false
      +'
      +
       test_done


 Documentation/config/push.txt |  6 ++++++
 send-pack.c                   |  6 ++++++
 send-pack.h                   |  3 ++-
 t/t5516-fetch-push.sh         | 21 +++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index e32801e6c91..f16ac9311db 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -137,3 +137,9 @@ push.negotiate::
 	server attempt to find commits in common. If "false", Git will
 	rely solely on the server's ref advertisement to find commits
 	in common.
+
+push.useBitmaps::
+	If this config and `pack.useBitmaps` are both `true`, then Git will
+	use reachability bitmaps during `git push`, if available. If set to
+	`false`, may improve push performance without affecting use of the
+	reachability bitmaps for other operations. Default is true.
diff --git a/send-pack.c b/send-pack.c
index bc0fcdbb000..d18cde850ef 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		strvec_push(&po.args, "--progress");
 	if (is_repository_shallow(the_repository))
 		strvec_push(&po.args, "--shallow");
+	if (args->no_use_bitmaps)
+		strvec_push(&po.args, "--no-use-bitmap-index");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
@@ -487,6 +489,7 @@ int send_pack(struct send_pack_args *args,
 	struct async demux;
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
+	int use_bitmaps;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -498,6 +501,9 @@ int send_pack(struct send_pack_args *args,
 	if (push_negotiate)
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
 
+	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
+		args->no_use_bitmaps = !use_bitmaps;
+
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
 	/* Does the other end support the reporting? */
diff --git a/send-pack.h b/send-pack.h
index e148fcd9609..d5d6ff589d9 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -26,7 +26,8 @@ struct send_pack_args {
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert:2,
 		stateless_rpc:1,
-		atomic:1;
+		atomic:1,
+		no_use_bitmaps:1;
 	const struct string_list *push_options;
 };
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..ffda830ba22 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1865,4 +1865,25 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success 'push with config push.useBitmaps' '
+	mk_test testrepo heads/main &&
+	git checkout main &&
+	GIT_TRACE2_EVENT="$PWD/default" \
+	git push testrepo main:test &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q <default &&
+
+	git config push.useBitmaps true &&
+	GIT_TRACE2_EVENT="$PWD/true" \
+	git push testrepo main:test2 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q <true &&
+
+	git config push.useBitmaps false &&
+	GIT_TRACE2_EVENT="$PWD/false" \
+	git push testrepo main:test3 &&
+	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
+		--thin --delta-base-offset -q --no-use-bitmap-index <false
+'
+
 test_done

base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
-- 
gitgitgadget
