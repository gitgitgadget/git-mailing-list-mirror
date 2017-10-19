Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C9F202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbdJSScI (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:32:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47308 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754300AbdJSScH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:32:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id t69so17754133wmt.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4MPMdmXfjL99w/QUuQhxfXCyGjGzNpd8sDiDMSh380=;
        b=YsqtUSQ0k6+yFb1lVspl7HaT3A0uPiFarmrLD5NANQ+DoUnLrK88A832J82zf4JKMa
         NyGGEwplEY0ePgS58qH5vHTO76JAkBImnxmgpXKa5lCIBdbpZoHC/EkFb3II5hqRO5Eq
         BkTYzVAtj2t1AS8xn6tl6pD4VdOrx0ryrnVBLKRK7RTAoJLy/vFJfM9wlFwN/f3k32hJ
         09al2Z0LpOdI00pGBpa2ct1hm9kz4SHfk6BDy31iOtxohtnzJZlD8Ppz2zmXQyEmdUPy
         omOq1EutB0A9cecdPTGRS3D/YQdU5M+6g6tpui0ZGB9pugcYr2M+u4szh6nJvZ4JkV5K
         heQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4MPMdmXfjL99w/QUuQhxfXCyGjGzNpd8sDiDMSh380=;
        b=bET9pwuEna/Fw21yQWBh1x2tfnBQ8aJT8ryBD72vQzNf7+1r0UxZPVpPPl1IORI42+
         Zvs1ifz3MSLdZo83SJ8qX5vsOCW5bevVdbuYgC8IQgaRtFMNu2TrcYiPSCiUuxjLiqTb
         +GLwqcLPiSmwAYFPAKc7E8auMXx0uoer970FX6uGqwE2JDPUoAEKJWnvwFjMWrE044aY
         regk8L20KW7tk/qVIeXilHmrqA1DuS5k4SD+tkCwXs5jAvb+Y6XZbHCotCHxnY/wUxZU
         JpdYYpEqok6dvNihZ0eb827I2ybSIaxGNI3H1kPWLEpxX8srjfHQalJ+20/x/LRoqqzd
         dwPw==
X-Gm-Message-State: AMCzsaU4rFCCcL22+oa7Mhlut8QFse8pk+QHa1bFxBiKQJwyUPhW+T59
        qR5MFpJTS/ia4fRHkjEwyDRuX28L
X-Google-Smtp-Source: ABhQp+RvNPB1iR/JSZh3BFoYEqkb1s28Dvi0Nf4eVqciysLeJeRiS+L+YH2e829TRTwwpNV1rr2D1g==
X-Received: by 10.28.218.207 with SMTP id r198mr2270361wmg.14.1508437926045;
        Thu, 19 Oct 2017 11:32:06 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s70sm16306571wrc.83.2017.10.19.11.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 11:32:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] mark git stash push deprecated in the man page
Date:   Thu, 19 Oct 2017 19:33:04 +0100
Message-Id: <20171019183304.26748-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.65.g660fb3dfa8
In-Reply-To: <20171019183304.26748-1-t.gummerer@gmail.com>
References: <20171005200049.GF30301@hank>
 <20171019183304.26748-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git stash push' fixes a historical wart in the interface of 'git stash
save'.  As 'git stash push' has all functionality of 'git stash save',
with a nicer, more consistent user interface deprecate 'git stash
save'.  To do this, remove it from the synopsis of the man page, and
move it to a separate section, stating that it is deprecated.

Helped-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 53b2e60aeb..89b6a0e672 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,8 +13,6 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]
 'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
 	     [--] [<pathspec>...]]
@@ -48,7 +46,6 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 OPTIONS
 -------
 
-save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
@@ -87,6 +84,10 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+
+	This option is deprecated in favour of 'git stash push'.
+
 list [<options>]::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
-- 
2.15.0.rc1.65.g660fb3dfa8

