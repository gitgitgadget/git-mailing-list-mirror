Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA9C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiKPXYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKPXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069DB7CC
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r127-20020a1c4485000000b003cfdd569507so2032081wma.4
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGeYWHawFT/RkYnEHv+xVJgDFjPFKnvI5O3/C52qS/w=;
        b=dgPjVBOttRZO4I23KkZYqF7P+dfyuwEvVyDdNQb1/oix19au33WKbCDeF8QRDNamWG
         LVCfmdO9bWD2tTdhdZY4UOp9sn7OCQXMzukNComPx5r++90+bcEOcBRLSPQyOgFGEH6A
         OCThSwxH6tB9T3rxKk0ALKudyEdKa4rtUDzNyk674M2jPFLn/uHRqLPp8tHd3L2cI0Og
         ajG+pag87LEmP5EQWd4agICjHfmOB805W8djvS8oR3aY8WL5ZcMg9dOaWf8QyizvlOaX
         OByjKzgzZj7W2fozn/DseHWizokEzeben7wp250BtzzUDolltbzVqkFXY83A5McaC13s
         5k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGeYWHawFT/RkYnEHv+xVJgDFjPFKnvI5O3/C52qS/w=;
        b=vVu5ASY+9gcbjIGIUY/eX76PaF7BZPd7EkcOGsIxgncK4rDtygnVgsk62D1cPtVX8t
         apIqOTpjB+d9v21pqWhMbyBoXKeiRrwscgL9Ze5eyCo8Rdy1frZKRA0N1gmoSw12S0q2
         aeg3RQTgEjTd7QVrepjn0O8lqu/6vO1BM2VxUpAj+ewMFqbnYEpc7XZK/hMaEcJ0ncKp
         Gb7nmSLQj+0PPSCL/JD/mt6sxrHqlRjWQfXFtGxtizRsd2AjGFzEO8JCTiqx2WOH7W5T
         FgC23zFNEtIMYhh9wRHPFEmR17dlTk3aJz2R5GfLI/hLqnNY1BQvZcjBDBH//qKg9NX1
         jBug==
X-Gm-Message-State: ANoB5pn7gjDXdD/g8qnu72F9mVBZhs4lsh1Wadjt8OOG/cEKyUWVuAoR
        CPgpL8mWB0ue+R3uOH7HD0b1OQsAEjE=
X-Google-Smtp-Source: AA0mqf4Tvij6leCcfprcBFjHEHrmoydGQVbCmDXcRJimd36CgWiWw4Dnr6PGFm9R5JToflmQfbAwpw==
X-Received: by 2002:a05:600c:3108:b0:3c6:bd12:ac68 with SMTP id g8-20020a05600c310800b003c6bd12ac68mr3519381wmo.123.1668641025348;
        Wed, 16 Nov 2022 15:23:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003cfd10a33afsm3587604wmo.11.2022.11.16.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:45 -0800 (PST)
Message-Id: <754355ca44f56823a4dad8138228b446b39a420c.1668641019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:38 +0000
Subject: [PATCH v3 5/6] fsmonitor: test updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

t7527-builtin-fsmonitor was leaking fsmonitor--daemon processes in some
cases.

Accomodate slight difference in the number of events generated on Linux.

On lower-powered systems, spin a little to give the daemon time
to respond to and log filesystem events.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 t/t7527-builtin-fsmonitor.sh | 94 ++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 14 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4abc74db2bb..951374231b7 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -13,7 +13,7 @@ fi
 stop_daemon_delete_repo () {
 	r=$1 &&
 	test_might_fail git -C $r fsmonitor--daemon stop &&
-	rm -rf $1
+	rm -rf $r
 }
 
 start_daemon () {
@@ -72,6 +72,34 @@ start_daemon () {
 	)
 }
 
+IMPLICIT_TIMEOUT=5
+
+wait_for_update () {
+	func=$1 &&
+	file=$2 &&
+	sz=$(wc -c < "$file") &&
+	last=0 &&
+	$func &&
+	k=0 &&
+	while test "$k" -lt $IMPLICIT_TIMEOUT
+	do
+		nsz=$(wc -c < "$file")
+		if test "$nsz" -gt "$sz"
+		then
+			if test "$last" -eq "$nsz"
+			then
+				cat "$file" &&
+				return 0
+			fi
+			last=$nsz
+		fi
+		sleep 1
+		k=$(( $k + 1 ))
+	done &&
+	cat "$file" &&
+	return 0
+}
+
 # Is a Trace2 data event present with the given catetory and key?
 # We do not care what the value is.
 #
@@ -137,7 +165,6 @@ test_expect_success 'implicit daemon start' '
 # machines (where it might take a moment to wake and reschedule the
 # daemon process) to avoid false alarms during test runs.)
 #
-IMPLICIT_TIMEOUT=5
 
 verify_implicit_shutdown () {
 	r=$1 &&
@@ -373,6 +400,15 @@ create_files () {
 	echo 3 >dir2/new
 }
 
+rename_directory () {
+	mv dirtorename dirrenamed
+}
+
+rename_directory_file () {
+	mv dirtorename dirrenamed &&
+	echo 1 > dirrenamed/new
+}
+
 rename_files () {
 	mv rename renamed &&
 	mv dir1/rename dir1/renamed &&
@@ -427,10 +463,12 @@ test_expect_success 'edit some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	edit_files &&
+	wait_for_update edit_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/modified$"  .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
 	grep "^event: modified$"       .git/trace &&
@@ -442,10 +480,12 @@ test_expect_success 'create some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	create_files &&
+	wait_for_update create_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
 	grep "^event: new$"      .git/trace
@@ -456,10 +496,12 @@ test_expect_success 'delete some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	delete_files &&
+	wait_for_update delete_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
 	grep "^event: delete$"      .git/trace
@@ -470,10 +512,12 @@ test_expect_success 'rename some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	rename_files &&
+	wait_for_update rename_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/rename$"  .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
 	grep "^event: rename$"       .git/trace &&
@@ -487,23 +531,42 @@ test_expect_success 'rename directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	mv dirtorename dirrenamed &&
+	wait_for_update rename_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
 '
 
+test_expect_success 'rename directory file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	wait_for_update rename_directory_file "$PWD/.git/trace" &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	test_might_fail git fsmonitor--daemon stop &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace &&
+	grep "^event: dirrenamed/new$"  .git/trace
+'
 test_expect_success 'file changes to directory' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	file_to_directory &&
+	wait_for_update file_to_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: delete$"     .git/trace &&
 	grep "^event: delete/new$" .git/trace
 '
@@ -513,10 +576,12 @@ test_expect_success 'directory changes to a file' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	directory_to_file &&
+	wait_for_update directory_to_file "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1$" .git/trace
 '
 
@@ -561,7 +626,7 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
 	nul_to_q <actual_2 >actual_q2 &&
 
-	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+	grep "^builtin:test_00000002:[0-1]Q$" actual_q2 &&
 
 	>test_flush/file_3 &&
 
@@ -732,7 +797,8 @@ u_values="$u1 $u2"
 for u in $u_values
 do
 	test_expect_success "unicode in repo root path: $u" '
-		test_when_finished "stop_daemon_delete_repo $u" &&
+		test_when_finished \
+		"stop_daemon_delete_repo `echo "$u" | sed 's:x:\\\\\\\\\\\\\\x:g'`" &&
 
 		git init "$u" &&
 		echo 1 >"$u"/file1 &&
@@ -818,8 +884,7 @@ test_expect_success 'submodule setup' '
 '
 
 test_expect_success 'submodule always visited' '
-	test_when_finished "git -C super fsmonitor--daemon stop; \
-			    rm -rf super; \
+	test_when_finished "rm -rf super; \
 			    rm -rf sub" &&
 
 	create_super super &&
@@ -887,7 +952,8 @@ have_t2_error_event () {
 }
 
 test_expect_success "stray submodule super-prefix warning" '
-	test_when_finished "rm -rf super; \
+	test_when_finished "git -C super/dir_1/dir_2/sub fsmonitor--daemon stop; \
+			    rm -rf super; \
 			    rm -rf sub;   \
 			    rm super-sub.trace" &&
 
-- 
gitgitgadget

