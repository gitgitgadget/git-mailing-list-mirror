Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13B21CC64
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767292072; cv=none; b=S1EPJqRcrYC7nY02zSvgveT9QPEVJ5E/KnyaXINS/c61iddJpngKvvUPDpNIply/+99J8Y76nN3aNwZxYL79m2oSbcgLqc6DPylCXKtk/Vdzb7ctf9BMit/IDKnp8EEz0LwIigNWzLTgWmTtDEBj8RsHCDda39wg7mX7byMtgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767292072; c=relaxed/simple;
	bh=fkmxF0iCIPA1dgNp7lrDtPfMoclTCSUd5gVOLJNawp8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UqvlgVLkqURBzYVo0UHSiFbbMWLXb+rkRz5pQa2GwFIkOyQdYYHxI+F4komTt0iyNyBAQtyoQ0eznTqkjSDfuQ5DlzB/CVwNZGV+O8BA0wD1TNcGHMNmkabLBAfPGKLYLD4GVK6bpu9l5BBCXOYzDiZDTBiwYMMsfizImIgBYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjD0Kcob; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjD0Kcob"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0f3f74587so164261155ad.2
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767292070; x=1767896870; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L21yGoUbdQaPPT3LPFk/jWlhAPZ3FzmfEZihNds3UyI=;
        b=CjD0Kcobqi9II4puqHLCG76WOK6QtrB8T6liOwBZ8huhs0kxzPmYQJ76WzXzwVbGxZ
         qLiTZOnuozTkhTO1ctWOykq5idlOj+oQuzN7lzpMDXb2EepbDXiKM/NJG67IL+gu4Qh7
         1fgJGxKax5Fm4RaVbydvGnNTLbhR/GDr5Sn/w8eXRvf+d217N5iZfHqb+d2MqbXgGsR+
         SqB/yNL+QPrvJe6j1aWG0NPI8NLHblBKyE3B/CYqemKaLe5utnSLVsyU9lw0gdTdFdQp
         6avLAW2JZTX0Hl2MLy9OoSswAgzs549vWBT6ZvJPU8OiLe1iPWsOu0bEqeB91xurwhmb
         lgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767292070; x=1767896870;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L21yGoUbdQaPPT3LPFk/jWlhAPZ3FzmfEZihNds3UyI=;
        b=ryvlwvpPnYF72ykjy7z+ofyGzoO4O8vjFF4mthbEpcz4n+hTyZ8booyta22mTTPJYY
         sGBMoPvraVKs7Fgg2DNzB7VIPq0SuWL7gLqfagKKJcQkhAIT+ASpKTqNezVpIWPc4Vrj
         FnCANFG8fhPHDXye2XNPU92NnWmOqRETWNcvi3SZsDj3u6Nz/YKzKXxEi9ZdMKnL2dyw
         k41/DXUQoJxkcTi52GhcC+O9Apy8jS9jcYDT7BKXTTdp4paRiJ8s7hL3VyGeVgHppQcl
         /Bb7P4lrwqUWxcZR/9M7r3eUBk8zCZ0nMcePd/l7BoBBxfcTYgrH3J7Y0Q+h0UzSexZ5
         08Gw==
X-Gm-Message-State: AOJu0YyM8oYmOIXEMaFIUCqAcTk2KzfUTGn65OoArzUwK6OinQHVspI0
	O507qEodn8AYODwlBXG22AsidZkrcdAxJenGF+s38HhmP4iBbN6RHH/TIzCPHg==
X-Gm-Gg: AY/fxX5aJ6e7u50neHBcIsmJs4yAN1WroF+i+CEo5xd+po6mzLnUWAuVYsyIQV2fUXZ
	6Fir9gnYywfnrH3EqrGYTAnDBHyU0fG3KZLRxqqBoWgBjCS7MrcFHTiO0xGGIKlPgG2Yh2nLEIX
	NRhLO8mG07kMbQXXXhXJD+fVNdGfV8q9WWRBqx83C1+txOy3VsV68c+gHdMl001yinA8br6qIQC
	eiz7JPIugkWeudqNHRlgpWFM+PCe7MvZqnpm7peKgT2lj1THaoVGfR+Es5E6+EgpUKyyqRVEEtR
	Ad7ihncnH1If9gjTdfh/DUPvIFmb+Tum57c8R3x+07bd52MspyRvWH9QNY36gBvZeciPhoTZ6ge
	zxR8u1QEOxZSsF+Fl1knwsSZ2Ig7PDRxj7EUPTGT0Gga7tNw0j9D5NJYpQ8nncwci+eYARDx7il
	eJkGOJYxbD+kYM1A==
X-Google-Smtp-Source: AGHT+IEKdfkMc/Z/EZ+c5wlZkl0pc0SF7AOvtSCQKxtY66128SDvW6ylGPHB3nnWprznbZSvVqRMEQ==
X-Received: by 2002:a05:7300:d208:b0:2ae:5552:b5ae with SMTP id 5a478bee46e88-2b05ec47cccmr43165052eec.36.1767292069515;
        Thu, 01 Jan 2026 10:27:49 -0800 (PST)
Received: from [127.0.0.1] ([172.182.213.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm105616070eec.2.2026.01.01.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 10:27:48 -0800 (PST)
Message-Id: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Jan 2026 18:27:48 +0000
Subject: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree" test
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
Cc: Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The "difftool --dir-diff syncs worktree without unstaged change" test
fails intermittently, particularly on Windows CI.

The test modifies a file in difftool's temp directory via an extcmd
script and expects the change to be synced back to the worktree. The
sync-back detection relies on git's change detection mechanisms.

The root cause is that the original file content and the replacement
content have identical sizes:

  - Original: "main\ntest\na\n" = 12 bytes
  - New:      "new content\n"   = 12 bytes

When difftool creates the temporary index (wtindex), the cache entries
have sd_size = 0 (zero-initialized via make_cache_entry with no
refresh). Git's ie_modified() is designed to handle this by calling
ce_modified_check_fs() for content hashing when sd_size is 0.

However, Windows has known filesystem issues that may cause this to
fail intermittently:

 - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
   same information as lstat() after close (config.mak.uname:506)

 - NTFS timestamp issues: The racy-git documentation notes that NTFS
   is "still broken" regarding timestamp granularity between in-core
   and on-disk representations (Documentation/technical/racy-git.adoc)

 - Attribute caching: Windows GetFileAttributesExW may cache results

Fix this by changing the replacement content to "modified content\n"
(17 bytes), ensuring the change is detected at the earliest size
comparison in match_stat_data(), bypassing any platform-specific edge
cases in the more complex code paths.

Note: Other tests with same-size file patterns (t0010-racy-git.sh,
t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
because they use normal Git index operations with proper racy git
detection. The difftool case is unique due to its ephemeral wtindex
created via make_cache_entry() without full stat refresh.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    t7800: fix racy "difftool --dir-diff syncs worktree" test
    
    In
    https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
    this test failed for me on an unrelated commit. I had Claude look into
    it and it thought that this could be a racy git problem. I'm skeptical
    but a) I don't know the source well enough and b) the fix is low risk so
    I thought I'd send it to you folks. Everything below is the AI generated
    explanation.
    
    The "difftool --dir-diff syncs worktree without unstaged change" test
    fails intermittently, particularly on Windows CI.
    
    The test modifies a file in difftool's temp directory via an extcmd
    script and expects the change to be synced back to the worktree. The
    sync-back detection relies on git's change detection mechanisms.
    
    The root cause is that the original file content and the replacement
    content have identical sizes:
    
     * Original: "main\ntest\na\n" = 12 bytes
     * New: "new content\n" = 12 bytes
    
    When difftool creates the temporary index (wtindex), the cache entries
    have sd_size = 0 (zero-initialized via make_cache_entry with no
    refresh). Git's ie_modified() is designed to handle this by calling
    ce_modified_check_fs() for content hashing when sd_size is 0.
    
    However, Windows has known filesystem issues that may cause this to fail
    intermittently:
    
     * UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
       same information as lstat() after close (config.mak.uname:506)
    
     * NTFS timestamp issues: The racy-git documentation notes that NTFS is
       "still broken" regarding timestamp granularity between in-core and
       on-disk representations (Documentation/technical/racy-git.adoc)
    
     * Attribute caching: Windows GetFileAttributesExW may cache results
    
    Fix this by changing the replacement content to "modified content\n" (17
    bytes), ensuring the change is detected at the earliest size comparison
    in match_stat_data(), bypassing any platform-specific edge cases in the
    more complex code paths.
    
    Note: Other tests with same-size file patterns (t0010-racy-git.sh,
    t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
    because they use normal Git index operations with proper racy git
    detection. The difftool case is unique due to its ephemeral wtindex
    created via make_cache_entry() without full stat refresh.
    
    Signed-off-by: Paul Tarjan github@paulisageek.com Reviewed-by: Johannes
    Schindelin Johannes.Schindelin@gmx.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/ptarjan/claude/fix-difftool-test-DDxDC-v2
Pull-Request: https://github.com/git/git/pull/2149

Range-diff vs v1:

 1:  dd5b774451 = 1:  98bc88f336 t7800: fix racy "difftool --dir-diff syncs worktree" test


 t/t7800-difftool.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bf0f67378d..8a91ff3603 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -647,21 +647,21 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch
 '
 
 write_script modify-right-file <<\EOF
-echo "new content" >"$2/file"
+echo "modified content" >"$2/file"
 EOF
 
 run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
 	test_when_finished git reset --hard &&
 	echo "orig content" >file &&
 	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
-	echo "new content" >expect &&
+	echo "modified content" >expect &&
 	test_cmp expect file
 '
 
 run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
 	test_when_finished git reset --hard &&
 	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
-	echo "new content" >expect &&
+	echo "modified content" >expect &&
 	test_cmp expect file
 '
 

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
