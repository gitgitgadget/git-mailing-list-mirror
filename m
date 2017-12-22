Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA681F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbeGKMmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:42:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45034 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbeGKMmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so18326368pfh.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=O+E74TwyTqKsNs/L/+oBXtL+KkghNZvulBvj3uiyGgQ=;
        b=pN+Bp0zUPgE5toSnIo9VKmaAQ9qhccguXrR4N0Uibtl6F/l5fMxYnoD5xtvn8GG9+Q
         kSdbqFGGlJO4UBiSBsePpSCSGT4OlBHwjcKXEQcaa0uOXQG5F1AzLUY4nh53w6NFuxaN
         Nraxokc2Jilifw9tb2Slo2ulC8/53Rh6V0uPkN8P0p/0eQ163Heuv2vg/rbP9ABmyImg
         wmKKAozQ4pAHDWMtQXX1Vu8Nse/dWe0ue0F0OhSa2N3LtizcHJZCx7opX5XeTdK/n/K5
         bsbMhPEvo7T7dhAJgCH6eIcu+katXxQMK0UC+p+r3930tALpBy9BAA8szceBIQfP4FfP
         +sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=O+E74TwyTqKsNs/L/+oBXtL+KkghNZvulBvj3uiyGgQ=;
        b=OGUcsiBZSkIp6nziwLkNKAjrSArl5LTIeq8X+AxUtyguAu8S7E8Z2/bZJJxNnnsGKO
         szfo33034rH2QQCLBmUn6fzdGpBFRWMGcm8b/Wanr16n341QHLP7U/njcJR76sPNgAZ8
         oPlPpn/b1A267h5e9MorFMz1nxt7ve15TbBScMmpb7WuKVDLlZSPYn3cYhPfN/wHJfdN
         ld2vYZrflcVjTnuXZN2GZSDUSMxwR9Ez9NXG8JX1rWvR64sFiW+o11TcEW8TCFDDtbgY
         cPXd1Sa4wAqO+514RO7eCTcKOBhooHUmiiYWkvD+Y9ky9fgZ66JFDQBNgOvT+wUjSmm7
         9jug==
X-Gm-Message-State: APt69E3XHieZLhjGZqP6l3fHyWXsknZo+SHdbYzMOufKB9Qcej2fQYjI
        A/S02vmTd1h3R0DkozOgfLPUlw==
X-Google-Smtp-Source: AAOMgpcPTmYvRh+6s+X0YTJsMQ2a5oRMvIYD9AR7tDL9acCYvScbkfo3d7bsGKQ7IfsZznuWIzmmvg==
X-Received: by 2002:a63:c60:: with SMTP id 32-v6mr26729029pgm.155.1531312692956;
        Wed, 11 Jul 2018 05:38:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id z4-v6sm19440847pfl.11.2018.07.11.05.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:38:12 -0700 (PDT)
Message-Id: <9e2c1fe83178f7047d8f2aacaa961381a4894081.1531312689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.8.git.gitgitgadget@gmail.com>
References: <pull.8.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Dec 2017 15:10:02 +0100
Subject: [PATCH 1/3] merge: allow reading the merge commit message from a file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is consistent with `git commit` which, like `git merge`, supports
passing the commit message via `-m <msg>` and, unlike `git merge` before
this patch, via `-F <file>`.

It is useful to allow this for scripted use, or for the upcoming patch
to allow (re-)creating octopus merges in `git rebase --rebase-merges`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-merge.txt | 10 +++++++++-
 builtin/merge.c             | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6a5c00e2c..537dca7fa 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
-	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
+	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
 'git merge' --abort
 'git merge' --continue
 
@@ -75,6 +75,14 @@ The 'git fmt-merge-msg' command can be
 used to give a good default for automated 'git merge'
 invocations. The automated message can include the branch description.
 
+-F <file>::
+--file=<file>::
+	Read the commit message to be used for the merge commit (in
+	case one is created).
++
+If `--log` is specified, a shortlog of the commits being merged
+will be appended to the specified message.
+
 --[no-]rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
diff --git a/builtin/merge.c b/builtin/merge.c
index 4a4c09496..b0e907751 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -111,6 +111,35 @@ static int option_parse_message(const struct option *opt,
 	return 0;
 }
 
+static int option_read_message(struct parse_opt_ctx_t *ctx,
+			       const struct option *opt, int unset)
+{
+	struct strbuf *buf = opt->value;
+	const char *arg;
+
+	if (unset)
+		BUG("-F cannot be negated");
+
+	if (ctx->opt) {
+		arg = ctx->opt;
+		ctx->opt = NULL;
+	} else if (ctx->argc > 1) {
+		ctx->argc--;
+		arg = *++ctx->argv;
+	} else
+		return opterror(opt, "requires a value", 0);
+
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	if (ctx->prefix && !is_absolute_path(arg))
+		arg = prefix_filename(ctx->prefix, arg);
+	if (strbuf_read_file(buf, arg, 0) < 0)
+		return error(_("could not read file '%s'"), arg);
+	have_message = 1;
+
+	return 0;
+}
+
 static struct strategy *get_strategy(const char *name)
 {
 	int i;
@@ -228,6 +257,9 @@ static struct option builtin_merge_options[] = {
 	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
 		N_("merge commit message (for a non-fast-forward merge)"),
 		option_parse_message),
+	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
+		N_("read message from file"), PARSE_OPT_NONEG,
+		(parse_opt_cb *) option_read_message },
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
-- 
gitgitgadget

