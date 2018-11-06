Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437AD1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbeKGCm7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 21:42:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40713 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389386AbeKGCm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 21:42:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so4445589lfe.7
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEt2wqrw9CdVDDjndolyHMGJVbSgd3rtWDpnVIn2GAE=;
        b=HzDN6rF1gRGv/onWJCqAIzZ71xWyZ9VzkUY9ZaVcXkYjZ3NBJbZQ/aj4YMVR3hwaOd
         5AoyGsZwXxf/sjyubZ8UUVsDu/kevfmu2G4hdyemyrLvNJjvf45//a7hwIPUUPSD/e+C
         PnAYWehqUTGKvPHd99s+i2y0kQRJVYrSGbZa9faV0ycWbmetHn1jEFvYtMQxAWiezWP+
         eSig38Gt/jILq1K6O5v7t5w5jPEdMfWq4hBSIc1atr59Z/nkuAKuiE3erYgPzATW2x2s
         eX6FsZ10KZNQVm3uUA+gBuFtNZB3zi9Oa0Nhn4Xy6ByEHE+cssuh0rv9D0NvwohLWglT
         Y0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEt2wqrw9CdVDDjndolyHMGJVbSgd3rtWDpnVIn2GAE=;
        b=TzhqhbMTgyt73b/DrtYCyW2oUc34lQXY6fyVAkDdPSsrXhs1AZUxbFS+rb5yN1T2U7
         jFJfcFUquP0Ysqrd03wFchAtNuvRCMX5iFCiwQ0t4/EfRJFO5zE/f82UzjXgIPy2k53H
         wdXEq0+i+VDzZzvhdUZEaRSuE4IhfXfDruT2wcCV551Q46Q5rCD7zPyUHDgJTjVDXy7s
         bjXYNsDfY1RFcl2xA6yeKNdXg82kbig1wabl0jGlE4JobCU8Rf44WqhlUBXX2vOJZrnC
         bdCW22ZUwKm5xoYFjFF18OKTTG8uGXrHk3/X9rOLFyxu/pOKtagRPH1Ug/DsOOnrOYz+
         VpKQ==
X-Gm-Message-State: AGRZ1gKhOG6kW8y6f9oHSi8kTeC5eMkk3t/9RL/euSRIPK9oPS1h2A8n
        HCXw6tBGE0GQCwtrQZvuROU=
X-Google-Smtp-Source: AJdET5dCHvCxLWrA/sQmSlPp93hgRb3yuaz3fF/03H+ISDIBiuDIeGp4QC6QzNyl2ZLTK5e2r1WPHA==
X-Received: by 2002:a19:6514:: with SMTP id z20mr8081243lfb.31.1541524603108;
        Tue, 06 Nov 2018 09:16:43 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a9sm4847286lfi.57.2018.11.06.09.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:16:42 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        andals@crustytoothpaste.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Subject: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
Date:   Tue,  6 Nov 2018 18:16:37 +0100
Message-Id: <20181106171637.15562-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181104181026.8451-1-pclouds@gmail.com>
References: <20181104181026.8451-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK here is a less constroversal attempt to add new trailers. Instead
of changing the default behavior (which could be done incrementally
later), this patch simply adds a new option --append-trailer to revert
and cherry-pick.

Both will show either

    Reverts: <commit>[~<num>]

or

    Cherry-picked-from: <commit>[~<num>]

--append-trailer could be added to more commands (e.g. merge) that
generate commit messages if they have something for machine
consumption.

After this, perhaps we could have a config key to turn this on by
default (for revert; for cherry-pick it will turn off "-x" too). Then
after a couple releases, the we got good reception, we'll make it
default?

No tests, no proper commit message since I think we're still going to
discuss a bit more before settling down.

PS. maybe --append-trailer is too generic? We have --signoff which is
also a trailer. But that one carries more weights than just "machine
generated tags".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-cherry-pick.txt |  6 +++++
 Documentation/git-revert.txt      |  6 +++++
 builtin/revert.c                  |  7 ++++++
 sequencer.c                       | 39 +++++++++++++++++++++++++++----
 sequencer.h                       |  1 +
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..b5dff29ead 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -102,6 +102,12 @@ effect to your index in a row.
 	Add Signed-off-by line at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
+--append-trailer::
+	When recording a commit, append a "Cherry-picked-from:" line
+	with object name of the cherry-picked commit. If a merge is
+	cherry-picked with `-m`, the extended SHA-1 syntax is used
+	to indicate the side of the merge to be cherry-picked.
+
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..e08010b200 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -91,6 +91,12 @@ effect to your index in a row.
 	Add Signed-off-by line at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
+--append-trailer::
+	When recording a commit, append a "Cherry-picked-from:" line
+	with object name of the cherry-picked commit. If a merge is
+	cherry-picked with `-m`, the extended SHA-1 syntax is used
+	to indicate the side of the merge to be cherry-picked.
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index c93393c89b..3bd8f57b90 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -119,6 +119,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
+			OPT_BOOL(0, "append-trailer", &opts->append_trailer, N_("record cherry picked commit as trailer")),
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
@@ -126,6 +127,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
+	} else if (opts->action == REPLAY_REVERT) {
+		struct option cp_extra[] = {
+			OPT_BOOL(0, "append-trailer", &opts->append_trailer, N_("record reverted commit as trailer")),
+			OPT_END(),
+		};
+		options = parse_options_concat(options, cp_extra);
 	}
 
 	argc = parse_options(argc, argv, NULL, options, usage_str,
diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..e8fa307109 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -911,7 +911,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if ((flags & EDIT_MSG))
 		argv_array_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
-		 !opts->signoff && !opts->record_origin &&
+		 !opts->signoff && !opts->record_origin && !opts->append_trailer &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
@@ -1669,7 +1669,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res, unborn = 0, allow, parent_id = -1;
 
 	if (opts->no_commit) {
 		/*
@@ -1716,6 +1716,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
+		parent_id = cnt;
 	} else if (0 < opts->mainline)
 		return error(_("mainline was specified but commit %s is not a merge."),
 			oid_to_hex(&commit->object.oid));
@@ -1768,6 +1769,17 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
 		}
 		strbuf_addstr(&msgbuf, ".\n");
+
+		if (opts->append_trailer) {
+			strbuf_addstr(&msgbuf, "\n");
+			if (parent_id != -1)
+				strbuf_addf(&msgbuf, "Reverts: %s~%d\n",
+					    oid_to_hex(&commit->object.oid),
+					    parent_id);
+			else
+				strbuf_addf(&msgbuf, "Reverts: %s\n",
+					    oid_to_hex(&commit->object.oid));
+		}
 	} else {
 		const char *p;
 
@@ -1780,14 +1792,28 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		if (find_commit_subject(msg.message, &p))
 			strbuf_addstr(&msgbuf, p);
 
-		if (opts->record_origin) {
+		if (opts->record_origin || opts->append_trailer) {
 			strbuf_complete_line(&msgbuf);
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
+		}
+
+		if (opts->record_origin) {
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
+		if (opts->append_trailer) {
+			if (opts->record_origin)
+				strbuf_addstr(&msgbuf, "\n");
+			if (parent_id != -1)
+				strbuf_addf(&msgbuf, "Cherry-picked-from: %s~%d\n",
+					    oid_to_hex(&commit->object.oid),
+					    parent_id);
+			else
+				strbuf_addf(&msgbuf, "Cherry-picked-from: %s\n",
+					    oid_to_hex(&commit->object.oid));
+		}
 		if (!is_fixup(command))
 			author = get_author(msg.message);
 	}
@@ -2227,6 +2253,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
 		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.append-trailer"))
+		opts->append_trailer = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
@@ -2618,6 +2646,8 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
+	if (opts->append_trailer)
+		res |= git_config_set_in_file_gently(opts_file, "options.append-trailer", "true");
 	if (opts->allow_ff)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
@@ -3432,7 +3462,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+			 opts->record_origin || opts->append_trailer ||
+			 opts->edit));
 	if (read_and_refresh_cache(opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 660cff5050..7d7c1fe6b4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -31,6 +31,7 @@ struct replay_opts {
 	/* Boolean options */
 	int edit;
 	int record_origin;
+	int append_trailer;
 	int no_commit;
 	int signoff;
 	int allow_ff;
-- 
2.19.1.1005.gac84295441

