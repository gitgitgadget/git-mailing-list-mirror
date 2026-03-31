Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254163C2E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956324; cv=none; b=b4Nr/rlp9ngWQrbGSANiZ3VUe6vIekC984dv/9iAlYGa6gmNNhXhuWZMz+EsLP/64w+uH9TmPLeviEBk5E3mhq5tNC9zqQhSn2bS+ToC4UMv0tNRsEOM8ld6v3tscFNFr/WGhryEUQSbbvYxO8jdPUqNWcw06gk6yuoLszQ5B2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956324; c=relaxed/simple;
	bh=CPhkvmuJc6n0E8BZbL/Yff+LDPqLbCkL20V5g2NKhv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z66qtXrUY/vd9tByVc8ONvDU5YAEe9zapEn6Kwko5XiWjlKD++xRVIbjO/UZfABU3ItG4dXlPzaZ9SLllmS0V6CB8/zfK5A4NCl5JCEBvy3EAeEe0jABFr4w4wYg6A8IbnGho+XUHrsmBUjsRaEwki0yrq7dwGJ2DFGCGMD761o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b05+/D4t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b05+/D4t"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso36888075ad.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774956322; x=1775561122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyntLLKE/eoHReZEL0wPzPEYZTVvBROGjxSxiwipfyQ=;
        b=b05+/D4tfoTF05ppJB0ZRYVdBlsnqvr4Nz/vzF77ELWZqW9q6IS92k4waqtINdl2mM
         MSl3LwnbRm0lZdoQeynpSILCQKHkvdS7qp/w1l4I26UAOG3OsHl25FwvxRFd973PeLZ+
         14a651mYVZrTn17k3+1QgfCqlmOin92x9egjD0tlRKg2yN4F07E/EpLoZ/bBOMYh9A4e
         v2FihrPVRTWnJgID1WvjLDlx8IdroexUQO48CXYUjwggPEOIpbXFeZQUUme7bIPkP/Jz
         XKSyLI2QqPkQabQGo8m3jMWdpyfippHKXAF9A+cNt73yz9ad5OLQmAYNje2U+eiMhHzW
         4t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774956322; x=1775561122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyntLLKE/eoHReZEL0wPzPEYZTVvBROGjxSxiwipfyQ=;
        b=VD1iv1XVM4heycXcocae+dNuBmZRlR29cIJUTCQXRGY0YjXUDshRUH/OivEo+q99NW
         4H49flBFIOYMdMkDXnHyRUqPGIxX9qQFv/6a8ky91AGAWGqHdAByaXeDqApGJpTDH1Dt
         dfNqn0p6jGqJHmMbOp1pFdzjBSt+xeNrd/t2vox68pyzfb28THVRNaqp84ghDAe7TJ0r
         7MkEavhDmuT27ifQE8PzpFjOKULojNJtv/FcjxtcU0hrQhhZPiUQhTslYdmNyJVmeSMN
         L/Jbu24sFFlWknqXDISoHUJPBVvurAEf/RpfEh4yTzSn31xepauokYnaMateaViYSdDj
         I0wQ==
X-Gm-Message-State: AOJu0YwUKI6cdHMvp67tePWHoybRVtDPpFPS5rCccYQt37JQb9jrXR/h
	PHKystKHQW2h/Ljrak6vinarVx8edggEg653q00qpmAWNXglHyz03amLiAWJHKhD
X-Gm-Gg: ATEYQzz9kG9YLK9sRvU/tctF3Gi/bIdrMyTsPKVl9NDUrUqbqOz2xyO+wmv913Yf9HZ
	EFc9yUWLQQL+XyuFQibWE9cuYIl8LNu71yBihbDflAkYFrSDAkM0uiV4cl5iIIU3JlyXabNrziL
	hiGOFpUdLTqtg4mvMCe959oiFJdigSv8UDG5tFEEWmXGF2+xXBIhoOde4/s/KKrZeNt2/LkoIJK
	2KQcdfLqvOrHgmEnd9RArWe4fc8FrPvy7e3tivH8SvTGEu4EdUjW3cxltLCV4/l6BhR01Ye4M/8
	sXlUVIXSuCLYzdAB3kHVORabfAqGhSwHK0jncqCgWkS7J/pJbo8wEMLG4MyybSeJ5vEb2NuYP9/
	VyW5SWVpgLjHGY/uy5RipQTziQ4haGQDHVjCyRaqM+VcVlSeHsZ1oHdlYaEAmTGTLICxX4Iq7vC
	KJnevV4YKFRLSVtVFuonHfJyO0rpuIxNCi/y9yYz/+yRjf3zKg9zeucod5dUlbbv4NvYgrZ0UKc
	4236cG7oQ==
X-Received: by 2002:a17:902:ef0c:b0:2b0:b557:6fe5 with SMTP id d9443c01a7336-2b25efaca1emr30007175ad.30.1774956322198;
        Tue, 31 Mar 2026 04:25:22 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264224esm112055975ad.15.2026.03.31.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 04:25:21 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] backfill: auto-detect sparse-checkout from config
Date: Tue, 31 Mar 2026 20:25:16 +0900
Message-ID: <20260331112516.772635-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git backfill currently initializes the `sparse` field in
backfill_context to 0. This causes the command to always perform a
full backfill by default, even when the repository has sparse-checkout
enabled in its configuration (core.sparseCheckout).

Because 'sparse' is explicitly set to 0 at initialization, any later
logic intended to auto-detect the setting from the repository
configuration becomes dead code, as it only triggers if the value
is negative (sentinel).

Change the initial value of .sparse to -1. This allows the command
to correctly fallback to the repository's sparse-checkout settings
when the '--sparse' or '--no-sparse' options are not provided on the
command line.

Add a test case in t5620-backfill.sh to verify that 'git backfill'
automatically respects the sparse-checkout configuration without
explicit flags.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 builtin/backfill.c  |  2 +-
 t/t5620-backfill.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 4b2db94173..0f31844ce7 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -124,7 +124,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.repo = repo,
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
-		.sparse = 0,
+		.sparse = -1,
 		.show_progress = -1,
 	};
 	struct option options[] = {
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 91b5115732..a1a8d736db 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -149,6 +149,21 @@ test_expect_success 'backfill --sparse' '
 	test_line_count = 0 missing
 '
 
+test_expect_success 'backfill auto-detects sparse-checkout from config' '
+	git clone --sparse --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-auto-sparse &&
+
+	git -C backfill-auto-sparse rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 44 missing &&
+
+	GIT_TRACE2_EVENT="$(pwd)/auto-sparse-trace" git \
+		-C backfill-auto-sparse backfill &&
+
+	test_trace2_data promisor fetch_count 4 <auto-sparse-trace &&
+	test_trace2_data path-walk paths 5 <auto-sparse-trace
+'
+
 test_expect_success 'backfill --sparse without cone mode (positive)' '
 	git clone --no-checkout --filter=blob:none		\
 		--single-branch --branch=main 		\
-- 
2.43.0

