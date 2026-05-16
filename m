Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A203E63A9
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947189; cv=none; b=BOJ7CVzrCSArD5CkvqeR0/VoDgutXrMAs3f4rHCEQ9ISJR+aAXGB2/eZDpibWk+Nhj9PeZIMAbThUVb3Zs25yhA+DuwFL+d/xBPAxEI5FARRXLOHRSix1lR1MFZZKwxG/LXI2QJJcaSQEgvJxeGZoDsJ3CyoTY8RH+xCAgn9p6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947189; c=relaxed/simple;
	bh=sKhqXXSI1Vg6Tat3HQ5sGmZ3roeC3MthMSoDo0NrIh8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nk4vZzVq0WRQDnONxaBw8GoLLvs1vYnngiVau8F0w72LzsD6QnJL6xQF77Nn2vd7lh0S24zP9kIUoylWLVFnKgZCMTk6E6qebYMtHje+DzTY2PjxI0UnfAJUkJ558gAc7Ykvicgo4nxi85Q5As6/WF1W0x7NAIMxcmQjkT5i/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut+g4M3m; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut+g4M3m"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1354403c610so2430009c88.0
        for <git@vger.kernel.org>; Sat, 16 May 2026 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778947186; x=1779551986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzIoVgsVyLM181K32B1UPSBcqqvUfk4q3Y+Rny7YG6c=;
        b=Ut+g4M3mct22dwb09htf470SNbkZfiuJPo60pW4fyhNep3wVDyuSlk26ZMzRT7rBwb
         MO3rMWgJDg6ZTK1hhFB4l2qAwy21hgxeplpBuTAfM0Uy2vg01I3EsO9E3gJz1h+wZDW6
         XJqplP0soRQhvRefbh3AyaJo3rQxV7F2mP/czFNAdOrf+jMdo/PTcdNPzRINmVgZLwwG
         DgPWwNAmE+gNlk8GqXSr7Ff4GpxfOifsf6+HXNlZANF5DoaLG8ZJw28IlZkJkHNWAYX7
         JOs8TjTiAQ5Y9x8ur09pIFJGs5Czj1HDS9/bBQqbtES9JlIY5K2doWb5qS2f6Bj3pjJU
         naUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778947186; x=1779551986;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzIoVgsVyLM181K32B1UPSBcqqvUfk4q3Y+Rny7YG6c=;
        b=aI50irn7MJd0iMpd2H81SMG2bmSK1JaInOJo77rmhtdMn+/QY9DRi1pSSTfXE2nOV2
         c+XUWV1mzUQ1pN9iwRKqpNDuBR9ewqlnM4yIlDHzxv1XtvyyspPOK14gPqQc97W+KzNx
         TfZRKfXZGL9VMAMvsZi/l8KwsIIPqXGGf8sVO2xkA9JNrqnLKCVEzLDLtHUAFOJTGO2w
         p9LdjSFD0xyOxqzHyxM3gTt6WgmCPRrSBh1T9urIj59Vl/OZZvbHIpov90sWYCO1sOSh
         nXENcXvbYewNqrBMzvb1B3O086fWQDx/I3YIPjGzzHVWBm5JXVdaenCgHwno8CwL3J6k
         krAA==
X-Gm-Message-State: AOJu0YycgvSs9PrNYrLPwBFFG3h3mJ+MBksy4JbI+/38AIlyszlvyl00
	G6mKERAThQWFsIHFJ/qGKJgvqL3Ld4aVl+jSQ3jTz4SVXRkd/lQnVPLVwGeYqw==
X-Gm-Gg: Acq92OEGxlIKjqjq1GH9P/bliPp8i0qdZnG3GeUdBtv+lbin4z2HZwf0IvxhlbhMYca
	o8QZdNreXiTUQXnng3QvHlC4d2V+EWbF8M76VE9yKXCCt/44+KbNC7iomTMPFvbAB2EJA81WjyF
	14B/jdqZBSzdR7qSzC3txuYX74qIzuULmfTu1ah1HgetztfhvfxkShHgxQ5greLRg2zzD1fKXlv
	tnJfkl5GU3c9eU+E7MkSSXhkQzo04sbfSvwBsFutlksACXwWH2QABbgFwofyKmheNeM7NwRQiQe
	fHUvG6oPLuTyWMpNjDZ0KlyZzLY7Al5kUjX1icAFhKJRjE2+PaKAIbq1dXOORnWgaYchSgKKcWn
	fAa5vQbb1mlJ+aQMJJ6O26WgCrMtgDh6w6zguJMEoh5E0V4Q0xMduo1oMbDAB92aCIjKToY7/Mq
	u2NGR3UxA0RHCrZyh+foMZG5Bs3/sAtjC1oM7lDgU=
X-Received: by 2002:a05:701b:2315:b0:135:245e:5d6a with SMTP id a92af1059eb24-135246de1efmr1672006c88.24.1778947186415;
        Sat, 16 May 2026 08:59:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm14934255c88.9.2026.05.16.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:59:45 -0700 (PDT)
Message-Id: <4d11ebb79ea780c1ce619c66cf9693d819d86d4b.1778947182.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
References: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
	<pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 May 2026 15:59:41 +0000
Subject: [PATCH v3 2/2] t6600: add tests for duplicate tips in
 tips_reachable_from_bases()
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
Cc: Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When multiple refs point to the same commit, the reachability check
must handle them correctly.  Add three tests:

 - duplicate tips, all reachable
 - duplicate tips, none reachable
 - duplicate tips at the minimum generation (exercises the
   early-termination advancement logic)

Suggested-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index dc0421ed2f..9486002866 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -612,6 +612,51 @@ test_expect_success 'for-each-ref merged:none' '
 		--format="%(refname)" --stdin
 '
 
+test_expect_success 'for-each-ref merged:duplicate, all reachable' '
+	git branch dup-a commit-3-3 &&
+	git branch dup-b commit-3-3 &&
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/dup-a
+	refs/heads/dup-b
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/dup-a
+	refs/heads/dup-b
+	EOF
+	run_all_modes git for-each-ref --merged=commit-5-5 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref merged:duplicate, none reachable' '
+	cat >input <<-\EOF &&
+	refs/heads/dup-a
+	refs/heads/dup-b
+	refs/heads/commit-9-9
+	EOF
+	>expect &&
+	run_all_modes git for-each-ref --merged=commit-2-2 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref merged:duplicate at min generation' '
+	git branch dup-c commit-1-1 &&
+	git branch dup-d commit-1-1 &&
+	cat >input <<-\EOF &&
+	refs/heads/dup-c
+	refs/heads/dup-d
+	refs/heads/commit-5-5
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-5-5
+	refs/heads/dup-c
+	refs/heads/dup-d
+	EOF
+	run_all_modes git for-each-ref --merged=commit-5-5 \
+		--format="%(refname)" --stdin
+'
+
 # For get_branch_base_for_tip, we only care about
 # first-parent history. Here is the test graph with
 # second parents removed:
-- 
gitgitgadget
