Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD11B218D
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720518; cv=none; b=Fn4/EVcwYbTGLdfu9GHejKBUE0cc7EvywlfubiTiRTZc03GWA6WqnmCge2/BHJLZNslG/zZbPCC9BN02CTNzRAaDumWxQGhDIbsAGO2Qasq4CJwgaRX8PeoVK1pEAC+o8vr7KNY5lxLgMRP8vBEGQ2oJrfBI5GmIgSIKRJV0qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720518; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqGuffim/Gst1WPq2BK3VIZYIT9jNpe6FxFVvOIhzZ7EKUBKigQzmb3TD/yqUd3Pga0KSdvHdViqrBwY8gYP4hSorfj0wMRraOQrrDZzX1/dpZaotFFogV60dX2OvDLp/TXMXicJGWyK6J4pPPnYJTahAFsXNFboow8nEb2vOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hShGwBoZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hShGwBoZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec7cde922so3144295a12.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720515; x=1731325315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=hShGwBoZCD4gs/hHqutakEISu75ioEfM5vvUZKf3xe2rH5ryNT/6/BXqPcy03yXTcB
         qtG90uM1IsECyQIyIIHDJY94wgtFEkxH7GZ87HlTzXfzE8y0Vnkz3csZwPIlR+YRtFTH
         lLwAsP2PbOkAoL0adeU9xpYxb9beWpoBoau01H7eISWpszSnR+otJREZjcayvTI3/G8Y
         WgP6N0uZ/sRgkR4kSsu6Nh5EuWTREwZEdWBCn9Y0uYjnMZSo7IerAHTijOHZYiCvQhX5
         zStokFMc1PANPe82BGuHXAEipcHpKEdNCQuts6+HL0sUgQ/mr/48TgchOV3FmThIHdMA
         5KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720515; x=1731325315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=FrnciJDsVp4cLBgnB483xtGUDBL/WS3Fqz6zBVyinEeyJHstfM188ockjGKIRafLWQ
         e2Im5MbN8oG5uzWI4zy+CI8MA+sedPEzZbktuMZTJCwI1RJGU2sD3qmF9yr8TdrhVqon
         AzbGmvQLSaKTELTjxTPDLeUHzL5ougMC3jimz43zi98xRICX3X6qbDDDUPMhnONbs0RC
         0SCJ2EtHjPoBCH+LXXLoS97Idj8BNub+IbElIvd6j0oqgTUJY4KfzoBa1vF3WOIF0GfT
         3AuPd6Qk3tLKaZytn75F7ggO5fGv8IQZn+nG3c/EXi5f4WOUGIO3t2rsmrs0Bfx9yATk
         IN0Q==
X-Gm-Message-State: AOJu0YxZ8SHQDt/hRux+yfdSifMURuWxW1f9Oll2QKcLC+g4m2bKJFW0
	sTVijDWi9cgWqbndIG4vQ13KKM48kZ0dtgd+v8Gma+aiGR48n05f0xoYcs8f
X-Google-Smtp-Source: AGHT+IE7ogUG9tRD0WnMczM/tymMtBBdsSU5DZtB+mUCbLD5UTqk9IZJvwcwmjF9Ts170Q0493/hQw==
X-Received: by 2002:a05:6402:2748:b0:5ce:ddd4:7c2f with SMTP id 4fb4d7f45d1cf-5ceddd47c77mr1223090a12.7.1730720515017;
        Mon, 04 Nov 2024 03:41:55 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e97f2sm4157219a12.87.2024.11.04.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:41:54 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v5 3/9] packfile: pass `repository` to static function in the file
Date: Mon,  4 Nov 2024 12:41:41 +0100
Message-ID: <167a1f3a111958df7e1841aeae37addcdf04c411.1730714298.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730714298.git.karthik.188@gmail.com>
References: <cover.1730714298.git.karthik.188@gmail.com>
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

