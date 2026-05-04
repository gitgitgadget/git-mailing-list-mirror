Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C53E559F
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916664; cv=none; b=cKLtwe4KN+kYVMuy0eMcyczgtLTPS3n4/+YtRKYMfHS0vQyC8C4g44Lk7w1GsJUOZWWfnQw4KmWY6SWPnLJqaSo3V0tzvbLMxxO3367d0J4BfNEt+jWnOWnx/u87bgL67ZncaRYcvgp8x2hEoatcRdnblQV8kpsctmEy/b6dtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916664; c=relaxed/simple;
	bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmg3CyTDl21uEuUUAF4ciEQUMcz9STZj4Ipp/3LosKFcA7DmWlKJ4loI4m6BBc+OCoXISWcRuAx0ICEezYT5KIrcG+4uIjIQpAnObyHrcAs0zG7TyDItMq2+mS8+qX38RliX2gzfFIZY2nZV/pdoeB31rWbUbLGIAhn8uNAQeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKFEXuZo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKFEXuZo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so50710875e9.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916661; x=1778521461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=eKFEXuZox7iBWvDvr74g+AoOiZ6JmtrHJ6t2JT8OAxDtSyImIBx4m6XoAy5PhyRn+F
         /1CahdxBrNFHR7DDUtSDwJg4SAZYe3xYE5ypb3BkIB/M9Z4aq+J2ijOVuQaAJnn0bUEk
         a3KqVD7Mzl8bQTAPiIAcblDwptIqXES2OIEUBn11jkx1TVoXuni1otdd2v6fDZwOp9S2
         8TOwyone9kv+/qUzj/sIsbmna9IJZrJHjqERcbFy/daVavwRt757sM/GeRaNYzpirq/S
         4N98FvDkzUAf1QcUe3+Qgideve38kbWPbc8iDwjrxl1QRV6X+VreQcAXUPQPPLwvwSOt
         L1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916661; x=1778521461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=Ui2azt3CRM2MgSH/KrQGZ1Lw66uWd9gAD10eOdetWJU8uzrMgiwiRe4eaGIDyoRi/z
         PZGWAD7EpuqXpWFfveHIX6XdItr9fFZPNzxrtdmO+57Z0e4Gv0JKIKDGbpybElpjs1EK
         joHEo+HbmC/5dfKvqowjmq60fLFn9LebIQIg92EbtXjlISr3QmmCZNH62pyu5DUfaZms
         8afe9VAH2De6yV35azE6dEIEbDhPysa7UCqvGrxXL8Ceam/wUcoCAvJ0U/eAdKNgt52z
         Yw+s7rgyTuO6XFE1xYSZ1apSS9VUGYMaBZssFKWwf5wuf+y7rFb6Yysb98PnYPdQKIV5
         YSOg==
X-Gm-Message-State: AOJu0Yzde2sJt45CxrshgG7pSvJ42m5svqUbjw/whmoPQT4tswBUh/15
	xa+nsmhSmzsEZKQCZn/UceDgHMjdKuB9GT6qUN4hMsaHm41E1BjJcDMP
X-Gm-Gg: AeBDiesDp+EltN9jED5sv3er1ef52TBmIMlCiguSu3tKT2mF3c5doNSskLeugfRh//n
	hNpxlFY4PnDnHI25/ET8fO2dwPClJbpVrcLnaFmYM8u1o3XgJlCDirN0B2oH41WjkBKpPT6ujaJ
	pjKXm6Ula9c5Filn3IysToGFFDfeqQ9kZtZkJgNp315bWFecfOO1tvvLrCCgwZG02W7YrSBX1H4
	mQwqU2OIS6fpZuX/AQJpXPhWu4vyBGz9s8XxTbkdIF83cghat5T5GOI7G3UnHhcmj/Ee/6kTeMt
	ZIq6XdRoqZzpxgJkRvNmuyjm9lEye5tq1cbjuz8GjfT2xvRQ+FXTmxfANwAm1r6cbk45xlfFcSr
	yj/3H3e2nFNVlEUwkwVAouyIOGXxqTJQUZgUwY2bx1g25rl9j8wuHJlfAEv1Va8WbklpgZ5WKAU
	v4oyWDj+zVJXbpwRvc/i0mm0ZMPi0D2LAhqe7o11hukxUyZus0ND8=
X-Received: by 2002:a05:600c:4e4d:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48a9866a55fmr206319005e9.20.1777916661396;
        Mon, 04 May 2026 10:44:21 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:13 +0200
Subject: [PATCH v4 9/9] refs: use peeled tag values in reference backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-9-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42uthWecYA/0K9RBWrIA3VrHmw2QNJBmDk
 5wPemj6Br7FbYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrrAAoJED7VnySO
 Rox/D3oL/32qP9ld9YZ+3E+1QneLjSlsdqSG9z8urFsAXXTgIuTQeskSXVUlbg1qzDczo1J1h9w
 7+5Quy9K4uWQnT9tSQCFV+D8X13wMo/A4NJMlFl/8wjPbPFjew7oqxSunmSROpexG+suCOiXDUY
 68GAbtqViyWgysuVfjT2joPe2OT0NIyhXy8ZZeFED+s/zoBOeqIz5pz+pr4uFQz6+l+9O52kBWv
 RTp8nq4A3zu7UuvWbEwHYKsalGH1dPOntxS3h5wDY3pVNp+FFmpHr16RX4HDYjOLedXEpagTwIx
 XloPSbkQD4W3X/m7JwqXZWalTdbgXjrXFSqTERtb3CaRHpuTLfW/ZH5uK6KuQr08vcm64G+bMKh
 wtFpMQr1itDTgasyYOA1XySltOsbBxc/gpcscNS8MmmiA1YZHKTuyyeecBXXIe9/tCcyb1TplgF
 z910ZH9lJoTFyYth/g5xZEt6XTMy3XqhgultenjK0LPXxbrKE6t9H4mg2CQ7tS7qK6CHFEUVov6
 oY=
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

