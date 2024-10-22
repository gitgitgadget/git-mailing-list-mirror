Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4C12C552
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574630; cv=none; b=kkekg0ZxefvnaGZttGw+FY9ElqaUuAblCs8fhqZ3BVBNEs9NPxM/8Xhlc5TGkc5pp09Xz0CVGxO9MBHVVlnD6FqyhiMSMQJbGgI+Sy25PAi5CdveWsqqWt0FMtHK6k2NsyOj0BFjDHdEhzE/sMT0agIVwVTMDTMR/Yekf3uQDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574630; c=relaxed/simple;
	bh=5GzF9PCgCy1dVVZT3Al79NQtBgiC3194rw0GgjPbASo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mBIDoduI7ELxHg6M0l19qBxgW/Ab8G733cGrorIv9vvC7vynQxIh+K+k+AgIoF49ja8c9qx8EbCjvaejxQlqmDjkjDNgfQTKygvQUfwtpS2e1+jVj1yBanBnqI+bGbxYqO2aAJgkpbIK+uUf6Fu4owU1CoJr+qzqnBunN5WiAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dra2PO1V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dra2PO1V"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86e9db75b9so669473666b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574627; x=1730179427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=dra2PO1VZmP48941IiPpgmXI56s9gV3/KJdjuvenW/daUb/U6u1P6lL+HPB6W4Y0tf
         4nUOBpmXM1558mmV0kzRuEfmRqhsilaxrZOgjmqRvNv4pkcmcd5A1JMXTMrQjt9RzeSl
         DizRo4Q29lv/5F+6SCfRCFrlDr+4j5gN3438pIXAMD1XuTFdrHPcylgBjlYYS6TFz2Ej
         2IKv76WPqY2CU8G9fVPGUzsSRU+FiNKqxkTYKbW9/U5hL2Of+JL/w4jxcsVvh3zmHm9I
         DKpiH4L83Sb/f8YSn1q6Z73FqBFmd9jLrM7TB8yk7/DEVLer5O/OeCOWlXVylcg6xo9a
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574627; x=1730179427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=g6W8JtPFPrKdw0lCMtAdlaZR4zo9ZcvwqfN0PnwQjjwplIYRtqFxCQGES04hwrwD21
         ql4Zsg5A2h1F3Emm246G43jsj8nKZrEZll61SsVdMKleo3u+/w/aruuiJdL/BJpjeXIt
         AS5apLJP+gMN8wEAtettWeWMHEGbNXxnEYA00YF8HH81hte4TCBD06jP0NSp8OT3tBxT
         8oB2eRyEkoPSs2ToSV4XDhkJxkSo2Mcf/gGmucvL3gGE57r8jNIJPf7L4t0d59dK0UEE
         ypfuiH1M6d2R9dUpqFOHBrtzWYCIRiXIaxAk8PnvRdHgfBr5UYH3W5gSNQWkmiR4pL/f
         dZsw==
X-Gm-Message-State: AOJu0Yyl24f1+WMN3XWib24yUc9Dqg9Y+RuOcVoc18OAvwpoNKOjEomt
	chA2k0eJpoLw9x2Zysv3BSU0ROCwc18s2WsaJh0RcbI+MSr3IqRUT+tRGg==
X-Google-Smtp-Source: AGHT+IFZMrHtrAKABb9A2NFdZ/E8EeQb2fvnpjEzioKE0ST4QdoVn6x6IuEotF6WOu4+tyab2+SzAQ==
X-Received: by 2002:a17:907:7fa8:b0:a9a:478:2ee3 with SMTP id a640c23a62f3a-a9aad37718cmr121309466b.40.1729574626858;
        Mon, 21 Oct 2024 22:23:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfc5sm288872066b.70.2024.10.21.22.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:23:46 -0700 (PDT)
Message-Id: <2ad3b0faa058afeee5c6b86b4bce334e77993dac.1729574624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
	<pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 05:23:42 +0000
Subject: [PATCH v3 2/3] merge: replace atoi() with strtol_i() for marker size
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
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

