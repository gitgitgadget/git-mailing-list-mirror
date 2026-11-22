Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795354769;
	b=e9+aaxlyDBoEsWbQ75WAxBXyvjK94uWW1Q464zbRgHqwlDgP1BXvAhdqNZSl3Xctiznv
	 ywOjWI3Xj0Cc/YKQzawTLBVisWwtbu66im2RjiGsT894oOtm8ux3Gc+wbKQGA37T+g6YH
	 8g5Gs7Mw9aPDht39+Mypcu5seLvRP7XMmFlsmcrUvqZdt5R36XLeZcfsXlXy+VAD51pL0
	 EOdnGFVn9DyjU7d6CRL32d9c3+7NBczKTJQ/iN88YPcv6XUkja3OUXnxS1tnpUyNqAhdX
	 mHsR9/64IqdQdQov++qdONWxL6vFL9KIx2PmZe4y/tUaL8OnJ8nOSMZtoIezj+5kShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795354769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=J6wShsfZhZMOWOsNNjmjpzACPQPY0inv3LxL5lfHAfg=;
	b=qKHF+UFWYQHOj45Kji7zvLyn25jj5Do+UHsuzXEr3AwFAnmRbT930wu9kIyVQofyZsPp
	 i8MpPDDt+/y0jG4rxEfnGRtMJu6PYWxtybE+FFG6js+yT5hS9Sf0Icr5R0ZEZ/7pGkShK
	 8jxK+KjnAj9ZBNp7nYvFS7TRvygNPYNecYDwprsPWwL2FE8kZ5e+oEMOMmiMUARAI01PX
	 UkZ8dnCPEyVrKvqi3QwzAKy426V7nDVXHoTzoMpXAMGUWqXeM+/rsp1z58R/6EJi4UPT4
	 76U7FOSEYGeMpVbnPdtIJVDRPYZ6ZHAdEYkfQduaiwWmQgB8sW3bKDfOwz4hvdSkDmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AK4iCtCL;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78297606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 13:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78297606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AK4iCtCL
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso1355619a91.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354768; x=1795959568; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J6wShsfZhZMOWOsNNjmjpzACPQPY0inv3LxL5lfHAfg=;
        b=AK4iCtCLGgbf96ZD5gCne5sLUD0I63xph16Rb4lIjZ3vYIbWyFZPA68Gi7suQXeeMh
         OcyJl39UCtH1xahThISPjDxcdpbiZHJ+W0QjMXseCmkRhyjwg2BL9nJu6ay4sjS5boUx
         IzoerKSqrHJOI1Ftzk4S+nflEl3T2fnYUzX8CeZYS2jb1YnG9syJ90mx8ICvSbCzT6cz
         sk6rrimFMqd5ryvBrP1qk50tOLAPMDeDjurN7sGdn/aNzfwvI4XZP2ceuRO5IA+5rOD5
         mLARPsSAd8q29kSGK98Nov/tf6VqwmIC19pGkH09QJyhvIgMfkHjE5TSHGglco5bZo36
         pHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354768; x=1795959568;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J6wShsfZhZMOWOsNNjmjpzACPQPY0inv3LxL5lfHAfg=;
        b=zbFcF9vayyvrFadgWJ4+8E5nQx3SF++Qp4Qkz8Pblynpg4puybZVBjEJjLaRNAMLvw
         yAKGC8WMisyDKQQ/rkp3BZIMn0GLBGP+Xjfbz9O2YBXNjxPE1D9wu/dC9ok6Uk/II7dK
         v7Ap/dOAjvJKvJD8j4b/oFXx5ZbgpLde0lnAAkcWsF2sNZqfwsvK2eoGyjr6FhQ9HHFe
         Vjz0vYbcLcAClbP8feNJnNBkqPMKN6GDsFBGxd9uFP4nUGuwxBRRIFeEy/1awt4hGvIU
         CI9xOslHUL3L2OKD7wHPSCSHM+BKyheeHPAVBzKOwTMR5VedIP6CpzCJa9BFExBWSThp
         zE4w==
X-Gm-Message-State: APuU4Z/vACeX6xta8dpzK3BXf7nah71gnvCMaZtLf7D68J6ZrobYigEt
	UjBQQDQOKILImASOIimEZUwWThXZ2S0pOxty8ndWPBAHmhN0rW0ABOxpjseh2g==
X-Gm-Gg: AZFdTZf9LgiMhKES72itt9uXivhOYr6UYJVxmmApJxsUkUzdl73ubFFHGsvX8K0LbCM
	Ah6abGGy5g3q8doHlZ4FyHvZyW/mpCDBcfkVvyT+IEizL1s0LTRQ4F/M7yIYA7F9zYYdl6noJ48
	oGLxIHpHvNAgl/9oH2RYewfCBChSXh8Bia7AJv3L4olLYpqMhiFNIx74B0ATgjwDWtuPLAGB7WN
	svQOhz5u1jbxIG7ohTSmfeYEi9/5ClS3AbVgg/3/vrxpQ9/0u7K0yE0hhR9YP9o3rXDA1L9X7Ya
	hPsD4b8XwglNogdCJHsjL008Yd3bL8NTzFUZBLWXTRXLFsB1MjJG2LzbM7lPQhUzWA8vvklpIeg
	AAV0ihuiK8/Wstu1Yk6QVUcIIfJmovpw2bizImV+gcAwc/7rPJ1BMmIxHLfsRLaBGlRdG8gZgWM
	ptlKJR0C9I5X4LQq0cBSPlzW8kHZjikHWnGahwf8/2J4284x+yNg6f/OE3Rc/mZY1PimFQu7YQO
	r1rBnaKPrAw35Y5y6uYdEEXj53QmozlbMfvx2LVl89iBZxOyf+ICGc1Y+VgC4m/1lJvaKG6n6ps
	b7njhhSp3zBC8l38/xS9++dgv++rJCIYhA==
X-Received: by 2002:a17:90b:3f0f:b0:3a0:b312:1fbe with SMTP id 98e67ed59e1d1-3b41c9006d4mr11594048a91.23.1795354768300;
        Sun, 22 Nov 2026 05:39:28 -0800 (PST)
Received: from [127.0.0.1] ([20.230.181.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm16016077a91.12.2026.11.22.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 05:39:26 -0800 (PST)
Message-Id: <pull.2503.git.git.1795354765127.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 13:39:25 +0000
Subject: [PATCH] difftool: handle invalid paths without crashing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Check the cache entry returned by make_transient_cache_entry() in
builtin/difftool.c. An invalid path can cause the function to
dereference a NULL pointer, resulting in a segmentation fault:

$ blob=$(printf '%s\n' DEADBLOB | git hash-object -w --stdin)
$ tree=$(printf "100644 blob %s\t.git\n" "$blob" | git mktree)
$ commit=$(git commit-tree -m BADCOMMIT "$tree")
$ git difftool --dir-diff --no-symlinks --extcmd true "$commit" HEAD
error: invalid path '.git'
Segmentation fault (core dumped) git difftool ...

Add a regression test in t/t7800-difftool.sh for a tree containing
an invalid .git path to ensure git difftool --dir-diff exits
correctly.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    difftool: handle invalid paths without crashing
    
    Check the cache entry returned by make_transient_cache_entry() in
    builtin/difftool.c. An invalid path can cause the function to
    dereference a NULL pointer, resulting in a segmentation fault:
    
    $ blob=$(printf '%s\n' DEADBLOB | git hash-object -w --stdin) $
    tree=$(printf "100644 blob %s\t.git\n" "$blob" | git mktree) $
    commit=$(git commit-tree -m BADCOMMIT "$tree") $ git difftool --dir-diff
    --no-symlinks --extcmd true "$commit" HEAD error: invalid path '.git'
    Segmentation fault (core dumped) git difftool ...
    
    Add a regression test in t/t7800-difftool.sh for a tree containing an
    invalid .git path to ensure git difftool --dir-diff exits correctly.
    
    Signed-off-by: Ophir Bleicher ophirble@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2503%2FOphirBleicher%2Fbug-difftool-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2503/OphirBleicher/bug-difftool-v1
Pull-Request: https://github.com/git/git/pull/2503

 builtin/difftool.c  | 2 ++
 t/t7800-difftool.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc7b2ea443..8208ade472 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -336,6 +336,8 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	int ret;
 
 	ce = make_transient_cache_entry(mode, oid, path, 0, NULL);
+	if (!ce)
+		return -1;
 	ret = checkout_entry(ce, state, NULL, NULL);
 
 	discard_cache_entry(ce);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 0079aa9da4..9c79b2dec0 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -929,4 +929,12 @@ test_expect_success 'difftool --rotate/skip-to error condition' '
 	test_must_fail git difftool --no-prompt --extcmd=cat --rotate-to="3" HEAD^ &&
 	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
 '
+
+test_expect_success 'difftool handles invalid .git path' '
+	blob=$(printf '%s\n' DEADBLOB | git hash-object -w --stdin) &&
+	tree=$(printf "100644 blob %s\t.git\n" "$blob" | git mktree) &&
+	commit=$(git commit-tree -m BADCOMMIT "$tree") &&
+	test_expect_code 1 git difftool --dir-diff --no-symlinks --extcmd true "$commit" HEAD
+'
+
 test_done

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
