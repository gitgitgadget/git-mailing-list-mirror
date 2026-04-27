Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251163B5319
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286538; cv=none; b=qYu1tAi0v0N4dkHDj4iqUJEsPLFpMrruxjICJZdHPp6BZ8+qRO7PeDnisnCl+cTqZg0XNODGsx6B85uAAXJ9xECut4nOQHNQJigokDgQKc1KXybz6AnkPLA2dVLuM+deKa9o/cYIBEClD/SR2QtZ8wtPgynqU2Hy6WVjP32TuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286538; c=relaxed/simple;
	bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBERBjBiXxpjFWmKGXco/VwUluehbS2o3Wd28pUcX1PC+QcZh+lJDp06/rQvu8Zmzv5w62CFXSOcIa5OYASZEiZ8yo8zjA6/VqhE+oDY8ZBED1e50sG1F1QfSHNKkBwTy2z7/CIoeyOAeAipcl2eXwkJ2ECGB3S0ED+cvoYPoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR3P0n+M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR3P0n+M"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d77f6092eso7014646f8f.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286535; x=1777891335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=IR3P0n+MjewtQITHfMgzWzValUROs2GLsuGx3I2TWaFj6uKDC3oMZTeHtQ70p4D4pn
         c2b+Y/XnKQvB5oPrI2WcLWK0pfXjwmju+pYg/CPl0SCCyxjS+2rgp1DnqPXeYF32aXLh
         nPtDLBG4AXd1grdWp88zaQtZ4ArifjesvOsFVRYhdq7IFnFvW4tnV78iQbJxYlrN0azL
         pH5CGZI84HqsDjgcQcRZ2lqEpKr0XMnB2X0FNvTInBvI67aBoZCxpnqJ4o+lniXVEskO
         VIyKz7KU6+lhPJuG+A2rMSxOrOFqWL9LCEWU52wjgTqLt9G7538VsZvwW9k4TmFfAZ9i
         BWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286535; x=1777891335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=f9SBzIuRBG0vaDFRKIN7bBivKKgj21BAZsS4N8Do2AQ8DUDBB5eXmoaB0AycVEDdHi
         2boCfV781cmlG/pf8DddhaK9QW0F3uepk4z70E8356XaN/Gg5uhhmKd5v6WIjKrf9eu+
         62gafG69Q89KomGGnhgUz0+CQl6RWx75rMI0AZmxWBeuGND3qOSW7m+CulHEZWiOIDz5
         U3v6i/kpm3MXvnJMQN7h7c5J05cbFq4MuHoDTe4Lcx/lyqqWs/JEtrqXnpMTsEMuQP1r
         omXna1ZxoMKDyIt5+o80TX1fdj3CcZIMy/pKCA38etaWHLCR+TSKA4ywtqiw7UfYSZa5
         DzjA==
X-Gm-Message-State: AOJu0Ywu8HV8jwkM/qlg3AzaTqyaYKNvNhvf/14qgDPT5rci3rbKpiUS
	KdrEXJ3Rl5wJx9vDUqS8N4vzMP/7B0yfXpHP0LFbH8EC9ydX9Tm9DZ3meoKkyg==
X-Gm-Gg: AeBDievNKCng21IzhQjL3p6ykMjAQb3ouw4uw94i3It27/NxUnfCDHa6fkRXYJzrLXU
	WXgsy8aREKKhlS4Igpl82RYJ+xm23CoDJe0P99xpWY3nm/AE3HRZEwDt82zl4JoNq38mNxAqXjK
	GM77Z5pbj/GAPK8rJWrVQ+fznMeuD/LqLrapXjKF7h75Ha4O1UQPCdd8UMDfVxSXNKiPG+LoKYd
	tILn1+JVtYra4WELVPcpqjhRptXw4aYLu9IUd4r9/n7Zozf+QC+jjO1uhpZPx/h89HkB68DCkwv
	ezn2noHAYOkN3rLhfCYGND0VQcSRmdkVqVCVjfxKTeF+w83SoZmCzGae28wNOrqnQp3aMWNGXTJ
	q4Wbv3tkFtL2pfSLO3fWjeMqQKaja0R2u1MiuxtaeF9WLwXR2+tqbOKSoi5I2PCAunHHDcdFU0X
	F4AxN2vda1yJIJPq4s101BizikjegHOJ1GWRc3zfku
X-Received: by 2002:a05:6000:24c3:b0:43d:7868:21db with SMTP id ffacd0b85a97d-43fe3dcc11amr65641662f8f.18.1777286535002;
        Mon, 27 Apr 2026 03:42:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:05 +0200
Subject: [PATCH v3 4/9] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-4-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX+JMn6uKqCE+Oz1D87l8CjGclvkUPBsH
 XPHDaZ4LjD11okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1/AAoJED7VnySO
 Rox/F2EL/2O/oW+QqrvXn52Xag6dP1+6XsMtwb6GjgIFiRsSKLfSt5+4idhSA/sVH/s4TtpKASB
 UJ396Ql51JY4re7G/A0CXOipGG/3Ss8Sj+vp4wD9n1CBtMwi1dKX+J8bbM+AugvRYTqxq+Ln4uH
 XmGV3uwMFBi2a766ZhzAFGAtN3+ySgl92eG8oThHEzCT/Sea3UG38BGKXCFVyNIfCObOMoEUS7Z
 BdA8Zm9BhovpxbQwpxEzRoy6+wkTe0IVHY+QyHa30G2uDAQ+Rd0px9ahWJ2139kFhXwbflRmpjL
 oCvsC/KR7Lwk0CPtfQDBtkLdrCWT8nKXdu2m4e7nmNoelqTRZPjEnGO29ELrT9XBhWSxKebqzab
 4Qb5T+n0yqELz3WMGqErir9uNaCRfCOQLkIsnCSoRIE8mAaNeUWhIEn0pDowdewN4QCaOvSO2wa
 97KMlG66ZUT9Y8juoXV+KCFvhTtUap+THtzykqBjNxd1b14NUA+uEf4x86LNxZjfOZ1awJ5bNB6
 no=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update()` function is used to add updates to a
given reference transactions. In the following commit, we'll add more
validation to this function. As such, it would be beneficial if the
function returns specific error types, so callers can differentiate
between different errors.

To facilitate this, return `enum ref_transaction_error` from the
function and covert the existing '-1' returns to
'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
behavior, no changes are made to any of the callers but this sets the
necessary infrastructure for introduction of other errors.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 20 ++++++++++----------
 refs.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 6b506aeea3..efa16b739d 100644
--- a/refs.c
+++ b/refs.c
@@ -1383,25 +1383,25 @@ static int transaction_refname_valid(const char *refname,
 	return 1;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err)
 {
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
 	    (flags & REF_SKIP_CREATE_REFLOG)) {
 		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
diff --git a/refs.h b/refs.h
index d65de6ab5f..71d5c186d0 100644
--- a/refs.h
+++ b/refs.h
@@ -905,14 +905,14 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
  * See the above comment "Reference transaction updates" for more
  * information.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err);
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err);
 
 /*
  * Similar to `ref_transaction_update`, but this function is only for adding

-- 
2.53.GIT

