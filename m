Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAF820450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbdKBGxI (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:53:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:49170 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdKBGxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:53:06 -0400
Received: by mail-pg0-f66.google.com with SMTP id g6so4263771pgn.6
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kf1SyIdHYt8OU0UWDH3ThFBQLVmxj3jvJVtEEhXkpNk=;
        b=WSSsDgzCk2Dnzc8YcPijT/04nVtwoP+fyjW3TyGjlZow9z/ZRD6eaeRsgfad0GXu7M
         L3PEGt7WoazN7Y7Bxh+D/8ZErdc95YyilTbx1ChSYqM4t+vDFZBndHRSZGM4RPDIBpxg
         2T/tiKdLglPvuEnsjYC0zzZTVVPc3Xx8huooAuMzu2Im3DBhFJcKPvRZBSHvAIf8IA8f
         El+9pqoqGIzXu20FCnxaak7zhje5BXP4zvRHvt2bYimefZbI5nXfy31AingxblygE9jI
         mmI+ig2prQyAM3Z3ZJzfAk8LChDhl8wDecbvV9q+T2U2CQVkBLWGa/XQnIM8A2SBEWR7
         TuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kf1SyIdHYt8OU0UWDH3ThFBQLVmxj3jvJVtEEhXkpNk=;
        b=Tjns8O9M6lVcACraAhJHmv/PAq6P33suBVtc3dzkpOWomtgSPbNGCp+JQby4w8q3N5
         Vxqi+ppOryczNY6xPZKuX49mGzcslwosoWocse0A7hfGr35B6rilKY5EfnsbUBA0crwC
         I42GEHhwJEUIHEYqYmstRtY3ZmkY1rExJwvLd4o1Voq0KdIbxcyQp3DwtFcZeavdM/9H
         jgGR3YKOIGmirtJdl30jr3qV8iFnVQ39FMFvTPcV0TlDFSn9jiAubTv4jTCd8AAzbQKk
         I/PaxTMmtA/CfqEQU64BlYeJAEV/ZfA+2ALOyr7f5r7nuReDa+dSLPrZDYf3otI/mpXh
         Kluw==
X-Gm-Message-State: AMCzsaX/Alj+i3/iNTKHi2iFoMhjzrpQYe7P15zcTpYKe4uz/T5LFkbJ
        YoM3034eidTyRonHcHRuOyVX4zKaK+w=
X-Google-Smtp-Source: ABhQp+T1Hi9APAP3LP6x7cdx29zuSf7O9BtP9zmla2W4ipW8dRDe28JsgFGaJJun8/T1p62UPZ8KZg==
X-Received: by 10.99.119.4 with SMTP id s4mr2447358pgc.377.1509605585593;
        Wed, 01 Nov 2017 23:53:05 -0700 (PDT)
Received: from localhost.localdomain ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id p4sm3879871pga.58.2017.11.01.23.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:53:04 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 2/4] branch: re-order function arguments to group related arguments
Date:   Thu,  2 Nov 2017 12:22:40 +0530
Message-Id: <20171102065242.25299-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
References: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

The ad-hoc patches to add new arguments to a function when needed
resulted in the related arguments not being close to each other.
This misleads the person reading the code to believe that there isn't
much relation between those arguments while it's not the case.

So, re-order the arguments to keep the related arguments close to each
other.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           |  4 ++--
 branch.h           | 14 +++++++-------
 builtin/branch.c   |  4 ++--
 builtin/checkout.c |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index ea6e2b359..7c8093041 100644
--- a/branch.c
+++ b/branch.c
@@ -244,8 +244,8 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head_ok,
-		   int quiet, enum branch_track track)
+		   enum branch_track track, int force, int clobber_head_ok,
+		   int reflog, int quiet)
 {
 	struct commit *commit;
 	struct object_id oid;
diff --git a/branch.h b/branch.h
index 1512b78d1..85052628b 100644
--- a/branch.h
+++ b/branch.h
@@ -11,21 +11,21 @@
  *   - start_name is the name of the existing branch that the new branch should
  *     start from
  *
- *   - force enables overwriting an existing (non-head) branch
+ *   - track causes the new branch to be configured to merge the remote branch
+ *     that start_name is a tracking branch for (if any).
  *
- *   - reflog creates a reflog for the branch
+ *   - force enables overwriting an existing (non-head) branch
  *
  *   - clobber_head_ok allows the currently checked out (hence existing)
  *     branch to be overwritten; without 'force', it has no effect.
  *
- *   - quiet suppresses tracking information
+ *   - reflog creates a reflog for the branch
  *
- *   - track causes the new branch to be configured to merge the remote branch
- *     that start_name is a tracking branch for (if any).
+ *   - quiet suppresses tracking information
  */
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog,
-		   int clobber_head_ok, int quiet, enum branch_track track);
+		   enum branch_track track, int force, int clobber_head_ok,
+		   int reflog, int quiet);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 5be40b384..df06ac968 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -766,7 +766,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(branch->name, new_upstream, BRANCH_TRACK_OVERRIDE, 0, 0, 0, quiet);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-			      force, reflog, 0, quiet, track);
+			      track, force, 0, reflog, quiet);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8546d630b..5c34a9a0d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -639,11 +639,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		}
 		else
 			create_branch(opts->new_branch, new->name,
+				      opts->track,
+				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
-				      opts->new_branch_force ? 1 : 0,
-				      opts->quiet,
-				      opts->track);
+				      opts->quiet);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
-- 
2.15.0.461.gf957c703b.dirty

