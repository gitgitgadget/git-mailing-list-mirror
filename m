Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CFFC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiGGXCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGGXCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C425861D56
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:02:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so28275681wrh.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=byqMmsgnHvuT3IFtXPJEwT40pUJAAW0lFE4L3PklnTs=;
        b=hgQ/sHh4byZBKcaI0h9NFwVh0ZmVXJAsD3J7FXEeiP0dAte3RQAokO62r7LoW+C/6t
         qAGl1OhDzaZHF4zMgiR14sfsj9LYJRgesTx/7PFZKYTteuob7kAs8FCkraDJnEpq6VWH
         EKrq4EZNEsM42dc++vlOo2iZgPRHKxRUFTghwC/7DP0llQ8xdix8j35Bt4EdsgTPPoih
         ZDRPL+Fu5i2S+BUQC+bwADnKDnbHwpDT1WBt1iX1E9t//pcC9HXTfl4ZrC9Mbpet1oOq
         E0mGoeinMlBMy8onT+2eOKJLdWBFafpks6V6LC09MVRqKpPnYkZMr6TvCIxqw0HEkFV4
         WjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=byqMmsgnHvuT3IFtXPJEwT40pUJAAW0lFE4L3PklnTs=;
        b=LOe47E5POz+bD6XDOPqgwOYOO02/WBA+rtSaWBO8eG+gMTOzHKf1GC6b/NuimO+iLP
         X7hk4T3zzgMtDbDzVJjRci6E3UYZAiUfZv4gufI1w0vZkC/aax8kDt9PgFPq+yLf4PDE
         FtqeXZxSl3g2ZG43CWukSRAtEwscYeBNPeskzD+ZB7nF4btUUTn+beteyhG4uuqAgECc
         a5B+7HxHO6OCjwDQC0A5LcTUMcTerCxoTLrZNKsjxxOA6+2oRUv3Rizv3cFWM8wTXrmv
         9hEXkbVYNTCKY+2r71XvCmt46lfv/cApnmu7CxjInCuHJ7F27jzox4c4yDmhfFs8iHH6
         tk5Q==
X-Gm-Message-State: AJIora84ieWXp9w+h9CsxVKtQsuHXSjbv6bgzE2bCL8gI6gt9sDSFkQH
        ifO4UYS/qsLQj0HEQZJT0Rf+OMsCSEE=
X-Google-Smtp-Source: AGRyM1v5M+/Rw+GAOCgky4kg4FWvM3VIyffAMdEuavXEst5Z1hf9s4gk6PHWoSHDNy4W49lnK0tJNw==
X-Received: by 2002:adf:fa4a:0:b0:21d:6904:f0b9 with SMTP id y10-20020adffa4a000000b0021d6904f0b9mr237373wrr.167.1657234919036;
        Thu, 07 Jul 2022 16:01:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4409000000b0021d86796294sm2665685wrq.59.2022.07.07.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:58 -0700 (PDT)
Message-Id: <58f25612aa385c3ac9f48f908ccc4d0d02d58b8c.1657234914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:51 +0000
Subject: [PATCH v7 2/5] Documentation: define protected configuration
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
index c4ce61a0493..2dc74f510f2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -344,6 +344,7 @@ specifying the path of a file with the `--file` option, or by specifying a
 configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
 For more, see <<OPTIONS>> above.
 
+[[SCOPES]]
 SCOPES
 ------
 
@@ -381,6 +382,18 @@ Most configuration options are respected regardless of the scope it is
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
 ENVIRONMENT
 -----------
 
-- 
gitgitgadget

