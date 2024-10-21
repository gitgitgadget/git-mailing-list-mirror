Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF21E5709
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504696; cv=none; b=QjnAorWSmeKSOG7kCBP0/gmhp4xgjGIiF64GcIVxwNiv99AHHcCESxyFyQY/TC2aZWM2Hxm3WJcpV/4BWQDw8rUkyMsUK2cOoFO8Y6o98gFVxrbo2n9zxHe7Syvew1Qx7+OE8Vnx6UW2WDFL88HeFYzB0b5viFcUmxNiOLpBjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504696; c=relaxed/simple;
	bh=7R9D53vMveTBoquoK5KiAzyv7NbQGhCOWci7OAZjprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYzXwu/BwWJqAIaW7jUUsJbWQOSsbLblNZqphhMm1BnrWi0CuM1q150TgPSj7fbXA5s3CgbG/t0knIbHyXZrh1glHAWnQ42/af6dkGEF5Z7eomtPRohyAbwar+SZeoniDmp3erIUJ8HfO7NQu697p40tXu28Sdk/nwQsmOCQbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfLE2DeI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfLE2DeI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so508832966b.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504693; x=1730109493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K07S/EzEEiacNTiHvYWjPNAW5dH16XFWmyLdObkYBxc=;
        b=FfLE2DeILGKu2GpylPBH38aWa7/JbHbYoCgrFiDA8/wYWqGVnrj7DtZQTKKRgPZpax
         I2oMb2mmqi3oNGW//nWYP5Cecd33egqyyRtQ3r9ATD+HgoA3Iyz3gDMY9Wy0m4c+DuXx
         SFnN/AoPhjXCpHhT3V/f+o2WXpaYem7ktm3dl61AmllF5wUqU4JFtflIrx1WlUEsiE6b
         fG9tOnGW6XyPLiw1s0Cz3+1spEnjPsMSh3CEurRGIMg7greIRrAF1Gsya1iZPb55TfMF
         GbugKdJdybDQm4ns2cT3MuxqVEHH02/wHyjJUyce8h19gXiexUSOoGxc2dOVXZJ7R49i
         REbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504693; x=1730109493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K07S/EzEEiacNTiHvYWjPNAW5dH16XFWmyLdObkYBxc=;
        b=enBKrMny4fHOBypFffQlTPolBfZZH5sdQX9lx6gbPEOr6FqBXnspm2elrHvukdskwp
         ZMYXQeskPXsgvV6KkckqiKlxXkVCqkKrOfUv5yYNWTOAXrYGtEEU3hlaI02h3G4cP/Sn
         IAQiTbEGo58Le2omeSwwY7dKboAbg+aWcX1m1ZwppFVwMGfyT4m++lLhqkodiApsLbfq
         o8cPmaLRaUnvOONvJFfCGQSAh/MfykiS6FMR4s/ix690piHgKzlZGPWbmKLh0rjJjxiN
         uWA6axXdKH6ori+MN5X1aKS35qWQDciEHL1szlG/p+adsfcnqpwcSMtdxRFk4hkPPTuI
         4jBw==
X-Gm-Message-State: AOJu0YxERbTHs7sfXjAnG5UipOFjFpyGVWQQcOQ0f+b/DrsR7KJq3Wnd
	zW0QWyD0/RwiEfZ19Z0yjWLaCkUE13aQj2rinw0/sllP5FtF8vNyDnCb8YJQ
X-Google-Smtp-Source: AGHT+IEGD4swbFnoLSkoP6PB3253fmoA6ZkRtlKAU8t0zppjusOL5nPG3RjVUuJ4jqSBX8RyDwRXSA==
X-Received: by 2002:a17:907:7250:b0:a99:3a3d:9611 with SMTP id a640c23a62f3a-a9a69ccc958mr1050310266b.50.1729504692407;
        Mon, 21 Oct 2024 02:58:12 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 08/20] packfile: pass down repository to `unpack_compressed_entry`
Date: Mon, 21 Oct 2024 11:57:51 +0200
Message-ID: <72cdb128c17f3f87f2506b3158b09cfcb58206d3.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `unpack_compressed_entry` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 458db59b3a..54f3b9f0a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1615,10 +1615,11 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	return type;
 }
 
-static void *unpack_compressed_entry(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t curpos,
-				    unsigned long size)
+static void *unpack_compressed_entry(struct repository *repo,
+				     struct packed_git *p,
+				     struct pack_window **w_curs,
+				     off_t curpos,
+				     unsigned long size)
 {
 	int st;
 	git_zstream stream;
@@ -1633,8 +1634,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 	git_inflate_init(&stream);
 	do {
-		in = use_pack(the_repository, p, w_curs, curpos,
-			      &stream.avail_in);
+		in = use_pack(repo, p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		/*
 		 * Note: we must ensure the window section returned by
@@ -1777,7 +1777,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		if (!base_from_cache)
-			data = unpack_compressed_entry(p, &w_curs, curpos, size);
+			data = unpack_compressed_entry(r, p, &w_curs, curpos,
+						       size);
 		break;
 	default:
 		data = NULL;
@@ -1838,7 +1839,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		if (!base)
 			continue;
 
-		delta_data = unpack_compressed_entry(p, &w_curs, curpos, delta_size);
+		delta_data = unpack_compressed_entry(r, p, &w_curs, curpos,
+						     delta_size);
 
 		if (!delta_data) {
 			error("failed to unpack compressed delta "
-- 
2.47.0

