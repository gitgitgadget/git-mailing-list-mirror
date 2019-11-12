Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35661F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfKLKid (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38269 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLKic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so2367547wmk.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VH1R/IfHdgKEIPpomWN06FnlIkXtVZrD8Hf/gCipgYk=;
        b=f6tYHRatsibsX2/3NyDZLmFcclbOK8Hkt2W662ewkumS+o3SQHLkCzrlGIvQ1BmdWz
         7rc8suTzMhoFqL4kNznih+BTdjIuyhPQoRKggK/fclkN57BRDx0TChR7I39mvRVqQSgA
         51PmIX+dy6A9Qtrumc7+DrD2ml+W8kenITSQj3cOpqTTe801cqwy+inI/bvkkm1LDTCw
         qqMFkXWp87gsiEpQQjWh/BxzpQVyBwgvJQCCW4GVcqBO1RBCykwmuVyBJR8ePEeGiLPq
         hC5UVK2cCwQkxsWakEOlbTJjVtQovIyHvXONa/v3KDmxDC9Iqc9YqPKOTL7RPphLpRNf
         wiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VH1R/IfHdgKEIPpomWN06FnlIkXtVZrD8Hf/gCipgYk=;
        b=q9y0qIW/0NOwFMfJ9wPk9ODl70hSoiYGQNE44bsXRGxnB4CQU0PkUEgAAHKTjqA9LG
         d7dxvStLkG87+RfJWEwSLwL4ZGIR9gdZ51pP2pNqpNgvSvHKxtoz6gQ1fIN5+sl9p1wo
         sk4zA32dX+JO7sLrMstNKQ/aVmLX53XmVq3SlN9/m8GeH4ysCgpDTQvHXnCt1ltQaIPL
         3XH4R919PM6gX+AHA1ZtbpAie7ZSSrxVECj2U9GqnnwyKmsU3HE9Da1qCUEzj0YlUetq
         4nO9TDh+UXretNXuf9yh1Ux9cxyGe0MSpHkBY6ThFRFABXXR1ks6do6hFYcz8I30yr72
         J5NA==
X-Gm-Message-State: APjAAAV5fq+VS/gUCFm+83IE0lGgEhE4k3laPJ+TvYlMIbLxl+GSmyOl
        TQ6+iuqtVO/BvoXrXJTwuMAWmjWN
X-Google-Smtp-Source: APXvYqxIBJ8i4TJeBULS0L09PjwZ4RASS0n+bWM14FtKvR31MZpVkCbCLBPgRvNGhQwoKG9fhiyzLA==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr3013850wmj.134.1573555111252;
        Tue, 12 Nov 2019 02:38:31 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/13] t6120-describe: correct test repo history graph in comment
Date:   Tue, 12 Nov 2019 11:38:09 +0100
Message-Id: <20191112103821.30265-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the top of 't6120-describe.sh' an ASCII graph illustrates the
repository's history used in this test script.  This graph is a bit
misleading, because it swapped the second merge commit's first and
second parents.

When describing/naming a commit it does make a difference which parent
is the first and which is the second/Nth, so update this graph to
accurately represent that second merge.

While at it, move this history graph from the 'test_description'
variable to a regular comment.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 45047d0a72..9b184179d1 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1,15 +1,16 @@
 #!/bin/sh
 
-test_description='test describe
+test_description='test describe'
+
+#  o---o-----o----o----o-------o----x
+#       \   D,R   e           /
+#        \---o-------------o-'
+#         \  B            /
+#          `-o----o----o-'
+#                 A    c
+#
+# First parent of a merge commit is on the same line, second parent below.
 
-                       B
-        .--------------o----o----o----x
-       /                   /    /
- o----o----o----o----o----.    /
-       \        A    c        /
-        .------------o---o---o
-                   D,R   e
-'
 . ./test-lib.sh
 
 check_describe () {
-- 
2.24.0.388.gde53c094ea

