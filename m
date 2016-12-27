Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4B220441
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755353AbcL0QXU (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36044 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755269AbcL0QXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id n5so12846708pgh.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ICdFF/M23eEYK0wkoYeMMwETs3aBi8qOp7AwR0gyOk=;
        b=Afxmm1g0XTNpItUxKkipC8372InToxzAccOhKh97dqaFYJ+m59oSPo+45vBpAlYy9p
         F+iPHrJp9+c8wcMKaoIm/uTBNTdiYh3T4W7dnXInHYfovJNgGDxyDKffDGoEM/bt7S8/
         Xx0K8vsp2haQkkB2bklEZa2qwSJw7UBmIp2EwsKLpbP8RVcA8WuxA/TND3rCLNiTqnGH
         v+FsNmxj7fQVOKjBBcFprmlxyDA55KXNiSHDNqE1Lysw4eYkVKay4aSEMnu4zKNWeM1x
         q6TnLrzTNi6aPOZ52O1R/JbBDBSBDGMMHypCKdl9FPy+AnDjOZ0EP7yhcateM2yikRIX
         acCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ICdFF/M23eEYK0wkoYeMMwETs3aBi8qOp7AwR0gyOk=;
        b=nlF8uWuiv6Zi9DxMeZsIRqLJVkk8n+yRLQNba45qTramgQrrIC3jRFjaBIaOkm5LTR
         vkK02GQtgUqb0FZvzdhZLjnU78Jp1Jbi1UHww45JgpEhXSAs/0onA23L+h2A6E1odCn3
         qNttagkMsa2yVeNktkNfOhPnnUNd+1aytIrcHlmDX6KHReq5inARH/sb5zUV1cmdWrtv
         t/I2bwvSFhN3RMa4zB3sOLF49QY/JAYrk7fEyk+qFyVuLFhKZibX8EA6xo6xY6cg+Ygh
         M8ApzjYwK5my8b5Mekb65DZX2Z8wTnD7JUAzBO3eRBNZWjlbI8DkvWUiDjhp4Fd3hkro
         wVBQ==
X-Gm-Message-State: AIkVDXJSlas/Itb1ynR3UmlNrKhVlu1ahKsFrP5GNcH2pLAaczHVGz5gXGeithuhHo6Emg==
X-Received: by 10.98.7.151 with SMTP id 23mr30490987pfh.5.1482855796315;
        Tue, 27 Dec 2016 08:23:16 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:15 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 02/20] ref-filter: include reference to 'used_atom' within 'atom_value'
Date:   Tue, 27 Dec 2016 21:53:39 +0530
Message-Id: <20161227162357.28212-3-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Ensure that each 'atom_value' has a reference to its corresponding
'used_atom'. This let's us use values within 'used_atom' in the
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
index 0a57872..f31c4b6 100644
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
2.10.2

