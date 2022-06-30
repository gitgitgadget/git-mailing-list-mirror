Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1DC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiF3SOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbiF3SOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B59F3FDA5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so85336wmb.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gTcS6gAx+mAwu67s0Vsrg+OViPFhCGZSE7su0s70T3I=;
        b=dPT5fRhA7pUwTjatcT8tWk38p6jgEeqSPd6wvvhRJVaAH75nSdJ4NKYB/KRRFLS07h
         x6cD3ZnkEW3+krMkpBgenAR2YwYOQ9DLh9LZNYp+R1zRnx34WWAkotWtBBzFN2LMTLmP
         PA7ohm5eMbxc/JPdhMnTxRcOrIVwKtxKJNbiYhptxvgNK+xk+P2U9b17L7619/x+0t+r
         jpdjPBYhhtg7tXuXiJ0w6YkdrzxL8DRi+eg51kCmMKntYqxlBxUmhKqLfR4LRjARu+iA
         2n/oEWeAT4LVR8DN7HahRcZwdUIT9YkDZ308SmNwXugtENWXTPpLg13kf8paut9RXQrW
         MTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gTcS6gAx+mAwu67s0Vsrg+OViPFhCGZSE7su0s70T3I=;
        b=Yr3NR2ZnRS+4TUozzMY8Nfe0IBatN0+z9yBRhvqJyNtxFbc+cpnElBz6HB6szuCI9g
         kzTLK9kSxK9FHOAodnu7Kb8lGjYT8vtTzisGeLreGDnrpgiTYtaFHO2bihQzCcV6DXDh
         6F8ti4BDJPbbEhlTUhXRMV+coyHbuTyKmz53ckPY3nuHb52OP9ru14+VURT764JJwKmm
         eIWvQIl3FFwi0juJ0ccUu+CUQLtiWekopclUhyy5RhzZ4nfebZURNtnnwAoYMSSi4HZH
         bH/5PqzCgl4mWEz+j3S6uzWL1MCmqvFHdsvPWjCfspp5rM2nDuPaLiWjrJoSLHHpK9bY
         eDTQ==
X-Gm-Message-State: AJIora9oY8vVwPW0uY9RT4TjmgeJ99TwbFzscVTpWSaDihaN66+BWXry
        IoCjgUIQZ7y4n3Ixoe+dKBshLd+2JmY=
X-Google-Smtp-Source: AGRyM1vbtK5BVGVqa+o9ftYnZocg8gH/ZJFyHZZZ/SmiV+ulvC3bSApvSWdFJEAjKgKirKococHvdA==
X-Received: by 2002:a05:600c:154a:b0:3a1:7002:3486 with SMTP id f10-20020a05600c154a00b003a170023486mr9504463wmg.104.1656612843508;
        Thu, 30 Jun 2022 11:14:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003a02b9c47e4sm4285990wmq.27.2022.06.30.11.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:14:02 -0700 (PDT)
Message-Id: <43627c05c0b997ea407c865b04994cba630297d6.1656612839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
        <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 18:13:56 +0000
Subject: [PATCH v6 2/5] Documentation: define protected configuration
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

