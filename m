Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2B21F407
	for <e@80x24.org>; Tue, 12 Dec 2017 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdLLLY2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 06:24:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45372 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdLLLY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 06:24:27 -0500
Received: by mail-pg0-f68.google.com with SMTP id m25so13193059pgv.12
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4/ga+S9d9DdSuZNYuqbRY7GZtijW3kRnLNt4rJzSAdc=;
        b=jPJMYLHA2xMbwlTJWzXLH9NMwq6dbkhhPwUC0+GrsOBApqnZBaJ05D5PAlHDE/kJKf
         VUxQ8nVp51kP3AEk0AY9I01BHZwooETnB1EqHwAZevjdSQyFDzSTnpxbkrl4KmHuje0j
         u879DjW1ON8QiP6IansU/qSJn5Ay/j2B90NzqI+iZky+ba2HVmC2HUvC1bzKyS8zpx/t
         aa72M9iZxnVVRzTFwos/7oJetmNVcrBggh0M7kqPEaF/WFL3T5OH1qUgwgDj8AMKnJdV
         OgaR7wL41pJEOQE3kjX9RoEC//1G54vsHlAGqbshkOBbCbO46bQbSAA474HDHTOPNrE4
         Rybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4/ga+S9d9DdSuZNYuqbRY7GZtijW3kRnLNt4rJzSAdc=;
        b=YIYJgqMam7nLds59Z/yH0SLjSTfZT2cVoV+PruLig3X+LpzAqpsIAFJQR33ttieKnN
         tG8l6eJZy5JatNr5m/9onEuHbCJBUAJQDhyq1jefR4bHa+QIJqXSkxKl3fC5jtQknY5j
         6Id42iN94HAjqwHXnjk3HzigZgUKyTWnjyMWqBc4wdW1Bdq5VW8S+vE5GE5vPnLvYo/8
         Y2TrceOB4vE/3Orip1UyvucaSCj5EYAqc2oV+MVt0cNK3mp/dMFlcvSJvM96Bf5rY5oh
         NoZ5JjGm2Xct8qXM5EqWYdY9YcWXIr2B772fcykHIl0fCwm5febumXV/fgGSVo1YlvYg
         Zo0A==
X-Gm-Message-State: AKGB3mJy2/MWzdyobrXBo2EzLmyb4zyqVVbVgylA1T4FesKsrpBavT/+
        fxUwMxnbWEPK0KibgnpbqGDvhVmg
X-Google-Smtp-Source: ACJfBovFIsE99WzuHiw6eNT8WLberHhFYRQVZSeEVBIzEeiXKPkqsrdxkIpLOLtb9XcBFVsqzc6P/g==
X-Received: by 10.99.178.8 with SMTP id x8mr1729315pge.243.1513077866188;
        Tue, 12 Dec 2017 03:24:26 -0800 (PST)
Received: from jekeller-home.localdomain (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id 68sm29387216pfx.186.2017.12.12.03.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 03:24:25 -0800 (PST)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
Date:   Tue, 12 Dec 2017 03:24:22 -0800
Message-Id: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for git config and how it reads the user specific
configuration file is misleading. In some places it implies that
$XDG_CONFIG_HOME/git/config will always be read. In others, it implies
that only one of ~/.gitconfig and $XDG_CONFIG_HOME/git/config will be
read.

Improve the documentation explaining how the various configuration files
are read, and combined.

Instead of referencing each file individually, reference each type of
location git will check. When discussing the user configuration, explain
how we switch between one of three choices. Ensure to note that only one
of the three choices is used.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-config.txt | 46 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 14da5fc..4299fd6 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -104,13 +104,11 @@ OPTIONS
 	list them.  Returns error code 1 if no value is found.
 
 --global::
-	For writing options: write to global `~/.gitconfig` file
-	rather than the repository `.git/config`, write to
-	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
-	`~/.gitconfig` file doesn't.
+	For writing options: write to global user configuration file
+	rather than the repository `.git/config`.
 +
-For reading options: read only from global `~/.gitconfig` and from
-`$XDG_CONFIG_HOME/git/config` rather than from all available files.
+For reading options: read only from global user configuration file
+rather than from all available files.
 +
 See also <<FILES>>.
 
@@ -237,26 +235,30 @@ See also <<FILES>>.
 FILES
 -----
 
-If not set explicitly with `--file`, there are four files where
+If not set explicitly with `--file`, there are three locations where
 'git config' will search for configuration options:
 
-$(prefix)/etc/gitconfig::
-	System-wide configuration file.
-
-$XDG_CONFIG_HOME/git/config::
-	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
-	or empty, `$HOME/.config/git/config` will be used. Any single-valued
-	variable set in this file will be overwritten by whatever is in
-	`~/.gitconfig`.  It is a good idea not to create this file if
-	you sometimes use older versions of Git, as support for this
-	file was added fairly recently.
+System-wide configuration::
+	Located at `$(prefix)/etc/gitconfig`.
 
-~/.gitconfig::
-	User-specific configuration file. Also called "global"
-	configuration file.
+User-specific configuration::
+	One and only one of the following files will be read
++
+- `~/.gitconfig`
+- `$XDG_CONFIG_HOME/git/config`
+- `$HOME/.config/git/config`
++
+If `~/.gitconfig` exists, it will be used, and the other files will not be
+read. Otherwise, if `$XDG_CONFIG_HOME` is set, then `$XDG_CONFIG_HOME/git/config`
+will be used, otherwise `$HOME/.config/git/config` will be used.
++
+Note that git will only ever use one of these files as the global user
+configuration file at once. Additionally if you sometimes use an older version
+of git, it is best to only rely on `~/.gitconfig` as support for the others was
+added fairly recently.
 
-$GIT_DIR/config::
-	Repository specific configuration file.
+Repository-specific configuration::
+	Located at `$GIT_DIR/config`.
 
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
-- 
2.7.4

