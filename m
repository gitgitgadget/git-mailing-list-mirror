Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D734B211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbeK3B5B (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:57:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44469 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbeK3B3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so991838pgr.11
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zZ9nr1QxhlCmO0WSNTrayxRVNtZOVqbsuZPmA2tKoRM=;
        b=uu25MKto7of1ZqXjDLVX2KJyC3izfxKJzA0HRTsZbdIJMKnLKn1AFeeTULVUAPFEK6
         5mgWzNihSmBYxa9LJHlePx3yw6kKskV1OC5PnGfmKcwtdtFBUm1NEMOcQXyAbQgHSWzj
         36sFD3rpuVy9GG+BT2YY+DgwDE19xO1N6pZ63mnL4La/SQiCRL7xsp24da8QnvD/gocV
         3UpzKKGMV6WUB+wEDtX5VOiCxQUzhCfrIx2eZ4eW5ZMiaY6w6+uIP9WIbAMvgB+XS2ss
         VrnVO2CaIQbszusI+MBoh13us/5r0+vZW9hBXNIrYudfbQD0tJ6pXH1e1oaeh8Autyma
         QBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zZ9nr1QxhlCmO0WSNTrayxRVNtZOVqbsuZPmA2tKoRM=;
        b=g7F4TppBignsfHGsWuYmwmlv4aL0FzMbkd2VpE6j6/ktH6rY4Bn9tsgrq57vPxP+gI
         8nZ8AUFp9LJIMB8wOtfnNedwHo6bkP5CdAp2q1kfTbKpQO9r1Sd6POK9ay0waiAayUhF
         T05QCA934Jt/+XJmxEmKPqR2Z0hMnX5RaVTI0NIIEshzkhfXdQucQf5YY40BtLj+XBXH
         mTsZ+PCVN7Mw5y0QGzkOldrLAF2MWoR3qVssc2lpN1afS9/ZG6yPfQdEoOXKurv8jsV2
         mTkbbd6apwd/+b/RFzaMjRB9hslwnOuWlNII2Raw30H9FvtQLomVQGAbL1+jPZOAjL7G
         yJ2w==
X-Gm-Message-State: AA+aEWaPfHxYwLfpIaEKQaWzp7kYeHruSzaxHtmqPBoFpq/AkAHNYQnq
        V6w9RvZ0lk3hOQgSrhjN7/e+0qxd
X-Google-Smtp-Source: AFSGD/X4pYzB7YTQob288tyWF2Gqj5DGsUexDIY/zX6dMfR/Y3R6tJx89VpFFA8syEIRqeAyo+dklA==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr1566753pfc.185.1543501448156;
        Thu, 29 Nov 2018 06:24:08 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 12sm2113883pgd.35.2018.11.29.06.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:07 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:07 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:57 GMT
Message-Id: <d6912188bee43f2558b7b42395e8687073d50720.1543501438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
        <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/6] pack-objects: create pack.useSparse setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The '--sparse' flag in 'git pack-objects' changes the algorithm
used to enumerate objects to one that is faster for individual
users pushing new objects that change only a small cone of the
working directory. The sparse algorithm is not recommended for a
server, which likely sends new objects that appear across the
entire working directory.

Create a 'pack.useSparse' setting that enables this new algorithm.
This allows 'git push' to use this algorithm without passing a
'--sparse' flag all the way through four levels of run_command()
calls.

If the '--no-sparse' flag is set, then this config setting is
overridden.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c         |  4 ++++
 t/t5322-pack-objects-sparse.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7d5b0735e3..124b1bafc4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2711,6 +2711,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.usesparse")) {
+		sparse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 45dba6e014..8f5699bd91 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -121,4 +121,19 @@ test_expect_success 'sparse pack-objects' '
 	test_cmp expect_sparse_objects.txt sparse_objects.txt
 '
 
+test_expect_success 'pack.useSparse enables algorithm' '
+	git config pack.useSparse true &&
+	git pack-objects --stdout --revs <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_sparse_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'pack.useSparse overridden' '
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
 test_done
-- 
gitgitgadget

