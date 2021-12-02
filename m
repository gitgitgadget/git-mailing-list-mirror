Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5FC43217
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376638AbhLBSnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhLBSnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338DC061759
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so460840wme.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3alPs0V96A3U1mKPlrtf6B+b0US9dI+Mh5kG8iFdhAw=;
        b=FfRqoHZDmjmuYj4wgk6lRCICcOd/3KBnF5M5fukXxdBhRwmQJdxf65VApFS0qwa1Gk
         R4nOwJsnjZds+BN82Cz4gD6AnMXn2zS2gfMPJpSGVQiJKyaHRQQCXajavUEUUbx7Rr4K
         u+Wm5Vhn9X7rD9T+gC2ukukFfBgRa0mWeFJTew4sZ6+tND33hdAKp34mppJO9130iqds
         hWtabOmTkAy+KIENjNzohLuv3/pHWhIipAov5qPkTq0Or0zcVYADereYN0T/JGilYlkx
         zkhnmCnwVh+FSP/17KMGn0T8fk7Lya0UcpA7cws5VvCiXvvXLQCeu5vH7yXNkEZbO4Lr
         x6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3alPs0V96A3U1mKPlrtf6B+b0US9dI+Mh5kG8iFdhAw=;
        b=sGNg/uB1dF1/tp7jZJDfKn9bN0Wa/QLaPqYAF8VemIe0zud3f8tr6xZN48AHLhR9LS
         LPFpZiqTFJD90a+1UNN4+lQUQ8QJKJGfFZa9QBfPavitDzS5mIRcsrTL5+6BGK+uBH2H
         dmFQ3RFE1mcUA++bCS2uOiTnZE+r+bXtfMYxd7tTtQrUUs5EREl1WEVJ7CHxvhiyx3ac
         9gfMOMEwUfcosyZVcHMWDQ6kRAXjOhumuwjXivA15Bb6EMypiOKSQ/WD5AiVKx8Ex7a/
         A36ItIKd+x/lz7J9zpjU/uyE/hebGi/cjvJII+J2f1WKGUq+dk+Z5BX7TY5X6Unp5UCr
         il3Q==
X-Gm-Message-State: AOAM5321XuOTvObt3F+QGIfccCFiFKJhAhE7rwXOwLtBiuZFY+Ijhucc
        HczwmwV62PQ0ks3uJBuzBKbk0B3kn3o=
X-Google-Smtp-Source: ABdhPJzj8Ql8m6ZliEziwXJI1i20LZrsOA/iB8V8Ec5gD8YJx3pmSrM/A6VugtFtnPN9cSL5sV5J8Q==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr8462767wmj.115.1638470406483;
        Thu, 02 Dec 2021 10:40:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm583250wro.35.2021.12.02.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:06 -0800 (PST)
Message-Id: <536005d65a26e8471bb0c5b9109a59319c636eb1.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:39:57 +0000
Subject: [PATCH v3 3/8] test-ref-store: plug memory leak in cmd_delete_refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index cbf1b5f506d..c8ae36e2172 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -141,11 +141,14 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
+	int result;
 
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	return refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, flags);
+	string_list_clear(&refnames, 0);
+	return result;
 }
 
 static int cmd_rename_ref(struct ref_store *refs, const char **argv)
-- 
gitgitgadget

