Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C351F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162563AbeBNTBv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:51 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:46478 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162545AbeBNTBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:47 -0500
Received: by mail-ot0-f201.google.com with SMTP id m10so13332077oth.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RPKzk/MLgffyYYtMeOPMcESc76DyoVyTT+SsJCumlRU=;
        b=iYt0YJjQdKGPM98gm1a7hodDP7ciAZROb6TqqiA0wyDd8EtvHYoTvtwUqjQQ8FHy6s
         7q9qoHj9N9CLUe4ZzDRplLa6r3SuuHdsGI1724r0ae0daedpW14VnVjJe52rJFRpGjWd
         w3UGmPjq4pyqThg4dDO9NUQXdmc+vGzGRvU9bcteBqP3SNo/4zstgfNyXya2ezNsjjiy
         l/wXh2I9RDXUAEBwhMNdoYU3BL3Nf0mBtjBgUgNU1kclIRAFwgLmhwxKrRErebGS743g
         DW/o9c+bHfW0hsUh7cJ6ldDr2HSdcutLajr1GSYcR12dEVxqNCw5KQqIvQw4IMX1fH7B
         Kojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RPKzk/MLgffyYYtMeOPMcESc76DyoVyTT+SsJCumlRU=;
        b=D5UBKi9Ucjdxsx9HiMewKcxTvCHajoG+oPJgcphZxqgh/5fyWG9kZ3Y1jj5Qi1NEt9
         CU1HqXzhRJVh+EOgXop1fXxCOSCuso1zLM0mwShc5o77WFDbnmxWSBSkcymg+/C47r0W
         nrkRPPIWG2lTFwqqVF7rAb2nGFKAx/Hq1ZDxiVAOjlDHnHReqB1bwj5ea/mYSvtLJWF3
         yZ50RQssdcWY8yxjhNAVyCzFj6o6b38v48HMU/WwpS7pn8wgOM0mBtD00ezZLfyUTznc
         Rg6KqsJcWpd+p6IW007l6jPTHwG81+ubMbq9Y2k8fHdhrqHTB03eQO3vgZQ8GHKOoEdh
         zhJw==
X-Gm-Message-State: APf1xPBGYjZMbhTNcu2/DFyKhgknubPhakHJN9KLQAC56EUmNGqjZ9wd
        CQqS+3hUdOBlSXEGSCpjaFgdRlF7zR7fhYez3WMMDLA7p24rtveHnHMhdCb4u+usrWX0IveelYS
        Tl1wOyfNI3Lr6fmxE8MtW2O7N4HhrURSz+18fV/gi8Mvvpo7Xd2UbLbwb3A==
X-Google-Smtp-Source: AH8x224HKrxhnKUcOtA8RvaJZamv33gqrr3UG+Jm1Mmk4gY+tWRHaEltDPWzmI5b7UMlGjzXexUPYP7i0EI=
MIME-Version: 1.0
X-Received: by 10.202.196.72 with SMTP id u69mr38049oif.106.1518634906781;
 Wed, 14 Feb 2018 11:01:46 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:46 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-25-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 24/37] ref-filter: rename 'new' variables
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
2.16.1.291.g4437f3f132-goog

