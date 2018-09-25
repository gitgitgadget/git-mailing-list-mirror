Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4211F453
	for <e@80x24.org>; Tue, 25 Sep 2018 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeIYXxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 19:53:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36822 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIYXxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 19:53:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id v17-v6so16899777lfe.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pNsNA4udk28W5sTd/C4bbh5oX1k18SN1XSDDcEc1cw=;
        b=PVYvWpLaPdkrPhGhhcYBUsJvDDxq4Y7VSRqNbxHF43vbgYGFWSxwUUHgAmyVQ1EN2Y
         6/8XSGHB5WRgaOaVarmijaLWmT8ChbjihohKAukoG2Ic5ivTv5WAscPhKMDtYYn6pxKz
         oBFGpliVZCPVBq+2Cyz5DUxAIGeyEtQO9c/bzYp9B+ClODHagAlQwdzbD1SDvjdYh0kY
         PwTcOhaX5Weeu3O9zI1iIyaZnpM360xjb8fDkN62eQy/pwVEgfAOrc3JIlCcz5Dfg1g2
         X9rzpEjrBRqyGC2Emb5gN6uzul04AzwSdG0M7/whnaKqcrT6pe91cyWE5NoVKD3MVMt0
         HRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pNsNA4udk28W5sTd/C4bbh5oX1k18SN1XSDDcEc1cw=;
        b=RYwZZRYGpOOVm7aln4MvuGw8DSt6EPhkAdzilsu7G3zBBcHt2sUXZck/KKxSCzm7jE
         62lVgw7JXspErPCtO+eO5cQL2HL9EeEXudY7tLpSgsGWL3/UNs867YbZtNStIPSqr2Sf
         wMhNSqDFnMdg/g391IWF/eMcm1IJO6VPWfqYJ/UTFUzHKQ6VPWFdjI8DAFbJad/Y+sJ/
         ju5XMRmyp71eKcOuAkt/X1pKTuMvLoARFXYpe8w1hp6W/iIUC1PzQmHJxF+ifc2H09Y9
         vQT4HyqNcqBL+l2MZ1YOJflsz1VyRo/KAnhmViTpjF/nL8AgiBdxiBgsj4Uo9fQhKQH+
         j3aA==
X-Gm-Message-State: ABuFfogDF5NJo08JIUoH9JC8lMKZs/pXNgKDnuwTE2+C3cTwDaKMsVp3
        nBOuRMtfNbmmFmCMO+hQrrY=
X-Google-Smtp-Source: ACcGV60omiuxslTLOpchjBaL/2SAt0SU/qOpKLoj/XXlY1q1tfGioWr9pxggFUn11TIOHxeApM8PTQ==
X-Received: by 2002:a19:df43:: with SMTP id q3-v6mr1551594lfj.53.1537897494687;
        Tue, 25 Sep 2018 10:44:54 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m10-v6sm527110lfl.38.2018.09.25.10.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:44:53 -0700 (PDT)
Date:   Tue, 25 Sep 2018 19:44:51 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180925174451.GA29454@duynguyen.home>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
 <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 05:15:38PM +0200, Duy Nguyen wrote:
> On Mon, Sep 24, 2018 at 10:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> > I personally find "help -av" a bit too loud to my taste than plain
> > "-a", and more importantly, I look at "help -a" primarily to check
> > the last section "avaialble from elsewhere on your $PATH" to find
> > things like "clang-format", which I do not think is available
> > anywhere in "help -av", so I do not think "-av" can be promoted as
> > an upward-compatible replacement in its current form.
> 
> Yep. I also thought "help -a" was denser but wasn't sure if it
> actually helps or not. Whenever I look at that block of commands, I
> end up searching anyway. For my use case, "help -a" could be better
> served with something like "git apropos".
> 
> I think adding another section about external commands in "help -av"
> would address the "clang-format" stuff. With that, it's probably good
> enough to completely replace "help -a". It may also be good to list
> aliases there too in a separate section so you have "all you can type"
> in one (big) list.

Here's the patch that adds that external commands and aliases
sections. I feel that external commands section is definitely good to
have even if we don't replace "help -a". Aliases are more
subjective...

-- 8< --
diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..23a34b36e7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -38,7 +38,6 @@ static const char *html_path;
 static int show_all = 0;
 static int show_guides = 0;
 static int show_config;
-static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -53,7 +52,6 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
-	OPT__VERBOSE(&verbose, N_("print command description")),
 	OPT_END(),
 };
 
@@ -437,14 +435,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		git_config(git_help_config, NULL);
-		if (verbose) {
-			setup_pager();
-			list_all_cmds_help();
-			return 0;
-		}
-		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
-		load_command_list("git-", &main_cmds, &other_cmds);
-		list_commands(colopts, &main_cmds, &other_cmds);
+		setup_pager();
+		list_all_cmds_help();
+		return 0;
 	}
 
 	if (show_config) {
diff --git a/help.c b/help.c
index 96f6d221ed..4a168230dc 100644
--- a/help.c
+++ b/help.c
@@ -98,7 +98,8 @@ static int cmd_name_cmp(const void *elem1, const void *elem2)
 	return strcmp(e1->name, e2->name);
 }
 
-static void print_cmd_by_category(const struct category_description *catdesc)
+static void print_cmd_by_category(const struct category_description *catdesc,
+				  int *longest_p)
 {
 	struct cmdname_help *cmds;
 	int longest = 0;
@@ -124,6 +125,8 @@ static void print_cmd_by_category(const struct category_description *catdesc)
 		print_command_list(cmds, mask, longest);
 	}
 	free(cmds);
+	if (longest_p)
+		*longest_p = longest;
 }
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
@@ -193,26 +196,6 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	cmds->cnt = cj;
 }
 
-static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
-{
-	struct string_list list = STRING_LIST_INIT_NODUP;
-	struct column_options copts;
-	int i;
-
-	for (i = 0; i < cmds->cnt; i++)
-		string_list_append(&list, cmds->names[i]->name);
-	/*
-	 * always enable column display, we only consult column.*
-	 * about layout strategy and stuff
-	 */
-	colopts = (colopts & ~COL_ENABLE_MASK) | COL_ENABLED;
-	memset(&copts, 0, sizeof(copts));
-	copts.indent = "  ";
-	copts.padding = 2;
-	print_columns(&list, colopts, &copts);
-	string_list_clear(&list, 0);
-}
-
 static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
@@ -285,29 +268,10 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
-void list_commands(unsigned int colopts,
-		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
-{
-	if (main_cmds->cnt) {
-		const char *exec_path = git_exec_path();
-		printf_ln(_("available git commands in '%s'"), exec_path);
-		putchar('\n');
-		pretty_print_cmdnames(main_cmds, colopts);
-		putchar('\n');
-	}
-
-	if (other_cmds->cnt) {
-		printf_ln(_("git commands available from elsewhere on your $PATH"));
-		putchar('\n');
-		pretty_print_cmdnames(other_cmds, colopts);
-		putchar('\n');
-	}
-}
-
 void list_common_cmds_help(void)
 {
 	puts(_("These are common Git commands used in various situations:"));
-	print_cmd_by_category(common_categories);
+	print_cmd_by_category(common_categories, NULL);
 }
 
 void list_all_main_cmds(struct string_list *list)
@@ -405,7 +369,7 @@ void list_common_guides_help(void)
 		{ CAT_guide, N_("The common Git guides are:") },
 		{ 0, NULL }
 	};
-	print_cmd_by_category(catdesc);
+	print_cmd_by_category(catdesc, NULL);
 	putchar('\n');
 }
 
@@ -494,9 +458,48 @@ void list_config_help(int for_human)
 	string_list_clear(&keys, 0);
 }
 
+static int get_alias(const char *var, const char *value, void *data)
+{
+	struct string_list *list = data;
+
+	if (skip_prefix(var, "alias.", &var))
+		string_list_append(list, var)->util = xstrdup(value);
+
+	return 0;
+}
+
 void list_all_cmds_help(void)
 {
-	print_cmd_by_category(main_categories);
+	struct string_list others = STRING_LIST_INIT_DUP;
+	struct string_list alias_list = STRING_LIST_INIT_DUP;
+	struct cmdname_help *aliases;
+	int i, longest;
+
+	printf_ln(_("See 'git help <command>' to read about a specific subcommand"));
+	print_cmd_by_category(main_categories, &longest);
+
+	list_all_other_cmds(&others);
+	if (others.nr)
+		printf("\n%s\n", _("External commands"));
+	for (i = 0; i < others.nr; i++)
+		printf("   %s\n", others.items[i].string);
+	string_list_clear(&others, 0);
+
+	git_config(get_alias, &alias_list);
+	string_list_sort(&alias_list);
+	if (alias_list.nr) {
+		printf("\n%s\n", _("Command aliases"));
+		ALLOC_ARRAY(aliases, alias_list.nr + 1);
+		for (i = 0; i < alias_list.nr; i++) {
+			aliases[i].name = alias_list.items[i].string;
+			aliases[i].help = alias_list.items[i].util;
+			aliases[i].category = 1;
+		}
+		aliases[alias_list.nr].name = NULL;
+		print_command_list(aliases, 1, longest);
+		free(aliases);
+	}
+	string_list_clear(&alias_list, 1);
 }
 
 int is_in_cmdlist(struct cmdnames *c, const char *s)
diff --git a/help.h b/help.h
index 9eab6a3f89..105de6195a 100644
--- a/help.h
+++ b/help.h
@@ -37,7 +37,6 @@ extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index bc27df7f38..964615de2f 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -30,8 +30,7 @@ test_expect_success "setup" '
 test_expect_success 'basic help commands' '
 	git help >/dev/null &&
 	git help -a >/dev/null &&
-	git help -g >/dev/null &&
-	git help -av >/dev/null
+	git help -g >/dev/null
 '
 
 test_expect_success "works for commands and guides by default" '
-- 8< --

--
Duy
