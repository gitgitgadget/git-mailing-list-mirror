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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3A91F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfJUUAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:00:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfJUUAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:00:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 14so7335659wmu.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ed7W/LZ04Y89yVcbfKU8idjFqRsxwHbWt1U3Y9+i0HA=;
        b=lT4pUEhSKp1xbKEKIFkVIQpfRIovjfcUJ6VvmTjvFlZXbjIbbDxGnqRXg+QNwvK6EV
         dsFu2RghI67LtKwBE1udw2K2rQrkoh2b/1hl7kgZkxKSVLm/tjA3UfdcWrmUqpclPNBL
         o4oCMQXeFBfb0YYlWeYBPcR9f/rwnLz310DijTwGvA/eEkJdkf9CSHmeFALWoKbe5i2E
         Iup591vbkub9WV9hSasoh2wEf+meZDLnlr+BX3WZia9gU7mnhoWaYBtOpGEv4yFQArvT
         59AwecsJGidDDceASLdc/b72qX93ShJCvqpGSlI8z556qaFyGe2e50nUJnqyytorHQL4
         tRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ed7W/LZ04Y89yVcbfKU8idjFqRsxwHbWt1U3Y9+i0HA=;
        b=j3Xsp9wO0QR+MrbycxTNivbKTF+2HWCbGZ6HXbG4RIaKxTF5+dajzM+lwqkmNwp/Sl
         m2Eap1w65e5GTeY3EssaEwYjw3teSBf3HdrTmCtMFUB7kmjcT7wQ26Gc7DbmUz0dHEW9
         Y8ySTuPWQJhPfa1XcEV23immjBue8NO2t2+vOX5l/K/jzAqgbhv+td8IQfiiDjvL08Pe
         LQfeuSgolWW9JYTjY9rAY+yPx/5pFjKEwKTLB4OfneVdRm7bzd1z+WgYeaU7oJDI8+71
         P3VJavdKRlgXZ59ffUuenCOoDVWhgpqH9BA/3xrCiQxru/uLZcNkG435wzWZqueWV8/V
         HvqQ==
X-Gm-Message-State: APjAAAWYp/4ARqG63atqtXFXnjkOsfBXbbqOwHubULbhe2iim2OSv+J4
        9eN4yUiSIwDn+3uaTOCChPw/6I+7
X-Google-Smtp-Source: APXvYqyeT8R1t18Q+ex4p5gIQl72KyQXlrI0PPUDcPf3sk//IcIuIPs2Bj5zqGbjDJYe1qLdJ5hmFg==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr22227824wmi.175.1571687999997;
        Mon, 21 Oct 2019 12:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm19228783wmg.2.2019.10.21.12.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 12:59:59 -0700 (PDT)
Message-Id: <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
In-Reply-To: <pull.410.git.1571603970.gitgitgadget@gmail.com>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 19:59:56 +0000
Subject: [PATCH v2 0/2] Fix the speed of the CI (Visual Studio) tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made a mistake when converting the make/prove-based test job to a 
test-tool run-command testsuite one: I lost the parallelization, resulting
in way slower CI runs.

Also, I forgot to build with DEVELOPER=1, i.e. with stricter compile flags.

This pair of patches fixes both issues.

Changes since v1:

 * Fixed typo "nore" -> "nor" in the commit message.

Johannes Schindelin (2):
  ci(visual-studio): use strict compile flags, and optimization
  ci(visual-studio): actually run the tests in parallel

 azure-pipelines.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-410%2Fdscho%2Faccelerate-ci-vs-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-410/dscho/accelerate-ci-vs-test-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/410

Range-diff vs v1:

 1:  6fba3b1c76 = 1:  6fba3b1c76 ci(visual-studio): use strict compile flags, and optimization
 2:  e3343d1740 ! 2:  07749ab720 ci(visual-studio): actually run the tests in parallel
     @@ -14,7 +14,7 @@
      
          During that transition, we needed to implement a new way to run the test
          suite in parallel, as Visual Studio users typically will only have a Git
     -    Bash available (which does not ship with `make` nore with support for
     +    Bash available (which does not ship with `make` nor with support for
          `prove`): we simply implemented a new test helper to run the test suite.
      
          This helper even knows how to run the tests in parallel, but due to a

-- 
gitgitgadget
