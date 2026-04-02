Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0363ECBEA
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141885; cv=none; b=naiCYhWKxtGcWbr+jymiZturrVGCYdOsz2XkfCJ16IWc6lmBDBcxMFAesjR41dqIZu0S8yn5ysbcGcGN2wIbBbGNPVVy8HrrUK8GxldLNI2J7NhX7EWzKt+oSDJmpq1nSjExqlQ+PfVxFqquIHev48MhUvh/cveYFCBMVAwRIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141885; c=relaxed/simple;
	bh=5+zjdkdx7DpAVPYmcdhV6Nhu7ZxE5CT9aCPlFWmRi4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl4NIW/oPejDgwu17oUqcYKIXUBzrhXCqlFvSTOthBvCAEMdGiBI+XKibwdCTkjRcN5qJ3UDZ/6YYEmsCI+edbX8KRglpKOcWy9yGCk6h7pkIFwS4u1U8qk/xoxdQj77NJ0eT24xw6oQCNavKGsn6FK230Hi0Yg3LGpWEujcNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmvJjFmy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmvJjFmy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so11631135e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141882; x=1775746682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5usgxuWWtpyedJKW+zXs1RobrrL4bCBaU0E6Vbo7WqI=;
        b=KmvJjFmycUFzdA5fpKvbcAxJ8ieypa7K2yvy276jKjrx2UpV53ZB4hLcWDLOtv0erf
         TuPWxi//x+wmd3bIVbV9tf7w+HsET2hdS6EfN7+qe3YcBPhQqMdHpV8Nl6Z8KKjqZ7ft
         GBprzIZjKkR3NCRE+W0kqAiishrzIY7LXaY/FwJ5iNp3tb9oswqUN4dKXGQe526IzqE6
         g205JwyW7Rcckdys+CLkYqkG8/Z4SBiViWJBeQEKbk//JKqB3IEVWTjeF0TIXUDLhhtq
         gdp0MI5FtcVE3gxRpPbx2p1yQVyTVp00TaflcBcrSqcVm0URduCqNLDaH2srTq1ZOo7x
         EXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141882; x=1775746682;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5usgxuWWtpyedJKW+zXs1RobrrL4bCBaU0E6Vbo7WqI=;
        b=sYtM0AeobdckAtST2TF5nL2F8uHGN0J8acvce0bKORsHkxfSnNwYWs7TwdBPQ9CJ0E
         SXpg2y1HmawVVrPpHNrXR0JRlhRcBXxMSGCdNjW8m9y5mEVN5pjZVB8979VgA2rhb94Y
         lkV1Ss1fVvaErMvS9F6GZSZ4j0SpIqQOP54ncJRVbn0yjiQ3ckyZC9sj6JLSBw3ZFq5O
         vMNjtCuQemsfqTwbR2kKXmmk9oDXs4+I7qAq8iQRkuOcdewtEuFDEUsLf97C6ruswjBE
         bu8opfj8Eq3sPsz3w9aKunpcFNS5AsVZ4pRax+2dNFOj8DtL/6MhoWiQh0ecluo/WzXD
         eqKw==
X-Gm-Message-State: AOJu0YxesZfIvBgfzbi2TVY8S7Ce3gi7q/BzIt6eIhsr/COdSafPY/MR
	5GlE7lbUJyRnQmE8By53Ysrlec+BeQcaYgD1WX6zlVQ0MyDTqizrrKSi/rvDiw==
X-Gm-Gg: ATEYQzz1kUYH7RQo6B4tnimJSxTt9ebpYfDLx2ZXJP1pA1Is+reWjqbTK+cJJaaHKrm
	X7J7OAOr0EMKyRmAi2Eo0dUxFAnD+k2d4jHfHPPeZQtunufz2aup/AftIfi1YvsR6FE76fg1gt4
	yztRqA6RBmKhGRkM9x/4F+OdI5oVjRoPcQJBtIhWP2OSzyT6O750pf3R7frLT0p83/SAkaKgXe8
	c07Gn7n+f6nsPXex31UjSUfRhk/SAUWpARCUHtZyQkEm8lctouha6G7vPCxtAuWshWq4rcubhIh
	RPx+NZAtOBCXCbOsSfB/vzFPxYl6QevD+QFX6AiNYfxOW1pHrIoLAONTZrgf4Q4qoQIOs9ZVtI9
	UBAh9iK4wNHn659xlZhwl3yjsdfjHyFQTvbBVHdyIFMag/OmFMfnBKsK3YKNXoUIoTYd8wbo/ST
	aUQvMN5UjsmVaplnfjH35Iq3PdODKikbt2kZxS
X-Received: by 2002:a05:600c:c04a:b0:485:5981:1423 with SMTP id 5b1f17b1804b1-4888355e82bmr102735185e9.3.1775141882222;
        Thu, 02 Apr 2026 07:58:02 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm70913705e9.24.2026.04.02.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:58:01 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/4] xprepare: simplify error handling
Date: Thu,  2 Apr 2026 15:57:43 +0100
Message-ID: <cdcad99edc403a9e0d1d21592fa295477282421c.1775141855.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
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
index f8e6a6d74d5..cf4ac34f047 100644
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
2.52.0.362.g884e03848a9.dirty

