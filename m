Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC62750ED
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484062; cv=none; b=QFO8uCfcWEFIolGs1vlV9Kh5zTRvXvZunex6fjidQIAez4oJ/pkumprRzJswiojH9I0u/2V+9hSDXxCAAmS4vjsMJZNAkFlrw6Epbq4UxNrQObHAzCrCrCy8utQwyOGqsupbHYOv7M1DGTNsPUWjIciVqQwwgFAoGXMsJ/Zqvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484062; c=relaxed/simple;
	bh=8EjyxZ7R3wxYZKWUr4XcwOViANwBOkKJEeP7h2eJABI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHR0VNA+sy3Gf1JmynEo3HXhVo3M+d8puenQ1DmeYzt5Ymo/Nxf3y1tHhjXn4oTzma+WdetdtkN/21WUn2MG3cvJ7D9KhoKwZAA5X1mxxtpAyyN8rlf9rTF4uw+u2YISb/rePkgr7289HzPJNbaE9tJLCI/WjPNj0Dscw6OkM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb5xuxk4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb5xuxk4"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso337022a34.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484060; x=1784088860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=fb5xuxk4EML0XlaaBND7e1pqIWraG/KYrDSYfJoDDOQZgvfSginVXWvLSP5Em6F/pD
         Da9McPDq0W494+c2OfFzTW4ImJFWo+wUIw25/ZdNoOZ/xB5lmFtuIMGPjmXDs2NAgi56
         LZufx41VsOtt1e/zXxabSlfCu2ansPt4L86nY1uqFQM4YezawlY0c6lmKbf6hpQH1ibi
         xeAFkbONS78qVUVUI51HC5wduBiXmizL8wsKs1SFKK0JwaKY/1ZpJFz/plMQ87bhweo3
         7Sb/t6gt/IiPAnYKhQ6SM1oWRE4rAJXy7o1yQhfZn2MyREXWJj0TdyYnSjj071JPByWk
         g3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484060; x=1784088860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=p/6ciBb21Pyhonu15NRfKkDO9w/ZMhjXp4cdgIP9VJngI0A9IgR2JXHDftx7X9phz0
         L0EF/uAGZ6Xl0bswMrO3WlokoI6jJFy4B39dGX6nEL2kZ+AuIDWyAL7UMcjnqfD1C1yh
         8ofYQSON1qPHNBHuu21FkpVV2TlbiXCudL5XcBaw7eAGgTn/qsm9I6JfjG6aC4E0dLEW
         pdf43oFg1Z/1Fe0x3E+xpAlN2w/KbBL90Ctu4vuuHfcIAVTZi46wp/JAAIrhDNoarHZ5
         8w/6SB72RHOg/+tSQNusaAKEgAxpePg2EBorJM1NvlEX2tDrvKL6PH4fICg4OSUVF/XG
         HdTQ==
X-Gm-Message-State: AOJu0YwvRyqIqL50TaBTgM1QgxB1NKaKE02Jv51WdtvS4RSyPkJ8D33B
	wiv1P97pjbiyR5HwB9/Gt1HrNyPL3vUyz9sigEWpLS0h28q1BC9tff3MHrI/5g==
X-Gm-Gg: AfdE7cnO4EN3KckQzrP+rjdgOw1rpOGDpezyNvRbgv4MtXwrgkydjNpuJWh0Vep/cxS
	wI3x0hTzTomvaKbPpyZPR8co0lbJ2V4f8vcdPQrwiwhZAos98HB/qh0x6FuFk3B6Gkr4P8xyhJh
	8BMPEp9f6H6/VYeKZbSkzKO2yKrVrU46N3JgehgLMXJwv5J7JJN8lSsK+lE+SRpYT1W/uOi1iel
	RMBqrjxT31mWIhs1hjtsVYXmoWUq7MhDM6b3inUKohEsIuv+LiAYQyVT/ygfIpgW4pNd+4d/M6S
	CILLQVrgroqF3FhodB7hrGD7k1LqL4fKOd6K/EiRbsgoLM6VrsuzLMSiU3nJ0BtkGuQu8ICXnE2
	88+fxfavkJEa7il5YlZmaJbISym/m67rTPRMiTD6lSjjni5PRJfRJUWXX20wcCAGBHaZuqNFzgM
	oObpujit4jsMUyBwK3B19r
X-Received: by 2002:a05:6808:d4d:b0:497:d574:6155 with SMTP id 5614622812f47-4a206015c88mr577775b6e.33.1783484059925;
        Tue, 07 Jul 2026 21:14:19 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/11] object-file: rename files transaction prepare function
Date: Tue,  7 Jul 2026 23:14:02 -0500
Message-ID: <20260708041412.1157499-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
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

