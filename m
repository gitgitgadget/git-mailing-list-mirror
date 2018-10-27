Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557B31F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeJ0PDx (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:03:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34992 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeJ0PDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so3122910ljj.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZng75x/xPyY6cW/v4hj3GkMpT3ULqbqBLmwppJhagY=;
        b=uxY4e/vxUSbIeyD/RDLukDVlODF1/EKTD0kum1N52On+proBOpHsdJtoayZVmpsA3l
         9fRdIeP2oYT0dUCy2ID+0/1mVf+1bgkQ1YHB9vbZ9DlXeluXeOvpLcia2EheDZk1or+G
         kO+fkdfHcqXtJu34kqKv+4bj72yWy6MvoJRhZH8H6qyGJ9HwI3zGVMpLCyj+CyNKPgmO
         zWewWoaVNjNGTzJ3XjgLFE1FxzTU9ZbKer4oA++6joyAS3Nr+t1j2I0JbojK21oX5GQB
         J2bEM0hkC9cJ6lzz3XMcWstVSU6vRD/9Q934fsSMlKcOWMRQz+tUkxfqZYO421MGAgj0
         pjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZng75x/xPyY6cW/v4hj3GkMpT3ULqbqBLmwppJhagY=;
        b=eGsT5b718s/NAuYfwo1x+yWMSMdyadBQ6TSHrP/E9wSzxj/6szuq3/IjdLd9QrWrTq
         yQp28NP2oVd4Ccf/DTV8Pmj4jC/jGARZQLB7v+ZzGMbCImGkPW3m8P2npdASJzB7beu4
         M9JXZD8IpiF/fo7QuHfoerhQQlNDJw2vHcV01s0jLfqJyft7FD6OXkluYhfbXtnM6qX2
         ymwXy2J4kYchAbuiVgI8wHMvpJ2rlCZBZSUu3J15umMRS9onnyfR2kNrweyQNkbxg0+e
         7LTI1DbgD3n+RaRqsw/m7A1aQpms+QP1p6jRJMZeZcEX/D6Fb/rA9HBIWDzYAb+05ZBG
         deEA==
X-Gm-Message-State: AGRZ1gLVmV1RJzbqucLdIUB5y0KnvylKnHEzqwpuM/YckrNZJ01GzCay
        DuasCEGlLEeFwSyGEas3EoQ75b11
X-Google-Smtp-Source: AJdET5diZ+xTO7nqsQ+fRYudfGgV7GIy1yQT5CuOFQQ8mMinV0ua2h28XMoOJIOBP6wuReLoUpm3ow==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr3631763ljm.143.1540621437323;
        Fri, 26 Oct 2018 23:23:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:23:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/78] Update makefile in preparation for Documentation/config/*.txt
Date:   Sat, 27 Oct 2018 08:22:34 +0200
Message-Id: <20181027062351.30446-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

config.txt is going to be broken down in smaller pieces and put under
Documentation/config directory. Update build rules to take these files
into account.

A dummy file is added to make sure wildcard expansion is predictable
(depending on shell setting it could expand to nothing or becomes a
path if config directory is empty). The file will be deleted once the
move is over.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/Makefile         | 2 +-
 Documentation/config/dummy.txt | 0
 Makefile                       | 2 +-
 generate-cmdlist.sh            | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/dummy.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 95f6a321f2..48d261dc2c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -285,7 +285,7 @@ docdep_prereqs = \
 	mergetools-list.made $(mergetools_txt) \
 	cmd-list.made $(cmds_txt)
 
-doc.dep : $(docdep_prereqs) $(wildcard *.txt) build-docdep.perl
+doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-docdep.perl
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
diff --git a/Documentation/config/dummy.txt b/Documentation/config/dummy.txt
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/Makefile b/Makefile
index b08d5ea258..e2ca83203f 100644
--- a/Makefile
+++ b/Makefile
@@ -2068,7 +2068,7 @@ $(BUILT_INS): git$X
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt
+command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index fa1e5475e8..709d67405b 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -80,7 +80,7 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt |
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	while read line
-- 
2.19.1.647.g708186aaf9

