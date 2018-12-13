Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0EE20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLMToL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:44:11 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:51647 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeLMToL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:44:11 -0500
Received: by mail-ot1-f74.google.com with SMTP id c33so1218791otb.18
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uQ1jhi5AKwgWEkWw7YolYoka7re7J8A0znSfqW0qjMc=;
        b=oGhtFNHUbT6Opo+2uDPOJ8eequdqA9Y6z/GieLnm4q8pjV0QnwvTkGZR6c39TbzcGO
         KhgKYts8wAdsREL3K0tEPPkBhQUyYphZwXnqeUg720oGf74a5IlsoD695FoAu0QA7qQw
         ymbcWfh6fF+ukxaMdMW/Cy8k7VWKWfX+9T8Rpgl5VUpT0ptSES7GwcLx/PQXvinMSXja
         pPJmuzYmSOdTzSgtZSSLkmt2vOpAEfhC1ug2n8t4Qp7Qr7dAgShW+cCxNzWxS9ytnH98
         shHFv2a74fozJ375pNVqnYfuCfjdZ/H7ZBI/t5/glSWYadQQmM3+mc6/udmjZHoXMNrh
         omeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uQ1jhi5AKwgWEkWw7YolYoka7re7J8A0znSfqW0qjMc=;
        b=Q5YWd0imS5dnuWkz+SvdgCUvYfO4yfbvzTrWXpO5aWm7nMYJbMRy0kS8wvu+KrJPta
         pe/VlgXYcSXxt2f+TeT6uzXwY2MlfblIKRPY0j2hKkkLZGxGn2aq5oZX5BtiNS4/+H0l
         4S/dSy1NDjzT+K1X4Ir9qBGeMIDZzsigGogR6eV1nciU5mbJlBxalnvfw7mgFlOlmsmy
         N4kKhbObOk1NOjlqt78xzltsJ73eFe+gJaKMGR313LTmP6i+wWtO5juXGtIORmThxiK/
         oAD8O1JTVVN+uZsRc3VK0jLp5fpj1Kp8x8yfISO83Pr20u34jQsFWedBc4BitcSmcqGl
         ksyg==
X-Gm-Message-State: AA+aEWaUIUHJiuMqbLCyrxmNg30vhSpqEJuxuzJ1FCl1BIT4RlGjJwwH
        3afH+LkWeqSSml/uGoJIvbkikwJWsPvEElVLPsCY5Gm3LX2fls19uRAfweezeYmnoG1u4ciJtI8
        Lw9eq2y0FQtlz+f7A/W4cFkZ8p3vJNl76hS3y6d2yPiyJUYRZJg2Z5oUwyKnPMCY=
X-Google-Smtp-Source: AFSGD/UFmkKOpidldAsE0CEhlvs4peU27i+Qk0lng/8eQk6045XCNz93BA5TkpZS1zFrGRNHt8MALS8bRPxqYg==
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr69339otm.59.1544730250090;
 Thu, 13 Dec 2018 11:44:10 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:43:58 -0800
In-Reply-To: <cover.1544729841.git.steadmon@google.com>
Message-Id: <21101b961ac602be766b6947143cf80d322e36c2.1544729841.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1544729841.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v4 3/3] Makefile: correct example fuzz build
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
2.20.0.rc2.10.g21101b961a

