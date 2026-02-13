Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFC318ED5
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026931; cv=none; b=LokXONFDokI+JDzqi4T1Gx3YATLnTgYjgkvcUp9PcBko6BSahZVLOw9vhsotgeooRDJv4Hb/qAvyTY2idlzdq9HcjYydX/QbGDpX0kD8TPwK7IYls7RCOhK6nntTPOrOe1Dq0ZD9f5acnxQO7bHN7FCgemNDIb0qHVbrSW/ckYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026931; c=relaxed/simple;
	bh=Q7Nfe0i70iJC92l9DbpfDr28kWH1ZGCBeYnJYY0VhCo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KPWwzNoOVrljUo/u2VtZf7ipA29tkH7wWc+MsvNtVFLaed0FstczGu9xYy5o9Vtzg24unsv7ZU/ZFVS4rDMSnLzIh9xmBE/6ASJ8lyJOH76Ro79BolUXAOUDlkKZC+1IsdRC7n9qN8nnduA+zy/EJDW0zxxPGdPaoSIUHcH4gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKm0q2XG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKm0q2XG"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb420fbb5dso77166585a.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026928; x=1771631728; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmWBHL+lM2WU+YWSzJoYGR2thi98kVQMBQFukpTPUH4=;
        b=VKm0q2XGewQv/WWfAIEnyRO2fSe//6mcCjLmZB2/dEYR6PAo6iyIvQK/J5F+OPQpWW
         X410Lz+m6cdPGKGc/zn5hMyJL+DF+vRRxgvojmltuw6B9Vif6OEJ7oXG7uWLBcisFD6w
         9MVmYn/CjXHadeNH+zsD3YeQIbAgL9v0TodmqJoAL/PjhxNdk+UCsDUcai8IiuZ+yYnL
         8qrDAt56xzDIVOc+PYy3NvnBhl0a1A85ahd3blT9ErqsgRIbNACrL2iOpIFb05qRbcpe
         lm4S/3uXUXvWCCTqKab/aen3vD/fydMhG9NI0XPpC4JCgrmJoZo0JUKIHzayn9E+2GPx
         rZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026928; x=1771631728;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BmWBHL+lM2WU+YWSzJoYGR2thi98kVQMBQFukpTPUH4=;
        b=hetOW1Ce5Jxq5xaOH7Fob84WoGZKUM5Dc+NyblO1+OWXfElX5QKgJOdIYFY2eqbWg5
         KMcHPUx6g1Dvyg2PQnWaJsPCqgOp/9Kr+iSf3uIPfjp4qddmSlltOdIb+jyNoygVLhj8
         IiFq95P+XKA6v/3xvrJGIKNPVTaOjmi0BDq5So36ZSKJlpAn0HI4bk/oKlDqOzPRrPxA
         W7nWF9j/cLaTottZ0Pj4sfU874Wzul1A9KppG5GqFScwSqjR/Ooeu4H0EewtiDaIRrZg
         N9GOzPF2T1677bUzDpVfmGNvtDrYhxjMFS5Ty6hPe/gycZ2f48Hr9xPnq+v/IFNyxKfK
         pZBA==
X-Gm-Message-State: AOJu0Yy+C8ZJ+AwQF5NknLHYnJ1UyKay+/ufUs+5Q7JMNOfMgIIR2Mdu
	hDByZRs1ARRemmwFeGAoLFAbNcM3RKBud4OlPr+JTEE3mSj8gZIx6NvAZWGojEhj
X-Gm-Gg: AZuq6aI7hZqxQ7/r9xlwPvU5GKRpj+e2LBhNcVtaUgWJUx0HC/rTswiC0/NHqvCT6MK
	tSvygFQ6hhjpgSWy2v1Keb+Ai6tKy05eWgZ0fEKYSsgzCfj9YuoORhCK4ErNmhRAP4CebpXPRli
	pzhPDr7O02n6s568UFrCyHfXBsVcuF5iGVYBd+3gPXXCu5r9XeTSxX/Se07oaF6pl6NyTEZelcg
	YO5+1v40ifXGo7yxpa8xFIr4YGckTcn/5Hlf24y5/8E7fcLY0rfahBadJlzVN5MEPyDqHQASbmt
	+1HG8oUFLPrH5jdpErtbuuz5F9j5sFDD4FY06bs+4svmMBy/HLqdpfOEGetsJz/z4Z3kY9HcxNg
	xO825dfNNUm/rraGDKRXhoRw+ej3kDR3LgFHk3mOkry0C+gL+Zghk6enyRRmYgQQvM5ahEFDud9
	m5mYSiC+Z8aUPmKHgkJIKK0Vn5DNLkLOY8ZPg=
X-Received: by 2002:a05:620a:458f:b0:8a2:e1db:f442 with SMTP id af79cd13be357-8cb422b2fa6mr433592785a.30.1771026928413;
        Fri, 13 Feb 2026 15:55:28 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1f5669sm714129085a.34.2026.02.13.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:27 -0800 (PST)
Message-Id: <2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:09 +0000
Subject: [PATCH v2 04/13] config: format int64s gently
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting int64 config values into a helper method
and use gentle parsing when needed.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4c4c791883..d259a91d53 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -237,6 +237,25 @@ struct strbuf_list {
 	int alloc;
 };
 
+static int format_config_int64(struct strbuf *buf,
+			       const char *key_,
+			       const char *value_,
+			       const struct key_value_info *kvi,
+			       int gently)
+{
+	int64_t v = 0;
+	if (gently) {
+		if (git_parse_int64(value_, &v))
+			return -1;
+	} else {
+		/* may die() */
+		v = git_config_int64(key_, value_ ? value_ : "", kvi);
+	}
+
+	strbuf_addf(buf, "%"PRId64, v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -249,8 +268,9 @@ struct strbuf_list {
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
 			 const char *value_, const struct key_value_info *kvi,
-			 int gently UNUSED)
+			 int gently)
 {
+	int res = 0;
 	if (opts->show_scope)
 		show_config_scope(opts, kvi, buf);
 	if (opts->show_origin)
@@ -262,8 +282,7 @@ static int format_config(const struct config_display_options *opts,
 			strbuf_addch(buf, opts->key_delim);
 
 		if (opts->type == TYPE_INT)
-			strbuf_addf(buf, "%"PRId64,
-				    git_config_int64(key_, value_ ? value_ : "", kvi));
+			res = format_config_int64(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
@@ -309,7 +328,7 @@ static int format_config(const struct config_display_options *opts,
 		}
 	}
 	strbuf_addch(buf, opts->term);
-	return 0;
+	return res;
 }
 
 static int show_all_config(const char *key_, const char *value_,
-- 
gitgitgadget

