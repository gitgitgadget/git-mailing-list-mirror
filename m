Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73473131E23
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985154; cv=none; b=ue34S5WdQ00vsJU0Sroh6nI9Pio66umC3xyprlVdQ2EnToc24Tmr9LJY6czf4w66sbbakallk3B4dcm/AaLSgP2/RKfH6WihRK2N71FyDiTXveZtMDFegJ0JnjIy3bQ8/EBunxk+9FhQsuPib8cA7B/B5d5OKj6dboV5mr4O/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985154; c=relaxed/simple;
	bh=CQcMUA/sRB/QWbihFlxacVElu+NSy2DRwHBvVJHcNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bqp7gE1ki2HAGgiiIF9hhDy+nNXJs7ouk3Rs74o8owM00DzW5R2mimEp2wzkkZfSkE1mtGdS/R2PAMEFZC9nvB7djwqzIoFucxtIhfr0myKl30+pv0gO+fsxsLN9QJQsaooWVbxvF+pNJLF4D1t7fOZLKJ2fOwmupLlOllDONog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmTg/gUB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmTg/gUB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42e8e85a969so5302611cf.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985152; x=1709589952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOSgXZwzZutIsH9W50mGIJbV21EIOpTYplCjJ+NKEqw=;
        b=LmTg/gUBDJsTCzRWYnR3RU6UlxIM7NHbt8r+0EEqDXGxduirT9xrDWXOIbswcLYMC4
         EvyCntoee6SaobQEbphZydGzCg7nmaHvbqJltBzFxwCe37619tyeS4OljEUr7g8Eb/9O
         /dgLzUwNkmdHSia/jSTQbnFtBZNqhnMpaqGN2NxHHSZgOaY1gPJX8vm26a/3ueSYRrix
         Bj3+GoeieOrWQDygl6cUZGWXCgda+zTzDKKYqKwQTyWRBxsOK17hEtnBTh8rZfA2BBI0
         X4cKcV1NCxSAwNdKpg4YIwavFhb9i2vAaRvVxjIXrOrHOnr76ADOkkjt1HtfqYaj4OHi
         9tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985152; x=1709589952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOSgXZwzZutIsH9W50mGIJbV21EIOpTYplCjJ+NKEqw=;
        b=ieFjACFsesw+anzIQGynxqWXCoXAJm8agsOGxayfXBbQNHDKjN3+3NTo88FJRw4LRP
         GfQyWCwMoTuolQGTNCCwAtrVdzMC7LaVF712IYnfzBFCakEKinXcrIKBsHTJ3Wt/kKL8
         t5vRnBACtO48LA97jEso34m+5osJYWepuktnqq+8AszH8E6XQRXuI8Wgs/DxW04JcJLy
         6BMAq7W7tyDPB+kc3Mo7HGTrJtXzR+vazFutuVnymP4W2ER1fWovP00Zt89MLbEJEYb+
         +WEIYA6evsa98gXBE/gD4NEjPfloOCn6+1I/VDtp+p5aacFfL1NW7xBGCVv7dXdnp2ZH
         UrUw==
X-Gm-Message-State: AOJu0Yw06C+21XIleCH4yfsfm7B/kua2h3RFLP/Eo3WpIVlkYI/S6v7v
	+2/yYfUU26zzrX1tPSaYdlCGUY6GPHfeAgqBGAyKZzxbtlk6nmWstNz0Kigs
X-Google-Smtp-Source: AGHT+IHAi7RJyRz8WQi1b0fvF8qFH0cdGF5gtCgWixAubNwon4ByMmx93DDVIB6tAuXspTZZKjIgdw==
X-Received: by 2002:ac8:5a95:0:b0:42e:7de0:cf28 with SMTP id c21-20020ac85a95000000b0042e7de0cf28mr5164546qtc.68.1708985152059;
        Mon, 26 Feb 2024 14:05:52 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm2911696qtr.3.2024.02.26.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:51 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 1/4] builtin/index-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 17:05:35 -0500
Message-ID: <20240226220539.3494-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240226220539.3494-1-randall.becker@nexbridge.ca>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of
arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a3a37bd215..f80b8d101a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1571,7 +1571,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		 * the last part of the input buffer to stdout.
 		 */
 		while (input_len) {
-			err = xwrite(1, input_buffer + input_offset, input_len);
+			err = write_in_full(1, input_buffer + input_offset, input_len);
 			if (err <= 0)
 				break;
 			input_len -= err;
-- 
2.42.1

