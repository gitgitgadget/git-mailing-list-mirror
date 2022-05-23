Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66AC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 06:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiEWGNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiEWGMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 02:12:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54114A919
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c9-20020a7bc009000000b0039750ec5774so370799wmb.5
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cu3LSmtFKYiIGjQdBfiX8r8ZWzt3fGjI7m9YLy1lMgA=;
        b=Af7ZkLJOOba/6esRVU/jW+Clh0PkDP1ZpkeesTbTR9qZ19TXP28kdCN3ByNCNqxTV2
         +DH81qKdz3RAJf2CjCetJqTzwvNuANjG0ghlaxh+5AHuSC2UJjKW4RfGCl5GbhaHUmOU
         SetwDwDePAgGDIaYuySglOU87XFo/0YC/rbKFZ23xk3MxghmehNgdU+BvmhZeucf42Ud
         8lW68e3uhvvMF32eQ/PQhsQaHvygB0WNoc3GoAkh0h7OqoVkG8cHEeK89LCRkWWvd8Tu
         o9akNt5RVX3CdjdPo4wVCdb/dZ3sM1l3xShkjK0iHEqGu5elb4b2Oh6x9FqrxKbI1hcr
         2+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cu3LSmtFKYiIGjQdBfiX8r8ZWzt3fGjI7m9YLy1lMgA=;
        b=oy20DzYDjhLOZLM2zv+5v2f+Ha5gONHPXggqWEEUxZSmysOKRP7k9hvZjMGYoJsiPH
         aum+k4ypZz/UcRHxbj4Ztcermxpogaiu+APxdd2DDjHfArKUE0VMeb5wgfJgt8Ko29LA
         IDlOofLlv6CruItingpyLsZygO+tGuP1HpYhEkdAc5DDdgBEFgGfsmefYFawKi43G9UU
         lN1oFmsAIr5c3IoNhwnOXLez5+LTQupQ6mJjVFV8k5JYJtQ7oRuYbcVNuZXamjhgv1XN
         xhNDw27kx7pdvXhckUyzI+wXu617eKS+pH8M/HuQiYG/XT3wikJjZrGd+WavKTM7Uh6z
         zpxQ==
X-Gm-Message-State: AOAM533KAkPSZ1s0lNfugOiR2fbH78gE//GbpHKSd1EH6/TBJ9bGT3e9
        lay+IJ+zmsJ3UTlZV46UDILVuf32+UE=
X-Google-Smtp-Source: ABdhPJzurTEhKt7Xm8kLODlNw0adpYpVXrV81/QloFlUQbH3Gj1SEW1/I0/NIw4a5+3jo++aTqKPFw==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr19394192wmi.67.1653286347819;
        Sun, 22 May 2022 23:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020adfa507000000b0020d02262664sm8992405wrb.25.2022.05.22.23.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:12:27 -0700 (PDT)
Message-Id: <13bc75a2b0510f55e9a73852838b3b11683f13a2.1653286345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
        <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 06:12:24 +0000
Subject: [PATCH v2 1/2] add-menu: added add-menu to lib objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein96@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nadav Goldstein <nadav.goldstein96@gmail.com>

added to the lib objects the add menu module which is
simply extracted functions from clear.c
(which in the next commit will be removed and instead
clear will use the outsourced functions).

Signed-off-by: Nadav Goldstein <nadav.goldstein96@gmail.com>
---
 Makefile   |   1 +
 add-menu.c | 339 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 add-menu.h |  51 ++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 add-menu.c
 create mode 100644 add-menu.h

diff --git a/Makefile b/Makefile
index f8bccfab5e9..60ed7a5e1e0 100644
--- a/Makefile
+++ b/Makefile
@@ -871,6 +871,7 @@ LIB_H = $(FOUND_H_SOURCES)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
+LIB_OBJS += add-menu.o
 LIB_OBJS += add-patch.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
diff --git a/add-menu.c b/add-menu.c
new file mode 100644
index 00000000000..6a1c125d113
--- /dev/null
+++ b/add-menu.c
@@ -0,0 +1,339 @@
+#include <stdio.h>
+#include "builtin.h"
+#include "add-menu.h"
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "quote.h"
+#include "column.h"
+#include "color.h"
+#include "pathspec.h"
+#include "help.h"
+#include "prompt.h"
+
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
+	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
+	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
+	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
+	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
+	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
+};
+
+
+static const char *clean_get_color(enum color_clean ix)
+{
+	if (want_color(clean_use_color))
+		return clean_colors[ix];
+	return "";
+}
+
+static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
+{
+	struct menu_item *menu_item;
+	struct string_list_item *string_list_item;
+	int i, len, found = 0;
+
+	len = strlen(choice);
+	switch (menu_stuff->type) {
+	default:
+		die("Bad type of menu_stuff when parse choice");
+	case MENU_STUFF_TYPE_MENU_ITEM:
+
+		menu_item = (struct menu_item *)menu_stuff->stuff;
+		for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
+			if (len == 1 && *choice == menu_item->hotkey) {
+				found = i + 1;
+				break;
+			}
+			if (!strncasecmp(choice, menu_item->title, len)) {
+				if (found) {
+					if (len == 1) {
+						/* continue for hotkey matching */
+						found = -1;
+					} else {
+						found = 0;
+						break;
+					}
+				} else {
+					found = i + 1;
+				}
+			}
+		}
+		break;
+	case MENU_STUFF_TYPE_STRING_LIST:
+		string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
+		for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
+			if (!strncasecmp(choice, string_list_item->string, len)) {
+				if (found) {
+					found = 0;
+					break;
+				}
+				found = i + 1;
+			}
+		}
+		break;
+	}
+	return found;
+}
+
+static int parse_choice(struct menu_stuff *menu_stuff,
+			int is_single,
+			struct strbuf input,
+			int **chosen)
+{
+	struct strbuf **choice_list, **ptr;
+	int nr = 0;
+	int i;
+
+	if (is_single) {
+		choice_list = strbuf_split_max(&input, '\n', 0);
+	} else {
+		char *p = input.buf;
+		do {
+			if (*p == ',')
+				*p = ' ';
+		} while (*p++);
+		choice_list = strbuf_split_max(&input, ' ', 0);
+	}
+
+	for (ptr = choice_list; *ptr; ptr++) {
+		char *p;
+		int choose = 1;
+		int bottom = 0, top = 0;
+		int is_range, is_number;
+
+		strbuf_trim(*ptr);
+		if (!(*ptr)->len)
+			continue;
+
+		/* Input that begins with '-'; unchoose */
+		if (*(*ptr)->buf == '-') {
+			choose = 0;
+			strbuf_remove((*ptr), 0, 1);
+		}
+
+		is_range = 0;
+		is_number = 1;
+		for (p = (*ptr)->buf; *p; p++) {
+			if ('-' == *p) {
+				if (!is_range) {
+					is_range = 1;
+					is_number = 0;
+				} else {
+					is_number = 0;
+					is_range = 0;
+					break;
+				}
+			} else if (!isdigit(*p)) {
+				is_number = 0;
+				is_range = 0;
+				break;
+			}
+		}
+
+		if (is_number) {
+			bottom = atoi((*ptr)->buf);
+			top = bottom;
+		} else if (is_range) {
+			bottom = atoi((*ptr)->buf);
+			/* a range can be specified like 5-7 or 5- */
+			if (!*(strchr((*ptr)->buf, '-') + 1))
+				top = menu_stuff->nr;
+			else
+				top = atoi(strchr((*ptr)->buf, '-') + 1);
+		} else if (!strcmp((*ptr)->buf, "*")) {
+			bottom = 1;
+			top = menu_stuff->nr;
+		} else {
+			bottom = find_unique((*ptr)->buf, menu_stuff);
+			top = bottom;
+		}
+
+		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
+		    (is_single && bottom != top)) {
+			clean_print_color(CLEAN_COLOR_ERROR);
+			printf(_("Huh (%s)?\n"), (*ptr)->buf);
+			clean_print_color(CLEAN_COLOR_RESET);
+			continue;
+		}
+
+		for (i = bottom; i <= top; i++)
+			(*chosen)[i-1] = choose;
+	}
+
+	strbuf_list_free(choice_list);
+
+	for (i = 0; i < menu_stuff->nr; i++)
+		nr += (*chosen)[i];
+	return nr;
+}
+
+static void pretty_print_menus(struct string_list *menu_list)
+{
+	unsigned int local_colopts = 0;
+	struct column_options copts;
+
+	local_colopts = COL_ENABLED | COL_ROW;
+	memset(&copts, 0, sizeof(copts));
+	copts.indent = "  ";
+	copts.padding = 2;
+	print_columns(menu_list, local_colopts, &copts);
+}
+
+/*
+ * display menu stuff with number prefix and hotkey highlight
+ */
+static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
+{
+	struct string_list menu_list = STRING_LIST_INIT_DUP;
+	struct strbuf menu = STRBUF_INIT;
+	struct menu_item *menu_item;
+	struct string_list_item *string_list_item;
+	int i;
+
+	switch (stuff->type) {
+	default:
+		die("Bad type of menu_stuff when print menu");
+	case MENU_STUFF_TYPE_MENU_ITEM:
+		menu_item = (struct menu_item *)stuff->stuff;
+		for (i = 0; i < stuff->nr; i++, menu_item++) {
+			const char *p;
+			int highlighted = 0;
+
+			p = menu_item->title;
+			if ((*chosen)[i] < 0)
+				(*chosen)[i] = menu_item->selected ? 1 : 0;
+			strbuf_addf(&menu, "%s%2d: ", (*chosen)[i] ? "*" : " ", i+1);
+			for (; *p; p++) {
+				if (!highlighted && *p == menu_item->hotkey) {
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
+					strbuf_addch(&menu, *p);
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
+					highlighted = 1;
+				} else {
+					strbuf_addch(&menu, *p);
+				}
+			}
+			string_list_append(&menu_list, menu.buf);
+			strbuf_reset(&menu);
+		}
+		break;
+	case MENU_STUFF_TYPE_STRING_LIST:
+		i = 0;
+		for_each_string_list_item(string_list_item, (struct string_list *)stuff->stuff) {
+			if ((*chosen)[i] < 0)
+				(*chosen)[i] = 0;
+			strbuf_addf(&menu, "%s%2d: %s",
+				    (*chosen)[i] ? "*" : " ", i+1, string_list_item->string);
+			string_list_append(&menu_list, menu.buf);
+			strbuf_reset(&menu);
+			i++;
+		}
+		break;
+	}
+
+	pretty_print_menus(&menu_list);
+
+	strbuf_release(&menu);
+	string_list_clear(&menu_list, 0);
+}
+
+int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int))
+{
+	struct strbuf choice = STRBUF_INIT;
+	int *chosen, *result;
+	int nr = 0;
+	int eof = 0;
+	int i;
+
+	ALLOC_ARRAY(chosen, stuff->nr);
+	/* set chosen as uninitialized */
+	for (i = 0; i < stuff->nr; i++)
+		chosen[i] = -1;
+
+	for (;;) {
+		if (opts->header) {
+			printf_ln("%s%s%s",
+				  clean_get_color(CLEAN_COLOR_HEADER),
+				  _(opts->header),
+				  clean_get_color(CLEAN_COLOR_RESET));
+		}
+
+		/* chosen will be initialized by print_highlight_menu_stuff */
+		print_highlight_menu_stuff(stuff, &chosen);
+
+		if (opts->flags & MENU_OPTS_LIST_ONLY)
+			break;
+
+		if (opts->prompt) {
+			printf("%s%s%s%s",
+			       clean_get_color(CLEAN_COLOR_PROMPT),
+			       _(opts->prompt),
+			       opts->flags & MENU_OPTS_SINGLETON ? "> " : ">> ",
+			       clean_get_color(CLEAN_COLOR_RESET));
+		}
+
+		if (git_read_line_interactively(&choice) == EOF) {
+			eof = 1;
+			break;
+		}
+
+		/* help for prompt */
+		if (!strcmp(choice.buf, "?")) {
+			prompt_help_cmd(opts->flags & MENU_OPTS_SINGLETON);
+			continue;
+		}
+
+		/* for a multiple-choice menu, press ENTER (empty) will return back */
+		if (!(opts->flags & MENU_OPTS_SINGLETON) && !choice.len)
+			break;
+
+		nr = parse_choice(stuff,
+				  opts->flags & MENU_OPTS_SINGLETON,
+				  choice,
+				  &chosen);
+
+		if (opts->flags & MENU_OPTS_SINGLETON) {
+			if (nr)
+				break;
+		} else if (opts->flags & MENU_OPTS_IMMEDIATE) {
+			break;
+		}
+	}
+
+	if (eof) {
+		result = xmalloc(sizeof(int));
+		*result = EOF;
+	} else {
+		int j = 0;
+
+		/*
+		 * recalculate nr, if return back from menu directly with
+		 * default selections.
+		 */
+		if (!nr) {
+			for (i = 0; i < stuff->nr; i++)
+				nr += chosen[i];
+		}
+
+		CALLOC_ARRAY(result, st_add(nr, 1));
+		for (i = 0; i < stuff->nr && j < nr; i++) {
+			if (chosen[i])
+				result[j++] = i;
+		}
+		result[j] = EOF;
+	}
+
+	free(chosen);
+	strbuf_release(&choice);
+	return result;
+}
+
+void clean_print_color(enum color_clean ix)
+{
+	printf("%s", clean_get_color(ix));
+}
\ No newline at end of file
diff --git a/add-menu.h b/add-menu.h
new file mode 100644
index 00000000000..52e5ccb1800
--- /dev/null
+++ b/add-menu.h
@@ -0,0 +1,51 @@
+#define MENU_OPTS_SINGLETON		01
+#define MENU_OPTS_IMMEDIATE		02
+#define MENU_OPTS_LIST_ONLY		04
+
+enum color_clean {
+	CLEAN_COLOR_RESET = 0,
+	CLEAN_COLOR_PLAIN = 1,
+	CLEAN_COLOR_PROMPT = 2,
+	CLEAN_COLOR_HEADER = 3,
+	CLEAN_COLOR_HELP = 4,
+	CLEAN_COLOR_ERROR = 5
+};
+
+struct menu_opts {
+	const char *header;
+	const char *prompt;
+	int flags;
+};
+
+struct menu_item {
+	char hotkey;
+	const char *title;
+	int selected;
+	int (*fn)(void);
+};
+
+enum menu_stuff_type {
+	MENU_STUFF_TYPE_STRING_LIST = 1,
+	MENU_STUFF_TYPE_MENU_ITEM
+};
+
+struct menu_stuff {
+	enum menu_stuff_type type;
+	int nr;
+	void *stuff;
+};
+
+void clean_print_color(enum color_clean ix);
+
+/*
+ * Implement a git-add-interactive compatible UI, which is borrowed
+ * from git-add--interactive.perl.
+ *
+ * Return value:
+ *
+ *   - Return an array of integers
+ *   - , and it is up to you to free the allocated memory.
+ *   - The array ends with EOF.
+ *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
+ */
+int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int));
\ No newline at end of file
-- 
gitgitgadget

