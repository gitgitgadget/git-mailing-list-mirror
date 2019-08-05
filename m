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
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A3A1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfHELvL (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 07:51:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36160 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHELvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 07:51:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so68589855wme.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=S7FmlwkEz53ZYCoh4aQKbRAqYN+QuDX5JGSTRy5haBA=;
        b=o3CieJUdyGgyZvdJ0nPxbQPm2RRB97XYRdXakbzVKw+nxyCJ8cRzsNIiermoW4oKCk
         GhnXeZDKo7MldwbWWCG1BrYWC5g/uAWR/iXm1/xf8vbdQxBDdqjlwNrGBDlFTExP38Lp
         0y+YulsotMWS3vKxhBhY9wqXXjRsAWF3DvOsq/aCC+UYvWJBe1bFwqtXyJivFEBZkDtT
         4Dju1BzyDWTD4TROEbDr623zbLWPmAIx2kUtKr+5hqfSimXIBmt/vNgJ192494MsWF7t
         OnCgdPbTN6JE9iIhyqdJ7dYn1gtSRdGapqRNnR5qYA2wLqAD0UGty6I0LJuRtnv8tGRD
         8XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S7FmlwkEz53ZYCoh4aQKbRAqYN+QuDX5JGSTRy5haBA=;
        b=PFbxleCIb9SIBucKif0FKJgVIwyioHDLh3WM1MsuxroEiUWuQWhHgKfAygvYWtTP66
         UmdizXIhDF0W21hmFQmYWX7ttaKuWgURG+UoONuN+ilNvb3f0koHDGdFKxHCZnaSC5aI
         qAwvm/b6zfbcOe9f50tdskG4KbzKPdocYjLkj+GjyXCXRjhoCrAAv5LJlH8kqh+dkXPJ
         LfThNF91xHHO5m8tngulHXdxoSvxbu+ky6AJNaIlszctdY154AZZsSFE+we2RoWSlH3E
         U4i4uvQ/lgUyDcQcm1G3DS+0QEnB+Nrfl/gZTFDVLiSaKAq63+8Ets13faY7+NpJVkOj
         63vQ==
X-Gm-Message-State: APjAAAWrxL4OXB0Vz9/ZDKZLXprOiCZ1nFzw8yGbz+eqtfUu79art0bV
        Amt9a/lL/ZjqrK2OPOcFfsHxjtgt
X-Google-Smtp-Source: APXvYqyKFeWfQwYLmFmqcz7djjMxeMUjJgarhhWqjVdlSJTma1Pi0JVJFh9Kb9CUiGrdCXkidJTPBg==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr18447570wmd.117.1565005869044;
        Mon, 05 Aug 2019 04:51:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm62935161wmi.21.2019.08.05.04.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:51:08 -0700 (PDT)
Date:   Mon, 05 Aug 2019 04:51:08 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Aug 2019 11:51:06 GMT
Message-Id: <pull.306.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix a problem with PCRE2 and nedmalloc, found via Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a couple of days, maybe even a week, pu fails consistently, in the
Windows job where it tests t7816. The symptom is a segmentation fault.

I finally got to diagnose this, and it looked at first as if there was yet
another buffer overrun that was so small that valgrind failed to detect it
(see https://github.com/gitgitgadget/git/pull/178). The problem is another
one, though: we ask PCRE2 to allocate a table (and it uses the system
allocator for that), and then try to release it using nedmalloc's free() 
replacement.

This is squarely a problem with cb/pcre2-chartables-leakfix in conjunction
with an overridden allocator.

Junio, for your convenience, I rebased this patch directly on top of 
ab/pcre-v2 and pushed out the let-pcre2-respect-nedmalloc branch at 
https://github.com/dscho/git ready to be pulled. The rebased version is not
technically a bug fix, as I do not see any way that ab/pcre-v2 uses
mismatched allocators for malloc()/free(), but just in case that you wanted
to have it in v2.23.0 and not on top cb/pcre2-chartables-leakfix...

Johannes Schindelin (1):
  pcre2: allow overriding the system allocator

 grep.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)


base-commit: 7d3bf76999452ff64c84cec25fd95a7a95744b78
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-306%2Fdscho%2Ffix-for-pcre-chartables-leakfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-306/dscho/fix-for-pcre-chartables-leakfix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/306
-- 
gitgitgadget
