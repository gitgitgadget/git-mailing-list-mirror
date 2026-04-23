Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B353DF003
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933647; cv=none; b=mMnS7vjPgpYI/jfu22Xq4wenum/YpHoS07q/ANbv1lzL1neZaRHzfGB02gbLEsBpPqZ6mcudxH/kB5cRIPt+B7jnzWfAdVHel6pxYU4Uz4bHx6Yh28UVfORf0CkrF2ZXK2C3IU4jAMdsj9sl47ZFzQHFVv9EXsKjZJDi7QrbeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933647; c=relaxed/simple;
	bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbCA8WM2JtbTWfB4aTD2YkUI/YU/HTenDajeoegG5m9xevhDh/0QkG+qBkBzCEqD/IcwzWsXAQ6ozwJIPx8CwY5bL6mRk9m6ppLhi5KMzDE9jOpQQMRSUSsKcH7g09sSBluXQiRDB+fiTUI8V8Y5pV7H9BbgQCB3P3DY38Df/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSyOjRjd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSyOjRjd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso65080975e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933644; x=1777538444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=eSyOjRjdzEtlX5gaY1vwT0tvHYd4vqhvxNZJf0OsZxGXrSXtdmWYwLu6RrJaOzeeAM
         2JRHSr+7TMQVjWzGN6cxRQ34r/euO4ZITWaPMpl0haXvI+hJnl3tsiOIB9LapkhaWtKU
         lT4c7R6eURDSr435t0dyexJLBDH3Cj1GGDIvAAgeVySGLaW+W7xVQGlJIXpe06ummw/I
         d3EauZe/nuTq97G5R59EHggqSey41aUXZjqycmfI99uXqAImno8Z+PzgMeZnZNUYIdje
         K6i/GSN/9r8GkvAO4gBuyiTUq4wl3FVRfknYzUR8qWbeKnrgIYgmqs224ktRjS3eROdN
         a4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933644; x=1777538444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=iw9lAbdW2HOHaFdNMcahlbl6p1ISuCWAHXL5R/MhidszyjDo+6Pv+oElHQHhR+TtzL
         jLM9+g0ri6lOyf0JaR24JTXChw/UcdoGaPJd6x9DxaKW0/gcDIHlZQKfuLIjFdHybju2
         XlYPo1Hq4e/7QIZYgVuQNl+HS/LuxvfJbvow6ES1D+H4V6iG2wtVRhzTDXY6ERxxhUYo
         i5pN3G35l9G4wkIfldjmJji5IBa6CuWew37AWcQWoajjTBiqmoDlazW19f+PH5U/NML8
         yHtQp+Rjhlr+nPltl/4V60CS63lLFJUI+hArWsq5oEjo7kEK7E9MEAFKGdDDmTgtU9sO
         Z7WQ==
X-Gm-Message-State: AOJu0YzCgVBi0K/azvG+Rxtwur4g3NwXFbyJlvGkhhtqQYDnWca3nqxv
	YJa2Ag2y5JqXx5n+35S/keQXlGUmGeCG7KSttGJrXtow87zbUA/mNXh8zE3Eyg==
X-Gm-Gg: AeBDies3XZXtKvadsg+h/zHTrKKj84TzQeEZBiDVaPJ7pswe+vp+qQtBEEKHIal89qf
	PiVoqlTHV/08pKVgaAGL3fyEDxqgeivKvHbZrvkAZSXurw+5zXL/pjkME5Wi6BwvLRCTqBwSRjL
	jnMynvjV9ViSucjYOiPmYvv6m2OsjG98DTtGNBKglCPlzj9z7xGXxqmjSPAm8F0hi3ZtRPa4oI9
	7EYeNm86VRtnhEGDVIB+x764AWtuZ0A/MzCQzZSG5iA5NfEfhdEImxwTWUix21emrQBEpYabua3
	SZ+C7k9+rO4FGwECKmt/s3A11v6kO7M+xavdMZxUfrbGNZfcRI9K4WRczTjvJkZQp0aWleVPjNQ
	/X3jjD8viyos/ZCuLNNlF1IHmCw+nLDBPkmZC6u75F48lSTFDEkXqnz8OGigcB+KpSBhEnnQEvV
	VtPaXyKO/aWOtRsa4GdfosTCNbffPODsYDEu6hByOI
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr333035165e9.12.1776933644025;
        Thu, 23 Apr 2026 01:40:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:34 +0200
Subject: [PATCH v2 5/9] update-ref: move `print_rejected_refs()` up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-5-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wTWL7DjzSAn7AkiH9d81idZiH8M9WC0a
 ZddBxVYDQvJAIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsEAAoJED7VnySO
 Rox/bnMMAJpk9191THS9OsfrAlGKyb9CnIsZYQ1f6W9vmgh/RDfJkPIpUex8pGuoK3PYpWvZEAa
 Be+p+GjPpKsE5qVm4NVqqmcB5n+snGT7jYwNspKDBwK34I/XClOehjdeJlj3koOu6DQXpdwOV+M
 C2NTrRuAU3xNBeZQSHqCl9dOF7n9veR9DyLPddxMOgebDYG7QzeVNf97ZogyLe9aFlFTNEmUJT9
 dwclEriryCfzePUzZic7YGxdw0Nzb1DAR+kdpxXx5d0h6xeoMmKPJlSRhoAcQuBXp1HNVneswGk
 Ym+khOI1vcs2bNBqlllgsziB7gaemjMvA1U68LEzD84mSYo2AjV8W/e81q2QaTbPxvfrKPlSYV0
 KTIFgzA1S7Ut3d0i244lSN1pwF8ZfhPf0/oW7GjHTkhOEo30L8LRphmj6WJOtGcSnpNRDWKpxDE
 ItdSe61osQujDrOzqMHpmCIp0L79udFweGgCxGrei0wPoLXenpd0s7czdVET3g0CSHVzEWd1935
 ZU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `print_rejected_refs()` function is used to print any rejected refs
when using git-updated-ref(1) with the '--batch-updates' option. In the
following commit, we'll need to use this function in another place, so
move the function up to avoid a separate forward declaration.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..5259cc7226 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -234,6 +234,28 @@ static int parse_next_oid(const char **next, const char *end,
 	    command, refname);
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				const char *details,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (details && *details)
+		error("%s", details);
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    ref_transaction_error_msg(err));
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
 
 /*
  * The following five parse_cmd_*() functions parse the corresponding
@@ -567,29 +589,6 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
-static void print_rejected_refs(const char *refname,
-				const struct object_id *old_oid,
-				const struct object_id *new_oid,
-				const char *old_target,
-				const char *new_target,
-				enum ref_transaction_error err,
-				const char *details,
-				void *cb_data UNUSED)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (details && *details)
-		error("%s", details);
-
-	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
-		    new_oid ? oid_to_hex(new_oid) : new_target,
-		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    ref_transaction_error_msg(err));
-
-	fwrite(sb.buf, sb.len, 1, stdout);
-	strbuf_release(&sb);
-}
-
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {

-- 
2.53.GIT

