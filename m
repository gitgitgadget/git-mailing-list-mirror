Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD2620281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934121AbdIYIUs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33857 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbdIYIUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id u18so4503663pgo.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5toWmDsaqzdTqikBBGSzNd0+axCm73Prn37IDOcM4k=;
        b=VuYa4McwyoOKqQxOI2G3EzRQANrdP1jmHdH3OtvAs/DnY5AEu4PnPkL4NkxmCKsvg7
         GoJKnMaAdensCaq1AG2VWOIkihDmxl1BChZ3gD+1HkQeLzjkpfTeqEINj4FRDt2xt/34
         bVfhbEqGIYurGV402Onp/0M1FRtqsPJXEm0L35g+2umMIUlF2XmFOAu9tz4v3NHSq8kV
         bgSpuZHmnuvqIB5s/4SeZXgZ6Jy7xmWPLfZXSBpbpbQ/2phv5OiLJHMdquoR0mmp8WPn
         If3OdOZ3dvM0txjNyi9gFenKyzK//T7qxVZQ0+1I8FDqfuyJx1DLUiz7B89WtUQZiraB
         /FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5toWmDsaqzdTqikBBGSzNd0+axCm73Prn37IDOcM4k=;
        b=ZSFVwOsbMEL674dIVwKtGp+0VYhhijn5TUGJqFBjsvNTfVp6ICtwIjzIIHWhWyvfsr
         oEIjqkCs4D8WdRo8w0MSushFo07yMPP49eSY33BAn0+yjef/2snYYbBoqbeP1I+OeIUy
         CZy+Fa/TEi5/ttq7FUamWPboI4ptxFpp96s9qj1tn5Rc54ZLoz8E44UIPiWNAyRKuYsu
         62utNu6gSZ0moMchy1Fym23XlZZV0AfHsFMLRvLXHyyVzzuPTCwnIlbnjZMrnI7+3Tqw
         iEfbRCh/JEUWGv6T8AdpMxNaVdtQYerSW00b2WaU9RgYBs+T7OUnpUf/myGPohihRmBI
         N3rw==
X-Gm-Message-State: AHPjjUg2oV0JPpk3ZeQ3H4ABkhlxUv5DtFcQQDNQPhY+owpKmCsBrXQB
        Ip+btXFmwhtKSIjCOuL/iBg=
X-Google-Smtp-Source: AOwi7QD8v+pT/moB7YBWXmx3UJRh+ObL6zUa+HvRFqb0CVVuD6jRZ1Kn89gvgI+H05eLpX3ymvp/CA==
X-Received: by 10.99.114.83 with SMTP id c19mr6952785pgn.221.1506327644137;
        Mon, 25 Sep 2017 01:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:43 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 2/5] branch: re-order function arguments to group related arguments
Date:   Mon, 25 Sep 2017 13:50:21 +0530
Message-Id: <20170925082024.2691-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ad-hoc patches to add new arguments to a function when needed
resulted in the related arguments not being close to each other.
This misleads the person reading the code to believe that there isn't
much relation between those arguments while it's not the case.

So, re-order the arguments to keep the related arguments close to each
other.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           | 2 +-
 branch.h           | 4 ++--
 builtin/branch.c   | 2 +-
 builtin/checkout.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 8d4360aa5..0ea105b55 100644
--- a/branch.c
+++ b/branch.c
@@ -229,7 +229,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head_ok,
+		   int force, int clobber_head_ok, int reflog,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
diff --git a/branch.h b/branch.h
index cb6411f84..a6740bb9f 100644
--- a/branch.h
+++ b/branch.h
@@ -24,8 +24,8 @@
  *     that start_name is a tracking branch for (if any).
  */
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog,
-		   int clobber_head_ok, int quiet, enum branch_track track);
+		   int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track);
 
 /*
  * Validates that the requested branch may be created, returning the
diff --git a/builtin/branch.c b/builtin/branch.c
index 355f9ef5d..62c311478 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-			      force, reflog, 0, quiet, track);
+			      force, 0, reflog, quiet, track);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5c202b7af..4ef7a47e1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -641,8 +641,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		else
 			create_branch(opts->new_branch, new->name,
 				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_log,
 				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_log,
 				      opts->quiet,
 				      opts->track);
 		new->name = opts->new_branch;
-- 
2.14.1.935.ge2b2bcd8a

