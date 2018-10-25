Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1F21F454
	for <e@80x24.org>; Thu, 25 Oct 2018 11:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeJYThN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:37:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42216 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeJYThN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so3813177pgq.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zM1UjEZubv+e7YIl9Uy380SetgArCC9wP6ftrL4cDio=;
        b=TnqzQJgtihXr+7knvnV0sLMLG3Hcw4sA+nBbCgFO8t7bDF/tu9aDixCHA5ZZKrpapR
         JFDi1p8zV3QSQby0vHp2KugcHZU+KMDIqPN2B8ViksoxXh9eNSxVtmpCYI4bqpuM5FH+
         Iv4uvs+GCTWY7nBARs2iEBZeKmRsEBpe36FPZx4eQrtakeiubOIZRMiG2vIaiEfFpIhE
         /oezuUWqnglPGtciYmkM/wXujb81NkBwlrtSMmcv7R7jy4TP5zSfflThVoMnPmEqx+8X
         vl+84YWbymwsehROHK2Q6gB9yTBgGZ1fa4FZVuXaiwp55c0VUIq/xwbSINVj+4MPtV5Q
         HQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zM1UjEZubv+e7YIl9Uy380SetgArCC9wP6ftrL4cDio=;
        b=DN8xB8PhKq5OLx4NX53sUikl0OQ4KjVk3nGJuIvSxAsWeuSIXUmc6Tn7gbYbJTIClv
         2SIIHoiIha4J0eOdfS1hHZiZxpUoB6gNWHuiOCThR2gLGv9Z67yqBQRDxqiAVt2AHp6H
         GuywQdo655a9GmK8gQh39YD3HkfchpjHl0S8jOd72JYlq01o/F0Ew3rfPZfhYrbr+TRJ
         GXZD+gfDOUBGh4J+gWmi0YpEn5nraslEyEv4Q3XmWnk6O0SAoViuHDMGrAo/XHPgFtJ1
         5TK9UMCx9uOp05TWSTeqYh7tOTmUJohaLKekNgCQ42bA0MhHidOavjZhkY22W0HXm/l6
         4ZDg==
X-Gm-Message-State: AGRZ1gKhkpMx268oU5LkPbZ0MFowv6BpczNQNP58Sb4QcPP9UuaClBI1
        4ebgJEfdO1zjBu297Dw2/ammohV4fYY=
X-Google-Smtp-Source: AJdET5d7/SHKRkBJt+GQ26+HAidFopfe6U8Qi2SiQyVpsRva3GKBjoPP8OboSUWp/voHRCuDuWqALg==
X-Received: by 2002:a63:5c16:: with SMTP id q22-v6mr116077pgb.417.1540465496434;
        Thu, 25 Oct 2018 04:04:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 74-v6sm17545405pfx.182.2018.10.25.04.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 04:04:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/3] delta-islands: avoid unused function messages
Date:   Thu, 25 Oct 2018 04:04:24 -0700
Message-Id: <20181025110427.13655-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the macro generated code from delta-islands (using khash) triggers
some unused function warnings in macOS, OpenBSD and some linux with a
newer version of clang because of its use of static functions.

Changes from v2:
* Relay in the C code including git-compat-util as suggested by Jeff
* Commit message cleanup
* Make changes hdr-check clean

Changes from v1:
* Use MAYBE_UNUSED for all cases as suggested by Duy

Carlo Marcelo Arenas Belón (3):
  commit-slab: move MAYBE_UNUSED into git-compat-util
  khash: silence -Wunused-function in delta-islands from khash
  commit-slab: missing definitions and forward declarations (hdr-check)

 commit-slab-impl.h | 4 ++--
 commit-slab.h      | 2 ++
 git-compat-util.h  | 2 ++
 khash.h            | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.19.1

