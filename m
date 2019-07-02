Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2151F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfGBJOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:14:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37972 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGBJOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:14:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so7387722pgz.5
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWErZ4q/EYV5Los24o5miiBOLFeigR3z8zc0g/j9Ozg=;
        b=bmTN8MsaLmDmGvd7SeP0BqBjKbhjJMuzQ2jtrl0Z/xSvbpzPd6OIXccvV5bDSsdFaJ
         IP2wzlPF6GQJICoD/c8FnEYfzjleKsKp0pLVEFEWa7xOjPLZGw0eJo9wirLF2t5isDcb
         nTRXEh5jjjYeIpUl4LONNwDvo2mis0sFp6VZ5aoFvv4+43sZ7BTsUPNzSAY6NF1e+LYb
         OGcFpyjZxD5Rol6d/Q6oM3q1uLxWhCpqxXECV8vgU/QjAE8W2WG/4MJiusRayEOPdZ4W
         wp6s98uce1kdV2pCBeyrcOcg8mS5NwdVYGf2IF0HYeuUNDJPBQiCjzyRgiy5ZlfGhwCI
         GGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWErZ4q/EYV5Los24o5miiBOLFeigR3z8zc0g/j9Ozg=;
        b=PDXrqTxuozFWISAIxpXLdi7vBrmoydaUJWMngk3FGzwy46kdwnUxfkYHQ0sNpEDXmg
         j7HhYeaoqQPLKH+yZF1KBj8tHzATszNn8laMj47fNf6kdShfmYei/HQq7LSBb/iRTxmQ
         3yn6AbfkMCYAePCZYCdk5bbvAuUiTfFfXtTCFrRCejrNdjiko45MDS71yAiwr8eLf/ls
         KLZG1oudRMonDQrS0jYNsbob1/qjsrAeWhPM1fxzXXv9ySbM3axgam1WcZag2NeV69sb
         MbBaerpGAdIXtUmRrrteEfpb4HusN4O4hzSSBEBa8AAk+XFuNpydrqYkDSaGAkGxd7DN
         RNCg==
X-Gm-Message-State: APjAAAWtjxf4E8QxvX8tPIYcJXv//0u2+SgLffjz+b5hE5sE2NImwxHw
        06bfxcriEDatF4BDm10EF+s=
X-Google-Smtp-Source: APXvYqx0pVzzzpqChs09mJMVtrMeLhAauZaULLgDFl0OJU68v5METIW0Z9TIMFqEvJyA/GmCz29nHQ==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id b60mr4461155pjc.74.1562058861491;
        Tue, 02 Jul 2019 02:14:21 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id q198sm20499178pfq.155.2019.07.02.02.14.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:14:20 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: [GSoC][PATCH v8 2/5] sequencer: rename reset_for_rollback to reset_merge
Date:   Tue,  2 Jul 2019 14:41:26 +0530
Message-Id: <20190702091129.7531-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
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
perform, see 539047c ("revert: introduce --abort to cancel a failed
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

