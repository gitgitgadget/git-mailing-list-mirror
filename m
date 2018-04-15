Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770A31F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeDOPgc (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43226 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeDOPga (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so18596965lfa.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adOBXYO+8pWMBpBsCZkmjnNDMu/zOYhTBJ/rCPXUoss=;
        b=rhgbVixfnxxMrYEf5pRUkjT3MgJUTqnE7S25C3O7jjZicQTbCq45iTVYqYWDhUAkAG
         CE4q40p+G8JQpDXQ+D9K4p06rtVVlZnZklCPSOqFr2sFnSvHEin3/vPUCS1/ofWCFMae
         mJHt0a0xooOpgKjh1iUkdcdM9+tfGV26d1EH+mqh5leJFiLlwtN1EwF5058cvFQxBBqX
         cTJh8fS/hKrGRvtcVeCrk51SzdPVx7AFrfNik+glF1//+2lL+tcREg1Kzoiln+JCZCCA
         Kfv3Imh240AwBNfyXFkkuzUNLWG5n+IzDJkBgg0x4HXS81YZVPvqki/WgspzvB72JkOI
         eang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adOBXYO+8pWMBpBsCZkmjnNDMu/zOYhTBJ/rCPXUoss=;
        b=Tu1Vz+n+kSbH/SGyk/YGCp/iv+B/nOyfLys8wv5ip/XVQMjFI8s5OGKmrfibdj7ie8
         X5LBhOYUctxGn0mR6iCFfaK6t9DiYDFG0Ochg1bZ3esrBKBiux6EXIVQ1i2PlaxOAs2G
         uQjTywF+hhsRoEg/mUCaj+0nVdx2YTQyemGCZ4IIUdKZ33v8Db7D2F4LN9jnvE5dWmVE
         UC8/rrf9Z1iJAqwBiWDKiKrk0XaJPGvqQCUhdXqBxopXirb9yvhkVi3J4jNrn00Esxjx
         ejTCtI8sjS0hIbN3oXqXZjGnkqegI3Uq4sMcfS1UjtlUqM8FMRQSmkc7bYsX2hBciKX0
         PvPQ==
X-Gm-Message-State: ALQs6tDXzLPTT1SVpMchavpqHlRmy+O1l9/bXiw+/fH84AQnTxEL5Dh8
        dBOrl+2WLm/Ne4rM/iqvirk=
X-Google-Smtp-Source: AIpwx4+V8aRjoQEBRxsDX3IZuepA0FdxQgxlfr/QZ0dNyjKrpQ0vgfVJsLozVbBTCmvtpx+HflThLQ==
X-Received: by 2002:a19:1294:: with SMTP id 20-v6mr2294348lfs.21.1523806589330;
        Sun, 15 Apr 2018 08:36:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 0/7] nd/repack-keep-pack update
Date:   Sun, 15 Apr 2018 17:36:11 +0200
Message-Id: <20180415153618.32019-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 14, 2018 at 9:47 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> The only (trivial) issue I found in the patches themselves was that
> between 4/5 and 5/7 you're adding an empty line to config.txt in 4/7
> just to erase it in 5/7, better not to add it to begin with, but
> hopefully Junio can fix that up (if he cares).

Fixed (and is the only change in v2) in case Junio has not picked up
the last round and fixed it himself yet.

Nguyễn Thái Ngọc Duy (7):
  t7700: have closing quote of a test at the beginning of line
  repack: add --keep-pack option
  gc: add --keep-largest-pack option
  gc: add gc.bigPackThreshold config
  gc: handle a corner case in gc.bigPackThreshold
  gc --auto: exclude base pack if not enough mem to "repack -ad"
  pack-objects: show some progress when counting kept objects

 Documentation/config.txt           |  12 +++
 Documentation/git-gc.txt           |  19 +++-
 Documentation/git-pack-objects.txt |   9 +-
 Documentation/git-repack.txt       |   9 +-
 builtin/gc.c                       | 165 +++++++++++++++++++++++++++--
 builtin/pack-objects.c             |  83 +++++++++++----
 builtin/repack.c                   |  21 +++-
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   4 +
 object-store.h                     |   1 +
 pack-objects.h                     |   2 +
 t/t6500-gc.sh                      |  32 ++++++
 t/t7700-repack.sh                  |  27 ++++-
 13 files changed, 349 insertions(+), 36 deletions(-)

-- 
2.17.0.367.g5dd2e386c3

