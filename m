Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE53A6F19
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293833; cv=none; b=Npw9rV0wzf+CRN4xYguNsw0EcGdfOrOt6m+Mvc6AHQhToXIpQZRIANYtR9v0uIK38lIxxWvyKop3rEeHX4aTVCcxtoFZK/ugnkZkLsNo6DwHzTQ8NpDtIW/1MOruOJ1llgyjS915xlZ92pV0Soy17ViY88MU9bhrVDqGMowTbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293833; c=relaxed/simple;
	bh=no4cD+QcYicTCms+DAgkwwITG5OIAK0jWrsTvU9rCyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmSbziXoeMktWt+EmV2kGgU/ExepXeWcuWOQDv9FVdbda+0Xs5dcrqzgodVDU1pwH/ymX9+I8Dk3ta5gddPpT/DRQbqi3xTBMchlpZfmg1OpyYZ9XLyfuE1MYQxCAbnGiRVQDwiw3Ul7eTKbspDukS9DvTFn/zHzc9DNKShtYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw+/cdP7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw+/cdP7"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec450b950dso131376766b.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293826; x=1782898626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StwhdC4PjCsU2pPCRqmnHP3To5DYn/OYAFdLisMJT18=;
        b=Nw+/cdP7BLi29i43sHICtSLEyHL7pDEG0de68Lhe3DzMyQLhZjhfnPF8vGdC5VdqZO
         RRgPEFj521j2Vb2XdB15hNShX5snuE658plOnHtLhXwBv8gKiJi9k3V4MWIvqsIQWm0H
         lpJwf8sJ30q4z4tmZJGFgqsDZ9WYkYaOyOe307h4fGwXilY5WU85WJwy47k4gGKRyEgC
         ArowH+wZ6N/qULJJM6uLELH4KQ9jArH8UZT+O0ke2o21jqjuE7dGzerADZU7t/1Fy8lK
         /YjDCJIEg2TBEZ/MeiijB8maU+xfiOestRgeVVfh7Veg2PK60ht2BaJPhE0RsOAHoXJ0
         jC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293826; x=1782898626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StwhdC4PjCsU2pPCRqmnHP3To5DYn/OYAFdLisMJT18=;
        b=Oyju18qbaov1QfAHgdzdL57EU8yKaK6HHLvtic6Gf7GQQgh5PmDwtUyzzcN7Khicx7
         xGFvx1xeyKcXTQLr12dOq5HTbuhmkVCvi8Ms9OrRl9lQU2Yg3gjU6RffeHBYkwp2PwZU
         WlWFl4tctaPl1xHhm+oEVMfjcij2fqhH6+dtFxeClMXBhr/lxgKR7/2KmPsrUvebX0ya
         kM97zTJzxBD9ySoifZP2ibkcgy08N0Fj4NddCFbBdgm/O0ZsxSM9qWdkvXiTEnald7v2
         uqpRQRO7KGhOO1hI1ePaD1JeXJ+5HsXUJSgH3CBnxvqSKlGHfBxun1VsekjszvbyWUnJ
         PTUA==
X-Gm-Message-State: AOJu0YwGLujNdeb57qlAdXeKvIHLHhIRZEgzkiY+ovF6UuWmhihtOJVz
	RgLG9YT94vHuHk7VWRpHyY2drnEzXs4f133NZR/cH1+FOpOpFbhneOV3HBgfvxWj994=
X-Gm-Gg: AfdE7cmKH4wARzipWMH6ggu2a8cWKNkNZZbfMZJb7fEAVPfT2sMPzIo6L8gFG9SzcxP
	6wMbIcJQe9/XUraKeffPB7fSA2R2NGoA2OQnTLb33K9uoPv0s0m4xkaqpk3yvf2f/RgM3oVsfBq
	aQvOFLROlXSrsG6XFoZkLCdvi9MVIcXuQtrbl5KiO12NXf8bZXsaw7ebC2l/PL1pJHOn+Zevn3K
	x1csMC6MNQ0q2I3/Jf4I/2AHQ9QA4hoQvgIN4/M+2kvYbzGiyArb9MBpEVa1Dv8AOpf+4yg5QJy
	6+5gOJN0MfiobruekSCaHlReQt/dyuR1okexA/ucQV5C5hd5DNhVmogdoYAw6v/z+jJnvl1Z/sS
	m1GtGzixi3VYDf23BUM942/sD1yhKetYRVq7Wia5Gy509KRFoSZenNi7QStwrgTOlBo+7Gj//eq
	bGy1Fn24WXNTw4Zg==
X-Received: by 2002:a17:906:ee8a:b0:bf0:550:d9f with SMTP id a640c23a62f3a-c107eec8930mr398905466b.31.1782293825500;
        Wed, 24 Jun 2026 02:37:05 -0700 (PDT)
Received: from aartix.localdomain ([151.19.235.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd44d0sm806906a12.29.2026.06.24.02.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:37:04 -0700 (PDT)
From: Antonio De Stefani <antonio.destefani08@gmail.com>
To: git@vger.kernel.org
Cc: Antonio De Stefani <antonio.destefani08@gmail.com>
Subject: [PATCH] gpg-interface: fix strip_cr_before_lf to only remove CR before LF
Date: Wed, 24 Jun 2026 11:36:18 +0200
Message-ID: <20260624093618.17456-1-antonio.destefani08@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c4adea82 (Convert CR/LF to LF in tag signatures, 2008-07-11)
introduced CR stripping for GPG output on Windows, but intentionally
stripped all CR characters unconditionally to "keep the code simpler",
even though only \r\n sequences (Windows line endings) needed to be
normalized. 2f47eae2 (Split GPG interface into its own helper library,
2011-09-07) moved the code into gpg-interface.c, and 29b31577 (ssh
signing: add ssh key format and signing code, 2021-09-10) extracted
it into the remove_cr_after() helper when adding SSH signing support.

The original laziness was safe at the time because lone CR characters
are not expected in GPG signature output. However, the NEEDSWORK
comment left by a previous reader correctly identified that only
\r\n pairs should be stripped, not lone \r characters.

Fix the loop to skip \r only when immediately followed by \n, keeping
lone trailing CR characters intact. Rename the function to
strip_cr_before_lf to reflect its corrected behavior, and update
both call sites and their comments accordingly.

Signed-off-by: Antonio De Stefani <antonio.destefani08@gmail.com>
---
 gpg-interface.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index dafd5371fa..95abf1ef4e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -990,21 +990,18 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 	return ret;
 }
 
-/*
- * Strip CR from the line endings, in case we are on Windows.
- * NEEDSWORK: make it trim only CRs before LFs and rename
- */
-static void remove_cr_after(struct strbuf *buffer, size_t offset)
+/* Strip CR before LF from the line endings, in case we are on Windows. */
+static void strip_cr_before_lf(struct strbuf *buffer, size_t offset)
 {
 	size_t i, j;
 
 	for (i = j = offset; i < buffer->len; i++) {
-		if (buffer->buf[i] != '\r') {
-			if (i != j)
-				buffer->buf[j] = buffer->buf[i];
-			j++;
-		}
+		if (buffer->buf[i] == '\r' &&
+		    i + 1 < buffer->len && buffer->buf[i + 1] == '\n')
+			continue;
+		buffer->buf[j++] = buffer->buf[i];
 	}
+
 	strbuf_setlen(buffer, j);
 }
 
@@ -1049,8 +1046,8 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 	}
 	strbuf_release(&gpg_status);
 
-	/* Strip CR from the line endings, in case we are on Windows. */
-	remove_cr_after(signature, bottom);
+	/* Strip CR before LF from the line endings, in case we are on Windows. */
+	strip_cr_before_lf(signature, bottom);
 
 	return 0;
 }
@@ -1136,8 +1133,8 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 			ssh_signature_filename.buf);
 		goto out;
 	}
-	/* Strip CR from the line endings, in case we are on Windows. */
-	remove_cr_after(signature, bottom);
+	/* Strip CR before LF from the line endings, in case we are on Windows. */
+	strip_cr_before_lf(signature, bottom);
 
 out:
 	if (key_file)
-- 
2.54.0

