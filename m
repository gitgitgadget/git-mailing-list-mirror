Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D751F461
	for <e@80x24.org>; Sun, 25 Aug 2019 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfHYSW3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 14:22:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfHYSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 14:22:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so8705566pls.7
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Na1Cdd6aBMQ5xRuGBG8Kn1df/t/kL2yu9/LE2A5dEzU=;
        b=Vtc3R4k1ySL6vnStQKhGlImcmrdIiNFW8VEa0vE2iF3FAIKsJ7Ldr/ohFDgTepy5Pw
         A5lj2NFRlwPi/RnwVTLw3D32SofK+P/1Axavc5SL7oL4ZPb4Xq0UkOSJzC8ehfN6JyL/
         L40/o6cxfHcXLfVTWTq9I09guazhiZ829Jv0T+aX768uG3pZZLBRLhwgbPAMOsbnfnOf
         zL/fqS1tYQmhIamLVpzIxJ6KbSxJZfepzd4MFvr7My25HkrwvZ/5V0wzndYkER/7LrVX
         zndCC9uC18YYjeniv7uLPq6H/gMQ9SkOJYFZ/2jIUJ1ON8PGuSJwjBt7WLIb0SGN/Ff9
         UnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Na1Cdd6aBMQ5xRuGBG8Kn1df/t/kL2yu9/LE2A5dEzU=;
        b=O6yZOCgA+OFYnV9dhFKKI68QjIB48U1RDnBJZNtDmx9bT+i8SEJ69ozoqoGAmKqoMr
         Rsacto6CwEZMAX7Tf5hfBn0JXcyT/VonfaFXPA3XQxVQVsSjJsZ5Ml4FjmV2us5xGfOl
         TiyUMLm844zjxmvT9Rxm2p87vCSJhCC19hqYEy24W8dwNAqjUWPVTFqmmBt8SF3yeCL7
         piJ32pQ1msxTDzIAoveve8yAnyHhmnkId5FwCW38xjcgzNmFy+j+GDh6JB3Mea5IBq6r
         ErTfEXFWqwpsbvb0NpdWw8nIDG8eQ6sPJ5MdfnWcwAoKVyGtTnA7qPJ4OmmENeK+Upvd
         jaJg==
X-Gm-Message-State: APjAAAUavGz+AZt+qfcu/Iy9mdgmTJ3aoq1T7vlgifJUyx3mwwi3aJVA
        1rxW/KOci+hriPYHAyYmZvQOxLJ+VI8=
X-Google-Smtp-Source: APXvYqxEZDLcEE8QrFLWaFPpsXdJWj7tcy5Yrs1ji3hDh3eId2aANULlX6YUloc9k5HCMq1mPL+KSA==
X-Received: by 2002:a17:902:a586:: with SMTP id az6mr14367625plb.298.1566757348285;
        Sun, 25 Aug 2019 11:22:28 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y194sm10334693pfg.116.2019.08.25.11.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Aug 2019 11:22:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     cbailey32@bloomberg.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 0/2] PCRE1 cleanup
Date:   Sun, 25 Aug 2019 11:22:21 -0700
Message-Id: <20190825182223.76288-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of [1] which is mostly equivalent to the original RFC
but rebased on top of ab/pcre-jit-fixes.

The first patch fixes an inconsistency from 685668faaa (grep: stop
using a custom JIT stack with PCRE v1, 2019-07-26) where NO_LIBPCRE1_JIT
will only affect versions of pcre1 >= 8.32, while support for JIT was added
to pcre1 with version 8.20.  Technically this is a change of behaviour as
originally it was not possible to use JIT with those older versions, but
the restriction was somehow arbitrary and caused by the use of JIT fast path. 

The second patch is mainly refactoring and to make sure the solution from
2fff1e196d (grep: fix NO_LIBPCRE1_JIT to fully disable JIT, 2017-11-12) is
working as expected.

Carlo Marcelo Arenas Belón (2):
  grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
  grep: refactor and simplify PCRE1 support

 Makefile |  9 ++-------
 grep.c   | 16 ++++++++++------
 grep.h   | 11 -----------
 3 files changed, 12 insertions(+), 24 deletions(-)

[1] https://public-inbox.org/git/20190726202642.7986-1-carenas@gmail.com/

base-commit: c581e4a7499b9e1089847dbbc057afbef1ed861e
-- 
2.23.0
