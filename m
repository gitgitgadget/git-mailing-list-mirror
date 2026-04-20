Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672430EF95
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679959; cv=none; b=FvXHOlOeF+Gj4a56R75RpcjufOQFeDS9+uR5hZyQFxW5A9NYhQ8f0FfGsqxwPEAkC4MHvLUYggoXoQGzOeld1+owuGdV5/i+r7HXk8z9nkC7JbJExQtQNt7k785PPpryg2iNCtW1Q67Ra9ECpbpGSmjNNc1M1hI7T7+eKZihZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679959; c=relaxed/simple;
	bh=05FGBkBlZNTfFRFTIr/adq+Vdu+zX8v99qhclV1GtBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AP5LCr0LY9zqdM+DSmCh4gdyP9TCWVnynn3qH/mRNxEn2j3Vd2ZD0R8dWnxOlkunsyFUZvxK/7e9L+0V22AAHQ1PtwIIbzTx7z0aLoTDhmwrD6HQgxOR9+X5V5nBJsnJvJ5Tskd2QZ6zoHNUYXS3AKdN5ERcQOSA60aefE2oUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+qXfdsm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+qXfdsm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso21527385e9.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679956; x=1777284756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbSOHbZGK7czeHbBDa6xwbbn1f0T81rSVyyRlQ8LqnU=;
        b=h+qXfdsmT6amONpfsE6XHGII1zFlYM4QDsbDkmJhUfB13vz4KpGk2QvlN1lRImOuFe
         1E01RDlWciftdSFiRKA5eZV4Q5zyLEnbrPsmzrM0OqNoA1H+YnNWa+IWGobkgBX1hzQ5
         rhOOBJvjKtwHRUCcT/dRI7bqD2qbXOkg6W1WR/NUxI/nCrN1RUgV1hx8A40RGRc1pDKA
         DIkGkKLCAWAZtp57GzQYKEyZgdb+4AHprSg8q7a7Ojt5lcr5tJKAQmdhs0yEgNqPbOts
         o7cOY1m3W8QgzUzNeOpfwaOAjp+0Ggd3DFPq7XxDw1lS2fvvImv0xLA6xF6vlUIHmL88
         B1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679956; x=1777284756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mbSOHbZGK7czeHbBDa6xwbbn1f0T81rSVyyRlQ8LqnU=;
        b=WEsIqsM2d8WRPLzQfQIfrWfeT0+cdHPqMhaaCxQ4snLe5h9i23syyNACPHB9UlAFMP
         SZIZmp9vTEp1XpvWxxMFB7yWWrJ57kDjj1hp2fiSBM1Q4iMDY9CcNWv1Sv/Glo2QGPOO
         LCkRkRLAVbzBiZftvByW9PRsQHPE2jxDTDvugik2PJE8FNBqlh4Euth8pK39qNAqugWv
         wdeqKG7PycPCwM71rLGHKzNzos/JTIZCtLbjpyd8Wux0kZTxEn3sDpe4SujUrgY1tWc5
         eDd1rZdwvaukVT44jOTdRaBl0W9LrWStExNu2Hy9b5Arz8oB/tFqHTpkjJfGilnouYsJ
         vC3A==
X-Gm-Message-State: AOJu0Yy4Ljs0OlWR5QzQ0ofPI1s/lu6TZbweRlADoAOQQihTUydP5nfX
	GVyZT5pbf79YzT3aqfwjoEAPYbtzuTRVCrLhTyDxxZL+p/ES0ymaMYDIfCY7XA==
X-Gm-Gg: AeBDiet96FhNJIZtFimsMEmBlFewZAYv6h8vahIh6omeZ/fbd34/Td8yy80vrD8Oz5G
	TzyL/lFhT05nEsNN36HW4I3tkYBW7hjlAEt6yPEdxkmL+DBb+B0kradobduqP5bN6Ubj8Kwh7Rn
	d6GqFRSOdXFEPH5QPKkJ0h1XG6zjUujkgNaUSHZ2uJXpWVLHtWxhs8yj5idcvIJZvoFGY3cdu9A
	vhIv41I8ESCsUjvtQvpAgY4oQJoo8itoIcm4s2BAq6trI0kkfAE1apVyX3gVyfYjfSqpAGah6mA
	KDs3SDxAPMCHyaPX1/kIJO+/U1zcDhvkz0e2HdFPocmMcMoIBkaP7s456bo238eZPj2WUmhgIRD
	JoPZFqSXuCnZTMieFZ2SLAee8TcKljIYOvZVGRyuKOebSbT43GYDE8eQU8+PHNLPSADG+rdFX7t
	MfamOZ+DYfk3kGCs60IbooUkXZIhiIbAdm+NbFvcY=
X-Received: by 2002:a05:600d:8402:b0:488:ae26:435e with SMTP id 5b1f17b1804b1-488fb778d74mr141271065e9.16.1776679955641;
        Mon, 20 Apr 2026 03:12:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:06 +0200
Subject: [PATCH 8/8] refs: use peeled tag values in reference backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-8-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=05FGBkBlZNTfFRFTIr/adq+Vdu+zX8v99qhclV1GtBc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl/AGx9yubrwMRbskFo3SXkBh/hvffjtd+r
 x/rdlM/FwTUD4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fwBAAoJED7VnySO
 Rox/FUYL+QHF3GwT2ZATEaHU+3HCdH2ZX4vMjPj3nevKAcOTZ7s0uI5sQKLmkDAPFsEifQadTMz
 LAX+q6Hg7I9XJdwt6x1bCoNw/hmLJ1xsHIb4gW7ugJvqPCh0DXYzW9IUC4ObGrGgnZUKpD6iDab
 K3zoQrE2Nbfk7EGVU7whHa7LH3q3pFpeGoSE/c58DeRfXYxSA/0H2GAyjxrT2qtr6oTt6YetR2d
 e+jDjcyteRNPdkQGghRrtN1xPPiadS2omE8/b8/nAsAHgzz7JuUh5WwxHFANLEXaNFtKfYpydu4
 wWINqPPP4VF1CIuW1hywQsuYv2buqmsdAr+X4BLlXzqXMG7rY9olWu/o+kybnfei7mxFwW/z6qk
 5e2FQJ7uIUqtLlhA54MZ5PI4hc1SBmacvJAwOrWodxxGoe8a7JFLYtAr0Ocz+tsfj7h++9RKCWE
 hz+4lOgbCBuoXmHcTsw+QNH0inCuY06sA5hJ3gfJUMpQBZoifF2+Pb61fGyVktqlW8rQA6K9bC8
 S0=
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
index 195600cdad..64d2e105e2 100644
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
index 7416bb72fa..001be56e8c 100644
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

