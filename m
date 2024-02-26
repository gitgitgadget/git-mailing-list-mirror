Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9B131E31
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985155; cv=none; b=g1X/FEjn5lRomeXu0SwKAYpUBlEdNpXudRIKQySfricvjj0aptLiqUsDb+g6cQTf7OkzWddpRPCnLoMpg+BiY2mcE1cETCNKEyEYJyLmjsW9lFZRp1DF9cnTgslebkG9ITMFncMo9lUCO8vqbxKS+OJ9/s4batVTNJNNbTrBais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985155; c=relaxed/simple;
	bh=z20G1D/ingtEHs8n4ErdU8YD7D1M1aoKrhlupSXwVSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKVtriUIlO6jk4RzJL6S2XYIItfYtpxHj1HYbtFj67kbi5oyPtHLa9C+tMvr8uThGfoKf2N9CGNFqTJHN0hoz6tv6WIV+gS5hBzYQYVvah1F7hq3V07P3jNR9k1FPq+9fuI5ZQtv+salwI3YjjVJelCb89tlekcycVV8+C24ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4T45uzx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4T45uzx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e432514155so1786369a34.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985153; x=1709589953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3565OIASkrgH1GqfUgs+5HfDtKha1mUbalh4b8nEKKo=;
        b=Y4T45uzxPYTWtgDu2cqzM7KKKmKQVvJvh0owB8KjJvJMGiTQ/qW6KfxK5kLbhmrWQO
         jVpLudA/DByqxT269jCo9BYbf4qTz5LaQ7yEKaYj4fSl/F/K4pinI0+q8L1tpJCw7bE5
         yO3FB1T+U5ENtW9sKGU4s0xbL/V+M2zMyVnl5ua7GguMgdAUsEqefN0iqZ9pkbXtzMr/
         D6vZScex38OkeLrF2nkM5Vn0pTC+CWuaeuIiYCGmc9DAkDV52Rxw4EgUW3Ywb3/6EZyj
         CY6NPNu2tPfTrCche5Xzk6bpSVcvig9qs6Ngy4wjKhDU2lB1F1hhqJbqUPq1QTyuNfDe
         KSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985153; x=1709589953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3565OIASkrgH1GqfUgs+5HfDtKha1mUbalh4b8nEKKo=;
        b=w65frnPRXnAxPDadB19HeaymetGAQq7RQtLBrlv6ZUo453Vc6FRafz2RBORNSOLSpN
         za3br/gNkpQDTr431zQzWB++z7VKTUIw702lrGafxw3iJWBzNUxC166bSCMvmc0qzZpg
         BmcojZKCc9ylQUCC0cjkMmWL7aHXWWFcnruY9lMPVp5nuJedXetoZTsth62nGztYxSTk
         1Br2tdL2CnsfhiR5O4jG2/CD3Y9WZW0BOuatmc64zEts5AL2JT4VeQrIgMvZuYh9ZxEU
         Wn7up7HBIPxvgnqevyN34GGyCydkYjHaHzWO29rnLGT0O8Pfccr5wuw/YPVikOJg3NKm
         AKEA==
X-Gm-Message-State: AOJu0YzZtsHnR+AMLFNf7vuNWCILPQciEtwnjc00aEVC5xXFpTlsa6xg
	5t9pO8NQMMqsx9aHaqiI5oGNzI6oeUIyUKUwT/2DXyW2KLQ882Pscj1y7jne
X-Google-Smtp-Source: AGHT+IHqY7x5rMjf0FEyvi07LBf/hJj+ETe/j9DVFa3+vuSXIqsAz+lpa8GtJpzw7bocnYFAq9cJmg==
X-Received: by 2002:a9d:7acb:0:b0:6e4:512e:e0ab with SMTP id m11-20020a9d7acb000000b006e4512ee0abmr9402912otn.6.1708985153117;
        Mon, 26 Feb 2024 14:05:53 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm2911696qtr.3.2024.02.26.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:52 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 2/4] builtin/receive-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 17:05:36 -0500
Message-ID: <20240226220539.3494-3-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240226220539.3494-1-randall.becker@nexbridge.ca>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of
arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/receive-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index db65607485..5064f3d300 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -455,8 +455,9 @@ static void report_message(const char *prefix, const char *err, va_list params)
 
 	if (use_sideband)
 		send_sideband(1, 2, msg, sz, use_sideband);
-	else
-		xwrite(2, msg, sz);
+	else {
+		write_in_full(2, msg, sz);
+	}
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
2.42.1

