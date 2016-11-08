Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B559B2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbcKHUMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:17 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36291 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcKHUMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:14 -0500
Received: by mail-pf0-f193.google.com with SMTP id n85so20692080pfi.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xo/kkBzc1exMQydcePcddZ/tfzjbeb/shpn5QczwKZE=;
        b=zEUvkDIizQUh6jenHVynVUdhPxsmF9BElP4Pj+xeLSp5B5X6Ui5wxnCPhQTsQxahcw
         4AsvbCV+3HScJwvh931qiUyXT96rCRmiQk/h/lxhtjJZ/TI634Ctm/bD18nNQx/I3ve/
         4F0YVOYNnPGjHZd+nObYmrJnPd9WSK54MOvvSvzyM18ra3D3iP5LAjdWxC5bRUz/tJne
         zwRpwHgE+2FcAvbq0drpVa4nSjFyJF8BMgiFnZJiS+VQvNr68N8ckN1ewGcsjNSZraRa
         AjWbZJdDr1grLkgU9WhI9nLbm9GUdaR19j9McVGga1uG2Aa3HaSOT0Gmpnh9CMLq2Qka
         Lx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xo/kkBzc1exMQydcePcddZ/tfzjbeb/shpn5QczwKZE=;
        b=c/dfzX2ZQx95AWA3ZyVLgIC38jZtJCd1SIieRQAAtwhfB6RnXZ43vRy4Z0VXAehaYy
         mBC5Mx8decLJXXXva2hr22TUQa+awJe8AsYYELRctISwGDZXbYqSi16XFmngJMHGP9O0
         re3ozFDTrsSUFEiEOQh9J7ld5dvlyhHvHNgfxLIervz4fSuykSL6Y8Eh7fJxMcmfpI7O
         W2QzGXFoawdcIDbzbSKHdg3X9eNZ+rGK8qWDjB2zEd9sycBIRB02B1Dyyf/QPSMTh5V4
         lIwcsNWPKz5yGeHZcFXzmCLAx8s7JNqnBoSw2Z3rW6soNqKFDbtk91sCZO50KQEwJLrM
         NSxw==
X-Gm-Message-State: ABUngve7OrcPcGexmLqfX6p3qhlpvF7kz0mpSrn6AR3XFlcll5YcpVnzsBj52jxP6bxLKQ==
X-Received: by 10.98.202.72 with SMTP id n69mr26499866pfg.24.1478635933536;
        Tue, 08 Nov 2016 12:12:13 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:13 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v7 02/17] ref-filter: include reference to 'used_atom' within 'atom_value'
Date:   Wed,  9 Nov 2016 01:41:56 +0530
Message-Id: <20161108201211.25213-3-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
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
index 8c183a0..8392303 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -230,11 +230,9 @@ struct ref_formatting_state {
 
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
@@ -370,7 +368,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->u.align;
+	new->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -1069,6 +1067,7 @@ static void populate_value(struct ref_array_item *ref)
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
+		v->atom = atom;
 
 		if (*name == '*') {
 			deref = 1;
@@ -1133,7 +1132,6 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (starts_with(name, "align")) {
-			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.10.2

