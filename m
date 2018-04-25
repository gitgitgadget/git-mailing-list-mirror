Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AF61F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755831AbeDYQcG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:32:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44972 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755499AbeDYQbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so26359762lfg.11
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTGe/u55m62wV40evwmxsQ3AaAcCfg5uoW8LIUWZtKo=;
        b=s6v5yIcEpM2ol74RSelalvCvOPRxZynYHjpUzbMuRFCSfLvDYp/TRm2rPCWUYE5Vqr
         5MaSLcAxU2vGRmNgg9POQTs1FjIyS3kAUumoQ+Y+VrlO0xedFhHhmEqapk/eJIIwpkVT
         R/g+D6L8Cij1AaGAeliGkpLP+xLIlGSFb/fulAMDuYH8QOp1METtkqcfNQNYWkeLIALs
         3xkN49BtxG49IPyRdkowkR/D6hnnaLlmT2vY989o4Cf+vIObSDBj5Wn7FTmox2f/2KoQ
         aH35Zi6x1t+f+6FpLf/YIT7dC0y/+toMQQ0gq5u0PQME5BihYiTIcngrXPQ64x3PFbal
         8QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTGe/u55m62wV40evwmxsQ3AaAcCfg5uoW8LIUWZtKo=;
        b=IZDME52Wl7Z5RhYId2CAQ1rMu4boIFIkx306oB7GN7fOkhFmnYZY7QfhgWgoAib63X
         SUfj8EsTIK61vg8Xxkqtkk79FqqTbUEA/tGR3HDLlB/qzeocPefaQsQZo35Fff8XR7u1
         T9PokMHfJn1TUl6ECg71CHMIOy+aC+RP6cIeNx/UZvuwm7vKYB2/7+T0fsy2lbfu7mP6
         zLmgT85SikNrRwtfqHd/DILaIwwA/8lZPC5PKawdPFTnqRS4aBrjnWJhe884P7hKBcSz
         OFx44q+K9nsZ6TLVPspwD3Oq5bIAX0fbfL7hz+xBleN9A7oGdNxQ6HtgBCJMgiFCxf0o
         85bQ==
X-Gm-Message-State: ALQs6tBthSeM0mcXMChD+zCwfdritHLD74JIrEiWf/T/QJqEWlpByQnl
        1sgc31souBqxKvxT0lsALU8=
X-Google-Smtp-Source: AB8JxZqEZo7TybbxXCnPICtifSoD2YxPlklJqyXIrzawurE8nj/mwaqrfODu7kccqPkNoBI6i7MagA==
X-Received: by 2002:a19:fc04:: with SMTP id a4-v6mr15094449lfi.136.1524673901899;
        Wed, 25 Apr 2018 09:31:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 12/12] completion: let git provide the completable command list
Date:   Wed, 25 Apr 2018 18:31:07 +0200
Message-Id: <20180425163107.10399-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
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

Note that the current completion script incorrectly classifies
filter-branch as porcelain and t9902 tests this behavior. We keep it
this way in t9902 because this test does not really care which
particular command is porcelain or plubmbing, they're just names.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 119 +++++--------------------
 t/t9902-completion.sh                  |   5 +-
 2 files changed, 25 insertions(+), 99 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a5f13ade20..c74d1d7684 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -835,18 +835,30 @@ __git_complete_strategy ()
 }
 
 __git_commands () {
-	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
-	then
-		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
-	else
-		git --list-cmds=all
-	fi
+	case "$1" in
+	porcelain)
+		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		else
+			git --list-cmds=mainporcelain --list-cmds=complete
+		fi
+		;;
+	all)
+		if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+		then
+			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST";;
+		else
+			git --list-cmds=all
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
@@ -859,101 +871,14 @@ __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
-}
-
-__git_list_porcelain_commands ()
-{
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
+	__git_all_commands=$(__git_list_commands all)
 }
 
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_porcelain_commands=$(__git_list_commands porcelain)
 }
 
 # Lists all set config variables starting with the given section prefix,
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
2.17.0.519.gb89679a4aa

