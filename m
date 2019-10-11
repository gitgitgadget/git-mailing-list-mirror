Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCBF1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfJKUm2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:42:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55153 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJKUm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:42:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so11648092wmp.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PPN7x9ClmgCgXKr3OQvfM3/A46SJ5fG/ech8qtnfucA=;
        b=ruIogb8l1IMsjKMt8ayw5tT5yDa4k5VKa3ajh7LPHCxrQNerQHNiFVaUYUcVtxZMmo
         FEv3mU46cWG865ufULmf6Rcy6DySfe9sjhp2ud0Nn23nN0DTGMR2SsWTQ2aVz4BnrS/v
         FiWCUbK0v4/d4ENMAdM2VfiBbbFI1Ks1gFIG5rPWCpY/30n+I/0a80r7KlOpZwIBC/hi
         AdYWEwuxaL328iGd9hpZM3RWGoohTHmqNY04y+Nfzf4UjMAA1Gw1bjyhbfHINoAgFDDN
         /B9SQeJ6Z2pcK8pFmhRIocezds1FmmH3EKz/gbksEFH31Bgwa3DmmjedGCpSbdnUNUDK
         evJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PPN7x9ClmgCgXKr3OQvfM3/A46SJ5fG/ech8qtnfucA=;
        b=aOBySe5+Hx0B/JS7Oh8Q5fAHjssRjjs8L+Skd3gwvL5NAY5kCGpnoM+d7WVNxw2h48
         O6FakUTRINqGv0/9qeUFWKWROgOLcVC+3Bq3TNSZWTtXsZqDixA6moD34WVgzfwjN9Pa
         MfU46F2rC5ztgTrWQj80AUcbTM85Ooc5fWU3KAnlTQXYGituabAsW4QBUfRaHoy28n7u
         hWapPfUcAxyxlt79+DMAURhfuuBtWX0tXA7cdsn/dTmRSzDNuY92M5j1omj4JdxwmAAa
         QnCxWG3Fb1Ylyh8aPNQL4PGdpWXb95/hO+7cHnb2s+Fh59E4ubfDwWUuOepO/iuIG9u3
         l2ig==
X-Gm-Message-State: APjAAAWxr3yWILLXwopvCIqw9ub4N6syzn9q9ETpbKOvV+jzHhnTtvEB
        ZooErNG0PMSfA7c8wLZ6oBN5FXbX
X-Google-Smtp-Source: APXvYqzcvSFDbubmi4uilpuypb6G2dDFAxE4PEf8spqe2gvOqUpJb7+DfGEyV1mHT5PqYofCzr1zVw==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr4988331wmc.151.1570826544274;
        Fri, 11 Oct 2019 13:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm15216103wme.48.2019.10.11.13.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:42:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:42:23 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Oct 2019 20:42:20 GMT
Message-Id: <pull.390.git.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Dir rename fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de
                        ^                           ^-missing end of address
                 \-extraneous tokens in address
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves a couple things found after looking into things Dscho
flagged:

 * clarify and slightly restructure code in the get_renamed_dir_portion()
   function
 * extend support of detecting renaming/merging of one directory into
   another to support the root directory as a target directory

First patch best viewed with a --histogram diff, which I sadly don't know
how to make gitgitgadget generate.

Elijah Newren (2):
  merge-recursive: clean up get_renamed_dir_portion()
  merge-recursive: fix merging a subdirectory into the root directory

 merge-recursive.c                   | 89 +++++++++++++++++++++--------
 t/t6043-merge-rename-directories.sh | 56 ++++++++++++++++++
 2 files changed, 121 insertions(+), 24 deletions(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-390%2Fnewren%2Fdir-rename-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-390/newren/dir-rename-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/390
-- 
gitgitgadget
