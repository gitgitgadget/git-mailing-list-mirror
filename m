Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C36166C
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857549; cv=none; b=No101jjPmYa47icVTV3AVzkNkqZVDKh5UMvhnuo5SC2y5vATfDZhPbOXn4H8xGvZmAALXi1vwZSVkkEL9dn/gyaQcg0Oqo4Zy27HPlsZA/hEaSNpuYSvh+TGzPjMVVIGnbVNaUu6Gq5hCCj1nlxmXPIlfRKRSD1ZupCBt1cx00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857549; c=relaxed/simple;
	bh=S5phN8Hlc5vBvd0hrMsO7F2b3Nnsb4LiMxYSfGO/L9I=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MX8daewC4YQMB+9x+FOHCYz6gDiNy3u9jNGW9MjWPGeBWYkQwq/PFxTqZ9Dny2Vgir6QOZ/WcKmmyxQ1Xxrv3wxa86lO5ehbDwW359dPihzO8WCu9N7i9HKxHGBqrAMEf/49lZoon5RTmMT9yYQMjq7U8rqxVaYDIZdKpSlVZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6jgVkaF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6jgVkaF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b28aadb28so2988358f8f.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857545; x=1708462345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wy3UHChN83kaQEHB7S50UnwXtOlgoAl9Atri6eSrxM=;
        b=G6jgVkaFSxJKqsP2RsqKNpwEcccFvQ7j4noFdhlDjCMzVgBtCV67loXXot0E/Yvbuu
         VCi7QHYK5Oy9zWVv1lTaLc0sN+u1qN8mQPoklKrw3BubldQQktdlI8Om1SxXFxwHxrVt
         zStogBjC7/zOFysENuo7Ep9MVWKDs6RttKcq8agvUHjZyBtyd08Ao0Ge2gYLiZCojIi0
         VbIEQkTERZj5TrJrKIrjpQHrXNfidwRqOFYzc3Sad/NLPDfh+I1v5RJK6A+9COSrwx5/
         upYofPX/hp6ZrXsevO+T0G55h346fUJ3VDpwP6pbJv/cxXufNJNRzrEcBj+nxO3dqpj1
         xwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857545; x=1708462345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wy3UHChN83kaQEHB7S50UnwXtOlgoAl9Atri6eSrxM=;
        b=H6798mO6GbSe5j/lbIm3xw2aMuMJK+3EmWbx/2v9MTkz/FcZPcMHuGGJsWY29+ft28
         LJ2XLa4w3ZahaQQkh5g4DWMkrXKubhglHwPuoXGdwJc7jkjoY0j+Vysyp6GMPmbXV1Rg
         +ssmnV0AwqPo/lJhJRPE+m3oo415Gf2a+5nlOc3ymhPwAGSXsWCRfBG2eXsEjwmK00FA
         h2wFxrFzy7bpSoNPsZD5YAPNGn/CuZMGza+hjKBrV4S4XI5dqMls0KEudMpHw0npS5Ob
         aHpstNDfGYImIbROJ2tDg6N/WoWY4DRR12c8dhDXx3+67CtTYAgWJGHkiOsFu1EZFW/V
         tCVQ==
X-Gm-Message-State: AOJu0YzykPJBMR4X2Cs4kGiC6FJ7N0tO7Q50ad256Dc1FW8Ag1I6Rxkk
	H8l/Z1/3B6VMM+tkY6tsT+uq0xIA/2xlK8LAmOZB+mqYpXG28nXejcnIsfzV
X-Google-Smtp-Source: AGHT+IGphAIsVLW8ZtlzHBNtPKzpLeI9iNhUq7eTgRylFJtirmEkKRBg9gycFkPgD+d+4YEGzfvm0g==
X-Received: by 2002:adf:fe8d:0:b0:33b:39d6:666d with SMTP id l13-20020adffe8d000000b0033b39d6666dmr314576wrr.36.1707857544769;
        Tue, 13 Feb 2024 12:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b0033b4acb999dsm10357510wrx.98.2024.02.13.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:24 -0800 (PST)
Message-ID: <272d7805f474411bd30aee8a55f497d6689afb57.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:12 +0000
Subject: [PATCH 03/12] t7527: add case-insensitve test for FSMonitor
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

The FSMonitor client code trusts the spelling of the pathnames in the
FSEvents received from the FSMonitor daemon.  On case-insensitive file
systems, these OBSERVED pathnames may be spelled differently than the
EXPECTED pathnames listed in the .git/index.  This causes a miss when
using `index_name_pos()` which expects the given case to be correct.

When this happens, the FSMonitor client code does not update the state
of the CE_FSMONITOR_VALID bit when refreshing the index (and before
starting to scan the worktree).

This results in modified files NOT being reported by `git status` when
there is a discrepancy in the case-spelling of a tracked file's
pathname.

This commit contains a (rather contrived) test case to demonstrate
this.  A later commit in this series will update the FSMonitor client
code to recognize these discrepancies and update the CE_ bit accordingly.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t7527-builtin-fsmonitor.sh | 217 +++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 78503158fd6..5cd68b2ea82 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1037,4 +1037,221 @@ test_expect_success 'split-index and FSMonitor work well together' '
 	)
 '
 
+# The FSMonitor daemon reports the OBSERVED pathname of modified files
+# and thus contains the OBSERVED spelling on case-insensitive file
+# systems.  The daemon does not (and should not) load the .git/index
+# file and therefore does not know the expected case-spelling.  Since
+# it is possible for the user to create files/subdirectories with the
+# incorrect case, a modified file event for a tracked will not have
+# the EXPECTED case. This can cause `index_name_pos()` to incorrectly
+# report that the file is untracked. This causes the client to fail to
+# mark the file as possibly dirty (keeping the CE_FSMONITOR_VALID bit
+# set) so that `git status` will avoid inspecting it and thus not
+# present in the status output.
+#
+# The setup is a little contrived.
+#
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
+	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
+
+	git init subdir_case_wrong &&
+	(
+		cd subdir_case_wrong &&
+		echo x >AAA &&
+		echo x >BBB &&
+
+		mkdir dir1 &&
+		echo x >dir1/file1 &&
+		mkdir dir1/dir2 &&
+		echo x >dir1/dir2/file2 &&
+		mkdir dir1/dir2/dir3 &&
+		echo x >dir1/dir2/dir3/file3 &&
+
+		echo x >yyy &&
+		echo x >zzz &&
+		git add . &&
+		git commit -m "data" &&
+
+		# This will cause "dir1/" and everything under it
+		# to be deleted.
+		git sparse-checkout set --cone --sparse-index &&
+
+		# Create dir2 with the wrong case and then let Git
+		# repopulate dir3 -- it will not correct the spelling
+		# of dir2.
+		mkdir dir1 &&
+		mkdir dir1/DIR2 &&
+		git sparse-checkout add dir1/dir2/dir3
+	) &&
+
+	start_daemon -C subdir_case_wrong --tf "$PWD/subdir_case_wrong.trace" &&
+
+	# Enable FSMonitor in the client. Run enough commands for
+	# the .git/index to sync up with the daemon with everything
+	# marked clean.
+	git -C subdir_case_wrong config core.fsmonitor true &&
+	git -C subdir_case_wrong update-index --fsmonitor &&
+	git -C subdir_case_wrong status &&
+
+	# Make some files dirty so that FSMonitor gets FSEvents for
+	# each of them.
+	echo xx >>subdir_case_wrong/AAA &&
+	echo xx >>subdir_case_wrong/dir1/DIR2/dir3/file3 &&
+	echo xx >>subdir_case_wrong/zzz &&
+
+	GIT_TRACE_FSMONITOR="$PWD/subdir_case_wrong.log" \
+		git -C subdir_case_wrong --no-optional-locks status --short \
+			>"$PWD/subdir_case_wrong.out" &&
+
+	# "git status" should have gotten file events for each of
+	# the 3 files.
+	#
+	# "dir2" should be in the observed case on disk.
+	grep "fsmonitor_refresh_callback" \
+		<"$PWD/subdir_case_wrong.log" \
+		>"$PWD/subdir_case_wrong.log1" &&
+
+	grep -q "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
+	grep -q "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
+
+	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
+
+	# The refresh-callbacks should have caused "git status" to clear
+	# the CE_FSMONITOR_VALID bit on each of those files and caused
+	# the worktree scan to visit them and mark them as modified.
+	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
+	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
+
+	# However, with the fsmonitor client bug, the "(pos -3)" causes
+	# the client to not update the bit and never rescan the file
+	# and therefore not report it as dirty.
+	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
+	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
+
+	git init file_case_wrong &&
+	(
+		cd file_case_wrong &&
+		echo x >AAA &&
+		echo x >BBB &&
+
+		mkdir dir1 &&
+		mkdir dir1/dir2 &&
+		mkdir dir1/dir2/dir3 &&
+		echo x >dir1/dir2/dir3/FILE-3-B &&
+		echo x >dir1/dir2/dir3/XXXX-3-X &&
+		echo x >dir1/dir2/dir3/file-3-a &&
+		echo x >dir1/dir2/dir3/yyyy-3-y &&
+		mkdir dir1/dir2/dir4 &&
+		echo x >dir1/dir2/dir4/FILE-4-A &&
+		echo x >dir1/dir2/dir4/XXXX-4-X &&
+		echo x >dir1/dir2/dir4/file-4-b &&
+		echo x >dir1/dir2/dir4/yyyy-4-y &&
+
+		echo x >yyy &&
+		echo x >zzz &&
+		git add . &&
+		git commit -m "data"
+	) &&
+
+	start_daemon -C file_case_wrong --tf "$PWD/file_case_wrong.trace" &&
+
+	# Enable FSMonitor in the client. Run enough commands for
+	# the .git/index to sync up with the daemon with everything
+	# marked clean.
+	git -C file_case_wrong config core.fsmonitor true &&
+	git -C file_case_wrong update-index --fsmonitor &&
+	git -C file_case_wrong status &&
+
+	# Make some files dirty so that FSMonitor gets FSEvents for
+	# each of them.
+	echo xx >>file_case_wrong/AAA &&
+	echo xx >>file_case_wrong/zzz &&
+
+	# Rename some files so that FSMonitor sees a create and delete
+	# FSEvent for each.  (A simple "mv foo FOO" is not portable
+	# between macOS and Windows. It works on both platforms, but makes
+	# the test messy, since (1) one platform updates "ctime" on the
+	# moved file and one does not and (2) it causes a directory event
+	# on one platform and not on the other which causes additional
+	# scanning during "git status" which causes a "H" vs "h" discrepancy
+	# in "git ls-files -f".)  So old-school it and move it out of the
+	# way and copy it to the case-incorrect name so that we get fresh
+	# "ctime" and "mtime" values.
+
+	mv file_case_wrong/dir1/dir2/dir3/file-3-a file_case_wrong/dir1/dir2/dir3/ORIG &&
+	cp file_case_wrong/dir1/dir2/dir3/ORIG     file_case_wrong/dir1/dir2/dir3/FILE-3-A &&
+	rm file_case_wrong/dir1/dir2/dir3/ORIG &&
+	mv file_case_wrong/dir1/dir2/dir4/FILE-4-A file_case_wrong/dir1/dir2/dir4/ORIG &&
+	cp file_case_wrong/dir1/dir2/dir4/ORIG     file_case_wrong/dir1/dir2/dir4/file-4-a &&
+	rm file_case_wrong/dir1/dir2/dir4/ORIG &&
+
+	# Run status enough times to fully sync.
+	#
+	# The first instance should get the create and delete FSEvents
+	# for each pair.  Status should update the index with a new FSM
+	# token (so the next invocation will not see data for these
+	# events).
+
+	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try1.log" \
+		git -C file_case_wrong status --short \
+			>"$PWD/file_case_wrong-try1.out" &&
+	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try1.log" &&
+	grep -q "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
+	grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
+	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
+
+	# FSM refresh will have invalidated the FSM bit and cause a regular
+	# (real) scan of these tracked files, so they should have "H" status.
+	# (We will not see a "h" status until the next refresh (on the next
+	# command).)
+
+	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf1.out" &&
+	grep -q "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
+	grep -q "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
+
+
+	# Try the status again. We assume that the above status command
+	# advanced the token so that the next one will not see those events.
+
+	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try2.log" \
+		git -C file_case_wrong status --short \
+			>"$PWD/file_case_wrong-try2.out" &&
+	! grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos" "$PWD/file_case_wrong-try2.log" &&
+	! grep -q "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
+	! grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
+	! grep -q "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
+
+	# FSM refresh saw nothing, so it will mark all files as valid,
+	# so they should now have "h" status.
+
+	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf2.out" &&
+	grep -q "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
+	grep -q "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
+
+
+	# We now have files with clean content, but with case-incorrect
+	# file names.  Modify them to see if status properly reports
+	# them.
+
+	echo xx >>file_case_wrong/dir1/dir2/dir3/FILE-3-A &&
+	echo xx >>file_case_wrong/dir1/dir2/dir4/file-4-a &&
+
+	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try3.log" \
+		git -C file_case_wrong --no-optional-locks status --short \
+			>"$PWD/file_case_wrong-try3.out" &&
+	# FSEvents are in observed case.
+	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
+	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
+
+	# Status should say these files are modified, but with the case
+	# bug, the "pos -3" cause the client to not update the FSM bit
+	# and never cause the file to be rescanned and therefore to not
+	# report it dirty.
+	! grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
+	! grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
+'
+
 test_done
-- 
gitgitgadget

