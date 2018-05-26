Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B021F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbeEZN4D (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:56:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54792 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754312AbeEZNzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so21131233wmc.4
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHt8DZvC+tHqfTVf1TVfwHJ2qMqjyYMT8m8wjZSIwEU=;
        b=uoTTLuhWSAhAccbZedbEDGMQ5gT6Xb1VuFKuY7SmXmD0pyUkEUPiVG/SCYF4yKxMZQ
         /9aZL5zpTG31mJSZBvQ86cg7aCT6xTzf+S7wFtOzopJzSNK5pE5aArGgEweV9yCxHdn/
         Lp7P2fEg4JTzq+u+Fdepbc4YhHRNFc2gKfTPJjIWgi5KFkiQfr56C3Q31MZ1tj2sOgyZ
         5nG6k7xtxGDrBYEpH0jehTamBeH/Fpj/L2RBuK2hbu1Q96g7/Y/+EwrDzyhJdFi78Z85
         TMlmqhWZH4gcH3hriXnxBTO4KFeM6/AoYYzFJ6vxV+v5ffIa8ZOOXUu8U9PWm6syxrVm
         E5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHt8DZvC+tHqfTVf1TVfwHJ2qMqjyYMT8m8wjZSIwEU=;
        b=PXMbZ18VBM9PNG4A2rCa5MM3K/+TOhewVSR2ly3ZDWwQmBI3nPpjZRi+Bdrg05y4pG
         ZnNVfA/Lqp2ymiMocLTi34vYS64ZWG9bRa8D/zCmZsRMWqMv0ecKmsO7IQ6ThtalKKGT
         bEyuj6ZraDAChFZlfkWVKbVKPPlqMoldiHuprgPluKrU/r59KMDD41NA8B5HF+CI/Ohu
         KC+qyRNG8hBzNmrbeFVNwV7N1rOB7iAsJNcgFpe3OlTkmNsaYZLN9Jt6FbovMVidcLRK
         N9ZHZY017VhJRzueTVPEZ4g3RBqVBkxJgypJh8itJj5svp6FpZBXyslc2wLaQwGFy8pC
         5rKw==
X-Gm-Message-State: ALKqPwcnlDMCU3HVIoEHDYbdl6lz42zj4jM9mymNmmZ34XjYl0BnZ1VJ
        6jFWtiM+/gZuP8+H/7htmMc=
X-Google-Smtp-Source: AB8JxZrlGmQwZJ09TFey88oEksLID+Ds4sOksSwrTL4pRqjqPSsTprepQc7dHXZPAhZyT11wDQUlnw==
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr4202117lja.100.1527342948286;
        Sat, 26 May 2018 06:55:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 08/11] completion: drop the hard coded list of config vars
Date:   Sat, 26 May 2018 15:55:28 +0200
Message-Id: <20180526135531.4516-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new help option --config-for-completion is a machine friendlier
version of --config where all the placeholders and wildcards are
dropped, leaving only the good, completable prefixes for
git-completion.bash to consume.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/help.c                         |   9 +-
 contrib/completion/git-completion.bash | 335 +------------------------
 help.c                                 |  34 ++-
 help.h                                 |   2 +-
 4 files changed, 49 insertions(+), 331 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index ccb206e1d4..8d4f6dd301 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -47,6 +47,7 @@ static struct option builtin_help_options[] = {
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
+	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -447,8 +448,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_config) {
+		int for_human = show_config == 1;
+
+		if (!for_human) {
+			list_config_help(for_human);
+			return 0;
+		}
 		setup_pager();
-		list_config_help();
+		list_config_help(for_human);
 		printf("\n%s\n", _("'git help config' for more information"));
 		return 0;
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 12814e9bbf..1b0c30ed9a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2142,6 +2142,13 @@ __git_config_get_set_variables ()
 	__git config $config_file --name-only --list
 }
 
+__git_config_vars=
+__git_compute_config_vars ()
+{
+	test -n "$__git_config_vars" ||
+	__git_config_vars="$(git help --config-for-completion | sort | uniq)"
+}
+
 _git_config ()
 {
 	case "$prev" in
@@ -2300,332 +2307,8 @@ _git_config ()
 		return
 		;;
 	esac
-	__gitcomp "
-		add.ignoreErrors
-		advice.amWorkDir
-		advice.commitBeforeMerge
-		advice.detachedHead
-		advice.implicitIdentity
-		advice.pushAlreadyExists
-		advice.pushFetchFirst
-		advice.pushNeedsForce
-		advice.pushNonFFCurrent
-		advice.pushNonFFMatching
-		advice.pushUpdateRejected
-		advice.resolveConflict
-		advice.rmHints
-		advice.statusHints
-		advice.statusUoption
-		advice.ignoredHook
-		alias.
-		am.keepcr
-		am.threeWay
-		apply.ignorewhitespace
-		apply.whitespace
-		branch.autosetupmerge
-		branch.autosetuprebase
-		browser.
-		clean.requireForce
-		color.branch
-		color.branch.current
-		color.branch.local
-		color.branch.plain
-		color.branch.remote
-		color.decorate.HEAD
-		color.decorate.branch
-		color.decorate.remoteBranch
-		color.decorate.stash
-		color.decorate.tag
-		color.diff
-		color.diff.commit
-		color.diff.frag
-		color.diff.func
-		color.diff.meta
-		color.diff.new
-		color.diff.old
-		color.diff.plain
-		color.diff.whitespace
-		color.grep
-		color.grep.context
-		color.grep.filename
-		color.grep.function
-		color.grep.linenumber
-		color.grep.match
-		color.grep.selected
-		color.grep.separator
-		color.interactive
-		color.interactive.error
-		color.interactive.header
-		color.interactive.help
-		color.interactive.prompt
-		color.pager
-		color.showbranch
-		color.status
-		color.status.added
-		color.status.changed
-		color.status.header
-		color.status.localBranch
-		color.status.nobranch
-		color.status.remoteBranch
-		color.status.unmerged
-		color.status.untracked
-		color.status.updated
-		color.ui
-		commit.cleanup
-		commit.gpgSign
-		commit.status
-		commit.template
-		commit.verbose
-		core.abbrev
-		core.askpass
-		core.attributesfile
-		core.autocrlf
-		core.bare
-		core.bigFileThreshold
-		core.checkStat
-		core.commentChar
-		core.commitGraph
-		core.compression
-		core.createObject
-		core.deltaBaseCacheLimit
-		core.editor
-		core.eol
-		core.excludesfile
-		core.fileMode
-		core.fsyncobjectfiles
-		core.gitProxy
-		core.hideDotFiles
-		core.hooksPath
-		core.ignoreStat
-		core.ignorecase
-		core.logAllRefUpdates
-		core.loosecompression
-		core.notesRef
-		core.packedGitLimit
-		core.packedGitWindowSize
-		core.packedRefsTimeout
-		core.pager
-		core.precomposeUnicode
-		core.preferSymlinkRefs
-		core.preloadindex
-		core.protectHFS
-		core.protectNTFS
-		core.quotepath
-		core.repositoryFormatVersion
-		core.safecrlf
-		core.sharedRepository
-		core.sparseCheckout
-		core.splitIndex
-		core.sshCommand
-		core.symlinks
-		core.trustctime
-		core.untrackedCache
-		core.warnAmbiguousRefs
-		core.whitespace
-		core.worktree
-		credential.helper
-		credential.useHttpPath
-		credential.username
-		credentialCache.ignoreSIGHUP
-		diff.autorefreshindex
-		diff.external
-		diff.ignoreSubmodules
-		diff.mnemonicprefix
-		diff.noprefix
-		diff.renameLimit
-		diff.renames
-		diff.statGraphWidth
-		diff.submodule
-		diff.suppressBlankEmpty
-		diff.tool
-		diff.wordRegex
-		diff.algorithm
-		difftool.
-		difftool.prompt
-		fetch.recurseSubmodules
-		fetch.unpackLimit
-		format.attach
-		format.cc
-		format.coverLetter
-		format.from
-		format.headers
-		format.numbered
-		format.pretty
-		format.signature
-		format.signoff
-		format.subjectprefix
-		format.suffix
-		format.thread
-		format.to
-		gc.
-		gc.aggressiveDepth
-		gc.aggressiveWindow
-		gc.auto
-		gc.autoDetach
-		gc.autopacklimit
-		gc.logExpiry
-		gc.packrefs
-		gc.pruneexpire
-		gc.reflogexpire
-		gc.reflogexpireunreachable
-		gc.rerereresolved
-		gc.rerereunresolved
-		gc.worktreePruneExpire
-		gitcvs.allbinary
-		gitcvs.commitmsgannotation
-		gitcvs.dbTableNamePrefix
-		gitcvs.dbdriver
-		gitcvs.dbname
-		gitcvs.dbpass
-		gitcvs.dbuser
-		gitcvs.enabled
-		gitcvs.logfile
-		gitcvs.usecrlfattr
-		guitool.
-		gui.blamehistoryctx
-		gui.commitmsgwidth
-		gui.copyblamethreshold
-		gui.diffcontext
-		gui.encoding
-		gui.fastcopyblame
-		gui.matchtrackingbranch
-		gui.newbranchtemplate
-		gui.pruneduringfetch
-		gui.spellingdictionary
-		gui.trustmtime
-		help.autocorrect
-		help.browser
-		help.format
-		http.lowSpeedLimit
-		http.lowSpeedTime
-		http.maxRequests
-		http.minSessions
-		http.noEPSV
-		http.postBuffer
-		http.proxy
-		http.sslCipherList
-		http.sslVersion
-		http.sslCAInfo
-		http.sslCAPath
-		http.sslCert
-		http.sslCertPasswordProtected
-		http.sslKey
-		http.sslVerify
-		http.useragent
-		i18n.commitEncoding
-		i18n.logOutputEncoding
-		imap.authMethod
-		imap.folder
-		imap.host
-		imap.pass
-		imap.port
-		imap.preformattedHTML
-		imap.sslverify
-		imap.tunnel
-		imap.user
-		init.templatedir
-		instaweb.browser
-		instaweb.httpd
-		instaweb.local
-		instaweb.modulepath
-		instaweb.port
-		interactive.singlekey
-		log.date
-		log.decorate
-		log.showroot
-		mailmap.file
-		man.
-		man.viewer
-		merge.
-		merge.conflictstyle
-		merge.log
-		merge.renameLimit
-		merge.renormalize
-		merge.stat
-		merge.tool
-		merge.verbosity
-		mergetool.
-		mergetool.keepBackup
-		mergetool.keepTemporaries
-		mergetool.prompt
-		notes.displayRef
-		notes.rewrite.
-		notes.rewrite.amend
-		notes.rewrite.rebase
-		notes.rewriteMode
-		notes.rewriteRef
-		pack.compression
-		pack.deltaCacheLimit
-		pack.deltaCacheSize
-		pack.depth
-		pack.indexVersion
-		pack.packSizeLimit
-		pack.threads
-		pack.window
-		pack.windowMemory
-		pager.
-		pretty.
-		pull.octopus
-		pull.twohead
-		push.default
-		push.followTags
-		rebase.autosquash
-		rebase.stat
-		receive.autogc
-		receive.denyCurrentBranch
-		receive.denyDeleteCurrent
-		receive.denyDeletes
-		receive.denyNonFastForwards
-		receive.fsckObjects
-		receive.unpackLimit
-		receive.updateserverinfo
-		remote.pushdefault
-		remotes.
-		repack.usedeltabaseoffset
-		rerere.autoupdate
-		rerere.enabled
-		sendemail.
-		sendemail.aliasesfile
-		sendemail.aliasfiletype
-		sendemail.bcc
-		sendemail.cc
-		sendemail.cccmd
-		sendemail.chainreplyto
-		sendemail.confirm
-		sendemail.envelopesender
-		sendemail.from
-		sendemail.identity
-		sendemail.multiedit
-		sendemail.signedoffbycc
-		sendemail.smtpdomain
-		sendemail.smtpencryption
-		sendemail.smtppass
-		sendemail.smtpserver
-		sendemail.smtpserveroption
-		sendemail.smtpserverport
-		sendemail.smtpuser
-		sendemail.suppresscc
-		sendemail.suppressfrom
-		sendemail.thread
-		sendemail.to
-		sendemail.tocmd
-		sendemail.validate
-		sendemail.smtpbatchsize
-		sendemail.smtprelogindelay
-		showbranch.default
-		status.relativePaths
-		status.showUntrackedFiles
-		status.submodulesummary
-		submodule.
-		tar.umask
-		transfer.unpackLimit
-		url.
-		user.email
-		user.name
-		user.signingkey
-		web.browser
-		branch. remote.
-	"
+	__git_compute_config_vars
+	__gitcomp "$__git_config_vars"
 }
 
 _git_remote ()
diff --git a/help.c b/help.c
index f078dfebad..3ebf0568db 100644
--- a/help.c
+++ b/help.c
@@ -416,7 +416,7 @@ struct slot_expansion {
 	int found;
 };
 
-void list_config_help(void)
+void list_config_help(int for_human)
 {
 	struct slot_expansion slot_expansions[] = {
 		{ "advice", "*", list_config_advices },
@@ -460,8 +460,36 @@ void list_config_help(void)
 			    e->prefix, e->placeholder);
 
 	string_list_sort(&keys);
-	for (i = 0; i < keys.nr; i++)
-		puts(keys.items[i].string);
+	for (i = 0; i < keys.nr; i++) {
+		const char *var = keys.items[i].string;
+		const char *wildcard, *tag, *cut;
+
+		if (for_human) {
+			puts(var);
+			continue;
+		}
+
+		wildcard = strchr(var, '*');
+		tag = strchr(var, '<');
+
+		if (!wildcard && !tag) {
+			puts(var);
+			continue;
+		}
+
+		if (wildcard && !tag)
+			cut = wildcard;
+		else if (!wildcard && tag)
+			cut = tag;
+		else
+			cut = wildcard < tag ? wildcard : tag;
+
+		/*
+		 * We may produce duplicates, but that's up to
+		 * git-completion.bash to handle
+		 */
+		printf("%.*s\n", (int)(cut - var), var);
+	}
 	string_list_clear(&keys, 0);
 }
 
diff --git a/help.h b/help.h
index b46fe6ee73..f8b15323a6 100644
--- a/help.h
+++ b/help.h
@@ -22,7 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
 extern void list_common_guides_help(void);
-extern void list_config_help(void);
+extern void list_config_help(int for_human);
 
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
-- 
2.17.0.705.g3525833791

