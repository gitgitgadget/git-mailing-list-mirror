Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEEE20248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfDJRh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbfDJRh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d13so2793794edr.5
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wGECj64P2K9dvBshKB4z1BenSdgxSXocr8ywWHrl11g=;
        b=Apm0tz9mfRwtoWlPK+ODvcC5APO/DklaHWytgPJ2Fg56VqLm6mapmX7/vcilESOM/F
         JClLoAEVPvjUT8aYgQJtq+CXopflcOQVMMBYKukrgJjSg+23y9IfCMKx8Rh5a5k5j4Zv
         PyruueB8qLJuJ57U0CLdPbc0lLbZ+ivFB5m+gZjuFODgiXbOEqB6UpWI6Op9xYdJXcaN
         b+VfqPqMsERxxurSl1gXzMgjseimT/9NJMkOY5rGjlXtlZMwDTwZPu1m5RfEjfJU1EKc
         lIM3JJ8uS2lhSMJA4yrk/PMUQ2StvSn1Fy1UlK1GLOp3gTDFWTCDpuRW3BpL8UGHTBAb
         NUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wGECj64P2K9dvBshKB4z1BenSdgxSXocr8ywWHrl11g=;
        b=AOq7FuaJJkBjxpNEpALxYgG1xYVMtwARAenDZLgIqyxeu9gt+A2JVNar5cPuQAGFgJ
         Ivy2U3NXb6sdMQ0qx+sxM8lTSb1bjMb1eBXhEhfFKXiXo7nF6EvaSOS8qLrCV7JeV/+1
         coajmqOD3HBmBruCRPDQ9kNMOtpUZysquCT3USBo2YEUZQpA8SrjX4VsFUAV1g94dYHM
         YGzEYymgciGi4B2wg5QCTstoLAfdyKS3iW4LHLiecb7mbBLizkCnxtKcaMAuTzCNs7lg
         Fm9+WsY63ZtZ1qZHp8zfcvyW1Y8xOzidk6BKwraC9tuiLvUlco/wTc2EUpRL/uCE7jZm
         i2xg==
X-Gm-Message-State: APjAAAVwd8wdV7ro5Xhs+jUIZbIvBwdJuCyLDLHfnL16IWHWHL4MH3Xw
        Z+nV5r8J+pKljp3iCfTCcEp/o86T
X-Google-Smtp-Source: APXvYqwNkQOu7x/bjxJshy1r0f20DOnIm0YCBDC3m62UivA5lyFnGySfhdelETMOg6XzRegVSOlLYA==
X-Received: by 2002:a50:978e:: with SMTP id e14mr27798221edb.217.1554917875530;
        Wed, 10 Apr 2019 10:37:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f32sm10757585edf.59.2019.04.10.10.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:55 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:55 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:43 GMT
Message-Id: <93b3151b6c8abeeab0674919badae72e39eea68d.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/11] built-in add -i: implement the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The reason why we did not start with the main loop to begin with is that
it is the first user of `list_and_choose()`, which uses the `list()`
function that we conveniently introduced for use by the `status`
command.

Apart from the "and choose" part, there are more differences between the
way the `status` command calls the `list_and_choose()` function in the
Perl version of `git add -i` compared to the other callers of said
function. The most important ones:

- The list is not only shown, but the user is also asked to make a
  choice, possibly selecting multiple entries.

- The list of items is prefixed with a marker indicating what items have
  been selected, if multi-selection is allowed.

- Initially, for each item a unique prefix (if there exists any within
  the given parameters) is determined, and shown in the list, and
  accepted as a shortcut for the selection.

These features will be implemented later, except the part where the user
can choose a command. At this stage, though, the built-in `git add -i`
still only supports the `status` command, with the remaining commands to
follow over the course of the next commits.

In addition, we also modify `list()` to support displaying the commands
in columns, even if there is currently only one.

The Perl script `git-add--interactive.perl` mixed the purposes of the
"list" and the "and choose" part into the same function. In the C
version, we will keep them separate instead, calling the `list()`
function from the `list_and_choose()` function.

Note that we only have a prompt ending in a single ">" at this stage;
later commits will add commands that display a double ">>" to indicate
that the user is in a different loop than the main one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 122 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 79adc58321..c8bd62369e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -58,6 +58,7 @@ struct item {
 };
 
 struct list_options {
+	int columns;
 	const char *header;
 	void (*print_item)(int i, struct item *item, void *print_item_data);
 	void *print_item_data;
@@ -65,7 +66,7 @@ struct list_options {
 
 static void list(struct item **list, size_t nr, struct list_options *opts)
 {
-	int i;
+	int i, last_lf = 0;
 
 	if (!nr)
 		return;
@@ -77,8 +78,90 @@ static void list(struct item **list, size_t nr, struct list_options *opts)
 
 	for (i = 0; i < nr; i++) {
 		opts->print_item(i, list[i], opts->print_item_data);
+
+		if ((opts->columns) && ((i + 1) % (opts->columns))) {
+			putchar('\t');
+			last_lf = 0;
+		}
+		else {
+			putchar('\n');
+			last_lf = 1;
+		}
+	}
+
+	if (!last_lf)
 		putchar('\n');
+}
+struct list_and_choose_options {
+	struct list_options list_opts;
+
+	const char *prompt;
+};
+
+/*
+ * Returns the selected index.
+ */
+static ssize_t list_and_choose(struct item **items, size_t nr,
+			       struct list_and_choose_options *opts)
+{
+	struct strbuf input = STRBUF_INIT;
+	ssize_t res = -1;
+
+	for (;;) {
+		char *p, *endp;
+
+		strbuf_reset(&input);
+
+		list(items, nr, &opts->list_opts);
+
+		printf("%s%s", opts->prompt, "> ");
+		fflush(stdout);
+
+		if (strbuf_getline(&input, stdin) == EOF) {
+			putchar('\n');
+			res = -2;
+			break;
+		}
+		strbuf_trim(&input);
+
+		if (!input.len)
+			break;
+
+		p = input.buf;
+		for (;;) {
+			size_t sep = strcspn(p, " \t\r\n,");
+			ssize_t index = -1;
+
+			if (!sep) {
+				if (!*p)
+					break;
+				p++;
+				continue;
+			}
+
+			if (isdigit(*p)) {
+				index = strtoul(p, &endp, 10) - 1;
+				if (endp != p + sep)
+					index = -1;
+			}
+
+			p[sep] = '\0';
+			if (index < 0 || index >= nr)
+				printf(_("Huh (%s)?\n"), p);
+			else {
+				res = index;
+				break;
+			}
+
+			p += sep + 1;
+		}
+
+		if (res >= 0)
+			break;
 	}
+
+	strbuf_release(&input);
+	return res;
 }
 
 struct adddel {
@@ -292,16 +375,39 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 	return 0;
 }
 
+static void print_command_item(int i, struct item *item,
+			       void *print_command_item_data)
+{
+	printf(" %2d: %s", i + 1, item->name);
+}
+
+struct command_item {
+	struct item item;
+	int (*command)(struct repository *r, const struct pathspec *ps,
+		       struct file_list *files, struct list_options *opts);
+};
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
+	struct list_and_choose_options main_loop_opts = {
+		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		N_("What now")
+	};
+	struct command_item
+		status = { { "status" }, run_status };
+	struct command_item *commands[] = {
+		&status
+	};
+
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	struct list_options opts = {
-		NULL, print_file_item, &print_file_item_data
+		0, NULL, print_file_item, &print_file_item_data
 	};
 	struct strbuf header = STRBUF_INIT;
 	struct file_list files = { NULL };
+	ssize_t i;
 	int res = 0;
 
 	strbuf_addstr(&header, "      ");
@@ -313,6 +419,18 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	if (run_status(r, ps, &files, &opts) < 0)
 		res = -1;
 
+	for (;;) {
+		i = list_and_choose((struct item **)commands,
+				    ARRAY_SIZE(commands), &main_loop_opts);
+		if (i < -1) {
+			printf(_("Bye.\n"));
+			res = 0;
+			break;
+		}
+		if (i >= 0)
+			res = commands[i]->command(r, ps, &files, &opts);
+	}
+
 	release_file_list(&files);
 	strbuf_release(&print_file_item_data.buf);
 	strbuf_release(&print_file_item_data.index);
-- 
gitgitgadget

