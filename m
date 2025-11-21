Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24212FBDEE
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723634; cv=none; b=hRZISKm4PYjhzu5CEnSNsMUiZEqMaU2xSOeAwPVLbKrZfcN9Xdi80007AgmLW0S4TjZHwRKd/w2rDlDfOT4PPF/FHWDTuvsjDhgTAOb9lK0TRxx9c2ocHMCO9+4i5J1HkX0Ci3VpVKs403FysQpgMWPfIMy7cvoqdI/R0ZOgip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723634; c=relaxed/simple;
	bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evJJQwGGvLK8hMYsHBP1wkg8O/h3KHa+IUGGE7h/nrx7nghVBCI5oxXxDFGYmG0tDndXi2lmNn0o5dSj9R8r4ZM+d5n8pCSNNOvGBUqlfl4VVp5rUF+aR18kuw8rhZO4N8RZr/9UinP8DmlGcGmwfR0bzpLOfbe6Hkvl4ibJtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fICfuOpD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fICfuOpD"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b472842981fso237534366b.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723630; x=1764328430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=fICfuOpDUfwnhRKZFBRnmDToM3Jzr8UpItgGSxyyf1BmV2W+EqnJgrQSOYCJzMv/pD
         B9lR5kqsogGAB0DRWnk7V/JE3QbnzEr1mhfR4TuS04L8q9gk3Uu/Q6fhtpu4clRWN8Aq
         F83CUWAeBOeF8/L6G0NsvtktD1mK6x87Yy43YxZ6RdLLdmIxVLFY0fQGxp+PxlsI6vhx
         0gJYRgIS2TBWyVxU9w9UmyEXHfFmQtO8ux8U30XY0dEiPkD8lSWLMncpehqpxzmW2gzk
         K+P9k/fqEuEyE90L2s2Ut7TdiMy9HdXtyAzP3eGnXB+giclJRcpWtjdYmSSF+MrEnXlc
         9fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723630; x=1764328430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=H0ZsiZ/SL/2e0BKEdtb/uyfiOq+rwZDI284frHjgbu8rd+AkSlehIy2Dm2IOx2qLWX
         taCCym2OPf6pGdGa6E3COhjiuW6cI2g9LRykNJv4dgOq/vdh76XHYlO47nqEPKMH5LnY
         Sr1KX5ql0xE3SUGfQSqQimdL9rMww6PuQPgfLffNcOtjyGj7Q0A4XjHoralqUuUEz5W0
         njz91g5UE1ZqB/FG75zaEO+DXM7pGBFDmYQGT59wTy3b/7NgOMLp5jQVXtbj282JGoc8
         mDRbhubPLNhFWWRxDu5x+eA++tcnqA14L5xRXYToI2/bLMiRSuGJhdaWTBIVGhiEt/DK
         k0Hg==
X-Gm-Message-State: AOJu0Yze1FbwJG3LrwryHCt2sVj/cNVcw6X0cGtFs5rIOZZsJe4tNvG/
	qdFEHQKLJn1uIWwibNtVmTvRqyufTZnoQELGY07AOCMHVaC/QApcOHhB
X-Gm-Gg: ASbGnctIMNlPtmhwwW7wOL3/Ygn+cKReU/eXYNr2Frl/dA7ON1JM3O4gv9Zy7IsEqXa
	f7GS1dpFaWAh3jYr6a8yytnbbHKVdqVR/94CU6NBJHKe96hmuEOoZbkfhvsFQHQ/SPLSsvHQTb9
	a1YyVWyd2C/2p06pdLw1e81x1nsawYuuF+gDrzL383X4A/uJ7l62g47Bl4/y8wo3g1who25ceLj
	LubBCEDagYZlZFR8LuvDGAGjomstY1V+iSOHKDROGTCzpjqCNpSrt/FtW4U/5dhpbKlu1NIhFy8
	y55NgVw40DealoXXqjqR0kiKymGTbdla8BSKEU4OKhtz4RRif/6YzB5wZD5F6HsOwWLDMIhChH0
	fB9iWsbyCKLA+v93Bvi6AxBhd87yuJwJmYWgqHK+krqKkhsiORi60b1h2d4/qZ6RfRIB7wiqzLI
	aGIQ4ODKyvb/gh95j/KHs=
X-Google-Smtp-Source: AGHT+IF5xdW8dCt1aypy3eL4394HpyebHRI31JFbUOuGbaVbxlBS/V/PPwNf1X/93SDusJXGNPioBQ==
X-Received: by 2002:a17:907:72c6:b0:b73:8759:62f6 with SMTP id a640c23a62f3a-b7671a52051mr213704366b.60.1763723629810;
        Fri, 21 Nov 2025 03:13:49 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:be79:897c:7a92:76c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm436206166b.4.2025.11.21.03.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:13:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 21 Nov 2025 12:13:45 +0100
Subject: [PATCH v8 1/3] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-fix-tags-not-fetching-v8-1-23b53a8a8334@gmail.com>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
In-Reply-To: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkgSWthpFhYk7k2F/xjwaDT3g61hP+obbNva
 V5GajUSqzonTYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpIElrAAoJED7VnySO
 Rox/IeoL/jv7uRhuL4/kgEVO+o3KSp59ruH1XtOqvUOrJxTAwBIYrg3N2kXqwnf4aRh2kbryoA/
 /TziQjCZIAQcRV2KOOO0aCrFQnExCOzFBkjXfgkNgcvnqyy0oxf97s8lSD7mzPxd//+F+jWlgUy
 NXzLR3l/3JuOk/amv2Wubx2+OoLgTVTrR7ghtFdhgqdJ6ReWqCLZWZsMZHvz15Q5Lb9XuGDpQdH
 yJdjzy2mxwDfaOSr9EovdJgXry4+mU4PhcqDuu7py3KVyXxYe5oAIhLCzZcNwF5M1uDQDXKl5yB
 5Pa3Qe2sx9OV6Hp1dMDfrVi/JvAZUPMXM/1sNs5J5G0DxMVrc1oE+YUbiqYyW7k+BrQ6LEobE7w
 P7OTezTQ1u5L0QB0R9qZpUZz5xE5mQiI9pkXfeTi+Ol3pVWg9AAW2cVmwwJT9COnCQX48l9noZ7
 ZPwRjzAnvjn4Oi2J0nbGeSI99Q6bRp87W7G+JU/xm5noX2v4ao7B6D43yjI+KpRyE2x6ViM+NM5
 /0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `do_fetch()` function contains the core of the `git-fetch(1)` logic.
Part of this is to fetch and store references. This is done by

  1. Creating a reference transaction (non-atomic mode uses batched
     updates).
  2. Adding individual reference updates to the transaction.
  3. Committing the transaction.
  4. When using batched updates, handling the rejected updates.

The following commit, will fix a bug wherein fetching tags with
conflicts was causing other reference updates to fail. Fixing this
requires utilizing this logic in different regions of the function.

In preparation of the follow up commit, extract the committing and
rejection handling logic into a separate function called
`commit_ref_transaction()`.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 59 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..f90179040b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,36 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+/*
+ * Commit the reference transaction. If it isn't an atomic transaction, handle
+ * rejected updates as part of using batched updates.
+ */
+static int commit_ref_transaction(struct ref_transaction **transaction,
+				  bool is_atomic, const char *remote_name,
+				  struct strbuf *err)
+{
+	int retcode = ref_transaction_commit(*transaction, err);
+	if (retcode)
+		goto out;
+
+	if (!is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+	}
+
+out:
+	ref_transaction_free(*transaction);
+	*transaction = NULL;
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1858,33 +1888,10 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = ref_transaction_commit(transaction, &err);
-	if (retcode) {
-		/*
-		 * Explicitly handle transaction cleanup to avoid
-		 * aborting an already closed transaction.
-		 */
-		ref_transaction_free(transaction);
-		transaction = NULL;
+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
+					 transport->remote->name, &err);
+	if (retcode)
 		goto cleanup;
-	}
-
-	if (!atomic_fetch) {
-		struct ref_rejection_data data = {
-			.retcode = &retcode,
-			.conflict_msg_shown = 0,
-			.remote_name = transport->remote->name,
-		};
-
-		ref_transaction_for_each_rejected_update(transaction,
-							 ref_transaction_rejection_handler,
-							 &data);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
-			goto cleanup;
-		}
-	}
 
 	commit_fetch_head(&fetch_head);
 

-- 
2.51.2

