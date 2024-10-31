Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBD194C65
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367602; cv=none; b=SevRJ8JETXASrbGtJP/7fmksZrimroLThE3FZbE6YMAWvXDj7Y2DdcDRi07lDGRiK6rKmcWkHw2gosJW3KFnTyinNEEoCwlXsqmLW+4ylQ7XSATtpUAF+HLUXAEx99OZdKNjOMrw6oaT3dXwVTkggPN4i2VkEqXa8+XrOASkABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367602; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2YBUG4xTVavK52gYDgWDi7IciJwLPsAcE2qzsfX97UXyuivi+4q9otvjM5ZD309bzm39tJFxEinKMCXVkMP59HDhna9wIkoeUSyiyPlhJM2gu2y4GmcOBzF09hob9067aHjyZCZm71lWg7YjsxNE4GWA6d5bycNH0bfRP2Kyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8fHbO3X; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8fHbO3X"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso9749761fa.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367598; x=1730972398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=W8fHbO3Xunr42msphVKyI0PaCBycebx0i6DspJ5Lelr49punkFR4a5CULX7tgHEz66
         fN/NvbLCQFGM+AIui4LF6M6pJdkok0wdXuXhH1/JZLo/q/hmDeZmJq+St6w3IkVl3R3j
         WOxVBQaulm2fR7zaJ/c66AJ8aQALTmU5EqryYJu+7+r4PYx0EtntWsiHhbiDqJFfcOXF
         93iriTVov42fA++9Cemu3H8o5UWeS6mpDq4JErKCIVdqpFsSlKWtW5kiWo9KHkYfoh1R
         rkLMr0kCUHFCToSJJ9L5nC/A9LuYQEzglccDVEC3iwD/B0BAxKD7s6RmbNJFAbacfX/i
         hEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367598; x=1730972398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=DrAZm0FWXoZTXmOiGhrcgIpVU1HfWx+OI8EpBWyqSgpAwirQxagzFMSMtmCj9S7Uya
         adljyJta8EX6PZUB5R3xMg2FgkKE5PBWqdxIlVy+JrUb92SdFVYQwpE35ogjyWgE9PV/
         TzRBeXMsSU4BlG6Qm24ofnLnom6Ca+XtCrVSq7o3jP0wWsZ7WVN8pX1q4ibTD20jd24x
         0wlhjOMgwb7JdOtPArW88s/51fY0M9Y/ASrxuwdA04a7/Jyw2gAp8jjB46sMZHairwnW
         uYGcXFabMfsNU0Es29IMG7ALSZRAJfRdvwy+LDUp4HcTwyDWMxaQKGJvkL5VSgAPxYgO
         tUgQ==
X-Gm-Message-State: AOJu0YxFw3gnpnBs0mKBrr2FBD1bydlnhquoGir1mltOaTC4m171U+ps
	NwqaOrk/Sj+TPcOYDJ4vyQNxNup5qmpx9FAYmd5Nm2m92/XUg/Rfdw7MT2v/
X-Google-Smtp-Source: AGHT+IGtAqzR9XXr9heL2/hm1hEGEbAPZf4/Zj1Gme0DnVSBNILdheeHv9LfntvfpMtDmmbB6ZW41w==
X-Received: by 2002:a2e:be1a:0:b0:2fb:5ae7:24e7 with SMTP id 38308e7fff4ca-2fcbdf60ea6mr141251171fa.4.1730367597668;
        Thu, 31 Oct 2024 02:39:57 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm46399566b.26.2024.10.31.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:39:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v4 3/9] packfile: pass `repository` to static function in the file
Date: Thu, 31 Oct 2024 10:39:46 +0100
Message-ID: <d5df50fa36ab50eeac9c08a9b16b18a7e7e30ed6.1730366765.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730366765.git.karthik.188@gmail.com>
References: <cover.1730366765.git.karthik.188@gmail.com>
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

