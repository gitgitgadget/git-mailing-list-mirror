Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE3347C6
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771670351; cv=none; b=gVknQ7ySoUOeqmhRSdzyxdYYIPWIXUHfYhG9zV5Am0pGtuOlZQhq1EJhwSW1AbxBEChiQR7giXJbVER99K6/vuJoDhKl/bhShbng5qJrxSJyG4zIzhlImfFUv0Bc/vqde0i5C5B0z6yifEXEGp2Qje1G8D8tpsc+FaoJD6IeyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771670351; c=relaxed/simple;
	bh=Lv65XaLGT2vnFwdk5JJ14xRz7bwAm6pnVDTKK0/BNOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP4wlA/CafGGTzK814ir93BA8MonGbAB53V2dkMZrqvByP3aC0tBfM/z5q8zQuX1fRAviYfssXeWcxh8ZE74kXGTjEnjhKSLMtQzl1mZuyBWJUIaVPT55GNEQC+16azinEdb3ddvcKp5jv0F8UVoqS4WnulfUZCYX6XwC2fPoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuwgtQP2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuwgtQP2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230c839409so2606169b3a.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 02:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771670350; x=1772275150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Muc6AciZf0W/hBR1vBfllClGKrx9CCwWGTmq9t9n5II=;
        b=YuwgtQP2WNQHKjaZfdVUJajIcrplarixydiM+klPhVLCFaJxn9iy4xmdTy2DVNn290
         qvSI935q5y4173Fv4AjU5e76otJSlgLIzMfxczQMQwCPW6Tn9xz2sBo7t74lv8NKhJf4
         FB8QoJIg0Qa24qF7TkIWAWhAu9wYg2/49iOZwkFyjUShQo4XTAswojSYat25ua661Rlk
         NwBDlwgshX0W7ubID5Z5WN9xYmqhRvzkAumSnzubKM9uCyODSkU54j8fbb+nV63ZGOfJ
         wEsrmOZRiutOvPj2y5gnU/gTYZyE7fO0tNwglPhT+u5ajb7Z8nngBZaQS9jYJNTjfoG6
         Ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771670350; x=1772275150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Muc6AciZf0W/hBR1vBfllClGKrx9CCwWGTmq9t9n5II=;
        b=an32Ir83qOrMatHrI5l9wrIBAYRGj0qazoCBAM9WRDN2UtYOhvaI5I2L5y/a/MCWXR
         mLVXtVD0v96PW5pcrd4OMsOb6Cpme0nF0hmqX7u1MV3AnZ6twf+sNkP+YjSiuv0jXI7q
         rg48eawqpDmv4mVtFYnWPwDi4vnLsj9rTNssOBpf6aOJgv44BzyhSFUU9bA9uzzLzveC
         F13+Vwb7fVegOjowjE+Nq4msjDCxBSdIX85/JZbDrVNHxxQfL45VSUiBJdybovwinibi
         IQBb33X93+rIohQZk6/tG7jlwS6Kb0zmNxQy5tGShuEknQTozWzBWdDHvDw9AaoWAQCe
         FQzg==
X-Gm-Message-State: AOJu0YxUCWz5e94J/AkCExscXTgK7V1Eba4bidpIkWNK0uz4EnLPnf9j
	rvGYkYJoTrFcRZEuaHyEaDSoyZj5GPE7nyLSvgWxUmoQ0jaJVGdgtJeX/6k63d2H
X-Gm-Gg: AZuq6aKOAn4HpiN+G+EC84WDjhKb1erdKYuDKjkv9G/5HDVSngXmAJyax6GLhssydZI
	i1Piy/fopAlekOWFiLFN1jaBBDasFgW21txz5L/eFI0cKrS2hI+d/Qa8zdjgFzDRhTNlYrRxEbC
	I2IUuCs0poHoAsZqDw2g8lAhb7sPwnXopUnm5woHrlLpj9KWpq5HooxSwHkPx807RMoss5yqhpQ
	0HDysYJsKVH5IgiwNEVu/ZNWpmS2Qi8CMCebJHnE5PzF5LCnbbk5g1RmPG4hpbUIMELjisuD8KZ
	UUg1/ZgiHmftixuOssDwXykGE9vKaMQQjdyrobPKrBLE2KyyMHC+6Wb7quHpHPri3x4YIt7OZfT
	7UziYudHX3ogslhxoFnX+Tf0tjb1OXrNc4p599PSZCtClH+G34y2M/dt9sPIf9y2qXti9L4KcLd
	r2Mu1O48447oyNz2T6Rvmv9nJ4p/Qw
X-Received: by 2002:a05:6a00:a85:b0:824:374a:140d with SMTP id d2e1a72fcca58-826da8bd87cmr2653553b3a.4.1771670349595;
        Sat, 21 Feb 2026 02:39:09 -0800 (PST)
Received: from sahitya-07.. ([2401:4900:8857:d4b6:dd21:4b0e:17d6:2838])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd6c3d38sm1937694b3a.28.2026.02.21.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 02:39:08 -0800 (PST)
From: Sahitya Chandra <sahityajb@gmail.com>
To: git@vger.kernel.org
Cc: Sahitya Chandra <sahityajb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-redundant: fix memory leak when open_pack_index() fails
Date: Sat, 21 Feb 2026 16:08:59 +0530
Message-ID: <20260221103900.41740-1-sahityajb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In add_pack(), we allocate l.remaining_objects with llist_init() before
calling open_pack_index(). If open_pack_index() fails we return NULL
without freeing the allocated list, leaking the memory.

Fix by calling llist_free(l.remaining_objects) on the error path before
returning.

Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
---
 builtin/pack-redundant.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index e4ecf774ca..86749bb7e7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -546,8 +546,10 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.remaining_objects);
 
-	if (open_pack_index(p))
+	if (open_pack_index(p)) {
+		llist_free(l.remaining_objects);
 		return NULL;
+	}
 
 	base = p->index_data;
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
-- 
2.43.0

