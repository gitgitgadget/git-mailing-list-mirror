Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E3F20450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755291AbdKBGyZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:54:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47970 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755280AbdKBGyW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:54:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id r25so4263227pgn.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kf1SyIdHYt8OU0UWDH3ThFBQLVmxj3jvJVtEEhXkpNk=;
        b=SqdgcVipmTHK/pPJLKAILqaO0TueOHkHQsDAvkICb6iQ5ErTCtJOOcVACQ/i5lHkqU
         1Jdb1BO+c5y+cWCPWuEfW5zc/gc7utApTV8TiAPuugRFM0K1d2s4c+1+57Ga8knEIh0X
         4nVRSmYlT1I0R6IXFsCr7Esg7JvfBBsrqnCCi9nDZFviKI+ulPAtJlWCpx0jxSlbyTgI
         6YT8EOMRDuaZWf9QLXopxmEo3Hk2P0tnfP4PoWz31pMzimXdgqT1AxfL74vudqMLhePX
         KQoCXUF0vxO7XLPe68VBu2bgsVeYwWMXVhhqE4lOelod9rbPaFa46xuujiLqgKZ/ph1g
         GuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kf1SyIdHYt8OU0UWDH3ThFBQLVmxj3jvJVtEEhXkpNk=;
        b=FjSM3huL5IkYVg5GlItx8+hU0OgGgz86jXN4UfpxPfkryGUdn8doCpbel9iPUMHnf/
         eDxPfYLtXjp2Z5zIex+HKeAbYTLdn0I3f3/go5L43I+kG0rS40L7Lay01bb8s4AKkhbo
         jHhqGcQ8FgQcwhP5gdF7Uko7N+wxuwUhYcAqyBx7RCL2aWuGTGZLE80CI/FsbuI9dlv2
         ELCA7Qrv+70xvFrMUQadaaHZbFx+ZDl+XjBCpCtWwsJ2LpQVpKvCtqtAB8pYDFXR28q0
         AFs85WfCEaP3rqYDNLqHYs6nBfRjTke92AVj4xVIS3eAP3V/klQXsHLI+cWav+Tf6Ktm
         0RVw==
X-Gm-Message-State: AMCzsaWgy4+skfIgbAmnKVjHM8h8PBx2nBp3eHvaCnVCT3uKCHj+qz6L
        6nI+QN7ss1P3FgqNxIDKeV69FflC/VE=
X-Google-Smtp-Source: ABhQp+RykVpYsnkh73Rk/83/TwBVrJTYmwnu6ptagXpCvubY533vc3FDhPiJRuWAqlpeL7oBg0kSPA==
X-Received: by 10.84.168.69 with SMTP id e63mr2177499plb.193.1509605661266;
        Wed, 01 Nov 2017 23:54:21 -0700 (PDT)
Received: from localhost.localdomain ([117.243.29.9])
        by smtp.gmail.com with ESMTPSA id q12sm3843567pgn.56.2017.11.01.23.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:54:20 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 2/4] branch: re-order function arguments to group related arguments
Date:   Thu,  2 Nov 2017 12:24:05 +0530
Message-Id: <20171102065407.25404-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
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

