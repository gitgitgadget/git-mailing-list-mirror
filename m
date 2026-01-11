Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686F2147E6
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768162928; cv=none; b=k8Xwq3oBROhflkL0Zq+nly/2QzruhUIcBP4+XZABlr7mCrwMZMWUjdslMhe5x1MXBiRAIDH7P6Ekzxo6n9OinK2k2RaahU8u4IuCu/CKK/HOPGWw1a3DP61DgKLiCB1oFvw5bnP41iCaJy5sErgeN75ukQo/Q/F8s31XJ5RiHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768162928; c=relaxed/simple;
	bh=2PMNZVDH9/9SWGFbGhErb2dXcfms4nlSL8vIU0M+Hng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBmFeKP4tLHEZ7BeZaXJ9A4d2qk8CxCGm1LmKWn32mO33FoDchLmYgTHBLs4RyAhOCHUsl9mqqIVeQO7vNAOAH2UPyPX1PvsKdbYHCZWS/yPQrNVZDBqcvn875eQJKeTRRqzbGcUCbpTC26X2pqFi9TZpeV936zZWcd0Lm9aIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1Jvjkev; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Jvjkev"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0c20ee83dso52470805ad.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768162926; x=1768767726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zLc+3p3EEvCqIiKAyz5RphRu6zcZu1Cmud85dKshuk=;
        b=P1JvjkevGLeLHdqz0Ou2Mvt2K709WejTFtJ2r4wfRMVfBdWC1/oRSIhbV6ryfmoyBS
         qwpviKxn7ZkSBeK+OqxF5gEnbKpX5CLZkWSWXy0805v71DJSGxiH/gVbpjQORzb08KzU
         1qsG7G+0GC1i8dIVhbuxThDX/PBEza9rmsCfoRoB5wcUTtAMRwAAvog09OtbfxG8FJtE
         rIrpnHqClz833W3hONggnLK0sfcfCoftUIKqtP5EGerIe9UrHI3jBmNCGOFlSkSE25xh
         DWsjoJYGpvV9pWkDkJo6sUCk0UVZ9/uy6n+LOPzDYVtiU7edHiZQPaJDO5lgPJtcEL1s
         +L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768162926; x=1768767726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zLc+3p3EEvCqIiKAyz5RphRu6zcZu1Cmud85dKshuk=;
        b=MeNPn54BlGWtzQI9Shs6h1jmFQVl/r0BQIzNm8pd7Snp/8rmNoc/q/V8r/p6E4ykqk
         FeebGabowP31BKX+ZvhY9geud3hXL07OqpHPbJdFN85QwhKDCli8I7iUqr4zMcgS3hqa
         9Ptp0VWgREnaxOZcF0shyHGsaCpWPliSohjKCwl08l5qGEca80JzOyJxA6/nX9NuFkKF
         Akia0y3TqcwuYXEUJp0rxpNF/3SHHY3CFjBYxCWeOMmt9cR3c17CzAw/FG2eJgjzEtME
         oA++gJ413f2cA2mLs2Ijb4/7TM6mdudrxyI8PC17bYhfYFO8Iw8KbH13WF0/WcxWn5LH
         Otug==
X-Gm-Message-State: AOJu0Yz6jAOccX8/R/cWSkpmsNzQZdoNy8ss/+TdMTgADqgxf5fohldp
	9Qy8HOUgRFNeKCY4aTIVyTstpw5xVZ/5vO4qORdZgcd4cmK13rv73/344FyRWQ==
X-Gm-Gg: AY/fxX407wZmbF8abXQyesmjHXwNZqJAidt6nTSrO+k33pBDe8QPvUNtud6X92goxwq
	ovY1fHRf0Df/TZ1Ce9KUsRS4hdHY2PBdjCOfgv7mcwBIqwNOiOvAOdopDsGaQhgm0m8gerv0J1Y
	zrCmjhLFMpksZOLkVKP8HtIzH0s1WoCXNCxQZhLxvdcbiyb/BFGivf6CrCGEWlu7TkvvEReZTsn
	w0W4bcBII+svHt/vbpogzc2H1xU5Z6T0RTl5iORjqGzXqWTn2jPXidwmV+FjgKJzIFJsN6Le3IH
	wFTIgDtnmV4pa3Z/Okj/568Pfa4JqGhiaEEloR3QTt8+W13G1EVadWLu7kUMYC+FU1lAXBhlxcY
	uznFZ+zFk7IFBxH7A5h0bqxs7brkoVFvt38mHAQWIbe+F7oQTCg/+8b86zU3kPuDTUNtC9cQEzC
	3Fvj4vEgL4i/GYjlf5I4fgfUihGrXuPDABcWZ/iNRUeNuq
X-Google-Smtp-Source: AGHT+IGO7ApWLiQyvqvgHLDehI3VpOSIu+WCX3iWNVh86lQg4AJsYrcIUfObSzEpD1tnIu+UoyjHPw==
X-Received: by 2002:a17:902:f546:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2a3ee42a386mr142158725ad.14.1768162925953;
        Sun, 11 Jan 2026 12:22:05 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:1e97:3d8:1b07:e7b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm15449980a12.2.2026.01.11.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:22:05 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit code in tests
Date: Mon, 12 Jan 2026 01:30:35 +0530
Message-ID: <20260111202137.257405-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While implementing the Avoid suppressing Git exit code in test scripts microproject for GSoC,
I tried to modify this test to remove this suppression. However, after making the changes
I ran the make test command to check, and the test #365 in which I made changes is failing.

Could someone please explain why this test might be failing after such a change,
is it something I am missing or is there something that makes this test not amendable directly?

P.S. Kindly ignore the commit message or format, this is only meant to discuss the failing test
before the actual commit.

Best,
Shreyansh

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 t/t5500-fetch-pack.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..1ae2d41c47 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -892,13 +892,16 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	test_commit other &&
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
+	test_oid algo >oid_algo &&
+	git rev-parse other >oid_other &&
+	git rev-parse main >oid_main &&
 
 	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
 	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
+	$(echo "object-format=$(<oid_algo)" | packetize)
 	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	$(echo "want $(<oid_other)" | packetize)
+	$(echo "have $(<oid_main)" | packetize)
 	0000
 	EOF
 	)
-- 
2.43.0

