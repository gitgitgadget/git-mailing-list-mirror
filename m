Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11D2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHFQmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:42:44 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:38534 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHFQmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:42:43 -0400
Received: by mail-it0-f74.google.com with SMTP id h5-v6so13096255itb.3
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wwply1zK1EqeTZIbXKDl5Bv7S7ckbJ79KiHfXs/i9iY=;
        b=tSaOKzsldiYae/g0mv4YkMAsBZQ8Re31HGkrhdRTd3SGViyq8y1si99RI7SLCMixDK
         KT0pdw1iAKA6t6lvyUyoRAc8+qTgW/LW/y5/w5lV2A0rXP4FcsPVfklE7bRgGC3w5C7M
         nHNxL94g1vBIhwmett6gZM94Ygp0qk395b0YshU7vN66nF7n+HjoQXqooEAadh0l5dLu
         LNq3VBDbnaGG418UM4ll0hyLVGKm6hZMXeLC9zv5jwxEUMhn+9jVBMiEh2Lx+KgJ0xIO
         0deJJvz6z6cnVu5bRyC7Qs3gOp6MlD90LurILpgvwzSGddKk/LMILw5N3cLywBVxClSN
         CTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wwply1zK1EqeTZIbXKDl5Bv7S7ckbJ79KiHfXs/i9iY=;
        b=imi/HMseQjX7iZ3DLliukB8hpskqV8DUzM4is55PEKFUGzY7KvezdX1UhW1GtwSM3S
         uJ2yVe0S14sV/NwDIO8joOCwR8kj65OSKQbiTMNBBFwFjHp/kfqkHlGxPjfKsO7nfX8t
         jCirDvxfhjmkVsgW4cdK5rRvrJf8usCgGIKzuqlunfsW0TGGUSGVThqWmqn/wDDA+am9
         D7IJz58ZUH62nFBnKdfmfp/2IXnqAo+UK7NyaFapsLDh+TBT13usFSYAZnSawcsJ/6or
         +jfiVM/N3ce1KqRkNxHoqjI4BZ1BUDrWAIcyPx2xT39XD7yetovJ28CrL3oQ7HEouOa3
         KZTg==
X-Gm-Message-State: AOUpUlEOTdnVnwD/RPLijqtsVmzJIkWXyFNTdobCOHxCkvKiftux5Kxj
        c/XuwZ1Q0m1xA3m0swfUkZ0DJVjJDGM=
X-Google-Smtp-Source: AA+uWPymqErKn+s77WIsCwYJLH8vH7hJME+IKiHinPXvSy7dIobdl4MdHLyTKDsXnpp4rdjHQ/qlRcBs80k=
X-Received: by 2002:a6b:88a0:: with SMTP id s32-v6mr7634395ioi.45.1533566000657;
 Mon, 06 Aug 2018 07:33:20 -0700 (PDT)
Date:   Mon,  6 Aug 2018 16:33:12 +0200
In-Reply-To: <20180806143313.104495-1-hanwen@google.com>
Message-Id: <20180806143313.104495-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180806143313.104495-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v5 1/2] config: document git config getter return value
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com, jrn@google.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 config.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/config.h b/config.h
index bb2f506b27..183b31ebf4 100644
--- a/config.h
+++ b/config.h
@@ -188,9 +188,14 @@ struct config_set {
 
 extern void git_configset_init(struct config_set *cs);
 extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
+
+/*
+ * These functions return 1 if not found, and 0 if found, leaving the found
+ * value in the 'dest' pointer.
+ */
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
-- 
2.18.0.597.ga71716f1ad-goog

