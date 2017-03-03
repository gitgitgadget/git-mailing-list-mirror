Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52D020133
	for <e@80x24.org>; Fri,  3 Mar 2017 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdCCNsV (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 08:48:21 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35975 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdCCNsT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 08:48:19 -0500
Received: by mail-pf0-f195.google.com with SMTP id j5so9987754pfb.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KLnFgGnZjG/aCV1gqDU7YZL83+9LHCd2r0WpaVGFBv4=;
        b=qSCG7alYDPcFM2uspaw2i/ZURscyAixB0X81MdbmKModtzTSTyIZA7Fiai6qEGr3Cp
         lfm3EtE5LmP6p5ZPMve587oKm7tx3SficUgA8Js7BJtF/8NB0g0xPZZyuAnli6E/3wGt
         lV47QsfSp17c6puKj36QBSM/F9cbx+EaMyS6N0ZZAlHYwbbqMTBsYYDowNOK4GqHX3BO
         VkHmRoI6qzGGGhK0uOMvGZp7Lri/DBS2aoWWabmQHxjxlU6L9eja8AJLJa08DDEhf1IT
         S1M7J9yBMs6LjKop4jyTfGrsl6xFlzD3w+jP5UE0KCHHLWw+/fXKg8fRM2rK+XmT5UUa
         O51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KLnFgGnZjG/aCV1gqDU7YZL83+9LHCd2r0WpaVGFBv4=;
        b=FKxwqW4wxEdUgfby4mt7UdK9qzABdl7HSWhGJc4dtkRZmENGaZbMl2MFhKk+QKWgwU
         C0FvcNpx+xoW2EtBOW+K8YoDsGXwqakDIdEwBNYEd6iGjl3mhsvGDfhlIdh6z5VJjmMY
         tWwzt6eyaXHA4iXlOvY71KEBcm3FiMdoNH4WMwMQVHjP8nprs79/VmybMoYUTDgc6th5
         /74C0xEgDl9TIFogXP/wd/oPrt486wCF3+AwQYbSbA/bW44unFIvIv3FKFKwxwMQgR2i
         JurW75g8MW9gahoHW5KoT5tFEK/OWKVxFVJKdIBj+U/0oteM+LceeU7AW4jSLsTHtQvs
         RtOQ==
X-Gm-Message-State: AMke39l0QsAmFEwjSrUmShy/kemqWPGTXEZwVkBRAQF0X4mIv+PcUz3VNVTWzeHIiK/iww==
X-Received: by 10.99.206.5 with SMTP id y5mr3539000pgf.212.1488548432487;
        Fri, 03 Mar 2017 05:40:32 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id i3sm20351323pfk.47.2017.03.03.05.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 05:40:31 -0800 (PST)
Date:   Fri, 3 Mar 2017 05:40:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 3/5] Add --gui option to mergetool
Message-ID: <20170303134030.GA6267@arch-attack.localdomain>
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
 Documentation/git-mergetool.txt |  8 +++++++-
 git-mergetool.sh                |  5 ++++-
 t/t7610-mergetool.sh            | 28 +++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 3 deletions(-)

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
index 01c1d44a9..31610f3b0 100755
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
+	test_expect_code 1 git merge master >/dev/null 2>&1 &&
+	git mergetool -g both >/dev/null 2>&1 &&
+	git mergetool -g file1 file1 &&
+	git mergetool --gui file2 "spaced name" >/dev/null 2>&1 &&
+	git mergetool --gui subdir/file3 >/dev/null 2>&1 &&
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
2.12.0.5.gfbc750a84

