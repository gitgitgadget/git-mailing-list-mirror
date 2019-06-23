Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72FE1F4B6
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFWUGL (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43864 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so6236243pfg.10
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2YnootIIhA9uv0o1Ssl3c+SBORnr9RTrLZW7WXiV14=;
        b=sAiJb/FproAMxfzCNY57tDCvocv2+TWaVr6wjiHw9SrkA8XRwVS4/bctjm4WPAN+mV
         Dmyl2Cc5H0GrLj5Ew0s8TbuZ7/AB0obRGDzUckkHpDUFeSGXuL/lJXSg4MSQ/ctnTkIi
         rCuvVFeC05L0Ph3zzMvvNn0gGWChSaWGBwm2VbVW+b+XuatQlmXN0ELUSBNDqlmbMvtY
         ENeDbaEWxAIGmUh7sX3n/UkXu+nRWMcnKPTK+3eOrtlfsWNM68AVbAMl3qVhp/N0SW5e
         hCzNISA3LxJRDQInEpRI1fveAVi+URbZugiHsdq4C+5irCLwxX0QXLGxoblbL7Ng8hOJ
         r+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2YnootIIhA9uv0o1Ssl3c+SBORnr9RTrLZW7WXiV14=;
        b=Unj6CP7J8XJm+ylxVK3RX2KRpxeIhhXBoIs37aG3Mrg1pngTkKVQyCLLTEWkLxILib
         v6+ypSh3ylK4PeYmZmOrhnTPa1MBUMrG/s+8g3v3VQqWtLbiQq0zkWF52uubBBjNVjJW
         ezz0XhPLFcxjIX9ScxACKZZsbl1pHD+QF5Nh3by1e96kUVL4tnw5A+JkT7bIJsY50drO
         NXdxYniRmw4tNGSuzlqiVp8vmgyelGGw5dWBe2erNhklym1Vdl6KCv8dFRTs85Ervvb4
         bbmo5blNL88+IxvuOeVTxFsnPy6AUbyETA4vJckZIwwnoiV0jKcYir8YSwErFGxbQBqj
         ql1Q==
X-Gm-Message-State: APjAAAXDBiIab53QuCIiSMcONVyOoCke0Ih0+HJuhXXhwHyxxZs7+aGu
        /VMcittn2y2TnfFTICW5f44yJ3XFpyk=
X-Google-Smtp-Source: APXvYqzewOOYpXHr6TwfqBJp66qsDKCZ6T2tZ+yYdGsot5ugTkZoJJxsOzcq0UIv2gBWSPT4UV/sgQ==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr20125681pjb.138.1561320370070;
        Sun, 23 Jun 2019 13:06:10 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.06.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:06:09 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 3/6] sequencer: rename reset_for_rollback to reset_merge
Date:   Mon, 24 Jun 2019 01:33:35 +0530
Message-Id: <20190623200338.17144-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are on a path to teach cherry-pick/revert how to skip commits. To
achieve this, we could really make use of existing functions.
reset_for_rollback is one such function, but the name does not
intuitively suggest to use it to reset a merge, which it was born to
perform see 539047c ("revert: introduce --abort to cancel a failed
cherry-pick", 2011-11-23). Change the name to reset_merge to make
it more intuitive.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0ef2622a69..cb856bcfc3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2732,7 +2732,7 @@ static int rollback_is_safe(void)
 	return oideq(&actual_head, &expected_head);
 }
 
-static int reset_for_rollback(const struct object_id *oid)
+static int reset_merge(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
 
@@ -2754,7 +2754,7 @@ static int rollback_single_pick(struct repository *r)
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(&head_oid);
+	return reset_merge(&head_oid);
 }
 
 int sequencer_rollback(struct repository *r, struct replay_opts *opts)
@@ -2797,7 +2797,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 		warning(_("You seem to have moved HEAD. "
 			  "Not rewinding, check your HEAD!"));
 	} else
-	if (reset_for_rollback(&oid))
+	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
 	return sequencer_remove_state(opts);
-- 
2.21.0

