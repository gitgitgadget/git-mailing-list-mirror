Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639D91F454
	for <e@80x24.org>; Wed,  6 Nov 2019 07:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfKFH2j (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 02:28:39 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55253 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfKFH2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 02:28:38 -0500
Received: by mail-wm1-f47.google.com with SMTP id z26so2101661wmi.4
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 23:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cAMWg1rhdk+g0JglIxC2EUOL2FPXo+CrVJb0S8Bp6Rw=;
        b=ICTdJjFXgIBpG+heRA5kN3EUlv7Rv8upnewxycQV+SfTV1oKroscKRH8TdzhZdX81E
         hIs8X6IMnWGlwh0iabTUco5iQgl5Z4E32CcHY8JNibNjk4DpxSNi5W0WaeSoTIRDZrAP
         EAYJOboRbvD3medWoN1kldYZJx5gFVWhGhGI59jpjIqasyDN9CRGggrG9f8lk2lTY+Dl
         h1lw1jZS8m8f4YyMVZHHWB5V6GeFyw0U7XTf3QVq/UtchWNzjNHUuvqKDvVl6tQcKW9K
         Yclds6rUkoGTnrOvCHKnw+uczt/tAG09jIMjQuzgrIEG5v1mMu5nywCPWj1v4SJ+d0yL
         Tb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cAMWg1rhdk+g0JglIxC2EUOL2FPXo+CrVJb0S8Bp6Rw=;
        b=rbtZ4VexrdoUKqcDg49zLZAWBQ0ZZ2Up6po+f6157SE1c2cBiyTNZAPiO/8yEqLh8n
         WDmA3fMtI0sjsfon74RIY7/PDn94NIudzfYE4RB2tPl+lCIv2i9fz5dkstRgtBGRqar5
         gMuNrGV2hah3iNlUZXpt/bbzXa1cischCnvBga7rd6JSBK3lkFPWAISgKr755ZP55VKC
         MPGG9/XL4bAQmo/9HHLR/3ZJ6RvdM+eiyQGwVKFemf7YE+gAhQ/39SnMi1j1QoegXiv0
         DAv+aP3ZeUtNNqg7Dex1OqnodpQXj6KmhUaw4afkQE9h2NjlhJxgbgys4K9hv/0HRjFE
         Rs5w==
X-Gm-Message-State: APjAAAWhga5eGKhdcIO+OFAf9+vMxagICv3xXbTeCIfo6I9gqoSiCQds
        T36hXdCZzvaqet8vZF5YB/rIdapf
X-Google-Smtp-Source: APXvYqyQfdM80xi/bOEdYl6Ge3KuqmaYE+t2OgxrDM57TNWeCrdUP078PkSBPZEUDWSO1bfFHS+Vmg==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr1121229wmc.113.1573025316901;
        Tue, 05 Nov 2019 23:28:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm1955393wmd.2.2019.11.05.23.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 23:28:36 -0800 (PST)
Message-Id: <pull.271.git.1573025315.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 07:28:34 +0000
Subject: [PATCH 0/1] refactor: rename is_directory() to dir_exists() and use it in clone.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes #230

John Lin (1):
  refactor: rename is_directory() to dir_exists() and use it in clone.c

 abspath.c                   |  2 +-
 builtin/am.c                |  2 +-
 builtin/clone.c             |  6 ------
 builtin/mv.c                |  2 +-
 builtin/rebase.c            | 10 +++++-----
 builtin/submodule--helper.c |  4 ++--
 builtin/worktree.c          |  6 +++---
 cache.h                     |  2 +-
 daemon.c                    |  2 +-
 diff-no-index.c             |  4 ++--
 dir.c                       |  2 +-
 gettext.c                   |  2 +-
 rerere.c                    |  2 +-
 sha1-file.c                 |  6 +++---
 submodule.c                 |  4 ++--
 trace2/tr2_dst.c            |  2 +-
 worktree.c                  |  2 +-
 17 files changed, 27 insertions(+), 33 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-271%2Fjohnlinp%2Freconcile-dir-exists-and-is-directory-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-271/johnlinp/reconcile-dir-exists-and-is-directory-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/271
-- 
gitgitgadget
