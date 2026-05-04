Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790203DEFE2
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903601; cv=none; b=Jicrg9pcIO2F08yNRNk7cCyur85xyIgVOX3S2plPIUwWMzSlaQMMEq0dXGAB6ujsWa2H9TbrEUx+WMxTMXAq7EcYqy6yzyUsf3lUylMf0EM2OFQtq6lEr+PcY1uRGCHqs+3LR3H320KOCiNbtmwFW5iJM1EcxFzgjzpCdxMjsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903601; c=relaxed/simple;
	bh=haxWyVz0kV23GZ4BmV3306g4eH0bxq/Lyf5NiYspCF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsEPd+HUxXyhRSBsa7O2Qq/bWOAte3aiMl/Z2rVDlefC/uDxmcXOa0JcdmuLuSEzODUW9fEugjtkmQImw0MxmlnUmI1PmSCzxLjYodt9wYQW1m3US0/rI8+VEsZc20NrN7M4Nj+vJvK8PPIMI1B1xnkIF+JWymjGc8NzgTvGK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDpvOQ6f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDpvOQ6f"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so25549685e9.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903599; x=1778508399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3SB3jTLoZJ7IQZvnwu0AEu4BuT/PvVOrYA82eXjsDs=;
        b=WDpvOQ6fHhabW+hCuP+muh3rFstdSToA9SUoSViNnbaVMZ+sIP5+XAYEo5qE9nO5CH
         7HzdgkyS1usVvrLQUdYQ7tLeO7f5vDT1rHudUIA6gP4oKmoq6EY1S+EfNMitGgMXQD1h
         +nXfo0Xlw7+LzxIAbrRm2vs2BkJuh/Jy4JbLqi2LendwtdbKSSFYF4YtdoiSs6GeneLS
         nNyHWi++lYoUO+u++WTmWbsQG8X9S4B2r9WeejodqUPrago0ZKCK6RkSdA4TM95MYVfs
         PVY8mDQG0F0mHmWHDvetLLsPyiG7Lw2x48LGd1C2EjR0tZ2ucElOP1sKNxtTiOytbdhh
         NgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903599; x=1778508399;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3SB3jTLoZJ7IQZvnwu0AEu4BuT/PvVOrYA82eXjsDs=;
        b=joVf9FTaUPXMuE8pJCpebpi4/PpAej409T8HB49J9e+0C5blJmnlW0uUF+oS7X22q/
         L/29Bj6K5YGc1oBTRdKs3kHuicOwVq9Sv1pHp/EsGTvhfQ6yNTStL5cNifDbvxNM3Ucv
         4U0kAMG+SnTd6M7EdXlQjgtPLiC5/L8e8YxlawtvcVIsmSEz10dM+UkETplEPENibHUr
         /r59CbFilL8nbxJMuCFhg/+0A7pgv3NbPQ4vHEhHVkffoB3Zxel3QMcnHdclRFSC51x5
         KgyxEMEhTk0piZElPAydIMYggYc2YjYS99UUnSGDOYpn+QVALIO2pu/9MCL6lZOGjHh4
         I98w==
X-Gm-Message-State: AOJu0YwZatUDg3sWMUk1hA+pXJ1er2w1Ex1CAs0Vr0wGL4W6dt09zwkX
	wIrbx3PpP4rHU1a+tH5NYzeOjdPa/faScu1Czu+Oap4SBplbwMF9MZi9i3pXtA==
X-Gm-Gg: AeBDieuVmZqj2+nZvdNGfbSmYoSWmRdjQJFervWsP5uu+t5swhlvg2D9q3lZJd8jkjU
	Cl0Z0YmQZo2cyWxVxAdf0Jb11JXYrjdN01NOUY1g9w8sbLwSm283GR9AlZHpAyQ2LO8flnrhIUr
	7V9hoWjlcNs8hSIKxI9fAed8PhRUc/KeVt8dtI5BfMjY7zGeUxCwiqdZP0jd4F1bE4VwGh96t+s
	6MeNfYigigjGzz4ADVApTS06c/jumQak9KtgiAYXp8V/Uz+ykzlkepIMFx2YcJgfyT2WKm1PzTO
	lyM8yiRXS96aK45niDSrco9PV6EKHYCGN6rfvcd1b/ZJZzF9MJqGQIA+g+VCOek8L83clK58Q+z
	nEaI9A4Hx8jyQOmRnFzLR4r8SQfiKUOdd2HnUHsUR+Xs8DXE+rKPmJX0g3gzNEUaHfulMgOFK1Z
	FQO3OJiwcuakeK+JamAM/w5D4Z3oAuN0sZrkYW+qAMupKPWbocAg==
X-Received: by 2002:a05:600c:821b:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48a9852f366mr157322685e9.1.1777903598829;
        Mon, 04 May 2026 07:06:38 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm390520555e9.3.2026.05.04.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:06:38 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/4] xprepare: simplify error handling
Date: Mon,  4 May 2026 15:06:20 +0100
Message-ID: <24e65d42b72a4e302bdb16125ce75f24659cd8a5.1777903579.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1777903579.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk> <cover.1777903579.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If either of the two allocations fail we want to take the same action
so use a single if statement. This saves a few lines and makes it
easier for the next commit to add a couple more allocations.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 81de412875a..7a29e5fc474 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -282,11 +282,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Create temporary arrays that will help us decide if
 	 * changed[i] should remain false, or become true.
 	 */
-	if (!XDL_CALLOC_ARRAY(action1, len1)) {
-		ret = -1;
-		goto cleanup;
-	}
-	if (!XDL_CALLOC_ARRAY(action2, len2)) {
+	if (!XDL_CALLOC_ARRAY(action1, len1) ||
+	    !XDL_CALLOC_ARRAY(action2, len2)) {
 		ret = -1;
 		goto cleanup;
 	}
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

