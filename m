Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDFF1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfHAVjM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:39:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37316 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAVjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so64435409wme.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Lorn+hATN5U7OdZ5Wa0SJRQ+4XkjLt+Cny0xQpvSigY=;
        b=GJGN58fWNQl/hlMuzuIjh9JuF6xSCKCym7Rdr+XZQ1wa880ahRImFI1/Xv3m4QpKzC
         2w6iA5an1AZDWR5qWO1q9vN9jMKMd7V0ndNzdgCspRMjidnKS9bn9AhRTGPrFybrLI5r
         qXeK6SG71t/RRQJ2YLqVfIE6/nPqteE+YZ5i7J6QXbMK117engAN8jDzNqydNlgWn5Vm
         eR9g4fb5HuDkjv8OWbY2CKdylHSLDloFtGOa54UUKzCivDNkUXE4BFp5Dm3Xgkw6Uf5r
         BEmP8qFBWo2yXQmn4iG6qDHtH616WxnksgCzAujvLekdChuZt1FcnGsm+AKLWtEPLscn
         5OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lorn+hATN5U7OdZ5Wa0SJRQ+4XkjLt+Cny0xQpvSigY=;
        b=f5NFDcq/fopBqXyulMHvB+aqAsCYmCoHxPi/Bcs88YZgcMtQeJqMlKa99PrsS7XYQ2
         DTWKH6YsO7T5OlxnZtLTsWfdq5KcgLm31cQC/6NlNbjSjrG2KekCMmetC8RsK6LlxX0L
         cJeyjR2DF7ZREtaL5anPoBtt5bargC+V8+P/NVYlggpack3/adO/4UwViKGB+4X3QAh/
         GIujlyM/eofmlD9C7zzk/JHgXfo/Z9aFlRoIx9U1qMe+X4xApadgDyVc1t7yaOcWd5w0
         r3wRv+DZdwkgGx5UfVAloGNGpUekq3aDnnnHhu/BKo4K1nF6NRvPAQBT4aR6032CdRjk
         lp+Q==
X-Gm-Message-State: APjAAAV4pkkm8FhfHjFLdlZcTYZhY1VEPxd1yOR7oGdKdsYPKXq9xRrC
        R19WO3Hxlt6RTJWE5hE49qbjirlK
X-Google-Smtp-Source: APXvYqwyJa42lAzuGwduI7ADaP8Z48sYA6e6y4xXlQJfJAdI0lX9FvMRwcqwlZ5bVKBxLpL8GzBqSQ==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr492659wme.11.1564695550446;
        Thu, 01 Aug 2019 14:39:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f70sm99393220wme.22.2019.08.01.14.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 14:39:10 -0700 (PDT)
Date:   Thu, 01 Aug 2019 14:39:10 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Aug 2019 21:39:08 GMT
Message-Id: <pull.303.git.gitgitgadget@gmail.com>
From:   "Philip McGraw via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-p4: auto-delete named temporary file
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

Take new approach using the NamedTemporaryFile() file-like object as input
to the ZipFile() which auto-deletes after implicit close leaving with scope.

Original code produced double-open problems on Windows platform from using
already open NamedTemporaryFile() generated filename instead of object.

Thanks to Andrey for patiently suggesting several iterations on this change
for avoiding exceptions!

Also print error details after resulting IOError to make debugging cause of
exception less mysterious when it has nothing to do with "git version recent
enough."

Signed-off-by: Philip.McGraw Philip.McGraw@bentley.com
[Philip.McGraw@bentley.com]

Philip.McGraw (1):
  git-p4: auto-delete named temporary file

 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)


base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-303%2Fphilip-mcgraw%2Fgit-p4-auto-delete-named-temporary-file-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-303/philip-mcgraw/git-p4-auto-delete-named-temporary-file-v3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/303
-- 
gitgitgadget
