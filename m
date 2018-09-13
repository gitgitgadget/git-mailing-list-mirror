Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF2C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIMXMu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40769 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIMXMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so2938897plp.7
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lc4TLkm1hGb1dmiFnB5R9pnfNtsNlsha0zbwJfhV358=;
        b=SrnGJCZizY0icWFhdot0D6t9POLNafWrXgmdTqmUTb3LryJ/aHOJ12QOEQHraa32cX
         uJ3FQow2/e2yuvY0NAvmJvAOOk8H755kg6BXI1s1RTYqiWm0QkfVOfdIZi8TPudLzD8M
         O0MOuh45/wDioKrYsYnf0DbmZmuphdKu9DDaeL1wrYYp3nDGWp4IjAGXeC6rvxGrnTv4
         3naYISxxnhf9UnEtWzA1NeNprTPRstgcG4IhXrj42IEYsEeSU8p/cLyeYZ1MEP0QnLYs
         HZaA3yjlvMCt6uhOKa56bE5IAn+/JT4sXeRvVWuq3wePKPPbvrhikp7ak+N3U5QdfzJ8
         ZY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lc4TLkm1hGb1dmiFnB5R9pnfNtsNlsha0zbwJfhV358=;
        b=WP4Wjruz6EKiWRxCTYF2jdsULtN4FjI21qjoltr3j16QvrPeB7k7Gyty9FRxIqHgUA
         vHwxnT5XW5xy+yhvhZIGYHyqQK3qcV0R0GlAkb8NiftQTi/vh71hCPAibEbJeazQNniC
         6r13Zn/wISMObWd2YamYsP8yrLWw3ahJor7C182CKFcli/VgFjMCfHoU8Hp/GiHdLrOT
         sDO4DlseHL7COOtE0enWv8xRt99BblEhOSHRbqe3fF1Uxaf4kemMjZNJC7RuH4nst5uP
         CejZZm5N8w5i3UZTecawFJRF8FbFhewXJTbcu0NEcHUcZLLN+wMMCUl/2SgUU080wjxV
         WFng==
X-Gm-Message-State: APzg51Aglt4xeTP1U6iRqoAJceF721VrZuLbmHJ5u/KpZixarMKWiHQ3
        MCVF2arNFIdPRjAyRQUf1N6HQGK9
X-Google-Smtp-Source: ANB0VdarPbhvFruhyy57RwQaqFBCNy8hNKYFzSh/TxBTvXVCU669Q9vkdZI0KZDVb0pqNX51R83ynQ==
X-Received: by 2002:a17:902:274a:: with SMTP id j10-v6mr8492156plg.152.1536861734698;
        Thu, 13 Sep 2018 11:02:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id w81-v6sm9276466pfk.92.2018.09.13.11.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:13 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:13 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:00 GMT
Message-Id: <d8ffd84d67471e6fbb658beedf4491e12ca50311.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/11] multi-pack-index: add 'verify' verb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The multi-pack-index builtin writes multi-pack-index files, and
uses a 'write' verb to do so. Add a 'verify' verb that checks this
file matches the contents of the pack-indexes it replaces.

The current implementation is a no-op, but will be extended in
small increments in later commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 ++++++++++
 builtin/multi-pack-index.c             |  4 +++-
 midx.c                                 | 13 +++++++++++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            |  8 ++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 1f97e79912..f7778a2c85 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -27,6 +27,10 @@ write::
 	When given as the verb, write a new MIDX file to
 	`<dir>/packs/multi-pack-index`.
 
+verify::
+	When given as the verb, verify the contents of the MIDX file
+	at `<dir>/packs/multi-pack-index`.
+
 
 EXAMPLES
 --------
@@ -43,6 +47,12 @@ $ git multi-pack-index write
 $ git multi-pack-index --object-dir <alt> write
 -----------------------------------------------
 
+* Verify the MIDX file for the packfiles in the current .git folder.
++
+-----------------------------------------------
+$ git multi-pack-index verify
+-----------------------------------------------
+
 
 SEE ALSO
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2633efd95d..fca70f8e4f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] write"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
 	NULL
 };
 
@@ -42,6 +42,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
+	if (!strcmp(argv[0], "verify"))
+		return verify_midx_file(opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index f3e8dbc108..b253bed517 100644
--- a/midx.c
+++ b/midx.c
@@ -928,3 +928,16 @@ void clear_midx_file(const char *object_dir)
 
 	free(midx);
 }
+
+int verify_midx_error;
+
+int verify_midx_file(const char *object_dir)
+{
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	verify_midx_error = 0;
+
+	if (!m)
+		return 0;
+
+	return verify_midx_error;
+}
diff --git a/midx.h b/midx.h
index a210f1af2a..ce80b91c68 100644
--- a/midx.h
+++ b/midx.h
@@ -43,5 +43,6 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 
 int write_midx_file(const char *object_dir);
 void clear_midx_file(const char *object_dir);
+int verify_midx_file(const char *object_dir);
 
 #endif
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 6f56b38674..1c4e0e6d31 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -150,6 +150,10 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'verify multi-pack-index success' '
+	git multi-pack-index verify --object-dir=$objdir
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
@@ -214,4 +218,8 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	midx_read_expect 1 63 5 objects64 " large-offsets"
 '
 
+test_expect_success 'verify multi-pack-index with 64-bit offsets' '
+	git multi-pack-index verify --object-dir=objects64
+'
+
 test_done
-- 
gitgitgadget

