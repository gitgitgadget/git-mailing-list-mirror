Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7E31F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfFRX2Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:28:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40881 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:28:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so17669265qtn.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kK57NPvbysnfF0vpDneZm4YVRPoaqbSksE+FPP+2SRM=;
        b=q1qpRxnES5VoZvS1ReqBrMByVXmjCS8hML25Ykc+Ic2G2wqwNScdPjzjaGw95iIFcP
         KZsjOHNnsVzkzzZ3Fhlrn5BB9IZFqX8wHGCaCX7us1PxIRI6b4azUbNlre43/UdvT+SJ
         l+OdXzylJwEuRhIJeAWrvwEe/4A0Jc4FQLYbGFAtxB3NPGZzxeIeCJ5UynlhCgZqtldZ
         yrke+gwZ8eB15TxtXQQPwb2o5HbNRv+wVF4TROxnxuDRSuhCGl/xl7aE7fkgzNY8Q0hE
         V8oOo+TrzUDuOPEN3U84aFW1vLp4PY6OqB91+FVj10Gr+v70w0IK9IsjQWL6hGMR0w0m
         hn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kK57NPvbysnfF0vpDneZm4YVRPoaqbSksE+FPP+2SRM=;
        b=tO0AxcTKLNefb3rVHW9GbcpjK0+YmUpg9qDwBOtri1/0LKkWjX2G6mZNl8X6PEXMTE
         E8NRGy8glpJjdPs1gv+IEeSDlYoE9XBGuv7TDMhkb8RD8L5hLV8dPICZXEwKuqj3O0g3
         6HFAFJXP92RZW3IZwWCLKQfu2M9YjW4hF6XLBnBd0KHpEl8rbYSmVWyaPrVnwdwGQVeA
         /gZTlCaqfzPNIXUvu9tFcz5DcEKAm8DZURhqsdXt0DSVnU7vR9ujI3IB5SyNaVavafa1
         UH9aCVb5tpc1B0i1LMQK29Qt70WgSgjuf3cyvGjPmjxK3mO5AkQ5HgtzVm0mZ8l/CGJS
         GpTA==
X-Gm-Message-State: APjAAAX8alcXSXy15ALic8OIxgGTF1KSasNG92te904aPcd9/Dq9GTYK
        AoW9w+E6xO4oNax3b4hJVig3PNV/iH8=
X-Google-Smtp-Source: APXvYqxZaUrvFiRhs3FZsYj5riAnyaZ1mBJcU73BpckMbQKEwnr+NK1UbsiZ3maGdaPm4OFdbJgvpA==
X-Received: by 2002:a05:6214:1024:: with SMTP id k4mr29501872qvr.124.1560900502845;
        Tue, 18 Jun 2019 16:28:22 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.28.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:28:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v7 00/10] clone: dir-iterator refactoring with tests
Date:   Tue, 18 Jun 2019 20:27:37 -0300
Message-Id: <cover.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190502144829.4394-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset contains:
- tests to the dir-iterator API;
- dir-iterator refactoring to make its state machine simpler
  and feature adding with tests;
- a replacement of explicit recursive dir iteration at
  copy_or_link_directory for the dir-iterator API;
- some refactoring and behavior changes at local clone, mainly to
  take care of symlinks and hidden files at .git/objects, together
  with tests for these types of files.

Changes since v6:
- Rebased with master;
- Added to dir-iterator documentation that ENOENT errors and hence broken
  symlinks are both ignored.

With the changes brought by this patchset, dir_iterator_begin() may now
return NULL (setting errno) when it finds an error. Also, it's possible
to pass a pedantic flag to it so that dir_iterator_advance() return
immediately on errors. But at refs/files-backend.c, the only user of
the API so far, the flag wasn't used and an empty iterator is
returned in case of errors at dir_iterator_begin(). These actions were
taken in order to keep the files-backend's behavior as close as
possible to the one it previously had. But since it already has guards
for possible errors at dir_iterator_advance(), I'm wondering whether I
should send a follow-up patch making it use the pedantic flag.

Also, should I perhaps call die_errno() on dir_iterator_begin() errors
at files-backend? I mean, we should continue returning an empty
iterator on ENOENT errors since ".git/logs", the dir it iterates over,
may not be present. But we could possibly abort on other errors, just
to be sure...

Any comments on this possible follow-up patch will be highly appreciated.

v6: https://public-inbox.org/git/20190502144829.4394-1-matheus.bernardino@usp.br/
travis build: https://travis-ci.org/matheustavares/git/builds/547451528

Daniel Ferreira (1):
  dir-iterator: add tests for dir-iterator API

Matheus Tavares (8):
  clone: better handle symlinked files at .git/objects/
  dir-iterator: use warning_errno when possible
  dir-iterator: refactor state machine model
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal
  clone: replace strcmp by fspathcmp

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 Makefile                     |   1 +
 builtin/clone.c              |  75 +++++----
 dir-iterator.c               | 289 +++++++++++++++++++++--------------
 dir-iterator.h               |  60 ++++++--
 refs/files-backend.c         |  17 ++-
 t/helper/test-dir-iterator.c |  58 +++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0066-dir-iterator.sh      | 163 ++++++++++++++++++++
 t/t5604-clone-reference.sh   | 133 ++++++++++++++++
 10 files changed, 635 insertions(+), 163 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

-- 
2.22.0

