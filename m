Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6641F4730
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298765; cv=none; b=uQjMPr4plOAZHRdxBg1iYXPGJAwcId0BO+xejt/sUhK9eZ8yiI0rXYiHNSHmEvHEeXKqt9Vvhr+QbIIUgtvbQ1eam/XJkF695EoqS0u+Nzta3nTFTF1ZT39wTeSf0YuVJQy5kF6y29umMY0jNvyHIZYcfeaP8G64zT5WkV2CzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298765; c=relaxed/simple;
	bh=BPWkLmM2QrO1mAtsCMr1jSHfrWjQ1vzlis2YZdgxDkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD5htDYXdvFfUA/ZSqqsTNeZ4hHAIvG0rer9ptLocHDD+emF3F6bMoxryz6Cfd/I7pwEQI5yN8bSBJ5q0p8fD7pUqKw1dfeeDolsFroDvYSZcgZIWkTVWNpOvATgiMkO/yydxltRAeQ3k72dPsBcaFA6ZLJGzTx004s9UmyzzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKW/L7gd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKW/L7gd"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso9335303a12.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298761; x=1730903561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CZQn+f8zJGdaEM65n6SkeilylzJyfph2HKL+7REKHc=;
        b=iKW/L7gdbsa6eMh7k43HFeZorSzGuCXucppIw1GJ6/KQTvq0ticie3333nWMu0Cja5
         ttHJbiXJkxU3GT3Npv1SK4hNQSEVmpQpuY62qPtByClQv7ILJyB8RSTUotUMjXAHY+P6
         sSLbB1xdr+wCsoJOarcUI2jRiNSWtZFZeVabshQEzjudOndk2pAnj2FCs+m7JAL2/+Gf
         vBkcN7CkZT9G1tIVbLq8g47ut8hTNvoxsuVJLsXsCqWkS72Fe7sLqqo6KZ9HEaT4T32d
         de7+dMAVW40rcHuWKnunqPCzgQ/c3Q1ugE277qlRiUcHSC3GszlFv+yRyeEhp2C+LOp/
         mE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298761; x=1730903561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CZQn+f8zJGdaEM65n6SkeilylzJyfph2HKL+7REKHc=;
        b=fkM2Qu3biTIifJAzoSwxOzvgO43h46ZUNnpz6acdrVpcYFNH+Cg2jTNeDDtpjm5iG6
         sIAmMoaJCL6TKWm/yn1dtjYGdIW0hCVv2ms/MSXqM4gPe6qvpBhX58hUaAEFjG70xoRz
         KHqlcwyZPUhWcpv75DuAD1xPr/yf0VXgKmMQkKihlekvnLC8xQ/awEjZjbWpZGEu96Xx
         OBCcWFn3PY5YHL7bfh/ysIoYZPRXQYh663uue5XnWOx3Navd0w2PaBMco2WjioOYGLzv
         IYDIl6x1pwKH7EfTHNNHEqUheXEUJFa5LUBdSwwV1/fnxhKm4PKsQw+vy4oBKEmGzB7T
         RqBQ==
X-Gm-Message-State: AOJu0Yz0AtKypzDY+xdsdAoxh5jplIfZficXPMAVNnjUmNSfVYTFSfe4
	ilj3Aj41+VWvxfz4L4nIPnLEYTbWvlIZACxXSyUQsbpPoHNYOToVy//ihm2S
X-Google-Smtp-Source: AGHT+IEiWpX+wgZJHlXlnN4f3L/06NH2oIwZSEGL9HttZqxnFmb8aD2EAI6CF1erlQFEt7Al712TJg==
X-Received: by 2002:a17:906:6a12:b0:a99:f746:385 with SMTP id a640c23a62f3a-a9e3a573d11mr408690566b.1.1730298760931;
        Wed, 30 Oct 2024 07:32:40 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 3/9] packfile: pass `repository` to static function in the file
Date: Wed, 30 Oct 2024 15:32:28 +0100
Message-ID: <5b975cb6d6ad760d70c9e9649c30978f2952bff9.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
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
index ecb284fd98..a391474031 100644
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
+	while (pack_max_fds <= pack_open_fds && close_one_pack(p->r))
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
+	if (!win || !in_window(p->r, win, offset)) {
 		if (win)
 			win->inuse_cnt--;
 		for (win = p->windows; win; win = win->next) {
-			if (in_window(win, offset))
+			if (in_window(p->r, win, offset))
 				break;
 		}
 		if (!win) {
-- 
2.47.0

