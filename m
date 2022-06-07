Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC1CCA482
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386986AbiFHAaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1844531AbiFHAMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 20:12:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46F3A0E72
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:57:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k19so25713614wrd.8
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jFIjuXvt59Z59x6iggNsmEt+FWw1OJYXARMKpw2SI6I=;
        b=URDllm3xhwzhJRG5Vwk6U2oORhUvEARzAgdda13CALXhJjM8/gJH0LD2vjYkJz/FAx
         v5KkldWqqqQI/VxgoMg2Sz2SH/RzNGxLJTs0P2nVFLG2XWS5q12gNXVEQBTv1vIKCd1M
         mCRMGOVqmi8/AHcuDtdQYMedASsf+7GciCOXd3EtOgF/HJfxQ/2+lyqsVUcV/ss45tFH
         kfoPnxoBQm7O82+KBZED2Kb5OYhaS3eUXk+eY1nq800ytYCng99ZEpaZa7b0nHRGp0d/
         ALGGBsQRefFWgYTEwxvjsACjZbKEWTFZSSWeVTeq++XX0hfe0qQyARNHoiZg7KADkb+B
         bE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jFIjuXvt59Z59x6iggNsmEt+FWw1OJYXARMKpw2SI6I=;
        b=CaanR/eg6hxLd0Q81yXvdn4VqK7Bf2KTuqRop+OJgyHFczGWgdm7AuzxX74iVgc1LP
         uKSnJsYea2kgdf0XQMF4EpK9VFWPaaFptb1vgd0N+d78U+CvTBLHGaIM6E4N3qwT1grW
         ahQ2yTpwyrsDP9ytw5fVya4ET/8cm6nC3BuGKTleiMXcqufITiD31Y9k1ZbEI4sk6cO7
         5qgsVF5UWmwXIn9fYt1euP3BhfIYT5jZnZKVXwOabpVulN7zOaF2vR/U1cHLvmN9yWzG
         Xd9Al3yeaPDGsBklgSQefSG2XBhUJmmqQ2Tnkd2s9ds/da1hZaRv4bndR4Hir4xdasbA
         YApA==
X-Gm-Message-State: AOAM5314lMA7LobfytAdYsclWjbr4Cn5ir5zEpkiVBdPg7RrnxNV2uXg
        ncsvSXI+xjjCSpRcW9NqHTD2C+ne3Ljngcq5
X-Google-Smtp-Source: ABdhPJyr+vwHzJHUxtOuO7v16hzsqCfGe8ofjfvaMeDVPEsRK1iJ3TyfUM33YeKqlz07LnAEwS3HRw==
X-Received: by 2002:adf:eccd:0:b0:212:fbbc:79de with SMTP id s13-20020adfeccd000000b00212fbbc79demr28305826wro.520.1654635436784;
        Tue, 07 Jun 2022 13:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a1ca101000000b0039c4ff5e0a7sm6856447wme.38.2022.06.07.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:57:16 -0700 (PDT)
Message-Id: <a5a1dcb03e18f3b9f3fd77ef94c17a05763a5f13.1654635432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:57:09 +0000
Subject: [PATCH v4 2/5] Documentation: define protected configuration
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
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

For security reasons, there are config variables that are only trusted
when they are specified in extra-trustworthy configuration scopes, which
are sometimes referred to on-list as 'protected configuration' [1]. A
future commit will introduce another such variable, so let's define our
terms so that we can have consistent documentation and implementation.

In our documentation, define 'protected config' as the system, global
and command config scopes. As a shorthand, I will refer to variables
that are only respected in protected config as 'protected config only',
but this term is not used in the documentation.

This definition of protected configuration is based on whether or not
Git can reasonably protect the user by ignoring the configuration scope:

- System, global and command line config are considered protected
  because an attacker who has control over any of those can do plenty of
  harm without Git, so we gain very little by ignoring those scopes.
- On the other hand, local (and similarly, worktree) config are not
  considered protected because it is relatively easy for an attacker to
  control local config, e.g.:
  - On some shared user environments, a non-admin attacker can create a
    repository high up the directory hierarchy (e.g. C:\.git on Windows),
    and a user may accidentally use it when their PS1 automatically
    invokes "git" commands.

    `safe.directory` prevents attacks of this form by making sure that
    the user intended to use the shared repository. It obviously
    shouldn't be read from the repository, because that would end up
    trusting the repository that Git was supposed to reject.
  - "git upload-pack" is expected to run in repositories that may not be
    controlled by the user. We cannot ignore all config in that
    repository (because "git upload-pack" would fail), but we can limit
    the risks by ignoring `uploadpack.packObjectsHook`.

Only `uploadpack.packObjectsHook` is 'protected config only'. The
following variables are intentionally excluded:

- `safe.directory` should be 'protected config only', but it does not
  technically fit the definition because it is not respected in the
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
index 5e4c95f2423..2b4334faec9 100644
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
 
+Protected config
+~~~~~~~~~~~~~~~~
+
+Protected config refers to the 'system', 'global', and 'command' scopes. Git
+considers these scopes to be especially trustworthy because they are likely
+to be controlled by the user or a trusted administrator. An attacker who
+controls these scopes can do substantial harm without using Git, so it is
+assumed that the user's environment protects these scopes against attackers.
+
+For security reasons, certain options are only respected when they are
+specified in protected config, and ignored otherwise.
+
 ENVIRONMENT
 -----------
 
-- 
gitgitgadget

