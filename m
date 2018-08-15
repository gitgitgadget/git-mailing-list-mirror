Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB071F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHOXu3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:50:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42948 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeHOXu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:50:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so1505943edp.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84V+sYvLpl4fCm8ZhM9rlnIMT3mK9AqsbGJkKgpqgGM=;
        b=sNHBbiVWwirk7LxIBk/BdVmInOVeFezFAvWKltyEgbVhFsuv6hbtEWUHN26hqjzRXq
         NbxOwlnwL6elBI0auT8BfrYC+aS4OfCeAyBe+Ie1pShtMHbPL/HxEiwa4h1Q8XIeO/F+
         4S3LEjpSXmnZSbS3z449L7I+32P+8MqflbTWVC2S5Vc+9wpNdlWsQ7T/MtJqoQd2RdWi
         +1elEcHUgo2UPY6SfLSchlBONPiNeC97jQ3gZAdtdl//p4XTAaOO5vfxN7SRMOiBE5Tp
         s21IiYmOERAHUHe+wmfr4fwo8iLwO66Xn2SGN50XD10YeTJC0dyndSRlrHyDpdoasGx8
         F8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84V+sYvLpl4fCm8ZhM9rlnIMT3mK9AqsbGJkKgpqgGM=;
        b=H+ZTJbv89O/PnWTFAEEEdeex53L0AumGrWAeCIIdVTSVPGVZalwS6qSvWRdofIMECw
         yiA/tqEbk2xiB28U/TsH7Z5EiSL5IRL86kz6ECwIAO84G9L6oy+1McWVgEgkP6ygIcAw
         j1M1kFpgi2GGclVelXIfxmzUCVGYdZNfxt/M2na9fkkQ/VuyeILKelswjar4MTq22UL3
         0YlRk/KWPdm+35TNvWboGJWOJI4Tphd1RCWY7BgEEMxf0SGrHM2YL2uFfL8q9J9XVnMv
         bEyv4oo/nFSq53N2KMoSH+txGfDPxJh/jC9+DxV1ay+cBpxNyUPpTubOZ8hGFIDKXR1k
         iKiA==
X-Gm-Message-State: AOUpUlFy2Yvt5VxImRPZnrqcRixEcvTHfWeCBUVSGgo/jdP44qkHBroC
        q1XbQff+bwwcNDM1aoXRGcnzbZaZivs=
X-Google-Smtp-Source: AA+uWPwworSGS2Nz7jKIaAMerpHoHMJ6eo6xWZlHUHnoeSbbxCtWZ+26RcPY1yUSQy2zSbstSmBnXQ==
X-Received: by 2002:a50:ad55:: with SMTP id z21-v6mr33446627edc.142.1534366597595;
        Wed, 15 Aug 2018 13:56:37 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.100.8.34])
        by smtp.gmail.com with ESMTPSA id s23-v6sm13344107edm.74.2018.08.15.13.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 13:56:35 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        karen@codesynthesis.com, Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2] worktree: add --quiet option
Date:   Wed, 15 Aug 2018 20:56:30 +0000
Message-Id: <20180815205630.32876-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.18.0.723.g64e6cc43e.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the '--quiet' option to git worktree,
as for the other git commands. 'add' is the
only command affected by it since all other
commands, except 'list', are currently
silent by default.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch.

Changes from the first version
(https://public-inbox.org/git/CACsJy8A=zp7nFBuWyfeP4UFf3KSsiaor3m0mtgVnhcEYHSw4HA@mail.gmail.com/T/):

- deleted garbage in git-worktree.c and deleted
superfluous blank line in git-worktree.txt.
- when giving "--quiet" to 'add', call git symbolic-ref also with
"--quiet".
- changed the commit message to be more general, but
specifying why the "--quiet" option is meaningful only for
the 'add' command of git-worktree.
- in git-worktree.txt the option
"--quiet" is described near the "--verbose" option.

 Documentation/git-worktree.txt |  4 ++++
 builtin/worktree.c             | 16 +++++++++++++---
 t/t2025-worktree-add.sh        |  5 +++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9c26be40f..29a5b7e25 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -173,6 +173,10 @@ This can also be set up as the default behaviour by using the
 	This format will remain stable across Git versions and regardless of user
 	configuration.  See below for details.
 
+-q::
+--quiet::
+	With 'add', suppress feedback messages.
+
 -v::
 --verbose::
 	With `prune`, report all removals.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a763dbdcc..41e771439 100644
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
@@ -303,9 +304,13 @@ static int add_worktree(const char *path, const char *refname,
 	if (!is_branch)
 		argv_array_pushl(&cp.args, "update-ref", "HEAD",
 				 oid_to_hex(&commit->object.oid), NULL);
-	else
+	else {
 		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
 				 symref.buf, NULL);
+		if (opts->quiet)
+			argv_array_push(&cp.args, "--quiet");
+	}
+
 	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (ret)
@@ -315,6 +320,8 @@ static int add_worktree(const char *path, const char *refname,
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
 		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		if (opts->quiet)
+			argv_array_push(&cp.args, "--quiet");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
@@ -437,6 +444,7 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
 			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
@@ -491,8 +499,8 @@ static int add(int ac, const char **av, const char *prefix)
 			}
 		}
 	}
-
-	print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
+	if (!opts.quiet)
+		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -500,6 +508,8 @@ static int add(int ac, const char **av, const char *prefix)
 		argv_array_push(&cp.args, "branch");
 		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
+		if (opts.quiet)
+			argv_array_push(&cp.args, "--quiet");
 		argv_array_push(&cp.args, new_branch);
 		argv_array_push(&cp.args, branch);
 		if (opt_track)
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index be6e09314..658647d83 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -252,6 +252,11 @@ test_expect_success 'add -B' '
 	test_cmp_rev master^ poodle
 '
 
+test_expect_success 'add --quiet' '
+	git worktree add --quiet ../foo master >expected 2>&1 &&
+	test_must_be_empty expected
+'
+
 test_expect_success 'local clone from linked checkout' '
 	git clone --local here here-clone &&
 	( cd here-clone && git fsck )
-- 
2.18.0.723.g64e6cc43e.dirty

