Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F8FC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiGGXCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGXCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EFE61D56
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:01:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l68so11475767wml.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Qz+S/OrOXvnbR+HijT7+g7W+Gpg9orhEeI8xyfH0Dg=;
        b=YgJYlh/e87qwIUpm/e3JujX516XP1ynSOaWYKEPXZJvTFZ8ub2ANSnfy1lnVW54CG9
         PAOGeNNpiPc98hd4inkxDL62Hrv+I1d6BZTGxuEw/yT9kYL8CVa2hj1x6rQleLd5bMLH
         QCXE/DIcDH+2rIcUk5d4ML8TF0eib78i3NmRYKu/axzMWKKGVxnF64zIC1xtVyslLIjv
         eWsWddhUr/Ae3Vvl6zffdaQZ87fqHcWw35E5fDWlppaDt2brf9HWe4IW3ldgiNoWU2bX
         ucZgRvoXiYI/MlbX66WyCfmqTr3blnfaVkI98eGs4uHAVQbXtSn6EQgIgTLUYQAey0Sa
         C/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Qz+S/OrOXvnbR+HijT7+g7W+Gpg9orhEeI8xyfH0Dg=;
        b=4zIG26Ax//2/IJTy2pf97srpyq+2UrzPndXvAudWwuESyey//Hb8c7EuB0ItsMrFP2
         41lNIWji7iJGNr/IrgrIBT/MgRjCU26RlkFYy34je8yLw4PoxE6GnAVjcX26AxSX8gTY
         5L+jhvSIyxD+IWO2NEtRs1nfz0CgZCF2V952gP1RyS18tRLc20YznqtgIMKoUQRsm8QL
         4K1RxemQkjzizqI5UKXIz2I46l83OHIZEMyocodMffz46lOnuGUD1NljZBgx/uTgEY7t
         inzAs6bd4KVtkBD/0YvbLdvoeKDSsPRf/512bUyhJ/5JS03q/uaHslFdcHJGJZeHj05F
         ELNg==
X-Gm-Message-State: AJIora8v/KI1dvuoIk57IiCjOOf4wNGuP5s3vhmeoICs2CqduEZjF3Z7
        Ef7Bo1mvlEwAPYX0nDfTAU+dNcPwlzU=
X-Google-Smtp-Source: AGRyM1tglgw2uiRH9pV8iPngrU5i6MvDj1QMQQN+8EAcmQSSwyyY2cf3xCgM25L54LFTbcuarcGTXA==
X-Received: by 2002:a05:600c:1ca9:b0:3a0:43a9:5e1a with SMTP id k41-20020a05600c1ca900b003a043a95e1amr189227wms.155.1657234917778;
        Thu, 07 Jul 2022 16:01:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d5090000000b0021d819c8f6dsm3882006wrt.39.2022.07.07.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:56 -0700 (PDT)
Message-Id: <5c58db3bb2189f3b4193a682aa3b43f3bfa95796.1657234914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:50 +0000
Subject: [PATCH v7 1/5] Documentation/git-config.txt: add SCOPES section
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
 Documentation/git-config.txt | 65 ++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9376e39aef2..c4ce61a0493 100644
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
@@ -322,27 +322,64 @@ $GIT_DIR/config.worktree::
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
+'git config' will exit with a non-zero error code. Note that neither case
+produces an error message.
 
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
+You can limit which configuration sources are read from or written to by
+specifying the path of a file with the `--file` option, or by specifying a
+configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
+For more, see <<OPTIONS>> above.
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
+option: `--system`, `--global`, `--local`, `--worktree`.
+
+When reading options, specifying a scope will only read options from the
+files within that scope. When writing options, specifying a scope will write
+to the files within that scope (instead of the repository specific
+configuration file). See <<OPTIONS>> above for a complete description.
 
+Most configuration options are respected regardless of the scope it is
+defined in, but some options are only respected in certain scopes. See the
+respective option's documentation for the full details.
 
 ENVIRONMENT
 -----------
-- 
gitgitgadget

