Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180C3B6344
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286544; cv=none; b=bkWR5s0fysuP0QNXk6l/zzBTXSYOhDXwICqTyF4dDCrlHYwuIO0g4yJdZ+6jhI0rE9t9mRxSS51iLmZpzrjUSSv+KCOtVMx1vqQWAcNZuj6DPwrt8O9M+tdqIgeFP/feiCykHF4ZNOZvsafTnPwNQpl2cDv+U5EKq9CFq7rM2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286544; c=relaxed/simple;
	bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ztq20oriyQ+phMehoKjUm4SR8PV3hMK04rYplxiZyGj7qwccSjDv0XkeuoYVnSQiS9xcy/CXGeKvWyud6WRmoDRHBGK1H0xFgSloOUSULISUS8FKzFVknlAfDX7mpj4B4/kthBEwwaQEFl05+hYottY3qz6gA6fLcAwkM8goCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNsuiIyy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNsuiIyy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5504230f8f.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286541; x=1777891341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=dNsuiIyy4yTEt3j9lkAdgGeYalhvNyV3APCt3zfq30OawFO4zzT51rukUtNTyHOxGV
         Mk6T/FjBHW7EDtVqY/LHQ9Uhh6todFJtBHPubqHfsmibg2hlx2nh1+lrMfmXJ++xZ/Xa
         XT+knp3uoAf6Rs7UklqTTXr4Gjlmk+lduLPzkQWmeCVzgHcsD17YcUO+5TS+A81zM90q
         NRHvbL/KiZq/+SvLKWWfhOg27ixe5/FFsfE3giviIPizjdn4AMmseDzX/0MaFLcPCAP5
         +KsT+5QmAOOwfjU0bbJKgG0Sw0mdPXIPfQvdREaVAwRLdJPWDXyVnZNVB4cbCiJTJBa8
         Ep1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286541; x=1777891341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=cwpevpe0joZgAnoGo+bdE8okvzDlGW0XjK2jXQDkF2ppYlkdu7DA9EN9DF9OTSfMFR
         iiDGUtPrRQQThvqHVGGcsFT2CJOZTAUwl1ben3JwryPAhBbk85ktIT2wNkx1Eod3ClWb
         mX86lTZs17Wh2QINVqz+F0LuYljRL66X3JL27pK7LPgvoq5hrdF6j6X7b9A4iXRmVRYl
         sCNWnhz6PtsCF+cQBchGrTXNXlr5DKFVTys5OA8r283mdY/ekLnkOoK8eVUDYsKzwml0
         XtyjjRz1m3zjdHOFN66is0E0hCvCohSuJj8Q2FtSP6l8ZsYrIeoWUfYVH36j5MYS3BpS
         gA7w==
X-Gm-Message-State: AOJu0Yy5kph2EzllXSiCc27gmKqaYkvnVXBI61fo/Q5abIV0RiH1s6DQ
	uRSJCQiTuOicknocM0y6hKfxor0e96ySzmzNK0YoDjpTqbsMOYML1m0I4x+nGw==
X-Gm-Gg: AeBDieuISSRCT/eQnPIimwWjWynJxNpwPZLESZjVBU6fr1TNDTd/90/plcGQS4CXI2p
	t0x5ljfwUJUnylfTFLRYvV9L8MBzE8YCv/T09zfUrZ6yaVgVl+Wv+BmKN+xUiWJ/4MNOEawAvNw
	Q4hP9pa+cBmP6HiYdRfslGY8Uh0ArJqxvu9tD1t77mzC2e4ikCncoUx4ztbZr3f0yJQ4nIRY1Rv
	B2RcijiP0tOwnw2bI22F7o3ffdJEIbn7H6usZz7HE8/nv4z73JG6Zwbzuk8lSNJ+isAyxSFJEsF
	wdvjGmrWk4n0BlhxR1cXuYEtdINhZ9W0NCqsP4/OTLdT3B3fHhaQi/QnW2TN8p+/qeLsftEZ8H9
	QlLp+UqDma7tbzGSweV+2ScTXrNfowNmj1mFgm6irdInHqrvq6PWKvI6FuwUbUZ7pOK981WTlAq
	tW/O126nQjv1AeYlin3AH9G/IJLD0vqSwXl16u2+le
X-Received: by 2002:a05:6000:1785:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-43fe3dbf4e7mr64909297f8f.20.1777286541085;
        Mon, 27 Apr 2026 03:42:21 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:10 +0200
Subject: [PATCH v3 9/9] refs: use peeled tag values in reference backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-9-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPYHXrht7lbxhJntum48IHm36j9ZodXq1n
 UJMH3GwRCT3nIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z2BAAoJED7VnySO
 Rox/SjkL/RzmXmLPV42JKKrMJgMiEe0q4LhIo8Udap2WLEFm2wG6q6LOejGRshwtGF9mbXY4il6
 sJsPuH89ZK5aHc9wqOqeLlofIYLaOfJTk5OpIze9PcG607+JAtdPGow4BQOTdcf77kJS/x/B/3G
 F6kxJVmkJnXXoZvbp14FOK6ktT9/RqfMqX2JexpXCytmY0V6fS6I6CZCufg+J4Ih/7PtEZEA+oz
 x97EIC1NP8J23BUn9N8LdCLiav+MM/rdqGuIUitBYMuu7ZXr4uROZMHJjyK8JoX7OXWAhejwPP1
 SSPEzxPa+M46Uy0kDWgIGlIUUbBZt+uW6wSWSRxAS0xrP5UBg/7Mbd7fbsnB/ZDFzv0BwoWFP9b
 li7TB0AJslfPKlCPtli2/BD5QzlHSONlREmZZm+81/aqDT4M6FAmooy0VrJF+ehSbYZfevATa0o
 oHdW5lslsqB9ju3V+ZSGx18FkUAJ5uIAZpvQrYTPmsG060uYKjlDxM7pmNUqat2IfrUmlMcLon7
 Hg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends peel tag objects when storing references to them.
This is to provide optimized reads which avoids hitting the odb. The
previous commits ensures that the peeled value is now propagated via the
generic layer. So modify the packed and reftable backend to directly use
this value instead of calling `peel_object()` independently.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/packed-backend.c   | 6 ++----
 refs/reftable-backend.c | 9 ++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 35a0f32e1c..0acde48c45 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1531,13 +1531,11 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 			 */
 			i++;
 		} else {
-			struct object_id peeled;
-			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
+			bool peeled = update->flags & REF_HAVE_PEELED;
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
-					       peel_error ? NULL : &peeled))
+					       peeled ? &update->peeled : NULL))
 				goto write_error;
 
 			i++;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b0c010387d..8b4ac2e618 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -12,7 +12,6 @@
 #include "../hex.h"
 #include "../ident.h"
 #include "../iterator.h"
-#include "../object.h"
 #include "../parse.h"
 #include "../path.h"
 #include "../refs.h"
@@ -1584,17 +1583,13 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				goto done;
 		} else if (u->flags & REF_HAVE_NEW) {
 			struct reftable_ref_record ref = {0};
-			struct object_id peeled;
-			int peel_error;
 
 			ref.refname = (char *)u->refname;
 			ref.update_index = ts;
 
-			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled,
-						 PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
-			if (!peel_error) {
+			if (u->flags & REF_HAVE_PEELED) {
 				ref.value_type = REFTABLE_REF_VAL2;
-				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
+				memcpy(ref.value.val2.target_value, u->peeled.hash, GIT_MAX_RAWSZ);
 				memcpy(ref.value.val2.value, u->new_oid.hash, GIT_MAX_RAWSZ);
 			} else if (!is_null_oid(&u->new_oid)) {
 				ref.value_type = REFTABLE_REF_VAL1;

-- 
2.53.GIT

