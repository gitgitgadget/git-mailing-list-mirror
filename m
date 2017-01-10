Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B58420A93
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755838AbdAJIs5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:48:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35923 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbdAJIsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:48:54 -0500
Received: by mail-pf0-f195.google.com with SMTP id b22so11588876pfd.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACh3yeZ86q8YoYC4R6fuRT8WG6N39GPPtszWz4vu/TU=;
        b=fsSjc0JCbYzW87hNnGNLoKLAItDajCpDFHXKqVsOuO4fvf9d8Ti/k/Zi/MR3G4ozRb
         hWfoNGQExAMFk9oSqs9ofgJNfsICV2tM+Fmbj1+xz+OCz1jJiamVjlQXwLcG15YIcYc2
         9q9Nrn7FX/7TT2EKHewLWW8ODFyLN4Rxc3SCgK9QmTXoKkf3RcbCAoHtbio58LSEhwcl
         PAbxKTN/yv+c7/leo86sBcycx0UUrLg3tAb0s8ZlS401CpAURDpCwM3SmO/SyO3vyQU1
         pcGhFw/lD+E0OdbPekmUSfXf68tbG6oVg1LApCGMv+FhnKdls/JJ2LSSssos4QE3Zyow
         WwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ACh3yeZ86q8YoYC4R6fuRT8WG6N39GPPtszWz4vu/TU=;
        b=GJTkNGaTBXBtW84Bj7hWz1LfFIckzyBDcQ3/PTv4N/Wj3t5RVyBvljipCuKNzMgYd5
         ZLW2gVoNRN7z6DrUF9QY2UbjTNocNDq0472gLlsgEZO1ybAT5YL//37eyCBIkmx+yUG6
         cVF1JrLAoEr8k+cSjh8W61EilYv2ixL1K0QXPTbWwiCkR4o7LFh8svNc4tHjEhep3e43
         rAz76M4OhgndsjyrJcZc5cW/G5vOYsUR/XYd4jvcbKQHKcI3IB/OSvBtJXg0C6S09TTQ
         HcUEMc8r0NCp91Ny4SadyNG4LUrr0r4YyF3AJqgmEfeXNck+UllQec28ab/kC9CSvG1L
         O7wA==
X-Gm-Message-State: AIkVDXIaLwPUh7a8oJOOgiWNDJrlpMJBfkAoBYyc0SQkeB9PMSorRT3vPY+AJVFMSqcFhQ==
X-Received: by 10.99.53.195 with SMTP id c186mr2737214pga.24.1484038133366;
        Tue, 10 Jan 2017 00:48:53 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:48:52 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 02/20] ref-filter: include reference to 'used_atom' within 'atom_value'
Date:   Tue, 10 Jan 2017 14:19:35 +0530
Message-Id: <20170110084953.15890-3-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Ensure that each 'atom_value' has a reference to its corresponding
'used_atom'. This lets us use values within 'used_atom' in the
'handler' function.

Hence we can get the %(align) atom's parameters directly from the
'used_atom' therefore removing the necessity of passing %(align) atom's
parameters to 'atom_value'.

This also acts as a preparatory patch for the upcoming patch where we
introduce %(if:equals=) and %(if:notequals=).

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0a578722d..f31c4b68b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -241,11 +241,9 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	union {
-		struct align align;
-	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	struct used_atom *atom;
 };
 
 /*
@@ -381,7 +379,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->u.align;
+	new->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -1090,6 +1088,7 @@ static void populate_value(struct ref_array_item *ref)
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
+		v->atom = atom;
 
 		if (*name == '*') {
 			deref = 1;
@@ -1154,7 +1153,6 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (starts_with(name, "align")) {
-			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.11.0

