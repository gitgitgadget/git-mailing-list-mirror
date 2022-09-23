Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068DAC6FA83
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIWS4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiIWSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240811ED60
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g3so1250753wrq.13
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=w+suomYViTRv1j6tWOXfz9NFjsRRzEhmTqAzIjoFRR0=;
        b=hDbflKxpWIAubzLKH3/B/x1PLn3vtOm03C75mxaAV82+rCBdefWLC3XXkgWTknxVPz
         R1N2XCKDpdXi6LVv+wTXrc6gyGrrADDpMr67p9PxTkxlGAoXTJx5GO8N7mgqyAaD0gVr
         YlEsCAFIewBo3qCYvddXpf5mUnHIoUhdvPehwnGF1t41b0AFBMF/xLrtC9aT/UlqJCZx
         Mo8KeQiE0s4Djl3usOxCfNtH1KiKdZN6Qo8y9GN/wElafCf2PEgHZhd3znmXTsZ4LBaf
         iBXXsyDchGjFGG5CHjVz3M936FunX0cNYPOkBbI5ikyMysBQhwDSjSqa8DcmgZDOR8Js
         Dxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w+suomYViTRv1j6tWOXfz9NFjsRRzEhmTqAzIjoFRR0=;
        b=u5/7AmyQoPgkW9sGM+MoWlhmqUwQHcYFKdqUFjtcmCGBlBQoICO3FYUOiclaqEjSAp
         xA6OY3hgNLPnKaUAgo4igM4abW/XzhQm1bkEPdxPOivsp5ZgC/ORo6zgyaHWc60Q1oZ4
         K1Dd89waIPb/cb9JsDTbtYqoj4tJFewYJiup5j/9U04ciXLtwYWacEAvCa5TUbi3/IFn
         XrPwkI2uzVJxPToPmcWfTWPVwR55lYXEwBgTYSAZLvxO1my+3nv8Fgu1L3yVY+6GIGTY
         +wGytQ1k0LduTNOzKgv3XbYTFmbAxc9nz+JwS6wDbIDjV0ZfAQ+UQKiQKq5HLdnRGHvv
         yqPQ==
X-Gm-Message-State: ACrzQf2+AjP6qSljXb7aFgtgBY/3/KSxVl0xxdmb0LQKeODfCWfBHy2+
        xLVDAe/3pp5EdgUOSYOeyep6ESX59AU=
X-Google-Smtp-Source: AMsMyM4PahqWHmZ4WnaxvzAhdzM31fZQMWDo9PFmBb90fVt1ZT9+Nb5NqjHkGAGqxvpjYR7/y7R1Cw==
X-Received: by 2002:a5d:42c9:0:b0:22a:be00:c212 with SMTP id t9-20020a5d42c9000000b0022abe00c212mr6343070wrr.570.1663959334135;
        Fri, 23 Sep 2022 11:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020a5d6250000000b0022ae59d472esm8022277wrv.112.2022.09.23.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:33 -0700 (PDT)
Message-Id: <811d516e5d272acc40835aa6bdd4f79a001f72c0.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:24 +0000
Subject: [PATCH 10/10] evolve: add documentation for `git change`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

Signed-off-by: Chris Poucet <poucet@google.com>
---
 Documentation/git-change.txt | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/git-change.txt

diff --git a/Documentation/git-change.txt b/Documentation/git-change.txt
new file mode 100644
index 00000000000..ea9a8e619b9
--- /dev/null
+++ b/Documentation/git-change.txt
@@ -0,0 +1,55 @@
+git-change(1)
+=============
+
+NAME
+----
+git-change - Create, list, update or delete changes
+
+SYNOPSIS
+--------
+[verse]
+'git change' list [<pattern>...]
+'git change' update [-g <change-name> | -n] [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]
+'git change' delete <change-name>...
+
+DESCRIPTION
+-----------
+
+`git change list`: lists all existing <change-name>s.
+
+`git change delete`: deletes the given <change-name>s.
+
+`git change update`: creates or updates a <change-name>.
+
+If no arguments are given to `update` then a change is added to the
+`refs/metas/` directory, unless a change already exists for the given commit.
+
+A <change-name> starts with `metas/` and represents the current change that is
+being worked on.
+
+OPTIONS
+-------
+-c::
+--content::
+	Identifies the content commit for the change
+
+-o::
+--origin::
+	Marks the given commit as being the origin of this commit.
+
+-r::
+--replace::
+	Marks the given commit as being obsoleted by the new commit.
+
+-g::
+	<change-name> to update
+
+-n::
+	Indicates that the change is new and an existing change should not be updated.
+
+--force::
+	Overwite an existing change of the same name.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
gitgitgadget
