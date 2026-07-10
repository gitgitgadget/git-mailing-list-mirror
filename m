Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04A26296
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701450; cv=none; b=WU/+ilBNLhSgLVa66xEh55g5/YuQEpMl9wft/ho42mUqZ8JmJC8ls5ANlTf/1ZMz5JWOivJxvVu2nStApswnORM5PNwlI4l9HuIp53Wf6wL2frMNA6n+97SUR70A0xoPSse1JcEoN7Zalg6NV98Tw9Nk6RjxcuFMNCYPM2Peot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701450; c=relaxed/simple;
	bh=8EjyxZ7R3wxYZKWUr4XcwOViANwBOkKJEeP7h2eJABI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8Mg8GZz9Y/IOLQAGI8/dHz3PXHixjBYqj3jRpy5Opkbr6tZKvbqLwtizCvzJXzjDsA3oflPi0zoYla1iOZkvJCibPl76343noZWw1UR3Ol0oXhmGV1DJTpiuSJnIioisBG5l4lTB7kjNouG8KTkGCO5X7AVnHIcWxtniyZJ50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTj7yX4k; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTj7yX4k"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6b554044fso1040645a34.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701448; x=1784306248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=eTj7yX4kXdYdZRjQTbk0nQxzFBO99wAaYkLfGThaNxSmTMUW2M+s7W3DPDZuTM0f9f
         K6Tn+GU1nl7ihpQEAG36XbJufnblSmmiJc1gqoil4tvu9wagyYu4Me2nGAo5RPsQlyH6
         3L3B3up1K1V7tVsw++ObF18hFzIOAntArZtCMuwYv4at3wyDrBGjPfgHFmUa1Lq1jNFU
         W3BQ6DgR6izYVSeaRGK7ge5vr+RcFxKJstck0pe3TdgrqV3cAyUrh6d1p08W853Ne4q9
         fHHtDFsHTD89qfgz0ErOPj1pJQe0UJm+jwupsLCXKTYyvc66tFCX78wp5iuMs+5+MOfl
         pB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701448; x=1784306248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=dga4vRN4QTIpXfCA5lxT0rhHm2BdiAV06bBrh5V37xyJf0ZohqaP5DTK+pc3fphi5X
         683x+5yLhsOuc56hEJfTL4zvkZvh/UZkRHg0Ma+sHfATxwQCpeUZPg6Hp1VOwi/V2heS
         wH6SIvlzUhtoaHMv95pSP7yiMVwawjkcGnACodv9kywvcN+/aJvOr3wBGtVtgmWoMy2v
         hIt4xS6aY1RwdSDZeZmKjOVlyi4DzN2wsN19SUHVUd6ghCIr1uMkrXJ/XNeFFkoI7jzy
         iXuTBG6k04cZlsoYYHz8kbOpzftbw/gJ1UVkGzx4DWnBGHdlU8CX0eAtbcLUs5cQdxXp
         HW4Q==
X-Gm-Message-State: AOJu0YwRThnW2G7nqbpNyJfemUkau7xyRsGsY7ZhcnK4e6I2xVLCMhR4
	w0q23k+y2rbYVSsQgyO+oLmjiPeOSia9Twcns62VNmu9P0FJStJ+EmuaU84qbQ==
X-Gm-Gg: AfdE7cnNx19XyCAD1raiz1P3So3uhrrNHqnUxhJC6HS+77cCiw2wvdIaO8GqsxEKeT4
	FIbWW2P/gS08lywz3Nm7fwvQQ3ldE4avlN2D1s4o004YPgSxTrsVUQMWnzJav7EC50OsSw+rKM0
	BFYEhYuXda6Sxkb2R4WoSIOG8Y/77u0eJwXct8DYDtIRY9WltswKcl7htvpVR9leVEqJ9PAB8Cg
	j4kmLXWPmaKCrBgjXZVowbsfKm8+hJOiPw2VQL0pBsjhj3oViCQGrEH9Kk24HZB89UXRaS2pgHH
	0FxHwq5tj2o7x9XGUu4GqMNUWsclpaLVrYusiWI+yM01p96pc8kueiBTjhMjtpI8FmTnGe8ZlHe
	m0tkJifbq3wnR2mfSnME6ZcROADQ09cwiZp0Y1xfvz9dI6+rdfVDV0OazY26UptgkjFEwEKYBVB
	jvy18plU28GD9glzK1haG+
X-Received: by 2002:a05:6830:6c11:b0:7d9:7201:1acf with SMTP id 46e09a7af769-7ebd00cbd30mr8207463a34.5.1783701448509;
        Fri, 10 Jul 2026 09:37:28 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 01/11] object-file: rename files transaction prepare function
Date: Fri, 10 Jul 2026 11:37:12 -0500
Message-ID: <20260710163722.2962278-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" ODB transaction backend lazily creates a temporary object
directory when the first loose object is written to the transaction via
`prepare_loose_object_transaction()`. In a subsequent commit, the
temporary directory is used to also write packfiles to.

Rename the function to `odb_transaction_files_prepare()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index e3d92bbda2..a3eb8d71dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -499,7 +499,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_transaction(struct odb_transaction *base)
+static void odb_transaction_files_prepare(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -761,7 +761,7 @@ int write_loose_object(struct odb_source_loose *loose,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	odb_loose_path(loose, &filename, oid);
 
@@ -825,7 +825,7 @@ int odb_source_loose_write_stream(struct odb_source_loose *loose,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-- 
2.55.0.122.gf85a7e6620

