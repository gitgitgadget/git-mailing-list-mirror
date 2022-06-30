Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiF3SOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiF3SOE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84603FD92
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso81006wmq.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eg9oT2ttxFEF1wkAt+PI0iAiQ436tiumYPH3Aazib7E=;
        b=l7jP+BJpFRAWcBK827RUoQVKftK1l6AqxxkSHfrQueAUMnJrSSNgVwzqUoryaWZ3zS
         b33bUUQ/mI6idnuYt8ybht6San/guqzos+tlw1sJ8lFJaDbcjjmMJ9RJCLm+2+AWIuzs
         A76gWMbm7a0pJcZqLan1BUMswTKsPkC42Lw64AXhhtJyySr8s+Sykqb0quc1lbG2Rqa8
         b32bIFCUa1UbgWbEYHuVnHMfFhShHA5/ilB6s/ogD5rHLjuj72Wcz+3Inm4erIAPpn69
         pqO785tBb15WLXjV3pYF9xt/S8vbyMew2HXl6ccuorNID73pd5PHj4F5CoALiNbaJYjF
         1JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eg9oT2ttxFEF1wkAt+PI0iAiQ436tiumYPH3Aazib7E=;
        b=stFADWd+RpZoGpjqnQmQvSlBbtDUTwpMOXFqd5MYuWIEqkWMkJWFLfi+eveImdvr/V
         c8iPcx0HHzcseRN6Pab1RlhemNAdJoEh9uCvG7EVVEhBIlTuJ/+5vTSdzzrq3t2i32cn
         C0f+hJWGYytrRE8e0C0giwgOm/brzfdQ4HXyjsBA8k0/cFYxVQGPN7GWpbA5Ejp33fq+
         RQwhPX2KezNSZUIttEN84BI9jTSK0dPrkIqsZZZ5ai5g9uT4swT/k/EVQFX5uq2HXHZi
         yiN+YqvCh/lkEE1MfkC4t9t3CAWrqiLkJoJjyXqnzjUi3NLsKJqoDq1cOt2KFK8VC/H0
         HORA==
X-Gm-Message-State: AJIora/WnF7L6Zf/amIlUhOMDO1WAa1CVV8wfpDhPeHYQE12oi8i8xcm
        NY66iPj5EmAik6uAhj2TG8JfzUoipHk=
X-Google-Smtp-Source: AGRyM1tH9ERVNBXKk6ln80GT3X56X/wWLhXfTID9Em6Dm4a009k9MnM7sRUM6hno2wuwQSZuwUDLGA==
X-Received: by 2002:a05:600c:41d1:b0:3a0:301d:f75f with SMTP id t17-20020a05600c41d100b003a0301df75fmr13436322wmh.31.1656612842134;
        Thu, 30 Jun 2022 11:14:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600001c700b002167efdd549sm19804771wrx.38.2022.06.30.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:14:01 -0700 (PDT)
Message-Id: <ee9619f6ec0608f399fc924cfe9254df5e7bc431.1656612839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
        <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 18:13:55 +0000
Subject: [PATCH v6 1/5] Documentation/git-config.txt: add SCOPES section
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
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

