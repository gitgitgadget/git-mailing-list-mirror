Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134F17C68
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594122; cv=none; b=EUHpljdbYLpNbY4/A/jA/ERBjh5+eXUutbup9sG2XZlPaPWk5sC1cL5kE8eGrKx3qHBbw9tMAb46sExGlJZg8Q6FYQHp52hFMWxyA2+bIvKaGOXiyz+51fkegISKsxap+IDzoLrKW4fISeya2iO/Cu9WnrU0MBCD4KpoO368nYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594122; c=relaxed/simple;
	bh=7hEPM+686e2LwLzUsNKEW/7eC4H9tgaIcZjbUuF9yJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T01aEl+f/6yRAiGDd7oYd4bvzCGKv9J1H90pSt7QxLPyt8NVWlTuUEszgMGYnI0hNxywFgjCG/Ua9yqyCO1Sfc/0tgDL8p8c+0yqdYRLERJsROkmzRl3LnoWRQDtIyRk4v/MGozn9TBBr2xLOrOVUjb81RVI0y3hI5P8lTM2+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7N/FI5j; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7N/FI5j"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2059112f0a7so31603515ad.3
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594119; x=1728198919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaW/L1N+pf/tIvL6LVphvkNKwP4K+NALqN0af0AZ1E8=;
        b=D7N/FI5jJ45eg1pgzfLWgKyYyT2cwRclnxdMYgILzvMhTyu8MyzZVS9tDNapfSctcj
         3vkEkB4NXG4f0ydpBAwqGt3lHJPub3NuemynHZEIAPW3hlng7b8c/Z1ZGrlkAkRpyadf
         a36fT8C9u4pAeri7k1916qro0K4VKVbbF0V+Sf6gsj0Boq6GRsq7ZTSnzniPM/uupMbm
         LvnqahjjIpy9DSVGhZVshEPfUlN085gCfBzUYZgBgKNkFsvid74ql6/CLmpaQ+8X3K8J
         /EQTlxTTQwouXFZQQS68hJgmrwa1vUXD0z+GPFf4CHMpPDNy+x4LFQo6w+AQVV4HmsZy
         de6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594119; x=1728198919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaW/L1N+pf/tIvL6LVphvkNKwP4K+NALqN0af0AZ1E8=;
        b=OvL2sed+OTVyIKGhr8QUIFmegoSB38lmg1OrqavwBEccSZQ1FUCXiO4c9g9omkcO+x
         gy0Iqd2Ghtdyh9L5CzJN1SdRScDFoJ8RkqhbQtqKiExMv/4Jdb9MMe27sRcpA9xyPYRX
         xEmj0OnfuSzsc30MnFssIa6xOijP/yIsIHtdkNhHnOO+FkP42FH20epTIsud7KyfP+zq
         CHgie+JZYk54YpmjJGA/pCEQIGws8KWevTMZR79J1Pfa9Zn5opaZENZiv7PgtTr8U+VE
         eRVH8+oTEXTez9DjeMdcp7uSFgyFRfP3c4SWY3xm8dCzgN3cp6XCSfFSBzb/0ju9AJLK
         BsqA==
X-Gm-Message-State: AOJu0YwsRmMn8uqJgxKJQggjN+hATHNAo9V/KIEQLzHtnfr/p1b4LDBz
	sj5H9us2WPrNwoo7XhWribHp2SvZ/LQCZ3riuMR0ulw+JtW1LWxtzG103g==
X-Google-Smtp-Source: AGHT+IFJ+hbo3O8zrYJVjd8XJd9ceSwOQdaZOuxDI0Xfu71rWcKPy4gzaEjBIHgcmZVmvvdI4wLbOQ==
X-Received: by 2002:a17:902:f54b:b0:206:8c18:a538 with SMTP id d9443c01a7336-20b3776af26mr126102845ad.32.1727594119445;
        Sun, 29 Sep 2024 00:15:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e63ab7sm35739665ad.290.2024.09.29.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:15:18 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:15:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/9] ref: initialize "fsck_ref_report" with zero
Message-ID: <Zvj-hjBXlWr803Us@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

The original code explicitly initializes the "path" member in the
"struct fsck_ref_report" to NULL (which implicitly 0-initializes other
members in the struct). It is more customary to use "{ 0 }" to express
that we are 0-initializing everything. In order to align with the the
codebase, initialize "fsck_ref_report" with zero.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..03d2503276 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3520,7 +3520,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = { 0 };
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.46.2

