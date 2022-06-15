Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C24C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiFOXfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348302AbiFOXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0C1A077
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so1962108wma.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FX9WywCMgk4H9s1L3SBIYIKDMkNAaot+DlF3ovFm27Y=;
        b=H9te3kAc02PxdUTMxNvttyGGQrl5D3enq1fZRL/FmBlA7i2hfd/zW3OCDyvZzLwWDO
         BiBHPK7V2V7tbIvPg5JQDDOrWBpCNc9hf/zcReoUwKcK5suAfe1fCJz7Lr9oQiiECQtX
         6+GqhDoF4a/HaJRORTC5IU5O5Fk4Zbq8+1xSaPZrxEupWvJW5nC7FRxOjc9yV9UTrF6R
         KVwUZXtu1t316SmVkpT0+o01s7/q5BUzMX1H0+FiCg1nSK/flQzrRh5tuCMo+q0Qhv1l
         DrnNBS+9ertWuIfIglhEQEMG3a4IsdORC/DIN8VIT4kx9+BQEszytO8WTcfV6w4eAFmg
         MDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FX9WywCMgk4H9s1L3SBIYIKDMkNAaot+DlF3ovFm27Y=;
        b=57kRWzr0iLNh8vtsqDnksWnPCReV8MGuMFhPIiCQJ/eR0jLKVWoG1wfcY6OhTxfdpB
         eAqLxov3lqVxMKMZMcyzyXH2jKkIHL2S+LfKbK/4M6PwE+UvJqRcPJrI2y9yR9E8JpLr
         PzKlXRjyqMnVQ6fftzZp8P5YsbrGzhHygIXAuEaMoZrlQsIkp4/UvJOLjzEaeudUkWU+
         HbpteHA4THcACM2yl5NkFw6TtE20TQS79ygNtws3YdONBlNawKZQYWLkHaDgAOO3t/h8
         CQdl24lPAH6XDhtgnplslkWzcNOeb0EvuZMMOGLhNpwdow2rppgbU51jfKl4eCe8hcyA
         WSDA==
X-Gm-Message-State: AJIora8I3EcS+ZhOofrGwY6bpCcajC61sgxje+37P1wtD7DE0yNh+DrR
        /7f1YfKCFgODZjcpdUGBZHpjc79biVA5Xg==
X-Google-Smtp-Source: AGRyM1vdRMhhJu3OJ0uqz2HyJNihynbZB6p1UDn9PU1yqAOrrGXI7L6byWGDfvgimWxlLWUGERaMEQ==
X-Received: by 2002:a05:600c:1554:b0:39c:858f:6273 with SMTP id f20-20020a05600c155400b0039c858f6273mr1957009wmg.16.1655336148462;
        Wed, 15 Jun 2022 16:35:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b00213465d202esm253482wrx.46.2022.06.15.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:46 -0700 (PDT)
Message-Id: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:34 +0000
Subject: [PATCH 00/11] Coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The release window is a fine time to concentrate on bug fixes, and Coverity
can help identify bugs. These are only a couple of fixes, Coverity reported
many more, but most of the reports seemed either bogus or harmless (such as
resource leaks in test helpers).

Johannes Schindelin (11):
  mingw: avoid accessing uninitialized memory in `is_executable()`
  fsmonitor: avoid memory leak in `fsm_settings__get_incompatible_msg()`
  submodule--helper: avoid memory leak in `update_submodule()`
  get_oid_with_context_1(): avoid use-after-free
  submodule-config: avoid memory leak
  pack-redundant: avoid using uninitialized memory
  submodule--helper: avoid memory leak when fetching submodules
  read_index_from(): avoid memory leak
  pack-mtimes: avoid closing a bogus file descriptor
  relative_url(): fix incorrect condition
  bug_fl(): add missing `va_end()` call

 builtin/pack-redundant.c    | 1 +
 builtin/submodule--helper.c | 3 +++
 fsmonitor-settings.c        | 8 ++++++--
 object-name.c               | 6 ++++--
 pack-mtimes.c               | 3 ++-
 read-cache.c                | 6 +++---
 remote.c                    | 2 +-
 run-command.c               | 2 +-
 submodule-config.c          | 8 ++++----
 usage.c                     | 1 +
 10 files changed, 26 insertions(+), 14 deletions(-)


base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1264%2Fdscho%2Fcoverity-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1264/dscho/coverity-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1264
-- 
gitgitgadget
