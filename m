Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F1A1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeDJSdZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:33:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38833 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDJSdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:33:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id m13so13776459wrj.5
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qd0pOAHou/xTaE6hERdijPs1ynEDLh486l8JobiFvu0=;
        b=BSEeTWcnIeUyr/4kEMbtcijQi8DjYAEQLUQqTZN6spVlhoSKr/kecQSZO1iLpmfmR+
         9TZaW2mLVQeNFmjsYAaYSGRDesT+vKNKJXsmGzPXBtpDn340A/13oerFG14VTUmuxnYj
         qGZUQNr7SFeSBx+3uhForUm01FM6Wk1+uXMAa3yD1w5l1gWOnIsBZ78go2Ib9ZWvqN/M
         e64+8eRor1Hmv7bdyVgY4QJru/jLF/6vQfeFeW4v2gUavr7IlOoXUvtKCL+PGiyz7MIQ
         otDM4wjNTqkJa3KDik1ISaX+AOUUqnqoyZ5IUeln0y7M49LYTnTlbHndvxDYZ9Pe34vU
         sXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qd0pOAHou/xTaE6hERdijPs1ynEDLh486l8JobiFvu0=;
        b=iQAhlekq+/7J4cQZz8PZG3+P9vJNorEohQZr6nNcimhDHKPkTIXSSy69Z4hnBKwONi
         P6Ho5NqTE34GlFDucFskQvRbEd062QXlv707GA2A2U5z4c2K5zkliJzOp4TLODwCQxNp
         V3Lsa6MwN4qXGGaHzFt3zI/Oz5s5sP/Guy9hF9H8dKIAoDplG5/pLLb1ETNOpULGj4SR
         hJHXuEqIqOS6HW9FSeM8ysWOHC2wL7te3LSwiW4BslTdqsHhpQRwE/qQqrGs7kDbtKwb
         2ox4OzUncOvESTwr4YcVuACQEllhYuSAF8yLudsheFaTdAFbYf5q3PJf2kROq2TIKUwd
         JQ0Q==
X-Gm-Message-State: ALQs6tDs0yd7OHOFQ2bwn5G5+gYzUrjWA0ZSzRhr0cTecADLrAOnpLMr
        qsCvQdj7TDqYQCaKEaObOW+jww==
X-Google-Smtp-Source: AIpwx487nfGA44FRMIVWT8vUBiCMUyxkpTfCxsHOk4Jm4pKe02bEb2kUM9OdW7BAENsMjfpy1/7q1w==
X-Received: by 10.223.135.76 with SMTP id 12mr1091264wrz.275.1523385188263;
        Tue, 10 Apr 2018 11:33:08 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id j21sm4426354wrb.49.2018.04.10.11.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:33:07 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 4/6] doc: added '-d' and '-q' for 'git push'
Date:   Tue, 10 Apr 2018 20:32:22 +0200
Message-Id: <20180410183224.10780-5-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing `-o` shortcut for `--push-option` to the synposis.
Add the missing `-d` shortcut for `--delete` in the main section.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-push.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b08302fc2..f2bbda6e32 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
-	   [-u | --set-upstream] [--push-option=<string>]
+	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -123,6 +123,7 @@ already exists on the remote side.
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
 
+-d::
 --delete::
 	All listed refs are deleted from the remote repository. This is
 	the same as prefixing all refs with a colon.
-- 
2.16.2

