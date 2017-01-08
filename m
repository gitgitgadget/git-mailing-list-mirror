Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456401FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbdAHJkf (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:40:35 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33861 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933644AbdAHJkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so1441687pfb.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc+9VR3a4M/6MEpLnA6MsPmhfTRMIwqaJf4RJfe129U=;
        b=Xk7IexXOwCqscetOK6H4UykGDfhEnfxG2XE9atC4u5HKuDUPz7j6LddcJZUrqBsMmF
         nyuidFbcMOr/wpvdRrT8V8Sm/IHeAJyrmWp+oA2j5pzkvEJLHGmW+Qv51ITLkpPejZuy
         jTA2SOTE8MawPNVCEmcff1t7FveaYJpPy7s5u+pZRwqocx504qkT60XyF8NGY2wL+xPt
         Nd2XlHJrUO04aZhb7gWzEVnM6Q22HfBxMuVp7dXmGiEp5ZiqCD1QokBku9CEUF+3pKbx
         XV++7SwZtNAmYqLURboiFN7qddnxHWc/++UVAg6wVIdG//k9g+kbwy/mdS2cKedP1t4j
         mrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc+9VR3a4M/6MEpLnA6MsPmhfTRMIwqaJf4RJfe129U=;
        b=IX1hk3lmYljj38cCF0hoz6j96c+Vxi61hUOZmVhKVXTkbRKAmq134XxfGioP2ATP9s
         xsRl9aIprfHDohzFGfmyMEALsYKKwc3mgOJGwo6s3cio4sbyNcZf5rKnpjNaKKN+QSME
         yomnxT1HdCyhJYCKbcaW5d0+qvRjDis9LaE3CBl8zkYNPbk0KfOfw/wD5D6zDp3DFL7g
         oY6+T7wZMzRcdntsUQ/luHaezJnOrBFQUe+Dlv0pl3Db+fC7HdQewXwDUPOpJffC+6n3
         dyvUoPACsN2413EVUtnYy4Sitx3Uw7Qg63VYGFZCpAYqmG+/DJdc7vh/4131DIRiZlBt
         +3HQ==
X-Gm-Message-State: AIkVDXJH9CxFbS+1bg2AFMBtkx/1tmT3eyjXa9qb5qhKuZQJQoA39+eHdRIWPfyqb+mwUg==
X-Received: by 10.99.226.3 with SMTP id q3mr155917032pgh.37.1483868420509;
        Sun, 08 Jan 2017 01:40:20 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id t15sm127553484pgn.18.2017.01.08.01.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] git worktree move/remove
Date:   Sun,  8 Jan 2017 16:39:57 +0700
Message-Id: <20170108094003.637-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version is the same as nd/worktree-move but with the recursive
directory copy code removed. We rely on rename() to move directories.

Nguyễn Thái Ngọc Duy (6):
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command

 Documentation/git-worktree.txt         |  28 ++++--
 builtin/worktree.c                     | 162 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |   5 +-
 t/t2028-worktree-move.sh               |  56 ++++++++++++
 worktree.c                             |  84 +++++++++++++++++
 worktree.h                             |  11 +++
 6 files changed, 335 insertions(+), 11 deletions(-)

-- 
2.8.2.524.g6ff3d78

