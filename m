Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D271F576
	for <e@80x24.org>; Sun, 11 Feb 2018 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeBKJnw (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 04:43:52 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46543 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 04:43:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id z79so2981968pff.13
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67CVJD6EbGSY74jSvLcyjcP4m6nwTkIC4D8Su6Mjay4=;
        b=m6dlNa1nZFAr3UM74nkIOzw1UJSNqp0L70WvA/vf3Ja3WykvY9U6dzNssskdWWPHsK
         0TaGTBAHW2KwdtdVYF4us16tbY2NRDVvXugsj6y07Y4ZIJvSyyYc1+4qOmyX9KrmbFxE
         Bblf3M8LS0/Ng700g/WoCZ01+9NG8Wh4gQZ5or1PXYgGcUfzs4d+IE5dLspd2vt/rQoP
         t7Zysi4ZStRhW+Mppuo6w2tLABaYSJezgTJHwVTWbry19PyZhWubwUhHvwUIGwRgqGui
         1lkpimMDpMDQzaknwSAem1pqAJi37R6PX+JVBHyaLXtk112ZJ6ITxWJ6OzBf/8w0O1om
         VjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67CVJD6EbGSY74jSvLcyjcP4m6nwTkIC4D8Su6Mjay4=;
        b=PJMVu9QJdzSpd3ZGPRwz+ygIsQLHkiugeKZIU0ay0OpkWiNaZT85wgLY7FubFvp7qY
         DT+0h4O7iYEnoXDX6wqNjt9T4VCPlndTCoDEdAAKTtG9w+0v0ii9huTURQOa2Gd3W3V/
         QgpwvuNZgSvQ7RvJw7geqpoqx+KImO9EgQfNOWtjQK/1lvmMq//OprdIq3fWPsQj7kKS
         D6XwE89Jy8bZgV1qjwbnNJu+SNPCCE3qRro7ZijSDuBaYJMZSIXfrexZt3kmvuZZz/rO
         Eq4xWNmwp6VwA4uHkoXMJDDG/qG3Ow1dyFT4hFh0AXwug0sHoT9C8w0n3qHkzy3DFDsr
         uMvQ==
X-Gm-Message-State: APf1xPBg5oYnT/TTGB0d2wd66rANtPag86vEOxqL8icoBr7CunHfF3J1
        3N4ym/q1u9uekw0M6hHYbwTKww==
X-Google-Smtp-Source: AH8x224Y5Am0Ae/Gg505Qz1kQOOgEaK+N5ZnREw20wU+vovAJPZKnTbPNR7AH8haba2prQeITDtETg==
X-Received: by 10.99.186.22 with SMTP id k22mr912352pgf.7.1518342230331;
        Sun, 11 Feb 2018 01:43:50 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v69sm19550567pfi.65.2018.02.11.01.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2018 01:43:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 11 Feb 2018 16:43:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/3] am: add --show-current-patch
Date:   Sun, 11 Feb 2018 16:43:26 +0700
Message-Id: <20180211094328.6157-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180211094328.6157-1-pclouds@gmail.com>
References: <20180131093051.15525-1-pclouds@gmail.com>
 <20180211094328.6157-1-pclouds@gmail.com>
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
 builtin/am.c                           | 32 ++++++++++++++++++++++----
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          |  5 ++++
 4 files changed, 39 insertions(+), 6 deletions(-)

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
index acfe9d3c8c..07abfb8f83 100644
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
@@ -2121,6 +2120,23 @@ static void am_abort(struct am_state *state)
 	am_destroy(state);
 }
 
+static int show_patch(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *patch_path;
+	int len;
+
+	patch_path = am_path(state, msgnum(state));
+	len = strbuf_read_file(&sb, patch_path, 0);
+	if (len < 0)
+		die_errno(_("failed to read '%s'"), patch_path);
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
@@ -2149,7 +2165,8 @@ enum resume_mode {
 	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
-	RESUME_ABORT
+	RESUME_ABORT,
+	RESUME_SHOW_PATCH
 };
 
 static int git_am_config(const char *k, const char *v, void *cb)
@@ -2171,6 +2188,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
 	int in_progress;
+	int ret = 0;
 
 	const char * const usage[] = {
 		N_("git am [<options>] [(<mbox> | <Maildir>)...]"),
@@ -2249,6 +2267,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_CMDMODE(0, "show-current-patch", &resume,
+			N_("show the patch being applied."),
+			RESUME_SHOW_PATCH),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2359,11 +2380,14 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.16.1.399.g632f88eed1

