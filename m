Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1C61F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeETSkx (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44346 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeETSkf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id h197-v6so20753155lfg.11
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/giG/ApctzUt106b3b2FR7brrZC9hJLDWf34mWvciP8=;
        b=aACYd5a+9885IfLzcv62UvkZqQXvCkUkh4godtyuQXOQlubTrGtroi5GVyIlwV9Gpt
         h9shqCvrEaDg+UQ8Xw/mK7HUJfdAdg5Whb4lWJ7wgLtPI4Xti2Udlr676fsYKivzuY91
         56U1vti31QCa+9Rgy+p0gdg2JzKevQmwEgaklcEtYmVcybpgpdf0r3bkZqSigORAsR7i
         A4a3f0M7NL6BcIGb6EnvPgIhjw+skxki35p9khptvsIvN4nYixaNZXsrx5jOubdTATj9
         l7gwtCGSLR0w+kl4mlH6OvYysIkq7KY+B9I3C/aKFyhTWjBRsxCPlOwTDU3ER1Q2hMRx
         p9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/giG/ApctzUt106b3b2FR7brrZC9hJLDWf34mWvciP8=;
        b=ChsHrUzKHcmow+Wt7eHq5ZgWfcVUXBI9JnzngJ4oh61eyzaE7zEwOopQV6i04tlUR0
         C/sVmU7jqJdz9Ya9zKmGxirYjdH35vml3Pp6mE4PG5BISxPhB8I+cjZpxi4IZsgQKABf
         KtY6ReDm0qXVoP7ClwVqkXpY4rsxCDPFifEX5SInS3HooxeQLofsydKa8xukkfVZ1jYt
         gvzmMdyPKcyytbS6Nc3cZbhB+lUdE/jHrtn+r2foWyE4c+HguzZ2mldyY9asX9juKfRX
         bHu6+ZPfBlNyLUbraWvgufIDIkkW8Os6R3J7JrBiGpTQXTD9diAwGRKTT25jeDu3bKYS
         he2w==
X-Gm-Message-State: ALKqPwfPdrRRuzjlJ19+1qxJdYugmlxlAfsq1bL1SI7WL2jXXEsoKuji
        1VWlF/ia/4B0Wipq/2Qdhvyppg==
X-Google-Smtp-Source: AB8JxZpB58N22M8tfAEEWJbno0mjV1Hu8Qkrxox2yGdgHvL9K9b+Ac0a960xI+CaJ/cJcPb+Z9yhsg==
X-Received: by 2002:a19:2143:: with SMTP id h64-v6mr24715734lfh.73.1526841633615;
        Sun, 20 May 2018 11:40:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/17] completion: let git provide the completable command list
Date:   Sun, 20 May 2018 20:40:04 +0200
Message-Id: <20180520184009.976-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of maintaining a separate list of command classification,
which often could go out of date, let's centralize the information
back in git.

While the function in git-completion.bash implies "list porcelain
commands", that's not exactly what it does. It gets all commands (aka
--list-cmds=main,others) then exclude certain non-porcelain ones. We
could almost recreate this list two lists list-mainporcelain and
others. The non-porcelain-but-included-anyway is added by the third
category list-complete.

Note that the current completion script incorrectly classifies
filter-branch as porcelain and t9902 tests this behavior. We keep it
this way in t9902 because this test does not really care which
particular command is porcelain or plumbing, they're just names.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt                       |  53 +++++------
 contrib/completion/git-completion.bash | 119 ++++++-------------------
 t/t9902-completion.sh                  |   5 +-
 3 files changed, 58 insertions(+), 119 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index a2f360eab9..dcf1907a54 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,12 +47,12 @@
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
-git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators
+git-annotate                            ancillaryinterrogators          complete
+git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
-git-blame                               ancillaryinterrogators
+git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
@@ -62,7 +62,7 @@ git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators
+git-cherry                              ancillaryinterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
@@ -70,7 +70,7 @@ git-clone                               mainporcelain           init
 git-column                              purehelpers
 git-commit                              mainporcelain           history
 git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators
+git-config                              ancillarymanipulators           complete
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
 git-credential-cache                    purehelpers
@@ -84,30 +84,30 @@ git-diff                                mainporcelain           history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
-git-difftool                            ancillaryinterrogators
+git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
 git-fetch-pack                          synchingrepositories
-git-filter-branch                       ancillarymanipulators
+git-filter-branch                       ancillarymanipulators           complete
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck                                ancillaryinterrogators
+git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
-git-get-tar-commit-id                   ancillaryinterrogators
+git-get-tar-commit-id                   ancillaryinterrogators          complete
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help                                ancillaryinterrogators
+git-help                                ancillaryinterrogators          complete
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
-git-imap-send                           foreignscminterface
+git-imap-send                           foreignscminterface             complete
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
-git-instaweb                            ancillaryinterrogators
-git-interpret-trailers                  purehelpers
+git-instaweb                            ancillaryinterrogators          complete
+git-interpret-trailers                  purehelpers                     complete
 gitk                                    mainporcelain
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
@@ -120,14 +120,14 @@ git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
-git-mergetool                           ancillarymanipulators
+git-mergetool                           ancillarymanipulators           complete
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators
+git-name-rev                            plumbinginterrogators           complete
 git-notes                               mainporcelain
-git-p4                                  foreignscminterface
+git-p4                                  foreignscminterface             complete
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
@@ -141,32 +141,33 @@ git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
-git-reflog                              ancillarymanipulators
-git-remote                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-replace                             ancillarymanipulators
-git-request-pull                        foreignscminterface
+git-reflog                              ancillarymanipulators           complete
+git-remote                              ancillarymanipulators           complete
+git-repack                              ancillarymanipulators           complete
+git-replace                             ancillarymanipulators           complete
+git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain           worktree
-git-send-email                          foreignscminterface
+git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain           info
-git-show-branch                         ancillaryinterrogators
+git-show-branch                         ancillaryinterrogators          complete
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
+git-stage                                                               complete
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
-git-svn                                 foreignscminterface
+git-svn                                 foreignscminterface             complete
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain           history
 git-unpack-file                         plumbinginterrogators
@@ -177,11 +178,11 @@ git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
 git-var                                 plumbinginterrogators
-git-verify-commit                       ancillaryinterrogators
+git-verify-commit                       ancillaryinterrogators          complete
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           guide
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4e724a5b76..cd1d8e553f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -834,19 +834,33 @@ __git_complete_strategy ()
 	return 1
 }
 
+# __git_commands requires 1 argument:
+# 1: the command group, either "all" or "porcelain"
 __git_commands () {
-	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
-	then
-		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
-	else
-		git --list-cmds=main,others
-	fi
+	case "$1" in
+	porcelain)
+		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		else
+			git --list-cmds=list-mainporcelain,others,list-complete
+		fi
+		;;
+	all)
+		if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
+		else
+			git --list-cmds=main,others
+		fi
+		;;
+	esac
 }
 
-__git_list_all_commands ()
+__git_list_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(__git_commands)
+	for i in $(__git_commands $1)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -855,6 +869,11 @@ __git_list_all_commands ()
 	done
 }
 
+__git_list_all_commands ()
+{
+	__git_list_commands all
+}
+
 __git_all_commands=
 __git_compute_all_commands ()
 {
@@ -864,89 +883,7 @@ __git_compute_all_commands ()
 
 __git_list_porcelain_commands ()
 {
-	local i IFS=" "$'\n'
-	__git_compute_all_commands
-	for i in $__git_all_commands
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ignore)     : plumbing;;
-		check-mailmap)    : plumbing;;
-		check-ref-format) : plumbing;;
-		checkout-index)   : plumbing;;
-		column)           : internal helper;;
-		commit-tree)      : plumbing;;
-		count-objects)    : infrequent;;
-		credential)       : credentials;;
-		credential-*)     : credentials helper;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fast-export)      : export;;
-		fsck-objects)     : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		ls-files)         : plumbing;;
-		ls-remote)        : plumbing;;
-		ls-tree)          : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		remote-*)         : transport;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		show-ref)         : plumbing;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		symbolic-ref)     : plumbing;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		var)              : infrequent;;
-		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
+	__git_list_commands porcelain
 }
 
 __git_porcelain_commands=
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1b34caa1e1..2f16679380 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
 
-# Be careful when updating this list:
+# Be careful when updating these lists:
 #
 # (1) The build tree may have build artifact from different branch, or
 #     the user's $PATH may have a random executable that may begin
@@ -30,7 +30,8 @@ complete ()
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
 #     "filter-branch" and "ls-files" are listed for this.
 
-GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
-- 
2.17.0.705.g3525833791

