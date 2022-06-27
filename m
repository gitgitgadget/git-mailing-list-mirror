Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74991CCA473
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiF0Sik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbiF0SiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F53CD7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so9118866wra.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eg9oT2ttxFEF1wkAt+PI0iAiQ436tiumYPH3Aazib7E=;
        b=D4sW+MuYgf8fBMUS2ECsMpV1HGTAYBjilySFW6tWdR4TpNWMwrNCgJ4iuFKtR3L2ph
         OM+CACYHmQrv7bLk3yLdVGeUbjqMnMWQevjlsIuffszBb+9BMvqE03ZKPIrHci211dmz
         7mC5QIodWdafs60t9SEcnzHd35D8oSxmVT7p5W+uNAlOg7kzM8CBygxwqWtyrUTVwc68
         QRVHdh4hJzQnwmGTSBRpVPHICs7U09sxBhMeYwuifghbLl0VNfhI4/I5kzYWCiCtVhNH
         Tqiwz+3GqzgQJnp2/W8lb3FW7pOgo8Fv0mEq62JUuTeJHeHf+GTbNfiTtqbPQvHNamDP
         cElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eg9oT2ttxFEF1wkAt+PI0iAiQ436tiumYPH3Aazib7E=;
        b=p1R+b3Z/SYfBWD6aA0mekq+aT33qi8yiKK7OGZ0ndIvacHGoEKl4E0HXVBkDcOaFi2
         LAno597xCkDc/Trt9f7BX4YxKtapyp1eb0N15OarOLMkiF/LfAYpJMw2JQqSS6YtngZU
         seZ0Qyk2BpN1GdUdU+wWo+8UgR0EEH4JxDWBA5KfSKsHKfJhE1HL3L8VIQjgd3y5luvl
         eCj+rbah3R8d/eDjQf5XnRtrNJWqrBOBN0RRhjm1I7OWVi7AynlhI8uKMUMgwpzsk4ZM
         23T1ASeDPpc5c9jMwd/EEc8Wu+G21fIx7ZsIFA4SqTf4BbZCG69XEDlUVbD8yVrmICNw
         EiFw==
X-Gm-Message-State: AJIora/FBH2T6MG8T2irOzXTYcY7qHgXyMrep+36oDklW6FTx7mchmJJ
        5k6Y2UNCbMwQVHFaVGaQdw4KN017/ubvxg==
X-Google-Smtp-Source: AGRyM1tH3hbzActPj7H5RH1wOAPQo9HlX5/TOHkvxvumU+jnk3U52QVL0qB3WicOnrcilVS1yUpB7Q==
X-Received: by 2002:a5d:6d45:0:b0:21a:2f43:cb76 with SMTP id k5-20020a5d6d45000000b0021a2f43cb76mr13842982wri.254.1656354996790;
        Mon, 27 Jun 2022 11:36:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0021b829d111csm11530943wrq.112.2022.06.27.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:36:35 -0700 (PDT)
Message-Id: <ee9619f6ec0608f399fc924cfe9254df5e7bc431.1656354994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
        <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:36:30 +0000
Subject: [PATCH v5 1/5] Documentation/git-config.txt: add SCOPES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In a subsequent commit, we will introduce "protected configuration",
which is easiest to describe in terms of configuration scopes (i.e. it's
the union of the 'system', 'global', and 'command' scopes). This
description is fine for ML discussions, but it's inadequate for end
users because we don't provide a good description of "configuration
scopes" in the public docs.

145d59f482 (config: add '--show-scope' to print the scope of a config
value, 2020-02-10) introduced the word "scope" to our public docs, but
that only enumerates the scopes and assumes the user can figure out
those values mean.

Add a SCOPES section to Documentation/git-config.txt that describes the
configuration scopes, their corresponding CLI options, and mentions that
some configuration options are only respected in certain scopes. Then,
use the word "scope" to simplify the FILES section and change some
confusing wording.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-config.txt | 64 ++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9376e39aef2..f93d437b898 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -297,8 +297,8 @@ The default is to use a pager.
 FILES
 -----
 
-If not set explicitly with `--file`, there are four files where
-'git config' will search for configuration options:
+By default, 'git config' will read configuration options from multiple
+files:
 
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
@@ -322,27 +322,63 @@ $GIT_DIR/config.worktree::
 	This is optional and is only searched when
 	`extensions.worktreeConfig` is present in $GIT_DIR/config.
 
-If no further options are given, all reading options will read all of these
-files that are available. If the global or the system-wide configuration
-file are not available they will be ignored. If the repository configuration
-file is not available or readable, 'git config' will exit with a non-zero
-error code. However, in neither case will an error message be issued.
+You may also provide additional configuration parameters when running any
+git command by using the `-c` option. See linkgit:git[1] for details.
+
+Options will be read from all of these files that are available. If the
+global or the system-wide configuration file are not available they will be
+ignored. If the repository configuration file is not available or readable,
+'git config' will exit with a non-zero error code. However, in neither case
+will an error message be issued.
 
 The files are read in the order given above, with last value found taking
 precedence over values read earlier.  When multiple values are taken then all
 values of a key from all files will be used.
 
-You may override individual configuration parameters when running any git
-command by using the `-c` option. See linkgit:git[1] for details.
-
-All writing options will per default write to the repository specific
+By default, options are only written to the repository specific
 configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
-You can override these rules using the `--global`, `--system`,
-`--local`, `--worktree`, and `--file` command-line options; see
-<<OPTIONS>> above.
+You can change the way options are read/written by specifying the path to a
+file (`--file`), or by specifying a configuration scope (`--system`,
+`--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
+
+SCOPES
+------
+
+Each configuration source falls within a configuration scope. The scopes
+are:
+
+system::
+	$(prefix)/etc/gitconfig
+
+global::
+	$XDG_CONFIG_HOME/git/config
++
+~/.gitconfig
+
+local::
+	$GIT_DIR/config
+
+worktree::
+	$GIT_DIR/config.worktree
+
+command::
+	environment variables
++
+the `-c` option
+
+With the exception of 'command', each scope corresponds to a command line
+option - `--system`, `--global`, `--local`, `--worktree`.
+
+When reading options, specifying a scope will only read options from the
+files within that scope. When writing options, specifying a scope will write
+to the files within that scope (instead of the repository specific
+configuration file). See <<OPTIONS>> above for a complete description.
 
+Most configuration options are respected regardless of the scope it is
+defined in, but some options are only respected in certain scopes. See the
+option's documentation for the full details.
 
 ENVIRONMENT
 -----------
-- 
gitgitgadget

