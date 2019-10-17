Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270D11F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437020AbfJQUR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:27 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:36501 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQUR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:27 -0400
Received: by mail-yb1-f201.google.com with SMTP id w2so2737466ybo.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wuw9pHIBKMwZZl6lzf8ADfjXz2feiVGcfVtWSouL+7U=;
        b=ggm9QlXv5qVhk2DYeiXA1Llzj6OQWq03PHX3SQUAkcEGFMf9//sBnM2uKg9uo8vZgc
         4dEuE1lSVq6XBAZftqM1VBbXqT/GHamZwpKZunYMbMoptuDYv2QeKCLrd7KyBzVufoEQ
         iLu7L8CFKdjfG7KkWIB4GlL4+MaAcDdCTKFzSH8BGrTrzz2ETGJjSZCeLPRuboZ8ThFv
         lSFex7Qz7vkWbuboopRN4y2geL4MSE6jyhRcZJYR6UZafOzMtQeR9w6Rg9Nn7aSNoRCv
         u/Af29MlGVOpG6QQ+Nvnf9bZRBi7+Zqz3XIrJ7XLvOsbOCT3fJIg8RgDcCut6V7QqtiJ
         R7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wuw9pHIBKMwZZl6lzf8ADfjXz2feiVGcfVtWSouL+7U=;
        b=m1lsaO/+qPMoZmg7BJBWRNYmPhGejN8kfeBZ00UlZjSGnXo/AKX/BYe37zLP94rmFB
         c7lvxkx0uca1wkPqQMf0fgrRd7gmZsC2pYbICkR7UPSToQWA84xL0NjDRMqnBZhbAozx
         ND/1j2OIKZT9MSzaWcf5ttCxQLNBckJGOk5d5nt691yi4ElZc2G9sgFHD9F4mPFk1b51
         Lof9rmOd1/230IurIFG3w0HkrWndVIxvHKkT5YnWgAv/9TzARo1FzpM2pI62UQsvFOKH
         BWMNdwFUNI/7IkRxacrexe2E2j72f7RwPbnvwUNNTEuzsGBVvO6Pw6YzNfg2YVBYnR2W
         LCjw==
X-Gm-Message-State: APjAAAWzZjXfXzAyssUNxKBiwBOi8og3Pjh+jc57q/yfDLXj8rP7o515
        CuNCmLz1U/55Ab6CFy5sVATK+DDKAD5rBGxi100DK0ZUEf/zXUwWtDoN/8jZUVvr1LaSUc0ecqN
        Nud1/EDZR/KpsNPsymGKn4KmAjCXKcdoGsvAt2KB9ILbvBrsqo/sTZmegDdaegS5F4S8T5z0EvI
        aH
X-Google-Smtp-Source: APXvYqw7AkKXb/6lQM+LSgUD2izGMLyXCy7iD6fD7NY9I5nyg7F8vE1yb1DrHZ/OWfspMJd4dWP90sKryqtocFtqtcc/
X-Received: by 2002:a81:6cd3:: with SMTP id h202mr4067022ywc.223.1571343446632;
 Thu, 17 Oct 2019 13:17:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:11 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <b19d6131e01692e47eafd58bb5a9b0cd2a8c88ee.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 2/7] index-pack: unify threaded and unthreaded code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a5591039..df6b3b8cf6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1210,15 +1210,7 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = &objects[i];
-
-		if (is_delta_type(obj->type))
-			continue;
-		resolve_base(obj);
-		display_progress(progress, nr_resolved_deltas);
-	}
+	threaded_second_pass(&nothread_data);
 }
 
 /*
-- 
2.23.0.866.gb869b98d4c-goog

