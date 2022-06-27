Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E092C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiF0Sia (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiF0SiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C08CD8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s1so14263622wra.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gTcS6gAx+mAwu67s0Vsrg+OViPFhCGZSE7su0s70T3I=;
        b=TI2tEdfvjmjGZgtGnbX7CZ4kgySUmV75akglW05ipTLlBdDjNgiXhegE6jnxUqa9nC
         jq1faVjB/HYgljSvZKoVJ6QTPwulZM5VLWBEd+Ar69zZ8vaQuEYvH9rOPvAoancJCHTS
         q/BsIB7M+nvD1aF7v7caDrGftmjtLfRXFllcE1zE7t4jDBr90O5hbFxbCaUpSFYZqBoU
         qVpZynWzQuUh3w9rqZhYn3oaoh+qDrdo+AmP69IanSdKfLFW/i36nMDqil9AMmV/QllI
         uyDGyc55EgFLQHwbHEEeB7cTOkejoxDtw7yCdSH4Z+Ugjne7F+J44q2+vSy33RUKg7uu
         zvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gTcS6gAx+mAwu67s0Vsrg+OViPFhCGZSE7su0s70T3I=;
        b=ImHhPpkYFld/YjROduu+rPB/AP9e3QT8W8eUuz8OIO5Hs5mQty9nCCxsXMb4zt/mGT
         kqjglmCMDEl667biEmVSAVN6BmP4SHztKF+d9jeB1uIvwyRBBRR/u5Xczhnm0/B77Y34
         BCzRak0DUXltodifl9P7CnUWtxJA8DOVbZWEqSdipg5iowND2yJYrcoVHVS3mfDNyXdP
         vOiHszY2o41eBofsHUrSEHS/7KQu3gAL2qzNSPv6ibDJHnpezFTLLNItIvQZgqa/Og/7
         Qt+LSJ/GfLeK/YQZC/7R7es7tbD/tjTqaJEDCTxMXyLfF7Nv3GFrbFxobEftMa2sm7qW
         Pf6A==
X-Gm-Message-State: AJIora9u3YXu9ojc5Yah1sN4WOyXfj5rlFXbycAW8AU6hVmGZ42fcSTv
        ewuw0yhS4OGsAKlpc04FcY3964QypQZz2g==
X-Google-Smtp-Source: AGRyM1uYxxwE9kiNVdzuhtntdPJFH8ygPvV5uLiwE3zfogwrAQnfsq9JEuUxoWu4V2GbXeVhAn5aFw==
X-Received: by 2002:a5d:584e:0:b0:21c:ea0c:3746 with SMTP id i14-20020a5d584e000000b0021cea0c3746mr5474337wrf.199.1656354998016;
        Mon, 27 Jun 2022 11:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b0020c5253d8fcsm13335303wrx.72.2022.06.27.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:36:37 -0700 (PDT)
Message-Id: <43627c05c0b997ea407c865b04994cba630297d6.1656354994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
        <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:36:31 +0000
Subject: [PATCH v5 2/5] Documentation: define protected configuration
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

For security reasons, there are config variables that are only trusted
when they are specified in certain configuration scopes, which are
sometimes referred to on-list as 'protected configuration' [1]. A future
commit will introduce another such variable, so let's define our terms
so that we can have consistent documentation and implementation.

In our documentation, define 'protected configuration' as the system,
global and command config scopes. As a shorthand, I will refer to
variables that are only respected in protected config as 'protected
configuration only', but this term is not used in the documentation.

This definition of protected config is based on whether or not Git can
reasonably protect the user by ignoring the configuration scope:

- System, global and command line config are considered protected
  because an attacker who has control over any of those can do plenty of
  harm without Git, so we gain very little by ignoring those scopes.
- On the other hand, local (and similarly, worktree) config are not
  considered protected because it is relatively easy for an attacker to
  control local config, e.g.:
  - On some shared user environments, a non-admin attacker can create a
    repository high up the directory hierarchy (e.g. C:\.git on
    Windows), and a user may accidentally use it when their PS1
    automatically invokes "git" commands.

    `safe.directory` prevents attacks of this form by making sure that
    the user intended to use the shared repository. It obviously
    shouldn't be read from the repository, because that would end up
    trusting the repository that Git was supposed to reject.
  - "git upload-pack" is expected to run in repositories that may not be
    controlled by the user. We cannot ignore all config in that
    repository (because "git upload-pack" would fail), but we can limit
    the risks by ignoring `uploadpack.packObjectsHook`.

Only `uploadpack.packObjectsHook` is 'protected configuration only'. The
following variables are intentionally excluded:

- `safe.directory` should be 'protected configuration only', but it does
  not technically fit the definition because it is not respected in the
  "command" scope. A future commit will fix this.

- `trace2.*` happens to read the same scopes as `safe.directory` because
  they share an implementation. However, this is not for security
  reasons; it is because we want to start tracing so early that
  repository-level config and "-c" are not available [2].

  This requirement is unique to `trace2.*`, so it does not makes sense
  for protected configuration to be subject to the same constraints.

[1] For example,
https://lore.kernel.org/git/6af83767-576b-75c4-c778-0284344a8fe7@github.com/
[2] https://lore.kernel.org/git/a0c89d0d-669e-bf56-25d2-cbb09b012e70@jeffhostetler.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/uploadpack.txt |  6 +++---
 Documentation/git-config.txt        | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 32fad5bbe81..029abbefdff 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -49,9 +49,9 @@ uploadpack.packObjectsHook::
 	`pack-objects` to the hook, and expects a completed packfile on
 	stdout.
 +
-Note that this configuration variable is ignored if it is seen in the
-repository-level config (this is a safety measure against fetching from
-untrusted repositories).
+Note that this configuration variable is only respected when it is specified
+in protected config (see <<SCOPES>>). This is a safety measure against
+fetching from untrusted repositories.
 
 uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f93d437b898..f1810952891 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -343,6 +343,7 @@ You can change the way options are read/written by specifying the path to a
 file (`--file`), or by specifying a configuration scope (`--system`,
 `--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
 
+[[SCOPES]]
 SCOPES
 ------
 
@@ -380,6 +381,18 @@ Most configuration options are respected regardless of the scope it is
 defined in, but some options are only respected in certain scopes. See the
 option's documentation for the full details.
 
+Protected configuration
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Protected configuration refers to the 'system', 'global', and 'command' scopes.
+For security reasons, certain options are only respected when they are
+specified in protected configuration, and ignored otherwise.
+
+Git treats these scopes as if they are controlled by the user or a trusted
+administrator. This is because an attacker who controls these scopes can do
+substantial harm without using Git, so it is assumed that the user's environment
+protects these scopes against attackers.
+
 ENVIRONMENT
 -----------
 
-- 
gitgitgadget

