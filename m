Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636B62023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdCCL5p (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:57:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35327 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdCCL5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:57:42 -0500
Received: by mail-pf0-f193.google.com with SMTP id 67so5352188pfg.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dhV7KS3z/kC7bbAsgDRdAMY/IRPOIW5L5sXLon0Vso0=;
        b=W6OvNKfF8h31z2p1XH0XxdthdvLxQ6xWcXIzqOAeNPl3bVdMiY+OuOKIQceptFxi8L
         rtNMQwgJi5UMLqsth0mQd+MdP9G9XPyK8BiH7wIxvNlS3lCy6IJ1hDsE1t+MeDGstae/
         DJuiizzwv/uI86tYT8NvZhu03Zd7Qok36nGjm5A0Eew0McJ1ZGum/OmXm6YLAma/TdR5
         v6bALTpuqiIxIWGustjFgSprAArnQfdlvjrhdVy/O5sGl5LBVFMat2CscN6IcXIgRmJp
         XrgFUYVmBL2jmPyLaj7pfZ1A0i6uVZ2gCXNSQUkrcETwJ/u0riFxnF//B48aX7pIJeG/
         fFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dhV7KS3z/kC7bbAsgDRdAMY/IRPOIW5L5sXLon0Vso0=;
        b=oiazUixQKYko/ingnOnTBiAlhLuLmECVGDeKMVr3LDcg/G66xXZxdDuGxDUQFWLW8N
         P+MG/Fh2z8TwTSW8ibPaVxMjTKmrfeNkh3vbLQFOK/lsJ+WmwdVdzUrNdKtLgAi1V53M
         gnvn2RiiECBls184zRzTaQN4T9rQvo4rzcREXDSO5LEJNxKHC15N8ntWF6/rLA/i7F85
         wYt/txTc+ld+B22/fwMhZBC/KPdhl3HItzJAniqj8+5/NfE/U0usQMmQtnuJHqdH6Sz6
         bkn26MBgaq0vAsi12CHUd7ogpzeCHcWi2HZK0acRpaIOnGr3ShG0PEcx2otKb07vPRUc
         k5qQ==
X-Gm-Message-State: AMke39laKvPL7bjZ/oWUKiAhsRY1Sgddx2FtiD/XaCe8b8NwQmFGqBux0yv+5sbe8lUQow==
X-Received: by 10.84.236.4 with SMTP id q4mr3839974plk.1.1488542261303;
        Fri, 03 Mar 2017 03:57:41 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id v86sm23102971pfa.58.2017.03.03.03.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 03:57:40 -0800 (PST)
Date:   Fri, 3 Mar 2017 03:57:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH 1/3] Add --gui option to mergetool
Message-ID: <20170303115738.GA13211@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the discrepancy between difftool and mergetool where the
former has the --gui flag and the latter does not by adding the
functionality to mergetool.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool.txt        |  8 +++++++-
 contrib/completion/git-completion.bash |  3 ++-
 git-mergetool.sh                       |  5 ++++-
 t/t7610-mergetool.sh                   | 28 +++++++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 3622d6648..2ab56efcf 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
+'git mergetool' [--tool=<tool>] [-g|--gui] [-y | --[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------
@@ -64,6 +64,12 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
+-g::
+--gui::
+	When 'git-mergetool' is invoked with the `-g` or `--gui` option
+	the default diff tool will be read from the configured
+	`merge.guitool` variable instead of `merge.tool`.
+
 --tool-help::
 	Print a list of merge tools that may be used with `--tool`.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41ee52991..d5f3b9aeb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1584,7 +1584,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui"
 		return
 		;;
 	esac
@@ -2308,6 +2308,7 @@ _git_config ()
 		merge.renormalize
 		merge.stat
 		merge.tool
+		merge.guitool
 		merge.verbosity
 		mergetool.
 		mergetool.keepBackup
diff --git a/git-mergetool.sh b/git-mergetool.sh
index c062e3de3..f3fce528b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -9,7 +9,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
+USAGE='[--tool=tool] [-g|--gui] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
@@ -414,6 +414,9 @@ main () {
 				shift ;;
 			esac
 			;;
+		-g|--gui)
+			merge_tool=$(git config merge.guitool)
+			;;
 		-y|--no-prompt)
 			prompt=false
 			;;
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 381b7df45..5683907ab 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -123,7 +123,9 @@ test_expect_success 'setup' '
 	git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	git config mergetool.mytool.trustExitCode true &&
 	git config mergetool.mybase.cmd "cat \"\$BASE\" >\"\$MERGED\"" &&
-	git config mergetool.mybase.trustExitCode true
+	git config mergetool.mybase.trustExitCode true &&
+	git config mergetool.badtool.cmd false &&
+	git config mergetool.badtool.trustExitCode true
 '
 
 test_expect_success 'custom mergetool' '
@@ -145,6 +147,30 @@ test_expect_success 'custom mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool' '
+	test_when_finished "git reset --hard" &&
+	test_when_finished "git config merge.tool mytool" &&
+	test_when_finished "git config --unset merge.guitool" &&
+	git config merge.tool badtool &&
+	git config merge.guitool mytool &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master >/dev/null 2>&1 &&
+	( yes "" | git mergetool -g both >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool -g file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
+	cat file1 &&
+	test "$(cat file1)" = "master updated" &&
+	test "$(cat file2)" = "master new" &&
+	test "$(cat subdir/file3)" = "master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with gui mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.12.0.1.g5415fdfc5.dirty

