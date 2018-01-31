Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4F61F576
	for <e@80x24.org>; Wed, 31 Jan 2018 09:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeAaJbK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 04:31:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40370 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeAaJbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 04:31:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id g16so9580695pgn.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeQ9xejLH17EXrz3KIo26XU276MmsfUgIaE3A45zPV4=;
        b=suDID7H0UOex3iKHkv+io8x10Ys8QrjnaBahLcsjDSruiwXDRoQSR5GMEAGC2PkSsM
         k6HXVOZCI36v4czxrxEnyctTp/mpAHWFEzjvVlpBQH++pEDn607Qfw1a6pDUqEOH8Wrb
         U/w3OC1AgQ2soaxhtAx3erfMfyF2Ax4Qfp/YZsKFJs/r3Rgd2/IuPzy2ipBqgz9LsckP
         +OkiKdaD2dPhTiboi0zc+ym1EC+CS4hg0pgk0K0m0Vl4RlSBG7CHeb028HZTy/ymQRlz
         7zvop9nHRRl4kSiCi5ZhEve0iZTM2ZZfs+evXAMQ4/xKNrXx1q9XbAp1WG+gs7HCel9P
         9OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeQ9xejLH17EXrz3KIo26XU276MmsfUgIaE3A45zPV4=;
        b=J0Ekl/xChhDef5tJbuomODqg3Gt8lEwyWKX/8iDkaECV19uebWVSMsHFQPTySEnILT
         1d4iq1OyWbPhnsVOOyrDIYRj1LkD49QH7u8p4U/qHlDo3bbVqZP2y6EbHC5axGVbRBGX
         MwGvjz9BwnxB42E2lfY/+IJJNfmhQvBGF3c4CCJ6CplcBgvX4Onk2FcHkPOJOCwDjxET
         eVb/YERPgR37XbRMuDoB+A/9rVHZxse7BHlIcx5rNytraCu1/WLWoX8/0o3sVxd3o8Q7
         ksWiqL8VpC3nZVVCehGyPuB2E05Ljp2ZUrad6Y7xtrwWwaD967jtyQJFQKXq6VTdrcY8
         xVIw==
X-Gm-Message-State: AKwxytfe1WWTcpOscoGnCnBCLihuK7dfQcrgdRzjvny9VUOB4l3L4uic
        LSHcCLnVxoCXI6mqjhwKU92zFA==
X-Google-Smtp-Source: AH8x225Yn91sK7etAfW5kDu7Dg4kPVPc4UDf1B4iqkLa36/EI5dt100WfQ61qdvW18HutE+aMluFsw==
X-Received: by 10.101.90.71 with SMTP id z7mr26046845pgs.15.1517391066369;
        Wed, 31 Jan 2018 01:31:06 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id b81sm43819278pfm.25.2018.01.31.01.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:31:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 16:31:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/3] am: add --show-current-patch
Date:   Wed, 31 Jan 2018 16:30:48 +0700
Message-Id: <20180131093051.15525-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131093051.15525-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
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
look at the patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-am.txt               |  6 ++++-
 builtin/am.c                           | 31 ++++++++++++++++++++++----
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          |  5 +++++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 12879e4029..0f426ae874 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort)
+'git am' (--continue | --skip | --abort | --show-current-patch)
 
 DESCRIPTION
 -----------
@@ -167,6 +167,10 @@ default.   You can use `--no-utf8` to override this.
 --abort::
 	Restore the original branch and abort the patching operation.
 
+--show-current-patch::
+	Show the patch being applied when "git am" is stopped because
+	of conflicts.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..5eff1a648d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1831,8 +1831,7 @@ static void am_run(struct am_state *state, int resume)
 			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
 
 			if (advice_amworkdir)
-				printf_ln(_("The copy of the patch that failed is found in: %s"),
-						am_path(state, "patch"));
+				printf_ln(_("Use 'git am --show-current-patch' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
@@ -2121,6 +2120,22 @@ static void am_abort(struct am_state *state)
 	am_destroy(state);
 }
 
+static int show_patch(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int len;
+
+	len = strbuf_read_file(&sb, am_path(state, msgnum(state)), 0);
+	if (len < 0)
+		die_errno(_("failed to read '%s'"),
+			  am_path(state, msgnum(state)));
+
+	setup_pager();
+	write_in_full(1, sb.buf, sb.len);
+	strbuf_release(&sb);
+	return 0;
+}
+
 /**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
@@ -2149,7 +2164,8 @@ enum resume_mode {
 	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
-	RESUME_ABORT
+	RESUME_ABORT,
+	RESUME_SHOW_PATCH
 };
 
 static int git_am_config(const char *k, const char *v, void *cb)
@@ -2171,6 +2187,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 	int in_progress;
+	int ret = 0;
 
 	const char * const usage[] = {
 		N_("git am [<options>] [(<mbox> | <Maildir>)...]"),
@@ -2249,6 +2266,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_CMDMODE(0, "show-current-patch", &resume,
+			N_("show the patch being applied."),
+			RESUME_SHOW_PATCH),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2359,11 +2379,14 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	case RESUME_ABORT:
 		am_abort(&state);
 		break;
+	case RESUME_SHOW_PATCH:
+		ret = show_patch(&state);
+		break;
 	default:
 		die("BUG: invalid resume value");
 	}
 
 	am_state_release(&state);
 
-	return 0;
+	return ret;
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..56ca445fa8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1077,7 +1077,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "--skip --continue --resolved --abort --show-current-patch"
 		return
 	fi
 	case "$cur" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 73b67b4280..23abf42abc 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -662,6 +662,11 @@ test_expect_success 'am pauses on conflict' '
 	test -d .git/rebase-apply
 '
 
+test_expect_success 'am --show-current-patch' '
+	git am --show-current-patch >actual.patch &&
+	test_cmp .git/rebase-apply/0001 actual.patch
+'
+
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-- 
2.16.1.205.g271f633410

