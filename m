Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17854C433FE
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349305AbiAaPBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiAaPBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:01:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E32C06173B
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so25883761wrb.13
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/ZljNoJgVbCVB9yLzYfuE976PzYqWu1MtluAAAmo3IQ=;
        b=bDmCnjChXkWaPoJxXZF3wK4YjKKwFjD4p81jzsu7ejDxyCAwL8aji7w7js4sg+BApp
         3gJvAG8BkmSa7aW8b1h9KRs0g7bKVNQ2i2yUciz5LlzJdPhelH1bucnZguRwqBMt2rd3
         8Bv0g3yg5VChJ+tyzuVwFyFDpN7VpO2n4H3kUXo+PtiLclre+zBKeU5a/HYaro7sjUZ2
         yNU0enhlzyR4jGcc2bgRq11nosiE1937NTFky6lwjhk/zNTWShGXbUhFQVjMkdE9iiZg
         6t29orPSgUoKzBsFjTooxrfUcDpMf50f6owzpBC1cIZv6VcfvKBwtUZroTJu/zeC2nnn
         CtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/ZljNoJgVbCVB9yLzYfuE976PzYqWu1MtluAAAmo3IQ=;
        b=2MFaKOc+0PSgg8aRD/9PL8CmzSo8Fi/Ms88l61y4Y6iN5upFvqEWWIJFlzp8cICb7X
         yAAgYN0AbKgjErx9D1E9XweufoFL/zUBK8GDNPOLHicgza3bJ6MXQLOjeKGj372haoM6
         ypdphYykzI8gv3ZYv6QG75ziSk3QiTVvNLQf4kBMKZgwgruZjAc7PBUwaDUN/+elpfOn
         mwQUx0u8vMeUFAtm2QhWLxj4Fv1QA/vxHCbjewALOrCEKX9ii5V5THPQkb+hfGjytGB3
         D7GqQnsLqZBZfgfYFX/89Rd/ZsPkgFUtn3LeyIpmUwV+EVW9KAnqnHaUw5meIxMvG3YX
         M2rQ==
X-Gm-Message-State: AOAM533qRJ+aNPgeW+5at+ZEAtVq+4z9fd2QYdlkf2iOVgyzmHmymlw3
        zBvbxXnKkd3Yxrbar6N4KHl2FSV3D4E=
X-Google-Smtp-Source: ABdhPJxdHRwjLue40/J1sqn1HMvsFJih1rnQRs3SV+Em3o2mdRfWAR0SILrCVNXqomoSxEO5t92s+w==
X-Received: by 2002:a5d:64e5:: with SMTP id g5mr9633508wri.345.1643641261529;
        Mon, 31 Jan 2022 07:01:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm9511903wmx.5.2022.01.31.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:01:01 -0800 (PST)
Message-Id: <1bd5f26271c9b1cff6c920bb91738ae903dccc61.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
        <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 15:00:55 +0000
Subject: [PATCH v5 1/5] Documentation: add extensions.worktreeConfig details
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The extensions.worktreeConfig extension was added in 58b284a (worktree:
add per-worktree config files, 2018-10-21) and was somewhat documented
in Documentation/git-config.txt. However, the extensions.worktreeConfig
value was not specified further in the list of possible config keys. The
location of the config.worktree file is not specified, and there are
some precautions that should be mentioned clearly, but are only
mentioned in git-worktree.txt.

Expand the documentation to help users discover the complexities of
extensions.worktreeConfig by adding details and cross links in these
locations (relative to Documentation/):

- config/extensions.txt
- git-config.txt
- git-worktree.txt

The updates focus on items such as

* $GIT_DIR/config.worktree takes precedence over $GIT_COMMON_DIR/config.

* The core.worktree and core.bare=true settings are incorrect to have in
  the common config file when extensions.worktreeConfig is enabled.

* The sparse-checkout settings core.sparseCheckout[Cone] are recommended
  to be set in the worktree config.

As documented in 11664196ac ("Revert "check_repository_format_gently():
refuse extensions for old repositories"", 2020-07-15), this extension
must be considered regardless of the repository format version for
historical reasons.

A future change will update references to extensions.worktreeConfig
within git-sparse-checkout.txt, but a behavior change is needed before
making those updates.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/extensions.txt | 31 +++++++++++++++++++++++++++++
 Documentation/git-config.txt        |  8 ++++++--
 Documentation/git-worktree.txt      | 11 +++++++---
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 4e23d73cdca..5999dcb2a1f 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -6,3 +6,34 @@ extensions.objectFormat::
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
+
+extensions.worktreeConfig::
+	If enabled, then worktrees will load config settings from the
+	`$GIT_DIR/config.worktree` file in addition to the
+	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
+	`$GIT_DIR` are the same for the main worktree, while other
+	worktrees have `$GIT_DIR` equal to
+	`$GIT_COMMON_DIR/worktrees/<worktree-name>/`. The settings in the
+	`config.worktree` file will override settings from any other
+	config files.
++
+When enabling `extensions.worktreeConfig`, you must be careful to move
+certain values from the common config file to the main worktree's
+`config.worktree` file, if present:
++
+* `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
+  `$GIT_COMMON_DIR/config.worktree`.
+* If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/config`
+  to `$GIT_COMMON_DIR/config.worktree`.
++
+It may also be beneficial to adjust the locations of `core.sparseCheckout`
+and `core.sparseCheckoutCone` depending on your desire for customizable
+sparse-checkout settings for each worktree. By default, the `git
+sparse-checkout` builtin enables `extensions.worktreeConfig`, assigns
+these config values on a per-worktree basis, and uses the
+`$GIT_DIR/info/sparse-checkout` file to specify the sparsity for each
+worktree independently. See linkgit:git-sparse-checkout[1] for more
+details.
++
+For historical reasons, `extensions.worktreeConfig` is respected
+regardless of the `core.repositoryFormatVersion` setting.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2285effb363..a48f7529fbc 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -141,9 +141,13 @@ from all available files.
 See also <<FILES>>.
 
 --worktree::
-	Similar to `--local` except that `.git/config.worktree` is
+	Similar to `--local` except that `$GIT_DIR/config.worktree` is
 	read from or written to if `extensions.worktreeConfig` is
-	present. If not it's the same as `--local`.
+	enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
+	is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
+	form `$GIT_DIR/worktrees/<worktree-name>/` for other worktrees. See
+	linkgit:git-worktree[1] to learn how to enable
+	`extensions.worktreeConfig`.
 
 -f <config-file>::
 --file <config-file>::
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9e862fbcf79..b8d53c48303 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -286,8 +286,8 @@ CONFIGURATION FILE
 ------------------
 By default, the repository `config` file is shared across all working
 trees. If the config variables `core.bare` or `core.worktree` are
-already present in the config file, they will be applied to the main
-working trees only.
+present in the common config file and `extensions.worktreeConfig` is
+disabled, then they will be applied to the main working tree only.
 
 In order to have configuration specific to working trees, you can turn
 on the `worktreeConfig` extension, e.g.:
@@ -307,11 +307,16 @@ them to the `config.worktree` of the main working tree. You may also
 take this opportunity to review and move other configuration that you
 do not want to share to all working trees:
 
- - `core.worktree` and `core.bare` should never be shared
+ - `core.worktree` should never be shared.
+
+ - `core.bare` should not be shared if the value is `core.bare=true`.
 
  - `core.sparseCheckout` is recommended per working tree, unless you
    are sure you always use sparse checkout for all working trees.
 
+See the documentation of `extensions.worktreeConfig` in
+linkgit:git-config[1] for more details.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
-- 
gitgitgadget

