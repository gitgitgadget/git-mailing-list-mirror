Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49255C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiGNV2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiGNV2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:28:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF246D9F4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so4215096wrv.10
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KmQ5rKdKW/vCdCzeR5S6o2R6WXND2dUPlfpoTf8jznQ=;
        b=S+Y+uWD5oHlHTmInz42FMJt+braYGmgRkAOCIK3gfifhgy1FKfHQVt59QlSx+qHJ6u
         yvbnhxLlqyhwJcuqjnteWZ9zTgPzAPAgVRlvAOAnH4BeWzq9th/kkyhq7ZOvfvPlcMuC
         p4NixrfEgCP7Hud7uNwY9zoNwFE0BeeZZY4RV1UnM5YSgFT7jE2IC1mBZWS0lbb/lgcC
         fpqp32jE0q9Vy1j3hbov+E47+ys9oEjvTeUOx2d9bX1/kvTIxw3y/oCYg469VjkvIpEF
         pZs+gC5bizehPC+PV6EV5LXHHYZDBhC13gmrKVYPbo2bqQH14m3Gb9KCSIyEzBCXhtsc
         GVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KmQ5rKdKW/vCdCzeR5S6o2R6WXND2dUPlfpoTf8jznQ=;
        b=O9fAaHjD5oAKV8uMjmCDRAhZHo3LLrs7gjlu566g6BgRURo6+K0P1wNYOI4v5p26Um
         Ar8K5WbUOc0AwCqoa2K1kivyNrqIgSKBpI8Th/c63UHPQgYS2l1lOfXaVTHZ3p7hknuF
         nT895qZvjlLEG8T/D/9C+ZVIn/M0PWBzz2N2dcedosvbnHA+gzkuwyd4+Ocgh9C5UGWk
         WmUJX2lpXPm/yfUsdJneYrPTCHcS4eGZhhrhksSJ5+sZtBHc4motKhNfhBzHc3qjMMJ/
         N0u5axJ9MSXv3SopCGFxo6IU+eAqDqahyprgIk2wvJuZN+CtR04m/X+yO5kgcaD44nKc
         Xdzw==
X-Gm-Message-State: AJIora9N8Ws08dM3dlsg1sBgAt7F+k+BlUku8I/tCsrpWHsgRZhAKnMm
        eiCmKmKIAqjHKVtKNtdjQuDmVet4z9I=
X-Google-Smtp-Source: AGRyM1v8gJeJ5rOyL2mlMlsmOSZf64cEV2U35Sx92iJmNmhKQyWaQ3gfcENSOUZvl9IwYiFr6fSmJg==
X-Received: by 2002:a5d:4c49:0:b0:21d:6df5:beb7 with SMTP id n9-20020a5d4c49000000b0021d6df5beb7mr9977368wrt.286.1657834087398;
        Thu, 14 Jul 2022 14:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003a2cfb9f5basm7959203wmq.16.2022.07.14.14.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:28:06 -0700 (PDT)
Message-Id: <df8a1a78d533924b88f9513df3f328738b1589bc.1657834081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 21:27:58 +0000
Subject: [PATCH v8 2/5] Documentation: define protected configuration
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

For security reasons, there are config variables that are only trusted
when they are specified in certain configuration scopes, which are
sometimes referred to on-list as 'protected configuration' [1]. A future
commit will introduce another such variable, so let's define our terms
so that we can have consistent documentation and implementation.

In our documentation, define 'protected configuration' as the system,
global and command config scopes. As a shorthand, I will refer to
variables that are only respected in protected configuration as
'protected configuration only', but this term is not used in the
documentation.

This definition of protected configuration is based on whether or not
Git can reasonably protect the user by ignoring the configuration scope:

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
index 32fad5bbe81..16264d82a72 100644
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
+in protected configuration (see <<SCOPES>>). This is a safety measure
+against fetching from untrusted repositories.
 
 uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 53c7c65f9ed..7a2bcb2f6cb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -341,6 +341,7 @@ specifying the path of a file with the `--file` option, or by specifying a
 configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
 For more, see <<OPTIONS>> above.
 
+[[SCOPES]]
 SCOPES
 ------
 
@@ -379,6 +380,18 @@ Most configuration options are respected regardless of the scope it is
 defined in, but some options are only respected in certain scopes. See the
 respective option's documentation for the full details.
 
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
 [[ENVIRONMENT]]
 ENVIRONMENT
 -----------
-- 
gitgitgadget

