Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7052BF3FE
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757233; cv=none; b=sbGlCI/qVddMNCCPR+fF1giNQkWQczxO8nGG15HM2WcLYFo2rxKYpKTm/k4L3mW1jyBgpZVVUSr0Fcj+6e2ho8gkSRZk4fr7KnYNkrjmSc01BgGDf1s9EdEQoK7IWv5UKg30zbLxI1bJaqrGeucY+0suALLW/fycAFhTmCD7N5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757233; c=relaxed/simple;
	bh=sXRPwxDHs9pln2H0TSPY5feRTVEgeDGurA4Q+i3aYr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBUOq4LkJr4bUbDhxZDDuRO0xvL8cz/4na4KnWSTrPg9VY6jRS0uDqFVmJc8XAuwokPdvjmkNiaH2cDgjVTJwrpJ6xneLE6X6XVmX49NHyHsS2M0A2BE5UeTVEUNFmnnChSgHB4DzVY4+oeY67VHqzeYT0Rt43QkkZ5q5NBaPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q4SGl5nE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q4SGl5nE"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476964b2c1dso99563761cf.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757230; x=1745362030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdgXDncBl79uhyB2Zn24sX1erKzVOM/9l3B83Mt9eQc=;
        b=Q4SGl5nErJAi5TlqXNsVXcdYGg8+C1jskkfbG8M3UH2fx0wyFc5VUvNKGjaJqEz1Ik
         SB+9EeIvwIUHnz4c/Ai++cwB7l+bcDMWYLjWuP32TT1H1cyFswVyfVIMpuC/vhtBe19P
         wjhFg6JAfYQ5yGczExbHMb6Nki6CZACzRPdO5Ott8DdRFBI8FKdhjyJMQTewaVLs6scK
         mmpoSzvdL8dpGpNURfJz4izdeeO/qPQIQK+GoHt9Soq5mwfzeu0ZSKWh1/y9saCscdlQ
         bOUl/BZRtgEe3mW05WyYF3jGqRj6RxEPGBGuN5wu7JhGKYBpOxO7xLMc7BMJ5+ySUQyu
         K6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757230; x=1745362030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdgXDncBl79uhyB2Zn24sX1erKzVOM/9l3B83Mt9eQc=;
        b=r5x3Hum2+K+e7xZ13+eVeKQa1RnCR36GxVJ6mflmZQiW8ULRlfF5Fs8kq6k1qrYWtV
         H7uGQydVjlk4X6bIpeiyesWyi5qChmg4TD01evoikgrQ5X6ynbKmvfSsxRrWn3A4bW/V
         jSS5jwIfMLq1jaOr7jcUV/+kyE1FhuxKsYPk/oXnRisSucv1WuzqaDJLgPa+Y3RTpqPP
         T7y+l05oVPA23NhM5HQ6ICa1elg8sfLKEi0zQucCTaW7wJAfGOHpjmac1VJtjYxwnbss
         K9551uUfUdC+uDXRTcaL6kPHSfFt2epvVZe2VsYfVSF2ImeyWGfTHwzc9nP14TICIK3v
         I5oQ==
X-Gm-Message-State: AOJu0YxstDAvJbGcYwJRZaOeJwgPXLu3A+cnMbS8jNGcsOsvNF0iBOud
	Y2uiViwmMe+jZ37G59An26Fw2SUnKy6f8F6tnHfbZtWBKgj6xOJzy7cZRGvev+41HiBJmoCVLYE
	dDcg=
X-Gm-Gg: ASbGncsq0XgkjYw8XHYKyLNO2QjnkU2fxADW1IA9wGyz/XbHjtcb1h+/he15l2shZ3a
	9SkeC7NGx0zUAr8YtNq/7J0xCB+tDV40i0/+Y5k98yZfohIN7K8jT1GX96M4fHi0Hx217VkzXf/
	K5W+6bkhbDGha1Fmhk7TEUol232II5xf8VRpvCT6UgK1ZDolxwNZBwDdXvz05lw5ZP4O6SujRqr
	FyLGNYwag1++RRDDm2ITnqkBu1nq7uK2/XSdQ6ddY3I8uFk0TarvkvCTZ5PwiAj9+86M0ZQuGr0
	q66jGT+66tJ7Yxo0nzKeK4Jnu+6/kg5YyOjfCmupUhrUI9LLmJJoJoSkMoh3XXa7ach9w38Amqb
	64PSuXtKgArqa
X-Google-Smtp-Source: AGHT+IEtMLHlKdqah86LnB9EYaAFPoML3gF+n+6jD0iWhXGiBUOjtu2RVTHktKLcj2XJRRPLhZtJ5w==
X-Received: by 2002:a05:622a:1820:b0:476:7cc2:3f57 with SMTP id d75a77b69052e-47ad39f6a05mr16939691cf.10.1744757230356;
        Tue, 15 Apr 2025 15:47:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb163e4sm99170781cf.31.2025.04.15.15.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:47:10 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:47:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/9] pack-objects: swap 'show_{object,commit}_pack_hint'
Message-ID: <6c997853f15deb03a7b55577316720c40573be9b.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

show_commit_pack_hint() has heretofore been a noop, so its position
within its compilation unit only needs to appear before its first use.

But the following commit will sometimes have `show_commit_pack_hint()`
call `show_object_pack_hint()`, so reorder the former to appear after
the latter to minimize the code movement in that patch.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f06b359150..f4009cd391 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3513,12 +3513,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit UNUSED,
-				  void *data UNUSED)
-{
-	/* nothing to do; commits don't have a namehash */
-}
-
 static void show_object_pack_hint(struct object *object, const char *name,
 				  void *data UNUSED)
 {
@@ -3541,6 +3535,12 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	stdin_packs_hints_nr++;
 }
 
+static void show_commit_pack_hint(struct commit *commit UNUSED,
+				  void *data UNUSED)
+{
+	/* nothing to do; commits don't have a namehash */
+}
+
 static int pack_mtime_cmp(const void *_a, const void *_b)
 {
 	struct packed_git *a = ((const struct string_list_item*)_a)->util;
-- 
2.49.0.230.ga662d77f78

