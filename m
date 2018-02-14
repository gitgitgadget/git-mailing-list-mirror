Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9010C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162573AbeBNTB7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:59 -0500
Received: from mail-vk0-f73.google.com ([209.85.213.73]:40422 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162570AbeBNTB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:58 -0500
Received: by mail-vk0-f73.google.com with SMTP id w3so3156381vkh.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=onohdc6uHfUjZlItxGGjGGRdTE3VLfXSDw7siXFl3w8=;
        b=OyJ9fgKE87n0iMg19AXPUs5TIWu/sbJkx8M/lLIV9IrWK/OSjJwRPXjvjEn7FLFPMi
         QmVW0iXhzHZZBPxxzYC8KJos2kTostBfdrbJzdsBQ4hmhXdi74wdPpn8XMSQCKOOq/1Z
         q+EbOWZYL9z/Ez9S3KKtuQkNK3ndnQdu9isyk2Kkz5CA43aUT0dBZkY1G1YK+E5QvmFa
         rTTeBSy/lmuyRMvKeCxbWx1GVITefFrLvy9uw80ymoIeSkMoAcQe/qY0LazZ7tnyBFCA
         i0W8bdY/M5lWdWIEzbaRzzqM2q6kXbJI2dhlG1jyM/1a8FPXUFev9OvgeiXFYvn+bUAm
         642g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=onohdc6uHfUjZlItxGGjGGRdTE3VLfXSDw7siXFl3w8=;
        b=EioyDoh1uK/LzUbiZhjq388arvKsDBDbO+yADaZ8uPOTY5KUSGqzNOfhqAXtqWY8E0
         H0fpzwpBs/8x5csX7eoZPSj3ucfhdvouUSDJzvWMmMI+VDZO/oy+KEjN2pTw7AbDpHAS
         rFzf7y8586/aGZaNQj+Mj9DnxFl4My6md17OI66LTei64VS9tyrVdws5nEwjtTSDEGoj
         yvUfih705zHIaqTqFgegUpUgeNZKKLj1iVwkVBxELKIPIECYdm+eauH0HIUfelrI9Blc
         I7Z2Nihcj8140uBiUSmGxuqf0vgA6nqRDIz07uMHklk19upEfWJ5AMcWqtwguIlsChz/
         SA/g==
X-Gm-Message-State: APf1xPDT4X45HWWaAn2Kn3SB/HacYbyjgfzhz1thMwXKIFKM5+TR0sgy
        XjxEfG3Vt3kjpVoAhIbe7oEofibTJ+/kEK6KHsNhcDNpDH0E3IMFxuxlj8dJf5HyAsd5/HbWcs+
        6E3AHpSSaW21wN0b8Tj8vG3tqnFEcskof/+rbTvZOrEItVjO7YNb4b2s8Sg==
X-Google-Smtp-Source: AH8x226oMELcSMJI9QA/DxK5FpfqHUDUP37PK83F2y6MS3zESCWof1Yw0RSx9Mqab4BRuFnMAJqylKhOkfc=
MIME-Version: 1.0
X-Received: by 10.159.45.134 with SMTP id v6mr2667031uaj.60.1518634917379;
 Wed, 14 Feb 2018 11:01:57 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:50 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-29-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 28/37] trailer: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 trailer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3ba157ed0..5a4a2ecf9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -174,12 +174,12 @@ static void print_all(FILE *outfile, struct list_head *head,
 
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->token = arg_tok->token;
-	new->value = arg_tok->value;
+	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = arg_tok->token;
+	new_item->value = arg_tok->value;
 	arg_tok->token = arg_tok->value = NULL;
 	free_arg_item(arg_tok);
-	return new;
+	return new_item;
 }
 
 static void add_arg_to_input_list(struct trailer_item *on_tok,
@@ -666,30 +666,30 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 					     char *val)
 {
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->token = tok;
-	new->value = val;
-	list_add_tail(&new->list, head);
-	return new;
+	struct trailer_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = tok;
+	new_item->value = val;
+	list_add_tail(&new_item->list, head);
+	return new_item;
 }
 
 static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 			 const struct conf_info *conf,
 			 const struct new_trailer_item *new_trailer_item)
 {
-	struct arg_item *new = xcalloc(sizeof(*new), 1);
-	new->token = tok;
-	new->value = val;
-	duplicate_conf(&new->conf, conf);
+	struct arg_item *new_item = xcalloc(sizeof(*new_item), 1);
+	new_item->token = tok;
+	new_item->value = val;
+	duplicate_conf(&new_item->conf, conf);
 	if (new_trailer_item) {
 		if (new_trailer_item->where != WHERE_DEFAULT)
-			new->conf.where = new_trailer_item->where;
+			new_item->conf.where = new_trailer_item->where;
 		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
-			new->conf.if_exists = new_trailer_item->if_exists;
+			new_item->conf.if_exists = new_trailer_item->if_exists;
 		if (new_trailer_item->if_missing != MISSING_DEFAULT)
-			new->conf.if_missing = new_trailer_item->if_missing;
+			new_item->conf.if_missing = new_trailer_item->if_missing;
 	}
-	list_add_tail(&new->list, arg_head);
+	list_add_tail(&new_item->list, arg_head);
 }
 
 static void process_command_line_args(struct list_head *arg_head,
-- 
2.16.1.291.g4437f3f132-goog

