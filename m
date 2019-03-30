Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A461F20248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfC3WtS (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44228 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3WtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so6482260qtb.11
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzoCGUJX4PcwItKDMccmivKK8Yj2bfNaL71h9JtPwps=;
        b=vAZfLXaxLk2ed9erRV5J1i+Wtsi/n3dfkGvdO6Ardj3FmtOFd6gjb1Z8V3X5W+GOjC
         MaAS5qUocZRLIEmP+kFhRyFj+Y/tiVgocBOXZrpHm6ndR+zAuX2Yc6sU8b/3LpXrLW8O
         D6Czod+4DNjqgCnBB/AUKm8PeslfKqFsNT0TwAx1mRIpasQNqW/hqvlUW6LxH5vq92nD
         aiYhf54j4LlH0ytkus5BMgMJ8COWjUQfscHy/uXDWDVIenBPWvIYzYVepJtvOuup+9Gc
         GzEmYY5GPoIdfVryDyVwEs6q6o+rjGcV4+B5R/oRbqE/1JbO9xovPj/KYUFJBlO7IugD
         50zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzoCGUJX4PcwItKDMccmivKK8Yj2bfNaL71h9JtPwps=;
        b=hOFa71dtI5EvU3+VGjphpgdZcI64nsKXrHhV2mvzQGLfhGh48ffrxdLqqT4hlriohH
         rCUQJpqx/Vx2l3bf+esg5bR6gYiU+gmO2sSB4DsJEqM6xgu/3vZsQbWI1DilY09ZOPi1
         VeV5RCuhQ7Jmm6/91aDEADXVbeaLI2W93pkX5RYgYo0jdkRpXfWbrIzfBBjCnLJm99cY
         SJLplOKzJvn0EWvFz3zKg3CrdW+gBWVtsY3l0AUHG9WqRvzOX6wkmmfQhpN9Q/IlHn2C
         zJX2n6kPv8ln2wed726547XYpwvuN58X8W2JJ7LDa4tlEMW/POEbPJ4cgFSIqpxD3c+e
         Hu8w==
X-Gm-Message-State: APjAAAWbV5RGMR3bZfhZK58hZMutrTpKpJ5rVdn6xTAI393WXebBn8jL
        YB9WCsGfM89YdUXFDT0RRFgmmQ==
X-Google-Smtp-Source: APXvYqyaZK8Hs8VQvJqKVp+5ANipVGp0iJyZIptoxzyldc9gREEFIJgj7cHvDrFKTZZQOrvi+lqOEg==
X-Received: by 2002:aed:3f57:: with SMTP id q23mr48606595qtf.301.1553986157200;
        Sat, 30 Mar 2019 15:49:17 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 0/7] clone: dir-iterator refactoring with tests
Date:   Sat, 30 Mar 2019 19:49:00 -0300
Message-Id: <20190330224907.3277-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset contains:
- a replacement of explicit recursive dir iteration at
  copy_or_link_directory for the dir-iterator API;
- some refactoring and behaviour changes at local clone, mainly to
  take care of symlinks and hidden files at .git/objects; and
- tests for this type of files

Changes since v4:
- Improved and fixed errors at messages from patches 1, 3, 5, 6 and 7.
- At first patch:
  - Simplified construction, changing a multi-line cat for an echo.
  - Removed unnecessary subshells.
  - Disabled gc.auto, just to make sure we don't get any undesired
    behaviour for this test
  - Removed the first section of a sed command ("s!/..\$!/X!;")
    that converts SHA-1s to fixed strings. No SHA-1 seemed to
    be changed by this section and neither it seemed to be used
    after the command.
- At second patch, removed linkat() usage, which is  POSIX.1-2008
  and may not be supported in all platforms git is being built.
  Now the same effect is achieved using real_pathdup() + link().

v4: https://public-inbox.org/git/20190322232237.13293-1-matheus.bernardino@usp.br/

Matheus Tavares (6):
  clone: better handle symlinked files at .git/objects/
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal
  clone: replace strcmp by fspathcmp

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 builtin/clone.c            |  75 ++++++++++++---------
 dir-iterator.c             |  28 +++++++-
 dir-iterator.h             |  39 +++++++++--
 refs/files-backend.c       |   2 +-
 t/t5604-clone-reference.sh | 133 +++++++++++++++++++++++++++++++++++++
 5 files changed, 235 insertions(+), 42 deletions(-)

-- 
2.20.1

