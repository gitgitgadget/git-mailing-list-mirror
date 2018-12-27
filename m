Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869F9211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 06:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeL0G7I (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 01:59:08 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:56366 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeL0G7I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 01:59:08 -0500
Received: by mail-oi1-f201.google.com with SMTP id a62so12464110oii.23
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 22:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1FggbrvLr/QWIl+a6Pkz2EQGfCClhuVcCSNVWG01Sso=;
        b=jFibfMj37ss+pAfJg/KGyphr90qvMZTLW/Vx2mp0JerTfBo7HHFJbwt7TZK1/l+AaD
         G9ZxwVvuz9laPfFvidO5sYO5NKhdYqt5gc6uP3jvc2Jmh7MZCI0equ8uBxDYP4ykBxX8
         ZDaGyA4oA8m+HNwyrO/Vy2awtfZ2Z9YlN+4mbyzUPcZy13yXyR8H89uXnKSNwnJ0IyvT
         cnV+Pn87wjrHuttrxct+SsIiEhwtfmV2fdXozLTpXjmtUbggUirNoQtXQ7Ss6Jb+pRAi
         XXsKarCl6x5Nk9bILppEsbrPEsQL2sb8ipucPAZjAFV1pDhWm0y79v7cKRP5NnTMLk7J
         76VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1FggbrvLr/QWIl+a6Pkz2EQGfCClhuVcCSNVWG01Sso=;
        b=gpc6KZTJBkaXmVGiFdk8U72YGTy0Lskcl7e6i74HFzW7IbhgN2e4H7cvHuRE3esQ9q
         ikLb/0VQ4I7dxFwmI1b7VF+OyBijx/j7N6voDQqBCwmFGzn0aH51LNBLAWL4X7XIjfVE
         vFQWJ+naD2In6t06rrXRjL6TmQ1vhGUqEr7iiNDrVHQbde5tK7wQnD7xX50SvvmLwYry
         0rSdloO+R2E7wPuq6TDZT8BezadfpJkRj+Nyr0ofOKiytJ73oLENs2FRtuSCZ9BCWch0
         LURcbLedsmn0nJJz97bNIWrm0/h7JcgJWodsy9AKJbKsa9Naus5DEhnBse3jtS/SbSl2
         jqNg==
X-Gm-Message-State: AJcUukdyYs1w1LSrql5OUGhcdz6ZdKSI6ERtSY5c4Gzv3FiqKREKTJfN
        3SnD2idgNQZexNTgkddobFK/UxXtrXBgq2B6F3EcuHkmKeixCjUlmIQ9l5//sdK/4LdI4ap6CGq
        xybZdL/Nr6CQjuu+GpVjE/6RjOqutR0tH1YJpT1FhHTo5CKRU1AkBf9vz6PldcLMpQqDZdxYXrg
        ==
X-Google-Smtp-Source: ALg8bN6EhYPxICXaxhB5k0+O5Pk8aingQPkMoI9WApQdwq764ZK714QsVqGFyLS6o4TBQG6CGmotHwDI3d9Ve5LPSyk=
X-Received: by 2002:a9d:7406:: with SMTP id n6mr16625285otk.65.1545893947530;
 Wed, 26 Dec 2018 22:59:07 -0800 (PST)
Date:   Wed, 26 Dec 2018 22:58:55 -0800
Message-Id: <20181227065855.68632-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] Specify -Wformat along with -Wformat-security
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without -Wformat, -Wformat-security won't work.

> cc1: error: -Wformat-security ignored without -Wformat [-Werror=format-security]

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index bbeeff44f..aae9db67d 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -7,6 +7,7 @@ CFLAGS += -pedantic
 CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wformat
 CFLAGS += -Wformat-security
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
-- 
2.20.1.415.g653613c723-goog

