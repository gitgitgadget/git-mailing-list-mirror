Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729AD1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeBXDem (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:34:42 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38812 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeBXDel (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:34:41 -0500
Received: by mail-pg0-f68.google.com with SMTP id l24so4094829pgc.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek6I8Ap0tkjxhzxzUv76bQVtzcul/9XCqxVVvUnRN8o=;
        b=PpuUuZc02KyRSd4IzXYYeY2rq1f2FJTEnOP9LL9vt9+2QIWc095wazLMp4+FuzdTxW
         yfhA/t2tkhlF59A90ye0QxwACJjKOKqB1fkaoqFnyk+1BEAI4afW8jK/kRUbYupnwxz2
         +c/Y7dfihpF+YaEFr85uC5fuGA9Gc0LQswQVynIm+IgLmwhISJCMSHo0hWP/qkN49muM
         n2AlBR9UntQOhYJXVU6ScIUUI4naB2tl3KsOO0Zt5FkNxGm61hjCui25/2rMyc98Z0eW
         kVAG4zHOpJIMHLbv2L7s8Z6VaxxMYOLXqyNqhgZjTEBcDbAf1+PXZDjlWA85DKcEz/6R
         GYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek6I8Ap0tkjxhzxzUv76bQVtzcul/9XCqxVVvUnRN8o=;
        b=fF0OblkIywPGMCRTIq6tw1OcKkcEMu0i+U6k+lA1yUIp+SG8yiSE6FwKassisY+YiC
         7kEMEuTTZfo/k5zD5P7KZbHmaulFOrU9YEkXFIcMq7vkuW9YYuR3W9xlZf2qpZ5TsG9M
         Plk+jSbdOokN+c2nQOpE2hOa5xnw1XwZCxWu92YzIG/Ajue/f4dECH3d8lbtiYcsf5TH
         O6AKD5ehu+DUeCdgwoYaUeSa8ndk0hfJ1ZnzWG86OqVlMLPzheP6QR2zT5+gr3p0Ro+3
         uV7nZHTodCFqxa38Lay2Mah+S75MJexiPE3FfhJpeUl4fSr1/nRdEXLua/cp7DcwLNw0
         L7bg==
X-Gm-Message-State: APf1xPBxtEkyGOGZIhPR/sMw4ODJ1OKKiQ8ehmliV6du+hXNTuROyMwS
        fouA5nB/5TfycUzlgEzvQkYNaw==
X-Google-Smtp-Source: AH8x227NlABSwO4quQr3sTNtp7o0KxWYrlZFnsqpl0rqIHHfb7E7ZX/5//mVi5Wwat6cfa4YFd1hmQ==
X-Received: by 10.99.190.15 with SMTP id l15mr3110700pgf.325.1519443280782;
        Fri, 23 Feb 2018 19:34:40 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id u27sm2439359pfk.172.2018.02.23.19.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:34:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:34:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/5] Fix initializing the_hash_algo
Date:   Sat, 24 Feb 2018 10:34:24 +0700
Message-Id: <20180224033429.9656-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180223095640.25876-1-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian questioned the unnecessary alarms in v1 when "git diff" or "git
index-pack" run in no-repository mode. I had the same feeling after
sending v1. But instead of suppresing alarms, we could do better.

v2 breaks those "fall back to SHA-1" code into separate patches and
handles it properly (I hope) instead of blind fall back like v1:

- for index-pack, we can determine the needed algorithm from the pack
  file. I'm making an assumption here that pack files with new hash
  algo must step up file format version. But I think it's a reasonable
  assumption.

- for diff --no-index, I still fall back to SHA-1 to generate the
  hashes like before. We could probably introduce a new command line
  option to use a different hash. But that work could be done later
  when an actual new hash has come

Note, I didn't test but this series could potentially break 'pu' (in a
good way). I initially was puzzled why the test suite didn't fail when
the_repository->hash_algo was NULL (i.e. before Brian's fix). Then I
found out that more work to abstract away SHA-1 hashing functions have
been done since then. But because the_hash_algo is pre-initialized
with SHA-1, these special cases did not show up until now. If there
are more the_hash_algo conversion on 'pu', more "no-repo" cases
could be spotted by the test suite.

I think this makes pre-initializing the_hash_algo to NULL a very good
point: during the abstraction work, we at least must identify the use
cases like this (code running without repo). We don't have to fix it
right away, but we can start thinking about how to deal with it. If we
ignore it and switch to a new hash, these code will keep using SHA-1
and cause more headache in future.

Nguyễn Thái Ngọc Duy (5):
  setup.c: initialize the_repository correctly in all cases
  sha1_file.c: keep a good name for "unknown" hash_algos[UNKNOWN]
  index-pack: check (and optionally set) hash algo based on input file
  diff.c: initialize hash algo when running in --no-index mode
  Revert "repository: pre-initialize hash algo pointer"

 builtin/index-pack.c             | 26 +++++++++++++++++++++++++-
 builtin/init-db.c                |  3 ++-
 cache.h                          |  3 ++-
 common-main.c                    | 10 ++++++++++
 diff.c                           | 12 ++++++++++++
 path.c                           |  2 +-
 repository.c                     |  2 +-
 setup.c                          |  5 ++++-
 sha1_file.c                      |  2 +-
 t/helper/test-dump-split-index.c |  2 ++
 10 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

