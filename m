Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627FE1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbeKFEmU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeKFEmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so9117689lji.7
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnYWc5zwuti8CEyNhFPtqk7nCTJ7E2m/CvY6Hlsk03k=;
        b=C61vnUgtF8dh4qG16B5/SjKW4CbrBY7/ZmBwAEbBCRIWn5u8uXNEbuTFHMs1s53u4k
         5YeBDjAQf5Xh4ftDEq98gGCY0onMNBH0hllCD6Z0+pPhq+bv45WSAWdHQ6tjihjRVNue
         W84LRG8cZBL64KbOq5QCkegmmtsBygtZIMH/mUi3tpf8WyFUCWNR1YPpKBKbZ29M92mh
         xL5mje6mpXWXHWLfkcDXGreDwEhA3kLkLUlrtPjwhL3XM5JsRHdpdJrwW8qI3BIDNYvY
         eTSXwqmu2S7/kIrPHaczpJ5wtrLknjqIyj6mh3UACbKAap3W1mD+WcvhpksYnvjwU42m
         JZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnYWc5zwuti8CEyNhFPtqk7nCTJ7E2m/CvY6Hlsk03k=;
        b=mhcvjJ17CY97/ff5E/yUqct9GZl1uAL/87ag7E5xDiW+nP7dhbEvwXsI+ntC9GTgpa
         ShPRLx2eCrY0unK7NyBPj8E6Ob0KKt2Y9YHFvBJzFRxU10/3BqRY2YZWN8IDHhexzfIT
         y9CRBiyEvywNLGOBaMZQe6Fm+yIw0NO3rSfiD5HxwE6ziV3bVvhOPKSM7zq58bP3yjp9
         xRGCsLRSfFIGAwqUDkRZVOPoTBxiNDJ6JpnO4SPfbA5z5r6iW/ghA53hRQ2OroyInpBl
         QHlPpgckH2xVJaxT464QtYI33w0LjoLL+fFd9TeZQ5V0TrE9ypqY/hKVc22PuetRy0eh
         AybQ==
X-Gm-Message-State: AGRZ1gL0ToVnPXcUrrIgO3RW4Q+6YcGKEtOZdkU8r+M1ooI9bpUdMzvd
        LDIysvFjfIy2P1uDFrgqngobgYW8
X-Google-Smtp-Source: AJdET5ex0HRp09NMX8ShWtfzwzBdfGBlkIxuyo/mxC9gNEarECQuk2+lP5IEhE2gZSkYOP2oVtlOFQ==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr12893705lje.115.1541445669228;
        Mon, 05 Nov 2018 11:21:09 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:08 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/16] archive.c: mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:46 +0100
Message-Id: <20181105192059.20303-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
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
2.19.1.1005.gac84295441

