Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B1F1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeKJPXc (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:23:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33685 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKJPXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:23:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so3384325ljd.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca1xoImJksMtB7vKPj0M7/OEb9ORCFbH9k8Y3MVP3lU=;
        b=bn4aBEp7Lj3ZGZmaC799CdI+a2jYg0A0XPrVqoWiJmbbloaHcE9/IBJY6T0e0hj+KE
         nPzNi3uY14T136LlRy7zSjtD60WWzw71HdXZ4H5Cq8AArBoie9GHFW1g/YJAukteBP1G
         XkRjicjtWjEwKLVYp6O3lFcRtp6vcKZ2XE/9NOerKWtR8rxHfyWddVGtbub9tiJWAigG
         MSplzjTYJxuMxLU46ieGPS1ECQTc7BJjNVOwfI6Vb4D856mvu2JbVkhdwojNX4iHDwS6
         7BW5FCgQa+KZaGYRRMCwfDopiEk7Y1nBtWVGk2hNC/ziLYMtfGAKZUXKIymnOTAPaykk
         uhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca1xoImJksMtB7vKPj0M7/OEb9ORCFbH9k8Y3MVP3lU=;
        b=I0ZvA3xjYycrTqBMPilDg/Q+W6w6U2WgkSn1jKgblJ+nlLTZidxoM4nZuJgLk5VCFl
         vzpCNLyVL0/qU2xHA/OkCPVkxjsQCbDNlJrhsRcSLCWorbkhBYC/fOnLKfNarv/G2+uY
         eUJgTctGcljxMt7O0EANKIMm5JlWrl6GMs1tz3FMytSVunAbetTksU0OjhLPZAO4an4w
         GiHveO2Y/t0CXl/Om0EGx62eAOPQLjITecGUFFSbEJ2VQKywGJXnz3bgBilBTuWwTfBF
         dWtaHZyja29ZNTbQMEbRLFi3Ntk/97jevbsI008as+qzJFPomX6EeTxOrfFbJwJphQsN
         cEzA==
X-Gm-Message-State: AGRZ1gI/0hT51SP9zlM9Cz4nhLNZEVZXSS1kWz9euQhmg8JjvtFWa7Qd
        f4wpy2WcV1RqvRRmHjOdW44=
X-Google-Smtp-Source: AJdET5fsnJd9VJeKMKQAOLsNPFe9VAYoHZCrM8b8zOn36R9zwzfwKjLgdcJj5h9ByBU91mwb9yF4Kg==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr6934775lja.37.1541826985737;
        Fri, 09 Nov 2018 21:16:25 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 03/16] archive.c: mark more strings for translation
Date:   Sat, 10 Nov 2018 06:16:02 +0100
Message-Id: <20181110051615.8641-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two messages also print extra information to be more useful

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index 9d16b7fadf..d8f6e1ce30 100644
--- a/archive.c
+++ b/archive.c
@@ -385,12 +385,12 @@ static void parse_treeish_arg(const char **argv,
 		int refnamelen = colon - name;
 
 		if (!dwim_ref(name, refnamelen, &oid, &ref))
-			die("no such ref: %.*s", refnamelen, name);
+			die(_("no such ref: %.*s"), refnamelen, name);
 		free(ref);
 	}
 
 	if (get_oid(name, &oid))
-		die("Not a valid object name");
+		die(_("not a valid object name: %s"), name);
 
 	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
@@ -403,7 +403,7 @@ static void parse_treeish_arg(const char **argv,
 
 	tree = parse_tree_indirect(&oid);
 	if (tree == NULL)
-		die("not a tree object");
+		die(_("not a tree object: %s"), oid_to_hex(&oid));
 
 	if (prefix) {
 		struct object_id tree_oid;
@@ -413,7 +413,7 @@ static void parse_treeish_arg(const char **argv,
 		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
 				     &mode);
 		if (err || !S_ISDIR(mode))
-			die("current working directory is untracked");
+			die(_("current working directory is untracked"));
 
 		tree = parse_tree_indirect(&tree_oid);
 	}
-- 
2.19.1.1231.g84aef82467

