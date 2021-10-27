Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7785C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D5C60296
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbhJ0IaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbhJ0I3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C4C061348
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o14so2636535wra.12
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QyrukTNVfouEeAzxOv26evBXhIGqbMFj9uesv2a/2bw=;
        b=NzA4o8HjFjQyJyKPSEkJ/c+PxzG5K64EY3/lVCbDAaFe6NJE91cJvOuphbuwCVCSPT
         5r8GSyKJMZ3272k/AKdDLhoLT5lI5zyJ/+qnpZI4F8Xi+xZ7B3nXxoYMDx3gEbV4b+KW
         b3eEBCEXsffExZc7wVwQrmRA4W98G9Shjp8GgnjstmKHKXhGMd4YdIH0Hbfy5rNSFijr
         XbDt0snOXj2dXH7NKnjivvuCxo6iyJXclL6NUoPVAFtpBcuyL2YUNv2KwnQTiTVcqRbL
         JY8tvOZIEgNiuhUXilLZGLEw4uMfFBhYwy2ZeqkhciM5uP5UkpsNXGVPqQEB6M5VCHBg
         D8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QyrukTNVfouEeAzxOv26evBXhIGqbMFj9uesv2a/2bw=;
        b=UlF5yu69DAUXlhW/CICG5g6VZ6SWD/hTPAQJb1AmZkbHpRB97NeRSVq1oL4bp3B0LJ
         /Ao8Vv51tW//hSIEynrtPTsEa5A1eByod+pYNr3VPpWN15QIjh/ZX3YtdyUEyaQq5De5
         jVHUNK9BnDmy8PG5IAAxiMuxP+ORbe0HJpreRsl9E4ga3Ov/OJvjDLHlk5gQcoGcqaei
         /pdvEKz67yOYPdEw1l3yoFESIqOvUE/PlwJvh6iliQUw9UNDrFuJxgZSpbg5FyVPVL3u
         1Q9S0XGqReA5891cc7v7mqCgJot4MUQK0pc6pzUWkGy7PNYW/OaP/vyCJTi5taidldGC
         tPbg==
X-Gm-Message-State: AOAM531w02WmuKDV8kn8UOYyvHRFCyED8baFuZLr8Fb6GIQ1fo2V19w8
        jbE7pYv8q4OMj+sbB6871Znx8ulNmhQ=
X-Google-Smtp-Source: ABdhPJzZ9R45H3bHyUZNYqIYic4JLCRGwtTvTdjZWNhHGZkrrHhbI9dSokaAV/uduRH00vFsOMrdGw==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr26876362wrx.334.1635323244700;
        Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm22969656wri.84.2021.10.27.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Message-Id: <136aec439fd7e1c807088b57101df54bf6beb34f.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:11 +0000
Subject: [PATCH v6 07/15] scalar: implement 'scalar list'
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
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The produced list simply consists of those repositories registered under
the multi-valued `scalar.repo` config setting in the user's Git config.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 11 +++++++++++
 contrib/scalar/scalar.txt | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index dc84ce0d5b2..d13eb951c3d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -250,6 +250,16 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int cmd_list(int argc, const char **argv)
+{
+	if (argc != 1)
+		die(_("`scalar list` does not take arguments"));
+
+	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
+		return -1;
+	return 0;
+}
+
 static int cmd_register(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -336,6 +346,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d9a79984492..f93e3d00efd 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 
@@ -28,11 +29,19 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand.
+depending on the subcommand. With the exception of `list`, all subcommands
+expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+List
+~~~~
+
+list::
+	List enlistments that are currently registered by Scalar. This
+	subcommand does not need to be run inside an enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

