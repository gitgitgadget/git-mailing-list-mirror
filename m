Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F62720A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLGW1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:27:37 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53042 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:27:35 -0500
Received: by mail-pf1-f202.google.com with SMTP id q63so4512826pfi.19
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N9IBtPufJ2jZxUes8Y8kY5fx6zKd1WuqEcYPTtwzVCg=;
        b=QHPANA3HgXB53XrUtDjoB3Q7864ScQKegFYZjVHzrOUWr0oxTp9hRLcYzF69frRcVC
         4HkwWMADwALoIxDql70AtZUhVtHnhxzChQ75HLC6a4dohmNu4oY8uWLIvwMKgDnw3/PF
         B/HHn/wQCxq90ZUEiYN7ehNGMhub6yy4HZs6giF8GK/vcTN9Ip9G82BPQ3LPMr5fTc12
         ZBk6pNiqBciehVW3lOD2M0Cg9rhzFVEpCTgyTFC10/nz+Bu0OgPzAJS47ycTXmdhtMff
         PyXMDthH27A6X61eVdOHtDq8kwfW/2lUu3PnlqOarF9Gj120AbCxyiYi5JiL9oCD8oCb
         OhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9IBtPufJ2jZxUes8Y8kY5fx6zKd1WuqEcYPTtwzVCg=;
        b=R7S/H6v9xoZeFHgp6J6TpB8FitaZ6kXgEYApuCeWf7/ZK5bMAzS2Iv5uXZ8XDEdhAC
         q5/bFYImMeEsoWUE+AtQteuxGIicXS5WElXHb+P973AkXIU8z27y2ZYTUSWQ188LoN+5
         iALL+Wyh5nbsFsoZrCKw1sUs5/b0SkbiZeYjfQ0fjzNzG8zYfqzEzno2Jkiqj/LfbN2N
         L5tpfPeXyoQFhRk2dSCkV6Z8bizkHuizBa8o/87IKq0zDj/+TZUzbLabneErCWliPKKu
         WrYan8+6K4UU1IPMIOXx+SU9LoCFXflNzM7gCCU+phKpKdaeK4m9Nd/5oe95lsl9qr0W
         IxEA==
X-Gm-Message-State: AA+aEWYj50fFum/OrjULGRBwCj1xj5MSw9We8YdVBAbdc1myBCDCNpib
        uFNOsK/Z9WSU8Eun5xSpAER9IlzQD5RjvaCX53K3YZv6RzhZ0//lIr7OhiJZVtWDeKnnfPxIkZs
        X08gfk9Mkr57HwdUVw1XJW9wu6X51NebA279ODRBpoTLpZ8m1JTl2+o5oUWlpMY4=
X-Google-Smtp-Source: AFSGD/UleaEGwKQidNbTzKOkVLElvcGTuPI/dPq6nZavtpKsfK1t4dKjUFYEBu+Clbg3V20cU4mrnrQ88WTfQw==
X-Received: by 2002:a62:39d8:: with SMTP id u85mr1986514pfj.116.1544221654484;
 Fri, 07 Dec 2018 14:27:34 -0800 (PST)
Date:   Fri,  7 Dec 2018 14:27:24 -0800
In-Reply-To: <cover.1544221121.git.steadmon@google.com>
Message-Id: <06a32bfe8bcde47ede70f2447477803964fbc284.1544221121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544127439.git.steadmon@google.com> <cover.1544221121.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 3/3] Makefile: correct example fuzz build
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
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
2.20.0.rc2.12.g4c11c11dec

