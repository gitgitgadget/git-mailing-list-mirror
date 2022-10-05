Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB3C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJEPBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJEPAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814F13F5B
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b7so18738151wrq.9
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=w+suomYViTRv1j6tWOXfz9NFjsRRzEhmTqAzIjoFRR0=;
        b=fPLAyFOaaCWSQlIruRC6VqoI4qmxpCoqH9Ptc9qw7SvzjWaCcK/LZRKAnqtBsN6xVd
         +C9SxMY7GKDqXS3tJzilLC8Wq+J1cbZyBPFfD1XM8R5U7dV3mLVrBfz4r1BIbW7xX2LG
         RbNdtPlB1uNCVkfmPYGm1lIwEHWnDUJrHL6upoxWdfLARRA5MlXR/C6R5BrxPgeCk/Tu
         suPFk+70yhyDhxe1QKYar+3w79VkLDFhih2a3HvW2VVdjc5lGldPZasTIb6kUG2D8QYS
         0bZyJnD64A2WWYujAWf5Tu7vXuxfL59bX9kn32UntVVIeWziou3pn+OaI3tYx7IqGRVC
         kGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w+suomYViTRv1j6tWOXfz9NFjsRRzEhmTqAzIjoFRR0=;
        b=j60JAi+3j9o0scpOas2EQqBeI7Lnco4DcnJdJZCH7VbF/uYGeXvT5g5pevPrtQsHsM
         Ztda61Xa7izrJ8io7GeJwyMrR1tCZHPRKEY7v0K2S+K+4aUGEEGLtKIn8ndO5GroR5k4
         0FtjS4uh8ULtyM3ha1boDSmCVynncGQBN9WMm2M4G93NPBgGPNPRovxG0TbswbAM+e8G
         cQCClR/7deLMeXQdlvl9aAqVCnXzYvFC7Y1HEwCWyYOdI5uzxkKD1MaMLr7tsXsknkcz
         cUpMC9feR232PnfmI5X+ioJU/ra87OneyrJd3X/Ky4mJ+3kFArVSPjHoOe9G042K0ZHh
         dzZQ==
X-Gm-Message-State: ACrzQf04Y/uxSyPSL4u2FnXz9bl6rdgvTrnzba06ObsSenA/p2gQ7KX3
        pp/yTpoA7LoA86jssGWY8rfbNPKZQfc=
X-Google-Smtp-Source: AMsMyM6sKlnndSezwM/CEmeG54WnVqyMSEBbmbsOpcj653yrcxo5r9r3SiT6KfFY/aOZSX5E+CLKbQ==
X-Received: by 2002:a05:6000:1d8b:b0:22a:c046:946d with SMTP id bk11-20020a0560001d8b00b0022ac046946dmr80268wrb.249.1664981968936;
        Wed, 05 Oct 2022 07:59:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c320400b003b4727d199asm2053239wmp.15.2022.10.05.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:28 -0700 (PDT)
Message-Id: <e67ff668fffaf6d38ec77d332319d60acc9b2454.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:16 +0000
Subject: [PATCH v2 09/10] evolve: add documentation for `git change`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
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

