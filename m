Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183601F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfEJUXP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:23:15 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46830 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfEJUXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:23:15 -0400
Received: by mail-ed1-f46.google.com with SMTP id f37so6691981edb.13
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LCMYLR55GjAvQ6nbDw0e6uoNdie2UEDa7jmEpLKGtDw=;
        b=CMbcQcMECXdJPmHgXJ9soix2wr7RZDjp1pbuyJzvFv+mPfyH+ds+934UWR5PuxDn9V
         9bo4EGaelXD30sk5XtQtXdfdhUOudcVVrkRSDY1AlkoWe2vhg6ZYjaPzupIK9z5hG5q2
         FJSo7EPiIz7TCJ79tKYVYo3wDYZWb+wXP71VPfg3/HxXSyJPl0r4opDYcl+EZEqYyGvU
         Z6CFrpfWNn5WdRiaF4U1Sl7fpeVbe5sSwg1qVw44NgUDXcUWhFO72+vrty5vmVLsu85n
         Qq4a1UAhmXDEBH3Ldsdz1RF7p7JsNBysnwE7i7EuH6NhINDCVAKOIN6+gki/hzIC0YS9
         pZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LCMYLR55GjAvQ6nbDw0e6uoNdie2UEDa7jmEpLKGtDw=;
        b=MEiJrz4f1YhF0pxICBmH2lN45y2wJOVoH48C1TtmVH++d4C/wvMDRqeBknz8VnUJxw
         WJy6LtfJXACOfEu5qG3U9Og13bEYddoZTM7oR9ewGq00oKdlmh+VF3+StSvdjcb0oLhe
         qJ9IrqoFWFlDTUOO4LjknaTVWM7njS//ujqu8RZ1nBAYFPfM9k3kyemdok9iC2q1u920
         VNZRTZzMZ4TjjKMbLxn1Pn7kigHc+L0pUGQ+spLqoj2JNMKgIowsIXeB8P74C0a3X08B
         W+4zj9JOusamEosGTVONo3ef0tY697r/ZNbZdspT6rSaCXweUvVdaL7nYP8KId+QykxK
         g3ug==
X-Gm-Message-State: APjAAAUJtPQjuUgpabSXXgrb/3GzxKAaCWpcNtP+kA7ZjW9skIVgJo7G
        t+UCXbVKVSqUGsKZG2eHnNrR8/fB
X-Google-Smtp-Source: APXvYqz65XlESUMYJpzCRV/04RlRcIxxxHz6U0UU53QdMswGl/4VBHg4g1XYLc7uRpjw9DO6sQwgPA==
X-Received: by 2002:a05:6402:1812:: with SMTP id g18mr13589008edy.273.1557519793776;
        Fri, 10 May 2019 13:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35sm1762328eda.2.2019.05.10.13.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 13:23:13 -0700 (PDT)
Date:   Fri, 10 May 2019 13:23:13 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 20:23:10 GMT
Message-Id: <pull.188.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix git status' display of git rebase -ir's label commands
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

Those label commands are currently displayed with their argument resolved as
abbreviated commit hash. Not really what we want. We really want the label
names instead.

Johannes Schindelin (1):
  status: fix display of rebase -ir's `label` command

 wt-status.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-188%2Fdscho%2Ffix-status-with-rebase-ir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-188/dscho/fix-status-with-rebase-ir-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/188
-- 
gitgitgadget
