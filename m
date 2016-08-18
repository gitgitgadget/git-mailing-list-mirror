Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35ACE1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbcHSA4k (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:56:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35625 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbcHSA4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:56:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so1548078wmg.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 17:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dx9UyjeDm0lx4WGJ5Uu7Eo0F2MDAGehsZPnJfaJ0SE=;
        b=p0Rl3c+gTJDdyREccGrUrIWCZJIUF5EB7dY2w0uW7qJfL5Zb4OLKmxwGWCq7lAWS4a
         bIQUp+jCqGsSh7M7BJgk+/vLKHvg7fNqeeoWNRtmdw+jcEB8l5mOKW/IHWUuOLqL67bf
         3meVyfjvwQiBnSfozX4xJBX9zkJPbQdo31q2AHLnTTTkFNOJTJqFxdx9vvMHbKVuv70+
         MR6O4WBKhBgtSYD8EFHhmsFmnKdbFtvPuKkm1cU0WoJ78ETOgHwGCcPJsJXKs1wCfgfb
         W5m3xAV+xEMdzXwLDGHfKpaclAxajI56MWy9RoyWURiRQenlUFIjPms7LmFBw7a0ipjE
         WHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dx9UyjeDm0lx4WGJ5Uu7Eo0F2MDAGehsZPnJfaJ0SE=;
        b=Dq4sjxKrrgayI0fy4SbzqvSMDFMZVMjYZk2tW3pR2dMj7nKdEy/F0J/7YPUbBFcjFT
         tvn15SAoRRpHmQ1yAufM9+QqHVcbNgbNBjTMpRbIzXa6QFmrP1rXMBbFt4cdSyFJlEMw
         D403bUaMh9fO/zMMoWD4HpKId/z/yt65bRyXRsHwvkXbzKHWOgJdlbgvryEhUI9H0He2
         I9/MqCUmPcKpSoYZksEfcLOi9YKBJITcteceY1ficJkCp59fNR3V856FzjxV3JX9v49j
         n6HiGXOyiSBl/vxfhnTpKM37iwApbnXjRYe4R46CdFII4jpu9fsNwrzUn3epP9DXoEbI
         wlyg==
X-Gm-Message-State: AEkoous7mmzA4UDQYHkDDknbShO+nD3fmtKvxoZtihCMaIU1xZGLRgeCyapJj3CL6KsV5g==
X-Received: by 10.194.136.196 with SMTP id qc4mr3319372wjb.136.1471546645337;
        Thu, 18 Aug 2016 11:57:25 -0700 (PDT)
Received: from localhost (cable-86-56-90-190.cust.telecolumbus.net. [86.56.90.190])
        by smtp.gmail.com with ESMTPSA id q4sm3482901wjk.24.2016.08.18.11.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 11:57:24 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 0/2] help: make option --help open man pages only for Git commands
Date:   Thu, 18 Aug 2016 20:57:17 +0200
Message-Id: <20160818185719.4909-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160816162030.27754-1-ralf.thielow@gmail.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this version, one patch has been turned into two.  The first introduces the
option "command-only" to make 'help' only working for commands and additionally
give some nice help on typos.  The second makes option --help only work for actual
Git commands.

Ralf Thielow (2):
  help: introduce option --command-only
  help: make option --help open man pages only for Git commands

 Documentation/git-help.txt             | 11 ++++++++---
 builtin/help.c                         | 30 +++++++++++++++++++++++-------
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 15 ++++++++++++++-
 t/t0012-help.sh                        | 29 +++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 12 deletions(-)
 create mode 100755 t/t0012-help.sh

-- 
2.9.2.912.gd0c0e83

