Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A383A20281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdJENWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:22:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37816 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdJENWr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:22:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id v38so6612047wrc.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=UjycH0+fMDqy3HGvWA21ddrjuC3BnXbUIIB34vknYmo=;
        b=iU60nOtsgv0srcVLGadOS5rJZG/Aw5fc9yfZQN7CwYRyt4DOl4L0lyyXV/LQDQfBhn
         bMa3oOPeGH+M28ZtPlxUMHger8bnCwZLRDU8crgNzZoDv+rWgseI6jRAjeufmO/r950I
         ee5Dx7Nv2x5xvJ2XXiPnrz7FM4RHpZIqsjl7y9PiMCyxwiWJSgFM5noVoBH1w5wPPl58
         wkIFLT3v5eI9v+2FMbRIN88n5YgJtj5G0l9ArkauNJRz1ysvCbCboQT3VrGKTbEFOy+5
         XhZfY1bilbvIfAtiTfba6oVLlPB/4TxircZY4T91eWHZ+RQLKSn8bed/wpRXOLJTZFKC
         xwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=UjycH0+fMDqy3HGvWA21ddrjuC3BnXbUIIB34vknYmo=;
        b=tLBx8Vh9HEKl/S0cLYa4yiboyCUhRrHE4MYU5BYtcBtg5Rk2krhJeMFAY7ciXN/zPg
         Bdd75DC3ZoocU3LxgKYWHHQUoPgK0MfzPugk6uZ2taFh9PiCfq/dSqYwowy3ZstB41gc
         aaUpUBYhg6DXZLFsT3htav1CLW7/ervkdWf/ERUVRVB9lCHCUm2cwKQMyBRo64G5loaq
         MX5vl1Bfp2w8pQVSVEy08pAfa5d+2m8rnXgENTh1ia7Zk86WJPBSYYy0hcKMReE4fuAS
         Plu9Dq8jN4+w8tmfJV2CmSkgyr5l8+2/DedXs5uhatdrFTV1MjEN+B3piP3Sl3wqR3me
         SpoA==
X-Gm-Message-State: AHPjjUiRTIPAc0zrSLmsP6Fr8i/rLkTbe1LbEz0k5z4df8jGljEbnM6m
        YLpfodYQO705mJ0ddeBn89INuOEL
X-Google-Smtp-Source: AOwi7QB9XFmDWPEvPkQVGxqxWPmFHUh+QnEC4FqWEhzFyvtJT6z+K6pTiIayKXr9l7VVJuJB9p71rQ==
X-Received: by 10.223.174.150 with SMTP id y22mr24611708wrc.29.1507209766425;
        Thu, 05 Oct 2017 06:22:46 -0700 (PDT)
Received: from donizetti.redhat.com (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.gmail.com with ESMTPSA id r15sm10864439wrc.30.2017.10.05.06.22.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 06:22:45 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] trailer: push free_arg_item up
Date:   Thu,  5 Oct 2017 15:22:40 +0200
Message-Id: <20171005132243.27058-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callees of process_trailers_lists are calling free_arg_item.
Just do it in process_trailers_lists itself.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trailer.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3ba157ed0..4ba28ae33 100644
--- a/trailer.c
+++ b/trailer.c
@@ -178,7 +178,6 @@ static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 	new->token = arg_tok->token;
 	new->value = arg_tok->value;
 	arg_tok->token = arg_tok->value = NULL;
-	free_arg_item(arg_tok);
 	return new;
 }
 
@@ -271,7 +270,6 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
-		free_arg_item(arg_tok);
 		break;
 	case EXISTS_REPLACE:
 		apply_item_command(in_tok, arg_tok);
@@ -287,15 +285,11 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(in_tok, arg_tok, 1, head))
 			add_arg_to_input_list(on_tok, arg_tok);
-		else
-			free_arg_item(arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
 		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(on_tok, arg_tok, 0, head))
 			add_arg_to_input_list(on_tok, arg_tok);
-		else
-			free_arg_item(arg_tok);
 		break;
 	default:
 		die("BUG: trailer.c: unhandled value %d",
@@ -311,7 +305,6 @@ static void apply_arg_if_missing(struct list_head *head,
 
 	switch (arg_tok->conf.if_missing) {
 	case MISSING_DO_NOTHING:
-		free_arg_item(arg_tok);
 		break;
 	case MISSING_ADD:
 		where = arg_tok->conf.where;
@@ -374,6 +367,8 @@ static void process_trailers_lists(struct list_head *head,
 
 		if (!applied)
 			apply_arg_if_missing(head, arg_tok);
+
+		free_arg_item(arg_tok);
 	}
 }
 
-- 
2.14.2


