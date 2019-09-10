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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBE21F463
	for <e@80x24.org>; Tue, 10 Sep 2019 05:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfIJFQi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 01:16:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42101 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfIJFQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 01:16:38 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so34620757iod.9
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHZWP83OyXvvBaeQLFSnC+ilzR6oEdXHY42gwFxUTO0=;
        b=EpKzH2E6e7SBCWslGR7p19MjM4Yb8iOoRUJXtBug/X7mtEbWdvkmwDuZq9Lw9WSID9
         XXB9G7fqZkPHj2K2aM4RgCkjg7WLDWLEeB1FCZx3TFyphWs7Dswa4PY5AvWoEuRakVsM
         fFBlxOUxuOqO1ivpJGMqaPWMl+M2VwFZGo0x3sLB9JKp3tUYR0sR8+fBSzi6KyiB3PDu
         SbXGxWlve1PW2wca/nqq5e/T6NdTwA8aNtKgPrSWHwjscH4aUamAyr2v8tuIGjYCHgtj
         Mw+hkEEhlzIpzyYNu2lnbvwXSVkOYF1jdjT7Z1SJrbK4RT2d0bBdLDIRD7RnDQLnrCAa
         JJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHZWP83OyXvvBaeQLFSnC+ilzR6oEdXHY42gwFxUTO0=;
        b=Mx5ytFfRVfyImRZ2/Sh8aXsXwEqvS34ceYuLQ/F7qacUVt+QQy9IlHeweiOjWuRTau
         9DGoagLLv6hA1gv8vFHIXr5a9TBEnuY5bPrds1YgMtZGLS0nCpvrBFx6kqcl7A35pyCb
         uFiswAZqxf0Vhuub8FNg5cCL3YWWIQo5/MegM7O5aMHgg0KuCiNqtdRO26cVW6l2RTwD
         Uj06Z7xvhw/Z7HXTDcjY4YECD+y8NgFUMImzvUOVMJcKFoDbpWQnCkEjVsQeGSTldVPg
         T3K9gop7GN9mcjfmjdrurlnFC/IhnwXW8l1r1/0g+kLFUNRTliMwRMxBeV6HNSEDOEEK
         /W0g==
X-Gm-Message-State: APjAAAWVNaDml4rHxChpRWqmVEhaJc3fCAUGCwD0bNPvas7L2Xx6gcSf
        EQ0xg+jUcSLjlqrVO3VJanipm2SY
X-Google-Smtp-Source: APXvYqymElI5xpVq803V0Cs2D6mfHheg/z+n7VkdU6D+pfwtjyKnz8zbnBPwAOE/Lkcl4KSs0f/NGg==
X-Received: by 2002:a02:638a:: with SMTP id j132mr30185750jac.100.1568092597186;
        Mon, 09 Sep 2019 22:16:37 -0700 (PDT)
Received: from ericfreese.hsd1.co.comcast.net ([2601:285:8280:27a7::c608])
        by smtp.gmail.com with ESMTPSA id k17sm1913204ioj.10.2019.09.09.22.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 22:16:36 -0700 (PDT)
From:   Eric Freese <ericdfreese@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Freese <ericdfreese@gmail.com>
Subject: [RFC PATCH 0/1] for-each-ref: do not output empty lines
Date:   Mon,  9 Sep 2019 23:17:04 -0600
Message-Id: <20190910051705.2765-1-ericdfreese@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a follow-up patch based on conversation from the thread: "[RFC
PATCH 1/1] for-each-ref: add '--no-symbolic' option"

I had proposed a `--no-symbolic` option to git-for-each-ref that would
filter out symbolic refs from the output. It was discovered that the
behavior was already possible using an `%(if)` atom, but with the small
caveat that empty lines would be output for each non-symbolic ref.

This patch changes the output behavior of git-for-each-ref such that it
only prints lines for refs for which the format string expands to a
non-empty string.

If this is deemed to be too disruptive of a change, a new command option
could be added to opt in to the new behavior.

Cheers

Eric Freese (1):
  for-each-ref: do not output empty lines

 ref-filter.c            | 3 ++-
 t/t6300-for-each-ref.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.23.0

