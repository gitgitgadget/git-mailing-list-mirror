Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8921128A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074018; cv=none; b=sXsAP33qwRgH6pnvQ11Yk3+0kKltDS0o1nmpfsIoo/deMfC2HWhHlALic7/2YdkMFNxkdQ63MN7cVRUlRpwUTKqPjJrZbaNTdem66e9my2dhNxc9uhM+K0ii/JZIXxUiHt7XGiPzO8vxd4H1TpauKOGs2MtCSwYwarzYvy7F740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074018; c=relaxed/simple;
	bh=jMxSi78Ou42dqiV64yEbnYTH/R9O8cbltEOgjGxX5Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZ0APh6DTLFQtaIAICnNka78xP4xdeOsIq7MTlcE4qfgFx2NnNnL6qxnt9c/HTSBum44MuSa12hap7/IQ+NvVt9HY82iLOTpouf16bDfupBJs6VVKJLhrQmBZ7TFsdYH32UgMGUc+jIiCJiFN6wvd21LIb4/x4Z8wxZrpqAt4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0JpwHGb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0JpwHGb"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so1388449a12.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074013; x=1743678813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc65zLz9YYweJmOCsYLVTRRerGukoX4aoY+eAYY8QkM=;
        b=X0JpwHGbN9sE2pa1aZsBLjlDAxwxjTPxKBggJUmD9ZL4y86sA6+hHu5RKWtEDYEI5R
         L5v0st7ovcWLW31baQqUMH6hrDfPWP6DLSPII90hr/Uj4VpKqeDwcz3KhC2uucXrbTcn
         gYvSe+BIlNDlWdelaEcerSgJ/QZ9kKdEEVo6u3ysYS6ZFTXfjsYvmwLetbynsqXk31Pz
         gfFaWDsyfNYottbqZLtWUPLSC/zLNEH5rISnDv+grJVZAJvAzxmM/1H0a+eh+9z4Y2Zw
         KyByDHhZSlNbEvm6fVK2fqg53Cw+juJHfQ4GDHiJ8pEYveOmvnyFnlCiGI/gkR1GG/mg
         HIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074013; x=1743678813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc65zLz9YYweJmOCsYLVTRRerGukoX4aoY+eAYY8QkM=;
        b=aU53ttDiizKMVoKZBephXH4DMZXFVddm0y6osqZn1CdkC2hW2WdeDKzce8SmhLpLxo
         7jiowX4vgsWQwVwQj8DuhHg8aRgrjypNqSUvMovdwBkoR3J5a36T47RgaYkJmHxHiyH0
         kpdxxJwLIOGaybRbB+2EyjiqcxWfWv8LF5pGPusSkzGHPY4Jb1EBks84G6p0XmxIJru8
         KdHd9rd/TpEvWz80sFgYPTQLiydJRyvssz3FTtem3pZXSQdiO50ndJls5dXGcTZWsMhA
         1lWzqKW/EtAFkkEySMqofpACv424SbB5SxKR0FE8acJbg+cKHz8FltNbILsb8tBjbf0O
         OIwA==
X-Gm-Message-State: AOJu0YxR6GkwA/aPUYOgPHPvC9qGkvxMYzUHuOQMj+UPzfvvYmAcVQ/N
	M33C1rIfl4rb46Gj4y4NQ5txJSGky6nijlA+OskO3AKdYetxCUSf
X-Gm-Gg: ASbGnctymaUS+zgToYMbimGOi8HQ5SjxtPEXsyH3tjKIDprIqFU32mlibxOzMZ3OItp
	SKxfQl2ZTMo0J/PGBooqMhuqZOjau/XIbUJ8iHzlN2gagYf0xoC0KaWuAK3pHAl6f2SEYlivoQF
	urPKB1fDUhchtCkpiJOwtE8rywkimnBjF9W4qiyp27WrTpG8fHESP4GZ85OpycCdgFvFMU/vbZF
	j81XHLr/I4WXxKQlaTpHFG/tFBfiNYl5l0wb+IL9tXYHX+DHUwcayaRoOO6Dx3TBMCur1CH7hHm
	kCx4q1mZnBp7MmdGU6lmJn/yLcPJvlmn9nGG6YeKUkzgt28=
X-Google-Smtp-Source: AGHT+IGBraxQomCaERa6v73yyo/J/fum5th/+k2uNmtnfqKZQhbwi0drbAujk7sC0/Itm0yj5JxHjQ==
X-Received: by 2002:a17:907:c0f:b0:ac1:de84:dec0 with SMTP id a640c23a62f3a-ac6faf03b6emr268451766b.26.1743074013372;
        Thu, 27 Mar 2025 04:13:33 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:27 +0100
Subject: [PATCH v5 3/8] refs/files: remove duplicate duplicates check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-3-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jMxSi78Ou42dqiV64yEbnYTH/R9O8cbltEOgjGxX5Bw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMthL/8OfJR+EuErdWEIgjsFr88mf486q0
 /tlyA0Ow9uqRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLYAAoJED7VnySO
 Rox/PfwMAKN3iMYOLtnY8FrDS5VbyhhqqCwJaY6P7+yNMc5S4mU1JUQ5XP5bc+vm/guguq25fi+
 mzuEPtKNPMZ+PnrkauhJyXkyZHkd2+NCCbBWREP4p0CrXa5c1cMyyGfPeOhRQrI/0//TrpemwYE
 0va4SOCvaTSLenEg+ScxHQtvEdSsH9zuSXE1a5seFI0S7PMAd7pUUYQXMMGUu55XPCgJ1S6kuaa
 RDKvIXrCQ4TNLRPRntsg7U52E9MoLRkTV/qgzBFSG9EFZBlUOktynLemmv8S9pYzvAqSLiZ1tYK
 r88M7K1mZkRjc39ea6PfpuQ05MUJE7qfxivVMO9u3Xo5rHK0MOAn2TbmnXOxX1XLwok9SiERya1
 /HM9JzEITIKhnrSp/QTG3LeoHuldSv8R4cw4lKpW//P0F2srcgUO3o5/IFHkq7yDbV8oPM7+oeF
 JcA0byKLIK7hWNFU5bovDs+sNigKQLOtXQlDhdDbp5O0X1PXv9sGIvpl4JFYFyAfSKJCBDby2J6
 p4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Within the files reference backend's transaction's 'finish' phase, a
verification step is currently performed wherein the refnames list is
sorted and examined for multiple updates targeting the same refname.

It has been observed that this verification is redundant, as an
identical check is already executed during the transaction's 'prepare'
stage. Since the refnames list remains unmodified following the
'prepare' stage, this secondary verification can be safely eliminated.

The duplicate check has been removed accordingly, and the
`ref_update_reject_duplicates()` function has been marked as static, as
its usage is now confined to 'refs.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 9 +++++++--
 refs/files-backend.c | 6 ------
 refs/refs-internal.h | 8 --------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 504bf2063e..61bed9672a 100644
--- a/refs.c
+++ b/refs.c
@@ -2303,8 +2303,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 	return ret;
 }
 
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err)
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+static int ref_update_reject_duplicates(struct string_list *refnames,
+					struct strbuf *err)
 {
 	size_t i, n = refnames->nr;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 58f62ea8a3..ea023a59fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3016,12 +3016,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	string_list_sort(&transaction->refnames);
-	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92db793026..6d3770d0cc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -142,14 +142,6 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
-/*
- * Write an error to `err` and return a nonzero value iff the same
- * refname appears multiple times in `refnames`. `refnames` must be
- * sorted on entry to this function.
- */
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err);
-
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify

-- 
2.48.1

