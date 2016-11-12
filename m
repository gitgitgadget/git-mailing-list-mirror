Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F291E2079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbcKLCYh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:37 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35211 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936420AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so3167276pga.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07S+McHXdnWol94i+9hE+IXJL5QAE3oHtKkdgP/ebxM=;
        b=wTyjxCDV9JNJAtSl8wQ1KrfiyF3VBkdo025mXd/rA37aH94REvDsXgWWbfOJY54ztm
         fdbh92JV44idCt2VnB5mJM7Sei+H15EXT2qpHn730p8MaFASEpyHGkmHKrdM0DkDNBaR
         Lr0ClT+9AR7RxhCOAduGQHTkrlTauRlobRWpequw1hollAsdNcZY4oApOWsqHmPJNlQs
         LtIV0UZn/fhbVKgyYdW/kqMEn0B9m0wA0jeN7uZIWJsMerG37aLsvziM+ehdxoIZUI4U
         EOyCKjK8S7ceJXbwK4rBt39c6iD4wlG+DEguJrx1uevsZEHRwkmOYAXnlCh6lw/u4NzP
         rCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07S+McHXdnWol94i+9hE+IXJL5QAE3oHtKkdgP/ebxM=;
        b=BTv8R4tkJND7h+4S6rDupqQXOzRcpayBGC9elJE9jXJ0vebljPfntyOY8pxvp4BCLV
         I87NyUUoOu6W9Ab0XLT8QII+pgmObdEfbQVsJ3dERi8EwpXf4FaGtEPNmEyhqdWb6qPN
         jgfPUqroHGr7FVV+04/7wUDjbP2KKwEjOyn6MdIkMlIgAQXsYnfsiQM/wdWkYPZ7KWgN
         KFSDhv0CzzpoysIQA0vCs193ikQlWcqgR5950ndZ/mHvSp06tId/9iRCVRFx2Q2r0B+A
         yxCpn/tOPH3oi1uz0Ni0Z2m+8Ga5q1taimy6qifZofUd118fUrDjYx8Il28ZCX3jUyZr
         Qt2w==
X-Gm-Message-State: ABUngvduWRdXiaUCflsYlINEkam7xtesOULrjalI+eVybE+chUVtH3SOQCrEBdnHfLyfRg==
X-Received: by 10.98.159.136 with SMTP id v8mr12820212pfk.82.1478917424464;
        Fri, 11 Nov 2016 18:23:44 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id dj2sm18073027pad.19.2016.11.11.18.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:23:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:23:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/11] git worktree (re)move
Date:   Sat, 12 Nov 2016 09:23:26 +0700
Message-Id: <20161112022337.13317-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is mostly a resend from last time [1]. The main difference is
patch 10/11 to prevent moving a worktree that contains submodules
because these .git files may need rewritten to point to the right
place. I'm leaving the rewriting .git files for future (preferably
done by "submodules guys").

[1] https://public-inbox.org/git/20160625075433.4608-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (11):
  copy.c: import copy_file() from busybox
  copy.c: delete unused code in copy_file()
  copy.c: convert bb_(p)error_msg to error(_errno)
  copy.c: style fix
  copy.c: convert copy_file() to copy_dir_recursively()
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command

 Documentation/git-worktree.txt         |  28 ++-
 builtin/worktree.c                     | 179 ++++++++++++++++
 cache.h                                |   1 +
 contrib/completion/git-completion.bash |   5 +-
 copy.c                                 | 369 +++++++++++++++++++++++++++++++++
 t/t2028-worktree-move.sh               |  56 +++++
 worktree.c                             |  84 ++++++++
 worktree.h                             |  11 +
 8 files changed, 722 insertions(+), 11 deletions(-)

-- 
2.8.2.524.g6ff3d78

