Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0754D1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbdBHMSS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:18:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:49311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdBHMSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:18:16 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFPyK-1cgz6S1GCK-00EKxp; Wed, 08
 Feb 2017 13:17:04 +0100
Date:   Wed, 8 Feb 2017 13:17:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
Message-ID: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T3LaQtftH4WJeXXOMVv1AqgwiawGSM+M+4VLDzc3YbLHXjNUrxw
 sNYHxj7NVyarApTx7DYvTM75T/7vilWaLYgOtgJHeLo2WGI+W1Asscty+OVP74+QTETN1EC
 QrM7m/aIZf+WxWro5sHJKS/GUULk5q76odIx7aPfzKxDcWMFHiBCl8oT0HZ36WGMMVu2zlm
 7q3OmyHZCWbd5lo8gKQIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:blO13rCAUlo=:2KFVSk7RX/9XbzD40bl0t4
 VixMVH24yly8Y4FMmvdlw3CEYWoyNcEPnkNrgyZcQgCh7beiMFzlv0yM0qZHwTimOFgOqVgTS
 SBDNl4YE5skQugkv0euXvn50im+LwH6Kv8RT21xvR/oiDR4UNjDHr2Y4Aq6BfvkgAGmkAD4xM
 Q1qZth3A3Ng0+oDK8KLlKOA7NNV5JXKS73eT7JhQjnbhgHAl1B9O11KrpbUvrp+eYplY4C86U
 qhRVNOGKmgafctLAdqnE+D0VKpkaRo/VvnQu+EPDG1knGtTvXjxIl3EXq8wjAmjHPdSZZPLYw
 QIyyMAWJ+qeQ0/uBcSDdRTsV1Hm328R+yPArzszU1PwrouDe8Qu+qnBAJjetpyqIV4azLE324
 43S9Uc0a4o/BV/fMyn/18od28M6XlckSZ3CW+J7f8FqpF4Um97W5PSqVe9SlKP4lQSQR4KTcR
 8BO/LBqoNl0PlIoHWc95wM9YZWGEIhOE85mN5OetjDzqr0KZgFMzCeq4MVpHfOXPUksZ0f+cK
 ZDSqEj67M8E5T6TeGFz6keN9fIZN8nlzZtufcA/A8T8tZP+zN7zt6XUWWyJM+eI8XvtVv2jYs
 5HytMIBCFYu4pRg+4U0ZNKthogKs5RkL88c5jfrsszbGYnwd64vmZrLGzlAG8voRVFda1MGlO
 aq0qaiBHl6OTgvHq3xvGT7uszSggYpRSZ8WbA7yiDlZTh9T5m2K44MtXSSqlIdNJvna2H7fgz
 2lLfm1KHE4BPQ/yvh4S25NUCsmuDgoPb7eC4jiPal3nK6c6wvbX4Gsrgd2EdyEhaURB0JTvQx
 zalFiAZTkYs7Hu7TzjmnBnPVEvKbZ5NqVx12AuyKDh/6s3VQOZ2+EoDfWDpoXFZPJ/fD6wpfl
 cAJC/mMQbqm06xmOWRmrmc43nqE9RNf7omzxT08Va/1Dixl8JlpoX8QupN7UqpXJbQIDV30mU
 COsslshT9JvL61/3Wn6S/yf6C2UAexxJktY1Y/yg+FMTw+SmYsY+KMhCtp+CXbgcT/22WshZa
 KftSGL5QJp0pmZ7jrXeHlnEoLPJk8dhTln/tdOkBAbFNR9QhFBv4mcwU++ga2tIegQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to making git_path() aware of certain file names that need
to be handled differently e.g. when running in worktrees, the commit
557bd833bb (git_path(): be aware of file relocation in $GIT_DIR,
2014-11-30) also snuck in a new option for `git rev-parse`:
`--git-path`.

On the face of it, there is no obvious bug in that commit's diff: it
faithfully calls git_path() on the argument and prints it out, i.e. `git
rev-parse --git-path <filename>` has the same precise behavior as
calling `git_path("<filename>")` in C.

The problem lies deeper, much deeper. In hindsight (which is always
unfair), implementing the .git/ directory discovery in
`setup_git_directory()` by changing the working directory may have
allowed us to avoid passing around a struct that contains information
about the current repository, but it bought us many, many problems.

In this case, when being called in a subdirectory, `git rev-parse`
changes the working directory to the top-level directory before calling
`git_path()`. In the new working directory, the result is correct. But
in the working directory of the calling script, it is incorrect.

Example: when calling `git rev-parse --git-path HEAD` in, say, the
Documentation/ subdirectory of Git's own source code, the string
`.git/HEAD` is printed.

Side note: that bug is hidden when running in a subdirectory of a
worktree that was added by the `git worktree` command: in that case, the
(correct) absolute path of the `HEAD` file is printed.

In the interest of time, this patch does not go the "correct" route to
introduce a struct with repository information (and removing global
state in the process), instead this patch chooses to detect when the
command was called in a subdirectory and forces the result to be an
absolute path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/git-path-in-subdir-v1
Fetch-It-Via: git fetch https://github.com/dscho/git git-path-in-subdir-v1

 builtin/rev-parse.c   | 6 +++++-
 t/t0060-path-utils.sh | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ff13e59e1d..f9d5762bf2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -597,9 +597,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!strcmp(arg, "--git-path")) {
+			const char *path;
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
+			path = git_path("%s", argv[i + 1]);
+			if (prefix && !is_absolute_path(path))
+				path = real_path(path);
+			puts(path);
 			i++;
 			continue;
 		}
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4df8..790584fcc5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -271,6 +271,8 @@ relative_path "<null>"		"<empty>"	./
 relative_path "<null>"		"<null>"	./
 relative_path "<null>"		/foo/a/b	./
 
+test_git_path "mkdir sub && cd sub && test_when_finished cd .. &&" \
+	foo "$(pwd)/.git/foo"
 test_git_path A=B                info/grafts .git/info/grafts
 test_git_path GIT_GRAFT_FILE=foo info/grafts foo
 test_git_path GIT_GRAFT_FILE=foo info/////grafts foo

base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
-- 
2.11.1.windows.1
