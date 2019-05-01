Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9426F1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEANMB (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:12:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34591 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:12:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so7324937pgt.1
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmG3b+PJKf3SDBzjvBJs10bElVE2m6jusL7sEtF/NY0=;
        b=RK6sDombZ47QB4XExPXEY+wsc+NKLv+29Y3LK+5mH5CdOw5/xqOt6z1qDpMXpY6qh0
         +AyVzDBED08qL3Rfpc7IDz9CXmiOe+doVUX7HaiQc1rWTzcp+SvzUzosdDRXuEdqOaa5
         koKAuZ+ouauTTuQ1rrzfudLvb2esIo1WA4k8lg8dA0VjfYYn8IQNve/9guF3UIuupEzW
         JSvP1bp5N76PmfWILjZTouJQNxvgwp4h/FkQPLlwMSx9+OI+kxIIPqUapMzXcc69Bxtc
         fu+Oul1XpHr4RUd4Qduu8zXHEhz8AaO/6Xd50F/wngi86J5ZU3DURibPcHTxnoDmvQEO
         0DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DmG3b+PJKf3SDBzjvBJs10bElVE2m6jusL7sEtF/NY0=;
        b=Q1YdQQMCf60gGn8TGIKVX4RfqSzYn9KhjZlsnAO4IDUyp9eKVpdi2Ly1lME757QClS
         DkyGIIDavDe20iTgl/+pt9J2D1m8B5WoFBMjFhAQK8ndACkWKEeDKamtXklgO3C+6ZvT
         AqYLsyvbWWtqSVfF2SnF8Bdg5owI8HayHLT9+/1iIw4sujcTtWEBuIs8JouvyB57OQt/
         IppYNhX98O7vFW1ZNdvlVHFgFR12B9zqoPx07zHUUvqWb3UeHIcM6gu9ghEsMRa28F7P
         AD8/Smh32JXXlPfemBFzC9ZlUWqOm/+bw4fNY5fRM3i7mSt1QDNWk8iU4IOCqdYPnfkH
         V2mw==
X-Gm-Message-State: APjAAAWKXOrs6qBxfv0NBXPuKR3dDYVmkm2Mx8jIIT5Jk11fvHsojfd7
        a3fm9rHXviilFbHsh4hJEXr9rIKG
X-Google-Smtp-Source: APXvYqyl4mIMLLaxCt71XzsEST9UEKrXKeKrt93gGOfkQscAAQL7Myf8yhrKdRrfKc5x5ImXQE5lKQ==
X-Received: by 2002:a63:8741:: with SMTP id i62mr22792807pge.313.1556716320435;
        Wed, 01 May 2019 06:12:00 -0700 (PDT)
Received: from ash ([171.226.41.84])
        by smtp.gmail.com with ESMTPSA id w65sm27425345pfb.59.2019.05.01.06.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 May 2019 20:11:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Add "git merge --quit"
Date:   Wed,  1 May 2019 20:11:50 +0700
Message-Id: <20190501131152.314-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1110.g9614c01b33
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nd/switch-and-restore suggests 'git merge --quit' to get out of a merge
even though this option is not implemented [1]. It's a soft dependency, no
actual functionality is broken by the lack of --quit, so I'm sending
it separately.

[1] https://public-inbox.org/git/78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com/

Nguyễn Thái Ngọc Duy (2):
  merge: remove drop_save() in favor of remove_merge_branch_state()
  merge: add --quit

 Documentation/git-merge.txt |  4 ++++
 branch.c                    | 11 ++++++++---
 branch.h                    |  6 ++++++
 builtin/merge.c             | 30 ++++++++++++++++++------------
 t/t7600-merge.sh            | 14 ++++++++++++++
 5 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.21.0.1110.g9614c01b33

