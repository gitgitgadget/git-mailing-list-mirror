Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A77E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeA2Wil (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:41 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:50887 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeA2Wih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:37 -0500
Received: by mail-oi0-f73.google.com with SMTP id p188so1750867oig.17
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PPonEvXwfDx5Q1myKUyqbodqfUOqXaLWdHTgq+HGaXg=;
        b=S4o2mvRBmbwIusfvAJrdiZs8Y5nOJTZ6+V/evnQalXqoV43w9Mrr+TeuSTZVzF48Qt
         WRalzGNIUPPYBRYp8ALOexJUc6jjg48ZhBNdo3Oxp0PrCGfvVhfv/NV5MG3WLJyz828o
         FNyZY7zDz2s0x7VDSN3yfO71gUqlANmPaslz8fzHrGadRr9oA1w51kbsHru3jmqOAkxw
         4jS33lKEFFmvkm4WaGJLOURvjthP4U8krw306Z3qbE/NpVQjHQyz3sgqQiu7DwQkyuCb
         mMSrEa1vrizjUyNRCjsTv3pUowymMbmACqtY4E8WguHuvaQmLQEnxietmGyJsWD6kWAt
         SF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PPonEvXwfDx5Q1myKUyqbodqfUOqXaLWdHTgq+HGaXg=;
        b=d6sk3BrQbpKIwLBUyMepCPvpGBhAy80DD4zaV++aVP3hWNPGgWHw7TtGOOTklIh8lR
         I1yv/jxXqg1OL4MYJmeCjjWG/ZWTytMRTRHLniNL40PV/ZHDlq5B7Gb7fbZSILUR0n/U
         hhA9xA7pgqqDoIUO0YHxZssKhERkJ87+QQrh3nqxofCcF9AdgU8J7OGEmrrD34Aw4H0D
         dfc9Fa/fJ/wXZG0EFcVJ+wHpFAstJcxUIDqAI9ra9IXeP8WJKdoTs/xHmBbSqJeRjSFb
         8I7pRfTE6EruS0fIaNup/IBemlveihcASAirJxl7dbugLI9+X5NpmNQEQZesTKOoJiKM
         fe4A==
X-Gm-Message-State: AKwxytd/W9mwe/gjKPMQSaFadQKOIQobVQOPcIKXD2XmjRC5XmRlcysM
        gRPIMruypH2ae7QRyoIQhYbCwoQDmPAlrJQvu/khpS2I4gBdjaw4oEjn4K4FPUMKwQeXLmFp+iT
        Nh6CvWgeFjZke9WvX2E8vQR4CkJfVzLEQjd7UUGr/FexDe6oVY4nCgJvJQA==
X-Google-Smtp-Source: AH8x224csMMPqTeyknN+LxHFiVZ+cXATzO8h4kHHE+vqVINp8M9GJBbHAPWi/ufzqNAiWACrY06wfUuN14s=
MIME-Version: 1.0
X-Received: by 10.157.46.174 with SMTP id w43mr6536522ota.35.1517265516865;
 Mon, 29 Jan 2018 14:38:36 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:15 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-25-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 24/37] ref-filter: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 ref-filter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9dae6cfe3..99a45beb1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -529,12 +529,12 @@ static void end_align_handler(struct ref_formatting_stack **stack)
 
 static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	struct ref_formatting_stack *new;
+	struct ref_formatting_stack *new_stack;
 
 	push_stack_element(&state->stack);
-	new = state->stack;
-	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->atom->u.align;
+	new_stack = state->stack;
+	new_stack->at_end = end_align_handler;
+	new_stack->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -574,16 +574,16 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 
 static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	struct ref_formatting_stack *new;
+	struct ref_formatting_stack *new_stack;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 
 	if_then_else->str = atomv->atom->u.if_then_else.str;
 	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
 
 	push_stack_element(&state->stack);
-	new = state->stack;
-	new->at_end = if_then_else_handler;
-	new->at_end_data = if_then_else;
+	new_stack = state->stack;
+	new_stack->at_end = if_then_else_handler;
+	new_stack->at_end_data = if_then_else;
 }
 
 static int is_empty(const char *s)
-- 
2.16.0.rc1.238.g530d649a79-goog

