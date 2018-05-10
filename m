Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4411F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeEJMnT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:19 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:56255 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeEJMnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:18 -0400
Received: by mail-wm0-f45.google.com with SMTP id a8-v6so3683145wmg.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLJpTup3MilgKfxSWZYjqt58/xc8ehTE4/UJafbg31Q=;
        b=koY/8jbFQLdcCqQtLOYrGYgsouISifQCwHL1J+zJ+d9Fbc/SmVBuz8u6zTzYyTNuPX
         sbiCjfQZpKyqw6xrs7AAIg812R70EHpaVyMDwT6TRxdfMgBuqaNWUiKX8VWB5amV4ZqI
         O0cdubnGxzozeb49kUT1VMFcyqBVjW+6gsAGitEji1p7FUuKIiGTJc6t9ZBqDUXaV6me
         abSIVWPuqrlvR0z/qxSONm/UoODZ0Ix2TiMaYWQtv0RRiG1E6wbU0rdoRMjO+qRThOkL
         PkG25wrVXcJicX4rvhk0ybEZyeeGW4T4NwTCa/rxkCrL9E5kB45YvOIVrbla08OoETmU
         xabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLJpTup3MilgKfxSWZYjqt58/xc8ehTE4/UJafbg31Q=;
        b=CyADUQPu0wb8kGzaumo7QPkrpmqvMIkE47fDCdbh2RK9cl9mHAu8P5e3hczcXdTtbZ
         xR8piaylSVH4ERq5cXr6Bxzyc0EeTmfeI6pzUU62KpKDuAPgyj84iRE0FfVHnijIXyXi
         3BcO6L1P2N/ik6zooUAguf8rtjgZBjU2SxFq4A2p+7YyyISHjzVT0ug9rL7CbpmtMDjr
         YnhtxusmpQDPnG1mXmm/aQi8FBdMzc1iQ1ap2ico2Gkn+RK8Wpq50/xwZZBdjYHK/qmy
         mBRuL5O9bhGo0vvpIvO9nI1YoTbCYQjKPaiTgQsuyhHMI4846/P6MBu3DDp61sGASKHk
         Kusw==
X-Gm-Message-State: ALKqPwdj4008S/z8NaCf+awGHnRB4Br6NAFdg8UjMhUDivS/CQBODgXq
        D1qkI8j3KtgZys6rM13Cmz5RGLBG
X-Google-Smtp-Source: AB8JxZp88L9hKVV183dYbaSCgy8QoYn9cDBT0AfPld6VWtxS8dpcNqpEnMXOTjFtq/W9SvIUwi7yHQ==
X-Received: by 2002:a1c:b109:: with SMTP id a9-v6mr1108350wmf.18.1525956196541;
        Thu, 10 May 2018 05:43:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] get_short_oid UI improvements
Date:   Thu, 10 May 2018 12:42:57 +0000
Message-Id: <20180510124303.6020-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is like v3 except all the patches to the peel syntax & docs have
been dropped, which were controversial.

I think it's worthwhile to re-work that, but I don't have time for
that now, so I'm submitting this. Maybe I'll have time in the future
to re-work the rest, but then I can base it on top of this.

Ævar Arnfjörð Bjarmason (6):
  sha1-name.c: remove stray newline
  sha1-array.h: align function arguments
  git-p4: change "commitish" typo to "committish"
  sha1-name.c: move around the collect_ambiguous() function
  get_short_oid: sort ambiguous objects by type, then SHA-1
  get_short_oid: document & warn if we ignore the type selector

 Documentation/technical/api-oid-array.txt | 17 ++++---
 git-p4.py                                 |  6 +--
 sha1-array.c                              | 21 +++++++-
 sha1-array.h                              |  7 ++-
 sha1-name.c                               | 61 +++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh       | 26 +++++++++-
 6 files changed, 115 insertions(+), 23 deletions(-)

-- 
2.17.0.410.g4ac3413cc8

