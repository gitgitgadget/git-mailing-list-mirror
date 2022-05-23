Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C9FC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 06:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiEWGNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 02:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiEWGM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 02:12:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011034BA6
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so1189690wmf.1
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WVBkdKOFWx94AlqbZkiAsQSt7Fpy76h7KbPlHrxPgdU=;
        b=Bg3/UXHEU+9FL9xHSoSFL/x1i6kpMMjuD5V5YFcs+Lie/p0uJFc6+bbiSH7wxHBXTx
         ZmlEf1FeGcneDVMZNycuwS51p1u75Nx0sx9kwHv0EIrTI5ptSUl9/DjA+ltetMW9cI1+
         mXMPf6uut/ZVeLsmMXd6Dx5OqnNcxpJ9uKoHZj7/sx7sLI3qaAVg2IToa8JdyEhj3Fb3
         JP/4eU+2wuoO58/Y9eX1GH6b51G9Zxy5cqPDtuIt9UG45Ylm6BoMF1xe/GMlC+KxOGtd
         DlNts6bzy5GbKNQQyXo4S20ZhwwZjcxw4EIaZca8Bwp/9/cVhNS3iFHuUD6USow86qdK
         k3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WVBkdKOFWx94AlqbZkiAsQSt7Fpy76h7KbPlHrxPgdU=;
        b=WHvp+R1j8tdcZE5as2RZfLJIbEu7Zi9UG/SIbT03cqtT0cRWLtrhUBMgs0iFx0EP+O
         qSnSxzIWqLH2Hy1jiSiHAzWjEIdivIBDfAmPoV3q1HpvmnjoAT11RvAVsE4KIV7lTJU/
         KitgJF1i6yvikEne0szzphXX3ONrKpnRXhQeOpqH0ME42AXW5iZwulm8xRBj9zndeILa
         kBwIVyXig2quM/csdTudDKoxefpQpQ26oWyRsl5OMJKNameTYP+fupswrrJCM9eqy84p
         Qu8xlsMaYaxhY7rOGajR0I28q8W4GvZVxvUrRjwmmDqWPXvuFIf2o90QlWdDRSs6OM1t
         jH5w==
X-Gm-Message-State: AOAM532PexQvjm0YI8yDldPBESb5ZjcJgvlw+yHFFmPiX+xugH0iHBG4
        ySXcXaBRg3Udmf6Y79esQ9j2TnB+Q80=
X-Google-Smtp-Source: ABdhPJwnXEPSTv2U7L4FlRRFb0knlAioLKmm8PQeBRK5//9cS1iHHZCMilBILpeajVjENSUYcD9blQ==
X-Received: by 2002:a05:600c:3d16:b0:394:4ff0:d818 with SMTP id bh22-20020a05600c3d1600b003944ff0d818mr18287040wmb.5.1653286349389;
        Sun, 22 May 2022 23:12:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b00395f15d993fsm8811848wmr.5.2022.05.22.23.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:12:28 -0700 (PDT)
Message-Id: <7271a285d18604bd77251d586201d31eba1287da.1653286345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
        <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 06:12:25 +0000
Subject: [PATCH v2 2/2] clean: refector to the interactive part of clean
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

moved the code that responsible for presenting the menu options
(interactive flag) to be handles by the add-menu lib that was added
in previous commit.

Signed-off-by: Nadav Goldstein <nadav.goldstein96@gmail.com>
---
 add-menu.c      |  78 +++++----
 add-menu.h      |   8 +-
 builtin/clean.c | 413 ++----------------------------------------------
 3 files changed, 68 insertions(+), 431 deletions(-)

diff --git a/add-menu.c b/add-menu.c
index 6a1c125d113..becf4956917 100644
--- a/add-menu.c
+++ b/add-menu.c
@@ -13,24 +13,18 @@
 #include "help.h"
 #include "prompt.h"
 
-static int clean_use_color = -1;
-static char clean_colors[][COLOR_MAXLEN] = {
-	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
-	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
-	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
-	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
-	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
-	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
-};
-
-
-static const char *clean_get_color(enum color_clean ix)
+static const char *clean_get_color(enum color_clean ix, clean_color_settings *clean_colors, int *clean_use_color)
 {
-	if (want_color(clean_use_color))
-		return clean_colors[ix];
+	if (want_color(*clean_use_color))
+		return (*clean_colors)[ix];
 	return "";
 }
 
+void clean_print_color(enum color_clean ix, clean_color_settings *clean_colors, int *clean_use_color)
+{
+	printf("%s", clean_get_color(ix, clean_colors, clean_use_color));
+}
+
 static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 {
 	struct menu_item *menu_item;
@@ -80,10 +74,33 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 	return found;
 }
 
+/*
+ * Parse user input, and return choice(s) for menu (menu_stuff).
+ *
+ * Input
+ *     (for single choice)
+ *         1          - select a numbered item
+ *         foo        - select item based on menu title
+ *                    - (empty) select nothing
+ *
+ *     (for multiple choice)
+ *         1          - select a single item
+ *         3-5        - select a range of items
+ *         2-3,6-9    - select multiple ranges
+ *         foo        - select item based on menu title
+ *         -...       - unselect specified items
+ *         *          - choose all items
+ *                    - (empty) finish selecting
+ *
+ * The parse result will be saved in array **chosen, and
+ * return number of total selections.
+ */
 static int parse_choice(struct menu_stuff *menu_stuff,
 			int is_single,
 			struct strbuf input,
-			int **chosen)
+			int **chosen,
+			clean_color_settings *clean_colors,
+			int *clean_use_color)
 {
 	struct strbuf **choice_list, **ptr;
 	int nr = 0;
@@ -155,9 +172,9 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
 		    (is_single && bottom != top)) {
-			clean_print_color(CLEAN_COLOR_ERROR);
+			clean_print_color(CLEAN_COLOR_ERROR, clean_colors, clean_use_color);
 			printf(_("Huh (%s)?\n"), (*ptr)->buf);
-			clean_print_color(CLEAN_COLOR_RESET);
+			clean_print_color(CLEAN_COLOR_RESET, clean_colors, clean_use_color);
 			continue;
 		}
 
@@ -187,7 +204,7 @@ static void pretty_print_menus(struct string_list *menu_list)
 /*
  * display menu stuff with number prefix and hotkey highlight
  */
-static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
+static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen, clean_color_settings *clean_colors, int *clean_use_color)
 {
 	struct string_list menu_list = STRING_LIST_INIT_DUP;
 	struct strbuf menu = STRBUF_INIT;
@@ -210,9 +227,9 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 			strbuf_addf(&menu, "%s%2d: ", (*chosen)[i] ? "*" : " ", i+1);
 			for (; *p; p++) {
 				if (!highlighted && *p == menu_item->hotkey) {
-					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT, clean_colors, clean_use_color));
 					strbuf_addch(&menu, *p);
-					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
+					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET, clean_colors, clean_use_color));
 					highlighted = 1;
 				} else {
 					strbuf_addch(&menu, *p);
@@ -242,7 +259,7 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 	string_list_clear(&menu_list, 0);
 }
 
-int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int))
+int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, clean_color_settings *clean_colors, int *clean_use_color, void (*prompt_help_cmd)(int))
 {
 	struct strbuf choice = STRBUF_INIT;
 	int *chosen, *result;
@@ -258,23 +275,23 @@ int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*pr
 	for (;;) {
 		if (opts->header) {
 			printf_ln("%s%s%s",
-				  clean_get_color(CLEAN_COLOR_HEADER),
+				  clean_get_color(CLEAN_COLOR_HEADER, clean_colors, clean_use_color),
 				  _(opts->header),
-				  clean_get_color(CLEAN_COLOR_RESET));
+				  clean_get_color(CLEAN_COLOR_RESET, clean_colors, clean_use_color));
 		}
 
 		/* chosen will be initialized by print_highlight_menu_stuff */
-		print_highlight_menu_stuff(stuff, &chosen);
+		print_highlight_menu_stuff(stuff, &chosen, clean_colors, clean_use_color);
 
 		if (opts->flags & MENU_OPTS_LIST_ONLY)
 			break;
 
 		if (opts->prompt) {
 			printf("%s%s%s%s",
-			       clean_get_color(CLEAN_COLOR_PROMPT),
+			       clean_get_color(CLEAN_COLOR_PROMPT, clean_colors, clean_use_color),
 			       _(opts->prompt),
 			       opts->flags & MENU_OPTS_SINGLETON ? "> " : ">> ",
-			       clean_get_color(CLEAN_COLOR_RESET));
+			       clean_get_color(CLEAN_COLOR_RESET, clean_colors, clean_use_color));
 		}
 
 		if (git_read_line_interactively(&choice) == EOF) {
@@ -295,7 +312,9 @@ int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*pr
 		nr = parse_choice(stuff,
 				  opts->flags & MENU_OPTS_SINGLETON,
 				  choice,
-				  &chosen);
+				  &chosen,
+				  clean_colors,
+				  clean_use_color);
 
 		if (opts->flags & MENU_OPTS_SINGLETON) {
 			if (nr)
@@ -331,9 +350,4 @@ int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*pr
 	free(chosen);
 	strbuf_release(&choice);
 	return result;
-}
-
-void clean_print_color(enum color_clean ix)
-{
-	printf("%s", clean_get_color(ix));
 }
\ No newline at end of file
diff --git a/add-menu.h b/add-menu.h
index 52e5ccb1800..64f1cbdab9f 100644
--- a/add-menu.h
+++ b/add-menu.h
@@ -1,3 +1,7 @@
+#include "color.h"
+
+typedef char clean_color_settings[][COLOR_MAXLEN];
+
 #define MENU_OPTS_SINGLETON		01
 #define MENU_OPTS_IMMEDIATE		02
 #define MENU_OPTS_LIST_ONLY		04
@@ -35,7 +39,7 @@ struct menu_stuff {
 	void *stuff;
 };
 
-void clean_print_color(enum color_clean ix);
+void clean_print_color(enum color_clean ix, clean_color_settings *clean_colors, int *clean_use_color);
 
 /*
  * Implement a git-add-interactive compatible UI, which is borrowed
@@ -48,4 +52,4 @@ void clean_print_color(enum color_clean ix);
  *   - The array ends with EOF.
  *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
  */
-int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int));
\ No newline at end of file
+int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, clean_color_settings *clean_colors, int *clean_use_color, void (*prompt_help_cmd)(int));
diff --git a/builtin/clean.c b/builtin/clean.c
index 5466636e666..ef220869851 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -19,6 +19,7 @@
 #include "pathspec.h"
 #include "help.h"
 #include "prompt.h"
+#include "add-menu.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -39,14 +40,6 @@ static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
 static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
 static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
-enum color_clean {
-	CLEAN_COLOR_RESET = 0,
-	CLEAN_COLOR_PLAIN = 1,
-	CLEAN_COLOR_PROMPT = 2,
-	CLEAN_COLOR_HEADER = 3,
-	CLEAN_COLOR_HELP = 4,
-	CLEAN_COLOR_ERROR = 5
-};
 
 static const char *color_interactive_slots[] = {
 	[CLEAN_COLOR_ERROR]  = "error",
@@ -58,7 +51,7 @@ static const char *color_interactive_slots[] = {
 };
 
 static int clean_use_color = -1;
-static char clean_colors[][COLOR_MAXLEN] = {
+static clean_color_settings clean_colors = {
 	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
 	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
 	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
@@ -67,36 +60,8 @@ static char clean_colors[][COLOR_MAXLEN] = {
 	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
 };
 
-#define MENU_OPTS_SINGLETON		01
-#define MENU_OPTS_IMMEDIATE		02
-#define MENU_OPTS_LIST_ONLY		04
-
-struct menu_opts {
-	const char *header;
-	const char *prompt;
-	int flags;
-};
-
 #define MENU_RETURN_NO_LOOP		10
 
-struct menu_item {
-	char hotkey;
-	const char *title;
-	int selected;
-	int (*fn)(void);
-};
-
-enum menu_stuff_type {
-	MENU_STUFF_TYPE_STRING_LIST = 1,
-	MENU_STUFF_TYPE_MENU_ITEM
-};
-
-struct menu_stuff {
-	enum menu_stuff_type type;
-	int nr;
-	void *stuff;
-};
-
 define_list_config_array(color_interactive_slots);
 
 static int git_clean_config(const char *var, const char *value, void *cb)
@@ -130,18 +95,6 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-static const char *clean_get_color(enum color_clean ix)
-{
-	if (want_color(clean_use_color))
-		return clean_colors[ix];
-	return "";
-}
-
-static void clean_print_color(enum color_clean ix)
-{
-	printf("%s", clean_get_color(ix));
-}
-
 static int exclude_cb(const struct option *opt, const char *arg, int unset)
 {
 	struct string_list *exclude_list = opt->value;
@@ -307,21 +260,9 @@ static void pretty_print_dels(void)
 	string_list_clear(&list, 0);
 }
 
-static void pretty_print_menus(struct string_list *menu_list)
-{
-	unsigned int local_colopts = 0;
-	struct column_options copts;
-
-	local_colopts = COL_ENABLED | COL_ROW;
-	memset(&copts, 0, sizeof(copts));
-	copts.indent = "  ";
-	copts.padding = 2;
-	print_columns(menu_list, local_colopts, &copts);
-}
-
 static void prompt_help_cmd(int singleton)
 {
-	clean_print_color(CLEAN_COLOR_HELP);
+	clean_print_color(CLEAN_COLOR_HELP, &clean_colors, &clean_use_color);
 	printf(singleton ?
 		  _("Prompt help:\n"
 		    "1          - select a numbered item\n"
@@ -335,329 +276,7 @@ static void prompt_help_cmd(int singleton)
 		    "-...       - unselect specified items\n"
 		    "*          - choose all items\n"
 		    "           - (empty) finish selecting\n"));
-	clean_print_color(CLEAN_COLOR_RESET);
-}
-
-/*
- * display menu stuff with number prefix and hotkey highlight
- */
-static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
-{
-	struct string_list menu_list = STRING_LIST_INIT_DUP;
-	struct strbuf menu = STRBUF_INIT;
-	struct menu_item *menu_item;
-	struct string_list_item *string_list_item;
-	int i;
-
-	switch (stuff->type) {
-	default:
-		die("Bad type of menu_stuff when print menu");
-	case MENU_STUFF_TYPE_MENU_ITEM:
-		menu_item = (struct menu_item *)stuff->stuff;
-		for (i = 0; i < stuff->nr; i++, menu_item++) {
-			const char *p;
-			int highlighted = 0;
-
-			p = menu_item->title;
-			if ((*chosen)[i] < 0)
-				(*chosen)[i] = menu_item->selected ? 1 : 0;
-			strbuf_addf(&menu, "%s%2d: ", (*chosen)[i] ? "*" : " ", i+1);
-			for (; *p; p++) {
-				if (!highlighted && *p == menu_item->hotkey) {
-					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_PROMPT));
-					strbuf_addch(&menu, *p);
-					strbuf_addstr(&menu, clean_get_color(CLEAN_COLOR_RESET));
-					highlighted = 1;
-				} else {
-					strbuf_addch(&menu, *p);
-				}
-			}
-			string_list_append(&menu_list, menu.buf);
-			strbuf_reset(&menu);
-		}
-		break;
-	case MENU_STUFF_TYPE_STRING_LIST:
-		i = 0;
-		for_each_string_list_item(string_list_item, (struct string_list *)stuff->stuff) {
-			if ((*chosen)[i] < 0)
-				(*chosen)[i] = 0;
-			strbuf_addf(&menu, "%s%2d: %s",
-				    (*chosen)[i] ? "*" : " ", i+1, string_list_item->string);
-			string_list_append(&menu_list, menu.buf);
-			strbuf_reset(&menu);
-			i++;
-		}
-		break;
-	}
-
-	pretty_print_menus(&menu_list);
-
-	strbuf_release(&menu);
-	string_list_clear(&menu_list, 0);
-}
-
-static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
-{
-	struct menu_item *menu_item;
-	struct string_list_item *string_list_item;
-	int i, len, found = 0;
-
-	len = strlen(choice);
-	switch (menu_stuff->type) {
-	default:
-		die("Bad type of menu_stuff when parse choice");
-	case MENU_STUFF_TYPE_MENU_ITEM:
-
-		menu_item = (struct menu_item *)menu_stuff->stuff;
-		for (i = 0; i < menu_stuff->nr; i++, menu_item++) {
-			if (len == 1 && *choice == menu_item->hotkey) {
-				found = i + 1;
-				break;
-			}
-			if (!strncasecmp(choice, menu_item->title, len)) {
-				if (found) {
-					if (len == 1) {
-						/* continue for hotkey matching */
-						found = -1;
-					} else {
-						found = 0;
-						break;
-					}
-				} else {
-					found = i + 1;
-				}
-			}
-		}
-		break;
-	case MENU_STUFF_TYPE_STRING_LIST:
-		string_list_item = ((struct string_list *)menu_stuff->stuff)->items;
-		for (i = 0; i < menu_stuff->nr; i++, string_list_item++) {
-			if (!strncasecmp(choice, string_list_item->string, len)) {
-				if (found) {
-					found = 0;
-					break;
-				}
-				found = i + 1;
-			}
-		}
-		break;
-	}
-	return found;
-}
-
-/*
- * Parse user input, and return choice(s) for menu (menu_stuff).
- *
- * Input
- *     (for single choice)
- *         1          - select a numbered item
- *         foo        - select item based on menu title
- *                    - (empty) select nothing
- *
- *     (for multiple choice)
- *         1          - select a single item
- *         3-5        - select a range of items
- *         2-3,6-9    - select multiple ranges
- *         foo        - select item based on menu title
- *         -...       - unselect specified items
- *         *          - choose all items
- *                    - (empty) finish selecting
- *
- * The parse result will be saved in array **chosen, and
- * return number of total selections.
- */
-static int parse_choice(struct menu_stuff *menu_stuff,
-			int is_single,
-			struct strbuf input,
-			int **chosen)
-{
-	struct strbuf **choice_list, **ptr;
-	int nr = 0;
-	int i;
-
-	if (is_single) {
-		choice_list = strbuf_split_max(&input, '\n', 0);
-	} else {
-		char *p = input.buf;
-		do {
-			if (*p == ',')
-				*p = ' ';
-		} while (*p++);
-		choice_list = strbuf_split_max(&input, ' ', 0);
-	}
-
-	for (ptr = choice_list; *ptr; ptr++) {
-		char *p;
-		int choose = 1;
-		int bottom = 0, top = 0;
-		int is_range, is_number;
-
-		strbuf_trim(*ptr);
-		if (!(*ptr)->len)
-			continue;
-
-		/* Input that begins with '-'; unchoose */
-		if (*(*ptr)->buf == '-') {
-			choose = 0;
-			strbuf_remove((*ptr), 0, 1);
-		}
-
-		is_range = 0;
-		is_number = 1;
-		for (p = (*ptr)->buf; *p; p++) {
-			if ('-' == *p) {
-				if (!is_range) {
-					is_range = 1;
-					is_number = 0;
-				} else {
-					is_number = 0;
-					is_range = 0;
-					break;
-				}
-			} else if (!isdigit(*p)) {
-				is_number = 0;
-				is_range = 0;
-				break;
-			}
-		}
-
-		if (is_number) {
-			bottom = atoi((*ptr)->buf);
-			top = bottom;
-		} else if (is_range) {
-			bottom = atoi((*ptr)->buf);
-			/* a range can be specified like 5-7 or 5- */
-			if (!*(strchr((*ptr)->buf, '-') + 1))
-				top = menu_stuff->nr;
-			else
-				top = atoi(strchr((*ptr)->buf, '-') + 1);
-		} else if (!strcmp((*ptr)->buf, "*")) {
-			bottom = 1;
-			top = menu_stuff->nr;
-		} else {
-			bottom = find_unique((*ptr)->buf, menu_stuff);
-			top = bottom;
-		}
-
-		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
-		    (is_single && bottom != top)) {
-			clean_print_color(CLEAN_COLOR_ERROR);
-			printf(_("Huh (%s)?\n"), (*ptr)->buf);
-			clean_print_color(CLEAN_COLOR_RESET);
-			continue;
-		}
-
-		for (i = bottom; i <= top; i++)
-			(*chosen)[i-1] = choose;
-	}
-
-	strbuf_list_free(choice_list);
-
-	for (i = 0; i < menu_stuff->nr; i++)
-		nr += (*chosen)[i];
-	return nr;
-}
-
-/*
- * Implement a git-add-interactive compatible UI, which is borrowed
- * from git-add--interactive.perl.
- *
- * Return value:
- *
- *   - Return an array of integers
- *   - , and it is up to you to free the allocated memory.
- *   - The array ends with EOF.
- *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
- */
-static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
-{
-	struct strbuf choice = STRBUF_INIT;
-	int *chosen, *result;
-	int nr = 0;
-	int eof = 0;
-	int i;
-
-	ALLOC_ARRAY(chosen, stuff->nr);
-	/* set chosen as uninitialized */
-	for (i = 0; i < stuff->nr; i++)
-		chosen[i] = -1;
-
-	for (;;) {
-		if (opts->header) {
-			printf_ln("%s%s%s",
-				  clean_get_color(CLEAN_COLOR_HEADER),
-				  _(opts->header),
-				  clean_get_color(CLEAN_COLOR_RESET));
-		}
-
-		/* chosen will be initialized by print_highlight_menu_stuff */
-		print_highlight_menu_stuff(stuff, &chosen);
-
-		if (opts->flags & MENU_OPTS_LIST_ONLY)
-			break;
-
-		if (opts->prompt) {
-			printf("%s%s%s%s",
-			       clean_get_color(CLEAN_COLOR_PROMPT),
-			       _(opts->prompt),
-			       opts->flags & MENU_OPTS_SINGLETON ? "> " : ">> ",
-			       clean_get_color(CLEAN_COLOR_RESET));
-		}
-
-		if (git_read_line_interactively(&choice) == EOF) {
-			eof = 1;
-			break;
-		}
-
-		/* help for prompt */
-		if (!strcmp(choice.buf, "?")) {
-			prompt_help_cmd(opts->flags & MENU_OPTS_SINGLETON);
-			continue;
-		}
-
-		/* for a multiple-choice menu, press ENTER (empty) will return back */
-		if (!(opts->flags & MENU_OPTS_SINGLETON) && !choice.len)
-			break;
-
-		nr = parse_choice(stuff,
-				  opts->flags & MENU_OPTS_SINGLETON,
-				  choice,
-				  &chosen);
-
-		if (opts->flags & MENU_OPTS_SINGLETON) {
-			if (nr)
-				break;
-		} else if (opts->flags & MENU_OPTS_IMMEDIATE) {
-			break;
-		}
-	}
-
-	if (eof) {
-		result = xmalloc(sizeof(int));
-		*result = EOF;
-	} else {
-		int j = 0;
-
-		/*
-		 * recalculate nr, if return back from menu directly with
-		 * default selections.
-		 */
-		if (!nr) {
-			for (i = 0; i < stuff->nr; i++)
-				nr += chosen[i];
-		}
-
-		CALLOC_ARRAY(result, st_add(nr, 1));
-		for (i = 0; i < stuff->nr && j < nr; i++) {
-			if (chosen[i])
-				result[j++] = i;
-		}
-		result[j] = EOF;
-	}
-
-	free(chosen);
-	strbuf_release(&choice);
-	return result;
+	clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 }
 
 static int clean_cmd(void)
@@ -681,9 +300,9 @@ static int filter_by_patterns_cmd(void)
 		if (changed)
 			pretty_print_dels();
 
-		clean_print_color(CLEAN_COLOR_PROMPT);
+		clean_print_color(CLEAN_COLOR_PROMPT, &clean_colors, &clean_use_color);
 		printf(_("Input ignore patterns>> "));
-		clean_print_color(CLEAN_COLOR_RESET);
+		clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 		if (git_read_line_interactively(&confirm) == EOF)
 			putchar('\n');
 
@@ -715,9 +334,9 @@ static int filter_by_patterns_cmd(void)
 		if (changed) {
 			string_list_remove_empty_items(&del_list, 0);
 		} else {
-			clean_print_color(CLEAN_COLOR_ERROR);
+			clean_print_color(CLEAN_COLOR_ERROR, &clean_colors, &clean_use_color);
 			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
-			clean_print_color(CLEAN_COLOR_RESET);
+			clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 		}
 
 		strbuf_list_free(ignore_list);
@@ -744,7 +363,7 @@ static int select_by_numbers_cmd(void)
 	menu_stuff.stuff = &del_list;
 	menu_stuff.nr = del_list.nr;
 
-	chosen = list_and_choose(&menu_opts, &menu_stuff);
+	chosen = list_and_choose(&menu_opts, &menu_stuff, &clean_colors, &clean_use_color, prompt_help_cmd);
 	items = del_list.items;
 	for (i = 0, j = 0; i < del_list.nr; i++) {
 		if (i < chosen[j]) {
@@ -807,7 +426,7 @@ static int quit_cmd(void)
 
 static int help_cmd(void)
 {
-	clean_print_color(CLEAN_COLOR_HELP);
+	clean_print_color(CLEAN_COLOR_HELP, &clean_colors, &clean_use_color);
 	printf_ln(_(
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
@@ -817,7 +436,7 @@ static int help_cmd(void)
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
 		   ));
-	clean_print_color(CLEAN_COLOR_RESET);
+	clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 	return 0;
 }
 
@@ -844,15 +463,15 @@ static void interactive_main_loop(void)
 		menu_stuff.stuff = menus;
 		menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
 
-		clean_print_color(CLEAN_COLOR_HEADER);
+		clean_print_color(CLEAN_COLOR_HEADER, &clean_colors, &clean_use_color);
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
-		clean_print_color(CLEAN_COLOR_RESET);
+		clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 
 		pretty_print_dels();
 
-		chosen = list_and_choose(&menu_opts, &menu_stuff);
+		chosen = list_and_choose(&menu_opts, &menu_stuff, &clean_colors, &clean_use_color, prompt_help_cmd);
 
 		if (*chosen != EOF) {
 			int ret;
@@ -860,9 +479,9 @@ static void interactive_main_loop(void)
 			if (ret != MENU_RETURN_NO_LOOP) {
 				FREE_AND_NULL(chosen);
 				if (!del_list.nr) {
-					clean_print_color(CLEAN_COLOR_ERROR);
+					clean_print_color(CLEAN_COLOR_ERROR, &clean_colors, &clean_use_color);
 					printf_ln(_("No more files to clean, exiting."));
-					clean_print_color(CLEAN_COLOR_RESET);
+					clean_print_color(CLEAN_COLOR_RESET, &clean_colors, &clean_use_color);
 					break;
 				}
 				continue;
-- 
gitgitgadget
