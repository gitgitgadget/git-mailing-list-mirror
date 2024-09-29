Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D18AEA
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577696; cv=none; b=uj99yBli0MkGuYSdFIP5osZ6jE8W+ik/HwAXE4xHjSbUDgiKUeNPw+M0Z9gOUt7xvrjwLiM4DlUYvA7cvqOw97PbcY7Rf+QeRMZvOe7VMzvQ/ejfM20ovvNVe+fPaONfW7VyXVdbOQdfcqlnIEG6rz6yuAMtQjBCpsd1ufiLs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577696; c=relaxed/simple;
	bh=Eh7ppMca26OjwSEAvY2aNgwzEk0zhlFBn5YQEWSRhsk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ua4fJ/LWWVP3rNqsy0pVbc6AK/wtJYqxf9c/8+LPLE063HyH3BQG14vPzqrVxAs4Rh0xj+iImhTtM7d4uHmgqotX+JBjC2eR3ZfXwkQ10TRGzzVJs+cjh53hncCpsmEyBeTA7m4PUVRAymDrQ+WCf3sBjOLlKYRazehSlpTuwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcgiMrqp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcgiMrqp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so4418313a12.2
        for <git@vger.kernel.org>; Sat, 28 Sep 2024 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727577692; x=1728182492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aOZ5XlD0JfSWxiS8xCpry8r01pgtcwc4VCy8O+ZwpOE=;
        b=dcgiMrqpAFw4SmOGRG/5qXBOLudZkryO0V8xi0W4kllrgN/wLCppYGZ/ObuEjiCaZT
         tfa6TvnHlgAx7i+WCNxCCap2Y6arF4o5/Wd1YDatFNPPP1b72bTuIxmJ3xYGWuFhT73v
         U846xVNcWnPwT7fDX2E9WWIXGUwphVKSBZj/6VjqPCY8NsTQ1puozYGsY/MSUcZRHLvK
         XaYErHKcz5Yye5aIOk836/Vzm4gJ4a0ULFcwD5dtojHWGeB0odemZ69HGT+dNH5jkkHV
         u4xtc/ycXjpKBparROKdNWpXup48eiudG9bm83THIBRKkuTYS3Su/MVEAJqtkaw9q/Ii
         RNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727577692; x=1728182492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOZ5XlD0JfSWxiS8xCpry8r01pgtcwc4VCy8O+ZwpOE=;
        b=n+gu2bilR9cHTXUeZnIUypZpcsCqWRvDTahnyB8sH+YG840IqKe6cQpepzJ4IO98Vv
         K5LUomV2p5vkRz1qGZZ/3hhTk3P/ldpIa1LwoRGHLfyP9wOR378CobNgfl0A5q5uEPLy
         elTRVVdClerg1O5FrG0Dl0k9xLny2kTbGYNN35+HeIrAGfE20nGSuwp+rfOGYfFknhyZ
         a41uvwT8kOrseVg6PVUi9jHxXigqsDL7UdL8T2IKOY4jqvUQSSTVFnYi0w9qdCJtmcNy
         lzqwqMPJA2tie43iYAYM7MrIBqIXsFYpBfBjlgzlDqv05whL2c4zhdlPKizd5+Iw3OQN
         iF+A==
X-Gm-Message-State: AOJu0YyYEhYXeryMMGKprtsWkzNX7oQdCO7ppRTkfwGv8cilEWVrpBv4
	v/htL4MAFmVVl3c9wmlZJPbxpLnMbMUCtxWgxyiF+tthIQY2m6Y3valbOQ==
X-Google-Smtp-Source: AGHT+IGdTwykCrHHvFpIIwrxJTEtU3UabWl3oip+YoSTiKeXT43hGCR+4BZVYl8RkVyti4MXK5+MAQ==
X-Received: by 2002:a05:6402:3890:b0:5c7:227f:39e4 with SMTP id 4fb4d7f45d1cf-5c882603b44mr7322437a12.31.1727577691636;
        Sat, 28 Sep 2024 19:41:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240543csm2750111a12.6.2024.09.28.19.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 19:41:31 -0700 (PDT)
Message-Id: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Sep 2024 02:41:30 +0000
Subject: [PATCH] fsmonitor OSX: fix hangs for submodules
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

fsmonitor_classify_path_absolute() expects state->path_gitdir_watch.buf
has no trailing '/' or '.' For a submodule, fsmonitor_run_daemon() sets
the value with trailing "/." (as repo_get_git_dir(the_repository) on
Darwin returns ".") so that fsmonitor_classify_path_absolute() returns
IS_OUTSIDE_CONE.

In this case, fsevent_callback() doesn't update cookie_list so that
fsmonitor_publish() does nothing and with_lock__mark_cookies_seen() is
not invoked.

As with_lock__wait_for_cookie() infinitely waits for state->cookies_cond
that with_lock__mark_cookies_seen() should unlock, the whole daemon
hangs.

Remove trailing "/." from state->path_gitdir_watch.buf for submodules
and add a corresponding test in t7527-builtin-fsmonitor.sh.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    fsmonitor/darwin: fix hangs for submodules

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1802%2FKojiNakamaru%2Ffix%2Ffsmonitor-darwin-hangs-for-submodules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1802/KojiNakamaru/fix/fsmonitor-darwin-hangs-for-submodules-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1802

 builtin/fsmonitor--daemon.c  |  1 +
 t/t7527-builtin-fsmonitor.sh | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index dce8a3b2482..e1e6b96d09e 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1314,6 +1314,7 @@ static int fsmonitor_run_daemon(void)
 		strbuf_reset(&state.path_gitdir_watch);
 		strbuf_addstr(&state.path_gitdir_watch,
 			      absolute_path(repo_get_git_dir(the_repository)));
+		strbuf_strip_suffix(&state.path_gitdir_watch, "/.");
 		state.nr_paths_watching = 2;
 	}
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 730f3c7f810..7acd074a97f 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -82,6 +82,28 @@ have_t2_data_event () {
 	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
 }
 
+start_git_in_background () {
+	git "$@" &
+	git_pid=$!
+	nr_tries_left=10
+	while true
+	do
+		if test $nr_tries_left -eq 0
+		then
+			kill $git_pid
+			exit 1
+		fi
+		sleep 1
+		nr_tries_left=$(($nr_tries_left - 1))
+	done > /dev/null 2>&1 &
+	watchdog_pid=$!
+	wait $git_pid
+}
+
+stop_git_and_watchdog () {
+	kill $git_pid $watchdog_pid
+}
+
 test_expect_success 'explicit daemon start and stop' '
 	test_when_finished "stop_daemon_delete_repo test_explicit" &&
 
@@ -907,6 +929,23 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 	test_subcommand git fsmonitor--daemon start <super-sub.trace
 '
 
+test_expect_success "submodule implicitly starts daemon by pull" '
+	test_atexit "stop_git_and_watchdog" &&
+	test_when_finished "rm -rf cloned; \
+			    rm -rf super; \
+			    rm -rf sub" &&
+
+	create_super super &&
+	create_sub sub &&
+
+	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
+	git -C super commit -m "add sub" &&
+	git clone --recurse-submodules super cloned &&
+
+	git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
+	start_git_in_background -C cloned pull --recurse-submodules
+'
+
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
 # regardless of how it is spelled in the FS event.

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
-- 
gitgitgadget
