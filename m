Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D71CCB59
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634944; cv=none; b=WMiiNCPUI7RrWQwZO94D1MaBYw43Bk1s2YEqEdQB7bljC/4VzMF6zCdW2irx0MGMH/5/zDwY1Qs4HWHSzBAEB3q9V/bzZI8napkOAh71cOma90COA+DcNvcdTQPyFpEeXE2/UQAPWT8KUicENwgvkwAjfGGt0xdy2m3633EEFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634944; c=relaxed/simple;
	bh=5GzF9PCgCy1dVVZT3Al79NQtBgiC3194rw0GgjPbASo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KdtkaIB7MI4qSyH0/a0mX1GTfWtz7pox5OeQ9HW9aQE21KOX/tQKLX/AoCSln7xdtPQLKXq12QR1PfUfUYB8JqApmAEzno5ENK8+IPEEEu1j+chjn6muOJraGQaN8FOXkFjax7SfFCV+hiG3TzWeT1nZ55Q8cXyNC65HbtKr7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge6S/sUK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge6S/sUK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0cee600aso768190166b.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634941; x=1730239741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=ge6S/sUKx5f61q9USBs/D5wpPzlSXV5kc5GQtsQhqt/3Zt5x0kuAq7xPiQstjdf+0O
         4UBQBazXpAFMwmiFG33+2m1Tpf9HnprhuReSJZ+Ay8iRPrHXmBP1HtJOZ+aIDfS7IOgA
         H66yNz72hyu/GTCo9ucH/5uAHlUvkcO/uL5Hlxk+LtPpMh1xpnEnSZ+EGnjawXgiGmM9
         8I0NfD5TOcnxrt5PgQWBbsJDnCEOhykpAetHCNeRuN1s2Ll3qgdxG+PUXGAHxIGiX+VS
         VWE26M+bjEcQm3tlG4YkGP3KtJ5AbO7Fl5PiCyaabb44bo9I/1fRawjO7hMb1whikMGp
         1tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634941; x=1730239741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=H4sCzzEuVIKs60qqbLJwuQDRGC+o3RG+CTY6B4RWVSJIG1CsWxUigPiNvRLO8+8wAq
         QruqlT4U9HNZzxgvRTmGUmIMh5/WOVbts9rdX8JkbxDKRPFNFwjPyjvpLnNw+SQlD0u0
         abvY+pgVfglEz0v5oXgGDMFLhdyo1f+9z7R/zH4HP2rFjxu99ldWhu4vd11PKRmZGfWY
         7/vVUj+wE26QGjaZzp86QGZDLsOPAw/XYyMVptbjI6RfC38AKntHe+1XtqVlq311VbcL
         oxbUYkbUGho8HurZG4oga59mXq5m+mUlEw/2vHkxPGXhVaxmFwTzkCZJaxJRuhJhIAaY
         H8dA==
X-Gm-Message-State: AOJu0Yxl/0JGRmLMmHkYJkP1RxOJi60uFeCMG4AkDrzKNUD2PntuoT9Y
	0mvWn+Wm2Z82hD22l06Rstyn9uLVcljm3maaDNa3lxnmBEEeuZgeJE1v9A==
X-Google-Smtp-Source: AGHT+IEC6ROVdOlIidGWh1bTMuALOttR3lcN9NStHwPcdvgyjA62xvIBruc7L9BR/73LU+MBPj2YOw==
X-Received: by 2002:a17:907:2daa:b0:a9a:c03:ebc8 with SMTP id a640c23a62f3a-a9abf8c9f88mr35811666b.37.1729634940662;
        Tue, 22 Oct 2024 15:09:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e49sm390597066b.117.2024.10.22.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:09:00 -0700 (PDT)
Message-Id: <da9ea10e4e115777c16b32f1cde96a3df8c5cbb1.1729634938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
	<pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 22:08:56 +0000
Subject: [PATCH v4 2/3] merge: replace atoi() with strtol_i() for marker size
 validation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtol_i() for parsing conflict-marker-size to
improve error handling. Invalid values, such as those containing letters
now trigger a clear error message.
Update the test to verify invalid input handling.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 merge-ll.c            | 11 +++++++++--
 t/t6406-merge-attr.sh |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 8e63071922b..62fc625552d 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -15,6 +15,7 @@
 #include "merge-ll.h"
 #include "quote.h"
 #include "strbuf.h"
+#include "gettext.h"
 
 struct ll_merge_driver;
 
@@ -427,7 +428,10 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
-		marker_size = atoi(check->items[1].value);
+		if (strtol_i(check->items[1].value, 10, &marker_size)) {
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+			warning(_("invalid marker-size '%s', expecting an integer"), check->items[1].value);
+		}
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
@@ -454,7 +458,10 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 		check = attr_check_initl("conflict-marker-size", NULL);
 	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
-		marker_size = atoi(check->items[0].value);
+		if (strtol_i(check->items[0].value, 10, &marker_size)) {
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+			warning(_("invalid marker-size '%s', expecting an integer"), check->items[0].value);
+		}
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 9bf95249347..c2a9cf03808 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -118,6 +118,12 @@ test_expect_success 'retry the merge with longer context' '
 	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
 '
 
+test_expect_success 'invalid conflict-marker-size 3a' '
+    echo "text conflict-marker-size=3a" >>.gitattributes &&
+    git checkout -m text 2>error &&
+    test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" error
+'
+
 test_expect_success 'custom merge backend' '
 
 	echo "* merge=union" >.gitattributes &&
-- 
gitgitgadget

