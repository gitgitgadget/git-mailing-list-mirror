Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E5351C1E
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204344; cv=none; b=R1MSsOSp8N313vlqNA8MDAM1nAPU/jl3XK58bm5r3B7q/avvohEadRKGpks/Bakl0cTcxECh0wnt7AI92y5oHZexSJr2XuSn8H5iOCLv/3BlipWN8Qc0kpJj2mW4pvfXwRMt9k6MxMkbm1RNq9DkRb845v6RFB5cMetwzzKtf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204344; c=relaxed/simple;
	bh=fntHSo/NL5VUv8EwKpWC4xhWKbLFkB4VYVLL1eaAgB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmcccwMVcQCz3707/5urz9H4pJg2E0vUoH7BPXe7EIgPHREtZ2wFlWiNWoTQuLP97etrvijcz+Duui5pIZsFnVtaAlbzksICX3WbXMN5ZiVW3VDtO7cjXF1Q4F/od42qsLewmJUn1VNqXyzqmY79735VviD5SHZfDLVfcMpX3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esu6CXeS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esu6CXeS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c029505b389so137395966b.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782204342; x=1782809142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f48tQZT5fXVhwVeTVZYq3IVdJhaPeiQaK+Vs7UZptDQ=;
        b=esu6CXeSSihFivTA250Fo3b65OuJ0fv/KrU6HON0WsYrsDkFRUAZUEOaglpmaxdiSG
         d/tG6s4FpadsFYTx5bwrhmsSl0J1O58JfYaInm5WG1wj/3dS9a+WdL6LnELMVS7mLKBQ
         sex7RrsEsgH9+0eGtW0nyFCN4RQd8MynokuZ2zYpmEt11o9C5qGGfiY9UlcoopVA92qe
         0lpnvomPFhlP4KcNZGDg+Gt5akEvMZjPoWJu7Py6B93zdFUoNmizm6ic5TzCXErry4Vk
         8OplTLw1HY/ubErbWZxvCr7yijQ/3Iv4RhzUm5oEx3Uv6WE8rohPahZSqk37W0tPEzYR
         rkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204342; x=1782809142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f48tQZT5fXVhwVeTVZYq3IVdJhaPeiQaK+Vs7UZptDQ=;
        b=RNbpstElVCoxZ+Xfmm54ZNn0MXKeiu0V7SJZBdzdESJS27ofPICVrk9dJfkJD5IJLK
         A14mkJko87HBcl925FsU/l4B2Q3dYyxAdR+mTe8TZqXdBcWsjVkpX332RZKZEMTvWbeI
         XVYTaoUvcmNv1BHMTsC7/eH/YzDbVlAwsWK72DM+o5u34TWQSfG1bq7czid4fkC7AF84
         ekbHBh6aPX6621HXyb6PgKgdzKOuTIBDTPt39iM+dZ0vfMeaEV1rOBhL9vd+P7RFhDP4
         R+hiVKbLIKp6IyJY/ShVkZZCrrL4EiAuP+Y1sN0JJmcgl4RqUulzl1e0Dscyr3pURtNp
         U1aw==
X-Gm-Message-State: AOJu0Yy+OEUTwHHs9+PU9GV/mUvNhrGoKwG2zhDLmvcIGsiilMkVEKsO
	xZ48k0oMotwfLybRdJX6onLw5QyJjNqJ+IRlQv/+mz32fUU6s0OiLs5utXvqaQ==
X-Gm-Gg: AfdE7clhqnrrNOz4OeDRu4Cov01MUQoB/uw2x2lH660m2JOl8lP19qj3zbf0td9pz8T
	8nlCElN5JMgCavrcLHjdhVlQyRgBCHaP4MRCdtqdAvingeGj75qCzO2kRF9ArgVEwUWAGa8PuON
	cZecPsLKIOE2z62oBhj0LuCDdqSLiNlnq73uMhRp679QkKUsqURVJT9I4hqL0uJqDBrU5+RiCJQ
	QoOgQcgiDUNhzh305v4uQ6+27+Y3R3OPAxRBFA0KaYepNG0kALeyELkbsglmalox5YkkPsozcIr
	TgifuZ6ys2CH6Mqgp/iYsOZm/h7BOdFpMMMUPriZy82isKczx/tzxgJTrQHpDxZ3Nwt46CCXBVE
	oFnKZ4A7GMBqlMn7BcQde/sx1R9hudsbLG+IxG2MwJGnEGaWiEBJ1sxid+f/ytg0T3mCcj5LXiv
	Psrx2nYBy7g4Z/IoVWZrk1cgTWBpcQcr6ym6CMusc=
X-Received: by 2002:a17:907:72c7:b0:c0e:7f2a:ee96 with SMTP id a640c23a62f3a-c103158cdd0mr147156766b.29.1782204341241;
        Tue, 23 Jun 2026 01:45:41 -0700 (PDT)
Received: from aartix.localdomain ([2a02:b121:8f26:12a7:759a:c0f7:6fdb:5565])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ee6a85sm480151166b.43.2026.06.23.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:45:40 -0700 (PDT)
From: DSAntonio08 <antonio.destefani08@gmail.com>
To: git@vger.kernel.org
Cc: DSAntonio08 <antonio.destefani08@gmail.com>
Subject: [PATCH] gpg-interface: fix strip_cr_before_lf to only remove CR before LF
Date: Tue, 23 Jun 2026 10:45:20 +0200
Message-ID: <20260623084520.9015-1-antonio.destefani08@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remove_cr_after() function was stripping all CR characters
unconditionally, even lone \r not followed by \n. This is incorrect
as only \r\n sequences (Windows line endings) should be normalized.

Fix the loop condition to skip \r only when immediately followed by
\n, and rename the function to strip_cr_before_lf to reflect its
actual behavior. Update both call sites and their comments accordingly.
---
 gpg-interface.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index dafd5371fa..87ae6503da 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -989,17 +989,13 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 	free(keyid_to_free);
 	return ret;
 }
-
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
+		if (buffer->buf[i] != '\r' || (i + 1 < buffer->len && buffer->buf[i + 1] != '\n')) {
 			if (i != j)
 				buffer->buf[j] = buffer->buf[i];
 			j++;
@@ -1049,8 +1045,8 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 	}
 	strbuf_release(&gpg_status);
 
-	/* Strip CR from the line endings, in case we are on Windows. */
-	remove_cr_after(signature, bottom);
+	/* Strip CR before LF from the line endings, in case we are on Windows. */
+	strip_cr_before_lf(signature, bottom);
 
 	return 0;
 }
@@ -1136,8 +1132,8 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
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

