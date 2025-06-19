Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8B2248AA
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375831; cv=none; b=Zw9yeA+53GVLwT2Qmz9JWmwxpnDq6+PIoL5Csl66HbByhM3kBwF9yOoJgpEV5XzqG7y06+XgjPJPWAg5cNrQha6aLeXIhh/0JIuU4CybNRJ1BlH3InGI/NbP8tZyYXAqO47JhmX9IaoHoybigleClKKE9c7w6eluTbFf5Hb7bdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375831; c=relaxed/simple;
	bh=x5ekYaQcp5nFRxkj0wWH2vcnG4yLVDuqSdOcaNShW9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R374Zrmde8Bymzy0KGvxXXiJzgH0nQknW7PqigChNCzIYwJQKlUpVsfaBSVLQLm8HT7+77xxw3XLHaP6epQvji4PAgcWJOv+YoAPLj4QdPWCGwisb/CCOBcpjMk8z97QSMFf1pMirxKwe+iURLnNi6kMUHUaWNsLSvHO+q7LVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=L9s60fJ4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="L9s60fJ4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7115e32802bso11304337b3.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375828; x=1750980628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DnugGUMk5fVOoQGZkSR8wOyg0UHFpqreGDR7dv1Ng8=;
        b=L9s60fJ4/RrWljyaa90Mbm2jZpaJeKn2nsHwiNYOF3TCTaHGm2Q2hSlouuhzA6T0XV
         i/RUwebPSoPd/GoPm3zh6fphVJI7ofUoWrH8yNR8vEEtl13ZxMorYBb2RvqMQptKdTAx
         i5S8M9ALu+ycXLdTvjxt9vPMl9dCigIky3PSC/NwtwZCoUCZJAohGflHOt+KFIAAVEkT
         5lRQcH2mo8gmZTeWMWtlzzeM1nxWtsyQSlkHg+7Wze8Qloy9DcIa2z0nmv9jDRLj1N+x
         5r6WNN4BzCoHOioa96emWO465H8LcBEEEZojQG5c9wCeL6Rxi6F8hIHQW//LmU8SMeGi
         9n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375828; x=1750980628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DnugGUMk5fVOoQGZkSR8wOyg0UHFpqreGDR7dv1Ng8=;
        b=rx07kurTy9sxMMsuPingNbaEFSb4oKvQLPS8jyjyMl4DrFyMyDxBjUhI9uC5xEl+6b
         xOI4IA8ZMfnPoteCRtycDKef0H3HgkHn2W2YqZZFUd31Y/H+W5UGaiAlIwcM6bkJXg6P
         Duf53YGvDnjmUMuwhCmEutFEEnj6VskgpIsL5Dfl7KFUd+TM7r8DdtUioqRZkJNyS0fM
         hc6Z9PoTmnEt/T4m8RBUoe7o32/meTc7rcE0x8w1p05MkjB8liVQSBTWmm9zGCzHNTx/
         IUvFNxvoexbkqJbA5ROc5r9d4ZX/3DjtLYEk3gJmPJE8EDAjlagwJVah3dBuPs3zdsTw
         P91A==
X-Gm-Message-State: AOJu0Yw0bILZBbCqNLsBhoz7rInbr/Pv2tROS8cFYO0AK0DBdNte/vur
	FK2vvweI4zGrU3I5qAMoOvKjsamKDOrf44+cRqOxA+dAgmSxKczf3Z3rOUfh3MoBxSC8QGdMdyw
	dBTPi
X-Gm-Gg: ASbGnctgopEnhjVl3ai5dso/9/xMu2Q4cWFv3zapKdEMieNk6wJNu3eV2FKwuMakYOj
	FOOQRFzDCrBYx63kabjcioOdOA0d2H+4QuEuVypa3S5UIM8zxuAXfPkYOzwdMS9Ov4yyB+/CUyW
	fhViHWMtPyPaEaW942Kq8hA77vgwRANOV+TgBZHx7DBszGO6x5wF5kuDGV16sU7zm0P1/N8oqg+
	HipBYqLI+oC+f6cSSbM7kc5hm7rnDqyyIXB6VOvJUwlLQGZ8reAUYZYNyvYXx7WqozErRmXKUcx
	ThxLL9wi5LL5L1lvIZSqNIeMp+YOewxs32tyMLRA4GoEdaBDCjbr5Ts25yqfXFmFhqWC5woflHY
	QcOhuHUvJzY3G6crpKkc4qzoPRjfmhYxvYw==
X-Google-Smtp-Source: AGHT+IHKVmA7i8G6uaXL2mozaa8+QbeyyaeAThSWt+Cwly/M69z6rascZpmpsA6J54SimmZ7Rn861w==
X-Received: by 2002:a05:690c:d1b:b0:711:a54e:8e11 with SMTP id 00721157ae682-712c649a4d2mr15306207b3.24.1750375828544;
        Thu, 19 Jun 2025 16:30:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a21f0dsm2063807b3.43.2025.06.19.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:28 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 7/9] pack-objects: swap 'show_{object,commit}_pack_hint'
Message-ID: <c8cf316c5040539772ec66374c2bc74bb11afbad.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

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
index 9580b4ea1a..f44447a3f9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3748,12 +3748,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
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
@@ -3776,6 +3770,12 @@ static void show_object_pack_hint(struct object *object, const char *name,
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
2.50.0.61.gf819b10624.dirty

