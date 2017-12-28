Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A460D1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbdL1X2h (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:28:37 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45165 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdL1X2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:28:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so46049643wme.4
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FI+yLcKfPtopAVN7QWO5cLJQeD9fe8KsnlIYH/oiaY=;
        b=sRagt2lHDGjFfSoKfwFRcpqo4GbAIix7m7kooWdioNYPUv+SZm64gJ/hVvY+XLu7zK
         /INiFlODPUZRGr2WurW/TAwizThIcuXTriUeWpbJGsmbXi2N/K/FsF02wynaKvED7DRk
         xgbTO8LoHEyHkDg/O+Udm1Fch7A/bTJhFJl3ZT+Q/6AgQ4kSHTCtLJaiiTXeq3qMmPi+
         5CClVk892o328jo2aU2TfCdZsjHt6gGD3Z9AO5QGwBI7iuAMlpwpD9y/2bWTw5gNQd+j
         yy1CNECv692Yc8+T829L+uyO8yZ1h/yOP6gTWjFceX5a1RZyqgjqX6pdAQRjZl8C4ovi
         Z6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FI+yLcKfPtopAVN7QWO5cLJQeD9fe8KsnlIYH/oiaY=;
        b=PFdSHngj+DccUNuvyv7YTdZbBVy2ugjZeew9OllNRFlfk1fh84HLt07xuSVXczfyKi
         IlWg1VQ4X8w8zOwhRsuLFtfNmZsJpGCLqJuw9nDn47Xj/GfpCWXXGM64fa/LxnMiqgQz
         z/03b2lkZcLHkBLzjg98PXbuxunw1sXRxH4CrAyH/lrAaLBQuUcImI2IilfZnI0GmjQP
         lQLZGlog4aj+qBJ1g2GQQuVpPWkwuKKyQu3EmqAqXTBKBTbv6fvh1Vk53bPb2Ay95uDI
         NMDsp0xDJZ1qR39z78iYUcGh9HojXeoGw8gSPPkW91AimizLurZ9XzM5OwuBrEDOdI1z
         cs4A==
X-Gm-Message-State: AKGB3mK+dqAJGVxMEHJPvnfUgkG17jJNQS6qVLaFrBvmEEGykmiLEzLq
        517FT7FD9iwXWGsGJE3n5elfnIXR
X-Google-Smtp-Source: ACJfBosvGBwIfuMt14u+/4TXqij9SmOvdHUgqV/zvz717ck0J0e57w+RTksOPbJncmIjRYY8mZvibQ==
X-Received: by 10.28.0.193 with SMTP id 184mr28453117wma.58.1514503714681;
        Thu, 28 Dec 2017 15:28:34 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c53sm23187346wrg.10.2017.12.28.15.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 15:28:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] increase wildmatch test coverage
Date:   Thu, 28 Dec 2017 23:28:16 +0000
Message-Id: <20171228232823.14450-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes issues noted since v2 and one I spotted myself, notes below:

Ævar Arnfjörð Bjarmason (7):
  wildmatch test: indent with tabs, not spaces
  wildmatch test: use more standard shell style
  wildmatch test: don't try to vertically align our output
  wildmatch test: use a paranoia pattern from nul_match()
  wildmatch test: remove dead fnmatch() test code

No changes.

  wildmatch test: perform all tests under all wildmatch() modes

Fix vertical alignment of new test (that was just changed back later
in v2).

  wildmatch test: create & test files on disk in addition to in-memory

* Use ${file%/*} instead of forking for finding the dir part of a path

* Consistently name tests, e.g. I had some called wildmatch and
  wildmatch(ls), but then iwildmatch and wildmatch(ls) again, now it's
  iwildmatch(ls) in the second case.

 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 759 +++++++++++++++++++++++++++++++---------------
 2 files changed, 516 insertions(+), 245 deletions(-)

-- 
2.15.1.424.g9478a66081

