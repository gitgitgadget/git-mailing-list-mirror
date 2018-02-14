Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C231F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162577AbeBNTCF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:05 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:38833 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162570AbeBNTCA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:00 -0500
Received: by mail-oi0-f74.google.com with SMTP id c5so11383836oic.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2aQ6+k766+WYVsZHw0wmeKEAeYWs8wowzblgVvuiuOs=;
        b=clHsqarkBvLVbu+BtCEu6vpzesxalrh0uahvk/EbP77rgwFJJ6WsqeLRaD9+41WeBw
         dZnI0Lww1XU5zMNY/Ajcv5Goj/8GnB7jHMaGUsexAW4znF4b5GwsxxJNST9Di0CDlvx+
         YsG+NfAyTl+XaVGYCfyo3NYextZ7VMTTsEHsoWXWhjs2Tw44udxj2ZOI/Np2+9CwZSHM
         GzsDSiuDz+ARENG6iEXrZhnFMxL8JmIrJT9lkSVcH/kKrl7NN6M5B3ajlgz7QlDY01hu
         ZtlSWhQ7zZXeHrdUqQvxjLa0r0iXVcE5erltE5AK7ls5uA3jchVTcKoRg6tYN5Z6KBq0
         Y7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2aQ6+k766+WYVsZHw0wmeKEAeYWs8wowzblgVvuiuOs=;
        b=q06+i/gYf5wb82HCZwMcdEnQisv85uB5iD8cZBZwZqK2E97pZK3CB46EL+QCabiFIA
         i/ASvVPHWdlJL2Padowh68fHnp0eOq6D+1ghQAlsN46BcADSvwKAw/47za6nH14jdqDZ
         JaZ3iowt5rbvWI5F+eqp8H0ELt7olbz1BaPsXUIuhcQOMcvm+jUmnxGG9QhIDxLjdv/Y
         myk0DP0MUANBkohg51xP4yq3HNo+B19hqJOsBV3TwtwzdVzrbjFLCYyjkUhK1x9kZM29
         53AHBk8xcOCsuNbtOU4kXRtMptmpl5dX6lf1nzoUuW6+x4SLeagHTS8QsohFycS3AYnY
         I6Ag==
X-Gm-Message-State: APf1xPCGLWxqOyHH+GEaH1I94coQKZmt6MAJZINamMfY8Pia+1NdUnHU
        fLwji66YSLq6ollUbNpU7JsI/no9hyI50bO4tJTQW64EsbpVgvXP/XKtb4GhW0kuiTnvMdYhLfR
        fEqPt1inwEWS2ajh6bm2lOXqlW5HgOdrgMdeePbDnKFAZznlzZ0I0qjZHUg==
X-Google-Smtp-Source: AH8x226ty+K6Nq09EBexivu3v55RBLNXpFkjCQcOvdVwjY/d4WeGQmcer0BZIlQTlz0sFpBGIvlzz2z4YZk=
MIME-Version: 1.0
X-Received: by 10.202.88.11 with SMTP id m11mr48180oib.14.1518634920056; Wed,
 14 Feb 2018 11:02:00 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:51 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-30-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 29/37] unpack-trees: rename 'new' variables
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
 unpack-trees.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 96c3327f1..bdedabcd5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -194,10 +194,10 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 static struct cache_entry *dup_entry(const struct cache_entry *ce)
 {
 	unsigned int size = ce_size(ce);
-	struct cache_entry *new = xmalloc(size);
+	struct cache_entry *new_entry = xmalloc(size);
 
-	memcpy(new, ce, size);
-	return new;
+	memcpy(new_entry, ce, size);
+	return new_entry;
 }
 
 static void add_entry(struct unpack_trees_options *o,
-- 
2.16.1.291.g4437f3f132-goog

