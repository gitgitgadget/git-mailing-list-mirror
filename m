Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270178;
	b=00rABEmHrVCQ7CB5mv1KDlA3sH3ei0pZcxfhr6NTD8vwCjcPqQBLbjdczxTKmW+R/ib+
	 R6dau2u0YBiyEn9K24RHWwVHb2kckUTBLgOCSkOnbxOQUa5jvdtnIZCCiIEE/V6nOLP5C
	 QGKQo1tQ3AVJ4DKlNEP5IwUgKSVKcttIFAT5PfWVr8jLB3T/KpFXFKkpEum2Jydazh8VD
	 2IQPVNU4vp5n2I09euU2fLUmhyy/k4mYMlqNKpBhRaJmtHsONbPCXOpwZUf/MTrbJEcXr
	 QXted321UH7kq8sF+EiQw4jYQSdmSdMiJPYRO6t0nXiKey/o1JATCQMZN0EHKksF3Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
	b=45c7RCivX03bVbHlHeAMK+8JRphznm/jhbKkSVR8wel1idA1stLmCHkEA5bKcBu7RyWi
	 7ftd7EDGntZxgKq7YqSxm9CwCC3x7eGqF0E4WaBDD/BY3CC3+JhGmx33Y7X5v+XSWbsDn
	 3uQ3ihFgcKGlXFPkVCSAKDaWUahXV9dVlhGXVjQWBuH+a8gjBAaQjHblj+bNRhsCZNXHp
	 lX7nUWZ8lvM2PC74SWg59JsgXL/+535xBjJDi0F6Q36RIPhDVoteGx2Cl6obRY++47jYI
	 jPQWQhaBtqszgIJeaSQ33l3sAf/35H7XagOiHsIuAaPm/HrC6QhemkJMYGk57gwNEjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfNALtbj;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6333606A330
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6333606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfNALtbj
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-703be215729so553539eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270177; x=1794874977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
        b=GfNALtbjQxblvOnwkSbPBqe0B/wV0W95xNLWmbHqbmQYscb96aUxa+uGtai4vg5Zg8
         Hn6dGcr43O+swuJdEOhrnEnzoyc0YqMbJ3Zj9NcbQggqWsvnDzswmnECua2RiTw+dx/I
         9y+vf8DrvKVWSuDztWbjSNB4zLRfnoepjR1lRL/eykLqOEz0vNQMuJNn4bH217SLWa+T
         Ius/Gj6ki4cvS+WNysqmA9XdSy9Sw6kRJ134vJYrT0nl+azgjDmimkbF4uSCy613oIoL
         eifXyI501hf4FfUGpGqstkWgilM7gJluIMaWtQP9b0SyNEwiPzsFnaFr7+6zgkD1mpDR
         pM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270177; x=1794874977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpD80DimQYgR/0e1e3paRzNhCO1o9FKm31PzSwweQis=;
        b=Fal9h3EghMpHJT9FJJeB+81VQzz5TirntQL/PnuBaQ2ZfqbJ7vmVX5T56+bolv0wRC
         yO9wo7OdGlp7TuK3wxz4Ly9Z8H+z1e7YCMEa2yPpTs8X4deAShIM3wabl7Na4ucsuKa9
         WLH9Bge4bo7X3wTU/Zh/SOTXbsDuFsijyEtdwRMkW5P91YCUhSyFuK9u2Z30O11fFcP0
         LV89jj7RYbwWrgftgfU5hEtdGP5TEBZYngZForub4GmpbGlb+y0unhDYTfRmBrQxhL32
         XS1ThsNuE5rXGAmEqIh/zqgJ/rYR9FC4YTU8FmTn/tx6bw87OzmTxVqKJPrNAGjaSonV
         gnjw==
X-Gm-Message-State: APuU4Z8HQbxR6CTgga2Awea96mNxro5uJ3fRRnLw3+EJNR1/hmYJcGOR
	tTMPRl23KuRg9cz8mzdsFsgnmhaMZQQvIzWTqs6W2GVxEESw7Wh1/02+hkhzjw==
X-Gm-Gg: AYBFou2Z/f0+mSDaGh+28BtWyYKgNChsUICg8VQO+mlyHNodE5M8muFp+uNoUCImAdI
	/NYAaT1+BimGO3hZ2CosYYizkfs1JrKOglefL6LDaQ4rEwW0yn3LZwu3/n2IMzzl50cHMmczvJs
	Q3Rf8AUWTwxPUlxGOfGU7DbohltMmn506diQWTTn9YhXUMbB2BO4g73sdQgCVZfT532Aqh2vdX7
	sW+ufyI2SFMVtsxjzBnprk8aV3i/M8bZ8CATB9qepjOkN+eDJaizFmz7k4QZGHcvQTpVQu0JOAW
	X6V58aOEKSipfhkoEokoH8IpM6GdA5+CdDiKL/sBEWMwDqWmhWPcZEAoKmMK+aptJO9iD/bpa1y
	AlLlBJEsraAvHhz+MoDioS7ruwzkuhOgH7fsFYAkviLjMAvRgLct9wzragY7kiRAUFPPWXsarJT
	T+wqprfiH9JJo3lRi6JAuZZg2PPob3wlp+fyQHlEH2QnXlzAFw8vYGpRMPY9cry2uVrSBlqfh6d
	vT+PcJ3fcPDsgzgd94FOK6jJHz67wWO1hb27LOeithZb4tWHmILVwVY6Jy87j28PZd9fGNzE6Aa
	/J+DFOGon8fRwbYcgl31Q8lmowWmMP0QNHnzLIOq5Uyx5/bLif6GMuChtWQfaeYR0QTQ
X-Received: by 2002:a05:6820:55d3:10b0:6b7:8396:f3da with SMTP id 006d021491bc7-718a547cf25mr291974eaf.60.1794270176658;
        Mon, 09 Nov 2026 16:22:56 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm680518a34.17.2026.11.09.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:22:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/4] object-file: rename default transaction prefix
Date: Mon,  9 Nov 2026 18:22:48 -0600
Message-ID: <20261110002251.2007617-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261110002251.2007617-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the temporary directory created for a "files" ODB
transaction has its name prefixed with "bulk-fsync". This name dates
back to c0f4752ed2 (core.fsyncmethod: batched disk flushes for
loose-objects, 2022-04-04), where the temporary object directory only
served to batch fsyncs of loose objects.

ODB transactions have since grown into a more general interface for
writing objects though, and the temporary object directory is not
inherently tied to how objects are synced. In a subsequent commit, the
temporary object directory is created for every transaction regardless
of the configured fsync method, which would make the name misleading.

Rename the default prefix to "transaction" accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 132aaab6f8..201d9d6490 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1566,7 +1566,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->flags = flags;
 	strvec_init(&transaction->pack_names);
 
-	transaction->prefix = "bulk-fsync";
+	transaction->prefix = "transaction";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
 		/*
 		 * ODB transactions for git-receive-pack(1) eagerly create a
-- 
2.56.0.173.gf57c9a7388

