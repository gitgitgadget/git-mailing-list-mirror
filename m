Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E9CCA47B
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiGNV2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiGNV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:28:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CED6D9F4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az2-20020a05600c600200b003a301c985fcso1705992wmb.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6EjxlpzqkEruqpB4jK0ApOUhySpRy99/daelbcmn7yU=;
        b=gsOyIN8SH+sjQITqxMdlTlv991SO58KioRRft3QDPyaK/dBCRrTnmQSNdshHaF/VrA
         qOrVQd2E30tcu55Qcg7Ne47loN5PzEPY7kfSgoFNFfN5ybaZFrjHOg0jBu7EMCPmY32d
         ICWUiIkCh8oM1qIXfjXi/ZtHtYbxpWo152MQ2Bqn8YdqKRlLkOTyspripqjmpJZDNi0y
         OwgMYRQfWSsEDfdJGflvjM2vwY3DdrFjJ8vLLCPhV+Yi5x1NGf0LQCZsFo3MGuV9TaK2
         afAo33Upwe5bdWpT5ZlXQcMJdwE4q38ZUR7aHmUEMSvB4NkJgxVRMpbq8HkpN0j0wE6m
         3yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6EjxlpzqkEruqpB4jK0ApOUhySpRy99/daelbcmn7yU=;
        b=jIpGScUkHIm6G53g8gKPez3i67aHWsWNSGqxTkp0E+WzBsMnv5o2k8mo/URhSMFEFR
         TVbjZ5jsXYm2UNeWHecbGTrVVqoNw/N5PqcWxG5kzUf7xOUwnwSsq5gYawMiH/Lqu4wP
         MBEJBp0yjfKY8FQwF4ItEB9lX/13W05q+HC8zW/WQs8aL9DEf8DHsEZn76IzFYOFwhO/
         Ug9bBGnZPdoUNLVGJDpu1RxxD9iKku1ZS8qL7Alkfmhn7QkbIidL0KccDC+Rlvtm0bfy
         ouZoFYvUfhtVDp8MP91ITWXsxVQbkSYKV3cQU7fPzf2gyl1yFXITLy9rKlqvQhTFnygb
         3S6w==
X-Gm-Message-State: AJIora/49fi1xJFY7hbfeM6EQlmS+pYrVi8S/KZrRBKKwU5lYElVJGTu
        ItRC9AVHOpFigb1s7xMSG7jZbTT3eCY=
X-Google-Smtp-Source: AGRyM1vz/y+g5ZrOQSJ0FA+69a8OkYuxQHDUVk/yjwi8yrMgmJeWK6rhm7TIt1MXQdmojWs9YsV8jg==
X-Received: by 2002:a1c:7c16:0:b0:3a0:4c5f:ce13 with SMTP id x22-20020a1c7c16000000b003a04c5fce13mr11004191wmc.73.1657834085487;
        Thu, 14 Jul 2022 14:28:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0021d746d4820sm2233873wrs.37.2022.07.14.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:28:04 -0700 (PDT)
Message-Id: <6147751c9c13cba5afbf72e1107fdfeef91edcaa.1657834081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 21:27:57 +0000
Subject: [PATCH v8 1/5] Documentation/git-config.txt: add SCOPES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
what those values mean.

Add a SCOPES section to Documentation/git-config.txt that describes the
configuration scopes, their corresponding CLI options, and mentions that
some configuration options are only respected in certain scopes. Then,
use the word "scope" to simplify the FILES section and change some
confusing wording.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-config.txt | 82 ++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9376e39aef2..53c7c65f9ed 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -297,23 +297,20 @@ The default is to use a pager.
 FILES
 -----
 
-If not set explicitly with `--file`, there are four files where
-'git config' will search for configuration options:
+By default, 'git config' will read configuration options from multiple
+files:
 
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
 
 $XDG_CONFIG_HOME/git/config::
-	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
-	or empty, `$HOME/.config/git/config` will be used. Any single-valued
-	variable set in this file will be overwritten by whatever is in
-	`~/.gitconfig`.  It is a good idea not to create this file if
-	you sometimes use older versions of Git, as support for this
-	file was added fairly recently.
-
 ~/.gitconfig::
-	User-specific configuration file. Also called "global"
-	configuration file.
+	User-specific configuration files. When the XDG_CONFIG_HOME environment
+	variable is not set or empty, $HOME/.config/ is used as
+	$XDG_CONFIG_HOME.
++
+These are also called "global" configuration files. If both files exist, both
+files are read in the order given above.
 
 $GIT_DIR/config::
 	Repository specific configuration file.
@@ -322,28 +319,67 @@ $GIT_DIR/config.worktree::
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
+global or the system-wide configuration files are missing or unreadable they
+will be ignored. If the repository configuration file is missing or unreadable,
+'git config' will exit with a non-zero error code. An error message is produced
+if the file is unreadable, but not if it is missing.
 
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
+	GIT_CONFIG_{COUNT,KEY,VALUE} environment variables (see <<ENVIRONMENT>>
+	below)
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
 
+[[ENVIRONMENT]]
 ENVIRONMENT
 -----------
 
-- 
gitgitgadget

