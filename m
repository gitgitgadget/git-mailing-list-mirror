Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5891FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757594AbdJKSEO (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:04:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34150 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdJKSEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:04:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id u27so2671893pgn.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7hiuwkx1R68qYi0jDBMzElQ6QR6s6X1LvMnM4vZgSvo=;
        b=m4mmO7A9zV5BfqTXqST0XeaAM35XFHJp2gXmfh6ols4q4b18K80nDLPVw+IrfFsTP/
         +IqNOjOwdpP0VCoABi2+Jnz1mC7gwF2k7C2KebSXy7t9+cqTwm439xoqZGz0dIcv2XCm
         7g0hMiL2naYAu9nnzUKp5CW740FRg1uKYTFd4S27Bcaym6QmUubx7SbHp1eV4O9EGvZx
         4K7nnQEV6ewToylJ8RMuZoCwfrqdhjj1KfzJRCxqSNl7FVm8VmTXpQugtWHNhJQi3TI2
         qGVR5KzCs3otHHkXm5AALvuX0SfPzTftMY+eJrcBQvh3u0rmVM64Z1FIn4l7EUTSge5V
         XG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7hiuwkx1R68qYi0jDBMzElQ6QR6s6X1LvMnM4vZgSvo=;
        b=UtODmtZsmkiziM5k38Kxf6E9pZHiuYt474EsJp4tFS6sokEteT5uGxtM7QLUKD/0gk
         pq5QQh5QXuWTAqdiuTrxxNiOUFZso21A/O6vBVbNr89dXwOX4C1nBR7cbTiYq/NmhNJI
         kAMiUOtEXIl5OBaHvSDz8jZZn5Q6b5SQVK5dDvPpY5nr9FJIzFN/F3uC2Nq3RyAEvDQO
         8pCfaLRZpPdtWlyl5J6LcD3Iz76ccpiWzsq74NBneQvSOv8BoZhDpc9qMqekLixfHmBx
         MtgKomzpjPevedofpSJE+IvggzAktcJIsqLfUdGzeOHRnFmtqWkrB7yxjaNMYPDRxI9V
         RNCw==
X-Gm-Message-State: AMCzsaVBbNOKQJ1LGkCFHC6p2mPji4kAGbWSHrcLa29CFxWfZU+9O0zG
        rXix5ccYC0Reh4N9Ri8ZYOtoCl4x
X-Google-Smtp-Source: AOwi7QC52YHncwAczcEJRt0S4xSe6qxyIcR3MHTtoj3FOpexjElIoKEy8RSXd/HoOamcl7Oe0qn9aw==
X-Received: by 10.99.154.18 with SMTP id o18mr351583pge.18.1507745049683;
        Wed, 11 Oct 2017 11:04:09 -0700 (PDT)
Received: from localhost.localdomain (64.71.239.49.rev.vmobile.jp. [49.239.71.64])
        by smtp.gmail.com with ESMTPSA id g15sm23343897pgr.57.2017.10.11.11.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 11:04:09 -0700 (PDT)
From:   Takahito Ogawa <aiueogawa217@gmail.com>
X-Google-Original-From: Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
To:     git@vger.kernel.org
Cc:     Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Subject: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
Date:   Thu, 12 Oct 2017 03:03:50 +0900
Message-Id: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <y>
References: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash" behavior without any arguments was changed in
1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
This is equivalent to "git stash push" but document says
"git stash save".

Correct it.

Signed-off-by: Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1..63642c145 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
-Calling `git stash` without any arguments is equivalent to `git stash save`.
+Calling `git stash` without any arguments is equivalent to `git stash push`.
 A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
-- 
2.13.1

