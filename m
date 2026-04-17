Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F223BD02
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776465915; cv=none; b=GlegXBWkTiIn8p0ebMWroAs2e04WPSAsYeu8on81l17d0bXaJp2B+8MkyCml7hoqdBgn/3YJLbJl967VmM3tHONa2X2P8im2VNBAIJFfcNVbwBIdMbSHKzRRnyttirKHGmUjubnSN4fqczGPNyLBjAlaX/yl3KrLme++68ii2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776465915; c=relaxed/simple;
	bh=gIy9BuJMDy/IzaOngHtil/LaNmhpUOOgUW/in8N82J0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hcMNj0JzyTup7iQAdNXClwijPTaPf7p4wVRRC28vYG5cc3uRnZvRKmfxLJuyXu/SCXHbTFnXgMpy/+9+wB2HT56gaL8V2Rv5K06rZdk8cQTAetTrh/5UwemVe63hjfUFCj7tAf4UVhXu+6fqHxwlrJ4/Jxkhxsh6gSwI++tQzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj7drW6m; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj7drW6m"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc5941028so159435585a.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776465912; x=1777070712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY3ZrY+mXaJHlh3DUDdsPL8ChiuWxNH9Os93hKoFd1w=;
        b=Nj7drW6mbrq5tJy5hEVgYHL1yGiwyJ+X6nxFaay6Esv+rViJtCk2KejzKeuoVIoTVE
         vUur3HWJqIHUXwSxjEFJUBbaLbK5+y5TZ6UEGllR1G3DI+GQcXmTEw9DjRELYF88La93
         yGLcK3JlzzDfGD33nrdgS3jUgp/55w6JK6gbWcDXwCJrQft8FMgqn2oqvNNcWghsyk9X
         kFVqxDpzInvw+0265m6qHlHGnp+3tgF4EeBhE3OC+ef8UldtGXTBRrILSNOPDW+QXvO8
         Tx1mtYvD6rZQJesMR+tJZCwI7syAp+4+H8L1GIZVPs6xnvrILnLKinQ2IjV2AFXL4lWC
         ve8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776465912; x=1777070712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mY3ZrY+mXaJHlh3DUDdsPL8ChiuWxNH9Os93hKoFd1w=;
        b=ZqyazxaoRQDi3AbYPs/vvrzvf5yRq1pSm+lzWZSZ4F282DgGYXm/G01kbajgn2fKyE
         L/VErPb8iZOhC3sgBODsVguY9gqhdo4anb9VzUUWPA+PtNttdSslVi8MJ1UADTT1Gi1F
         fWZMl4lwk5UwUg6SpucSGILz2ExgWuVeNVD2VoJGwWea9jEDNaHV/YpkolEvkunCft0L
         b673vb0LwtKD6oOru6UsTrwMlWS8pPKkxm8gyN87p8xQNazJ9cglDgdwfQ/JjDo4GkaG
         O82bhL5aG5ilSpqRUT7Aptxag2brRcy5RLUz9m9Z60zDZNWf7gp5sSQRdncFf4pzS6kr
         SAIg==
X-Gm-Message-State: AOJu0Ywkrj7eQcfjaXrHUB4Ck+IHRETRoRwJJWAnpuYlvp3apBI7nYOw
	Zmm+4PaB87wprWe9gky1KJkQKoXtSj9ck4yVvPnd8/Nbl0ay6VhdWxdjOJE94g==
X-Gm-Gg: AeBDieumF3QKiaFaDnLG4loERCGklvJeiaD9nXyG99FL3nZ6qXF3FUZPmQqHWG8IokL
	KMhjRVV08EHMj2ReDfsxqDGJLY55oZ9tvPPwp5knhuMAQ8jOn00UwiltXz8H8Y4Re00OvsaqeML
	iwKgM31zDqIWaESaBdr/+bBgW+sri9INUNUpkRMaY2yojtQHvj1EetjoFGzes6W7WRbJ0sLTsxh
	jQNBrchZDSeuad0Xvn36lsKt3bHlI6nXtPda4MG2pLNk8jveppY9JYuffKNziFWaNGjrfeLDCiT
	daOm5NcC6zZK+6lMXAuxtkZfzJ9U3xogZzQMTeo+UKNxq3di35Tx4dOXAD+1sSUalel1GMUYvqL
	Q24hAiaTC5wAOXTFUF3gXDrQRCP3f7IZZxTzf60PcwYMSoG8CHHbWYmDXsyfETyKqA0NJ5WYCN0
	HRBEma62zs67IYYIP+uyXd9ef+F7VXNzYUOMfh5g==
X-Received: by 2002:a05:620a:284a:b0:8cd:9231:8b54 with SMTP id af79cd13be357-8e792852ae7mr680776685a.62.1776465911733;
        Fri, 17 Apr 2026 15:45:11 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d92ce037sm205562985a.32.2026.04.17.15.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:45:11 -0700 (PDT)
Message-Id: <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>
In-Reply-To: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Apr 2026 22:45:10 +0000
Subject: [PATCH v2] diff: fix out-of-bounds reads and NULL deref in diffstat
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

By default, fill_print_name() will C-quotes filenames which escapes
control characters and invalid bytes to printable text.  That avoids
this bug from being triggered; however, with core.quotePath=false,
raw bytes can reach this code.

Add tests exercising both failure modes with core.quotePath=false and
a narrow --stat-name-width to force truncation: one with a bare 0xC0
byte (invalid UTF-8 lead byte, triggers NULL deref) and one with a
0x01 byte (control character, causes the loop to read past the end
of the string).

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
    
    Changes since v1:
    
     * Simplified the loop to almost what we had before via a wrapper
       function that always succeeds in advancing the string and never
       returns a negative width. (Which, as a consequence, treats invalid
       UTF-8 and control characters the roughly the same, unlike v1.)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2093%2Fnewren%2Ffix%2Fdiffstat-utf8-loop-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2093/newren/fix/diffstat-utf8-loop-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2093

Range-diff vs v1:

 1:  fcd44d6cf8 ! 1:  4a72647ce2 diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8 truncation
     @@ Commit message
          diff: fix out-of-bounds reads and NULL deref in diffstat UTF-8 truncation
      
          f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
     -    UTF-8 chars, 2024-10-27) introduced a loop in show_stats() that calls
     +    UTF-8 chars, 2026-01-16) introduced a loop in show_stats() that calls
          utf8_width() repeatedly to skip leading characters until the displayed
          width fits.  However, utf8_width() can return problematic values:
      
     @@ Commit message
          0x01 byte (control character, causes the loop to read past the end
          of the string).
      
     -    Fix the bug by:
     -      - Adding a *name check to terminate the loop at end-of-string
     -      - Detecting the NULL pointer from invalid UTF-8 and falling back to
     -        showing the full untruncated name
     -      - Breaking on negative width (control characters)
     +    Fix both issues by introducing utf8_ish_width(), a thin wrapper
     +    around utf8_width() that guarantees the pointer always advances and
     +    the returned width is never negative:
     +
     +      - On invalid UTF-8 it restores the pointer, advances by one byte,
     +        and returns width 1 (matching the strlen()-based fallback used
     +        by utf8_strwidth()).
     +      - On a control character it returns 0 (matching utf8_strnwidth()
     +        which skips them).
     +
     +    Also add a "&& *name" guard to the while-loop condition so it
     +    terminates at end-of-string even when utf8_strwidth()'s strlen()
     +    fallback causes name_len to exceed the sum of per-character widths.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diff.c ##
     +@@ diff.c: void print_stat_summary(FILE *fp, int files,
     + 	print_stat_summary_inserts_deletes(&o, files, insertions, deletions);
     + }
     + 
     ++/*
     ++ * Like utf8_width(), but guaranteed safe for use in loops that subtract
     ++ * per-character widths:
     ++ *
     ++ *   - utf8_width() sets *start to NULL on invalid UTF-8 and returns 0;
     ++ *     we restore the pointer and advance by one byte, returning width 1
     ++ *     (matching the strlen()-based fallback in utf8_strwidth()).
     ++ *
     ++ *   - utf8_width() returns -1 for control characters; we return 0
     ++ *     (matching utf8_strnwidth() which skips them).
     ++ */
     ++static int utf8_ish_width(const char **start)
     ++{
     ++	const char *old = *start;
     ++	int w = utf8_width(start, NULL);
     ++	if (!*start) {
     ++		*start = old + 1;
     ++		return 1;
     ++	}
     ++	return (w < 0) ? 0 : w;
     ++}
     ++
     + static void show_stats(struct diffstat_t *data, struct diff_options *options)
     + {
     + 	int i, len, add, del, adds = 0, dels = 0;
      @@ diff.c: static void show_stats(struct diffstat_t *data, struct diff_options *options)
       			if (len < 0)
       				len = 0;
       
      -			while (name_len > len)
      -				name_len -= utf8_width((const char**)&name, NULL);
     -+			while (name_len > len && *name) {
     -+				int w = utf8_width((const char **)&name, NULL);
     -+				if (!name) { /* Invalid UTF-8 */
     -+					name = file->print_name;
     -+					name_len = utf8_strwidth(name);
     -+					break;
     -+				}
     -+				if (w < 0)  /* control character */
     -+					break;
     -+				name_len -= w;
     -+			}
     ++			while (name_len > len && *name)
     ++				name_len -= utf8_ish_width((const char**)&name);
       
       			slash = strchr(name, '/');
       			if (slash)


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
