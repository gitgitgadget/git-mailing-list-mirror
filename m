Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEE3587A1
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482076; cv=none; b=aXrcoV2rNZQWTXwREt+RGkBw3fxaPyqQgdznVXsLOHHMw2/5vU6W6Tze9lHAyMvNO5lQGNol8z3BhlHqn6Omw00kBlL/dnJvFRrwpzMv75TufPjr1/BpyRjJsbNeJrfpliOClmAeZwqfFhB+NCtel0yQ89QAaOKSMdwnP7dytts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482076; c=relaxed/simple;
	bh=Fba8nhcQwZQMMXqbLrNUqupHWDmBGzgRuTE/zVBNyVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4Uj582Xzurh0m1W/Vk0QkzAuqyZAAlL8Jqg9kLFTF7janPRfo6hwFT5zguW8/RaekcQXP7UIGzJ+1FL9QRFJkOYQcbBkBUvR9+kRssBoxy2EHYskoxqCjtw8ytjDYDF3WS7C2lLYCfNf6ug+VfE1zZxOM4ADi6fSeDod1hyGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mgg2cbQM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgg2cbQM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47796a837c7so21966015e9.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763482072; x=1764086872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXqmxN8EImGwRvWqRdbcmv8cHqKr9jea096wUfMjprc=;
        b=Mgg2cbQMiDj7eWQZyeERN3ncmXoIH7snXqcLtsL9l3FRSRnVVLzoeuYuHssyjobpN3
         VOl4sB/U6ch/y7RLbpXkFjV/+p27Vn/Lhs7Zv3mYU8Q+YAmTmm+UWJ/NLq/kKDPCICg5
         NHY6K3uh6vxPIM17SOXSWCJJ7am1FSPakY4m1YSCFI9Azqo4x/2SDPfUBEZM8FoVFQ0K
         nMR462W/wy5Bamir+2Mdf/Svneuul1Zuyz3CsPVUQZVN7aYfG7/kcLiT3KNBw7Ul8SUl
         6TuL58PwayKtsOJOZ/10Yv3c/T+xHgZn3R4raELuxkoo3qMwRUoqJUPtjbx7sMvai1W6
         YkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482072; x=1764086872;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXqmxN8EImGwRvWqRdbcmv8cHqKr9jea096wUfMjprc=;
        b=Y7ZjL275C0owORxdiTqk+25rIwz8f9mIIYG3qoe8mx0Ql1j3nksnjLwpO4byEMOfoP
         96h617JSzigecCnnl9UIc7yoHrKYM+votqGSbSTvB/2staYQHXCM4pZS2UEgBugOpm/i
         0UUboXdlIqiVUkBX2U/vjJ0/DV1kAK11TLeMSJ5M/nbpOdI3rMaXpsGRg+2hHJQ7/Za/
         0HDXpvp5s/e5vo5ICJg9FIfXvvHiW4kVCLbdhUtbwASZY7SLgWqCDFtipbYZ6/KnyL2e
         mp2SKzrcuk1jl6KD+iCL94+rTTsENN/R4HIS3gPYE2iuHHa4YMSZbAPwofacVZA1Uw8n
         wdkw==
X-Gm-Message-State: AOJu0YwAraWRLkjr/b12iDKCOCtD52GgN1ZYpvDDeaUXLDtI/TySIHzA
	HlYba4NG9qKEjQyZNkdU9t0J+e6TwhVl4a/7G41hsej4Yyr4DGqbxqJAnHK5mg==
X-Gm-Gg: ASbGncu6mCjumJzfagIg14NyZfXULA99Gn13WdEsLTMohBuIRKTNYk4rXsgyto730uu
	FNCooTVmwfjvrkOjKLVhRqt2SgdZvrbLUVlsSBLVcLMMe2iulv6wmWOZdMq4rN/MdY+FGMrkkZV
	idsl6jqxoP2GY/To4PTcKMinNNN1woEfjNIh3oNgW4aMgzLsTFNlgCAjrDjET3m92x529rE7KqI
	NykLd8hiR9p/FlPFCXr/jr2kgfgp9tDejfFjiglO8PxcWch3wMT3S+ZC+ErzdOmkenpVXMwF7MT
	wdLdVdd0uxc5kDdDEsLclMVgnCRYT1V2oBNJBmpa2xpDMLnyL8z9dJctrk9nQOibex4omC1wlPT
	28ShUBTpM6JEmR0o6y1AnbArWJ8VvSfIIoAOjHS0CI6ffcvjnGJsIsP4hpugoXS55u3ypaKkTmy
	995mgozsGmim7LtA==
X-Google-Smtp-Source: AGHT+IE2+vq8WFtwzSGGPA12hmXooNXU1ZTYfoATYjA4luvB3BH5JOCzUSAWV0TPDf4aa5JGP9oz2w==
X-Received: by 2002:a05:600c:c4a2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4778fe6a3e1mr126650705e9.13.1763482072010;
        Tue, 18 Nov 2025 08:07:52 -0800 (PST)
Received: from berwick ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97412e3sm20850665e9.5.2025.11.18.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:07:51 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] worktree list: quote paths
Date: Tue, 18 Nov 2025 16:07:33 +0000
Message-ID: <b42d0f668b4a5ba0ec00fed1377cad5488f62197.1763482051.git.phillip.wood@dunelm.org.uk>
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

If a worktree path contains newlines or other control characters
it messes up the output of "git worktree list". Fix this by using
quote_path() to display the worktree path. The output of "git worktree
list" is designed for human consumption, scripts should be using the
"--porcelain" option so this change should not break them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/worktree.c       | 10 ++++++++--
 t/t2402-worktree-list.sh | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0643a22ee58..303cc3b2d64 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -980,6 +980,7 @@ static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 }
 
 struct worktree_display {
+	char *path;
 	int width;
 };
 
@@ -989,7 +990,7 @@ static void show_worktree(struct worktree *wt, struct worktree_display *display,
 	struct strbuf sb = STRBUF_INIT;
 	const char *reason;
 
-	strbuf_addf(&sb, "%s%*s", wt->path, 1 + path_maxwidth - display->width, "");
+	strbuf_addf(&sb, "%s%*s", display->path, 1 + path_maxwidth - display->width, "");
 	if (wt->is_bare)
 		strbuf_addstr(&sb, "(bare)");
 	else {
@@ -1028,11 +1029,14 @@ static void measure_widths(struct worktree **wt, int *abbrev,
 {
 	int i, display_alloc = 0;
 	struct worktree_display *display = NULL;
+	struct strbuf buf = STRBUF_INIT;
 
 	for (i = 0; wt[i]; i++) {
 		int sha1_len;
 		ALLOC_GROW(display, i + 1, display_alloc);
-		display[i].width = utf8_strwidth(wt[i]->path);
+		quote_path(wt[i]->path, NULL, &buf, 0);
+		display[i].width = utf8_strwidth(buf.buf);
+		display[i].path = strbuf_detach(&buf, NULL);
 
 		if (display[i].width > *maxwidth)
 			*maxwidth = display[i].width;
@@ -1104,6 +1108,8 @@ static int list(int ac, const char **av, const char *prefix,
 				show_worktree(worktrees[i],
 					      &display[i], path_maxwidth, abbrev);
 		}
+		for (i = 0; display && worktrees[i]; i++)
+			free(display[i].path);
 		free(display);
 		free_worktrees(worktrees);
 	}
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index a494df6d612..e0c6abd2f58 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -29,7 +29,8 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
 	test_cmp expect actual
 '
 
-test_expect_success '"list" all worktrees from main' '
+test_expect_success '"list" all worktrees from main core.quotepath=false' '
+	test_config core.quotepath false &&
 	echo "$(git rev-parse --show-toplevel)      $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf áááá out actual expect && git worktree prune" &&
 	git worktree add --detach áááá main &&
@@ -38,7 +39,19 @@ test_expect_success '"list" all worktrees from main' '
 	test_cmp expect actual
 '
 
+test_expect_success '"list" all worktrees from main core.quotepath=true' '
+	test_config core.quotepath true &&
+	echo "$(git rev-parse --show-toplevel)            $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf á out actual expect && git worktree prune" &&
+	git worktree add --detach á main &&
+	echo "\"$(git -C á rev-parse --show-toplevel)\" $(git rev-parse --short HEAD) (detached HEAD)" |
+		sed s/á/\\\\303\\\\241/g >>expect &&
+	git worktree list >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '"list" all worktrees from linked' '
+	test_config core.quotepath false &&
 	echo "$(git rev-parse --show-toplevel)      $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf áááá out actual expect && git worktree prune" &&
 	git worktree add --detach áááá main &&
-- 
2.52.0.345.g9c3c96ee5a7

