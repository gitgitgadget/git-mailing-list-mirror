Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6BF207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbdECKSI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35900 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbdECKSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so3651735pfd.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U19owgPtLz5ivlJANXuI/3L8dVILpE86r1wejlccMhg=;
        b=tgNJCjhXpnOiaEBQYwqFBeVkzIXuloA+BtyMazg+tFboG27GsnVKzp8ZrvEoTzQLll
         y5+Khz7GOs3uX8YlyYll1x8UTy5DMMNt78u5FypzVvdwZdGpG4KtO4pdni8MfLaX/ET7
         TWsD2vTciKfTYn2oaOe3qDVU+w/nHKTEZycQM52//Yayb8osTWucl2KSMFcZErUHjmKG
         0/iR56lM3xzIY7VrYTmlcp54gVq/z5of+1hvHx4qRVq29RtpLB9hUAyhgkLbkPL7Cha8
         QIwpoH3E6GXBYoxqQ7CsIdLXECbq2wRekLkTVXvB5RK5T+fMO07DK59q7TerfE45naqC
         rL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U19owgPtLz5ivlJANXuI/3L8dVILpE86r1wejlccMhg=;
        b=hP4jnDxBoUz3frQiPjl5zypcSKfWcIruic6RZdDIhnK+Ov4dQopRuaftlyE0Uwc38E
         rcTKKmqpA08u0NiNfZKcPH67jNiAq1X+jLNCgM0zXGyX3Z3xKee8rBZH6FQFjqeAqPyL
         kl/zOqHs3tqoS5qfXSPTvt7aI0BxBU9Ur6jQwba5WJoOTWBxXuHaLAWBBvORomj2li7D
         QGWQaJzRYBAtUSv5pq1DEIdDBOQYD/n63fNJ2GI/wQoc4USJviyXgY/ScmE+3L/ybcaD
         IdylYBZTwOgVedDhITqyIQaNPdieZ0PTqp/qN91S/Eyi9FA9NsiwGIUlTJN4PD2U2hoG
         YwNg==
X-Gm-Message-State: AN3rC/7Q/iiqtNZAZ7xOM6zKgXbxNNDIbxomBtt0QdY7OPsWxVj8k4uC
        FY9R95fNViiC4w==
X-Received: by 10.84.192.1 with SMTP id b1mr44763676pld.9.1493806681747;
        Wed, 03 May 2017 03:18:01 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z22sm3697076pfg.117.2017.05.03.03.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:17:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/21] 
Date:   Wed,  3 May 2017 17:16:45 +0700
Message-Id: <20170503101706.9223-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 - fopen_or_warn() and warn_on_fopen_errors() are introduced. The
   latter's name is probably not great...
 - A new patch (first one) to convert a bunch to using xfopen()
 - Fix test failure on Windows, found by Johannes Sixt
 - Fix the memory leak in log.c, found by Jeff

There are still a couple of fopen() remained, but I'm getting slow
again so let's get these in first and worry about the rest when
somebody has time.

Nguyễn Thái Ngọc Duy (21):
  Use xfopen() in more places
  clone: use xfopen() instead of fopen()
  config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
  wrapper.c: add warn_on_fopen_errors()
  wrapper.c: add fopen_or_warn()
  attr.c: use fopen_or_warn()
  ident.c: use fopen_or_warn()
  bisect: report on fopen() error
  blame: report error on open if graft_file is a directory
  log: report errno on failure to fopen() a file
  log: fix memory leak in open_next_file()
  commit.c: report error on failure to fopen() the graft file
  remote.c: report error on failure to fopen()
  rerere.c: report error on failure to fopen()
  rerere.c: report correct errno
  sequencer.c: report error on failure to fopen()
  server-info: report error on failure to fopen()
  wt-status.c: report error on failure to fopen()
  xdiff-interface.c: report errno on failure to stat() or fopen()
  config.c: handle error on failing to fopen()
  t1308: add a test case on open a config directory

 attr.c                |  7 ++-----
 bisect.c              |  7 ++-----
 builtin/am.c          |  8 ++------
 builtin/blame.c       |  4 +++-
 builtin/clone.c       |  2 +-
 builtin/commit.c      |  5 +----
 builtin/fast-export.c |  4 +---
 builtin/fsck.c        |  3 +--
 builtin/log.c         | 11 ++++++++---
 builtin/merge.c       |  4 +---
 builtin/pull.c        |  3 +--
 commit.c              |  4 +++-
 config.c              |  5 ++++-
 config.mak.uname      |  3 +++
 diff.c                |  8 ++------
 dir.c                 |  3 +--
 fast-import.c         |  4 +---
 git-compat-util.h     |  3 +++
 ident.c               |  8 +++-----
 remote-testsvn.c      |  8 ++------
 remote.c              |  4 ++--
 rerere.c              |  7 ++++---
 sequencer.c           |  8 ++++----
 server-info.c         |  2 +-
 t/t1308-config-set.sh | 13 ++++++++++++-
 t/t5512-ls-remote.sh  | 13 ++++++++++---
 wrapper.c             | 21 +++++++++++++++++++++
 wt-status.c           |  3 ++-
 xdiff-interface.c     |  4 ++--
 29 files changed, 103 insertions(+), 76 deletions(-)

-- 
2.11.0.157.gd943d85

