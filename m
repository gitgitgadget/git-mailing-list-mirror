Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168239935E
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783881; cv=none; b=cPzhY02qMAoQIduVdZ+/06JzgMGEy5eV9jeSYuWyuM3VB0hwjOutr9a4uVaVYECc3rdOu8I3iFqCntKj95vm9JRmB2kGVxYG2EIR7yEC6K5rfaIKEX8vTZchx9g5e9vus/FvtrkJmaBoUOGMe0VKuVffx+xClbX/rO0BLgOyaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783881; c=relaxed/simple;
	bh=/Xpzq5xVvIaMLw8cCpSidUTbtz/4/u0P8t/VkXdR9tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IADKRsfvO1kDVW23VAWdjQOouN0xtpRmZtJvc3d+3ZJoBXIhK0e/fMxjwFjBSdaJxmAODOT0yeFlMOO0z6zHOxhRx3Wn/xEs/DOVah7DJNpNvo7do5DIOksTeOHGAEnkFpLhiIWEk2BnG/qKB2oZGVyiXSTJzTWcopAVkIMisSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAP2HGxH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAP2HGxH"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d55b97f358so5750590a34.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783879; x=1779388679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdrgz/HcfUJ5o+Pc74W5B5V98l2VejLzw1OTqsnQCmM=;
        b=UAP2HGxHjrMMFUiri155YrMDvAGhLSIl8lOB28spLYmOEYyDt5kv47G2H5PxwjQ34S
         JEz4yra/RyOPdRBa/A9YzGURK6l2H+Gvxn3uIEvRcAZ6kfmzCksvHLz2/z3j9YRONlyt
         nwmO+cmV+YRCQItWYoaqUZnYN248x1x4Epy6OMAYp1q7ODfP4b/Axcxi5J2TYMYvC78Y
         1B0V9bK5L83X6MV8FI2ME4GTlpTdLrZwYJRAJCJkVzG5OFE4dn+rD/KmCvcPMXe4+h12
         ze2WO4uJjUnv3xjH8Ho7J3h+xhCfx9LyNCrFmjLj3YxyDBCKkd0X/HQ9IctnOICLP9O4
         jA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783879; x=1779388679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdrgz/HcfUJ5o+Pc74W5B5V98l2VejLzw1OTqsnQCmM=;
        b=CGsf7CXOiYTZTAtMcpxOhpruTciuOUcU6UW0PkMB/LFWqqQjGyLZb+3w42PVfPEfRg
         cIWi1TtjwcOhwjVt9+zPBFV8uJSuUfMViBixQ/AehVav26UYIrfHZ+KFVn+XhTsAkRDf
         cp9wdT3u5NFQh2Rjo0l0rAMcoU+aoI9XwHTNwNW19YVHhLU6FXdQ/de2BfRwiMYQp1XN
         qcZ/u1AN+N5vxWD9Ne73DLBG8lILXVk1bOhgM0eRu9AEIHBfijSWfOT0P2gs2N+Zcdhq
         pB6/JAcPY8nUaAhhJ7i8VOIw0Y5eTgPZTrU23Fk8g7Gqwa8eLfbQCKv6abEM8BunIp7X
         Jgmw==
X-Gm-Message-State: AOJu0YwriA07taR16l6MfBCqGA50sJuVmxOgzXJ3UUU5/uHjCwTV/d+3
	DkT9SyKbwWaqJ31eKOqnVGtjEARZ0qgxJCGO/GUiwQWNk1imIG+TIlqr27PwEg==
X-Gm-Gg: Acq92OFrIHefT1+sfgypPictfVj5jcWRai4EvQvgj92xo3253Tlk9dpafivCtfwJsM2
	174UgHdjEqlcCGJRAUavnattmSM0Z+MKgHj9s5AeQpP3uZuF9H2gne4btsw7rinn0y+akpcE4sg
	kEnJl9ogFgc4dImz7fbtqpV5ISrIctYEwBQomDKaU6Qm88IHVru5+mY2fQK3SFfUHlxpNbdLR9J
	TKz6A6L4pgSM7feBL/2O0MvW0Tf/In5cMO5ZdpqRE948dNyxHDHFOFglreMunNt+EtjQYHdWW4G
	uYzIQ/jzyCeiuXlEBQXuEXO+RGfeC6waonUuobalWX7k3Z1n1bFbP6N7GFBYlorYG/REoIjeNN3
	Htq5+j2k1k1Pn3RRQjfljvrWE/5TI5EWw8ZJJMLEFugR+zbkTUPo9KO0+JIZtxrQ/RoWA+pAJkP
	w5FGi/99fz4R4IgLW6kkrsFF+ghBxonAo=
X-Received: by 2002:a05:6820:16a6:b0:69b:7ac2:5abc with SMTP id 006d021491bc7-69c94375738mr404926eaf.30.1778783878922;
        Thu, 14 May 2026 11:37:58 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:37:58 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/7] odb/transaction: use pluggable `begin_transaction()`
Date: Thu, 14 May 2026 13:37:35 -0500
Message-ID: <20260514183740.1505171-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
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
2.54.0.105.g59ff4886a5

