Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5859F208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbeHGPfi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 11:35:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43864 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbeHGPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 11:35:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so4490354edp.10
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jlHhI+puRL5olQPc2izI2BCuPAqiwC8Qpl/QVR7264=;
        b=apV8u0CGrQgzVtG7O9Q8Vl2EFvto2Z6IfUKCByw+YEkhd0UiDS/EvWCAaqRFIc+tH8
         RHO6bxSX47de/v/baQeKHWcNSBFDGl2Ipa7mmhB7DnzhCyUvr8dyNHR7CGocyqJAQZEo
         nfPP8KUOCXhzd+CNpm2IJ11HlU6Sdu5oxkkbXOwKMeO3Z0nfOokcg9wdoLx0/BQvLbSS
         cGijgE3LNGKF/lxohB4OtZ9DTEmEEg4Awz0eOZlYQlcpR0mgYhVVt4v4b8FKqX/yMMnM
         Cwcrdv4ehnRq8piPRAMfEIuUlr/ci5fRQkxzcB2YaCVRnY1uH79VGYZpAc8D3/qoubml
         UIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jlHhI+puRL5olQPc2izI2BCuPAqiwC8Qpl/QVR7264=;
        b=py9BJg/Fyboz23i+nqABOSc277IpjvqVfRi2YZOWgHJTRC4PwmL3847AbKjcfKqAjA
         ZHuZtSbVnEq3QSKbytV+A8zQXqkk+DGui64FPZLFITEaYCdt28gAM3Yx+7S8fhWrmObh
         zNtJI9P0h1s0IpaNN4Jn+AOtC6CIPwr3O5CbXR5swsQzB66GpJIlGaGxjavJG3jikj9u
         zM3w28upnxvTYiTsNU+uwlnPbAeEYe71ndETcPM/V81RWLn5ux7gwuT6vwcRzwhscbeA
         XfD4lNgq/BgkeqQZvBFNSCX+qsFxfEiuJgaf9PDROsuHo3pmbEkSuW84jiYKbSZLkYcC
         rpCQ==
X-Gm-Message-State: AOUpUlHK2+D8nbCN/O12mNPE8saIWcE01a+2QFqjURDe38EOv3xJPToC
        NtZfBptgos4vgKdwgOeNeWA2d1jNNQX/lrdWIw8=
X-Google-Smtp-Source: AAOMgpd24KKrGgfW/DQcOPq0+wVxKNzZlRy5F6ZiH5DV2n+7rlufqIIpDBSygcyCb0eB3MqO0R7+TA==
X-Received: by 2002:aa7:d4c1:: with SMTP id t1-v6mr23139806edr.121.1533648077606;
        Tue, 07 Aug 2018 06:21:17 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.100.8.34])
        by smtp.gmail.com with ESMTPSA id w3-v6sm1423254edb.16.2018.08.07.06.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 06:21:16 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] worktree: add --quiet option
Date:   Tue,  7 Aug 2018 13:21:13 +0000
Message-Id: <20180807132113.118297-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.18.0.721.gc1f18ed
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the '--quiet' option to git worktree add,
as for the other git commands.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git-worktree.txt |  4 +++-
 builtin/worktree.c             | 11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9c26be40f..508cde55c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -115,7 +115,9 @@ Unlock a working tree, allowing it to be pruned, moved or deleted.
 
 OPTIONS
 -------
-
+-q::
+--quiet::
+	With 'add', suppress feedback messages.
 -f::
 --force::
 	By default, `add` refuses to create a new working tree when
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a763dbdcc..c47feb4a4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,6 +27,7 @@ static const char * const worktree_usage[] = {
 struct add_opts {
 	int force;
 	int detach;
+	int quiet;
 	int checkout;
 	int keep_locked;
 };
@@ -315,6 +316,9 @@ static int add_worktree(const char *path, const char *refname,
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
 		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		if (opts->quiet)
+			argv_array_push(&cp.args, "--quiet");
+		printf("%s\n","soo qia");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
@@ -437,6 +441,7 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
 			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
@@ -491,8 +496,8 @@ static int add(int ac, const char **av, const char *prefix)
 			}
 		}
 	}
-
-	print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
+	if (!opts.quiet)
+		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -500,6 +505,8 @@ static int add(int ac, const char **av, const char *prefix)
 		argv_array_push(&cp.args, "branch");
 		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
+		if (opts.quiet)
+			argv_array_push(&cp.args, "--quiet");
 		argv_array_push(&cp.args, new_branch);
 		argv_array_push(&cp.args, branch);
 		if (opt_track)
-- 
2.18.0.721.gc1f18ed

