Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2B2459C5
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314126; cv=none; b=JV4Qzxok4WEn9xyjK6ZEJgTFLn1o2421iaUESGoEXSVrgk6lkjXTZYv6iGXRGSbQNN2/N5QBi23giTeNcVWVQ8PnYApg4mUJEkGUCsIif0TB3AXD9X9+xyDh9WoKREsN+0G6WRPW+RnJKToxsqocd4m1DyftEEw3/YHWhJA3yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314126; c=relaxed/simple;
	bh=ETfxImIv05gDLC75m1lZiaspdJ5pEiFAQdGN+p+mU0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rhNaw5Jjz5H9XyV5BPcUv71srVHK1+CnvUthwWmXi4hITGAIYnojaDYeJNrzzGdqqdOJ4yyutSMVoUt8eU+jGXb7I0CDU5g/2xOetTKljLIaS2w0d+fyistmbyLv34P3H4KqTD/1Z6tSrIaO7NlyQ+1RAi3m92aPNFOTmaghE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwjCGYCb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwjCGYCb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7c6ec9dbso102005285a.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 22:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783314124; x=1783918924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVjR9VqGJ/nQ3wX7uuTqME7AsPO7GwkiLyoLTEEf/PI=;
        b=iwjCGYCbkbDo136L4S6iPOy28JKgwe9pNUXymjwDQ6I1pi8/XcE1mgkr78+58YNAgm
         Hj13wlga8TEU3CYi2xI4RdGm2YiVrgdxZR6H12o3jJvUz6P8q2yJvNDbuQa2D+3hDXf+
         PXYhVrpl1cSwOlYpQ4q5yLHe4X9/7XMTnqmUpk84XKXj5X6molFMkiwSEH+ptCKzaI4R
         /w8s/iv2T0tzD9RClBjInH3NViwNyJwxkUuTP33RXApiVDuocYQFCzZ5F3fI06hoR+FQ
         kKV3cFmntpBy9wk8ZFgTOUvnHNeT3nCrQPWctZ/kM6CIkdM3owHyMxPZ7BjqzDVad2DJ
         kAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314124; x=1783918924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVjR9VqGJ/nQ3wX7uuTqME7AsPO7GwkiLyoLTEEf/PI=;
        b=ZH3fLezIQnW1sfVI6XEkYuQ6cudhm/a8YYkXgL2cw0gvQF+nKJQAC8xPy9wt9GGvys
         /hVdHxI6OSQcDj8RMbd5QVT9hDoUjC2EQHH6BrvKBhyc0C8j+8QcyIfWidus4sFu18YM
         X50cWSTvASFZJX09I+5AyKebESC7txJF0vA+cTRcMFY6LN90lt1kkYEWyYHFjBNmrZ71
         KZTvFuGF31gryN+GRlOzSqIUdaOxpwSoE8q2nmPF1gCp6Wwb2FPiElm2NV1zvhZWUIqs
         J//fF4F/ytgjwf4oaD6mO5DaSZaeXVySXeNfLNae/Ok+Mk7BNoyGm4kifTFCFpXlEv+3
         HW3w==
X-Gm-Message-State: AOJu0YwiPFf9gWN3Um6D6eZ62WBBIZGjIV+1w1LchGV5k4atpBvnf3aZ
	06dzXHzrVTXy0xFE2LHVapavoe0AMMK45aMvHuXyc4venEYceAqCRALBSFj6KPv5
X-Gm-Gg: AfdE7cms3DU5YKlPC75ehZVfmgxJCCSoAiSkgjivv39j7M1xDqwQ95A+j3Lw7OiUCQ7
	z5zHZsRRnOfxm/D/4/WJ9/AApxh43tzkPa7uki+gNCOO7QyXpdqzbaN290e9u2b0qia6SVg1eHd
	E54eSED+xPwhz1aG/fLA+6iaTq6RbTq4OtNDmnzrMy5E1ydmcm43nN9o07KozwchITWbCybFHOT
	93aHRWmJHkCwA/HNqpp1Qo7kxPlNtTgTXgW+q2yHN9XHZ/an4ZXgelHqmYtIwPIJChvQKnNaeGY
	E4JORA7rNgchoyvnOqy4gUXKkprLUi40bB2d5rHDCVRCfVCu8AMq3c/Lu3P7LifzsLbPFUWG+4Z
	EYQnYh6jTRixnkZI2dNKTxm5wBCPbnXSJ/bzZ16iGaxKG/uZuVSaVU0p8S08gwklu8eOI7s2iiP
	0HvsLwowcicxuk2OLcAqMAgzqb
X-Received: by 2002:a05:620a:4013:b0:92e:2c3a:a15c with SMTP id af79cd13be357-92e9a3e0f22mr1245447785a.29.1783314123619;
        Sun, 05 Jul 2026 22:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bc3a9csm893811885a.21.2026.07.05.22.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:02:02 -0700 (PDT)
Message-Id: <44d5db91bc3e951a6d2e34acc545b7093783bdaf.1783314119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
References: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
	<pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 05:01:53 +0000
Subject: [PATCH v4 1/6] t/README: document test_grep helper
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

test_grep is a wrapper around grep for test assertions that prints
the file contents on failure for easier debugging.  It also accepts
'!' as its first argument for negation, which preserves the
diagnostic output that '! test_grep' would suppress.

Despite being widely used (and the preferred replacement for bare
grep in assertions), test_grep has no entry in t/README alongside
the other documented helpers like test_cmp and test_line_count.
Add one.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/README | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/README b/t/README
index 085921be4b..4252774f86 100644
--- a/t/README
+++ b/t/README
@@ -1039,6 +1039,40 @@ see test-lib-functions.sh for the full list and their options.
 
    Check whether a file has the length it is expected to.
 
+ - test_grep [!] [<grep-options>] <pattern> <file>
+
+   Check whether <file> contains a line matching <pattern>, or
+   with '!' that no line matches.  Use this instead of bare
+   'grep <pattern> <file>' in test assertions.  On failure,
+   test_grep prints the contents of <file> for easier debugging,
+   whereas a bare 'grep' would fail silently.
+
+   For negation, pass '!' as the first argument:
+
+	test_grep ! "^diff --git" actual
+
+   Do not negate by writing '! test_grep', as that suppresses the
+   diagnostic output.
+
+   test_grep should only be used as a test assertion.  When grep
+   is used as a data filter (e.g. 'grep -v "^index" actual >filtered')
+   or inside a command substitution (e.g. '$(grep -c ...)'), plain
+   'grep' is the right choice because the exit code is not the
+   assertion itself.
+
+   test_grep requires <file> to exist and will BUG otherwise, so
+   use it only where the file is guaranteed to exist at that point.
+   When a file's presence is conditional (a backend-specific file,
+   or a path that only exists on some platforms, such as an NTFS
+   8.3 short name), guard the assertion on that condition (a
+   prerequisite, or a 'test -e' on the path) and use test_grep
+   inside the guard:
+
+	if test_have_prereq REFFILES
+	then
+		test_grep ! "$refname" .git/packed-refs
+	fi
+
  - test_path_is_file <path>
    test_path_is_dir <path>
    test_path_is_missing <path>
-- 
gitgitgadget

