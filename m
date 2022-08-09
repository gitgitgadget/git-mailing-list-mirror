Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE9C25B0C
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbiHINMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbiHINMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:12:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283C13CD2
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:11:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so14286575wrf.6
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=G8JreIyzcEq7/uAXxPzoccFoQb6CoOWKqrR+In2Ko/0=;
        b=c/UZFyh4AOw3eGq8Z59r1L1jBar9TSaacp5llrd6LdsVGqzVfBpDo3kY1Ar0rUmRjs
         9Xk4966c27aTtOavBsZk1L5djCc3AG+kxrRgDROviNy6132wgIHGWYZgKXMBafe9inKB
         P42Yf4s9SGekfElgVCzibWog+8JE5Ld0Nrb9a8xnILMP/XuILHR7G8vTRkOGLilAuKYy
         cnxLYLw4MwYJXqTbwmecmcKu5bVUVlgMjjzhzNFKAnuv09tkWQ4IQIRUqV+O8Cd79MZX
         w2cJjVQG9VmMM4HNq+d3xcfy3rF90AaCkc40SB0xIugdwSJsesSDn54CpWZYy+Z7euPO
         OPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=G8JreIyzcEq7/uAXxPzoccFoQb6CoOWKqrR+In2Ko/0=;
        b=2TXyIUYE3nzzxNwtt8qEFY6KXt2bdZevq5kP4x3gD+CY1yQQJ2A66+7Z14RXaa2O80
         GkZnQeselglfhLSIUBve8KhEUutvwIwRwQ/+R3FsGaGzkWeZiFPLUUAYCM6x5+17uNNl
         C1r4sHqSZDPZs74b/rqZO7EHQGarfPPBKl93CJNoy+xftUQioWlFKDDnuWKfpggQIkIN
         j9GamPjDhuQ/bzT535QjZKCrw3HxrCWw93E8pTtO0acaMFOXz2qAlBWStRuMOIZrJgUu
         UOTd9p3oHj0EjfyMChitYlfsOj4HkjaEsWL1fslYsGaP0r5ktLsmFN3JIEb2h3bW5YFA
         BQDQ==
X-Gm-Message-State: ACgBeo1rcobpR75fTghjHMFlmidchbsja/9KGNlfsGzm74lleo7KKG1m
        qtXl3KU13tO5nhDKNcYPgCZzJn+uqtw=
X-Google-Smtp-Source: AA6agR4qZe9WOcbZzk1CXIGacg/td2Cm1WVFaBD+AB50tC/4FFJcI2zDIZGnmRwDbT0ij4bJDwYoZA==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr14031029wro.603.1660050714042;
        Tue, 09 Aug 2022 06:11:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020a056000100700b0021f0c0c62d1sm13458376wrx.13.2022.08.09.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:11:53 -0700 (PDT)
Message-Id: <ed76d84c5a7def525ab39a8acecdac8bad12c54b.1660050704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:11:43 +0000
Subject: [PATCH v3 5/5] clone: --bundle-uri cannot be combined with --depth
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change added the '--bundle-uri' option, but did not check
if the --depth parameter was included. Since bundles are not compatible
with shallow clones, provide an error message to the user who is
attempting this combination.

I am leaving this as its own change, separate from the one that
implements '--bundle-uri', because this is more of an advisory for the
user. There is nothing wrong with bootstrapping with bundles and then
fetching a shallow clone. However, that is likely going to involve too
much work for the client _and_ the server. The client will download all
of this bundle information containing the full history of the
repository only to ignore most of it. The server will get a shallow
fetch request, but with a list of haves that might cause a more painful
computation of that shallow pack-file.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-clone.txt | 3 ++-
 builtin/clone.c             | 3 +++
 t/t5606-clone-options.sh    | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 60fedf7eb5e..d032d971dd7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -327,7 +327,8 @@ or `--mirror` is given)
 	Before fetching from the remote, fetch a bundle from the given
 	`<uri>` and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
-	namespace.
+	namespace. This option is incompatible with `--depth`,
+	`--shallow-since`, and `--shallow-exclude`.
 
 :git-clone: 1
 include::urls.txt[]
diff --git a/builtin/clone.c b/builtin/clone.c
index 4224d562758..4463789680b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -937,6 +937,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (bundle_uri && deepen)
+		die(_("--bundle-uri is incompatible with --depth, --shallow-since, and --shallow-exclude"));
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 8f676d6b0c0..f6bb02ab947 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -58,6 +58,14 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'disallows --bundle-uri with shallow options' '
+	for option in --depth=1 --shallow-since=01-01-2000 --shallow-exclude=HEAD
+	do
+		test_must_fail git clone --bundle-uri=bundle $option from to 2>err &&
+		grep "bundle-uri is incompatible" err || return 1
+	done
+'
+
 test_expect_success 'reject cloning shallow repository' '
 	test_when_finished "rm -rf repo" &&
 	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
-- 
gitgitgadget
