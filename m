Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6206D20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbdK2UDV (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:21 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33604 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdK2UDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id v22so4546637wrb.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aee4gZ1jgzz9k+vD70eo3pGZUsGmvzW3Gyz451Fkm4s=;
        b=c4HxB3SIo7c4HWQrCiV7UrScmFb9KkxfR22GIIbI4KcIRMeMuLkszjApljNSBn3l3A
         baDn7I3zNYz3A3A+XqOea7okX35L5lmXB+485BDFP0d0hJIpobamcxWcV6XIGLBH5bzS
         UnibXWyeoB3Cp6nwLlbsaJhBIshy1Sv6xHqIv9Y59kKrUruXOy96Uan7aulPhwgPZVxn
         T5DKp5OGO/jq8gPFtwKauq3uiOCwrFY0oyeS4ZV2kble65VFjh8cAa5Abi5xxWS13IcK
         tqeLapaOI7HFWUzXfdzq00EGDB14y17ZulK4o5OUdDmrdSrJW0Ilj7zUB1xfmY+mb0k2
         +EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aee4gZ1jgzz9k+vD70eo3pGZUsGmvzW3Gyz451Fkm4s=;
        b=lBexRxJyy4gJ0S0Li+rrCYPDrJsoc0WZTFyLb0jLh43NrbwAqX1jGcsoMihJJ+51zK
         nveajOn9txTqb4PsOIygGEBbSSmL1f6NJs8/NfrL88iypf/u62GS0sl3LW8Dt6p1tr9p
         cRSYRyWR68Lr7A+DIVHxOqZsni7NP28NA2PDiNIlpvyZYwo+mgrXB2etPg4gQuMiZf0o
         Kakb8Ydec0hQFjesPgO8P7N88LMMBiA8r54y6LDaROp+OTYAabvo4rSBsWw9Ohsy2VTA
         yMV6JKVhp9YoRPgCSZKrJqguxabxkgNePwIlkBGC+k5tEJeKS/3jK86DDTf0RHvnvuoD
         XYkA==
X-Gm-Message-State: AJaThX5h/sFssncJB2m/H4sSQoC1F6WWMjP5OizRLz1JB7oog56k5Xb1
        XgdOeI51FBZJGwswUp7n9UVPkAas
X-Google-Smtp-Source: AGs4zMb/s5oKkavJC9ZFo86Tkcta82hzcAGicIvMKwu3mPjXDBrscDoJHGXAQeYJ5PJhdNRp9gpXYQ==
X-Received: by 10.223.178.232 with SMTP id g95mr27293wrd.53.1511985799182;
        Wed, 29 Nov 2017 12:03:19 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 1sm2618851wmu.8.2017.11.29.12.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:18 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 0/6] make git worktree add dwim more
Date:   Wed, 29 Nov 2017 20:04:45 +0000
Message-Id: <20171129200451.16856-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds were at
https://public-inbox.org/git/20171112134305.3949-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171118181103.28354-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171118224706.13810-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171122223020.2780-1-t.gummerer@gmail.com/ and
https://public-inbox.org/git/20171126194356.16187-1-t.gummerer@gmail.com.

Thanks Junio for the review of the last round!

Changes since the last round:

- rephrased documentation and commit messaegs a bit use the
- established pattern and call git_config only once, instead of
  calling it multiple times.

Interdiff below:
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index fd841886ef..89ad0faecf 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -116,11 +116,11 @@ OPTIONS
 	in linkgit:git-read-tree[1].
 
 --[no-]guess-remote::
-	With `add`, instead of creating a new branch from HEAD when
-	`<commit-ish>` is not given, if there exists a tracking branch
-	in exactly one remote matching the basename of the path, base
-	the new branch on the remote-tracking branch, and mark the
-	remote-tracking branch as "upstream" from the new branch.
+	With `worktree add <path>`, withouth `<commit-ish>`, instead
+	of creating a new branch from HEAD, if there exists a tracking
+	branch in exactly one remote matching the basename of `<path>,
+	base the new branch on the remote-tracking branch, and mark
+	the remote-tracking branch as "upstream" from the new branch.
 +
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 426aea8761..002a569a11 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -43,7 +43,7 @@ static int git_worktree_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return 0;
+	return git_default_config(var, value, cb);
 }
 
 static int prune_worktree(const char *id, struct strbuf *reason)
@@ -371,8 +371,6 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_worktree_config, NULL);
-
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -603,7 +601,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_worktree_config, NULL);
 
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);

Thomas Gummerer (6):
  checkout: factor out functions to new lib file
  worktree: add can be created from any commit-ish
  worktree: add --[no-]track option to the add subcommand
  worktree: make add <path> <branch> dwim
  worktree: add --guess-remote flag to add subcommand
  add worktree.guessRemote config option

 Documentation/config.txt       |  10 ++++
 Documentation/git-worktree.txt |  44 ++++++++++----
 Makefile                       |   1 +
 builtin/checkout.c             |  41 +------------
 builtin/worktree.c             |  46 ++++++++++++++-
 checkout.c                     |  43 ++++++++++++++
 checkout.h                     |  13 +++++
 t/t2025-worktree-add.sh        | 130 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 277 insertions(+), 51 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

-- 
2.15.0.426.gb06021eeb

