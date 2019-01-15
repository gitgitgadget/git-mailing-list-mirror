Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716361F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbfAOUAL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:00:11 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:60303 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbfAOUAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:00:09 -0500
Received: by mail-it1-f202.google.com with SMTP id t143so3503644itc.9
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p07IRYGhIpsO4laZ+qfcXXdsPFp6XEsj7Q2Ov0BfSKE=;
        b=kXQHUtJqkfLXE1O/OYYlDUqZBgfShA0MV2GUAMT3qAv8oiKYAl0Sj3IH+7nwR7gR7n
         MiEN1qqbQIK4oEbyDAm2jUkRA/iWFx5M5l3nRPKT1RXkKESBseSehLikYQbcpwp1pglk
         4kzCnolpDvZLxb4VvkXcRifC82h7DWhfQg2BDiYHc12iA0ulIb78MsQAkKcRKamxL/W5
         sXFCUiX6gVqxRJLC8rrhGYdK4b4pEufwtB2BsZpuYpgFgaWZty9/uEH+AdbB5vh4grNx
         9qs9AKrhK/LMe2OXm0ARtJiVENBDKqAfaS4P/l/SFCvln5tp3Xb1lX77xxzhJ5j5Dczz
         USpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p07IRYGhIpsO4laZ+qfcXXdsPFp6XEsj7Q2Ov0BfSKE=;
        b=ekWEPN6PLcUP1pSGD00+hslB4vYgc9yI/h+Of7LaT/T3tcQk0lEWGr+h+XtELF4NBP
         NGPBVaRFf1Z7JM4FkbBcm1C3QK3Vd+M84V2iYrfZWo8xM6VOuU0zAtGY/h3ioYH13ljy
         lYE9UwDOz5uFAQdYkag5nCTQL5v7NefzvnHCkXnQdsBU3AYS9xp5qCAe7cVKJ6wN8xay
         JAnOB+SnbyuIv6ArAe/x0aIfG7POUgvTt4j30yc2ZboUS/BJN7TYGGKPiMA7bIv42bpI
         AiUvNs8k3s7l+QGugoWqC3LpWQmxQg+cdylFCcZdnZ76cny6J00f+HAw+TGubEG44lLE
         URXg==
X-Gm-Message-State: AJcUukdTpX2uUNW4RbSLqaqHYyXKwR42uMfB9HyaC4FOzlEVNRmLHmUN
        k1MZWW5mzv+kbvhSn8aO0DStJwjbLVHZAoxZaFBWJzCEflOcgym3O8gY856IW4CNYV22yhr4O9Z
        UDDl4pUZMQcPgdJY5yW4ZXE3i/eY4exLphMH1QiWiXjaKmgcvHxKSPFLtIeCU3Do=
X-Google-Smtp-Source: ALg8bN4kDbDYHt+7na0upELI0ljwAk1AfgheynzLnP6ilLCW5cMYei91jcUYsFNpe0bl1F5Glms5quKbndf8qw==
X-Received: by 2002:a24:78c:: with SMTP id f134mr419294itf.24.1547582408529;
 Tue, 15 Jan 2019 12:00:08 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:59:55 -0800
In-Reply-To: <cover.1547582104.git.steadmon@google.com>
Message-Id: <350ea5f7c97aa4166eea56aa57b66ddc9c53de4a.1547582104.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1547582104.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v5 3/3] Makefile: correct example fuzz build
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b72f37c29..bbcfc2bc9f 100644
--- a/Makefile
+++ b/Makefile
@@ -3104,7 +3104,7 @@ cover_db_html: cover_db
 # An example command to build against libFuzzer from LLVM 4.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
 #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
 #      fuzz-all
 #
-- 
2.20.1.97.g81188d93c3-goog

