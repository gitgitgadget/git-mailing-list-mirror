Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA80C1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391873AbeHPSKv (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:10:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34381 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeHPSKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:10:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so15850245wme.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVFj+CLRh1kJWcQRFHEEnyiKfVZkuXyTAaj1b2RmwZ0=;
        b=nb338BFvwSz1RvwuW6WzY35yQN3QfmDYabv/gkodIy0GxwXvX/ZJc/I+nY1YkDYvma
         a0q/wOSM88JHtHjJr2kieP07s2NVnNtUA/4Q3JMZgMrAAg7IPymDZOr7pJ861SVVdrm9
         tS8BonDxY9d1LKBcI1/z134OaxRZzXofUi5zVXZvpYRtiaZNDxzolhjboBEwtD4uj63K
         qIfZUBLln4/DjGNKQ1iSLW4MEw0L0pbDGfKk3KWX4aFAzvO99kAkzsZZ3oaGuxfM++Gk
         rvNBZja0HnYAd05Ty5+s6nQmaE1BAVqtElRj1Uru5QSyvA4Uw6CtH7mkecORLVGFa75l
         kbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVFj+CLRh1kJWcQRFHEEnyiKfVZkuXyTAaj1b2RmwZ0=;
        b=K0j4HvegPkJw48MW/4uC0xcQM22qSwB0Jrh6SOzU54J4P+jk46MQBumBg/cTDJjWjE
         k4sNktSIowI9TTKtEtFQf3eB0YHvtyQ86rwgLIwhpU72MEg9rgVnG/Pbld6Xe9YH90R0
         iLWq/wNgdy/SAz5d9+pQZeqKR2OuG+MNmuIeoSz5ZavNsvWij03Mk6WtgiYf3C56l1rW
         tqnZT1qlk8U8MakU5vqHvdvKcb4TqciqYv+q+1mRJmtpNFANR359P8eYYU8QRjKHu3x4
         72XuOdeP1sgZoezrIJUWn8E0mh2WHVBcw1CgLgUuiplSk6CM0eJaLWY9UnUfrZDMrXc3
         t4lA==
X-Gm-Message-State: AOUpUlHB7wom3riB7NU9L6eCXXeyyU/bE1qCMeEfiWR7iMCAttcYc1kg
        IdDSmsZ1t6giGCN2hf1XHYSSoVWk/e4=
X-Google-Smtp-Source: AA+uWPwFQZJOeT+U0ypUdh/Vzw7ZLOkcQo+lzrXyBcwHXMLSICd2yRexnpS2G8gBg4D56eW9fr93Yg==
X-Received: by 2002:a1c:cecf:: with SMTP id e198-v6mr15788084wmg.83.1534432302319;
        Thu, 16 Aug 2018 08:11:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w14-v6sm2863587wme.6.2018.08.16.08.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 08:11:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hadi Safari <hadi@hadisafari.ir>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] completion: include PARSE_OPT_HIDDEN in completion output
Date:   Thu, 16 Aug 2018 15:11:25 +0000
Message-Id: <20180816151125.11803-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
References: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The PARSE_OPT_HIDDEN is, per the documentation of the "option" struct
in option parse-options.h, only supposed to affect -h output, not
completion. That's what the PARSE_OPT_NOCOMPLETE flag is supposed to
be for.

Since 2e29dca66a ("completion: use __gitcomp_builtin in _git_commit",
2018-02-09) we've been using e.g. "git commit --git-completion-helper"
to get the bash completion for the git-commit command. Due to
PARSE_OPT_HIDDEN this excluded e.g. --allow-empty and
--allow-empty-message.

Now, this wasn't a behavior change in that commit. Before that we had
a hardcoded list of options, removed in 2e29dca66a ("completion: use
__gitcomp_builtin in _git_commit", 2018-02-09). This list didn't
contain those two options.

But as noted in the follow-up discussion to c9b5fde759 ("Add option to
git-commit to allow empty log messages", 2010-04-06) in
https://public-inbox.org/git/20100406055530.GE3901@coredump.intra.peff.net/
the motivation for PARSE_OPT_HIDDEN was to keep the "git commit -h"
output to a minimum, not to hide it from completion.

I think it makes sense to exclude options like these from -h output,
but for the completion the user is usually not trying to complete "git
commit --<TAB>", but e.g. "git commit --allo<TAB>", and because of
this behavior we don't show these options at all there.

However, manually going over:

    git grep -e OPT_HIDDEN_BOOL -e PARSE_OPT_HIDDEN

Shows many options we don't want to show in completion either,
e.g. "git am --binary" or "git branch -l". Many of these are internal,
deprecated, or no-ops. There's also things like "git difftool
--prompt" (the default behavior) which are arguably pointless to add,
we just have "--no-prompt" to inverse the default.

The options we'll now show on completion, that we didn't show before,
are:

OPT_HIDDEN_BOOL:

 * checkout: --guess (no idea how this works, not documented, but it's
   not deprecated and is there..)
 * commit: --allow-empty and --allow-empty-message
 * help: --exclude-guides (because why not?)
 * receive-pack: All three (non --quiet) options it supports. It
   doesn't have any completion now, but if we ever add it why not
   complete these?

PARSE_OPT_HIDDEN (without PARSE_OPT_NOCOMPLETE):

 * fetch: --recurse-submodules-default (a legitimate documented
   option, but perhaps we should blacklist this because it's rarely
   used and interferes with --recurse-submodules?).
 * ls-remote: --exec (as with "fetch" this is a synonym for
   --upload-pack, but unlike "fetch" it wasn't documented. Document it
   while I'm at it).

I don't know if that "o->flags |= PARSE_OPT_HIDDEN" line in
cmd_parseopt() in builtin/rev-parse.c should also be setting
PARSE_OPT_NOCOMPLETE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Aug 16, 2018 at 9:46 AM, Hadi Safari <hadi@hadisafari.ir> wrote:
>
> Hi!
>
> I'm wondering why there isn't --allow-empty and
> --allow-empty-message in completeion list of git commit command. I'm
> getting only following flags from v2.18.0 on `git commit --`:

It's because we've been conflating the desire to include something in
"git <cmd> -h" output, and having "git <cmd> --some-rare-option" work
or not. Here's an attempt to fix it.

 Documentation/git-ls-remote.txt | 3 +++
 archive.c                       | 3 ++-
 builtin/add.c                   | 5 +++--
 builtin/am.c                    | 8 ++++----
 builtin/branch.c                | 5 +++--
 builtin/clone.c                 | 8 ++++----
 builtin/difftool.c              | 4 ++--
 builtin/fetch.c                 | 3 ++-
 builtin/fmt-merge-msg.c         | 3 ++-
 builtin/grep.c                  | 2 +-
 builtin/help.c                  | 2 +-
 builtin/name-rev.c              | 3 ++-
 builtin/pull.c                  | 2 +-
 builtin/show-ref.c              | 4 ++--
 builtin/write-tree.c            | 4 ++--
 parse-options.c                 | 4 ++--
 parse-options.h                 | 3 +++
 t/t9902-completion.sh           | 1 +
 18 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index b9fd3770a6..39192f4e2a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -43,6 +43,9 @@ OPTIONS
 	SSH and where the SSH daemon does not use the PATH configured by the
 	user.
 
+--exec=<git-upload-pack>::
+	Same as --upload-pack=<git-upload-pack>.
+
 --exit-code::
 	Exit with status "2" when no matching refs are found in the remote
 	repository. Usually the command exits with status "0" to indicate
diff --git a/archive.c b/archive.c
index 78b0a398a0..d5e02127a1 100644
--- a/archive.c
+++ b/archive.c
@@ -414,7 +414,8 @@ static void parse_treeish_arg(const char **argv,
 #define OPT__COMPR(s, v, h, p) \
 	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
 #define OPT__COMPR_HIDDEN(s, v, p) \
-	OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN)
+	OPT_SET_INT_F(s, NULL, v, "", p, \
+	PARSE_OPT_NONEG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)
 
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
diff --git a/builtin/add.c b/builtin/add.c
index 8a155dd41e..f283eda6d8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -305,8 +305,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
 	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
-	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
-			N_("warn when adding an embedded repository")),
+	OPT_HIDDEN_NOCOMPLETE_BOOL(0, "warn-embedded-repo",
+				   &warn_on_embedded_repo,
+				   N_("warn when adding an embedded repository")),
 	OPT_END(),
 };
 
diff --git a/builtin/am.c b/builtin/am.c
index 2c19e69f58..d5353c5954 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2215,8 +2215,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
-		OPT_HIDDEN_BOOL('b', "binary", &binary,
-			N_("historical option -- no-op")),
+		OPT_HIDDEN_NOCOMPLETE_BOOL('b', "binary", &binary,
+					   N_("historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
@@ -2298,8 +2298,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
-			N_("(internal use for git-rebase)")),
+		OPT_HIDDEN_NOCOMPLETE_BOOL(0, "rebasing", &state.rebasing,
+					   N_("(internal use for git-rebase)")),
 		OPT_END()
 	};
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc55c3508..366ffb175d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -598,7 +598,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
-			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
+			      BRANCH_TRACK_OVERRIDE,
+			      PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
@@ -624,7 +625,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		{
 			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
 			N_("deprecated synonym for --create-reflog"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
 			deprecated_reflog_option_cb
 		},
 		OPT_BOOL(0, "edit-description", &edit_description,
diff --git a/builtin/clone.c b/builtin/clone.c
index fd2c3ef090..27d2a1a459 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -87,8 +87,8 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
-	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
-			N_("create a bare repository")),
+	OPT_HIDDEN_NOCOMPLETE_BOOL(0, "naked", &option_bare,
+				   N_("create a bare repository")),
 	OPT_BOOL(0, "mirror", &option_mirror,
 		 N_("create a mirror repository (implies bare)")),
 	OPT_BOOL('l', "local", &option_local,
@@ -99,8 +99,8 @@ static struct option builtin_clone_options[] = {
 		    N_("setup as shared repository")),
 	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
-	  (intptr_t)"." },
+	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+	  recurse_submodules_cb, (intptr_t)"." },
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 3018e61d04..f63e866dd7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -699,8 +699,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT_F('y', "no-prompt", &prompt,
 			N_("do not prompt before launching a diff tool"),
 			0, PARSE_OPT_NONEG),
-		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
-			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
+		OPT_SET_INT_F(0, "prompt", &prompt, NULL, 1,
+			      PARSE_OPT_NONEG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symlinks", &symlinks,
 			 N_("use symlinks in dir-diff mode")),
 		OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..3f11d743ee 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -153,7 +153,8 @@ static struct option builtin_fetch_options[] = {
 		   &recurse_submodules_default, N_("on-demand"),
 		   N_("default for recursive fetching of submodules "
 		      "(lower priority than config files)"),
-		   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules },
+		   PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+		   option_fetch_parse_recurse_submodules },
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index f35ff1612b..ba0a8426a0 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -672,7 +672,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 		{ OPTION_INTEGER, 0, "summary", &shortlog_len, N_("n"),
 		  N_("alias for --log (deprecated)"),
-		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
+		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+		  NULL,
 		  DEFAULT_MERGE_LOG_LEN },
 		OPT_STRING('m', "message", &message, N_("text"),
 			N_("use <text> as start of message")),
diff --git a/builtin/grep.c b/builtin/grep.c
index ee5a1bd355..2ecd941101 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -892,7 +892,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show only matches from files that match all patterns")),
 		OPT_SET_INT_F(0, "debug", &opt.debug,
 			      N_("show parse tree for grep expression"),
-			      1, PARSE_OPT_HIDDEN),
+			      1, PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE),
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..90c7a85cba 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -47,7 +47,7 @@ static struct option builtin_help_options[] = {
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
-	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
+	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c227..0a63d23761 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -426,7 +426,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			/* A Hidden OPT_BOOL */
 			OPTION_SET_INT, 0, "peel-tag", &peel_tag, NULL,
 			N_("dereference tags in the input (internal use)"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1,
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+			NULL, 1,
 		},
 		OPT_END(),
 	};
diff --git a/builtin/pull.c b/builtin/pull.c
index 4e78935392..cdc67cd17f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -146,7 +146,7 @@ static struct option pull_options[] = {
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
 		N_("(synonym to --stat)"),
-		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE),
 	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 2f13f1316f..afd916fa06 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -161,8 +161,8 @@ static const struct option show_ref_options[] = {
 	OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
 	OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
-	OPT_HIDDEN_BOOL('h', NULL, &show_head,
-			N_("show the HEAD reference, even if it would be filtered out")),
+	OPT_HIDDEN_NOCOMPLETE_BOOL('h', NULL, &show_head,
+				   N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOL(0, "head", &show_head,
 	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOL('d', "dereference", &deref_tags,
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index c9d3c544e7..489a5e46b0 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -29,8 +29,8 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_LITERAL_ARGHELP },
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
 		  N_("only useful for debugging"),
-		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
-		  WRITE_TREE_IGNORE_CACHE_TREE },
+		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG | PARSE_OPT_NOCOMPLETE,
+		  NULL, WRITE_TREE_IGNORE_CACHE_TREE },
 		OPT_END()
 	};
 
diff --git a/parse-options.c b/parse-options.c
index 7db84227ab..a9c82e518a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -437,7 +437,7 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
 
 		if (!opts->long_name)
 			continue;
-		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+		if (opts->flags & PARSE_OPT_NOCOMPLETE)
 			continue;
 		if (opts->flags & PARSE_OPT_NONEG)
 			continue;
@@ -485,7 +485,7 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 
 		if (!opts->long_name)
 			continue;
-		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+		if (opts->flags & PARSE_OPT_NOCOMPLETE)
 			continue;
 
 		switch (opts->type) {
diff --git a/parse-options.h b/parse-options.h
index dd14911a29..5f78e2e164 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -139,6 +139,9 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
+#define OPT_HIDDEN_NOCOMPLETE_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
+						 (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE, \
+						NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5ff43b9cbb..2e0b9c78e7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1423,6 +1423,7 @@ test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
 	--detach Z
+	--guess Z
 	--track Z
 	--orphan=Z
 	--ours Z
-- 
2.18.0.865.gffc8e1a3cd6

