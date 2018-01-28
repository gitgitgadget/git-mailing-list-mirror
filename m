Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2781F404
	for <e@80x24.org>; Sun, 28 Jan 2018 18:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeA1Scr (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 13:32:47 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36262 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeA1Scq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 13:32:46 -0500
Received: by mail-wr0-f173.google.com with SMTP id d9so4848492wre.3
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 10:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=oPOABW9PyavRyBTdXwCrLtWxkwZzUfuoUFKuC28uZ8E=;
        b=M3kSItwYebbO2+SgAM0BsdqTWkRCLdoxdiOIFf19JEciuxcQn5hyPbPc9QuAwf4qpF
         pxx3KoIFCQ14inh5xGC/CYq8sYboCQIcQEM/TPshG4LcQQznarbRCZbo5fvkvF98D2kQ
         5MBvyMtI68+UNB3JY971ktI17JaCxGqGgwgw13NG1RhIIxl8Xun8QicGPlEIRLSj3KA6
         VGlazsCx7MMnC822h5sqO34VDOy4rkT6X1FSiueArlEY7f760x7md2EKq2r1AXRn3Ep4
         2PWoxT4fQDqqvydQ00l42OG9foIMF7FOZ78e4zkzkORk3/vlcStOj4k+Pc46aUa7461d
         OKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=oPOABW9PyavRyBTdXwCrLtWxkwZzUfuoUFKuC28uZ8E=;
        b=H1Z9CscTPx5QPbZXG61swhpAmFfONzqsJIw+FSn9HmNqkd+uiezYVmx+WU+UYE803O
         fZnMCESESBhprpWK2GHLgjkwJfGU57s/ezerKgO5RFuTAM9vbMfltymBVbl/TSIJIJaI
         f4oXE7mqR/ctFWmCth3yFqed1Dqf+2sXI5sEkyu3oiC+LLQdsa3x8E04sbfHZklP7Tey
         6MlKiHbXsFwM2yVBI/qjSoLJrp+q0SDYEeD9tVkaxu3R1J8pGulAucypZl7Pqb8b9DAb
         OE6fBibJDekFA102kVb5FRFWJjXhNE5Y6cKLUd61tksShPRPig88Gk80CU8PzbX9YcJW
         aowQ==
X-Gm-Message-State: AKwxytcXfap5ciEysvHQ/2qdYpjRp/k4Kw38U1G++H0MXmnadnkWxulw
        UmGBpTGkwxHOf3Z0dhEEn7w=
X-Google-Smtp-Source: AH8x226A4MoVZqFQS7gpydpIsKKLhXWAv05pNd1UVuGnVu48gbheKoe/CQKiWe8k6wPcAFhx+yS7kg==
X-Received: by 10.223.154.134 with SMTP id a6mr9736657wrc.246.1517164365753;
        Sun, 28 Jan 2018 10:32:45 -0800 (PST)
Received: from localhost.localdomain (x4db128a2.dyn.telefonica.de. [77.177.40.162])
        by smtp.gmail.com with ESMTPSA id d73sm11051789wma.25.2018.01.28.10.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jan 2018 10:32:45 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] alternate hash test
Date:   Sun, 28 Jan 2018 19:32:39 +0100
Message-Id: <20180128183239.11237-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series wires up an alternate hash implementation, namely
> BLAKE2b-160.  The goal is to allow us to identify tests which rely on
> the hash algorithm in use so that we can fix those tests.

> t9903-bash-prompt.sh                             (Wstat: 256 Tests: 66 Failed: 53)
>   Failed tests:  4, 6-10, 14-34, 36, 39-62, 65
>   Non-zero exit status: 1

I didn't recall seeing hardcoded SHA-1s in the bash prompt tests, so
went to have a look.  And indeed, these failures are not the test's
fault, but the result of a segfault in 'git checkout' while trying to
return from an orphan branch in test 4.  The rest of the failures are
mostly fallout caused by the wrong branch being checked out or the
leftover index.lock.

$ ./t9903-bash-prompt.sh -v -i
<...>
expecting success: 
      printf " (unborn)" >expected &&
      git checkout --orphan unborn &&
      test_when_finished "git checkout master" &&
      __git_ps1 >"$actual" &&
      test_cmp expected "$actual"

Switched to a new branch 'unborn'
./test-lib.sh: line 609: 29342 Segmentation fault      git checkout master
not ok 4 - prompt - unborn branch


$ gdb --args ../../git checkout master
<...>
Program received signal SIGSEGV, Segmentation fault.
0x000000000041b636 in merge_working_tree (opts=0x7fffffffd200, 
    old=0x7fffffffd0d0, new=0x7fffffffd1e0,
writeout_error=0x7fffffffd0c0)
    at builtin/checkout.c:525
525                     init_tree_desc(&trees[0], tree->buffer,
tree->size);
(gdb) p tree 
$1 = (struct tree *) 0x0


The root cause is that patch 2/2 misses places where EMPTY_TREE_SHA1_*
constants should have been replaced with their EMPTY_TREE_SBLAKE2B_*
counterparts.

