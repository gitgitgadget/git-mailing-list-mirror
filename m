Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A962701D1
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063012; cv=none; b=qPaHQwkOmD8Qu0H3wLXfUpFr7neQ+Osb3ju1rCk3Fc1ylWu22WSjXqki8E5Y5VE+dtavfrQYmaLXcF7jsSYOy7UrVCaY0MZ73fAjaJzFsGvbGxfRrXqpfCovjlHUB1yixsiNRauIszdZWWZ930G9mv2X+lQOip2TmA9B/kRZADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063012; c=relaxed/simple;
	bh=HF7feQB/joHzFWjKE4ZLnjK3SrWNKpw/JepkkiUmsNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8FC+takbmWzL/p3mNQ5tgJ3dmZMyxYqCdO2idQdTpeXA3aocy36EhEg5XuZnv9bkj75QyV9cN4SmzUQo4pv+lCswmmLAkqiPZ7x8VJnh/hZ3cCYsxQnlJ4dKgcdO/U87GeMneHLtTuTXYD0aEByJtrLhYt4yYd4AEcKNv72ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSAzee3E; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSAzee3E"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c20f1e890so700329b3a.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774063010; x=1774667810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFHN+V77hf9MR6uIaVsWX754DBg0VU8XCDSEPn6b+d8=;
        b=VSAzee3E2qIDmm8KDp8zwZu5AgslGONMLZnct4J6VuKICw6RctKBw3i0gd/cOkA1vE
         5+xuoLjRUuuH+MT8rQtEEHs6ilaAqpy18N5P98khGVLfg6liW0YptsUMaRRybSfpGev7
         euPMFUzOn0rfAHUN30l75bbGE5eSyTYobsLoA74t2pAxOlJuTnMkhpz+cldos+669fXb
         MbEFlvcauEdKH5+xckdj9obCKP63Ha+IztK3Zg4xFh4mm5f8b75v1Xvfd9dh+RzlBV4m
         e/QAE3Bbcd2CrvLYxw+l+XM4vlb7Q0D8IaSPe5/T/YlDhjT1XE9ErcrWttnU30Ml0WtD
         S6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063010; x=1774667810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFHN+V77hf9MR6uIaVsWX754DBg0VU8XCDSEPn6b+d8=;
        b=sij+vpgoS/i/JhJVSTJPRonlh11BQ3rQxrBH3IS1Oyzot3f03kVgkNKEhgWTg7S/Hy
         g1O8xEFfvo9NXYL/oHjo79fJNORpIYfEu4QEC30LWzZZh4okkop5Cg0e+qw65a8TSuDv
         zHHZZBgtBKqh/70Q5yAPCQrfQfRI+Thk3gBfqlRWGCJdVTAnadk3DGO7fbKsE60U/Ffm
         2SIjTLC84s03P1BsNNg6Z8A46F5FKMZ/QHqKpo0YSH5nk+wd7qZCyUpKgt22DpVqE4f/
         LpzJIg4GDvk/SSNH4JPqMV2XltT+JZ7ltV+I1Io8XKhpe/uGtwOJAPqkGAofIlQLt5jw
         HjTg==
X-Gm-Message-State: AOJu0YzxUNmmq760rDDSq9ymud44HtQqH1PEcPJe3A7vsOTxOHadN+48
	9ylVSV2Uv1nW4y6GCTWGpwLD0xlEs8gIeWntvBCN1gw3vSoUr6cAke5XyqhF0PSiN70=
X-Gm-Gg: ATEYQzwPN66a/MmPmFtdATiZ8IYUVtTxNy1CcUfLGM7Ko96UsF7vhvoMZSwznTQwijB
	HGaQ1YFL4jx5ZyGiv8FZDj1O1DlsPBqiIqbg12nhFrErF8A8ucTWbeDzkXi4p5rVpX/j7JDlu72
	X+IxdoVIJF+aDOA/sDepKthx+pef+7BqCfAIajdyh9t5HC5lawD1Dp0Gz4YjQp7rfm5Iw5sNfBK
	J0oubHn6y86wnO/558KFuE24MXkAEYt5SmhK6o79BM+z6nq4VTwzzRtBClCDVORkFWxdSqjhh37
	vrzI4HVF+rMmc1ilH8XU3oo6+PMHgPc77FYgiB0KazEPJ13+metTfPxHk5P2SYEO/zgqNysrrCR
	ijpkLrJni/sHcqDlKfvowXFB1TFFVCxitg9zNMSqQvP2s1+oaZogXVWLdg3Ut+rd2XZgrSQpCLp
	mm2UGNVsTHgtjfXlAY6tb3zins4jUXUqM04U0Z4J+/rRscdCyAELKHHrDt66ObEfGVv702Pgeny
	YnsUPARlqpu9oyLAEeG+wX8ISkCpz2zBLrveObfWUfGhAaEEBksODt3rEpQ
X-Received: by 2002:a05:6a00:1789:b0:82a:720a:4cde with SMTP id d2e1a72fcca58-82a8c23855bmr4293699b3a.2.1774063010382;
        Fri, 20 Mar 2026 20:16:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:aa1e:d5f2:b805:6b52:50d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b041059a5sm4068743b3a.53.2026.03.20.20.16.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 20:16:50 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] backfill: handle unexpected arguments
Date: Sat, 21 Mar 2026 08:46:43 +0530
Message-ID: <20260321031643.5185-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git backfill takes no non-option arguments. However, if extra
arguments are passed with git backfill, parse_options() leaves
them in argc and the command currently ignores them silently,
giving the user no indication that something is wrong.

Add a check after parse_options() to call usage_with_options()
if any unexpected arguments remain. This prints the correct usage
and exits with an error, consistent with how other Git commands
such as git-gc and git-repack handle this situation.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/backfill.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e9a33e81be..0eb171478a 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -135,6 +135,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
 			     0);
+	
+	if (argc)
+		usage_with_options(builtin_backfill_usage, options);
 
 	repo_config(repo, git_default_config, NULL);
 
-- 
2.51.2

