Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891C364923
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734010; cv=none; b=a2n4kWrtESQ5Wv2Q8hziL9S9ANgscTxp4dNYCjq7cbUJPg9jFZ0HTwUZG3N9YTN4+XFiOhlCtdeaOheIzElMtBIW9RBH+U9hC2bf3kOsg00YJ8whzR54mVFEeuUQFz9qOK0Rioodx2UgKF4ny8+VsgFgj1jc9i4GcM13T5yUS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734010; c=relaxed/simple;
	bh=jeROlrUMUltBalcV31pZyB+WpfkUXePca3sX3kTAsSg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RIzmoL79PUFw/vsB+25jxhLSrJ4D5AWUQKk3LGlKbfLIPcj1wp29yu+wYpkPORvK2om0c6QbwlKXp+NnhFmBnyo0vFPZMm6A26h4aXXhDJ3q9nfY4qqnX6RMnnWjU8ND/52dRWZ44RBNnCJ2kzUOyYho/+UzPwobTrXoz6ZaW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agevxPei; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agevxPei"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2034666eec.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734008; x=1775338808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTQrZDLe98ibNqI2OkRXEDdqbcbVTpZ2gPOObXRmpoI=;
        b=agevxPeieRNNRoo1hClw0/jlfDBtSVDCPJ5cUWFLDImT3jxtyQwPfTFMJx3EpX771d
         8582dbKhMhKN5PZYgLFYE0Xa/o7MZSi5DTo/G0Xhfqvd7IS1IkG37DLAf5oX5qSUWlBJ
         Trw6oqNk96u6G/k9ByK6mTjkUPhA4h5R5k2ioVLWSOQOO0CvWpw1B/VY/Z7XojrCrbDr
         q8pfFgOS03gHweB7tlf1H3H4davCCYzxY76pwMpizlNC6xQs9sshQT3iUSKT+rJxV4p9
         Lp4ic6kAINY9DQeXKV/QcC4MbzQvcEe5SXooriXyLTb1xLchyPZNxtqh1w6/3rv1J2o9
         Xg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734008; x=1775338808;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTQrZDLe98ibNqI2OkRXEDdqbcbVTpZ2gPOObXRmpoI=;
        b=RaIcIjRai4gATNKgydesXgb3UIAxSJbGqX0fHrhuZItldjjGJKXKfW32eltDt3CF/7
         d4m/BWiNiSu2IDlmnpgKzB928CIdM70Zqf3oME2+vuWad0GMBtHufCk+B2ehe8fiJ09T
         JqGkyihdUZrRBO/WhVXeXKx4XhzxeDQsz77vi7BOyRp1gunndDzsG5nrHWILCdkbW1p5
         tEq3gleEMV5z7l3G5//iDW/k9FdbyYvr6L6wZH444wLsyuk6vhtOPJQGvnouftlxI5JJ
         go7cEgwPyMkFFXFFElPV1USu60SQSbjJ2vB5Zvc38FauPzwNuQ9IjbUpuYXdr5dLlbIu
         Y8ZQ==
X-Gm-Message-State: AOJu0YxGl3c7wKrGc9/ZGkEgVUo2xOT6SjaFVfLCsjpk9qxQXPLoZ2Q0
	PP59Wx6Vf6izYclGwyxFZfyxXI93Up5DOXfxHjeKRnO8MKet2BMhX4zcgNZKlQ==
X-Gm-Gg: ATEYQzxiO1Sob1u1KwDA5XQ/RjiPK3JBp+G9KLWrfni4Ip37s0bbuxeDPBIncXT2A0w
	KN6Up8TVZRrbd0L1sJn8mj62u9Qe9OYo7pg4UfvLDp/r5HFWes/cmlnePbogCgRf8FqS0brdpdG
	jHmvWU0fusbxNyqgcXqnXPsCJzX5t44wSkD87E392dl7Qehg/aB/JxhORgdnP89+fKJVgHkOR6N
	2IfMswBUgPCqoheOgzfgiTf1MX29U4lgoZnbc6VV3yumZsizvBpq6/VpgYgiQnhTrsi8AM6U3Sp
	+1b9Rzdn1dm8ONWnRzRi2drldtvhgbBQsNN8Nqadiino/TEOWKpundR6dgRnGL2TnOa0PBBcegR
	+ompkkWB9gpMGYhUrsxZAGUQp2s8lm2aQ5exWXFPbu8FYLfOXEhXvavh2PoxTypCr/Xfu9Y59fn
	vLRd9IVm4pkI1elvFuGYEZ0WoyV1Ch
X-Received: by 2002:a05:693c:2c8d:b0:2be:b20a:9b69 with SMTP id 5a478bee46e88-2c17723bdb8mr4946226eec.12.1774734007841;
        Sat, 28 Mar 2026 14:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm3103893eec.8.2026.03.28.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:40:07 -0700 (PDT)
Message-Id: <f3bb69dbfc628d88075ee9a5a9b549e73cb487fe.1774734004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
References: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
From: "Dhruv Arora via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 21:40:03 +0000
Subject: [PATCH 1/2] userdiff: adding typescript pattern
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
Cc: Dhruv Arora <a_dhruv@outlook.com>,
    Dhruv Arora <a_dhruv@outlook.com>

From: Dhruv Arora <a_dhruv@outlook.com>

Add builtin userdiff pattern for TypeScript files.
Recognizes function declarations, class definitions,
arrow functions, and method definitions.

Handles common modifiers like export, async, static, etc..

Signed-off-by: Dhruv Arora <a_dhruv@outlook.com>
---
 userdiff.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..086e3fa002 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -337,6 +337,19 @@ PATTERNS("ruby",
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
+PATTERNS("typescript",
+	/* Starting with optional whitespace */
+	"^[ \t]*"
+	/* Followed by an optional export and/or async keyword */
+	"((export[ \t]+)?(async[ \t]+)?"
+	/* Followed by either a function or class declaration */
+	"((function|class)[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[^{]*)"
+	/* or */
+	"|"
+	/* a variable declaration with const, let, or var */
+	"([ \t]*(const|let|var)[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[ \t]*=))",
+	/* -- */
+	"[a-zA-Z_][a-zA-Z0-9_]*"),
 PATTERNS("rust",
 	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules!)[< \t]+[^;]*)$",
 	 /* -- */
-- 
gitgitgadget

