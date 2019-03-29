Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0449720248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfC2Kjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:39:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46872 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfC2Kjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:39:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so1010460pgv.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhSMomsE0RQrpZy11+WXvteiTD7my5g4TOCBBXbKs9U=;
        b=ZmimBiUIfzTReCVbH93J7HwZxu0WCfuglOWHcDaVmnqFgKZVgXfe+wmCqrtxBZaj2L
         rvQQc69XhG7VDV5CQ2c5vAo5AiIIBPGMPFO3NXEZAI9NoW4USHbuEatq507znlJ1OWl1
         /wDzZwBREKyRGHd0fK5K1o4m1mIj60KEXB1GrH8okCXhE2wWuH/57gp7DTzyksq9Nfah
         v3B3IiE7yIMaW9qce4azTXZrx5gAY1Fvbw0Xkysky/ho3cbUT38V3rFku7qD/SmugmG3
         FqBwGzKvzqtA5zkhxF2SbPWbPB8ILyQ2J2Uspu4JTuNggoogZUKOTQsJ2f972hBaKije
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhSMomsE0RQrpZy11+WXvteiTD7my5g4TOCBBXbKs9U=;
        b=F2aHDIufzK5vr/Y2akVPn7FCalvbPubZTIfx3iWqLEZb5nKNlEN73exHxo8SISP0H4
         Rew3SNX11JFmSkEaIXavc4mF4IGHTh64jwdVTS25NMR5PdiU69XPfMjdSWMu4PfVCmPk
         OLIZ5px7Pc4B/1jIOVmwISPyiMMO6gWGdx3M2Rp2YR0rf/w3lkOgK40JAiQbslo+mSyH
         +nYxpmakTZKIiQ31XqfjpgAW/8Jz+j9OmNkyHCniXXuZMpN0jd+A5hemZH0ocqzqPnmj
         A0Gs1sSGzElRvP3cdfLgRoVUGCPKEarZYFQCzjMkX6H1t/NhbTZGeM5FRFQQSygmUPRG
         8aWQ==
X-Gm-Message-State: APjAAAUBumWz7QmqmidQGWhaKMfTUOqyIT6vRB9kNZWYldloXdrgtvtQ
        ZKSzeOGWhN4b6ceoaUp0adbE33ej
X-Google-Smtp-Source: APXvYqyGpORjJr12LmSDEWB5pPLy5yYdlUrBe+W5hsVXKymo9x20F7duvS5CeB10qqj6mskeqb2Jqg==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr44751345pgc.161.1553855987982;
        Fri, 29 Mar 2019 03:39:47 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t82sm6057969pfa.153.2019.03.29.03.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:39:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:39:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 01/27] git-checkout.txt: spell out --no-option
Date:   Fri, 29 Mar 2019 17:38:53 +0700
Message-Id: <20190329103919.15642-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easier to search for and also less cryptic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f179b43732..99c8c0dc0f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,7 +118,8 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
@@ -262,7 +263,7 @@ edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 Note that this option uses the no overlay mode by default (see also
-`--[no-]overlay`), and currently doesn't support overlay mode.
+`--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -270,7 +271,8 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
---[no-]recurse-submodules::
+--recurse-submodules::
+--no-recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -283,7 +285,8 @@ Note that this option uses the no overlay mode by default (see also
 	Do not attempt to create a branch if a remote tracking branch
 	of the same name exists.
 
---[no-]overlay::
+--overlay::
+--no-overlay::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-- 
2.21.0.479.g47ac719cd3

