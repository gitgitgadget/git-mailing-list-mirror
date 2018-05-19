Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B4E1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeESE2c (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38824 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeESE2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id z142-v6so16760276lff.5
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Q9g6uMKLJMHHgifjI9DFAP32StxJxS+v+HUvps6SnI=;
        b=ecz+VaBDX3LPHt/9x7LKLdZxYf7Wds3DqcKSGI3NLLR3iDbtm2D8lSuLRhzZnthbEV
         2PbkOjUjGNOEdPW3hbOmwbYw8x23gUS5hdeBze06yQLF09abUbw7+MmOXRyK9Q1f1HGU
         aMUtQ5bSF1tQ1+1eqswJfXwWYCMyQVrsJug1WgCISIdF0jk9ZaHxRRhOOglYnBCkS5S/
         uL7KFmkE75ZopJXJZdjwhu7Ub3E4JCnzBVu13cwt0J499+Mnnk7anOIAF5wfoLX5nRUz
         G1by7wYLoihVfHvi3KgEnRRnGKMUmXL2f8mZPoH4uTkN8o8R9f/mcXVXkQuF2c6TeM27
         gdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Q9g6uMKLJMHHgifjI9DFAP32StxJxS+v+HUvps6SnI=;
        b=EeS4vAiyHVUbwkb8LychOXBQV+0Eu7mzaHDvQnhg++0l/SS8/vxYTMotHinacuhirP
         Pf8tDSTi8eIdIuiCtpdiFcw6U57IhHbAl/UJ35bpFiw1+IAxi+oB9vN+hRE2rtJ4i0nY
         7NJ6WzIga/p04bERRO0nuJSmJ/jpyBWyWOL1U/No+II2d+AZW5sdrIubnZnLfWe0pphw
         pyrkIvrc/WSo6B/4XrE29Ckm1DIFRMIi/OMkfRH4s1m7XsZbM3rFVTtiLXG2NhzHI5iz
         z95aK6NFP1dgmH11loKg5oPjpegixAblPch+3hRsY71wyXw0wDgAaNapP9xeUVY9HCL6
         g8lg==
X-Gm-Message-State: ALKqPweVNYZmRosOaC3ATKfBMnN0nOJYJ/XNgV7j89mhBiqZ005R0z51
        m8e6LjABK1HWUCaW+6Wc/l9+RA==
X-Google-Smtp-Source: AB8JxZpKQLzYpdH4ED/t6ZHxrCG3MujvOSff6se3WbT9lBCUb5wS4ZOwaauAHDfAgUvq5Z5hi4oX+g==
X-Received: by 2002:a19:2b0b:: with SMTP id r11-v6mr3059337lfr.112.1526704090368;
        Fri, 18 May 2018 21:28:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/14] completion: let git provide the completable command list
Date:   Sat, 19 May 2018 06:27:50 +0200
Message-Id: <20180519042752.8666-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
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

list-complete does not recreate exactly the command list before this
patch though. The following commands will disappear from the complete
list because they are not in command-list.txt and it's not worth
adding them back: lost-found, peek-remote and tar-tree.

Note that the current completion script incorrectly classifies
filter-branch as porcelain and t9902 tests this behavior. We keep it
this way in t9902 because this test does not really care which
particular command is porcelain or plubmbing, they're just names.

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

