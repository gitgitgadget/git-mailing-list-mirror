Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EFB1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeA2Whz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:55 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:56276 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeA2Whv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:51 -0500
Received: by mail-it0-f74.google.com with SMTP id o4so9880264itf.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=nlF828y136vOS595kHjxTTHwHYYiPjMHfN4Y9rflUz4=;
        b=RPwoOjDk+0RtsgsNVArn+aLM8X0ot2T1c0jPnCCmj8549paHeKBbydvhceLkeAxLsi
         yupkkA6I/9UEw3HBK9C7mh4YYS/UZz833NS6BN9spneMzmWzzQ/wV7QDkakpaT50nHEM
         Ja+MmO3Y0pmN1hKKMEnB8+euxBI74w+8uYFP7PA4O03MJQnIAkT8mFug37JB26kjLTi7
         5E8uUOc1fS0OaGIEmbYemOrUPsrEweRnUKLH0oto7OUTIVlPfcHYYunMiluTyboE2apl
         ekkDU7Ydl/2at/yni/PEEWXOFhpuOl9JojYpJqIxTxkkY2PeW/1/VcpPwMRIg6CQm2Jf
         +A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=nlF828y136vOS595kHjxTTHwHYYiPjMHfN4Y9rflUz4=;
        b=qR16BipVS82aN5MDoSYgnBSgzKhxG6ZfCZiUu3Oh62XLPdUgYdtTWXjLU9/ouYSpCD
         nXe7lIx7tBVPwtbSziodbxka/aVQLswkPJryYCZrHSD0sJu1ihXV833q5hkan2wpP3Xe
         8K6f5iNnoNy7lloQdJCvfTsg43c8udBoV38Nig7asQAmII0YCOsc8iikbit5yW/7fK/l
         vr40SXaVZUkRUB+z5fYVZ2ASJZ167ETaOx12GlyUvVl5zeVKvNav7sC4BA57q6Bsa9wg
         2TUShp2+JXwvIQWJlOyTFlt0zQwdlh1TX3FWpSFObUU5ax1YdYtHB4iVVGS0moYHUgDE
         IUjg==
X-Gm-Message-State: AKwxytfDJ6Pk9/d6ywhwhdnMs5p2iKCkecUjxUyEZY1bPJsGqdVD4eDT
        IGi2oYC0pR4o5l0tB9H29jEAR0a04xhCVAQjbPyiua/Dy0bHF0t3wU6uCywz1E774JNdcAcBnWb
        t+mAUjMQJWdF/JYylkQ+a8czmTzr5bNkSRIE+Mtx8g6NX7vbAINVPihlsHQ==
X-Google-Smtp-Source: AH8x225fwl6NVx2EVt60fiisExLMf3Fz06Fny7++LAPq10eZ2MjLnkwb9yV5BE0L6G7PbYV00D9ZDi9Sl+Q=
MIME-Version: 1.0
X-Received: by 10.36.94.145 with SMTP id h139mr19553220itb.26.1517265470595;
 Mon, 29 Jan 2018 14:37:50 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:55 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-5-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 04/37] pack-objects: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b9cfc289..bfda8602c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1376,10 +1376,10 @@ static void cleanup_preferred_base(void)
 	it = pbase_tree;
 	pbase_tree = NULL;
 	while (it) {
-		struct pbase_tree *this = it;
-		it = this->next;
-		free(this->pcache.tree_data);
-		free(this);
+		struct pbase_tree *tmp = it;
+		it = tmp->next;
+		free(tmp->pcache.tree_data);
+		free(tmp);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pbase_tree_cache); i++) {
-- 
2.16.0.rc1.238.g530d649a79-goog

