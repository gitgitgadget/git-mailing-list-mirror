Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10301F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEHANZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHANY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so24678103wra.3
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LakZ+D3Q2eUmeWJFCdmYTzwIWrPrQxCw3k/TrLB/N8c=;
        b=XcuGVuOgVQW4cPMbFX3Kh+JDfXfNVzrNOIGYY7Ubhu37CxL6aNiDC5Pqhi9Hd2/xtD
         Gw8ZPJRfmD7Q0D9AwbSYy0Pv19B342RY+YxuhQzxOhLMJ4hRvbeFz1TbhsvOIXGCGLMn
         TocZ8+Q5cO5t03qWSpuLmDFcu7hgP81TiMiHWyKdrjl5XrX/nDuvCnP8xGoFD8BHip1P
         6c+3arLvH64bgzYY1aP7lTjh2sDZN3Q12YhOnaZguiY9n4XAdqC7TDsvLNkUtnnC8vy4
         E8E6JSyHx6RCE4BEV4EI7Gf8i2GfH5zxtuIad3wAN2yV5q3ZwTdC5I9+renXuJavrw5V
         pKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LakZ+D3Q2eUmeWJFCdmYTzwIWrPrQxCw3k/TrLB/N8c=;
        b=eT2uf2PhQg614rNl9ZYwnxEK3oE+0RxrRvkiQuzfPYgolC4MUY4qmWxBJiVeaiF2cQ
         3/9pPSqaoRFV9t+xeLEIKkYwSCDCcuhrERe0jBVYttbjLmbnLxPJx6rQ9bYX+K1N5PQq
         PJRXKBWzrUMB1+2hz5SRKGstMzDJAl7Cl7t8KjP+woTHka+X7PWrv4ETAqbNfiwIu4K7
         vEWTO0rm9jfXhZ360uHo4qAmVA/JEKAKSWGDS+eNLsxFU53kjzN1Tr+ioQRrgGxjz6WG
         q3kUJysMMiekNCfrZCr3389f/s6mV+oTjZ6FNy2S1sAin6fLEhl7C87FS75SVmnWCDL+
         HSCQ==
X-Gm-Message-State: APjAAAUHVuF954Splv77n/G3MB+ZCQZgUiOLkdd3SVWCvLdkQmanbclP
        lS8VhCIAMfDHo6efVNMJzHJys6zXeYU=
X-Google-Smtp-Source: APXvYqxj44v95W0H+IAkgQGsAQvW/dWb8x1ayNb/34HAZyb5AjTc7MgpDu3vRD2ujLJLFm6E1eg3AQ==
X-Received: by 2002:adf:e404:: with SMTP id g4mr936963wrm.161.1557274402484;
        Tue, 07 May 2019 17:13:22 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 11/13] rebase: eliminate side-effects from can_fast_forward()
Date:   Wed,  8 May 2019 02:12:50 +0200
Message-Id: <20190508001252.15752-12-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The can_fast_forward() function is potentially much more expensive
than is_interactive() since it e.g. might need to call
is_linear_history().

So reversing the two looks like an obvious improvement, but doing so
reveals a previously hidden caveat: We need the can_fast_forward()
function to populate data used later, namely the "merge_bases"
variable. This has been the case since it was added in
9a48a615b4 ("builtin rebase: try to fast forward when possible",
2018-09-04).

So let's refactor it into two functions. Now we'll always call
populate_merge_bases(), and then only call can_fast_forward() if
is_interactive() is false, making this both faster in pathological
cases, and more importantly easier to follow.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ae6b9b42b8..cb5d7fcb53 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -878,24 +878,30 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct commit *upstream,
+static void populate_merge_bases(struct commit *head, struct commit *onto,
+				 struct commit_list *merge_bases,
+				 struct object_id *merge_base)
+{
+	merge_bases = get_merge_bases(onto, head);
+	if (!merge_bases || merge_bases->next) {
+		oidcpy(merge_base, &null_oid);
+		return;
+	}
+	oidcpy(merge_base, &merge_bases->item->object.oid);
+}
+
+static int can_fast_forward(struct commit *head,
+			    struct commit *onto, struct commit *upstream,
 			    struct commit *restrict_revision,
-			    struct object_id *head_oid, struct object_id *merge_base)
+			    struct object_id *head_oid,
+			    struct commit_list *merge_bases,
+			    struct object_id *merge_base)
 {
-	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
 	if (!head)
 		goto done;
 
-	merge_bases = get_merge_bases(onto, head);
-	if (!merge_bases || merge_bases->next) {
-		oidcpy(merge_base, &null_oid);
-		goto done;
-	}
-
-	oidcpy(merge_base, &merge_bases->item->object.oid);
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
@@ -1154,6 +1160,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	int i;
+	struct commit *head_commit;
+	struct commit_list *merge_bases = NULL;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_rebase_usage,
@@ -1703,9 +1711,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * with new commits recreated by replaying their changes. This
 	 * optimization must not be done if this is an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    &options.orig_head, &merge_base) &&
-	    !is_interactive(&options)) {
+	head_commit = lookup_commit(the_repository, &options.orig_head);
+	if (head_commit)
+		populate_merge_bases(head_commit, options.onto, merge_bases,
+				     &merge_base);
+	if (!is_interactive(&options) &&
+	    can_fast_forward(head_commit, options.onto, options.upstream,
+			     options.restrict_revision, &options.orig_head,
+			     merge_bases, &merge_base)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
-- 
2.21.0.1020.gf2820cf01a

