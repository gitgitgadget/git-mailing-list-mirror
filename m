Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049802080E3
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299190; cv=none; b=CcTvpeA1eM0qB9VioIVvq6OKtqE7zCgKpsIUXYbClOEJfEdOP1/mYiY5dxDDUR+//Ybh5TNDw8blkmOohV5+wYrh2FHllwknq0xNZ+R5zh2XgLQ7ev+yJcN6ffA1FbmsoVAAylAKaj2UkZsL7CX+gnv++R06USOOLHPdv5X83j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299190; c=relaxed/simple;
	bh=U+XFGoQzxyyJRtz9agM0lv6W5cbWm2Ge0pYfYimKgpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh4Ic8cF/NBUViWYxrHUsIDyviRCetpDWbz+b2Mm691pZicNDZdFaD+DwEKj29j2qTmpQQ4UwDe6DLaYWIBNyXx0VoSapdptNhOLIUOWN2Fa8BC6S/jlUBLGp/ebm3Xi0/eC/XPapnryLk96g3BWWbv7Zw8l+0hoIo5NXL7+OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X29j5B/o; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X29j5B/o"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so7189330a91.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299188; x=1742903988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDzis9TYFoOOo6McnWKBY+0CzD+vDHSYmKTRS74auv4=;
        b=X29j5B/odJKH1C8LzC0hb1AvNd4wdUIA9jtpqm0rsb4oDIjjiUW57IwyY1RSaukgH4
         t0tMsvDakCSMCGsBMsiwp1Kcs2q6zm9iDjS5CfDdMR/3lA10kmS8vhzbRHOdbSutsOnV
         2OdVnC1ieZCW+FmswJBm26/+QZ8rDBMrZu+V6NM5UWcvTlI10bGB6HZeL1SdSUC+fbXB
         802FjqvPfPBNqxDZLDfnavgKoXt6C0I5VPs2qsbl7RXUjuVw/v6pRs38vLgMTC1PZ2Es
         yzFenQiGtPahwJFQKmFDfFMo1OnCRYz5uyOkEdD8lttJja/YUCHt93uZNOlUdMdtXk47
         o0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299188; x=1742903988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDzis9TYFoOOo6McnWKBY+0CzD+vDHSYmKTRS74auv4=;
        b=mYk3aSyYgpNh1wviIjBvBLMM5NkqbNaA2+RUmS1YGEFtoEyhhzThWiRWjQZmxXF1sA
         Ly+HPPUGy/jecPT/nYzKpa8hAI2M+3sK9N6V+gyy4odM+8LcgMhXYtYMknJ+PHi94kmD
         yxE8HmGjvPHjHMbT7WoIqgCo/qYx6n3PCWhv69sPJYloH6s2n3swfXKLC4LXLI5zJ+28
         OvywojTcI8Rq4qf6UKKZvntZYRcEphAUk6euD4wrLLnKLhPkr0ALWDuOkA3Cm5XfDhdC
         titSMjI2DcW/ePuegi14oh13DIkfyUbVblKoyNeNWhWGngopo3vTWULvB9Y4UnjBVxrr
         d7mg==
X-Gm-Message-State: AOJu0YypRHiouXgX4Ge6dE8WI4muLvfRDtcHf0UnIIXdPzUh5LoUaF1R
	rEMTJUVMSCodMQ8GtIRddpKXxbtQM7jPN9ImHUGJeex3PEvqYw6pyeqV9eW4
X-Gm-Gg: ASbGncuKzlfJOazhLt4waQv0e2oUSBzPTwODHDuA/+oa0WUG6MgRuwMKoep8YVOREAF
	OGq76yBZCbSJ01xWzleNIrVEOQcBG8PnvYQzqSPVq8NLQaoOH7nD+FyH/EQK4pmlzjZWSohP5Gc
	H55IOQKgQfUnIvAEwmKw6dR8mH6TSdVk55OcTE4q0mc2b33zyr1ATYIa57UbVsOcycakxz2LWBF
	KPMoEx+g34utg+g02lOIpQ3Pc9hNGd1JiHjftIOUOpAEICUXjig2NomoEWGnRj+fm/vWL+cloEz
	OEpgQF/GisnSwxmj3jIWU+zN91Xnb7yCJDpjJZniwqwVU64y1Lgzy1GN8cgiVJ/mKuc0JebyUof
	2+Izp
X-Google-Smtp-Source: AGHT+IEkKIO2yPpGA3WCSq33S91wQ5FrknyL7NyhYDY07X1IpOVB5UO+PHNT+QuXRtbA7CKQDwfWeA==
X-Received: by 2002:a17:90b:4fd1:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-301a5b02044mr2999742a91.2.1742299188072;
        Tue, 18 Mar 2025 04:59:48 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:47 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9] builtin/update-server-info: remove unnecessary if statement
Date: Tue, 18 Mar 2025 17:29:01 +0530
Message-ID: <20250318115912.2978992-10-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` to allow `repo`
to be NULL, no need to check if `repo` is NULL before calling
`repo_config()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/update-server-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.48.1

