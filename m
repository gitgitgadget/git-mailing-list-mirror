Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04A355F41
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443171; cv=none; b=beQ4C2mnx2lyZIF+FKW8ZvSIPQ0lIHkIEHXCcnsvTCf865QeOrB2yAtsTusmxyx/7bmSR6eCR4JiBvDn37MfLsoYGLxYJPSeOyTmKTGJBmITZnjuPVSMLY/+1cCoHthKT7eOo8QVssnEjSq+74IZ2t76DrsgATkAIzlQx/vsMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443171; c=relaxed/simple;
	bh=tpuwDWwm6YLZcOq9QiAzbFjtIX7reT8no1C2Z/RePdQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=axgRtNCJX8FRj+QOpZOwNLMTDOHMcm861FQC9SdjVkuYI3zVJ+1XE1yzMZqI1qbYT40jI2+vP6d1UC1zbYyR1igtkkWoaPh078vgnfnvvRe9ela3YkloeV5+MN+BcSMmhAKuDwqfphSeLzw0kJFtcXAz3F+4iOn1yWMAyZCGQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIsQbMvS; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIsQbMvS"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c7212836bso1592128c88.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776443165; x=1777047965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zG01ogzS4PrflHdjrElY9VIjxUfxMRuOIEOI4ahiFEY=;
        b=dIsQbMvS/NYKTWDVxiGPJXQHE7QtAaqzSRTQARzm+ip7syvFu/aPUBNyMcbAfvHSN+
         poY2ipQPUpx0VjQAs97Jw9+GSmmP+4JQV1gRWziggMrLWvIVgKZkxhuA69T2ZMMBZqmr
         HqbRtdnKwQqaLn53FRMDtthZgN2n2ipPU1P7j/w0ca2xAO31oQmZcQlTXTfyjcZ6rXze
         XEBaDuEyjbYdr9Ah9JTlcsF8MqAvEUmcrY2TcckQ1v9+EN90EvWZ4HMm8sRi3nLxGvK/
         euZX+AogzweMy3nWomXU2I1NbkFgSUrerjhU8Pq+UP6MXfuzN7//qwvTQ54RX0XeFTTd
         q81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443165; x=1777047965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG01ogzS4PrflHdjrElY9VIjxUfxMRuOIEOI4ahiFEY=;
        b=QNnwIuTMoPJMA+qPPGfM3xpBV2+adpEbttVtP4udw7MRIXB5NuA89KyG7ilCZOK1f7
         c3hcVhw4iyf7qZOaiAZWum9t+WSwOEgZHZp3NN7XNRhFTKlYjdbfI6bQlKilJNITPYTh
         m/gyY383+ls9yPoN2FCnGo5xNiQVkZlTlfOuJ2m0HYs3W3+TReAVnuVrsZER+3p/f8VF
         kVl649Mr42tuMA76CeR+YDUDp4u0tbwmrQXY9eFX5Pd+aPWjndE73JXoEehMmhcKVuZs
         mZA5lIeLJ1zG2ij1O7ac1xJBoTsK8ogYBlkM+pAOTla/O7rPOb+dbEwZbkIQGZdSR03H
         d5UA==
X-Gm-Message-State: AOJu0YzeODTwOcNqmqjmdOgI1AUDW1SvOdHstwPwWpyT5oEr9YgX9dWT
	Wm/75ykiMK16ob3JYxPWTQg72zZ2DOpEzEfN0FCWlJ41JCT4lMCnmDff+GJizw==
X-Gm-Gg: AeBDiesgMK61i01eAEIlR0AwO3qDkg3H0kKVQVXanXjzS4vyuCwciz51mCodCSBD873
	TwpJ3NPyW3OqJlvRimShQTSW7tl84AZuDiZtks79PZHtlmZCQExYXwlLzIPYQfc+VJB86I2CD4I
	9kBMsRGEJhWFDxCqA/AWVBcOwJM50dcPD64fxaQN0nEIqflXsBRsus2duuFENk4HzNZrSRLlbGj
	DCqMJ9fhdhFaIDdYRRLO+q7cQ0II7jm2psQFp9OCehprwqwJWUo2kp8naB6412otjiMFtK3Q/t1
	i/3VL0uhi3Ha5gTQOWodlrNxddXEkSjGmvQ5Ag6ETyfx9CZxjyObpaszA/nGtfbK+jNyi9X+t0k
	OTWNUjG7OjV7/ycvIUMxMQ1HZfhdLvX68vm3keBzA26+v22n77vbfpG15t5Vfl85RxsjJ0tiyMj
	RPro6c9WyfGyuYHe78MvvTT25yKAITaF48D0EP
X-Received: by 2002:a05:7022:e09:b0:12c:3d30:37c5 with SMTP id a92af1059eb24-12c73f75976mr1945211c88.12.1776443164727;
        Fri, 17 Apr 2026 09:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.163.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm3507785c88.14.2026.04.17.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:26:04 -0700 (PDT)
Message-Id: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Apr 2026 16:26:03 +0000
Subject: [PATCH] diff: fix out-of-bounds reads and NULL deref in diffstat
 UTF-8 truncation
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
Cc: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
UTF-8 chars, 2024-10-27) introduced a loop in show_stats() that calls
utf8_width() repeatedly to skip leading characters until the displayed
width fits.  However, utf8_width() can return problematic values:

  - For invalid UTF-8 sequences, pick_one_utf8_char() sets the name
    pointer to NULL and utf8_width() returns 0.  Since name_len does
    not change, the loop iterates once more and pick_one_utf8_char()
    dereferences the NULL pointer, crashing.

  - For control characters, utf8_width() returns -1, so name_len
    grows when it is expected to shrink.  This can cause the loop to
    consume more characters than the string contains, reading past
    the trailing NUL.

By default, fill_print_name() will C-quotes filenames which escapes
control characters and invalid bytes to printable text.  That avoids
this bug from being triggered; however, with core.quotePath=false,
raw bytes can reach this code.

Add tests exercising both failure modes with core.quotePath=false and
a narrow --stat-name-width to force truncation: one with a bare 0xC0
byte (invalid UTF-8 lead byte, triggers NULL deref) and one with a
0x01 byte (control character, causes the loop to read past the end
of the string).

Fix the bug by:
  - Adding a *name check to terminate the loop at end-of-string
  - Detecting the NULL pointer from invalid UTF-8 and falling back to
    showing the full untruncated name
  - Breaking on negative width (control characters)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8
    truncation
    
    Maintainer note: This is a new bug from the v2.54 cycle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2093%2Fnewren%2Ffix%2Fdiffstat-utf8-loop-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2093/newren/fix/diffstat-utf8-loop-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2093

 diff.c                 | 13 +++++++++++--
 t/t4052-stat-output.sh | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 397e38b41c..7b27241733 100644
--- a/diff.c
+++ b/diff.c
@@ -3093,8 +3093,17 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			if (len < 0)
 				len = 0;
 
-			while (name_len > len)
-				name_len -= utf8_width((const char**)&name, NULL);
+			while (name_len > len && *name) {
+				int w = utf8_width((const char **)&name, NULL);
+				if (!name) { /* Invalid UTF-8 */
+					name = file->print_name;
+					name_len = utf8_strwidth(name);
+					break;
+				}
+				if (w < 0)  /* control character */
+					break;
+				name_len -= w;
+			}
 
 			slash = strchr(name, '/');
 			if (slash)
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 7c749062e2..84c53c1a51 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -445,4 +445,29 @@ test_expect_success 'diffstat where line_prefix contains ANSI escape codes is co
 	test_grep "<RED>|<RESET>  ${FILENAME_TRIMMED} | 0" out
 '
 
+test_expect_success 'diffstat truncation with invalid UTF-8 does not crash' '
+	empty_blob=$(git hash-object -w --stdin </dev/null) &&
+	printf "100644 blob $empty_blob\taaa-\300-aaa\n" |
+	git mktree >tree_file &&
+	tree=$(cat tree_file) &&
+	empty_tree=$(git mktree </dev/null) &&
+	c1=$(git commit-tree -m before $empty_tree) &&
+	c2=$(git commit-tree -m after -p $c1 $tree) &&
+	git -c core.quotepath=false diff --stat --stat-name-width=5 $c1..$c2 >output &&
+	test_grep "| 0" output
+'
+
+test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not crash' '
+	FNAME=$(printf "aaa-\x01-aaa") &&
+	git commit --allow-empty -m setup &&
+	>$FNAME &&
+	git add -- $FNAME &&
+	git commit -m "add file with control char name" &&
+	git -c core.quotepath=false diff --stat --stat-name-width=5 HEAD~1..HEAD >output &&
+	test_grep "| 0" output &&
+	rm -- $FNAME &&
+	git rm -- $FNAME &&
+	git commit -m "remove test file"
+'
+
 test_done

base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
-- 
gitgitgadget
