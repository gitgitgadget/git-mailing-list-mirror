Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2917A31C
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699783; cv=none; b=XxLTBaHuyPEUy6yNcYhPm+G2fMTz/W5j4mtdLjuuX5kR/44lCUuIg+BMrxRlpnRk9nOzDp+s0z1wjreCEkq7sluUIRebDO6Ev9lV1Oww5ZhuvfU5i6SwbCA40WvxvJjVKd3lTXSmPdeXPGlTwUxd22YeAjJszvahtDK4EqOfpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699783; c=relaxed/simple;
	bh=aV9iMkCUt6A1kNMnwFPKdt1Lcuw0A3aP6c1KTlIfvXQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VTqAbrNV2LA5fdlMy2u7gSHO4TAsIUoS8ce1Kc24xFEKsMdJHNWA+SR2ucev4AZVgUvODnh1hQ3C8+XUiS8YEEW7CzNrFCSfhpoA+lN8b6SkjPAnZIZNbGXuywJZiFDAOZdvlFQu0K1rKW9pvDGhMYSsI0iZb98JX+hM2Eu1WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLrM99YW; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLrM99YW"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so55992eec.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699780; x=1777304580; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsJJjV4WzSWNKJwqr9AyeTui0jUOGK4O+NVtle/uics=;
        b=mLrM99YWWhi7xIvgbEp9Q++Ir9Nxa8ELZwsou/cuHXPiKVgaRts9PVxrzLaHt40/ZH
         1CL0yJVWeekt0j/NgNQRG08Qvx0Bpt7GrsBSRbafIpsUZsEz2PiMn3m49w9U27/R/nup
         K6BOQuvcEHDQZ9x8ImzJ7naXU3VbzZX7DchMw00haflIbOOK2lg+NiQeG37zg65aKQMq
         E62aNK2WXRK1C8ZT6cR7rVZaGFCGHrsni2K18HNzqR5+Gw9Tv5h5Ufk4/LpozGJXb/61
         BLNTPjwcUryIHk+y+nKVdMKe0Hr32lIawXqXmHyrv+UK8O5V/xkC/80ovkb+AD5z+gVO
         UAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699780; x=1777304580;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsJJjV4WzSWNKJwqr9AyeTui0jUOGK4O+NVtle/uics=;
        b=pWhh+yQwxZzCUUFptPfaMVk33wahfDXnxkCtTT1EkEVIQMTddVrrtUvr4HxefNamDU
         J8mxHAuiEoVB2zgISvSzieUqVyojT2CPJ3u7qZu9uhFjwRU5Dvg+GPnE6yLeQ4T7CgaL
         +nmIj1xzLX79/i1fJ8bAMhs6LUkJ5F2+en5JUoK8+CT8dyqflwe+TAjFkiCr72ACfRmN
         tBflR562txM2d8p8p8D4aaaKIYmLQGmjDl6Rx4MKOGxus6AYSkBGINz0f/FqUturo/ZX
         9UTwf6ysIwz3gvopwoA9qYWj41SVlAiSR/oLpPlC8bY3+arLhlIXgGDDhzHcsyyB4C6p
         jsyg==
X-Gm-Message-State: AOJu0YxDqJV4MkMK/I7kWZxFDlTrU/2+u6SX1zp6UKaIS6O6zRfE8K1r
	snURfzbGVdyk8jZIgYSUdADoSZcq+WwUiw3uefiP8unU9lKyowBHRiiM7CmgOg==
X-Gm-Gg: AeBDietJo5bBKW2MeSXQ2qYhvuwgs752ndsDJ+2HHATkwPAjNdfKmiGHDJd9iAiDlVD
	fkH4nHaGeR070S50hy1FY2uj8fx68h6HkTYzvJjCUrdgF1bn3mYv0vuHG15e/bJjnvQtE7GeXfZ
	3PjcEPQv6pjfmoLhWRQJb4jefROy1dVBXB3FiBQLhHtsp7Cb6pditZQSDRPapdDtRr1hOkd+EUO
	RGcQkUhmtC5kRZcVGnwDcoIqKX1EyXSmD78l37UBHPyorN7o+bNbI2PGHpRjpwG71MowJOB2IPC
	qH+dxsnQfb4sJ9nye9s439wprdCUUluHVdqG7EmE8WH+h6OmXbhuUCJ7BYQGkD63+dieir4NXUF
	SXMPnm2igwqQ5MT5pe7MT+C66l0n3mEmyKNUTS6VYWCfitIqoapk8EjKNEGHG/7VislO6/5j48y
	W/yRZW1roCbX0pnBitekc8GcIu8H7UflBNx5T7UA==
X-Received: by 2002:a05:7300:bc9a:b0:2d8:c521:c157 with SMTP id 5a478bee46e88-2e478a2f0b7mr6890228eec.18.1776699780096;
        Mon, 20 Apr 2026 08:43:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm15261045eec.3.2026.04.20.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:42:59 -0700 (PDT)
Message-Id: <pull.2093.v3.git.1776699778177.gitgitgadget@gmail.com>
In-Reply-To: <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>
References: <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Apr 2026 15:42:58 +0000
Subject: [PATCH v3] diff: fix out-of-bounds reads and NULL deref in diffstat
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
UTF-8 chars, 2026-01-16) introduced a loop in show_stats() that calls
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

By default, fill_print_name() will C-quote filenames which escapes
control characters and invalid bytes to printable text.  That avoids
this bug from being triggered; however, with core.quotePath=false,
most characters are no longer escaped (though some control characters
still are) and raw bytes can reach this code.

Add tests exercising both failure modes with core.quotePath=false and
a narrow --stat-name-width to force truncation: one with a bare 0xC0
byte (invalid UTF-8 lead byte, triggers NULL deref) and one with
several C1 control characters (repeats of 0xC2 0x9F, causing
the loop to read past the end of the string).  The second test
reliably catches the out-of-bounds read when run under ASan, though
it may pass silently without sanitizers.

Fix both issues by introducing utf8_ish_width(), a thin wrapper
around utf8_width() that guarantees the pointer always advances and
the returned width is never negative:

  - On invalid UTF-8 it restores the pointer, advances by one byte,
    and returns width 1 (matching the strlen()-based fallback used
    by utf8_strwidth()).
  - On a control character it returns 0 (matching utf8_strnwidth()
    which skips them).

Also add a "&& *name" guard to the while-loop condition so it
terminates at end-of-string even when utf8_strwidth()'s strlen()
fallback causes name_len to exceed the sum of per-character widths.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8
    truncation
    
    Changes since v2:
    
     * Fixed the filename in the final test such that it will trigger the
       out-of-bounds read under ASan, and updated the commit message to
       point out that ASan is needed to notice the out-of-bounds read.
    
    Changes since v1:
    
     * Simplified the loop to almost what we had before via a wrapper
       function that always succeeds in advancing the string and never
       returns a negative width. (Which, as a consequence, treats invalid
       UTF-8 and control characters the roughly the same, unlike v1.)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2093%2Fnewren%2Ffix%2Fdiffstat-utf8-loop-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2093/newren/fix/diffstat-utf8-loop-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2093

Range-diff vs v2:

 1:  4a72647ce2 ! 1:  4a3126720b diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8 truncation
     @@ Commit message
              consume more characters than the string contains, reading past
              the trailing NUL.
      
     -    By default, fill_print_name() will C-quotes filenames which escapes
     +    By default, fill_print_name() will C-quote filenames which escapes
          control characters and invalid bytes to printable text.  That avoids
          this bug from being triggered; however, with core.quotePath=false,
     -    raw bytes can reach this code.
     +    most characters are no longer escaped (though some control characters
     +    still are) and raw bytes can reach this code.
      
          Add tests exercising both failure modes with core.quotePath=false and
          a narrow --stat-name-width to force truncation: one with a bare 0xC0
     -    byte (invalid UTF-8 lead byte, triggers NULL deref) and one with a
     -    0x01 byte (control character, causes the loop to read past the end
     -    of the string).
     +    byte (invalid UTF-8 lead byte, triggers NULL deref) and one with
     +    several C1 control characters (repeats of 0xC2 0x9F, causing
     +    the loop to read past the end of the string).  The second test
     +    reliably catches the out-of-bounds read when run under ASan, though
     +    it may pass silently without sanitizers.
      
          Fix both issues by introducing utf8_ish_width(), a thin wrapper
          around utf8_width() that guarantees the pointer always advances and
     @@ t/t4052-stat-output.sh: test_expect_success 'diffstat where line_prefix contains
      +	test_grep "| 0" output
      +'
      +
     -+test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not crash' '
     -+	FNAME=$(printf "aaa-\x01-aaa") &&
     ++test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not read out of bounds' '
     ++	FNAME=$(printf "aaa-\302\237\302\237\302\237-aaa") &&
      +	git commit --allow-empty -m setup &&
      +	>$FNAME &&
      +	git add -- $FNAME &&


 diff.c                 | 26 ++++++++++++++++++++++++--
 t/t4052-stat-output.sh | 25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 397e38b41c..1a3b19f71f 100644
--- a/diff.c
+++ b/diff.c
@@ -2927,6 +2927,28 @@ void print_stat_summary(FILE *fp, int files,
 	print_stat_summary_inserts_deletes(&o, files, insertions, deletions);
 }
 
+/*
+ * Like utf8_width(), but guaranteed safe for use in loops that subtract
+ * per-character widths:
+ *
+ *   - utf8_width() sets *start to NULL on invalid UTF-8 and returns 0;
+ *     we restore the pointer and advance by one byte, returning width 1
+ *     (matching the strlen()-based fallback in utf8_strwidth()).
+ *
+ *   - utf8_width() returns -1 for control characters; we return 0
+ *     (matching utf8_strnwidth() which skips them).
+ */
+static int utf8_ish_width(const char **start)
+{
+	const char *old = *start;
+	int w = utf8_width(start, NULL);
+	if (!*start) {
+		*start = old + 1;
+		return 1;
+	}
+	return (w < 0) ? 0 : w;
+}
+
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
@@ -3093,8 +3115,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			if (len < 0)
 				len = 0;
 
-			while (name_len > len)
-				name_len -= utf8_width((const char**)&name, NULL);
+			while (name_len > len && *name)
+				name_len -= utf8_ish_width((const char**)&name);
 
 			slash = strchr(name, '/');
 			if (slash)
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 7c749062e2..e009585925 100755
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
+test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not read out of bounds' '
+	FNAME=$(printf "aaa-\302\237\302\237\302\237-aaa") &&
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
