Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2271F462
	for <e@80x24.org>; Thu, 23 May 2019 23:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfEWXzu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 19:55:50 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:46367 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbfEWXzu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 19:55:50 -0400
Received: by mail-vk1-f202.google.com with SMTP id y204so3008783vkd.13
        for <git@vger.kernel.org>; Thu, 23 May 2019 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OQD3GIMgNfEdJjkGGoUqLwIiQax1sbb79hL6MxuCw28=;
        b=sSpCyR231fPSMh7eiIXUCvO82a4Uxxz+OqHQ4dwJ9HdhDVY1GVlZjclU3qDDRZXXCF
         qRjicGnV3e3kz8jWGvo4ar9a2Z1OvTXIbe0bSLuXWBsE9ux/7LGDa+rhMj0TLioWS0J5
         YBjdHgfgvA971ypUcMPyp+8gPiYA+BFge2PjopMZlPUCzfx3L4xGloaG8Ir+2PzyDzJq
         enFnIblWUu5a0nNGhWDdPClFnPG01OUgNFonvKLccf8SBmPhX2WdRNf86Hy9GbysAS0Z
         0UMZdATm8LVJRjIJ71UJvsPCU9AGJaaAi+ffIJEFrnu1um50PIZLpZF1YJWXvpoe0QmE
         s4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OQD3GIMgNfEdJjkGGoUqLwIiQax1sbb79hL6MxuCw28=;
        b=PUKzq6pUG/6mLbC9UiV8cy5VbyNJLzfQfkpQGU2To4ZuFSq5kj4nV7ewg6xSDdkURj
         0jdT/W2IP757YHCIV9CkNND4HxJBE1LtngJ5pKZ6oDdtZHTFBVi4NyXqfYrYDHK21zpv
         8X1fbe9oB4K1k3Z7ptUTlaI5f6lBcO56cQSlzNhSe/87sD2JvuXtFDZpfIETH4Pcj/KO
         wR5cZtE9kPbDTFdN5nPXLlMTutrmsWX5JNdASuH09uGWzZaDCh0oLR/9AodAh/GAyt8F
         /5nipdGeXwNreSabuyW6FQpGuC9uX/8TfYgtlU2TMAzG/4xM1Vr8vS49Lf2PaD9Ti62u
         I0GQ==
X-Gm-Message-State: APjAAAXOrZjzJsxw6lacjokzIdYQ7NXajbdAy8JR0YP8bD2KVHHNt0fM
        KCt2zwKbWF/+j/TtcHoXO75dPzMPFaKvidqb11XVKm1VxsPqoDlUjYoMIM6B0tpXXVrTUtWLLIF
        YrfkTY/n6eccrYEPTDqT5OY9qlTkw2jU24usxzJicoBzTEUBx1i1Nc4j9HIFN
X-Google-Smtp-Source: APXvYqxxYZRJl3U0+IOZ5T6J5QgajcP11w7FSmGw2Vs5ejSaBMmMw78ZuU21CJdp8f1oKGiPmkoDjxUvhFiS
X-Received: by 2002:a1f:85d2:: with SMTP id h201mr3139606vkd.60.1558655748746;
 Thu, 23 May 2019 16:55:48 -0700 (PDT)
Date:   Thu, 23 May 2019 16:55:43 -0700
Message-Id: <20190523235543.4342-1-delphij@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] Use user supplied origin name for extension.partialcone
 instead of hardcoded value.
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Xin Li <delphij@google.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..822208a346 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1215,7 +1215,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register("origin", &filter_options);
+		partial_clone_register(option_origin, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
-- 
2.22.0.rc1.257.g3120a18244-goog

