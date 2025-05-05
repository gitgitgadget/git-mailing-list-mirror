Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375D1F1921
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436727; cv=none; b=gLSwpJnm6+4CFVBRCLvV2MBDEgfqVhN3ny8Ca1reRIIOA+D2Xxoo3zuaZ8VO0WHR/ta9+1tOXe71CYDnr6DvLq8TJ5CZ5TdbTZr+Lwye1K6FmCrRXsl6NiJcXd5ScY9YPW4F5MWwqVW7hwMLJM/t3eB48e2XFuTv2bXxQjti5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436727; c=relaxed/simple;
	bh=bMp4zKsUusyDYKW623XwNmiRAzdqlnE9WjnxItzZyaY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MtZoVE785YLhTiAZLno7Estzug/MFHwCD1xCIl2ytfIHmIpHlo53W86NI05Bm02FU86zqMutR1KLgVsGvYX2y1DX0qqT8F4XKA9pGU8qA19caEVWcr7yZ9+6KcH0yvSO39lS1zVs42yRlH4+tNRsy+GBMp704tfQtVq8CAC9h4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/D634R9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/D634R9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso29297785e9.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436723; x=1747041523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrymH1mdOpLETtlNoAf47/iqBDcW8hB9x9sSTqnpy20=;
        b=J/D634R9KL3eRr0aaBHEevfITv8IiarqvKVMVdqGB46EhtneU3W159ZLfnt8O4AvwQ
         FB9YzyMZB9LGdR5EeUdsG/6FrrK9lZdcRV6HMQ+haT/Dse0J30L14QEF1F4itrrZcKGf
         ge0bqw3qujr4w9SlAne7PCq/3DBsTNiuR8smt2eedJxtioTmFL1Td2e5K6nhmeqD/eax
         D66n7i2EVdy3nmaL3qM+6zvsN6bL9ybOFgtOSu0lyVDYfihqzLdz4dsmvz6PLKRKvrGh
         oWhNq+X2u1J3CMitHdr8SyZ8Zv4i5pVUa/JqUAs1RyijCV7QoYLPAewEKoLPEpFqXUZW
         9lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436723; x=1747041523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrymH1mdOpLETtlNoAf47/iqBDcW8hB9x9sSTqnpy20=;
        b=GtWS74BSKzXnZxVTXEmxRLsKehLxrjb/nI8hLs7A8uUMo7jPgSEKuF78VVnbpgLt73
         X+3PfFyeNy/RW+d8h4JRLHqoiOzy7oHezSWlkOhpsyXlr96aw0QAf00ShJHVT3NufUcz
         fzBFPvnEKVl/rMOi33khcvycaszeR5qQIIqpa2c66xG7BYDCYFEqigrYpwjX+kGyTqpu
         XYb+54i80WSU1GC/JZqA6110h8XnWBGLBfd4tXtEXkZ3ojqtpfYw9rhsSUnpZjelqTuP
         tLUlXXZCui4Cruah27orP5E/3jLCo7omoXyFMKOnPBH81DN/PJtihqj5IsMSHU3xtQHA
         E3ow==
X-Gm-Message-State: AOJu0Yxy/79vvLP87BMlTR4mtQWjl9tWaxNZivLHRfrY9L7sY9++ZZlP
	srG5TUf0Y1XD1ZyI4WU+HJfdTcMbnkadwe7D0SsCo4QcvIt9673ri/vPwA==
X-Gm-Gg: ASbGncszWqSdT0sx3twB3tQEeMd3j7/D/F/d2QzkSVei6NZUAAPeSjBQYDPWxXmMhu6
	MwSBj8M+u+V4WsRVQVq8A9eOFP5Q9wffIbCZHk2qgQjkoM4sLGF/b0V3AUgUcKAiPUSAEmEIkk0
	ILeIkASsW6Y6StSwpa30gkFMmGpROqqZEafDnDa8GyDA+GGAaIqrh14j5EaaF/tVrha48Nm6tjy
	OrJCSmeuH2TXPmDzHTEtAYi4A3cDodh8G/CUDWVNJJvfkc0xQkcT2syO6GYchbCln8ut5bmqpEM
	hYKIU0ztaxHKY+sqkO/+OnT3BQqe5AJpBydijT7vkQ==
X-Google-Smtp-Source: AGHT+IEQCNqektLEToTUCwddGG1RRUpcHgZJvXAMQKTCUKgZC0gddHT0WNKTX9HvGAz8NCS+gmIAmg==
X-Received: by 2002:a05:600c:4e07:b0:441:b3f0:e5f6 with SMTP id 5b1f17b1804b1-441c49200e5mr44466925e9.25.1746436722783;
        Mon, 05 May 2025 02:18:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441bc23bc06sm106104095e9.24.2025.05.05.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:18:42 -0700 (PDT)
Message-Id: <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 09:18:39 +0000
Subject: [PATCH 3/3] add-interactive: add new "context" subcommand
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

This teaches `add/commit --interactive` a new "context" subcommand, which
changes the amount of context lines subsequent subcommands like "patch"
or "diff" generate in their diffs.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 Documentation/git-add.adoc | 10 ++++--
 add-interactive.c          | 72 +++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh | 36 ++++++++++++++++---
 3 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index e3a50706acd5..1ab98c9b876e 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -265,14 +265,15 @@ and type return, like this:
 ------------
     *** Commands ***
       1: status       2: update       3: revert       4: add untracked
-      5: patch        6: diff         7: quit         8: help
+      5: patch        6: diff         7: context      8: quit
+      9: help
     What now> 1
 ------------
 
 You also could say `s` or `sta` or `status` above as long as the
 choice is unique.
 
-The main command loop has 6 subcommands (plus help and quit).
+The main command loop has 7 subcommands (plus help and quit).
 
 status::
 
@@ -373,6 +374,11 @@ diff::
   This lets you review what will be committed (i.e. between
   `HEAD` and index).
 
+context::
+
+  This lets you change the amount of context lines shown in diffs that
+  the 'patch' and 'diff' subcommands generate.
+
 
 EDITING PATCHES
 ---------------
diff --git a/add-interactive.c b/add-interactive.c
index 1ea8eb711a60..42b1bb8c5b64 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -20,6 +20,8 @@
 #include "prompt.h"
 #include "tree.h"
 
+static void choose_prompt_help_context(struct add_i_state *s);
+
 static void init_color(struct repository *r, struct add_i_state *s,
 		       const char *section_and_slot, char *dst,
 		       const char *default_color)
@@ -259,7 +261,8 @@ static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		opts->print_item(i, selected ? selected[i] : 0, list->items + i,
 				 opts->print_item_data);
 
-		if ((opts->columns) && ((i + 1) % (opts->columns))) {
+		if (i < list->nr - 1 &&
+		    (opts->columns) && ((i + 1) % (opts->columns))) {
 			putchar('\t');
 			last_lf = 0;
 		}
@@ -1047,6 +1050,60 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int run_context(struct add_i_state *s, const struct pathspec *ps UNUSED,
+		       struct prefix_item_list *files UNUSED,
+		       struct list_and_choose_options *opts UNUSED)
+{
+	struct diff_options diffopts;
+	struct strbuf input = STRBUF_INIT;
+	int res = 0;
+
+	repo_diff_setup(s->r, &diffopts);
+
+	for (;;) {
+		int new_context;
+		char *endp;
+
+		strbuf_reset(&input);
+
+		color_fprintf(stdout, s->header_color, "  %s:", N_("Current"));
+		fprintf(stdout, " %i\n", s->context == -1 ?
+			diffopts.context : s->context);
+
+		color_fprintf(stdout, s->prompt_color, "%s", N_("Change context"));
+		fputs("> ", stdout);
+		fflush(stdout);
+
+		if (git_read_line_interactively(&input) == EOF) {
+			putchar('\n');
+			break;
+		}
+
+		if (!input.len)
+			break;
+
+		if (!strcmp(input.buf, "?")) {
+			choose_prompt_help_context(s);
+			continue;
+		}
+
+		new_context = strtol(input.buf, &endp, 10);
+		if (*endp) {
+			color_fprintf_ln(stderr, s->error_color,
+				_("Context must be a numerical value"));
+			continue;
+		}
+
+		s->context = new_context;
+
+		break;
+	}
+
+	strbuf_release(&input);
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *ps UNUSED,
 		    struct prefix_item_list *files UNUSED,
 		    struct list_and_choose_options *opts UNUSED)
@@ -1061,6 +1118,8 @@ static int run_help(struct add_i_state *s, const struct pathspec *ps UNUSED,
 			 _("pick hunks and update selectively"));
 	color_fprintf_ln(stdout, s->help_color, "diff          - %s",
 			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, s->help_color, "context       - %s",
+			 _("change how many context lines diffs are generated with"));
 	color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
 			 _("add contents of untracked files to the staged set of changes"));
 
@@ -1087,6 +1146,16 @@ static void choose_prompt_help(struct add_i_state *s)
 			 _("(empty) finish selecting"));
 }
 
+static void choose_prompt_help_context(struct add_i_state *s)
+{
+	color_fprintf_ln(stdout, s->help_color, "%s",
+			 _("Prompt help:"));
+	color_fprintf_ln(stdout, s->help_color, "<n>        - %s",
+			 _("specify new context lines amount"));
+	color_fprintf_ln(stdout, s->help_color, "           - %s",
+			 _("(empty) finish selecting"));
+}
+
 typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
 			 struct prefix_item_list *files,
 			 struct list_and_choose_options *opts);
@@ -1147,6 +1216,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps,
 		{ "add untracked", run_add_untracked },
 		{ "patch", run_patch },
 		{ "diff", run_diff },
+		{ "context", run_context },
 		{ "quit", NULL },
 		{ "help", run_help },
 	};
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b8a05d95f3f1..9dcbc07d5876 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -758,16 +758,19 @@ test_expect_success 'colors can be overridden' '
 
 	<RED>*** Commands ***<RESET>
 	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
-	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>c<RESET>ontext	  8: <YELLOW>q<RESET>uit
+	  9: <YELLOW>h<RESET>elp
 	<YELLOW>What now<RESET>> <GREEN>status        - show paths with changes<RESET>
 	<GREEN>update        - add working tree state to the staged set of changes<RESET>
 	<GREEN>revert        - revert staged set of changes back to the HEAD version<RESET>
 	<GREEN>patch         - pick hunks and update selectively<RESET>
 	<GREEN>diff          - view diff between HEAD and index<RESET>
+	<GREEN>context       - change how many context lines diffs are generated with<RESET>
 	<GREEN>add untracked - add contents of untracked files to the staged set of changes<RESET>
 	<RED>*** Commands ***<RESET>
 	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
-	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>c<RESET>ontext	  8: <YELLOW>q<RESET>uit
+	  9: <YELLOW>h<RESET>elp
 	<YELLOW>What now<RESET>> Bye.
 	EOF
 	test_cmp expect actual &&
@@ -831,7 +834,8 @@ test_expect_success 'brackets appear without color' '
 	|
 	|*** Commands ***
 	|  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
-	|  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
+	|  5: [p]atch	  6: [d]iff	  7: [c]ontext	  8: [q]uit
+	|  9: [h]elp
 	|What now> Bye.
 	EOF
 
@@ -1172,16 +1176,19 @@ test_expect_success 'show help from add--helper' '
 
 	<BOLD>*** Commands ***<RESET>
 	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
-	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>c<RESET>ontext	  8: <BOLD;BLUE>q<RESET>uit
+	  9: <BOLD;BLUE>h<RESET>elp
 	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
 	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
 	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
 	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
 	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
+	<BOLD;RED>context       - change how many context lines diffs are generated with<RESET>
 	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
 	<BOLD>*** Commands ***<RESET>
 	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
-	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>c<RESET>ontext	  8: <BOLD;BLUE>q<RESET>uit
+	  9: <BOLD;BLUE>h<RESET>elp
 	<BOLD;BLUE>What now<RESET>>$SP
 	Bye.
 	EOF
@@ -1230,4 +1237,23 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 	test_cmp expect actual
 '
 
+test_expect_success 'change context works' '
+	git reset --hard &&
+	cat >template <<-\EOF &&
+	firstline
+	preline
+	TARGET
+	postline
+	lastline
+	EOF
+	sed "/TARGET/d" >x <template &&
+	git update-index --add x &&
+	git commit -m initial &&
+	sed "s/TARGET/ADDED/" >x <template &&
+	test_write_lines p 1 | git add -i >output &&
+	grep firstline output &&
+	test_write_lines c 0 p 1 | git add -i >output &&
+	! grep firstline output
+'
+
 test_done
-- 
gitgitgadget
