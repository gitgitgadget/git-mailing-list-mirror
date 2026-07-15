Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75448AE38
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128945; cv=none; b=Indag20Q2bbP8nGP+3A6XvUaNsfllsrC+9mMGn1cM/EQA0039UxuJedmJ70BiukqpVTiFeCkLcdbVpn0OpoFu+VMfkFzHkUDVWziQ8/D5IbDtZG61T7HbQ9XbYRxMlGRCo/p1sN6V+aQxVu3Toa6jRXOeTKeZC40qhcCg+jIv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128945; c=relaxed/simple;
	bh=J+zSoFHmxQEp/G4r2mb7IziHepm6Ry0TxZj0KtmVjBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=runhSjcOaFrFLIE1ezE222c9pfEi6zO5FOJxR/gzHlaE/woR3KKwthfZF7+eSlKIMu963yIHobWnM4WwgamJEatNxe9qz/mihiovnviGp4TZ7GSfFgV5DIWLAZN1TCEqq4hNkmND9jhaf4DfGqgVl/ttocSZ3gBsRdelkdxBAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg0/wshs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg0/wshs"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso22794875e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128942; x=1784733742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1HRWc+L3XrGF2SqRBl4W9JpXgo70uLigdAkwsqlg9k=;
        b=Dg0/wshs0sASL9TW/KtKM3NXCS5fjAYQVboLR/MF5We6MBdrk4YAK8IslLopj7Wa+7
         ipecRmrosXSkfEik+mGchAsYHu6JGqg4Rl+maG3DtIWUM/jbOy0WUMJ+5o1f+pk7VP0c
         sNtnBKf/BBMRs61U5kj+YwD7ie5FVXODQUSZOcud5zSP0nN5a34WAgiByzs+cMrdQCIf
         dm8xFXsWMs3WzHYNwtz+jMw1kHEliiv+XPFM6TriI9mVsrIMbfTQuvme5W5lxcqfWT1r
         gxlKNpbXoxdBfZmsWXhIK/6p8iszJNk2YjgYXvF8qn5/8fRkEpooDN5t3eP+kxshleCp
         U9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128942; x=1784733742;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1HRWc+L3XrGF2SqRBl4W9JpXgo70uLigdAkwsqlg9k=;
        b=qiAAH6tasUozUIFuZVopnp7bl1Ka+V1CBr+lALhd1zGA8BGSH1pLUbh+enQkkfN5NN
         Q6Sz48xtbasZ5Sjld+cn/JWj/KPeYp5yQHTsi4wqzHcNBJL3CQpdMhZXFi9kWBCfskTG
         Tc7V5zc8hBVa3Q0K9PMHYQOhcy9zGM175EQE9ClOMlWAt5qyW3vvYzIF0WKpxqDNsi1h
         /uN9y5zgK5Qcwa2wyt6NPB+ftpLwyf8KKyZNA7GfNPvKA/Z7B4vR1ZOl6KkJcB53j0Mp
         cYoB0PVKxOpd6dm7TKreBf+Ub/VLZyPi1FeeYJY0IANMdiU3jefjXmP/0bZtuD0RWcRD
         Mvaw==
X-Gm-Message-State: AOJu0YzoPC1hrI5gDAQmqgvRdLM2CeKu2/iibetWHz8Ylp3q9LPKBsD8
	nkjCzIqn1Po7fPoLIwqkkiVkHXjupG6mKA9RfPn2M7iv7MzK7tyTDkxSZcmjJA==
X-Gm-Gg: AfdE7cloCMdJNOG4fRq/GlPE+ti+e10Kyfbk3fIQJOtAhkzHZyg8XZdc7pXYGNzzr5T
	+AJv8bdyiLOpcWXaCnbOD9Pspi6wuhGTCjhtil8mz8kI+UjjHPNK0Yvb0HPWfjINX3ONWGiF/KF
	VwAaFOiIrG7dnBSEzrPeHX/dJhfiYbTBb53+Fsl+AA8uJim6SccS9wngccFS0zrnLLWHAoET+Ae
	SwZyZaGNmYZacK6Vpls8mOFuvod8jMhsgkMAwjv8gYUYzuDmtTSV1mGEByiQXZEgGQgpceRJ0S4
	mScVpbahfMeRaJRbB4wbLbdYxZ+RhzHr2N/7g1hSENxZ6DNb8XhFsFNJNNAEshA0cSEsqOX5vfx
	8TDnkoN52qLBtMt8wb/ZY93sDrz9BEmQg7wIYWFc/RCiXOSRi7hZWmPyAGqKvsVUz57sG7hz/MY
	5IB0tpxYOjeM/bikdJ
X-Received: by 2002:a05:600c:c87:b0:493:fd5b:2d5c with SMTP id 5b1f17b1804b1-49515904a8dmr92037165e9.22.1784128942180;
        Wed, 15 Jul 2026 08:22:22 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:21 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 4/9] sequencer: remove unnecessary "or" in pick_one_commit()
Date: Wed, 15 Jul 2026 16:21:58 +0100
Message-ID: <e785433ad3d77945c6eea7c732b0df5d9d04774d.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If error_with_patch(..., res, ...) succeeds then it returns "res", if
it fails then it returns -1. This means that or-ing the return value
with "res" is pointless as the result is the same as the return value.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1db844100ad..70e12eab0ec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5007,9 +5007,8 @@ static int pick_one_commit(struct repository *r,
 		      oideq(&opts->squash_onto, &oid))))
 			to_amend = 1;
 
-		return res | error_with_patch(r, item->commit,
-					      arg, item->arg_len, opts,
-					      res, to_amend);
+		return error_with_patch(r, item->commit, arg, item->arg_len,
+					opts, res, to_amend);
 	}
 	return res;
 }
-- 
2.54.0.200.gfd8d68259e3

