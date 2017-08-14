Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0440B20899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdHNVa7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:30:59 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34232 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdHNVa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:30:58 -0400
Received: by mail-pg0-f51.google.com with SMTP id u185so54765735pgb.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yV5lir39cUXeARUX+AUiv8N5PV/utwU9C84Ptw1HEnY=;
        b=evBykz1GASBNgZ2sYLXb3fOvzQXVRcRC70rXV2bSvwxeqDR5rJnNitlAiPwW3WtBaV
         IvqL+D76nOzIriSPF/6uzaAPw99XFoOfvdz481W5HABdGylAJceVB4gvcjuFoeuCs8LN
         1nqC4rtS4wdX+vIKWcX9tTUWeh/IdKKvs6M3PEAUQdrvQcTW4JHHcne+PBj8IZt63N67
         pvWpTmjubkfgWuuv4faKoQCyiEDgcCnCtjovGh9uGcbMU6MZI6qrnW7U9YdxpnODELW0
         VoGOj7EhMop30FUhio0Q45OFV0+N4Mky4bjpQUhjVGF5yP6Wz3+sQ5vPdkC/ITFOCamJ
         U80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yV5lir39cUXeARUX+AUiv8N5PV/utwU9C84Ptw1HEnY=;
        b=kVtvt3o8UC/lOgpW+L4byK7tqGY4WkErsDVxDYaN5cdiH3H6JGpxqUkZeN+wyoZBG+
         kgEGvAK7Vc1LoB+Mzn+SSxKEwtCTVYaInYBtp20iQVB7qdpbAaM7BBh5+dMH82ZvcKAE
         0H01fqZUsdFT3Fb3xVXdueEnbJuI76r7KKIEKjW/0omHR4w84qKGK2V1OncSYXs4LAR4
         F5Gv04AVvIwoQqAihaxWpvWBib70J+QaUdukwtKDFQgrkJSg5OfRKHTUZCNLX7xvz2fm
         LJvD8Ba74osIFlFt0aZH+FqUcRuXDDXI8VBEwVrlPzY78Uvsr5jIKFqMvHZyW/eD0PnU
         tsBw==
X-Gm-Message-State: AHYfb5inb+7bPJzuSKj69trmc8ndP2XzT9qkSuqNrcIPYeUjQ/+Maw52
        HW82/bMggTFTTnGNvEgBcA==
X-Received: by 10.101.85.1 with SMTP id f1mr25833927pgr.225.1502746257070;
        Mon, 14 Aug 2017 14:30:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h62sm15842737pfc.97.2017.08.14.14.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:30:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com, peff@peff.net,
        peartben@gmail.com, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/2] Makefile: add style build rule
Date:   Mon, 14 Aug 2017 14:30:46 -0700
Message-Id: <20170814213046.107576-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <20170814213046.107576-1-bmwill@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'style' build rule which will run git-clang-format on the diff
between HEAD and the current worktree.  The result is a diff of
suggested changes.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index ba4359ef8..acfd096b7 100644
--- a/Makefile
+++ b/Makefile
@@ -2414,6 +2414,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
+.PHONY: style
+style:
+	git clang-format --style file --diff --extensions c,h
+
 check: common-cmds.h
 	@if sparse; \
 	then \
-- 
2.14.1.480.gb18f417b89-goog

