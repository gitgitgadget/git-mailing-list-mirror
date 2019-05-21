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
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8BC1F462
	for <e@80x24.org>; Tue, 21 May 2019 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfEURuW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 13:50:22 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41734 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEURuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 13:50:21 -0400
Received: by mail-ed1-f54.google.com with SMTP id m4so30630993edd.8
        for <git@vger.kernel.org>; Tue, 21 May 2019 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/B73RZPr9DSu+9ApR7CvqW2RhxEt9mVXyId0S3ixz3I=;
        b=N2eoYR4cqSSexmnxvfq6szyMv+uZ6wAWSRVn8iismyQB1E/ASPaelbpwfBFVGtNEAc
         Y+yPOZEZfufc+t1n8NGfADG4g5LK8hVOfKcENn6aFrtseOR3NOELypDmc/PDbEEmw5ye
         avi94YLm2oxZ/nq5qgXTmEJMeBJaHHklsWwJO0Oysupq+hJODGbJXq5uESn3WYCZUQEu
         TBXGJRGh+xHbNaSr1r+Gm9mHdW1l8wy7S67EWHm4XyUbwtcjWCFTDesCpFpuTLgpwu3m
         nr4IcKvTVflotfOyQDzO/L/+YusS4RO1fXYmG7FwSdidrAkQrP3Ey3yFvGtjlglfsK/s
         qnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/B73RZPr9DSu+9ApR7CvqW2RhxEt9mVXyId0S3ixz3I=;
        b=d0+pbv+g7qcz8iQ7LIJ8Ow3RFL9DO69XHbZMT/X7zfO0RZQuzg9vRndTuR5JXK0hXp
         J7633tWV6AwWSL40n2Ltgh0RzOqgOjtV4s7SVwJ6k3689chqqk5WK/BTGeyN7GnNNnM0
         O9dQeWKdoiUb1CZTIOvPoVOjUxgyo81cURdWrPRHMUOi1TMgqcDmvHZPeIMLBTJYsQb6
         pTh6x9ZV9XkcZOfxMGDKTPncaL95vu3YreDPl4N7gIR5cQ2kbJE15jf0tYloCz8zhibM
         07jyxBXvkHWFutUiYX5vGSgoRrN8sCLIUpeecFI4yOI2HmID8KUGGfmcIAdNsFnICoi6
         nWGg==
X-Gm-Message-State: APjAAAUVB5LtUe9v4od2DklE3T3NLafN+1mgLlrzp6fNgL2Mz2DY1dga
        Kdnpsw4P5WJD+UxUa9GjvSTqLwxp
X-Google-Smtp-Source: APXvYqwj48uI29p7nAEjJ2C0s1rfDJ4UezrydlEpTcJ0hb3xMMrYuNpPQgJ0rnyZkHFU0uaQKkpwTQ==
X-Received: by 2002:a17:906:3e85:: with SMTP id a5mr65819598ejj.272.1558461020006;
        Tue, 21 May 2019 10:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm6449602edd.64.2019.05.21.10.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:50:19 -0700 (PDT)
Date:   Tue, 21 May 2019 10:50:19 -0700 (PDT)
X-Google-Original-Date: Tue, 21 May 2019 17:50:16 GMT
Message-Id: <pull.221.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix two issues pointed out by Coverity
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

I looked very briefly over the issues pointed out by Coverity, and decided
to pluck these two low-hanging pieces of fruit.

Johannes Schindelin (2):
  rebase: replace incorrect logical negation by correct bitwise one
  bisect--helper: verify HEAD could be parsed before continuing

 builtin/bisect--helper.c | 5 ++++-
 builtin/rebase.c         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-221%2Fdscho%2Faddress-coverity-reports-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-221/dscho/address-coverity-reports-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/221
-- 
gitgitgadget
