Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90889C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E98060D42
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhJ0I3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbhJ0I3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE312C061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z81-20020a1c7e54000000b0032cc97975e4so1611529wmc.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iIDxEOzaBWUuwrTlINMFmvZLBskkFAXJw9qE9GmcBzM=;
        b=M5YJVnVQN+tPJfk3sx4HYblzSi9zqi21KBiQYfAB3psEpDzkUzX/snTwrIbYSzpWxD
         d4i3aw6YuizePoMNELc4soT3gv+WOuZ4a3plhH+3siBXScqf+/i+nvxMf8TWQFGS3rEg
         aOkpXoW8cw6G2SZd60OHqJg4uMtaoh4sZNq2Akk8DaZwzncrF56Tmj9HbQ1/6MbWtnaz
         QW4I7G0zQAyYjUJxFBGZYGXDzbfeJTJd+2h2Ti+IoIOleqT3o1dr8R5rkV5zSRKN0wC3
         yl7Ak/RPwykuUFXtVKzHV52/Z54mLwXJa8AGPjUvFXF+d/11x/8Kz1ZGefWwOnyTBdf5
         VZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iIDxEOzaBWUuwrTlINMFmvZLBskkFAXJw9qE9GmcBzM=;
        b=PyRO0pkvnmMT+D6jTLXfjA90yKFLOnvUYZdrzQXlyrZFnN/TZhjNuR79X/fq9oggSk
         ZHUtmUsc+l00nPOeBCcWN+lbWlWDgSYG53hqL4htJGrRgFMnju84KElqmp4rEnT+6Qs5
         iAFADvBvKihyBFjp9Oc87RLYy1Z7DZ3kSUHF5hwPpmAmWVPOoOAfVx4Lac7q/6GWp727
         rzNCp/DziU0Yi4v93xGOTKJqIBa0wk4w9jgeKdK7/7/r2O341xPJbapMTdpZTcIYgdrJ
         /jYM83N5qlLnrl+z0/4W85X/PlBNqPG9SgNGZiuIgPs51KgO4jP0GbR4gwzDUEkmp/vt
         UERg==
X-Gm-Message-State: AOAM532aSaTu62Eyl5tMXd6iB102K0suoJFZZqzL2gGQoRre7bOuqZW0
        OLoA/m7RscUSJPq00j+RIc5JB9o4Y8w=
X-Google-Smtp-Source: ABdhPJw16gjD3lr5xYZkp4ye4KTz+dckyTv999fFJMgbirkNAEu+1WIaEfs6ndSafzGM9qxi1ZiOhw==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr4362554wmf.61.1635323241561;
        Wed, 27 Oct 2021 01:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm11603697wrs.14.2021.10.27.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:21 -0700 (PDT)
Message-Id: <40fee75968e6bb0940bfa040b917f305fbb6671f.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:06 +0000
Subject: [PATCH v6 02/15] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit establishes the infrastructure to build the manual page for
the `scalar` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/.gitignore |  3 +++
 contrib/scalar/Makefile   | 14 +++++++++++++-
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
index ff3d47e84d0..00441073f59 100644
--- a/contrib/scalar/.gitignore
+++ b/contrib/scalar/.gitignore
@@ -1,2 +1,5 @@
+/*.xml
+/*.1
+/*.html
 /*.exe
 /scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index f6f0036f0fa..e862d3ad8fa 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -6,6 +6,7 @@ ifndef V
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
+	QUIET          = @
 else
 	export V
 endif
@@ -30,5 +31,16 @@ $(TARGETS): $(GITLIBS) scalar.c
 
 clean:
 	$(RM) $(TARGETS)
+	$(RM) scalar.1 scalar.html scalar.xml
 
-.PHONY: $(GITLIBS) all clean FORCE
+docs: scalar.html scalar.1
+
+scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
+
+scalar.html scalar.1: scalar.txt
+	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/scalar/scalar.txt \
+		../contrib/scalar/$@
+	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
+
+.PHONY: $(GITLIBS) all clean docs FORCE
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

