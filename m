Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C809D20248
	for <e@80x24.org>; Sun, 24 Feb 2019 22:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBXWMN (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 17:12:13 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41569 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBXWMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 17:12:12 -0500
Received: by mail-ed1-f46.google.com with SMTP id x7so5980305eds.8
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6gtQZL1RimYoTp0tZU/mqrtSK6Yz2z2rMTrTLNL6zNw=;
        b=L91kSh3luRREOuQQ39YmWVaBB6JMJsX7FnK5ZHz1+xPM6fgxcqnq37FUYmjcDiZ3VE
         QgIwD7Syc75ROCCWvPQlS6eu9BJdQ7lbbQamGHYi8jal8zERlQFV3q3DdT7YA8YvQW+7
         xRsjtmRXjU0IPV+0rEMnBprxXSNW9e/PmqwHaGEvzMRmUhoi9Rxi5UEpShMyan/vq3W+
         ZZnwX/ihGvF/bfEacxXIhl/HwNQ2Gk/jRS9rCRViJi0B2N/CKVkd25RGIEfb1ljEhBTM
         xg4TyP/Fn3CERHIXEqfvWhH0qkmJHHA6M504+Xni+CjHKa1DB9SPMXLrUg8hEgKgyGz5
         idEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gtQZL1RimYoTp0tZU/mqrtSK6Yz2z2rMTrTLNL6zNw=;
        b=V5Vovd5h2tBQemPg4y7jaI/Ee1/CEqFrR4pWdzGCDrBYUaJOVB5jm048jfofEaJTJ5
         3+PKH+CJOjUiLagoqwsDOmZHRNoaKPjaEj6Wt76Mn3Z+P+7NVvzUhdas0XGJPkE5PpzQ
         NuadryuD/LUgcqKTqBZSWAJ6kJJyVC6j3+QAn18ZN27y5N/QsrPS83Ow3FNH/P0KBcjO
         01ZJSZ3wOs0Tz8sXbhZhdFvr6F9r6EKISMZXqxp/Y1POIMoS+ySf7QQHxeFImktwrgF9
         nRANBQERHAtv3vuYlFaIgBhySRt1aRZPmBo6IaTqcxINcL5nEJxqWbvmJjuzyet21LV2
         aiTA==
X-Gm-Message-State: AHQUAuakSxbDVB7xDoooWUXZGKog4BG7J4Pg7zycljf8oA3tXgyLUfKR
        wlwqfHjHH6EnTAp3sJValt5HVCy6
X-Google-Smtp-Source: AHgI3IY+Tf0RPdh43uuMJRM4KyED81Js46BO75VMuCrR7mepD/DVXiTo6yTFHCnm8pT+f+MBJfn5Jw==
X-Received: by 2002:a50:90ee:: with SMTP id d43mr12074685eda.129.1551046330819;
        Sun, 24 Feb 2019 14:12:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gq12sm1440373ejb.21.2019.02.24.14.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 14:12:10 -0800 (PST)
Date:   Sun, 24 Feb 2019 14:12:10 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 22:12:08 GMT
Message-Id: <pull.139.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] jt/fetch-cdn-offload: fix build with clang
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this is actually legitimate a build error (see e.g. 
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=2394), and I
am quite surprised that GCC accepts this.

Note: after thinking about this for a while, I guess an empty string would
work, too (i.e. "" instead of " 0"), but I already waited for the macOS
build to finish at https://github.com/gitgitgadget/git/pull/139, and it's a
fixup! for Jonathan to pick up, anyway...

Junio, could I ask you to apply this on top of your SQUASH??? to fix the
build?

Johannes Schindelin (1):
  fixup! upload-pack: refactor reading of pack-objects out

 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 2c31d711669adc7a7bfad06df37b976af99dfaa6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-139%2Fdscho%2Fjt%2Ffetch-cdn-offload-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-139/dscho/jt/fetch-cdn-offload-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/139
-- 
gitgitgadget
