Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77835966
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820930; cv=none; b=a3Tp0iMAxF7ZAmeuRsOc6hvmligYUT/chVYAlw8l8Nvo7WIB9vtJDXw+dyy825oKL1xYt3TclONaG956jS6zqhBUyr3ERu084+z0BwYSBI8TpL78jtoIwoR0SHfJsJ3Io6QPni7fBWiQJ1NbEqQZIVM+tcl1wBzzK5jgLlTNt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820930; c=relaxed/simple;
	bh=vexqpV1O36b32132VNXXq4Btme9tIKTgwV8rFnr3hE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWFPdLF9Hs3cc05mQGWw9Q+jm3W+yTIzESD8up4nsekaJqFZzGwbh4t9kAfKC1ifM0DtQMnOSaFEozjlnhkd+4oJBKhyx+xvVC2J0Ns2QlVJg+8ysiBOSMGJjhhAejHz2W8cbzRanhae4VIdUHEseusgeqIW/wKyh4fFSpT/K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxZMKsDR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxZMKsDR"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46792996074so51637771cf.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820927; x=1737425727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9/aqIKfmSkyzqieNEKLl1J4fF5JOznvTgU531dvcs4=;
        b=KxZMKsDRv13s+OunrWlncWFjUEfUsUHnATzcgrAErhqZujHI4Kb8mL6W0NK+3gdAtM
         g+pbyXhgczuArBJEo/VotTVcscrBDvdtWMqZXXo9irZRrGLpzDXEOMFS4f8HrfxsuGgK
         eZou51v2G4IwLjijPGsGSKCcl7Ar3oohhIdQ3kR3CQRbUNdMwewcWqkdAVTgc2Q+obra
         nhjO6L+ZBa0e18XbB/mqFWy7jXx31U81d9dVs4wpAqdwm8phEOhVDDhN31NFm1RRXtRh
         oLIQUto7L7g8TZi2tO9oavy4CGgF98GVGdKPgZ9sm3cT4WN7zA6XO+9b3ch5zP7suwmx
         TwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820927; x=1737425727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9/aqIKfmSkyzqieNEKLl1J4fF5JOznvTgU531dvcs4=;
        b=wqnHw3x/sSTurAVmFr1LaMEb9WIR6csYSWfL3X9iIjfgoeGfgqxpxm1xfbwC0ujL9c
         1or8LgOx0dEnZbWcT0l3lPfzEhzDsa1q+QfyD4Xa8i3COkE+gnKlVAZpXJRYk0Pqn1zG
         9FII7pB8tbanHJvVEaMXoW8QA6IzXG9/yyO7tHh+TQDCzVEDKjl+hx5NcUBYA68k0NRF
         wi4d17GECX9qimJFoMw5NOjMnarE8SW05XCEprZXSUR2d7V8jaAcMkoUV0NE/QBfxTlJ
         749l8TQq+mAjYLVRb5CKZQfSozKfpONExOO3Ai03yyl+C+jv1nBg7co/swCCjfkZJbFV
         8SRw==
X-Gm-Message-State: AOJu0Yx56wXHpIPhOgL1auYTUG6HtiRlTd1xDF5w0WzPgAapHDkmyHk6
	/D5UIUOLS7fFqHiTFa52oIG+OOE1gFrV6H4UWjkxukPwp766lwO+somwjancvY0=
X-Gm-Gg: ASbGnct7PHZgPeiAq6h8tA/m1mO2JYL6dxPu2Wfgp4dPgY4AsM2NCSyDlVeMbKvPB8T
	rl+5BYEWqKA01PTCyoO0w2T8LQrDCeXlm9CIWNlYBx4N24SVMqWpQ7xO+cjvV2H3TGgrR4puIBT
	uOD0qQWu+OK708/dd6CXnX9F7k1uA4w/NErXoeF24uF+ixs+Gwux8tPpuNs24JiVL+OEvvxVNN+
	hqeEg+/rEVKkzN75hvepxiFX2x3cbjTgmlojCWlzpJV0Ke/8sHxAQnGoViWZrS8dPtXj/wgWM4W
	LPK+Icw=
X-Google-Smtp-Source: AGHT+IHMa7LI4WGSLGkvv9C41mraaGs2HEssH3thQcPu9mBPeu8zZOetjC39qLEiF1U3WgfAIKAHHQ==
X-Received: by 2002:a05:622a:99a:b0:46c:a0dc:efb1 with SMTP id d75a77b69052e-46ca0dceff0mr162749481cf.34.1736820926837;
        Mon, 13 Jan 2025 18:15:26 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:26 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 1/8] git-compat-util: add strtoul_ul() with error handling
Date: Mon, 13 Jan 2025 21:14:53 -0500
Message-ID: <20250114021502.41499-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.
This commit introduces strtoul_ul() to address this gap, enabling the
return of an unsigned long with proper error handling.
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..f2935750bf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1351,6 +1351,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+/*
+ * Convert a string to an unsigned long using the standard library's strtoul,
+ * with additional error handling to ensure robustness.
+ */
+static inline int strtoul_ul(char const *s, int base, unsigned long *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s )
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;
-- 
2.47.1

