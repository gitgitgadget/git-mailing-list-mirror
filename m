Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D61F12ED
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039296; cv=none; b=FUS3IaHqZ0QVrGF3L54Yyv5YH3y3nNRNNhoVtQd0D6+9ASMYNRLuACkNI4DhQNWb/higbyDrNgnZ57WuFNV4d1KtLwyBK8SXJHD3itiYuxVsFjAgOEN2snbrwBTrhVdeAs5YNm18GnZwKLvE5FSMtSXrNxkuvXFVzVdsjLtA7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039296; c=relaxed/simple;
	bh=3OuNyHlHS+SjqagRiasCsdQU0OHABHHQkoZ/O6M435M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfIoZzA8VlkkuGMAVBEvYwyxe7mJNE9InWK6Ry6OlaEtSwrxolg5qS/ulloxFN3XPIKgf7X+MNPP2XjrpXWo+zMA4G66BS/dldgDg24q1+tawIXnRIxQQC3Dlx+n7bBk1wBH/Q1XcCnN/9GZkrh0EvR0UsZArwsXim/BbuYoxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjd+oucV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjd+oucV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22328dca22fso74667355ad.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039292; x=1741644092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTOzC8cVilP2FYG9KevtmZiYJ2WwzCJovXWF1R6yTt0=;
        b=Jjd+oucVovK+pe0sX7w+TXS9ogZxsshC+OjO8TZsCHzsRaQRmB+spW8zbR3rFRrH3f
         M/rg0Zy/zNehM+MdilJOJSiTo81SFrCDeAA8Be2RRw4j7bGT9pgfyoT2f83aor8Uaky3
         QOdBh5qh8mwEZftlQtE+vXcOQUbUIXV/IDvfAgJeXzlPEn87YPbP2oyX4L3X+lUuLKxE
         f6tZfRJCttQW98rgKchuRqqFg1eXqHKYMCi1fWrkOi9Ka5/ox5AtJaI3y0i+qMqmyd2D
         srOkQKMpMy3G97jAmQ2WVeryzzXZdkMy5ZdNbmnV0LRTU5HwZ5dU92FI/hTH5WIvQi6s
         SpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039292; x=1741644092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTOzC8cVilP2FYG9KevtmZiYJ2WwzCJovXWF1R6yTt0=;
        b=RGsVYQ6iuNMMIYb+CVH8z90452uRS+/FEtstRec6mm169Q8STPW+NlDSbH1Y0COVBA
         rhs8Ar+KzQ3V5W2nrF9i+fZudIIYrQoF+31BlfA0LkRb+PZnmLMpq7N0qOiEOOeE8Rnj
         WNgsQ+a/xR2TLPLsSf+V1s0y0MA5cNU8QxTQK3vvYVFUpkMeiEq4P5Qxk7BUfyEG52aI
         jx77jP2lysGym4q9UbfyTN1XbBKne74gp3lVMGNSjEYBomOXna1pA3/3ioRxKzPAeNhe
         u3tuz4hkLsS+iOiHg39RxGEj9fmOD2VdFek2G9wfIIU0j37dRiG3HnRHlvhGj1zGFF8o
         5Utw==
X-Gm-Message-State: AOJu0YwMNY5Z037vsX44b90MFfodn7GnNpareaP3wRALs2/YoW+hbTT1
	//ouHpPqSnWnzyzI27E34rbrI47NbFPl/64x8s6KYxLsdMiJMp7+XbfDeg==
X-Gm-Gg: ASbGncupPLagndBXkXGwu6QWd9BQGS3biFndk8jtMdvcGmighvAIkB8MrY3JWx3DZLG
	CBPSW7uTuSdFmt07GAxFExIqofuM4boRSlNFSWr3z8sbGk48x60udSJeHLiwcVzkgYAx2rdN9NC
	5nJuINyywImR9q8LOychSiTX+CT3urHsDCg1dVJzD0+0OKWi2cuuhkL82lyVIHaOWuBlnYKhmXz
	JxjzU+CZzBGeS9ySagLaiyqGkSkZ75BVCipd6F8JENOtRTK2A9xsZY16xbNnQXJmA9NHzpitLi3
	CnRiOxFbai29Xl5qUlDnYmefTWUxUHLPxs8DtSRxT1qV2oXsdB5+aXNES/wJDOT8XVQipCd2/we
	cYDR/RbYb7A==
X-Google-Smtp-Source: AGHT+IF5deq61YZf+afExzNMqfV9C1XzGdiB/im0McbRFeX6q3SIqM+5tDl3GjIPjvTXBVOo3XmpSQ==
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr242848975ad.35.1741039292382;
        Mon, 03 Mar 2025 14:01:32 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:01:31 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 2/6] builtin/log: die if -k and --suject-extra-prefix are used together
Date: Mon,  3 Mar 2025 19:00:25 -0300
Message-Id: <20250303220029.10716-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling format-patch, -k keeps the commit title as the patch subject
and can't be used with other options that depend on the existence of a
prefix. This way, -k shouldn't also be used with --subject-extra-prefix,
as it introduces an extra prefix.

If -k and --subject-extra-prefix are used together, die.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 95667c93ca..52dc0301cf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2256,6 +2256,8 @@ int cmd_format_patch(int argc,
 		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
 	if (cfg.keep_subject && cfg.subject_prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc", "-k");
+	if (cfg.keep_subject && extra_prefix)
+		die(_("options '%s' and '%s' cannot be used together"), "--subject-extra-prefix", "-k");
 	rev.preserve_subject = cfg.keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
-- 
2.39.5 (Apple Git-154)

