Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D761F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK2Izx (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:55:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK2Izw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:55:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so10827316pfc.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zZ9nr1QxhlCmO0WSNTrayxRVNtZOVqbsuZPmA2tKoRM=;
        b=i1b47fyxHF9ibHpBzf2cXKHIrcLsqI4RwfQEvKwCvocWf+x8t/i2ylAZbyiOYPn+US
         6kwMVnV5Mp58PZ6NFcRqYUe5GDoUMiJMHCOM2gXAld/QIImdJV8AhRaXadQtoGgSAtAV
         VT/8m8VFN2fduqtQ4afKbxose/PW2Wc2wliPVYhBgVt1FXAYqvqDsof4Ny0EkPW5WwYB
         xP/7FoXNSg0Fqi1M5s8TbvVHHmzF0t+6AbKm/o+wgdhdWxJywQ01rzJrublb4N8MHBWy
         CfElMZp3aqlUQMS2DPfBhLAlZIWX3fMF9Uk3+GMwdAcViczxZHgGTbgoTZFZmmHAIJRv
         fMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zZ9nr1QxhlCmO0WSNTrayxRVNtZOVqbsuZPmA2tKoRM=;
        b=dv6HZw6d0QblPsTyef+ef4IYoBXc5PHhyfLcjTDlConMZV4pQYx3HTtVaIv3Obbq2A
         iu3V6POjCJ5D4dyBkHifD8BrVorPxjY3Ae9xVjETseowGFxRo3cJV2nAD/2taoxglMVt
         mKfRzfp8wzRA7vKmMIqXnuW8f6YmOrLg6tUhjE+eYzPHVcxlQ0Ronch6i4lJxDjtAosI
         ERu5iLRf9MC6sMmN59UL6jMdT6UJXIz4wjptgUIdXaPvUYl3e0JneeupX9jPfzJ6FXT+
         y/iPXCbrXqu/YyJaptNVQ2d59AnV+P8k2bABwpGpSlImfpQS8MLctOEGMQ/Yi3ixpd/X
         DXtw==
X-Gm-Message-State: AGRZ1gLHGFOJB3bsDIkgcy+rWDsRpvaaaD3vOwsZhNO6bcXEGALvVOU0
        zu1d2Q1/P8Z7GhCr+nq6ZxfTXriO
X-Google-Smtp-Source: AJdET5f+R/S2HSDJKAzdOyu4mE7JHnoC/htGVQtyCJJNpzsWjTYwNz514GZi15mPxDQ1b5ri3FePVQ==
X-Received: by 2002:a62:434d:: with SMTP id q74-v6mr39558773pfa.242.1543441968730;
        Wed, 28 Nov 2018 13:52:48 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p2sm8495941pgc.94.2018.11.28.13.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:52:48 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:52:48 -0800 (PST)
X-Google-Original-Date: Wed, 28 Nov 2018 21:52:39 GMT
Message-Id: <bbc3f7818293f5bc4db30ed2b4c60fd67ae2ca1f.1543441960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] pack-objects: create pack.useSparse setting
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
