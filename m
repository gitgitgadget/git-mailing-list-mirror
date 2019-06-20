Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E329D1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFTJz3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:55:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34232 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTJz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:55:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so1323277pgn.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxbj6lDbBXXyrTIBJ38WZDLp/pVPAS+qtdDqczJM2rM=;
        b=qVB9sId180eHi4GwEtPGipsh8osUze0NZv7hqoyQe5nKnAQTrA5vG/aS7dT8vl1NdE
         BN54KajmprMHDM5N6R4ZykKuIVmU6nWua6LTGjlOOXjgd3Xbp6avEBUwtd6NRokzb6ay
         EjuDEc3OAcORaVzPGfNehwg9/GdMsMUah93mSgI/sDNxSIGNIkFO26EYx8R/XNw8Zrfq
         DyHru8N9A9Jq+9zdIcSAf+9XDfkCIPJa6DA8q+iqfi3w9I2wAHml0XHIFQ1kDvRdxkaJ
         WDsq0SrVuMyphYr/IYXznJOtN8Zdy6IHpRcYcDy0JDCGvqNzsQ4duBFsjKZ4D3lWOpQ2
         0hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxbj6lDbBXXyrTIBJ38WZDLp/pVPAS+qtdDqczJM2rM=;
        b=oinMKw9SK4rbsyhm506s7fxKKTHJ7pQivbxa3oXNM26uEnCpCyTbarg983DlAIOv5X
         vubl1m6vowiRG/VqxqffHUizhIlSFUjJLEWDdgCYskG1tId43UhsjoWUXJFFqmUXO+mz
         gf2syuK6YfjSDHVM9fXGrJhU7URRvn6XgOSAhKnnCJ04ndaySX4XfZhZv5YfJDPFqvtK
         XTJ8bwUITD+Q0wXHULc7Z8IZtlUjrhZBHZ2/mnp579yAnuHQHnDevJcwpNGdWcUjvI8E
         39C8K2WaTs6PH62LfkKTY7ioY2v9W9t506nS3C0BlUaOTr0jU0gmJiaGIpYWO0uSh09y
         CXWw==
X-Gm-Message-State: APjAAAUjD+wJlXLGQbgDaGrppnGOG71zABx/G6LEw4z9y7d3+G1Y1+tT
        ntTtKWPlE7JH1gOPITc/OOtU/cZo
X-Google-Smtp-Source: APXvYqzQ/TpBfxGRNVwcGV28/Lr6ZQwWgPXjB7Z94ABRX34kNngzvINqKIkizHe6q3YCQdLBE7qWkQ==
X-Received: by 2002:a62:2b81:: with SMTP id r123mr86692137pfr.108.1561024528404;
        Thu, 20 Jun 2019 02:55:28 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id m31sm7676115pjb.6.2019.06.20.02.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:55:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:55:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/4] Some more on top of nd/switch-and-restore
Date:   Thu, 20 Jun 2019 16:55:19 +0700
Message-Id: <20190620095523.10003-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is small refinements (except 4/4).

2/4 relaxes the 'in-progress' check for bisect because switching while
bisecting is normal _and_ safe. 3/4 makes 'switch -d' completion much
more useful. 4/4 adds the last missing piece in 'git restore', records
new files in worktree as i-t-a.

Still on the agenda (but may take some or much more time to do):

- submodule support in 'git restore'
- handling "git restore *.c" where *.c is expanded by shell

One item I have a patch for but decided not to send, is to imply
--detach in 'git switch' if you are already in detached HEAD mode and
want to switch to a non-branch. In other words, it behaves just like
git-checkout.

No more protection is needed in that case because you're in trouble
already if you don't know about detached HEAD. And if you do know,
then adding '-d' is just annoyance.

But I don't find myself using it and I'm a pretty heavy detached user.
So while it kinda makes sense to do, I don't think it's worth the
complication.

Nguyễn Thái Ngọc Duy (4):
  t2027: use test_must_be_empty
  switch: allow to switch in the middle of bisect
  completion: disable dwim on "git switch -d"
  restore: add --intent-to-add (restoring worktree only)

 Documentation/git-restore.txt          |  7 +++
 builtin/checkout.c                     | 82 +++++++++++++++++++++++++-
 contrib/completion/git-completion.bash |  4 ++
 t/t2070-restore.sh                     | 22 ++++++-
 4 files changed, 109 insertions(+), 6 deletions(-)

-- 
2.22.0.rc0.322.g2b0371e29a

