Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1027A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfAPWmg (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:36 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45639 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWmf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:35 -0500
Received: by mail-vs1-f74.google.com with SMTP id t136so3289926vsc.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SRWiHPmmntvQcIiavlynWCvgBTBK6iS5deX71ZKXJq4=;
        b=Rh3GdYZa53wLDGm42DK1qjRlEM+Y3sWMtyRjMwzgSX+/8e+6CLu3lN+lvqZ/f1v169
         vTwUlHV2RS0rRpKUpWWJ9WzxMqKJqmckj9Pqj81T7G9XujZNWyjwXTwnGDJaG/1fDYxh
         KqYbGD/SVqtXfPI2iasOeQSOJOaWXK863yW+rnMB/P8x71OOSDChdCPUl/MBz4KcC7TL
         BKTYn57Z3UrwLHdtY3CUdZqKQzsnv4+GhJtFEWnmN8nIFoYhlvqoJ4HpyZAufBLaecdU
         JzRxa9MSvxZzmncrlnoagDd22I1hKgmcMTcCT34zlmImWIq5m0GXECPxJW4bMKfPFhdh
         nFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SRWiHPmmntvQcIiavlynWCvgBTBK6iS5deX71ZKXJq4=;
        b=SO6P0czrOHvpRcR1EsqeoeDFlq4GkUXn/85cjfG9pmdGPLsgeVRgECsZyVd4olXIdK
         0zLNOxcX2ZLseZMaKCXo3tSbnXpUuZvTNvxgSutBQn+yTLcR8HYQI8IFA2thozJPcbuO
         lCDD/dRmF0dmu00mWWYZwA1+LGGqlQ3o1/oifzndVdIU0ye9VBWHfGt5jAAq4alXtOJv
         eNs2jGw8bQ15uA6D7JzJTUmABYOEPbR5Cfe1GOzt1VRxSOFwdZKSA6lIQpOmYJ7Uh7Jh
         DL7NifJMetkh22R56IhfZygsr0GOD7sB8tAkbSLUKexTUJT+pWziM12doCcDedD0Yaeg
         C9Yw==
X-Gm-Message-State: AJcUukc7ahsr/ZL5iPYauadRO+8BWrsGHW2ZrYzpyoAM7HKf8Wm1yDyC
        MHGFsEua+g+/j04MkRdgRftWQt//1bYjwyYpPGU8a1Zrk3h3H4msMBcBPBVaE6qZt7EPPurzA30
        CC5ncfqE1uNkR5AvMyXM8jhC5lcMWsdgXOtI1W+5p/4pJiD7p9ZpZHGqeQjWpzNJF2ql9fFUqjZ
        e+
X-Google-Smtp-Source: ALg8bN7/4wuXSCEKsNa32Zt5PeQV50gp4YvTxHEKzD7u69qdqcW98VCb2A8M5llrrUR5ZG9H7qk0TUsp87EfdjqQWFfg
X-Received: by 2002:a1f:25c4:: with SMTP id l187mr6913810vkl.7.1547678554899;
 Wed, 16 Jan 2019 14:42:34 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:13 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <a9a1fb7958e9b4269ca3057f0b4bbe4565d56e8e.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 5/8] t5700: only run with protocol version 1
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5700-protocol-v1.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 2e56c79233..9857bd0ecb 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -4,6 +4,9 @@ test_description='test git wire-protocol transition'
 
 TEST_NO_CREATE_REPO=1
 
+# This is a protocol-specific test.
+GIT_TEST_PROTOCOL_VERSION=
+
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
-- 
2.19.0.271.gfe8321ec05.dirty

