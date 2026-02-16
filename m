Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27452FFDF7
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248219; cv=none; b=IEMBs/eFKD1FcfzdXYv88Ycma9qP3zD2QtdXD2B5ny8sU2inAkjv5fm2hFcm7NJgXz7+U8U0AssyCjA5Lv1wquDnnN3hwBKZH366iDOesWnpjJGHTb/tLCBg9fw/NSdc0OWzt+xfvQFSkcSDAevt6qM7d5bt5F8DEdG6EGR7asU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248219; c=relaxed/simple;
	bh=pXjgdEso3a3gFsSqEuxS7ySEuexi7/0kuGx8lWCvkgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vholhvlw6NQX8ENC/rhrpG0cKAs+5WE39+eagqsjOhRa6N0ev9s9GOD+6MLyv528MXfKwbA8eBjxtuqVG0nOM+5ejoYBgFCM0CwuArw5SvqoleUGPkYFmwRvvQuuJKrUrUtwHzImwluit6hjnIkwlBjlayAqyceFiVl+zDcGIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEXy6uIo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEXy6uIo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483703e4b08so25198495e9.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248216; x=1771853016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BrACxXCAUW9nWnF9jSiAcBtTiqlfNQ0sX/0m2Jq1Q0=;
        b=WEXy6uIokhWo9CCHFTzkp2vaTQVonclwO/KOQthUiiFX0j7E00AYBhuzbSbhnIqkzf
         2gDcu+E+kCA9gXAsS0ydu8OEEfu7syy8Yf3JPtEITSCBUpc18wobQn7soeLqaMiGWn6K
         7UFdYbOFwXHczVu3nnJ9so7kHjVbDX3sQ3MSgF6xuC0hKtn5YUBRMA0W7QlW1zmWxQSi
         nEoxUIfV375EFxPSjUGhDfk9PASKBUBG5QsRMFYKbeiU/BY8f2885oB1SgTURAOJ33uv
         1irMRqKoVsVYK7ZBk3obTMxrsWnb5cCTX3D+iVKWKAVuxKTb4z6goTujk2AQ2POhgzta
         H56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248216; x=1771853016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9BrACxXCAUW9nWnF9jSiAcBtTiqlfNQ0sX/0m2Jq1Q0=;
        b=W+TEpkE2CYevhS467OeMJKrCqkP22ftbom7hPsJStk5wZN+AdHK081QHMHCJZkKb1k
         FL6cCdPCFKx9QS0eY3EnjzIJSHIOqwSiIA0jEnP9WuMVmYkBKlne8MqdL8MIFboyrG0T
         M/9uaXR48qmI+DSwfCvoR7gn4rKt46FLoDM29uw9blL56YUr5XHWfjZpYyzKOHbuka5q
         bqfvj1Ca9RrGiM13a1bvdw3eDO+oUi66o0ntfYwYheyqdPolTX0FSpMQNoE+XH2WFO9x
         dGnnPGiM2VCShh2e9W+0peP9NiM150AMl6iwn9KrsqSv7gfHQKtjV2sDzqi8BjBEFArH
         3bqw==
X-Gm-Message-State: AOJu0Yw+G3w0/zGlGLbM5axKTLpjtvsc/TdTNIXoSRNzkrNKPr6NUHc9
	tbxLYGkkq9l2EeBX6bEeG2AkWCud5Pt6eDa386RjNyK4Su9hTrfVhs5pm9i5Mw==
X-Gm-Gg: AZuq6aJwvKbnIzHoETRRACpuvoHJ9TVEzcc1RD9iGy8WfLc/wSEcO3wjgC8NHm9rr2N
	klD07xlmpgqAzr6A6yrmvVCubQ4/+gpsk/Ye/uUY7k7p4VUrNcMcKqBQkXbQRwkq11d0a8uKQdu
	Jb9J+7AyF2JVnkYmBmNC+D3K8CmmDb8/r859x3Y8R1t3TsHmFVe2VHT3lD/NLr3E9q8dR0u9mgw
	/+2BqOg6y+Dlm1XiVuc29wFpAvCWsSpnwyf7tUibIAVDSENU4fDffHslri6/ojhp5D7XZWvca4Y
	8113APXNAB11W/2v84xRGD1c4jbNznVcBe1fTJ6lC+agtAQWQVRWUcrrLcLg8Ouum6aoix1yM6H
	ESUv67a4DFPmEpMI1ASj/eQCAlfklQkpLMmiyTFRy6NPS3y0u6gO3yvneZpGXjXfCB/czAulgOb
	aAPhgUjp+NpumW2h4sZibPA5D8CsMsWXF3ats8WTMZ6HWyRYZF6HH5V9w/9/vMfLljd++L/GYqm
	aIKQJgzkRcH96BEH2iD1OgFnI3Z5jksxI7wzMjs7WYD42ReYg==
X-Received: by 2002:a05:600c:3502:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-48378d4f382mr114205105e9.4.1771248215868;
        Mon, 16 Feb 2026 05:23:35 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:35 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/9] promisor-remote: refactor initialising field lists
Date: Mon, 16 Feb 2026 14:23:07 +0100
Message-ID: <20260216132317.15894-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "promisor-remote.c", the fields_sent() and fields_checked()
functions serve similar purposes and contain a small amount of
duplicated code.

As we are going to add a similar function in a following commit,
let's refactor this common code into a new initialize_fields_list()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 77ebf537e2..5d8151cedb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -375,18 +375,24 @@ static char *fields_from_config(struct string_list *fields_list, const char *con
 	return fields;
 }
 
+static struct string_list *initialize_fields_list(struct string_list *fields_list, int *initialized,
+						  const char *config_key)
+{
+	if (!*initialized) {
+		fields_list->cmp = strcasecmp;
+		fields_from_config(fields_list, config_key);
+		*initialized = 1;
+	}
+
+	return fields_list;
+}
+
 static struct string_list *fields_sent(void)
 {
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.sendFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.sendFields");
 }
 
 static struct string_list *fields_checked(void)
@@ -394,13 +400,7 @@ static struct string_list *fields_checked(void)
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.checkFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
 }
 
 /*
-- 
2.53.0.77.g4627d513d6

