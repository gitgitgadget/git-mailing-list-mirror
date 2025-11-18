Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65030F93A
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482075; cv=none; b=YFjUO5K6lv0qTPRkN9VJaaEFl/9NJcsjFcclSbqaU5ImND2nP6cUiqNuJQAP+JB+XbDoNEhlL9jYOSlh+ofCnQRk9E9m1PpgKiQ+uVNZ5V3kDBMyjXsj8Ihas94dUBHgzjgjSRfV3NvhTooDrlwvvLMCnVYEJsZY/MPYsZPyhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482075; c=relaxed/simple;
	bh=TaFuIl1tKeyxBx/rNa8Bima9VNephL6a/zrQOs3xIPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ox6WfwtRscdklS3UVmKaA8D8y+Yfw/XPimPEmWD2CUbJm9F2fekW10zV29t21puWbYv3WBZYfRNa4kDB9BgEf12iufpIQ25aM3E/SgU6JVRjjI1AsfmrexjhogC3zsXGxL5O4cWKNnnqHMxtXvO3TxinH1D7/QJQNyLJTrsrJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2cRL/1W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2cRL/1W"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso22205485e9.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763482071; x=1764086871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzaffOVHws66ufM4Y2fm5k7LpmxehYw+WbrbBh+TC9c=;
        b=Z2cRL/1WmT3nzV7bgSq3+9Z0+DibTB4HPfzbLgTML5aAAE+n4P0n/Iknst6bqgan1x
         KVP0UKsqA7no7rcxqUWbeCpWn19JJ2flByLSL2ry7OqddAIC4lCB4SASw9AH0X+SWGyv
         A8WkPtPOUL2Boho6SNSn97/cgjvOET9SiSRA4AJCzHQIjBboS0ugNzYRFK9ODnd7+5SG
         RKq/IBd+r0lqv/rPEvRdxzwqazLARmJlyZSri3DqPnJgDybDhFWLcantSOopTSs4+3xe
         cGVrJbHKyMDcm7MzqT7SP+k7eE+re5pwCEvNnSGIt+H2xcy2Gz5xYCpBLIhH+PyRDTgN
         YDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482071; x=1764086871;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzaffOVHws66ufM4Y2fm5k7LpmxehYw+WbrbBh+TC9c=;
        b=MCgZt25yqKBBhkkiRos0M9Hdny19IpUE6svK2TKTV61mQZzSK4QjVq0Ids0+xdEFYe
         BUJMuCALNnFqZzLH3njwKALwtRDOeyzYYxMlrVzMijxgGBKmSP17XSM9gLwzh8b4zW/x
         wGMGgqYg3w8lG/WLYVfhahlSv9JvJ0P0eZTpWbuTHajLbjFEPQ4sG1w/Plto/EEtSvhw
         bcoJ1+9J8dLbc0PIvxKtp38P46vje4hoPyXA3qMIFqEI6/3CpdU65ErmsxcXiebi52FO
         z7shQFdwHPnlibXLiYlRWWMCh5O/wDH8Rp32742RyY8tLhzOI600jt36J5BHvd4VdLWr
         +T/Q==
X-Gm-Message-State: AOJu0YzNtEXoMTtD6WZawcrAAn229OIPoxQI2SirChRURXfj74W874Cv
	1aqho86uYP+Z6mDOr4tfpXgIhc4AUgPphBE26LyhfE0rkSdGVzwe3D/d7yOrsg==
X-Gm-Gg: ASbGncvEFafYrR7PtQfOQ8uLJWE8NqZ37rmLum7kn34EeqiOJzfKyPbbZTxhcaJhrYU
	1pplQJp3OIFrSTLPQbn9YH6KC6CPHRr4IzMu5urY8m5beFnYCOZB1fv9x92UkupBKVGre1ZCKiX
	P1qYBV0ZhhLqdQHs+2piLR29JvT8bVWMGdQ6M/wrVk/vEpD36VVhKvikn/eqlEZtulMw0DloZsR
	9k3IXq56AmnBTCCFY54C7zYZWwgQ/nOSk+/qRz43UD816ftsKb3Hf+BCzSRFuFD6ZR88NN6+MlL
	wvemPVmB/VQWLMQNyxKIh7QIccyfGzvT2V+wsGZ01NGC+ndGo7MpiYK7dwSWsKK/zHX7EkIfzg/
	aKmUQJRGWxnLdB7gaNAxeHMmK8mf4t7TQVfy/O2qeIS1DC3/Hz6neC4MMh6UZf2/DDV/oI8xife
	kYEQ2WbJUBVoAobRAe49wwn+V+
X-Google-Smtp-Source: AGHT+IHM2NosW+RLiHYgZY/DCkGEQaO38KAk2KKJFNpF1+IHGOkTy218Wf1Dxx9VVG36vsxVIF0P+w==
X-Received: by 2002:a05:600c:a05:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4778fe55465mr144724725e9.1.1763482071074;
        Tue, 18 Nov 2025 08:07:51 -0800 (PST)
Received: from berwick ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97412e3sm20850665e9.5.2025.11.18.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:07:50 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] worktree list: fix column spacing
Date: Tue, 18 Nov 2025 16:07:32 +0000
Message-ID: <9417c73b3c4b89ed7c4cb823f3f68e994a968021.1763482051.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.345.g9c3c96ee5a7
In-Reply-To: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The output of "git worktree list" displays a table containing the
worktree path, HEAD OID and branch name for each worktree. The code
aligns the columns by measuring the visual width of the worktree path
when it is printed. Unfortunately it fails to use the visual width
when calculating the width of the column so, if any of the paths
contain a multibyte character, we can end up with excess padding
between columns. The simplest fix would be to replace strlen() with
utf8_strwidth() in measure_widths(). However that leaves us measuring
the visual width twice and the byte length once. By caching the visual
width and printing the padding separately to the worktree path, we only
need to calculate the visual width once and do not need the byte length
at all. The visual widths are stored in an arrays of structs rather
than an array of ints as the next commit will add more struct members.

Even if there are no multibyte characters in any of the paths we still
print an extra space between the path and the object id as the field
width is calculated as one plus the length of the path and we print an
explicit space as well. This is fixed by not printing the extra space.

The tests are updated to include multibyte characters in one of the
worktree paths and to check the spacing of the columns.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/worktree.c       | 35 +++++++++++++++++++++++------------
 t/t2402-worktree-list.sh | 22 ++++++++++------------
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 812774a5ca9..0643a22ee58 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -979,14 +979,17 @@ static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 	fputc(line_terminator, stdout);
 }
 
-static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
+struct worktree_display {
+	int width;
+};
+
+static void show_worktree(struct worktree *wt, struct worktree_display *display,
+			  int path_maxwidth, int abbrev_len)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int cur_path_len = strlen(wt->path);
-	int path_adj = cur_path_len - utf8_strwidth(wt->path);
 	const char *reason;
 
-	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
+	strbuf_addf(&sb, "%s%*s", wt->path, 1 + path_maxwidth - display->width, "");
 	if (wt->is_bare)
 		strbuf_addstr(&sb, "(bare)");
 	else {
@@ -1020,20 +1023,24 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	strbuf_release(&sb);
 }
 
-static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
+static void measure_widths(struct worktree **wt, int *abbrev,
+			   struct worktree_display **d, int *maxwidth)
 {
-	int i;
+	int i, display_alloc = 0;
+	struct worktree_display *display = NULL;
 
 	for (i = 0; wt[i]; i++) {
 		int sha1_len;
-		int path_len = strlen(wt[i]->path);
+		ALLOC_GROW(display, i + 1, display_alloc);
+		display[i].width = utf8_strwidth(wt[i]->path);
 
-		if (path_len > *maxlen)
-			*maxlen = path_len;
+		if (display[i].width > *maxwidth)
+			*maxwidth = display[i].width;
 		sha1_len = strlen(repo_find_unique_abbrev(the_repository, &wt[i]->head_oid, *abbrev));
 		if (sha1_len > *abbrev)
 			*abbrev = sha1_len;
 	}
+	*d = display;
 }
 
 static int pathcmp(const void *a_, const void *b_)
@@ -1079,21 +1086,25 @@ static int list(int ac, const char **av, const char *prefix,
 		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
 	else {
 		struct worktree **worktrees = get_worktrees();
-		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
+		int path_maxwidth = 0, abbrev = DEFAULT_ABBREV, i;
+		struct worktree_display *display = NULL;
 
 		/* sort worktrees by path but keep main worktree at top */
 		pathsort(worktrees + 1);
 
 		if (!porcelain)
-			measure_widths(worktrees, &abbrev, &path_maxlen);
+			measure_widths(worktrees, &abbrev,
+				       &display, &path_maxwidth);
 
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
 				show_worktree_porcelain(worktrees[i],
 							line_terminator);
 			else
-				show_worktree(worktrees[i], path_maxlen, abbrev);
+				show_worktree(worktrees[i],
+					      &display[i], path_maxwidth, abbrev);
 		}
+		free(display);
 		free_worktrees(worktrees);
 	}
 	return 0;
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 8ef1cad7f29..a494df6d612 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -30,22 +30,20 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
 '
 
 test_expect_success '"list" all worktrees from main' '
-	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
-	git worktree add --detach here main &&
-	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list >out &&
-	sed "s/  */ /g" <out >actual &&
+	echo "$(git rev-parse --show-toplevel)      $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf áááá out actual expect && git worktree prune" &&
+	git worktree add --detach áááá main &&
+	echo "$(git -C áááá rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git worktree list >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '"list" all worktrees from linked' '
-	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
-	git worktree add --detach here main &&
-	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list >out &&
-	sed "s/  */ /g" <out >actual &&
+	echo "$(git rev-parse --show-toplevel)      $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf áááá out actual expect && git worktree prune" &&
+	git worktree add --detach áááá main &&
+	echo "$(git -C áááá rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git -C áááá worktree list >actual &&
 	test_cmp expect actual
 '
 
-- 
2.52.0.345.g9c3c96ee5a7

