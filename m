Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083FC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJIOih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJIOhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EDB27B1F
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id iv17so5477795wmb.4
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxgJjmbh+xLfyZbtDof9epBzQHRl8IpFyALiN1Oh+EM=;
        b=p5r0PGnol+5P6RY6gnjTsBBXcUCpektnqA+tYuNOxqQauBvTW2In6NSExuTnpJ18xr
         Y0/DY42EIUDomlD7hQjufHVyfoRFUv3tJFSb7csxtbLAVuepMoerU38UF9zOJ4CkcBf4
         XIA7LDxoRq2VysT7q4DximIn/17kE+7h+ckPKT2Uagd46+XRVC91SilT60UFowozQA8H
         AqfJ5lSPFnkh24M+378u3apGkWO0DFdAilRZrcoN3Ojvj+wtGMoGbtW7NdpEgfhKzBp0
         WxjYW/94iZw6MXl2Q2uNESDGM4NtcqqWw3AGqQCLGEq82xw8NfLaruA86N2TUA4PDMUo
         o1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxgJjmbh+xLfyZbtDof9epBzQHRl8IpFyALiN1Oh+EM=;
        b=x8Ff9XVjc/PZ6wpP7npUknRUZuyp1TD5HdD+S0BX+Tfz4gag+FbvI+r74wbUj8hhv9
         y7ak92qyw/Am0KoaXbh+Uo00WTU/7k90W6NjmRfKBHVNq1lx7jDIz7d7mbdk7wFyF3Fl
         F5uEGiDGKK4zrnACHUbh+qh18Pg3vpf7g5if3mF/qV/DIpvf9VJQ6FoEDa+ANuozDKH7
         xz84N6an5k1AubupgQr9AURcM5/SM5qD4HF2GtVteH1I4TkAxuq4NADLWK/aGik1feRz
         Rs43/v6hxu4lYTsVDUHKhQhdIF4Z1+ZHZ19XY9vEK79ewbKG28KWVWmuWe9L2+AvSDRH
         ck+Q==
X-Gm-Message-State: ACrzQf3L4Dqd3WBjkY9hyHnSvH3H2xKAtd89KE4S9t6XNBFM+WIwuaZD
        qcVHstJOh5Kv2lp7xKFUtFG7E2mbXOg=
X-Google-Smtp-Source: AMsMyM62vF/OgZCM7Rq9kK1CJx2Y0J2ateLp/4XmaVtXWLbji9uhA9ZyOR23BV9jHZi1jyZ36wfqdw==
X-Received: by 2002:a05:600c:218d:b0:3b4:7749:c920 with SMTP id e13-20020a05600c218d00b003b47749c920mr17275009wme.190.1665326270252;
        Sun, 09 Oct 2022 07:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5592000000b0021e51c039c5sm6807599wrv.80.2022.10.09.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:49 -0700 (PDT)
Message-Id: <743bdacded5183b5b11c9f19c24b07fa26eded24.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:37 +0000
Subject: [PATCH 11/12] fsmonitor: test updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
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
 t/t7527-builtin-fsmonitor.sh | 58 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 56c0dfffea6..19a243588e2 100755
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
@@ -72,6 +72,32 @@ start_daemon () {
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
+				return 0
+			fi
+			last=$nsz
+		fi
+		sleep 1
+		k=$(( $k + 1 ))
+	done &&
+	return 0
+}
+
 # Is a Trace2 data event present with the given catetory and key?
 # We do not care what the value is.
 #
@@ -137,7 +163,6 @@ test_expect_success 'implicit daemon start' '
 # machines (where it might take a moment to wake and reschedule the
 # daemon process) to avoid false alarms during test runs.)
 #
-IMPLICIT_TIMEOUT=5
 
 verify_implicit_shutdown () {
 	r=$1 &&
@@ -373,6 +398,10 @@ create_files () {
 	echo 3 >dir2/new
 }
 
+rename_directory () {
+	mv dirtorename dirrenamed
+}
+
 rename_files () {
 	mv rename renamed &&
 	mv dir1/rename dir1/renamed &&
@@ -427,7 +456,7 @@ test_expect_success 'edit some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	edit_files &&
+	wait_for_update edit_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -442,7 +471,7 @@ test_expect_success 'create some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	create_files &&
+	wait_for_update create_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -456,7 +485,7 @@ test_expect_success 'delete some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	delete_files &&
+	wait_for_update delete_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -470,7 +499,7 @@ test_expect_success 'rename some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	rename_files &&
+	wait_for_update rename_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -487,7 +516,7 @@ test_expect_success 'rename directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	mv dirtorename dirrenamed &&
+	wait_for_update rename_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -500,7 +529,7 @@ test_expect_success 'file changes to directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	file_to_directory &&
+	wait_for_update file_to_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -513,7 +542,7 @@ test_expect_success 'directory changes to a file' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	directory_to_file &&
+	wait_for_update directory_to_file "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
@@ -561,7 +590,7 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
 	nul_to_q <actual_2 >actual_q2 &&
 
-	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+	grep "^builtin:test_00000002:[0-1]Q$" actual_q2 &&
 
 	>test_flush/file_3 &&
 
@@ -732,7 +761,8 @@ u_values="$u1 $u2"
 for u in $u_values
 do
 	test_expect_success "unicode in repo root path: $u" '
-		test_when_finished "stop_daemon_delete_repo $u" &&
+		test_when_finished \
+		"stop_daemon_delete_repo `echo "$u" | sed 's:x:\\\\\\\\\\\\\\x:g'`" &&
 
 		git init "$u" &&
 		echo 1 >"$u"/file1 &&
@@ -814,8 +844,7 @@ my_match_and_clean () {
 }
 
 test_expect_success 'submodule always visited' '
-	test_when_finished "git -C super fsmonitor--daemon stop; \
-			    rm -rf super; \
+	test_when_finished "rm -rf super; \
 			    rm -rf sub" &&
 
 	create_super super &&
@@ -883,7 +912,8 @@ have_t2_error_event () {
 }
 
 test_expect_success "stray submodule super-prefix warning" '
-	test_when_finished "rm -rf super; \
+	test_when_finished "git -C super/dir_1/dir_2/sub fsmonitor--daemon stop; \
+			    rm -rf super; \
 			    rm -rf sub;   \
 			    rm super-sub.trace" &&
 
-- 
gitgitgadget

