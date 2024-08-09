Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0349192B85
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202031; cv=none; b=ru2L+dBQ+u6DAHAnMia4OOhogow7ubwmGCGaphHnpWLI9FvkFhYFXfkPNppsY7E8JDseXoUH2zAsBI0BxUxppUx5jCZe4D2/p5ifIRCozdySE116UJMclwDkTPFU+phRBIY/zDR1tXOTP7Q2Y6nInaauUeBLCfBnahABRT2UsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202031; c=relaxed/simple;
	bh=rNjYv8v/nNvu5fkAterIaONp+7KgWiJuJ3zrzWZNg3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvPDK5YqDVnUxhwyU8j29j1PD6G2VcIH54Tq03JvZ54UDWVsbiqaAch9tWGnYySD4Ojn2mbNPo5mkARepPQCS/CFbA2iWcJraE2N0jmeKUli24XaCwdFk6WDNTk2yH+FhyxL6gutrpgfxVFfbcbjNrGV2e3dh+VCFnX0uzLmh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBcU2CVp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBcU2CVp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7107b16be12so1614454b3a.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723202028; x=1723806828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxcNKp4a5xaumj3da3OqlAmj+xm5gsA3osHbMT4TyUs=;
        b=FBcU2CVpBdGAHqDQT9MBVcuQgAWILGAUc2Geyp1h8iP2xbVFkBgYEX7cW5LtYD2Jwm
         n8MChD6HlUZ4zIfWbetK3mND4Ot7bWO6lUvyLUTwnNvtIPnkZXVXyEbUjAyOHt5bUrHJ
         vdmUe9ieemBypDFpPREKK5hSBoTUHSBIS7tWtbvHL30OccW5amXHQiX2yPSFg+buXsYl
         e5qYqXyZzAz8N+TeQw9Szl2FTRdykVc9sXm7Yd//FtKbq3XQUzAbZrABsAFm4umgw8+Z
         SjN7HiXM8mSKJZASkxrun0pmvJdaBYBU51DxHmuU84Ks4OFcYqM2Ba0Yor34LWhGlumC
         oVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202028; x=1723806828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxcNKp4a5xaumj3da3OqlAmj+xm5gsA3osHbMT4TyUs=;
        b=QY25yIcZvqLjCeb9pITfwpoVAihIi9UtRkLrjK9dXcmCKluQbZsap4mztspegk8A7I
         0QZdvp8L23iIPaPiv4IbksziB4O0FCu9VpsZlSRP6jugvuvMC7UJdv40e0gFDBwrZ7WC
         QjfsKvuSVEK+eSA41f6e/0SeHLsYmpbWEtRBDWSnzgOiXBvc6LCsSMwbdxlvViuxHRZg
         UWek6dJQC7zU5IRsPpZOX46gfbnKEtjQ4BbM8F7nFspzKDyyhTxcARaoHSwbLyaaIFB7
         tVHfQcQQiD+NoalCH6/ZXI6rcNMWLC+1pm3hJL9mYAs35XJbJn97u7+gqloC5b6jKXHK
         ou4g==
X-Gm-Message-State: AOJu0YzsakuNT3E9sutpdqEtq30HvqlrNUuh93OOPE68nar58+TMtQZS
	zYGb4QxTI7Zq9g9y1mMeDEfGSDXfrw6bDjai/jRB4bvKakJzyqy5QkkO2Mpd
X-Google-Smtp-Source: AGHT+IEjn5WNo9xSXPXZtVbuwOW+cY42FIaO4r4GiXwgiH8ZdqT2KDk3YD6isfFR30F+gplGazQCVA==
X-Received: by 2002:a05:6a00:4603:b0:70b:a46:7db7 with SMTP id d2e1a72fcca58-710dc760456mr1097875b3a.16.1723202028216;
        Fri, 09 Aug 2024 04:13:48 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.199])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb2e74d1sm2490377b3a.171.2024.08.09.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:13:47 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] t-reftable-readwrite: use 'for' in place of infinite 'while' loops
Date: Fri,  9 Aug 2024 16:35:43 +0530
Message-ID: <20240809111312.4401-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240809111312.4401-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240809111312.4401-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a for loop with an empty conditional statement is more concise
and easier to read than an infinite 'while' loop in instances
where we need a loop variable. Hence, replace such instances of a
'while' loop with the equivalent 'for' loop.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e90f2bf9de..7daf28ec6d 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -268,15 +268,13 @@ static void t_log_write_read(void)
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
-	i = 0;
-	while (1) {
+	for (i = 0; ; i++) {
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
 		check(!err);
 		check_str(names[i], log.refname);
 		check_int(i, ==, log.update_index);
-		i++;
 		reftable_log_record_release(&log);
 	}
 
@@ -374,7 +372,7 @@ static void t_table_read_write_sequential(void)
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
-	while (1) {
+	for (j = 0; ; j++) {
 		struct reftable_ref_record ref = { 0 };
 		int r = reftable_iterator_next_ref(&it, &ref);
 		check_int(r, >=, 0);
@@ -382,8 +380,6 @@ static void t_table_read_write_sequential(void)
 			break;
 		check_str(names[j], ref.refname);
 		check_int(update_index, ==, ref.update_index);
-
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, N);
@@ -589,15 +585,13 @@ static void t_table_refs_for(int indexed)
 	err = reftable_reader_refs_for(&rd, &it, want_hash);
 	check(!err);
 
-	j = 0;
-	while (1) {
+	for (j = 0; ; j++) {
 		int err = reftable_iterator_next_ref(&it, &ref);
 		check_int(err, >=, 0);
 		if (err > 0)
 			break;
 		check_int(j, <, want_names_len);
 		check_str(ref.refname, want_names[j]);
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, want_names_len);
-- 
2.45.GIT

