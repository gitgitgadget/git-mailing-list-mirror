Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC73B1A3
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984790; cv=none; b=FaJaZ3qBUi+gEi4n+NlPFHfsyMJR/JR2hhDU3mOliErC7Rk4g1Ue6UJgbc0Aj+2zi1WSXtualjFG+57WKbddbyIK9i1f6lIGxg5AvlE13yCp9A97B6K0a1a10L7guB9Vk1aQHOpP0XbMHSNO+HlnV8oJTC7tE4XurEcdFFjBvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984790; c=relaxed/simple;
	bh=D1WkBTyh+/28Xidvv1wCmZ12YClkEAHaukl9lG4qNtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHh9vJBavdLcxjXtdUtv6iMMdzLX2P0B1Xe68fPJRM6W9AhIrH/yL7vgzcPDDQH7jivhXo/1JKNdgGjO/cvpKYs66zU32VrxyzmUyHEiR4suPbR7WOYrFkjL6XANkX6dWrCnOz+FTfm4qjTJd1Idu1eY1YnHBA5OjcgeFQbYPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlE2d8s+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlE2d8s+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955841fddaso186718985a.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984787; x=1719589587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGolJSvY9r/i94fLXNlvYHIUSnzUUxRo7Wmh7oM3xfc=;
        b=PlE2d8s+2DC3U4x2r7sz03O7ELtme1OapxtL6HiD9LYb1SdTUpMvjDslxfv7Bg6PTm
         ZbW1DFpGSv2A6bL5q0iWybKMTz4Zn2+7Yq1upMcLKnnmqXuHF1A5gWNlug3mVD8f89at
         MGl3enIBBLaMUPQbsb7xcTaWaHl6mBmiuK0wCoL95xLPwnM7PS7jZXrlXxLgF0NYtbb7
         jimjCrvtO7cvioru7AjQSsyXZxvdhEexgdfV0fG+THu+0qUmuE2ynyuGj84V7Z1mpEnN
         pxDQRWVAEjLZD54f5eQblltAehYnIGv+/2R03NyaJ4T8PFbjEwWYUMhrzrOKPunJNQS5
         BWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984787; x=1719589587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGolJSvY9r/i94fLXNlvYHIUSnzUUxRo7Wmh7oM3xfc=;
        b=YFUtfCMn+pw7hDwW5DHM42OuXJKdT9SGkT5F46b0uTZSPXkeH13B4HV8MXlfT+ax85
         E7FX2ngNeFLa0uxpSQwQeHmgJnuUvLCUu6vjBl1jf3Sios6pnMpfQMAkSOaWXnu+ShR+
         5zGuIAO8XTua1ZaoONP99YJ1C5Hq3qY+D4Knu8GG5XDjntvKaVpq+KH92qEWaFYgata4
         iYkmUMnIMeVdmdQ4L6SelR6KRP+46OJzEYRM3F5YrfECh142En6ZjWwKTSInlWcafOXU
         r/+at6Y3uHKYZWyqjOPcyhLj8PJ5nbpYvDY1MyTL9jl8YKHpDvp6qFMvu2DeJV3KRWkD
         xc1A==
X-Gm-Message-State: AOJu0Yxz30VwK/im/cmF/L+1rjXko4Dggw25iQ/asfw9bIrj+1WTvTsz
	z8YDXZALyWzBUZQukDJCk4k554SDD72k5i+Hyk4PCk6bhcijx8tQrN2euQ==
X-Google-Smtp-Source: AGHT+IEdA053L+37UEQ7w+Gt4gO126DR+cTv4rDIcKqbRaoaPRnlyBXFGmYgecf+UPKpjgD+GtRzXQ==
X-Received: by 2002:a05:620a:2441:b0:795:7abd:12e2 with SMTP id af79cd13be357-79bd98c93a8mr33601185a.17.1718984787529;
        Fri, 21 Jun 2024 08:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:bce2:445a:248e:77bf])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c3780sm96027785a.71.2024.06.21.08.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:46:27 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v0 1/1] Teach git version --build-options about zlib+libcurl
Date: Fri, 21 Jun 2024 11:45:52 -0400
Message-ID: <20240621154552.62038-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621154552.62038-1-randall.becker@nexbridge.ca>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses the zlib supplied ZLIB_VERSION #define supplied text
macro and the libcurl LIBCURL_VERSION #define text macro. No
stringification is required for either variable's use. If either of
the #define is not present, that version is not reported.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 help.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/help.c b/help.c
index 1d057aa607..f378750af4 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h"
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
@@ -757,6 +758,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
+#if defined LIBCURL_VERSION
+		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
+#endif
+#if defined ZLIB_VERSION
+		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
+#endif
 	}
 }
 
-- 
2.43.0

