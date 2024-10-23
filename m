Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C4155324
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669228; cv=none; b=LaETJ0AsC3wyZfB3KfTCv1UnzV7kPdPpAnqRP6LO+A7zGXFezv+iD78xvkKz+Fgvq9AAcvDuvO4Y93bTnTJH1HUVgo/SJs9na9O40yI+k4b0AvaT4iXW+J+dZ604UOYmHp5kc1vMdj92zQz/lOwbTJliejkb/Dj+sbdQUQh2AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669228; c=relaxed/simple;
	bh=5GzF9PCgCy1dVVZT3Al79NQtBgiC3194rw0GgjPbASo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CxLWxbRX4W37oO9rfJtNBCqu/yMpHeeFlxdrbhMnRS3iIXSYTCFx7INTDt+XWNVcrKKZId0A5pfVaHAq58d9AgKYdh2XMXXPLgBhUWekukaCBftdTC2CMbeCWhUYsLa2IFhGd19872E0SBIVk+ai/9iSphBDh5V59//tjJOGcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccA1be/f; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccA1be/f"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so6565072a12.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669225; x=1730274025; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=ccA1be/f8Iyt/a4VW8rjBkb41KnuPhU04yIs7sXJzuT8RkVEbrewOXqLB5f7zmZuuB
         29GU0hFXuxnsHe1pRQUb1c6d2QNLI7icUV3hwwuTNm+0ndCNBK5sroA1lWUCncY8ZSfW
         yS4UzulSebwSVDlogs8h+4xaoj4l6hIZl1XYz6+dpZ25ql/AoOvsK6gE+JXqwkbBTsN1
         attYJ2cFkoRvfg8HcZ4FDhC6ufpvc5UiL/eGONCB3LYQipo+jDZKMj6+rqqCjYD06EDU
         gJEVBQYfvppbEnABhzjRKoYCkCbB4JVFqDgsgbFudBeN+qzP3cBT2cBZMvlb3I54YO7m
         XFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669225; x=1730274025;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj2UQx1KomWHqTK06lThO2xY+it9ugdnkesFNhRwTqQ=;
        b=ny5stMn58x4h0QRdbMym5TrBQBa0JQgp76en2eSG9mo9H/a1gO4BFbwW0pY5KJQcoH
         YFUYhqko+VnF1dp0kIQuQyf2PYjsRPIJG78tIm4JBMvrQSIj/xYa8mMY8wqIdOSZ1cwS
         xNtrzgH5Fh5qKFgIavvFCRLu1w3EpGUExf+/grpzvGscVSr66XPzzOP8QmGAnqHzCNFB
         80AMf8lR8WQ7cOb4PEW6B3PA8HQ7I78Fq+Sd5DAVYYOZulZVhtj8B4VhdCvl++MOODmd
         VV6uQ+dRjiideQLILPwkEi3OOWN99t7BQ/5/viGL9gdYfFNmdhaOgBFzS71lY/Iv1MAp
         r0Dw==
X-Gm-Message-State: AOJu0YwGZFGenZiJlbDy+OPqkQtoIQNipmN7SE6cNcoDL6XVRL2qtmZj
	lPRAA1YmWMohtNTRyWdtngZRhoGHZwKKScP7IpDCafHutZs/tsMjWBXwrg==
X-Google-Smtp-Source: AGHT+IGqPqJtd9sV43BPNWh0UHq9b6v3/1sj3fh3E47RnONGgjhLFH+P+pLwOG1rOSKuigVAotSlvA==
X-Received: by 2002:a05:6402:1d4f:b0:5ca:14fa:dc87 with SMTP id 4fb4d7f45d1cf-5cb8acee294mr1249689a12.15.1729669224933;
        Wed, 23 Oct 2024 00:40:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725dfsm4021170a12.81.2024.10.23.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:40:24 -0700 (PDT)
Message-Id: <da9ea10e4e115777c16b32f1cde96a3df8c5cbb1.1729669221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
	<pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Oct 2024 07:40:19 +0000
Subject: [PATCH v5 2/3] merge: replace atoi() with strtol_i() for marker size
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
    Patrick Steinhardt <ps@pks.im>,
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

