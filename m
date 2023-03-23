Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70128C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 22:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCWWP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCWWP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 18:15:27 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076893598
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:15:26 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-17997ccf711so24134fac.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679609725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3GCNb4ZYl/PpRT4JBxeWiFTBZFevkTfQ0rvTxsKHg0=;
        b=IYlTXRsPPyfTIoJchp0WM57me4Annw8UTHBZf6f5zv3j2P03p3siRHHZUHhPHIxxE0
         VzwXLoNBhNGW+t68ixxwb5vPuqEC8XpezyhR4JdBUuQWomm++9v3dt1YPvs/CEomGLGt
         9lc5sNZhEWtGLXJV9EgRTg0O0OrfL/XXHsEiplVZ9jxesXRop1rNQBSLxrsQkP+ItUri
         K2sIOKwFIroWV1nncvHnFCxfyJDo/SdQSY/Ac2wo8vqNgVLgswgyPCvRcXSBVD5YbWX4
         DHi/diRPhUBx0mJgCyjxArSd9OyApJQF1brbMvquchnJQcLLwFahiA+70nj83Z8odk87
         w2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679609725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3GCNb4ZYl/PpRT4JBxeWiFTBZFevkTfQ0rvTxsKHg0=;
        b=HvQjNvtdxS5AC/vD0NF0nk3OYJMM9jsXvsbiY4/3oVHJAsuXsxzNMhNXefBKuebbWz
         cU2YgVbpL//6OTQ3gluT79Mk8hl/vej1P+Kfa6CjxQcH2vzS+pPRjNAGlQ0KN68NEbvW
         NwHB4vXeXOr1h5VXx0kB0t/IrI8DceJaSHBt7HrHTJ2/mPAOcMIMiTxpdjCIRKNnbmJA
         j9sXdM0BY8SSyMWR1P6hDgb1g2ZdPNgsCaSs0vE2BNLyqiiQZ1at/ItcR79vti93aQlG
         znUqUX6WJPFmk1EWNzxMrCaW/PGS1nNsVgVMYtrFa+5qO2wSJq1IKvuKlCPDOwPgUVHR
         fuxw==
X-Gm-Message-State: AO0yUKXOs1ERhO+LFTfISr0x9WZSEt8KIo75OAjwXpGK3kSHOL15Vrx9
        o5jrgwgP7CTmwFomRkeBM56hYml0bDc=
X-Google-Smtp-Source: AKy350YAuahvCk56MrdTH8/Qv6bMqW45lB3IUb9QMS2k6y0UOyjOF42X/pCzgllXyRENxE4RoTno1A==
X-Received: by 2002:a05:6870:c5a5:b0:17a:d08c:c8a8 with SMTP id ba37-20020a056870c5a500b0017ad08cc8a8mr437274oab.44.1679609724970;
        Thu, 23 Mar 2023 15:15:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id hv12-20020a056870f98c00b00176209a6d6asm6628480oab.10.2023.03.23.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:15:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH] doc: asciidoc: remove custom header macro
Date:   Thu, 23 Mar 2023 16:15:23 -0600
Message-Id: <20230323221523.52472-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2007 we added a custom header macro to provide version information
7ef195ba3e (Documentation: Add version information to man pages,
2007-03-25),

However, in 2008 asciidoc added the attributes to do this properly [1].

This was not implemented in Git until 2019: 226daba280 (Doc/Makefile:
give mansource/-version/-manual attributes, 2019-09-16).

But in 2023 we are doing it properly, so there's no need for the custom
macro.

[1] https://github.com/asciidoc-py/asciidoc-py/commit/ad78a3c

Cc: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 3e4c13971b..60f76f43ed 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -51,25 +51,6 @@ ifdef::doctype-manpage[]
 endif::doctype-manpage[]
 endif::backend-docbook[]
 
-ifdef::doctype-manpage[]
-ifdef::backend-docbook[]
-[header]
-template::[header-declarations]
-<refentry>
-<refmeta>
-<refentrytitle>{mantitle}</refentrytitle>
-<manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">{mansource}</refmiscinfo>
-<refmiscinfo class="version">{manversion}</refmiscinfo>
-<refmiscinfo class="manual">{manmanual}</refmiscinfo>
-</refmeta>
-<refnamediv>
-  <refname>{manname}</refname>
-  <refpurpose>{manpurpose}</refpurpose>
-</refnamediv>
-endif::backend-docbook[]
-endif::doctype-manpage[]
-
 ifdef::backend-xhtml11[]
 [attributes]
 git-relative-html-prefix=
-- 
2.39.2.13.g1fb56cf030

