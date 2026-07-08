Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30039EF33
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555176; cv=none; b=tCmR+5jxoOi28xLKkV1HVqTstsQQmXtzOV24hdw0VwyhgTIDL/xkiHZcWGg4rTp/WiaSa8CeMNBIFbLtBipqza5BFmdSoFPpUBu1vm6swGmDBON9XU1D1L3Ije4eK+S60LQHH3LPdnvVrniLgak80i1nmfAyevEp4fsKzYhdxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555176; c=relaxed/simple;
	bh=LgJOvA37/dn989m/9nA4etAmFKnNL4+6BPFhTkQDyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmRsotTIbaozO8mwfI3SJFByRYEjBh77N7VVS7o5o0QPDBC2IjKIG/9SfH447tFDQz4+rVDlBwMVM42yh8m4OJViJiQ/XfU9FHDPmD5SffkNioYrAep+QM3MpckJ+ZDlkN9g5Ek1AMYo7yDKolO6gnX6g1Sikt0O86EQcIiSH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTTvNmGc; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTTvNmGc"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cd237446cso811615fac.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555174; x=1784159974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=PTTvNmGcn0kgNu4qx88GhUkXq9MJxSpTEJhFZ/UrIoSoGLK/MPCnQ962N1x0qmC6uR
         ubaN8GPSRtPqnXJmy85pxfQ1uNP+tIwj4swE8AWOc9iAGkjLvECwEz8f9ZAYGSxRLtvj
         UHeVuB7UvGB7j0HtniFOZMXQGNVsyfHkeG7pry19K5CcFKuKCbP99RJwBk9NwLRxkW6N
         M644xTSMQblfHU9AqJkod+NA6Oy0c0nbklmTi75g+gKUywCeQUfmXdP+nRvzCpdxG6PL
         /EhiCI48lN3SiveFQF7cYW1YhK7Juz2Np2++Sk/++IaptSICB5/+0ViZJMBm6XwRpI0z
         VouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555174; x=1784159974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=Ot+1xF3oxfS75LvzKi8qzx9JQ01Es5U6tjBd4cYmMTdIJmwrdloT3HMftncyFx3y2d
         axxnwxYCMBBA5LQ/wZS4DEk6PbsOCJcmJAqCOoH2Nqlbh1HokW49LAmVzt7Yb/B1pL2q
         rVwQR+WHL5JZs0gbq9QUMz2WkQGxTdSm4IZ8MRT5OTT4BxN69uyIJ5FLdCrxEEsGlDFI
         VRd2srOhwXljCKfQeqJLeegp+pS+pAPM/BbMXz/2v1hVi0eHiUNmwusHCv9MeWP3MWXQ
         NVA8HICGTnWi+Ugfp0AiMDtircwi4g3iR4ANCDFt+6s+xGojxsnF8/TwzRdkhS1VfFeU
         ns2w==
X-Gm-Message-State: AOJu0YyaK9BQFo+tgzAlKScwu3RfYMOX4ikHH525i2ulAPjS7BcHo/Co
	w6zBNJJHm0kMIthhUlkFQ9u/uXF1ejzInS8CbehL5rxOlYowc9l5uhAOfGPmHA==
X-Gm-Gg: AfdE7clDzKKHdSupW9SlBCMRtE+9UO2jut1dD9OnlVwm4r1NGmUkPY4TIeVM8E9Q98G
	f+CuDybNc2WZ5fHBOikURZ5jJFBf9PdnfuaDUr/UsAVXmGwK1c7YS3W9dtRJRbNvKhVQnU6xf02
	jqpPgWNZzFYJYky0H91MRisR4GFfzoJF6HW9M9GcZKlZAkVzyL7dFG3COQ6ulwzbXeTddGs0fL0
	ULgrIm7kPznY6q016Tu0YZHFgSegvj4NGOP/HrUGOhFVd/EdIjoAQftW20mWGiOh/IZV5qMi0QE
	W7FwpEfvPoQSXLrN1exgYlFRX+b36XL/bSRoFEQuhPXBgwM/0Ur4dVt4P2XpVpo58XuOWVYgiej
	vLNLZ9pZ66fdNKEAASJsAaD7SFkkB6pljgBfaDV8eIwu0B0wGlAbtNogGZWt2uiaA3uMaUDquWG
	bPmSjSyEM4Bwhp+1G4o4Hn
X-Received: by 2002:a05:6870:f107:b0:43e:fe1b:1a76 with SMTP id 586e51a60fabf-45163bfceb2mr3161778fac.22.1783555174517;
        Wed, 08 Jul 2026 16:59:34 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/11] object-file: drop check for inflight transactions
Date: Wed,  8 Jul 2026 18:59:18 -0500
Message-ID: <20260708235925.3992097-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ODB transactions are started via `odb_transaction_begin()` and contain
validation to avoid starting multiple transactions at the same time. The
"files" backend also has the same logic, but is redundant due to the
generic layer already handling it. Drop this validation from the "files"
backend accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 4 ----
 object-file.h | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 33bd6c6810..e51389833a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1678,10 +1678,6 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 {
 	struct odb_transaction_files *transaction;
-	struct object_database *odb = source->odb;
-
-	if (odb->transaction)
-		return NULL;
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
diff --git a/object-file.h b/object-file.h
index 528c4e6e69..ea43d818f0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -194,8 +194,7 @@ struct odb_transaction;
 /*
  * Tell the object database to optimize for adding
  * multiple objects. odb_transaction_files_commit must be called
- * to make new objects visible. If a transaction is already
- * pending, NULL is returned.
+ * to make new objects visible.
  */
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
 
-- 
2.55.0.122.gf85a7e6620

