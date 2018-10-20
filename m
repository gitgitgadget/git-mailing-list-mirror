Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E5A1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJTUtf (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJTUtd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so33093633ljg.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35vEo+Dxmer/e9cj8c4tPVMYxgio15AxEdR0Zz9BTJ8=;
        b=YQ2T0a+KJUIATX+Ji4eONdPfuHFZ3FQ5s7kL3kWAuuszq/gjYCPgYx27/USkmiLBch
         uFlOeVOr6qgWWFyg92hSeM3acc7H97Kh4chDhurlKpIUa3NZ6cRq85DPk83aVPTEKLBL
         uar7q0KH0AaKsjMl0kARn1ieWEEhuLzRnCJHLVwDQFhQhBBq8C0KzYB14OXTGr4ZTMRK
         pRZNnh77qu/eThtKNo+CjQSmUvpYbChLVd+I+zQWZC59/4D8/+xwY7PZ9uavxfyUupKE
         fh4ZqQabKDqRxMB8T69Ue69yLcOrEcQayQrUiC8zQdNT2uHxISg7E9DveT4n71E5Rtkd
         SIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35vEo+Dxmer/e9cj8c4tPVMYxgio15AxEdR0Zz9BTJ8=;
        b=I7qbdau2L7ewyshJc9HDpCG3JCsF1bkVD1r3VGTDOE1bbi01o5bvKr4tWQYCaGOE64
         BXKeA1p0TU4VEgpya+RbUkof2PPlhJw+7dJ1Lpp8mz7HV4fJN9m17fNL1t7J1Yocae3d
         mx7rHDejfW0JePPiyNE/+14Ov4zODhI06nHuhISmzz8F2gutNZaIcWDw4gkbdmq1etAZ
         LTbvMQQVzMPorg5Lnjkj81davg3YIKEcVqJeI42XqgrJnyKGQuAC2LEVSUwYmZIJFg24
         fVytIF42w6F/AvPcNy1mSPP4nQR1Xo0SNk1VHoOZzM50foj2EEBj0UqWOFwH7qnikIIl
         1UPw==
X-Gm-Message-State: ABuFfojtQZg7My7ZrTKC5hIEinlY84Lc8Ps785BSCn1ctZB5ovlgSeIq
        DQUfyn+iNNFtFNo8UL8TIzOyusfe
X-Google-Smtp-Source: ACcGV63LIvUY3s7OGy/V3r6FfajqFK6HuaxtGO2qMeAshI6dapgxnTzcsjZgjIJMS/W7USZJkijb0A==
X-Received: by 2002:a2e:3e0b:: with SMTP id l11-v6mr27509279lja.16.1540039149825;
        Sat, 20 Oct 2018 05:39:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/59] config.txt: move color.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:01 +0200
Message-Id: <20181020123848.2785-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/color-config.txt | 201 ++++++++++++++++++++++++++++++++
 Documentation/config.txt       | 202 +--------------------------------
 2 files changed, 202 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/color-config.txt

diff --git a/Documentation/color-config.txt b/Documentation/color-config.txt
new file mode 100644
index 0000000000..8375596c44
--- /dev/null
+++ b/Documentation/color-config.txt
@@ -0,0 +1,201 @@
+color.advice::
+	A boolean to enable/disable color in hints (e.g. when a push
+	failed, see `advice.*` for a list).  May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors
+	are used only when the error output goes to a terminal. If
+	unset, then the value of `color.ui` is used (`auto` by default).
+
+color.advice.hint::
+	Use customized color for hints.
+
+color.blame.highlightRecent::
+	This can be used to color the metadata of a blame line depending
+	on age of the line.
++
+This setting should be set to a comma-separated list of color and date settings,
+starting and ending with a color, the dates should be set from oldest to newest.
+The metadata will be colored given the colors if the the line was introduced
+before the given timestamp, overwriting older timestamped colors.
++
+Instead of an absolute timestamp relative timestamps work as well, e.g.
+2.weeks.ago is valid to address anything older than 2 weeks.
++
+It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
+everything older than one year blue, recent changes between one month and
+one year old are kept white, and lines introduced within the last month are
+colored red.
+
+color.blame.repeatedLines::
+	Use the customized color for the part of git-blame output that
+	is repeated meta information per line (such as commit id,
+	author name, date and timezone). Defaults to cyan.
+
+color.branch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.branch.<slot>::
+	Use customized color for branch coloration. `<slot>` is one of
+	`current` (the current branch), `local` (a local branch),
+	`remote` (a remote-tracking branch in refs/remotes/),
+	`upstream` (upstream tracking branch), `plain` (other
+	refs).
+
+color.diff::
+	Whether to use ANSI escape sequences to add color to patches.
+	If this is set to `always`, linkgit:git-diff[1],
+	linkgit:git-log[1], and linkgit:git-show[1] will use color
+	for all patches.  If it is set to `true` or `auto`, those
+	commands will only use color when output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by
+	default).
++
+This does not affect linkgit:git-format-patch[1] or the
+'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
+command line with the `--color[=<when>]` option.
+
+color.diff.<slot>::
+	Use customized color for diff colorization.  `<slot>` specifies
+	which part of the patch to use the specified color, and is one
+	of `context` (context text - `plain` is a historical synonym),
+	`meta` (metainformation), `frag`
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	`newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details),
+	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
+	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
+
+color.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.  `<slot>` is one
+	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
+	branches, remote-tracking branches, tags, stash and HEAD, respectively
+	and `grafted` for grafted commits.
+
+color.grep::
+	When set to `always`, always highlight matches.  When `false` (or
+	`never`), never.  When set to `true` or `auto`, use color only
+	when the output is written to the terminal.  If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.grep.<slot>::
+	Use customized color for grep colorization.  `<slot>` specifies which
+	part of the line to use the specified color, and is one of
++
+--
+`context`;;
+	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
+`filename`;;
+	filename prefix (when not using `-h`)
+`function`;;
+	function name lines (when using `-p`)
+`lineNumber`;;
+	line number prefix (when using `-n`)
+`column`;;
+	column number prefix (when using `--column`)
+`match`;;
+	matching text (same as setting `matchContext` and `matchSelected`)
+`matchContext`;;
+	matching text in context lines
+`matchSelected`;;
+	matching text in selected lines
+`selected`;;
+	non-matching text in selected lines
+`separator`;;
+	separators between fields on a line (`:`, `-`, and `=`)
+	and between hunks (`--`)
+--
+
+color.interactive::
+	When set to `always`, always use colors for interactive prompts
+	and displays (such as those used by "git-add --interactive" and
+	"git-clean --interactive"). When false (or `never`), never.
+	When set to `true` or `auto`, use colors only when the output is
+	to the terminal. If unset, then the value of `color.ui` is
+	used (`auto` by default).
+
+color.interactive.<slot>::
+	Use customized color for 'git add --interactive' and 'git clean
+	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
+	or `error`, for four distinct types of normal output from
+	interactive commands.
+
+color.pager::
+	A boolean to enable/disable colored output when the pager is in
+	use (default is true).
+
+color.push::
+	A boolean to enable/disable color in push errors. May be set to
+	`always`, `false` (or `never`) or `auto` (or `true`), in which
+	case colors are used only when the error output goes to a terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
+
+color.push.error::
+	Use customized color for push errors.
+
+color.remote::
+	If set, keywords at the start of the line are highlighted. The
+	keywords are "error", "warning", "hint" and "success", and are
+	matched case-insensitively. May be set to `always`, `false` (or
+	`never`) or `auto` (or `true`). If unset, then the value of
+	`color.ui` is used (`auto` by default).
+
+color.remote.<slot>::
+	Use customized color for each remote keyword. `<slot>` may be
+	`hint`, `warning`, `success` or `error` which match the
+	corresponding keyword.
+
+color.showBranch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-show-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.status::
+	A boolean to enable/disable color in the output of
+	linkgit:git-status[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.status.<slot>::
+	Use customized color for status colorization. `<slot>` is
+	one of `header` (the header text of the status message),
+	`added` or `updated` (files which are added but not committed),
+	`changed` (files which are changed but not added in the index),
+	`untracked` (files which are not tracked by Git),
+	`branch` (the current branch),
+	`nobranch` (the color the 'no branch' warning is shown in, defaulting
+	to red),
+	`localBranch` or `remoteBranch` (the local and remote branch names,
+	respectively, when branch and tracking information is displayed in the
+	status short-format), or
+	`unmerged` (files which have unmerged changes).
+
+color.transport::
+	A boolean to enable/disable color when pushes are rejected. May be
+	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
+	case colors are used only when the error output goes to a terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
+
+color.transport.rejected::
+	Use customized color when a push was rejected.
+
+color.ui::
+	This variable determines the default value for variables such
+	as `color.diff` and `color.grep` that control the use of color
+	per command family. Its scope will expand as more commands learn
+	configuration to set a default for the `--color` option.  Set it
+	to `false` or `never` if you prefer Git commands not to use
+	color unless enabled explicitly with some other configuration
+	or the `--color` option. Set it to `always` if you want all
+	output not intended for machine consumption to use color, to
+	`true` or `auto` (this is the default since Git 1.8.4) if you
+	want such output to use color when written to the terminal.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 77acf785d1..9e2c6c292b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -309,207 +309,7 @@ include::checkout-config.txt[]
 
 include::clean-config.txt[]
 
-color.advice::
-	A boolean to enable/disable color in hints (e.g. when a push
-	failed, see `advice.*` for a list).  May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors
-	are used only when the error output goes to a terminal. If
-	unset, then the value of `color.ui` is used (`auto` by default).
-
-color.advice.hint::
-	Use customized color for hints.
-
-color.blame.highlightRecent::
-	This can be used to color the metadata of a blame line depending
-	on age of the line.
-+
-This setting should be set to a comma-separated list of color and date settings,
-starting and ending with a color, the dates should be set from oldest to newest.
-The metadata will be colored given the colors if the the line was introduced
-before the given timestamp, overwriting older timestamped colors.
-+
-Instead of an absolute timestamp relative timestamps work as well, e.g.
-2.weeks.ago is valid to address anything older than 2 weeks.
-+
-It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
-everything older than one year blue, recent changes between one month and
-one year old are kept white, and lines introduced within the last month are
-colored red.
-
-color.blame.repeatedLines::
-	Use the customized color for the part of git-blame output that
-	is repeated meta information per line (such as commit id,
-	author name, date and timezone). Defaults to cyan.
-
-color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.branch.<slot>::
-	Use customized color for branch coloration. `<slot>` is one of
-	`current` (the current branch), `local` (a local branch),
-	`remote` (a remote-tracking branch in refs/remotes/),
-	`upstream` (upstream tracking branch), `plain` (other
-	refs).
-
-color.diff::
-	Whether to use ANSI escape sequences to add color to patches.
-	If this is set to `always`, linkgit:git-diff[1],
-	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	for all patches.  If it is set to `true` or `auto`, those
-	commands will only use color when output is to the terminal.
-	If unset, then the value of `color.ui` is used (`auto` by
-	default).
-+
-This does not affect linkgit:git-format-patch[1] or the
-'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
-command line with the `--color[=<when>]` option.
-
-color.diff.<slot>::
-	Use customized color for diff colorization.  `<slot>` specifies
-	which part of the patch to use the specified color, and is one
-	of `context` (context text - `plain` is a historical synonym),
-	`meta` (metainformation), `frag`
-	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), `whitespace`
-	(highlighting whitespace errors), `oldMoved` (deleted lines),
-	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
-	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
-	`newMovedAlternativeDimmed` (See the '<mode>'
-	setting of '--color-moved' in linkgit:git-diff[1] for details),
-	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
-	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
-
-color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
-
-color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
-	`never`), never.  When set to `true` or `auto`, use color only
-	when the output is written to the terminal.  If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.grep.<slot>::
-	Use customized color for grep colorization.  `<slot>` specifies which
-	part of the line to use the specified color, and is one of
-+
---
-`context`;;
-	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
-`filename`;;
-	filename prefix (when not using `-h`)
-`function`;;
-	function name lines (when using `-p`)
-`lineNumber`;;
-	line number prefix (when using `-n`)
-`column`;;
-	column number prefix (when using `--column`)
-`match`;;
-	matching text (same as setting `matchContext` and `matchSelected`)
-`matchContext`;;
-	matching text in context lines
-`matchSelected`;;
-	matching text in selected lines
-`selected`;;
-	non-matching text in selected lines
-`separator`;;
-	separators between fields on a line (`:`, `-`, and `=`)
-	and between hunks (`--`)
---
-
-color.interactive::
-	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git-add --interactive" and
-	"git-clean --interactive"). When false (or `never`), never.
-	When set to `true` or `auto`, use colors only when the output is
-	to the terminal. If unset, then the value of `color.ui` is
-	used (`auto` by default).
-
-color.interactive.<slot>::
-	Use customized color for 'git add --interactive' and 'git clean
-	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
-	or `error`, for four distinct types of normal output from
-	interactive commands.
-
-color.pager::
-	A boolean to enable/disable colored output when the pager is in
-	use (default is true).
-
-color.push::
-	A boolean to enable/disable color in push errors. May be set to
-	`always`, `false` (or `never`) or `auto` (or `true`), in which
-	case colors are used only when the error output goes to a terminal.
-	If unset, then the value of `color.ui` is used (`auto` by default).
-
-color.push.error::
-	Use customized color for push errors.
-
-color.remote::
-	If set, keywords at the start of the line are highlighted. The
-	keywords are "error", "warning", "hint" and "success", and are
-	matched case-insensitively. May be set to `always`, `false` (or
-	`never`) or `auto` (or `true`). If unset, then the value of
-	`color.ui` is used (`auto` by default).
-
-color.remote.<slot>::
-	Use customized color for each remote keyword. `<slot>` may be
-	`hint`, `warning`, `success` or `error` which match the
-	corresponding keyword.
-
-color.showBranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.status.<slot>::
-	Use customized color for status colorization. `<slot>` is
-	one of `header` (the header text of the status message),
-	`added` or `updated` (files which are added but not committed),
-	`changed` (files which are changed but not added in the index),
-	`untracked` (files which are not tracked by Git),
-	`branch` (the current branch),
-	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red),
-	`localBranch` or `remoteBranch` (the local and remote branch names,
-	respectively, when branch and tracking information is displayed in the
-	status short-format), or
-	`unmerged` (files which have unmerged changes).
-
-color.transport::
-	A boolean to enable/disable color when pushes are rejected. May be
-	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
-	case colors are used only when the error output goes to a terminal.
-	If unset, then the value of `color.ui` is used (`auto` by default).
-
-color.transport.rejected::
-	Use customized color when a push was rejected.
-
-color.ui::
-	This variable determines the default value for variables such
-	as `color.diff` and `color.grep` that control the use of color
-	per command family. Its scope will expand as more commands learn
-	configuration to set a default for the `--color` option.  Set it
-	to `false` or `never` if you prefer Git commands not to use
-	color unless enabled explicitly with some other configuration
-	or the `--color` option. Set it to `always` if you want all
-	output not intended for machine consumption to use color, to
-	`true` or `auto` (this is the default since Git 1.8.4) if you
-	want such output to use color when written to the terminal.
+include::color-config.txt[]
 
 column.ui::
 	Specify whether supported commands should output in columns.
-- 
2.19.1.647.g708186aaf9

