Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78182023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbdCCKPT (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:15:19 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35475 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdCCKPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:15:17 -0500
Received: by mail-pf0-f182.google.com with SMTP id j5so32194220pfb.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 02:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQW9CJv8UDjc4vjhHPOoP4UK/c4nYa0+Eo+QkQ8py7M=;
        b=deRTFLr3Pgw4E25M5hA/s76/Pqvzw0kdWkwO8Yyp13r/NOr/AW0Ck0sTE2EEKvWWzn
         6tLew86t5Z+jL1kmlxO5Hdz76UmCla6H+MN3b7kMRzHrTUXAsrWM2BApG1HL8NI8+CY/
         LfFPjlLGHml+xzx+8wOPDlbbqHtarozh9nVS4URp3PjRosnvMw3RU0FFHnSbgIibKl7T
         e6KdyR3kw7IF7v3paYEoCI0knE+Rd95ilYz2j0p3C/JcOkKBxXeDLkpDtPbvSlsGVGq8
         zZjd6H/QMaUV5jGZ6zMBfQdr+FbUrVeRzmsehXFERnK2NQd5pZh90G/Oz3xTn0+RKuWT
         CiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQW9CJv8UDjc4vjhHPOoP4UK/c4nYa0+Eo+QkQ8py7M=;
        b=XhdVDQpIiBj6dTY+tsgcTbmp4k4ESlUZ/HipVHV+ODWKX0tKQ7jhZ1yP8ii3f7I3UB
         SNaNN5A3uwwtKqy2AuTeJ4pStWNt6yFQrGs3cI2rqDo1VHT7vIsmdnk7MAyquXGDfQmX
         SIF26PsfBAU/88sl6YU6HV1kcisWwWOfKEZ83hAqHNHlFOT5U1rd1KB37jr5///Y1oXg
         aBkcPGAzzdYIRLR7qwBJ5Ai0zoi+YdndfHqnyZa03tYRF7e/0irlAsbC7qI4azcViRUv
         duLxSuN+bKHgSyMw9cePQ+nhtUBp4cnyB4UCSGTdl+8aoycNW2C8+bGLhdtmgOWkleIJ
         rHww==
X-Gm-Message-State: AMke39kuKeXN8tY/IzwqnsR5B0DBAr81FnvfMiOX6D+dkzz+9ZiHbekkOG55F3yHgmqkrw==
X-Received: by 10.99.125.23 with SMTP id y23mr2296384pgc.79.1488534194673;
        Fri, 03 Mar 2017 01:43:14 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id 127sm16663130pgg.11.2017.03.03.01.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 01:43:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Mar 2017 16:43:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Improve error messages when opening a directory as file
Date:   Fri,  3 Mar 2017 16:42:50 +0700
Message-Id: <20170303094252.11706-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The topic nd/conditional-config-include hit a problem on Windows [1].
The test basically does this (much simplified)

    echo '[include]path=foo' >~/.gitconfig
    cd ~ && git init foo

At some point in 'git init' after 'foo' directory has been created, we
request to include ~/foo as an extra config file. But it's a directory
and we get some error like this

    fatal: bad config line 2 in file ~/.gitconfig

The message gives no clue that 'foo' is a directory (and probably
wasted a good chunk of time of Johannes). This series tells the user
about that.

The other half of the problem is, the same test runs without error on
Linux because it looks like fopen(dir) returns NULL on Windows, but
non-NULL on Linux and only subsequent read() returns EISDIR.
Unfortunately the config parser conflates errors with eof, I think.
And it simply sees <dir> as an empty config file, ie. a valid config
file. So no "bad config line..."

I'm making sure even Linux now reports loud and clear that config
files should be _files_. The same treatment is done for .gitattributes.
I'm not so sure about .gitignore because it uses open(), not fopen()
and I don't know if open() behaves differently on Windows.

I briefly considered fopen() and open() wrappers that always rejects
directories (if you need to open a directory, do it without wrappers),
but discarded it because it adds an extra stat() call everywhere.

[1] https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33#commitcomment-21121210

Nguyễn Thái Ngọc Duy (2):
  config: check if config path is a file before parsing it
  attr.c: check if .gitattributes is a file before parsing it

 abspath.c              | 7 +++++++
 attr.c                 | 8 +++++++-
 cache.h                | 1 +
 config.c               | 9 +++++++++
 t/t1300-repo-config.sh | 5 +++++
 5 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.11.0.157.gd943d85

