Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB3220248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfBYVyj (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:39 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48328 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfBYVyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:38 -0500
Received: by mail-qk1-f202.google.com with SMTP id z198so8955640qkb.15
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sd7OU0ZlQl3HmpVtm/ImInrB76Zk0Cn0aUyZfY/fuU8=;
        b=nVdzRv7vOKdOjhe5RHC8GjExyLNWj0VKy0fagAlMXlFpW9TN4kX3P9hNF34AOLf8BW
         OU9bnDoHe0cnX9myU1TESsFdN5FTVn7Iq6Du+LxsEHL0ijz3QIICzp+/sdewq6Gs1t1+
         rqbGLqjHKw6DKc2DMHp9lJgLKHvP8uxnU88/iKRbzcHeW2haQHM+FZdOR6olBv5xrVMv
         q9tu5XthFdtfwu8ngTPjMvH1mC/KABjZ0zoJ8yDD3v3k/VsXgWEdyrmrBFRvUlX2LW+R
         QBQ+KDG2KzTRYID0pZlhM0bWAB4kgkSzu79focXFb2PTmJW+zlsHUUEjwOioAGxs+jtK
         b2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sd7OU0ZlQl3HmpVtm/ImInrB76Zk0Cn0aUyZfY/fuU8=;
        b=WV2uTF4fb3X3xb3JHDMpe08w9NAWTODDMRlVqR5y/p7Gc/qRVy/lkxCbl2Bq0vpeFK
         cog0PQ5eJnOIxlBv2VxEGtDPSe7nqTOJsYfo5b/Xus8SWFa7bKGzcyiwb+k1fSEasB3w
         TyWl4+3y2e3gw4cs/faGcSOtqvK/ZbELziL5KO62VuKA4bAaGCHWPuXNe4uDDZlbtXUy
         Bu/0/LSN7Ej4fdxcvuuAMHAdmZWYablkSUFHOTZiawJjF2ayyvfDToz4K3tXuBD+PCYs
         KMcwiR+nk5Mqp6CEkM873sR7lNeobwOhzwVbcGNuK6wL/BixPgm+tLKVxYn/SBApKtHA
         Gl9Q==
X-Gm-Message-State: AHQUAuaEgAnH2HjRqIr3hmm3XBwemLkWrEaxyNVEC7UFqhMHSCev4/SO
        vsdbh8eoZw+RVD6xG6VxvKa6KcdtLAS5DxPDSSEqpVfODX9hr7Ea1nfha7KlqhgzcjIJ4lIqhbS
        gZRRdT1vZD3qcBw23fxmjKkm+0IdXUfISygVC5PfuROfcf5NdiUikeK+lnUwbLqrIvQorYKr8s2
        lq
X-Google-Smtp-Source: AHgI3Ib0dV5mopdx4l1TafB3+hrQUHmjUIafdiMW015yMWrgpRRZfddY5Rwb4pyBwbqppfiLK+BmBKPvqJRSdNN5cuXv
X-Received: by 2002:a05:620a:144e:: with SMTP id i14mr7217159qkl.38.1551131677943;
 Mon, 25 Feb 2019 13:54:37 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:13 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <629a243c7f53cfb01f7fec060db318f650ad33d3.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 8/8] t5552: compensate for v2 filtering ref adv.
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 filters the ref advertisement, but protocol v0 does not. A
test in t5552 uses the ref advertisement, so fix it to use protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5552-skipping-fetch-negotiator.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..8a14be51a1 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -127,7 +127,10 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client origin to_fetch &&
+
+	# The ref advertisement itself is filtered when protocol v2 is used, so
+	# use v0.
+	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
-- 
2.19.0.271.gfe8321ec05.dirty

