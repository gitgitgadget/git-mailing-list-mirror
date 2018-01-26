Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489721F576
	for <e@80x24.org>; Fri, 26 Jan 2018 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeAZJzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 04:55:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37032 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeAZJzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 04:55:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id z17so6979799pgc.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 01:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+8mX3CP8vq6eHhLatrx2DcPknLibj3au+muTGUZsgk=;
        b=bCQcdOkAGioGdeL5BfzefvsLTDZyHAk0ORqcumnhhI7ofMF9KDtLl9d4gBPCfH8z8s
         mUYvLXs9yATOAysLz+vAmxEuGCy5shdRosiNKuqstbvl8yXw4sRwu4EaSvNGvEkcPhb5
         inVKYI9oGIqEBzAhUTt0fp6uhVo0gp2I2SGCt1zoSSqWe/DpEJbzCfjfhwyd/FLR5hm7
         2PwvolZWcxrhc+YJ0WQgU2qQJLbEv0gpJZ9HPsi6JAS5p9SUX+i4WLRrJBqojnp0H/ga
         4hL6zjwrR9WQwanOL9bapSY0beyu8vnjrcSyYLvuZFdYAigxlkT0w0W0Kl5B9Y3NB4D7
         2lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+8mX3CP8vq6eHhLatrx2DcPknLibj3au+muTGUZsgk=;
        b=Toa0J3sWFKKMVn28Z49swi92eD2UihSxUHLrh6wp6L374AJqibzRMwfnFr+WCqZzXD
         OPGWp602hzB7c532LGEeHLN3keCZgmWzP2fYPgmvjzDPIfiIR/AUhHrMW5hf68M8A3uE
         S0M5RzY9cgyIqQxF2DDg8Ew2ipaVymYHY4L4sb6KRSgLo4o6JDRdV49vey3fxaxWYrtw
         jOmAZfSxuYMAOGZZtNh3d0rabo69Dw9iCCsxKpHxnIVJVKdP/xsxb/bbY1yFrr5ppY4e
         fEF5ti3d5pv6uYlBr1PqRcGIfE+Fi+H4mKRZQRZ0r4BpuMCLRWtmaBbhjkZjli1fgvzf
         Yjfg==
X-Gm-Message-State: AKwxyteZ2MqH1f4/0B7MgqfhG/QC4aUPENGpDLs5+RPXazoPcrjzgiIa
        L9lLWOSAqoUUkwdqhRhufdGMuA==
X-Google-Smtp-Source: AH8x225husVBk6oSAMAmo/9y18kFoUzs4vkLVJX/RzH7tlMzlOZ66EhCnRCnXfkfDTtunW42xo8mCQ==
X-Received: by 10.98.231.11 with SMTP id s11mr18702951pfh.174.1516960531847;
        Fri, 26 Jan 2018 01:55:31 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id x17sm7303817pge.50.2018.01.26.01.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 01:55:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 26 Jan 2018 16:55:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] am: add --show-patch
Date:   Fri, 26 Jan 2018 16:55:19 +0700
Message-Id: <20180126095520.919-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180126095520.919-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pointing the user to $GIT_DIR/rebase-apply may encourage them to mess
around in there, which is not a good thing. With this, the user does
not have to keep the path around somewhere (because after a couple of
commands, the path may be out of scrollback buffer) when they need to
look at the patch. Bonus point for automatic pager.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-am.txt               |  5 ++++-
 builtin/am.c                           | 23 ++++++++++++++++++++---
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          |  5 +++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 12879e4029..724095e921 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort)
+'git am' (--continue | --skip | --abort | --show-patch)
 
 DESCRIPTION
 -----------
@@ -167,6 +167,9 @@ default.   You can use `--no-utf8` to override this.
 --abort::
 	Restore the original branch and abort the patching operation.
 
+--show-patch::
+	Show the patch being applied.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..aaaf32886a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1831,8 +1831,7 @@ static void am_run(struct am_state *state, int resume)
 			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
 
 			if (advice_amworkdir)
-				printf_ln(_("The copy of the patch that failed is found in: %s"),
-						am_path(state, "patch"));
+				printf_ln(_("Use 'git am --show-patch' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
@@ -2121,6 +2120,17 @@ static void am_abort(struct am_state *state)
 	am_destroy(state);
 }
 
+static void show_patch(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_read_file(&sb, am_path(state, msgnum(state)), 0) >= 0) {
+		setup_pager();
+		write_in_full(1, sb.buf, sb.len);
+	}
+	strbuf_release(&sb);
+}
+
 /**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
@@ -2149,7 +2159,8 @@ enum resume_mode {
 	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
-	RESUME_ABORT
+	RESUME_ABORT,
+	RESUME_SHOW_PATCH
 };
 
 static int git_am_config(const char *k, const char *v, void *cb)
@@ -2249,6 +2260,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_CMDMODE(0, "show-patch", &resume,
+			N_("show the patch being applied."),
+			RESUME_SHOW_PATCH),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2359,6 +2373,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	case RESUME_ABORT:
 		am_abort(&state);
 		break;
+	case RESUME_SHOW_PATCH:
+		show_patch(&state);
+		break;
 	default:
 		die("BUG: invalid resume value");
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..1e9105f6d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1077,7 +1077,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "--skip --continue --resolved --abort --show-patch"
 		return
 	fi
 	case "$cur" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 73b67b4280..eff6455f42 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -662,6 +662,11 @@ test_expect_success 'am pauses on conflict' '
 	test -d .git/rebase-apply
 '
 
+test_expect_success 'am --show-patch' '
+	git am --show-patch >actual.patch &&
+	test_cmp .git/rebase-apply/0001 actual.patch
+'
+
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-- 
2.16.1.205.g271f633410

