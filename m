Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B79C433FE
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiDYSab (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbiDYSaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 14:30:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D8726AE5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso46138wme.5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpvDYK92geaWq6NAj3ofB2lxVVhPRl0V9Dr3eq9jwlI=;
        b=fnVnN6H7D/ZkXEKR6fbWl3EZCUjdEj+8WRT8fAVOWWm0cF8GebL1rutjyp23IJw4mZ
         tu4POAvcyTxCsThEu85Xy1ZbYgpPZNwUdMGjdUJ02Ybm3KFYV9ZmJAsGGTUw+sZZBvXV
         l6w0LlH5F8G4RD//7fXvECIQfiDWrcdUW1Ng+pAu1OgxLkwL9qZaA2cZehPyNlRCB+rq
         kYQMYdJA10ajC+vLc5BNmTcpKEm9ObG83bYczbiODX3cpQt1512phJmabVK2ao9VqxNW
         F02M1avLy+nx84mkfgsHatO1D7voLpFfebIOFU8NDnHNx0IGoYN9/Yywp2Hz2rMapDCC
         AifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KpvDYK92geaWq6NAj3ofB2lxVVhPRl0V9Dr3eq9jwlI=;
        b=8JaOY0lIU/DSg81QioN8Y6X6vAB8onULBUY2bm6LTxVn5kGRBIbgtT7S7SlRW9hn/Z
         tjn/Zo/miiqfsH/5Bj2eqiuwfrSWUp33rkTXcVp7tmZpzsmmv5+dqjdBdy5YDsxx73AL
         NsrklBSaiGlYZoxfFydQPa3nTZ/M3T7SKkn8Yx31eev3/DkPaVGToIO+49WGq6WxFV40
         ohH0itpQ2YaOvgN8DaRODpSOWBuwNxVLZph335wWqOUd1CUsi+a0Y2HEknbL/8iU/G4B
         oMxqX0loI+bTqETdWNkcALzJntILWMnght1zfy2CoOpzF6aQuYfYp+LniDarh4BOHQMI
         CIXw==
X-Gm-Message-State: AOAM530P4dWH79xS5GI6q8jba/7+H9+ud9xPJvr5jkCud3s0hqcJOu4/
        HHCHQtTlA9VrXUBsdf0mmqziScSE7Zk=
X-Google-Smtp-Source: ABdhPJzZJ3EVegOtRK4wplVwfXc2lbLg2QCBnwrLLJHPqJlhoyTbZijMkeyUdxa4Fj/EV1gSfV6K5w==
X-Received: by 2002:a1c:a181:0:b0:392:8f7e:d2f8 with SMTP id k123-20020a1ca181000000b003928f7ed2f8mr17956528wme.30.1650911238217;
        Mon, 25 Apr 2022 11:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b00393efe9e780sm1629065wmq.1.2022.04.25.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:27:17 -0700 (PDT)
Message-Id: <fd580e7947743db545a839e81f027984e70b7717.1650911234.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
        <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 18:27:13 +0000
Subject: [PATCH v2 2/3] multi-pack-index: use --object-dir real path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The --object-dir argument to 'git multi-pack-index' allows a user to
specify an alternate to use instead of the local $GITDIR. This is used
by third-party tools like VFS for Git to maintain the pack-files in a
"shared object cache" used by multiple clones.

On Windows, the user can specify a path using a Windows-style file path
with backslashes such as "C:\Path\To\ObjectDir". This same path style is
used in the .git/objects/info/alternates file, so it already matches the
path of that alternate. However, find_odb() converts these paths to
real-paths for the comparison, which use forward slashes. As of the
previous change, lookup_multi_pack_index() uses real-paths, so it
correctly finds the target multi-pack-index when given these paths.

Some commands such as 'git multi-pack-index repack' call child processes
using the object_dir value, so it can be helpful to convert the path to
the real-path before sending it to those locations.

Add a callback to convert the real path immediately upon parsing the
argument. We need to be careful that we don't store the exact value out
of get_object_directory() and free it, or we could corrupt a later use
of the_repository->objects->odb->path.

We don't use get_object_directory() for the initial instantiation in
cmd_multi_pack_index() because we need 'git multi-pack-index -h' to work
without a Git repository.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/multi-pack-index.c | 45 ++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4480ba39827..5edbb7fe86e 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -44,7 +44,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 };
 
 static struct opts_multi_pack_index {
-	const char *object_dir;
+	char *object_dir;
 	const char *preferred_pack;
 	const char *refs_snapshot;
 	unsigned long batch_size;
@@ -52,9 +52,23 @@ static struct opts_multi_pack_index {
 	int stdin_packs;
 } opts;
 
+
+static int parse_object_dir(const struct option *opt, const char *arg,
+			    int unset)
+{
+	free(opts.object_dir);
+	if (unset)
+		opts.object_dir = xstrdup(get_object_directory());
+	else
+		opts.object_dir = real_pathdup(arg, 1);
+	return 0;
+}
+
 static struct option common_opts[] = {
-	OPT_FILENAME(0, "object-dir", &opts.object_dir,
-	  N_("object directory containing set of packfile and pack-index pairs")),
+	OPT_CALLBACK(0, "object-dir", &opts.object_dir,
+	  N_("directory"),
+	  N_("object directory containing set of packfile and pack-index pairs"),
+	  parse_object_dir),
 	OPT_END(),
 };
 
@@ -232,31 +246,40 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 int cmd_multi_pack_index(int argc, const char **argv,
 			 const char *prefix)
 {
+	int res;
 	struct option *builtin_multi_pack_index_options = common_opts;
 
 	git_config(git_default_config, NULL);
 
+	if (the_repository &&
+	    the_repository->objects &&
+	    the_repository->objects->odb)
+		opts.object_dir = xstrdup(the_repository->objects->odb->path);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (!opts.object_dir)
-		opts.object_dir = get_object_directory();
-
 	if (!argc)
 		goto usage;
 
 	if (!strcmp(argv[0], "repack"))
-		return cmd_multi_pack_index_repack(argc, argv);
+		res = cmd_multi_pack_index_repack(argc, argv);
 	else if (!strcmp(argv[0], "write"))
-		return cmd_multi_pack_index_write(argc, argv);
+		res =  cmd_multi_pack_index_write(argc, argv);
 	else if (!strcmp(argv[0], "verify"))
-		return cmd_multi_pack_index_verify(argc, argv);
+		res =  cmd_multi_pack_index_verify(argc, argv);
 	else if (!strcmp(argv[0], "expire"))
-		return cmd_multi_pack_index_expire(argc, argv);
+		res =  cmd_multi_pack_index_expire(argc, argv);
+	else {
+		error(_("unrecognized subcommand: %s"), argv[0]);
+		goto usage;
+	}
+
+	free(opts.object_dir);
+	return res;
 
-	error(_("unrecognized subcommand: %s"), argv[0]);
 usage:
 	usage_with_options(builtin_multi_pack_index_usage,
 			   builtin_multi_pack_index_options);
-- 
gitgitgadget

