Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DBDDB8
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312625; cv=none; b=pu96uv4y9uMRTTGJS6khj9PXCTVOPrxDiuPgvoe+WPrFKJtBqg63aqcecDob/c2CgxsqksT01TfJDxGQblWuoz8XZ/AHivXx5DCjGkh7dfXTrGflKUpwBihsdxD3YZTaI2KANSG3wNkPXkHhb79KYkiYJ81ojcaBHUmsZoGr7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312625; c=relaxed/simple;
	bh=8RluXRvJvVKrpAJtrYu3yqto2gJ7Fw/0T7ZYG4sScDY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tcVOpzjrIHuw+vDyvjKamkZ2cufVSCSFvq/snBmaKUyHwMAD75bhp02uKuIdWwesps0cEjV1AR+vYRsFaEm6j57SDXvVwOKnhZTfnj28Hbj4649mFxNNNGL0bKMR+ntO1qjCgheZHRxLFiLT9LuCWrJlHYNVSg0WlmL9vPVr3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THk5Elhr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THk5Elhr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso3243725e9.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721312622; x=1721917422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Seb7lwjo9FL9xaKfRnbnLM/i9+bn4wtXSIFZClUBBQ0=;
        b=THk5Elhrv1LXPvxh/F9PaeqBWoLFbweqiBaU4EoXxi1gjQeoyIa8BAfaLPwo3z+KDu
         ounGsgtih88eDj4xOeSy/wjfDpIotsyQIitr6uW25kCpMAlzeZVL2jHspPGkY1EscNe0
         hW3yNtutjp8/IO75xym3ewzjuXfD2Z8dAzpvMBXa6F9cGgaqVksQfS+HfejwxNCPqw/W
         Dcr4OiU+YpflD6pBvoPMAhwsDGX8jMY0GxL+2tPHellTdqgOR6zoQsZThTqYpUKo7WHP
         xr3Vyo5KGcC4cwH/sQPkFE1bpZATu82ikBWajHx5fSxnPdnFHLmoKOWIEJNsaw1XmFY4
         nGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312622; x=1721917422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Seb7lwjo9FL9xaKfRnbnLM/i9+bn4wtXSIFZClUBBQ0=;
        b=edvgOm7OQN/CDQOrPL0wyDIO8BcOe9WAMMiQreyN+oxbzF2Iydgsdkizrh1Xpm8AUp
         Ris8l0ZWibWALA04ij0biWgcX+qqHrsNV9KJfEggFikw0bdwfCtpB8TciDYRW8y4n9xJ
         JEa7up16JwAhpVcIYpC/D6JdGspj8MNgV3Q3OiFdgA0ssdxSdzeVfV+OLVi5fxk8YrXy
         5TlcHp9nlw/XUeTHDFzf7WGtEf3+jJGIkwnrLPS9LhvAJ2ECJK9aV6gokKQ4/lte6ueA
         Dq+VLo3lXaD1EbBm1LJYU+rud0MDnZrtzKuOmTgjcn/93V6zFU4lp9ZwSP9hiduTijJz
         H22A==
X-Gm-Message-State: AOJu0YzWyAWfXYoXF3PCpJew6TJKDqaSG9i/eyhbgMgjdDN05KdLY5O6
	ET72tV8aDErSZA33OroiGH7US7XTe14tGHjxiNvaVkLD9JdEwk+l0POxJg==
X-Google-Smtp-Source: AGHT+IGiY3+1HBh+mpQG+vg8h+GGooO63U6yIuVjO3JViQ3siNI4VTOU6MZ2FGuNuUl6OOCSL7hldg==
X-Received: by 2002:a05:600c:1987:b0:426:5b3a:96c with SMTP id 5b1f17b1804b1-427c2cfc334mr35595855e9.28.1721312621284;
        Thu, 18 Jul 2024 07:23:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d3e7156bsm4938165e9.17.2024.07.18.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:23:40 -0700 (PDT)
Message-Id: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 14:23:39 +0000
Subject: [PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
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
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "add -p" parses diffs, it looks for context lines starting with a
single space. But when diff.suppressBlankEmpty is in effect, an empty
context line will omit the space, giving us a true empty line. This
confuses the parser, which is unable to split based on such a line.

It's tempting to say that we should just make sure that we generate a
diff without that option.  However, although we do not parse hunks that
the user has manually edited with parse_diff() we do allow the user
to split such hunks. As POSIX calls the decision of whether to print the
space here "implementation-defined" we need to handle edited hunks where
empty context lines omit the space.

So let's handle both cases: a context line either starts with a space or
consists of a totally empty line by normalizing the first character to a
space when we parse them. Normalizing the first character rather than
changing the code to check for a space or newline will hopefully future
proof against introducing similar bugs if the code is changed.

Reported-by: Ilya Tumaykin <itumaykin@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    add-patch: handle splitting hunks with diff.suppressBlankEmpty
    
    This is an alternative to jk/add-patch-with-suppress-blank-empty which
    was recently discarded from next. I hope that normalizing the context
    marker will simplify any future changes to the code.
    
    While I was writing this I realized that we should be recalculating
    hunk->splittable_into when we re-count the hunk header of it is edited
    but I've left to for a future series.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1763%2Fphillipwood%2Fadd-p-suppress-blank-empty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1763/phillipwood/add-p-suppress-blank-empty-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1763

 add-patch.c                | 17 ++++++++++++-----
 t/t3701-add-interactive.sh | 11 +++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index d8ea05ff108..13b2607f544 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -400,6 +400,12 @@ static void complete_file(char marker, struct hunk *hunk)
 		hunk->splittable_into++;
 }
 
+/* Empty context lines may omit the leading ' ' */
+static int normalize_marker(char *p)
+{
+	return p[0] == '\n' || (p[0] == '\r' && p[1] == '\n') ? ' ' : p[0];
+}
+
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
@@ -485,6 +491,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
 		const char *deleted = NULL, *mode_change = NULL;
+		char ch = normalize_marker(p);
 
 		if (!eol)
 			eol = pend;
@@ -532,7 +539,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			 * Start counting into how many hunks this one can be
 			 * split
 			 */
-			marker = *p;
+			marker = ch;
 		} else if (hunk == &file_diff->head &&
 			   starts_with(p, "new file")) {
 			file_diff->added = 1;
@@ -586,10 +593,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);
 
-		if ((marker == '-' || marker == '+') && *p == ' ')
+		if ((marker == '-' || marker == '+') && ch == ' ')
 			hunk->splittable_into++;
-		if (marker && *p != '\\')
-			marker = *p;
+		if (marker && ch != '\\')
+			marker = ch;
 
 		p = eol == pend ? pend : eol + 1;
 		hunk->end = p - plain->buf;
@@ -953,7 +960,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 	context_line_count = 0;
 
 	while (splittable_into > 1) {
-		ch = s->plain.buf[current];
+		ch = normalize_marker(s->plain.buf + current);
 
 		if (!ch)
 			BUG("buffer overrun while splitting hunks");
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac16..351dd2b4332 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1164,4 +1164,15 @@ test_expect_success 'reset -p with unmerged files' '
 	test_must_be_empty staged
 '
 
+test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
+	test_config diff.suppressBlankEmpty true &&
+	test_write_lines a b c "" d e f >file &&
+	git add file &&
+	test_write_lines p q r "" s t u >file &&
+	test_write_lines s n y q | git add -p &&
+	git cat-file blob :file >actual &&
+	test_write_lines a b c "" s t u >expect &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 790a17fb19d6eadd16c52e5d284a5c6921744766
-- 
gitgitgadget
