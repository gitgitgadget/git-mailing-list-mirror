Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBED201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdBRNdS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:18 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33028 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdBRNdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:17 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so7373400pgj.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O2bGO6tJEOw7Jl8eTt0k5kZy7SjxG6jJxn5mtJuFuc=;
        b=Ji0RIhZ9KIRKVJjHQUDyclBVHsdFh62t++V0btw+eBVVC+N5pxs2sOFOeLablDPm+R
         mky6A4PVEmDM8oQx65HhERAdABgGmDLne2Ke516lg7O3pe1YbF4BG8fPnjtx7et7Pm+f
         i/VHqJk7+7uAIxByuOs6WuKyEwyHiVZlphth3lUvVXnhnET46kywQnI2owp5lS4Czc09
         JAWbQw5u9Ws5MklEiraykCycxIgYAtbM4D2Ww4obecsWMw4fWnn50IGq4OwHZz0f9+gF
         BbjsaGVLXFiAX1lgayIdwQn1peaIPHR2pz+l+/mChg5Ow6Nuc7BMet2RpIVmrpOP+y10
         SBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O2bGO6tJEOw7Jl8eTt0k5kZy7SjxG6jJxn5mtJuFuc=;
        b=fIO3MrV6RWWfOJFoFtRnE+Wl1MNd6igkNMXOfzFwvffzjCTG2iAzXNPppZyk9WicvN
         Z5UWrIWa02dq4JtMH/McjPgbdWXhJNe9OVBx7FVqsJYCX2NZHVFKDFyXnCE0TSoKdHi6
         TrRR3+mrBsKSpr94F5PlsFqb4FXIdRuZdAgZYE2C52e97oVgvANXwpfDp+LnHx6puDSE
         sQl1wjd1iU8K+rPybxw49T5uzlYnSJtNL4z8Fq/Wm7ZOxPOR0cIQ3zNRo3LItauk7XbE
         vh6xaeCRTSkEVGOSMCWG9fil/mxrP4Q2dNKke3ixiirrd2dcvNf8HHnyScPE2Un0qOCL
         wwXQ==
X-Gm-Message-State: AMke39n0s9C9iW4RAdLxS70YLUz+dly709GCDR72J6mT1A5gq6vOSpqD10GYRO1Yb2g2uA==
X-Received: by 10.84.133.163 with SMTP id f32mr18244969plf.64.1487424796787;
        Sat, 18 Feb 2017 05:33:16 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id k184sm25722654pgc.23.2017.02.18.05.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 00/15] Remove submodule from files-backend.c
Date:   Sat, 18 Feb 2017 20:32:48 +0700
Message-Id: <20170218133303.3682-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:

 - is based on master+mh/ref-remove-empty-directory+mh/submodule-hash
   instead of mh/submodule-hash alone. It could merge with pu cleanly.

 - 06/16 from v5, "correct is_per_worktree_ref", is removed. The
   "remove the use of git_path" patch is updated to handle it
   correctly even without that patch. More on this later.

 - update "replace" typo in a commit message

The story behind the 06/16 removal is, in my simple view, there are
per-repo and per-worktree refs. But refs.c and backends see them as
three types: per-worktree, pseudo and normal/per-repo. Refs like
ORIG_HEAD are _both_ per-worktree and pseudo.

06/16 reclassifies ORIG_HEAD from pseudo to per-worktree, which
triggers a failure in t1400 because as pseudo refs, reflog will not be
created while it will be for per-worktree. This new test is on master,
not maint. I now fall back to treating both per-worktree and pseudo as
per-worktree in files_path() only and keep classification unchanged.

Side note, my other two series seem to apply cleanly on top of this
v3, so no resend.

Nguyễn Thái Ngọc Duy (15):
  refs-internal.c: make files_log_ref_write() static
  files-backend: convert git_path() to strbuf_git_path()
  files-backend: add files_path()
  files-backend: replace *git_path*() with files_path()
  refs.c: share is_per_worktree_ref() to files-backend.c
  files-backend: remove the use of git_path()
  refs.c: introduce get_main_ref_store()
  refs: rename lookup_ref_store() to lookup_submodule_ref_store()
  refs.c: flatten get_ref_store() a bit
  refs.c: kill register_ref_store(), add register_submodule_ref_store()
  refs.c: make get_main_ref_store() public and use it
  path.c: move some code out of strbuf_git_path_submodule()
  refs: move submodule code out of files-backend.c
  files-backend: remove submodule_allowed from files_downcast()
  refs: rename get_ref_store() to get_submodule_ref_store() and make it public

 path.c               |  34 +----
 refs.c               | 144 +++++++++---------
 refs.h               |  13 ++
 refs/files-backend.c | 406 ++++++++++++++++++++++++++++++++-------------------
 refs/refs-internal.h |  28 ++--
 submodule.c          |  31 ++++
 submodule.h          |   1 +
 7 files changed, 396 insertions(+), 261 deletions(-)

-- 
2.11.0.157.gd943d85

