Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1201F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGDJOm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:14:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43189 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfGDJOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:14:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so4730899edr.10
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=p6xVUhHSfFr7pgHtW2egmQwWOKTSSqVpSym620nh58g=;
        b=Q+JXfvoza7nBaifaq3k45RQdoumtVfA0dm9TsfbfD5RWrDZUg4EpNsDQIdBQG9O8wD
         OybyjYT89z3mgBT2leKCdN1YIzBFQ5mBVdTii6MSjz+/wuOMHyleEC1kdunFfy608SkI
         0wXIluXM9E/bzAZN39phnaWUhmIWlwLiqXKi+nXNlWfrjLvzuMGLgVsgZUWyicQ50S6+
         uOFQo9EH/z8PoPfKPu+Ouq3MeXPeSnnpf+FjA0Q88JaO85Y1EooHw+jCGnC1B7S74K+h
         p1CMPkzlBInRY1zYQ6PXkaRiLCOfi7yJIQxWR253TdTvuzxKeeoIW134JmUsGehiTo1Q
         sHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p6xVUhHSfFr7pgHtW2egmQwWOKTSSqVpSym620nh58g=;
        b=Qy+1ySFEcjSZgWTjkgYKcNjNP/qpwbN+2msnDS4o5nDJmP2WK0htVaQKu2wgRyLJ6+
         VHLbLHdiBHIXJPrx2In/SZhWP7e+YdMjEKV0CI5IsjbhsYBrW7QqUzzNlXGStNGh8PD7
         nab9Y3sB/RPYVa3mCvtTZhdHMTAoXKf9MpMomDx4b/N77cZ2b+FrIihcFwwVDhktV0p6
         hXxj/tmNbbUhNp4V2JNWu0gBPOtJrA3tRb9WOR1imwjlSC5CAqKzHS7tS/2Srn4pCC+U
         7XxLHz8rFPuW6nN/2dEsN4tQ0OjjGC8Av17KUudjrmQTyyPgRAOF/bjSUMVW5CNlzC8Z
         B1aA==
X-Gm-Message-State: APjAAAWiWT88RTgDSxfWjwWF4M1XTnhoRtO/bWJQlTvnkzcQXHyKzgH5
        Qz753iGTeeWNTxHeHDRw92NvZC7X
X-Google-Smtp-Source: APXvYqyFVQloy9gsDYB0YDlMSTaQ6QVl9LA7MEeB9akYMQ797j5gvTfWyPuZTSCDNsBhZWmN45IE0A==
X-Received: by 2002:a17:906:318e:: with SMTP id 14mr38542738ejy.85.1562231680555;
        Thu, 04 Jul 2019 02:14:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm954756ejo.77.2019.07.04.02.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:14:40 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:14:40 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:14:38 GMT
Message-Id: <pull.216.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] windows: avoid illegal filenames during a build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The + is not allowed on NTFS filesystems. Even if the MSYS2 make/bash we use
to build Git for Windows can work around it, it is not necessary.

Johannes Schindelin (1):
  Avoid illegal filenames when building Documentation on NTFS

 Documentation/Makefile | 88 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 44 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-216%2Fdscho%2Fmingw-avoid-illegal-filenames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-216/dscho/mingw-avoid-illegal-filenames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/216
-- 
gitgitgadget
