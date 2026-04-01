Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8843264CB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012608; cv=none; b=W09BgUgcrLXHB3v0obmrRbySuYbgWW95o2QSzhlrrj4HOTFOzyIUrlY8We3WZSsONRAh+gOEE7WQYUN613yemYW1ox+EH9dD53vsr+CGlWp+oRas49eG+0gyAbcHZ8sTSOgMlMwONDFwOC9nGVAkUjl9+Ba2Vn0x2bnDBtHxg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012608; c=relaxed/simple;
	bh=NKGzjbT3G2Qs1LobYt8i+F1zwzUwn6KVReYzMTAQ1Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr3rpWH7R4gdLaN0miqZi5vqDL5QspGK27nMYpjooBp6+oPDnlRkJvWJxbicWLvK3ETlqmEWg79PvJiY0+hWuOjPiN/FLLdgwcYzhiegl83YSn6Utpt2qXRbCe5tvuu9hTKJm9D8QhPAGxJCY/g8FnuJ+Ymwf9IfwPfjRFnR7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfbqmaEr; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfbqmaEr"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7422b4ff1so2072518a34.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012603; x=1775617403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=TfbqmaErYYUE/soxzQ1ubBgYLT9L7hEmKvsZ/Bn48ahNtfNmgWIK0f7cdwTHdWMDAt
         Ab8a5x8MSsy6Nn1vfYPN1z43CDOk9dEWxvU2DpabVPScarkQDg8aTSbwhUGg+b6SOjf0
         P00xGVNTiHB/6FYSXivGRmkbrqBNE0uLkzPkF9YnConsK5vhNAAvImvPNcf+FKLnRyvN
         vgvFYhtjZh6UVlT3d4s47OUPagG2y1IdpMFmEdJB6NZWYlIJdLoDaq0YPeLA6SojBWyD
         zl/rsNg0JghbeJ48zIhyLFetwBppu2dr9v8er2HgBPF0L1Ox/YgtlLXzPqRdYU209BxA
         pJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012603; x=1775617403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=fb1XZ3L/+BNt8MFhdYL4G5zk01V45jOpuo2Ql/8w3wTcNHN3unKnYwn/r20hP8EosP
         vU/0nFgCNvEmMWOGmDFU/qxspQ5xalVp/fjc+g7DyYKkAi8+Qz4fsV6Nct4dYSuCR7Hg
         VWpCoKd59x2gnEtdnQNLbzZnMP6PR7S2bnD2aj3crdwmT8BweLCqIqxEUhsIBi5/eNk2
         2/+j31GW0TDWaWQudibFz6d7c0QMS3Oi3dyNwEDQlAiXGKKUHZqrU3Jtk0M+mqWJ0vGI
         WCWQ17IYsx0idDkDZJt7G2kLaNUbngC1tcTn7CL4JPBv3RaNHA73ZYPEl5zH1A9LBEIj
         fzQQ==
X-Gm-Message-State: AOJu0YyyT4CIFKBvdBxUXTfqFresJR6NKfd+HjJH3VqUI+AhGWZyoyfe
	JPDObUdntfw2T+8kJyT+Sk4ncFaTv/SnkVrWNfZAqocinTY4Z4RoH4tt5/zxlg==
X-Gm-Gg: ATEYQzwYAzYO6g8cuf/WeuGKbPUn7PeplfkpyApvn4iU2AD18gXWnHapTeY5q5WnZbG
	yqnS1aasnCKoF9wWEwMTS6r3GpL+JibL3QZt7ntdIogCRLP+P38YLd6MLw7Fgc6ei6Rh9ycRLnd
	o6d+mQ+DofFJIhnUFidou0C9uxqZstS3Y89nkBILVXTUtk17u/N2AQ3tsEBp6vh+nlaILJmRuO2
	UTqxDJAswXNUwoa4Vapr4ycLW+ftenk+GhpxLG8+gxxQYy3xU6eKOtAWu6Awz534hPbAA7eDyrR
	irVsmdQ0ZKS1Xzph18kI11vW2Eo5snDCEoz5u+zTtYFiQojhTBOKpMqBsyWsU09lWcz0GaMxRjE
	dCuJ4bYSQLQoVzAQnx3GmKmVFgcfYrIRiAB+ybKy9tYftwG4D8E843YsLsFITKLZFOgtpU6qLwZ
	izTnZ5VJuCUslBKFtObxzkovuaqxTPByK92mcMjlM6vg==
X-Received: by 2002:a05:6830:2713:b0:7d7:ecea:fd95 with SMTP id 46e09a7af769-7db991e6370mr1328704a34.7.1775012602952;
        Tue, 31 Mar 2026 20:03:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/7] odb/transaction: use pluggable `begin_transaction()`
Date: Tue, 31 Mar 2026 22:03:10 -0500
Message-ID: <20260401030316.1847362-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each ODB source is expected to provide an ODB transaction implementation
that should be used when starting a transaction. With d6fc6fe6f8
(odb/source: make `begin_transaction()` function pluggable, 2026-03-05),
the `struct odb_source` now provides a pluggable callback for beginning
transactions. Use the callback provided by the ODB source accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index 9bf3f347dc..592ac84075 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-file.h"
+#include "odb/source.h"
 #include "odb/transaction.h"
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
@@ -7,7 +7,7 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 	if (odb->transaction)
 		return NULL;
 
-	odb->transaction = odb_transaction_files_begin(odb->sources);
+	odb_source_begin_transaction(odb->sources, &odb->transaction);
 
 	return odb->transaction;
 }
-- 
2.53.0.381.g628a66ccf6

