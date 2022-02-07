Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03427C433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiBGVdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiBGVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C6C0612A4
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so240972wml.0
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KICq9YcJdV4ejpfTBK+yosGiFs85PyzWOYs09u9Tdqg=;
        b=EmVa1tMtiBMjww2peoMjJPodqLdoOzTDcx3rKNqUFEO8SNbr1t5/5G6i87yUV1YYdk
         QGRTgXZR1eX+Vs40qJy7WGh/MVrTCVSXX5eHnS7kMHyF6zW5+RatF8WHsY5LF4q+cLFc
         oKPzxfBNd19njLtXDPggtBbaI47BnaSQ4QD8QRxOhM4N4XwOvwMYZwaVQAB/uV3XjwuY
         EmWIUlhIZ6pEqz6137oJJl5wv2leRptz6tkhtIoNwenIcn2UR9Oi3RbbDyNz+B6vBqH7
         RvXC20+EFGaJxjXZvhrTnJAeQXFUWvQX9d89874NCIZD1LPt2XvDaBv1THPS3k2Wk8+P
         py2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KICq9YcJdV4ejpfTBK+yosGiFs85PyzWOYs09u9Tdqg=;
        b=gfvmg7kluQq4A3jZn8a3seS3kIlu6nXursTOiPfHSOYlmro79Y7fKcpd7ElojE7If2
         bM++CRSkLkTEsmg6frKz4lP8esPEAKSbh5i7oI8sBwnzNrYZm4niZogAjH1zmOUSA+oc
         +53O0ZS+gyJkm/dIF8BfAzp05TkillHWGNcFqZUVt29QkRTdR1gGMpopiM7MNx/Lul57
         mLffZ4UkGVsegAOnjpmjV06WqgIgUpL2HJ7Uyg2eD21hAtbbsIVa+nGm2qgmwLDSbJ8L
         YjCxFR4kvJHPWxdTxZIVjSfy1DEy61232PhkKu5Be8NPlQlTShM+dUFxFV+1vKPo+MsR
         o4LQ==
X-Gm-Message-State: AOAM531KBxVKr58eSUkaUk1lPxtxQeIRlGjXqFVpmIDtyxOjXeq/FY0F
        6j7qFsQJXP7hDaYeJzBT1UtaPEFikV4=
X-Google-Smtp-Source: ABdhPJzPxoKcJJ+hLYrY74zqJcScxVqNsdih0vpJOwNcpJMhZoSkyr/SKaxPj4urRhDj5mqTWAXiHA==
X-Received: by 2002:a1c:a552:: with SMTP id o79mr668920wme.40.1644269586346;
        Mon, 07 Feb 2022 13:33:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm9325850wrp.51.2022.02.07.13.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:05 -0800 (PST)
Message-Id: <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:32:58 +0000
Subject: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig details
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com,
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
index 4e23d73cdca..bccaec7a963 100644
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
+	`$GIT_DIR` are the same for the main working tree, while other
+	working trees have `$GIT_DIR` equal to
+	`$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the
+	`config.worktree` file will override settings from any other
+	config files.
++
+When enabling `extensions.worktreeConfig`, you must be careful to move
+certain values from the common config file to the main working tree's
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
index 2285effb363..bdcfd94b642 100644
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
+	is equal to `$GIT_COMMON_DIR` for the main working tree, but is of
+	the form `$GIT_DIR/worktrees/<id>/` for other working trees. See
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

