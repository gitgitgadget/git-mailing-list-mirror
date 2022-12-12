Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF6C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiLLV6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiLLV6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A76E0F6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:13 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o5so13712875wrm.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGeYWHawFT/RkYnEHv+xVJgDFjPFKnvI5O3/C52qS/w=;
        b=XZa/RBbLKLJkP4YnHqjw37K+KY4V4C5AbL8uwWC5hliadqRXzrM7YgT3OjgiSiY7Wo
         hjkmOVmNMh1+eO+3vUn/XN/FXJbf9BUiJ171U/84B5SKGfPgMiuT84TFe659ptQRjwK8
         KnAIiWSL3s4SG6UgdNpiQnbsEBs1dre1zoepWmjpS22JpTT4NiDkpXIJ3+HkUGr9468n
         sCy16gpnNyklXK9AG3ohlB/dHTRugp3g2cdC9YIbwTE/pk4GL+2a8K9KXSs3sqJNjdyD
         qmnL2IiY7GJxILYLae/aaT86FyeZ3L9qbky3ZC+YJdTiFJ9XaBvZzJlv8D/dqh8OFWbP
         QyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGeYWHawFT/RkYnEHv+xVJgDFjPFKnvI5O3/C52qS/w=;
        b=UBnLXRxy8F9gXZsqeOzHEolkUmnvdn5r1T5ejATnU51dyjLJ1+IVPucL2IfIYEX61r
         qJAWvoIgqbOPsAtJzqI53QD7GSL0QVKBLS2VHM50ntqB0IIqU9lgT0LziZ5ZKVdlJBMc
         3IDFnjpHWFxEVoU+ulrZWleRQzW9UiSwn1uvunyT+xes7FgzDZ93QsP2TQwx+L5zD+eR
         6WvgId52ntmkzQUePEcUv0NOW1oh06tlhEQRyf/PaqNTygLA83rHfuQBx9zqKW0yHC7w
         Qt7JYG73W8RZBRxHZylbmyqO3pKqx5lSgRl2vokQXOkI7WTMd4hOBuP4nHcR8hmVdEyr
         ji0A==
X-Gm-Message-State: ANoB5plKYo1GXb6xEPKM7b43X8LNGC3ECF5svVFGPyn7vA8Jrj2xgJI1
        86FmeYsuZX6ZK2aXSaNZTYRGfIuWRtI=
X-Google-Smtp-Source: AA0mqf50fV0KUSv2kqt/4cge/vup9+8D3d2+w941jLfydUTl1P6f7z89tgDhsz15rlXukcZBVuLC4A==
X-Received: by 2002:a5d:670c:0:b0:242:1551:975b with SMTP id o12-20020a5d670c000000b002421551975bmr10774988wru.50.1670882291682;
        Mon, 12 Dec 2022 13:58:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe2c4000000b00236488f62d6sm9993786wrj.79.2022.12.12.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:11 -0800 (PST)
Message-Id: <6a7b554642c39096e80c0e0146d149eeee55241d.1670882286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:58:04 +0000
Subject: [PATCH v5 5/6] fsmonitor: test updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
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

