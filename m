Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6E21F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBFAVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:40 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:35696 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:40 -0500
Received: by mail-vs1-f74.google.com with SMTP id g5so2228951vsi.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SRWiHPmmntvQcIiavlynWCvgBTBK6iS5deX71ZKXJq4=;
        b=tLRjQg4UmDczrYgUfVu9CmJz6FSJy+JHB7lNQAK7e7dHPaJo+nuYYPj6p1CK9qdgWO
         PTJRAy3oFHGMXqvk16okb1gqkp6mV2wyFLxKU6pPSDrAScUVSo5BsIH6b6x00yXMyLPY
         AX7mYekzdnV3YeYY/vWZnC60VFaNE4GAohKpy2OaC4JB5APr7QbJpaQy/j0lsjlQ+vHu
         KtSnoFPrYnuU5Bq76db9KoaNCtv2/Ed+R/DAm0URY4lZooAGk51lA0HeIUvIXIXB6/0J
         9BuCX75+1MMg8A38Hyg05lwhxNJkWFEV2285/J1Xm3sM62+Os+HrzOehryrXm8eL0soE
         aV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SRWiHPmmntvQcIiavlynWCvgBTBK6iS5deX71ZKXJq4=;
        b=GXRGLv4BABOjGG7rTt0WdZxGZuC9BSgVbl25ym4vrPGj1TZPNYDK1bK0Vv8ml9ScJB
         xfDlr2u6M9mwgWmxfhpekuLC9YLPEb4aA3JO2AG3CdlkzUna+gwPZzzhbY4YOxhY7znp
         a+/tZOD4hkflsCOVkQQCPNuGrvQFdpVp9tSbzkf6mRGy3La3KV7J0IQyWSoi3n9Ml6I7
         TXY9O8+u6w3StPN1nouMJtQo/W32b3azaqVKl4YPRqW8OVr67CFivhE7FUD2UNnXJhLe
         1/QpFdREzTLrtxzA6dKYzPVA9QyGqfnXMz63iIG9e06nRSSb1bk/Q/eP1Cq/JYbBeYip
         itkw==
X-Gm-Message-State: AHQUAuYg6U/QulggvWl0hny8rudI4yh7rIySwSzEUEUPpkyD3q4/s+ZM
        dUwu5ScfBO0FDBVOeyvUmXTAiQhcflOKsUoT3r6xmyPo7tA7x0HrdnBbAIhjuQZex0egNSEiWhH
        oI3toukYZ2fFtpNPdVxtV1FnnxRcLzuobTsyfvr7S9VurP4dHKR7BfDWDsM/qI+87tezc5ZNDyh
        cu
X-Google-Smtp-Source: AHgI3IZt3B5hVOwGL74mZtPQvM8y8mchzOdcd+04/TqFbLMq79R5zT/uT+oOgeDUOwH4QhS+6ntv70ykOexRn9+nOwYp
X-Received: by 2002:ab0:1423:: with SMTP id b32mr4880916uae.8.1549412499049;
 Tue, 05 Feb 2019 16:21:39 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:19 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <f6cc28bf17d34c4b54a75dea6bd3eaccc3b17853.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 5/8] t5700: only run with protocol version 1
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
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

