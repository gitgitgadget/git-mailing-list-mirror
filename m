Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC131F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeETSkm (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43092 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeETSkg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id n18-v6so20744285lfh.10
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIqG9rcBpwrLjzcXZzkjOxY3Vxvukvec8Ri+laWTOjw=;
        b=Lwxa3jvygTHp2BzBGyPZpp8A6iDS8tt3yb0JC5DgQ/DxSw0ZKhzOprHpI2hc+AVF8x
         bfKRzrLu0gmjk6Ys4tQDXJTAMN4Nf5Y3xahthA0otQ//ZrKnmk7KQoORNDh4RKmDLzPw
         Vjpv+x+i5nYtmdjJxX3BF9VfP7AgBR7jZrp/AEL+Wh3YZIfg1wj5eMa/MSlFxEFBGrUz
         QFYZh5tfJtwOAF23SbrG9QLGpCACDspUfEgO+PjrXHf8dcVMrmFDcsYeq5+v2hEBE8Cj
         3NSMYSHNCVacZUB0oZb/H/YEm1q2ej46qJq9jXLRf3BPIQAGf1APLdYtZJxakWl+kfNW
         wmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIqG9rcBpwrLjzcXZzkjOxY3Vxvukvec8Ri+laWTOjw=;
        b=iYjUC5gTseDidXqykYTfXVEyjejKjM+FXPPdADzwJMqRnBjvX6/nb9zZyPEGvmNcvc
         k497UCNsOP6hr8b5g9m5nteVF2LHPfEOmJFgTQJQBOA+zz8HgRHdxaib/hTw24Kaj3Ki
         B0W3cwiYjSvNm8eXnUAV3HWg9nj+0xyTrARY3jBB1kyWtBOUu+cNBb5FdzTDRFH9dQ3u
         4+9e9U7utKQtCs3BAKSh0/JoV24lm83a5Y3kZx+l1FlUWPukSvoMd1DMDJCV2Ytl5Lk6
         Dcfl0jdZpchVTVoVW9EivUH28rVCK/940T+Sj1UM5NP5E4FfJHeHFd3+T8s/ld62jDu9
         UXdQ==
X-Gm-Message-State: ALKqPweULtypMQWc6MpiqSv8shyi9pLUqKPMeeo9TrjSKOPMief8gWkY
        g7s1gc4nMI5p9mN333WWCTuZhw==
X-Google-Smtp-Source: AB8JxZrkkfZuj9Iov2Sh1RJogBf1pm62x4mbrv/aZC6fh+A/ZIj3yMk/AgH4Fmc6lsZ9QtW1B2+sFg==
X-Received: by 2002:a19:f00f:: with SMTP id p15-v6mr26420219lfc.77.1526841634716;
        Sun, 20 May 2018 11:40:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/17] completion: reduce completable command list
Date:   Sun, 20 May 2018 20:40:05 +0200
Message-Id: <20180520184009.976-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following commands are removed from the complete list:

- annotate             obsolete, discouraged to use
- filter-branch        not often used
- get-tar-commit-id    not often used
- imap-send            not often used
- interpreter-trailers not for interactive use
- name-rev             plumbing, just use git-describe
- p4                   too short and probably not often used (*)
- svn                  same category as p4 (*)
- verify-commit        not often used

(*) to be fair, send-email command which is in the same foreignscminterface
group as svn and p4 does get completion, just because it's used by git
and kernel development. So maybe we should include them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index dcf1907a54..e505a1e34c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,7 +47,7 @@
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
-git-annotate                            ancillaryinterrogators          complete
+git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
@@ -89,13 +89,13 @@ git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
 git-fetch-pack                          synchingrepositories
-git-filter-branch                       ancillarymanipulators           complete
+git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
-git-get-tar-commit-id                   ancillaryinterrogators          complete
+git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
@@ -103,11 +103,11 @@ git-help                                ancillaryinterrogators          complete
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
-git-imap-send                           foreignscminterface             complete
+git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators          complete
-git-interpret-trailers                  purehelpers                     complete
+git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
@@ -125,9 +125,9 @@ git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators           complete
+git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
-git-p4                                  foreignscminterface             complete
+git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
@@ -167,7 +167,7 @@ git-stage                                                               complete
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
-git-svn                                 foreignscminterface             complete
+git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain           history
 git-unpack-file                         plumbinginterrogators
@@ -178,7 +178,7 @@ git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
 git-var                                 plumbinginterrogators
-git-verify-commit                       ancillaryinterrogators          complete
+git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
-- 
2.17.0.705.g3525833791

