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
	by dcvr.yhbt.net (Postfix) with ESMTP id D6AC71F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfJCTt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 15:49:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38860 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfJCTt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 15:49:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so3322315wmi.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SkClBTbaIcpnS8INWik2EGjHWPA3bjLcxldvqRlKe/o=;
        b=bA7ZvHpoO0pkJ2Cx593JETnHSyZMjVoNwM7G1ud0bQdSOL109HtbTXsoh68g2CoFnS
         6kknKT9grSajpv3i1GraozTRf9bIukTqJKZuqf+p6aYSn/qH5dKKpLhnl3/cgUigOT9N
         qMQiHJEH4SpBWSMtExdEXUoYIEJ4rvVBVG1ZPVoo35a2C+mmeXysCDLMjCrChZWLbhjf
         0w8FfZP3uRSwvMVDxGoGal0o6PDRbgRpgBGKOwXyplUj4woU21iedmTOMacqlKppzL4+
         DxhGNWKCvzjgGNs+Gm6dVHgPZEc23yn1Tpx6v6Nms0uQj0mBDT2t04OWS36V69S1db+l
         CEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SkClBTbaIcpnS8INWik2EGjHWPA3bjLcxldvqRlKe/o=;
        b=KQA0lvfpQPHhRWSFji+NRilLu4fke0TZ3ho9Vds0+LG2BVaAm0898pqYi3gOpqSjsK
         kntEKvhGq6px8g2AAAoDSZyuVYjFCChm3MZXameHe7ZY76J00RRe/X4wrIwk16kzT2AP
         lI4qfjvVY1y/I/extPYZwn7LeVcBrNRM0yxbpxF3Z6l3lIKrZSW9eR2agzivo5fS1Hmt
         wKk5dNyvp7EkTjTMJowa3IwnyGO1hDSZssnUgWhD0MJ1PvfJSMO/6QJy3uDXC7/CiAE/
         bfiwseYU6GQh5opc0i00t9oPSvm9Lf0uWXa0tPW3w/AWZEvmFZ0A0aLwGDpWfqeoZ2MK
         6enA==
X-Gm-Message-State: APjAAAXnTHaEdt1KJTbUX/LrsgORCFsqQJuGlhCd5UeU5yLyIWVn0gzG
        0Yptdqxw7tDE//JlJpdQ/sc+9v0S
X-Google-Smtp-Source: APXvYqxrjyij3I/fUNMMPv/uoGi3FumydzqoCOdvEmvD6MEr+rcH2TVflDEKjQ5GGtU8WCoEJ08gPQ==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr7730182wmk.107.1570132195889;
        Thu, 03 Oct 2019 12:49:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r65sm2517564wmr.9.2019.10.03.12.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 12:49:55 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:49:55 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 19:49:53 GMT
Message-Id: <pull.372.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] fsmonitor: don't fill bitmap with entries to be removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a segfault that I encountered while testing
fsmonitor. Under some circumstances, the fsmonitor extension was being
written with too many bits, and subsequent git commands would segfault when
trying to apply the bits to the index.

As part of these changes I've added some BUG checks that would have helped
catch this problem sooner. Special thanks to Dscho for pointing me in the
right direction and suggesting a test that can reproduce the issue.

Thanks, William

William Baker (1):
  fsmonitor: don't fill bitmap with entries to be removed

 fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
 t/t7519-status-fsmonitor.sh | 12 ++++++++++++
 t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)
 create mode 100755 t/t7519/fsmonitor-env


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%2Fwilbaker%2Ffix_git_fsmonitor_crash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wilbaker/fix_git_fsmonitor_crash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/372
-- 
gitgitgadget
