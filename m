Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63AD18870C
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323658; cv=none; b=A6QDkoTihbU7Wpvh7cOWcTW1OhbEeSLC4PRRUyfNfgjZXXZ78Cf6w94VZ7taEPqfX2vlrwh1lSbtrYs7/Y1Su2gv++Fg6+Nl1TpV4O6mMVBE68lm/AbRLPXIaWQ8SNL9HK5zzxa6xPcfxrGnYgczxOS5cy/9ypeFbYEj6a/Fch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323658; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spF/umF1JvK8ZUQKMSymG+QItYdJzqrvkWOiLYGOcvGq9knZi/Ml/mo225QZGir1IIPkeGHZqP8mGjQQHqiShiZqcfKAJxBWR6LeiuynDgzSI7Zc7ez/BrxJxLBbDf5p3SYkWFhukWDQo9Fb75HtMuU3vAPSQ17I/bPHD1uRuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a152eTWm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a152eTWm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99fa009adcso301474766b.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731323655; x=1731928455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=a152eTWmvW0LpenZ4KsW1QvYdhu51sgBkGPMO0Oukf1A9c2YzuirNsYKYNRlU5hiYo
         vVz5LtqBQuoiaNh/A1FSfINnwuhfG0ozt7bnM8bQos9++FYGvHcoKmWzkxIJjSkZku4s
         RAyeKjTuAagDuRaaGB9IDnNrcythY7D45sONyX561EjRpIp/thwB7asqOxZAJ8NoBnEq
         +h7utOs6OEhzgkSgE5qvsnmC3EjW69KOk6S1cAtZm/zyNlcGfAJEczgog8HAjK+fiPRB
         A9PyK1fZSb8Ex77IcYvuMqd+pmnOM/kvsbePPeoUHGsgrITLcGAj83aKKMG0UxVQA4VF
         vp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323655; x=1731928455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=GG5flRi77vfroFyJbGR5u0wzGoVe00gicoT1yHlq9Ta5+NVh525zc1SvXMgA43+ObW
         g+Uvx7fJC6fKtMO1//9LSATIexJim6a6oY7qXrfuDAhSnA+Ho7taehsI5rlVbECmzx5D
         JAaD2XgR0ffovmtrP44fHnnueWIMCewERnV8XoSS3aGqLYOsthY+aPwidQ3SEi0br2/8
         r5AWNhEoRl/iyVVlHlI9AUZnR5BhxzkAxXIaNIGAmBEviQhRmgmNDDB11fTYxJU/ERYq
         Biahz2TGbq2OjOFRvFcxbsPRBK9dWlUcO0XDSt1yEJhtho7f80d4QRJCfser6YLaKWTB
         9q4Q==
X-Gm-Message-State: AOJu0YzX8mnB6/W1zG1Baio0HP0YoCpgjDORdGetuYpr5/Vt+A2XYBMV
	lpACwJRjzl9mjLD2xB5o8komgxDaA6kE1Bvc4vmNHiVq6rhevvk1
X-Google-Smtp-Source: AGHT+IH/5WUoZ7wQJVfgFG5cKFPJNhVpr/u1RusW3K8KbmpNd8i5WQhj4c+9CHvIFutYUYstzTdLAg==
X-Received: by 2002:a05:6402:354b:b0:5ca:8b9:6e06 with SMTP id 4fb4d7f45d1cf-5cf0a311112mr16542812a12.12.1731323654578;
        Mon, 11 Nov 2024 03:14:14 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c625sm5012959a12.82.2024.11.11.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:14:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v7 3/9] packfile: pass `repository` to static function in the file
Date: Mon, 11 Nov 2024 12:14:03 +0100
Message-ID: <167a1f3a111958df7e1841aeae37addcdf04c411.1731323350.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731323350.git.karthik.188@gmail.com>
References: <cover.1731323350.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the static functions in the `packfile.c` access global
variables, which can simply be avoiding by passing the `repository`
struct down to them. Let's do that.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5bfa1e17c2..c96ebc4c69 100644
--- a/packfile.c
+++ b/packfile.c
@@ -460,13 +460,13 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	*accept_windows_inuse = has_windows_inuse;
 }
 
-static int close_one_pack(void)
+static int close_one_pack(struct repository *r)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next) {
+	for (p = r->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -555,7 +555,7 @@ static int open_packed_git_1(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && close_one_pack())
+	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
@@ -610,7 +610,8 @@ static int open_packed_git(struct packed_git *p)
 	return -1;
 }
 
-static int in_window(struct pack_window *win, off_t offset)
+static int in_window(struct repository *r, struct pack_window *win,
+		     off_t offset)
 {
 	/* We must promise at least one full hash after the
 	 * offset is available from this window, otherwise the offset
@@ -620,7 +621,7 @@ static int in_window(struct pack_window *win, off_t offset)
 	 */
 	off_t win_off = win->offset;
 	return win_off <= offset
-		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
+		&& (offset + r->hash_algo->rawsz) <= (win_off + win->len);
 }
 
 unsigned char *use_pack(struct packed_git *p,
@@ -642,11 +643,11 @@ unsigned char *use_pack(struct packed_git *p,
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
 
-	if (!win || !in_window(win, offset)) {
+	if (!win || !in_window(p->repo, win, offset)) {
 		if (win)
 			win->inuse_cnt--;
 		for (win = p->windows; win; win = win->next) {
-			if (in_window(win, offset))
+			if (in_window(p->repo, win, offset))
 				break;
 		}
 		if (!win) {
-- 
2.47.0

