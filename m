Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08ADD1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeESE21 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:27 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:38106 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeESE2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:13 -0400
Received: by mail-lf0-f44.google.com with SMTP id z142-v6so16760327lff.5
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpH9mzlOBqspqSW5VMPLtVjmUPQmmIKSho7A3m/JWoU=;
        b=az+U889EA8DlUJt4H1sjqXUTOX/pOJKB8MomTT8DtytXtAjI11Zh5sDKy6vl8BF7g8
         ZZV7lKtLxKCtJvE+oW3JLqRtv7eynOQkZoN6zcZ1qrJyVrhpFxYyljhte4+G8xXVvJei
         Pe32LLpmYSzH+r6ReFFMWnrndMw997D6DK5WjfosvN5be45+3RIfLf4MjkHFwkkdRXCu
         Wz+uNEN2avfEbFPeT0zLFq7zOvDKMPeTKpDv5vYyukx1vK7786fTgkgEX5wPJgZ1Yhmh
         ZQgcFy4empbEU7UijKq9LaSjyvr2Em61NBbDG5G38TH94dzTEAOnARacninAuQQr3nEL
         eWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpH9mzlOBqspqSW5VMPLtVjmUPQmmIKSho7A3m/JWoU=;
        b=RW68vj11Vh/XJzNjTBOo8X1Jc3AZ1Dt/HSuhS9ProPnknqldBTMk/1is1Eg5lfghAf
         37tsJY0KEYAcuV/DPWDepy4xhsdLcAOUFx3CZcpXwO18NoYanx/isTKXw3cxHM3FiJjA
         q4M925nWBo3bHeEwBjcIw0EMdON7BBboIQPK4UZ+GXwtw6fMqPo1tr8FzN4ua5PFi+8w
         i/6RuNiWQblmlYFx42xd3G8EZb8AwD/etmZ17YdXAhLOuMdZ2ECR3utl7DxKUX6BfB8i
         5r7apEAGvHfX8xtuDumnFES5QbKePargfvico9Co9+JD19mh3IIKuajeOzrD0XfOMKos
         XZHA==
X-Gm-Message-State: ALKqPwfoE5DnTT9hEp7NnA75YkT7c44ZAaR+V+tkfM/2t/5CJowSZN+T
        jJPBJ3iyikXmm93MaWHQC093sg==
X-Google-Smtp-Source: AB8JxZp/NkpURh9tXGtGDsZGvK+hujb5Vuk8mpRcviER9V7oOTlVgY+r+XcAtrWUz6tnIyM3KnC6JA==
X-Received: by 2002:a19:4ed1:: with SMTP id u78-v6mr22051925lfk.40.1526704091624;
        Fri, 18 May 2018 21:28:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/14] completion: reduce completable command list
Date:   Sat, 19 May 2018 06:27:51 +0200
Message-Id: <20180519042752.8666-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
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
- p4                   too short and probably not often used (*)
- svn                  same category as p4 (*)
- verify-commit        not often used

(*) to be fair, send-email command which is in the same foreignscminterface
group as svn and p4 does get completion, just because it's used by git
and kernel development. So maybe we should include them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index dcf1907a54..8462ea475f 100644
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
@@ -127,7 +127,7 @@ git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
 git-name-rev                            plumbinginterrogators           complete
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

