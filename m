Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB66233150
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859070; cv=none; b=GYfK0LZwtjf1Mi4OC0veHg6nA9uIcUqPwpVYC/i27wAKOhgtXZHweRX/mIDeE9p+/hGd6Ge1YvLhctuX9COgzO0Y/iQSdPqF2AHGb7JMonoSLsMtAqMc4WRQ4sTLKaFakUGdKo/Bx78eCvua3b4MiGW/flJHbThDNSWU9AV5cEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859070; c=relaxed/simple;
	bh=2DRP7Ckhyt6wzMKwlioGtEb1/3F/1v5JJLzgVLWaCzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgkDp0g6PnW4/FFL6UDz26PL0O1H+MmTvEz9po7VlElRzQJOYt407Hhd0cz5IaXgpE2LeO0Q5rlbcmqAvwtyF+eV2GJmfy7uHJOqvHyxcKpXNb3s+8oXhQa80Fe/6xMY7L34an4m1/KyMExJQXA7yp+WzuErov/rU/XhTFLPGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7080dd5fe92so58703827b3.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 13:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859068; x=1748463868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcJA9pi6KqOY7oNI8XU2XKlR5dOiIVAgp+oBFLkUIow=;
        b=sJo7dT8tKAN5VPDYpXSZBlMQmAh5AxzLKeCn8SaEn/299yXGibqEtfXid07xFU0+nv
         /kYiuF4cAk4455ir3+xc84epMT68KQFjZR1nLh1k8oI9M2psVoqUGVa1ib9n8HeCDXXC
         qMJSSGcQ/CsV6YgTSo9JiUR/1dI63wFDLYS/SPSyRRVOUnKIslpeKAnxQ+Nnw1CfQ8zX
         HdCjo+sThwiRScjNpS11ECNPYsZk+71O7cUoByTDTvkJ/oXKSrxveAAWyD8F+rqh97QX
         dkGd/Syh0p8MXDd9MynbVWaXM/lVQH8xQpk7FRioHtu9d0zLWUx0S+3PZgBRg8oOi8zM
         5LXw==
X-Gm-Message-State: AOJu0YwcNRYNE7jd1/Wf0tXh2Mbe7m6yp/bY8uUQtPQ/zo1q/E71Gk0P
	004osYVQkMyZvoLgvpq2n2nvz/algoO7oSzcyOQHso9TkJuQmASkBBnBQWze/xIfQwQ=
X-Gm-Gg: ASbGncsRyxV2w1yBilHNJZcrd2a5R17r+nl/vOSwtrJaQFhIt8svb76WOyXCqUku/2d
	jg3AvbLts4WX2L4AvnNjjUDTpNc5xwKE5G1EU9S7HqVSJUg1VGsnstEaoPKp5IdAto0wGx4NvrH
	yx0gbM371LwzPiAhpcD8roN3Z8EmlDuUHCOORgVSDGpD09dgnUVHwP6uGrzkr/jo3QpRQM/oVNw
	oZY6iTeN+PGdkJDn/hXQbi/nR/qGF1fQ4KFW7DuyZ8qC2RH5sF8sQuCenU51SN+GuEBWziq1npv
	LosT4YZVZ5sagUa4aEEQBM4wO2nTK7N+vP8N49FrL2kMXUHLGquK033K7RKpFA==
X-Google-Smtp-Source: AGHT+IHlKtb3Poo7d0eOdZQK5HVcnkDle9xQUtg6q/x4Nfo3ahEtde4E8Sw2v/5xJkCDBf2gzjyflw==
X-Received: by 2002:a05:690c:3389:b0:708:3a47:3d2c with SMTP id 00721157ae682-70ca79cb5e9mr334653097b3.13.1747859067655;
        Wed, 21 May 2025 13:24:27 -0700 (PDT)
Received: from ferr-Latitude-3490.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70df5e02688sm3445237b3.16.2025.05.21.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:24:27 -0700 (PDT)
From: Fernando Gouveia Lima fernandolimabusiness@gmail.com
To: git@vger.kernel.org
Cc: fernandolimabusiness@gmail.com,
	gitster@pobox.com,
	adlternative@gmail.com,
	avarab@gmail.com,
	stolee@gmail.com,
	peff@peff.net
Subject: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
Date: Wed, 21 May 2025 17:24:09 -0300
Message-Id: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>

Two comparisions between int and size_t, and int and unsigned long int
cause warning sign compare to fire.

Avoid this by changing the type of variable "i" in add_ref_decoration() to unsigned long int and
casting the variable "filename->len" to int in fmt_output_subject().

Signed-off-by: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>
---
This is my first contribution and i got this idea on the Microproject
page. I hope this is the first of many contributions to the git
community :).

 log-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1d05dc1c70..e0848fcccc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -151,7 +151,7 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 			      int flags UNUSED,
 			      void *cb_data)
 {
-	int i;
+	long unsigned int i;
 	struct object *obj;
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
@@ -458,7 +458,7 @@ void fmt_output_subject(struct strbuf *filename,
 	}
 	strbuf_addf(filename, "%04d-%s", nr, subject);
 
-	if (max_len < filename->len)
+	if (max_len < (int) filename->len)
 		strbuf_setlen(filename, max_len);
 	strbuf_addstr(filename, suffix);
 }
-- 
2.34.1

