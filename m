Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD375223302
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055944; cv=none; b=Esbcakm04JHBHkfWqTHsGM3Uq8IiWcApc5VrNuHRUxjD3MVYn2r0uUQJ4ppWy/ynEHnUGMqM7ZmPjuW/lwpuR4d/XHTAZLV/xNF7Hu9UC7k36BcGVBffxoXrbCGj7VIOXO/qKxe0+5BYwZlB84ruOZXu15lTR0ybaU770f8tS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055944; c=relaxed/simple;
	bh=zBZCaKkWZd/NPjnuKnmRgFUvkEN+6JVHO9mqFuPHhfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAk4dqbrdlwk/oMNI+Xa/qJAXBIIjE0FU438p4l2Ans6j59FbsNvBiUlXocoR+kBvgHWi+UdRUvaaoDCACPOgYQw0p/Zs5cOjyNjR7ztL9pQUYSIMvY+yNwjwsZGMvW+j3KHU38IV+Mna3L20URe2h8pkWAmZZzlt9X3n3d6LyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fADgzT/B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fADgzT/B"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so6549663b3a.2
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744055942; x=1744660742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxFLTtP4Lx59zm2e/s5BLeECN05DESGpML6hd4P673o=;
        b=fADgzT/B3+lzzJ+IYdmaHg0ja6dnlHWz6/6U4LABw4+ylNGb3zJLRmYpuXUXtVkn3p
         hSXxiDOC6vyk1xFetzBVWRSZEdSxENy/L0LFNXTclctypkZVWDm+hzpuqtsNO2GFqBk6
         48Q58YQk2ZkqqMaL7Y26ihgkEE34NFt48omxj2hHKSCAUu576Fm20VhH+ULcH82tPSRw
         ukqnIgz+Nq+i64rRH10r6Ym6bC81rzWX9krbt65TTK9BHGiNEbnjCnfDXz2tIIR89fLG
         6smx9Dmx63DKoVrCqpJJc1++TjCsGA46/Z5lgiR1/9/0lnmJon51X30M+O8lq5Xx+/vd
         rJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055942; x=1744660742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxFLTtP4Lx59zm2e/s5BLeECN05DESGpML6hd4P673o=;
        b=YkUO2yaRLtnDQCRR6QtofrzwI/5A/KCEUDhoNJ6WpRAfb1Uv67KM2C1e6oiDMP1BlX
         lCwynl9y6FsmnP5mmOJnQ/Mz8iK3dmfWkX2rbywx9BGwNgo/Vnup6q0tn+bJkzAr/m05
         sePuuXnBdJ69ysZHLb95DW3rn+RSh5b5m/w4YZ7B6r71xI30FT0v+faO2Hq5TaIdH+WL
         xQqY6E3f59xNKEKohmWjNwA6QLHn1xvWMkjmpSPpjZtKf8RyPY5efqp0QIUF4BQtjhT3
         RCiWtlXnsOT8WjA7KIWAKne1dLH7MnmCWAU7pSt7uYsWBWIgjBCMgJvwdepJ9/qQsYeF
         3Fmw==
X-Gm-Message-State: AOJu0YwULw097ZfjJRLUzF8UFhYgIvTOkdhdLID4qopoaA6iTl+H3OKD
	4o7nWyrmNleTXlFWed5C+ElIkhCV5aHQbnAlTIiLPGeu2YwbREhy453tl2/wiEg=
X-Gm-Gg: ASbGncsxmbpwlkt+ZopYWJEkFGpcLvs/R+ubRGn7AQ4S75Ycgg0lmfYpQI2Tjl1RT58
	o65zv7Y5dT9EZ/xTNACbb4zP3Gl6JEZX+2m5XfL9+WIcK3oWERYm/2fjsaC20500jS4Cy7xcGEi
	USu/m+suHGLTDY9F0o2y6sFhZ7kzx9xcrg8QSy7cZfL+Cx1eFbJAf3Pj5+IVJZIJpTUOQSmCp3I
	nvUsFhra2Td4+nlYWFcxKeO+LlEOTiC1ausZkR3OR1ObcOfrEXvy1/brGZyzboEPfulXB+MwU7z
	AY+d4bJe7Rs8PWZW/y8lLxL8TPZGzjmDxLbqh7Fu1EVhqalTe3Yuh3y0eULYZLzJPnemmw==
X-Google-Smtp-Source: AGHT+IFBtFL2Qp0vXwGw8AfO8xF+uYyeZQcfqr4km2q4LUUy+0KkVaseoqVKgf4/nTGiO4fu+5g2Fw==
X-Received: by 2002:a05:6a20:c6ca:b0:1f5:64fd:68ea with SMTP id adf61e73a8af0-20107ea675emr18974618637.4.1744055941732;
        Mon, 07 Apr 2025 12:59:01 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc3fd411sm7644032a12.52.2025.04.07.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:59:01 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/1] builtin/update-server-info: remove unnecessary if statement
Date: Tue,  8 Apr 2025 01:28:41 +0530
Message-ID: <20250407195850.299348-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407195850.299348-1-usmanakinyemi202@gmail.com>
References: <20250406121513.154084-1-usmanakinyemi202@gmail.com>
 <20250407195850.299348-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` in "f29f1990b5
(config: teach repo_config to allow `repo` to be NULL, 2025-03-08)"
to allow `repo` to be NULL, no need to check if `repo` is NULL
before calling `repo_config()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index d7467290a8..ba702d30ef 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -20,8 +20,8 @@ int cmd_update_server_info(int argc,
 		OPT_END()
 	};
 
-	if (repo)
-		repo_config(repo, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index dbd8cd6906..6824581317 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,4 +107,11 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage &&
+	test_expect_code 129 nongit git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
-- 
2.49.0

