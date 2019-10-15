Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A631F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfJON42 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbfJON4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so24019122wrd.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RpAQ8CkiTeX0a4BxWyRnHmJk9+q6ciw0GxRYhB2+/Wg=;
        b=mx1r4eYWRZ5l/lJ4Tq6rxjLaH00jJsGtsOzjY9bi/yE8wBHU97zQE4T7R8BG4JAsKm
         4KiEKp7Lj0dq/BEBPu7b9F15IyYYM19CXIs74wNEk/76bQwVfG6AZbTg232xfBeXBYXe
         LmD67BEuytlaoK0gmF5oGNE+SvM+cPTw4AwMK+BjNC5gCHt21c1StIoyVAxvky7fqh+5
         sjSIgtibUZPUDWW5a/JlOQB4MzN7w1xJ20xG6hQdJ4h3WiAx/CNdMNx6N7GShX432ut6
         nk6iqc6dVGr5VaVEOOBgvcEkULBBB4MYVxZS5xqyveVu/zeVW1WQeueXchb5QwBfl42v
         LWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RpAQ8CkiTeX0a4BxWyRnHmJk9+q6ciw0GxRYhB2+/Wg=;
        b=YxgXLFNUoYsH3jL8AV5X96T/e6qf34MzpXhkA2ATtvvyYVFdp/IIFmxTOj73fA4/ND
         cg2KhlC1c2FseW5zrDHSMI+QIy7raTrNPTVormUfFmHuDp+iHuTf1a5UFod3RovkL2nk
         CzLiTd1FVR+PCKCdUn7FjUsZiBva/bNqdk6h4PriZrvdcKM/rQhz9C5gZcYRoe9PmqjK
         nDrbWCiJiqKvah7AwhSH+MadWCEJ6YtpzNLlEyzDHjlIYN1VVQtnB9vbsQaTYjw2sTq5
         AVNBakeY76UZAjkWOzgjCyuWXhXkqVny30Sc7HexCe0kzX4S7sXumxzQyIh2Ke7LX+4K
         X8VA==
X-Gm-Message-State: APjAAAXjaweLNW14ArMY2vJo3jdhCdq2TtiaOMUOuIrJ0nqFQEy1tbPP
        6HLftNVfE4vbTo6ha5pQin9oQeft
X-Google-Smtp-Source: APXvYqwOf5epbDsLYAokaXa7bQ2cgcXU7H3qMThGy7XYmVK0VeGGU5DYAcyzm/dU7Q95WiR9zKS10g==
X-Received: by 2002:adf:bd8f:: with SMTP id l15mr30265109wrh.362.1571147779509;
        Tue, 15 Oct 2019 06:56:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm31088077wro.44.2019.10.15.06.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:18 -0700 (PDT)
Message-Id: <44c30780290e31103d333b914b33882fc01b70ad.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:56:01 +0000
Subject: [PATCH v4 14/17] sparse-checkout: sanitize for nested folders
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a user provides folders A/ and A/B/ for inclusion in a cone-mode
sparse-checkout file, the parsing logic will notice that A/ appears
both as a "parent" type pattern and as a "recursive" type pattern.
This is unexpected and hence will complain via a warning and revert
to the old logic for checking sparse-checkout patterns.

Prevent this from happening accidentally by sanitizing the folders
for this type of inclusion in the 'git sparse-checkout' builtin.
This happens in two ways:

1. Do not include any parent patterns that also appear as recursive
   patterns.

2. Do not include any recursive patterns deeper than other recursive
   patterns.

In order to minimize duplicate code for scanning parents, create
hashmap_contains_parent() method. It takes a strbuf buffer to
avoid reallocating a buffer when calling in a tight loop.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 22 ++++++++++++++++++----
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95d9a90b84..40b6c599dc 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -212,9 +212,17 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct strbuf parent_pattern = STRBUF_INIT;
 
-	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
+		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
+			continue;
+
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
@@ -230,8 +238,14 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 
 	string_list_clear(&sl, 0);
 
-	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
+
+	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3a4c0e6f5d..e752f3ba0f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -236,4 +236,15 @@ test_expect_success 'cone mode: init and set' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: set with nested folders' '
+	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
+	test_line_count = 0 err &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+	EOF
+	test_cmp repo/.git/info/sparse-checkout expect
+'
+
 test_done
-- 
gitgitgadget

