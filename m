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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F5E1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFUJUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:20:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35023 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:20:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so2710860plo.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0tDpwlg+OKRkVbD+oy1LwC7tE5sbq/gpCxskU0uUP0=;
        b=glSAk8TeHSMQANOR11duSKa0OWu28GIQ834sLWE+f8Bwd+QB/t6+81Vi3zXpHr0Yq4
         dF5Gje8NWw9uYOlKMDzWFEA0r+73VSueRCsc9UoeirjP14nEEH/1dts2NRGAS6kXO4eM
         +rJ7Sf+xEvcKFJOIjHEjcFIH2PgatCIXGop3BkGaKttdIhfPIOOnm+/7YyjBLwivu8YI
         eK5k2HG3uAYmqlQAy301nIMFPb+KQ9idIQbItRX2DpGv8TzZKsd07SWv/v/sB/XZ9LvB
         LOnwOjrd3IqXPIV0NgHOzedfthIvr+NnbbhtQ0GBBBKpmUGOZZka+LZ/veiB0MWJ7Duf
         jlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0tDpwlg+OKRkVbD+oy1LwC7tE5sbq/gpCxskU0uUP0=;
        b=j2iBPtCo3CHgj3tC2q8PcT6hoWz942B4Ild7uHhShbOiYb8NTCrMYmvWzIsj4EsRcP
         CplCgKK3RyH/HH9W7YVxbSqAB28QHaD3eEkAL5qDzCLb+++P4OStG9hQ4T7e8Xdptpka
         sx/crhT/9FZqps2M3lWYGcZmJTrUr1swdusvxA5+PFiQ+DJ0IHmDXtCshK4OP/EoBIwm
         nj9FaBQpjeSiO9exeSG2aLZlHd3lsu/QmnB2cy9mA59LYjtAwPrYOqZ8ZheZxXNsLXFT
         DBmgolrNyOcVC3tLUNf8jQ9hXMNg1FvWdrZRr3N8tTlqPuGK0sveM08TxkYQ6VcVoc2q
         1nyQ==
X-Gm-Message-State: APjAAAUQrs1VGFUtRxjfBuJiAi8LUl0d408EwiwkcpXXw8Pdpo/WrqdT
        iqhNQzYrG+l3zUCJ801gDaugbiI8P/I=
X-Google-Smtp-Source: APXvYqwNk7iNmIDGFEOjjdu6UX7iRvoDz3yO5j68uLzIXsBlLYqfyPYRnCdxTJQCxYFmohnd3xJ+LA==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11mr28546696pls.107.1561108829980;
        Fri, 21 Jun 2019 02:20:29 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id i133sm4380220pfe.75.2019.06.21.02.20.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:20:29 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v6 2/5] sequencer: rename reset_for_rollback to reset_merge
Date:   Fri, 21 Jun 2019 14:47:57 +0530
Message-Id: <20190621091800.17686-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
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
index c644368b54..12f2605ded 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2731,7 +2731,7 @@ static int rollback_is_safe(void)
 	return oideq(&actual_head, &expected_head);
 }
 
-static int reset_for_rollback(const struct object_id *oid)
+static int reset_merge(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
 
@@ -2753,7 +2753,7 @@ static int rollback_single_pick(struct repository *r)
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(&head_oid);
+	return reset_merge(&head_oid);
 }
 
 int sequencer_rollback(struct repository *r, struct replay_opts *opts)
@@ -2796,7 +2796,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
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

