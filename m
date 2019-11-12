Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6187A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 16:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKLQ6Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 11:58:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 11:58:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so19376852wrx.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cvYrtcGgvh+zdSmt3MwhWvhIkIU5/ZUYpG959maBlOU=;
        b=te50vw9QYpt6nKcQfdDGet4E0NEggjfkl8BSlvd9BCLl3vzVIoO/pbaKpaMxFjDJ7l
         kyQ1jCZ69yPO4pOJJ8TlhYIBTzAgWDHEmT0mUzwibWRIJvVS7MhNnze0qA6o+IRCvvea
         6L+Mm2r56AQHjr8MLtueTd2OwDrcDfE2e6nG3M2kB++RHfBXiAATZGec/tnHFk58L7rw
         ivJ5u9mSqotycf/HyxWDRlAq9VJEcZvqrbNskmKaAhbOvOZf1v+eeSx079HEAScEbeNc
         nN3AAsqtxiVfibCMCXbW1pTKxqmRYCT8XUhYLOiBA+AW5s+aidZku137jqzcsFZwk2pz
         1jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cvYrtcGgvh+zdSmt3MwhWvhIkIU5/ZUYpG959maBlOU=;
        b=UU5NgsUewKkWEJIXasqgK76CrOqan0gww2yqDMBpndBb/M/CjDL+gw0PyCi/D3Fg0c
         oPAKMwz6qfsdC6ODkFDfUUpiWC0+w7EgyLg5Q9QtycQ9HqtSo4QMFPp8mfhmbho8vt/I
         mzPNybWv4nlXwB4HOp6enL6wrtmaxWuR96vcaY21yTSVeJrBQLVpo1qZpyfzd2SZ0ZyO
         uXENwG6Wus8EjvILaNo/1JOh34veJ6eZMc081qGpdFmW1mzxv4MwLUUdX066+3EcYYGp
         vND+QPmpIxGvf4GaSl2iS4yoag6oXCynOw342H7+m1JUqIuSA7SSjp1fuUHrJALBdE69
         k4Hw==
X-Gm-Message-State: APjAAAV+7Cke34c1ub0zNfFFve2DqPWxiXarFNV3lvEg+xjO9XC9T7Mm
        JfgMjwF2+YwvgW569V8JeokQeJ0F
X-Google-Smtp-Source: APXvYqxo85lFDJhfvkZFJQpLTst3OK275UTkICfShXd9p05fw94rUggo5Zc7ULuauln3nVGEqiKwuA==
X-Received: by 2002:adf:ab4c:: with SMTP id r12mr25506328wrc.3.1573577901953;
        Tue, 12 Nov 2019 08:58:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25sm3448685wma.20.2019.11.12.08.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:58:21 -0800 (PST)
Message-Id: <pull.460.git.1573577900.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Nov 2019 16:58:19 +0000
Subject: [PATCH 0/1] Move 'git commit-graph read' subcommand to test helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed [1], the 'git commit-graph read' subcommand has little value to
users and should instead live in a test helper. The implementation was able
to move almost wholesale, with only some new code to find the default object
directory. This was necessary because of some tests that use a bare
repository.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com/

Derrick Stolee (1):
  test-tool: use 'read-graph' helper

 Documentation/git-commit-graph.txt | 12 ------
 Makefile                           |  1 +
 builtin/commit-graph.c             | 68 ------------------------------
 t/helper/test-read-graph.c         | 53 +++++++++++++++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/t5318-commit-graph.sh            |  2 +-
 t/t5324-split-commit-graph.sh      |  2 +-
 8 files changed, 58 insertions(+), 82 deletions(-)
 create mode 100644 t/helper/test-read-graph.c


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-460%2Fderrickstolee%2Fcommit-graph-read-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-460/derrickstolee/commit-graph-read-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/460
-- 
gitgitgadget
